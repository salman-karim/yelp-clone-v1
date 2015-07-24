require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end


describe User, type: :model do
  it { is_expected.to have_many :reviews }
  it { is_expected.to have_many :reviewed_restaurants }
end
