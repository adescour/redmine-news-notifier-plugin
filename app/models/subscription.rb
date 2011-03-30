class Subscription < ActiveRecord::Base
  has_one :subscriptions_list
  belongs_to :user
end
