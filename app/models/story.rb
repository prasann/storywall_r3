class Story < ActiveRecord::Base

  ALLOWED_STATUS = {
    :in_analysis => 'In Analysis',
    :ready_for_dev => "Ready for Dev",
    :in_dev =>  "In Dev",
    :dev_done => "Dev Done",
    :in_qa =>  "In QA",
    :qa_signoff => "QA Signoff"
  }
  attr_accessible :description, :status, :title, :allowed_status, :updated_by
  validates :description, :status, :title, :presence => :true
  validates :status , :inclusion => {:in => ALLOWED_STATUS.values }

  belongs_to :user

end
