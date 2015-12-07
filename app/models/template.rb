class Template < ActiveRecord::Base
  ACTIVE_FLG = {:ACTIVE => 1, :INACTIVE => 0}
  belongs_to :user

  def set_to_active
    self.active_flg = Template::ACTIVE_FLG[:ACTIVE]
    self.save!
  end

  def self.clear_all_active_flg
    self.update_all(active_flg: Template::ACTIVE_FLG[:INACTIVE])
  end

  def is_active?
    self.active_flg == Template::ACTIVE_FLG[:ACTIVE]
  end
end
