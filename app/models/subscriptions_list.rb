class SubscriptionsList < ActiveRecord::Base
  belongs_to :project
  has_many :subscriptions, :dependent => :delete_all
  has_many :subscribers, :through => :subscriptions, :source => :user, :class_name => "User"


  def <=>(other)
    return self.name <=> other.name
  end

end
