class Rule < ApplicationRecord
  validates :priority, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, uniqueness: { scope: :user_id, message: 'User cannot have rules with the same priority' }
  validates :percentage, numericality: { only_integer: true, inclusion: 1..100 }
  validates :only_one_100_percentage_rule, only: [:create, :update]

  private

  def only_one_100_percentage_rule
    if percentage == 100
      has_existing_rule = Rule.where(user_id: user_id, percentage: 100).where.not(id: id).any?
      if has_existing_rule
        errors.add(:base, 'User can only have 1 rule with 100% allocation')
      end
    end
  end
end