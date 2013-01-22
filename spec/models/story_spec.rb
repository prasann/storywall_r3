require 'spec_helper'

describe Story do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:status) }
  it { should ensure_inclusion_of(:status).in_array( Story::ALLOWED_STATUS.values ) }
  it { should belong_to(:user) }
end
