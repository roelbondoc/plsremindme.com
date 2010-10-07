class Reminder < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :status_id, :allow_nil => true, :allow_blank => true, :scope => :user_id
  validates_uniqueness_of :message_id, :allow_nil => true, :allow_blank => true, :scope => :user_id

  named_scope :not_completed, :conditions => { :complete => false }
  named_scope :completed, :conditions => { :complete => true }
end
