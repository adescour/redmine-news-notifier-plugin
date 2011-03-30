class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :subscriptions_lists, :through => :subscriptions
end
