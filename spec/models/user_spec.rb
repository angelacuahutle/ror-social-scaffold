require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'Angela', email: 'angela@pachis.com', password: 'admin123') }

end