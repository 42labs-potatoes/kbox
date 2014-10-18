require 'rails_helper'

RSpec.describe Group, :type => :model do

  it { should have_many(:playlists) }
  it { should have_many(:songs).through(:playlists) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end