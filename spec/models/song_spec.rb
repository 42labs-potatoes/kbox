require 'rails_helper'

RSpec.describe Song, :type => :model do

  it { should belong_to(:playlist) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:playlist_id) }

end