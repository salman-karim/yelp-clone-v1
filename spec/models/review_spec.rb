require 'rails_helper'

RSpec.describe Review, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }
end
