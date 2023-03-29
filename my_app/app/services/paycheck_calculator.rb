class PaycheckCalculator
  def self.calculate(user_id:, date:)
    filtered_transactions = transactions_in_range(user_id: user_id, date: date)

    profits = filtered_transactions['income'].sum(&:amount) - filtered_transactions['expenses'].sum(&:amount)

    if profits > 0
      ordered_rules = rules(user_id: user_id)
      Paycheck.transaction do
        new_paycheck = create_paycheck(user_id: user_id, date: date)
        remaining = profit

        # To support regenerating, we could destroy existing paycheck items for this pay check here

        for rule in ordered_rules
          break if remaining == 0 # Might be useful to send a message to the user or we could create the paycheck items with amount 0
          
          if rule.percentage > 0
            remaining = create_percentage_paycheck_item_and_return_remaining(
              paycheck_id: new_paycheck.id,
              rule: rule, 
              profit: profit,
              remaining: remaining
            )
          else
            remaining = create_fixed_amount_paycheck_item_and_return_remaining(
              paycheck_id: new_paycheck.id,
              rule: rule,
              remaining: remaining
            )
          end
        end

        # remaining > 0
        # create paycheck item if we've gone through all the rules

      end
    else
      
      # Could be useful to log this/send a message to the user
    end

  end

  private

  def beginning_of_range(date:)
    # For now we'll look at transactions within a month
    date.beginning_of_month
  end

  def end_of_range(date:)
    # For now we'll look at transactions within a month
    date.end_of_month
  end

  def transactions_in_range(user_id:, date:)
    # Could improve this by plucking only amount
    Transaction.where(user_id: user_id, date: dates_in_range(date: beginning_of_range(date)..end_of_range(date))).group_by(&:transaction_type)
  end

  def rules(user_id: user_id)
    Rule.where(user_id: user_id, active: true).order(:priority)
  end

  def create_paycheck(user_id:, date:)
    Paycheck.create!(
      user_id: user_id,
      date: beginning_of_range(date: date)
    )
  end

  def create_percentage_paycheck_item_and_return_remaining(paycheck_id:, rule:, profit:, remaining:)
    entire_amount = BigDecmial(rule.percentage) / 100 * profit
    amount = [entire_amount, remaining].min

    PaycheckItem.create!(
      paycheck_id: paycheck_id,
      amount: amount,
      category: rule.category
    )

    return remaining - amount
  end

  def create_fixed_amount_paycheck_item_and_return_remaining(paycheck_id:, rule:, remaining:)
    amount = [rule.fixed_amount, remaining].min

    PaycheckItem.create!(
      paycheck_id: paycheck_id,
      amount: amount,
      category: rule.category
    )

    return remaining - amount
  end
end