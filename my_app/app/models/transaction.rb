class Transaction < ApplicationRecord
  enum :transaction_type, [:income, :expenses]
end