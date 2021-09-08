require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Angela', email: 'angela@pachis.com', password: 'admin123') }
  describe 'Validations' do
    it { should validate_presence_of(:name) }

  end
end
