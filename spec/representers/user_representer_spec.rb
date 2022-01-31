require 'rails_helper'

describe UserRepresenter do
  let(:email) { 'test@email.com' }
  let(:user) { create(:user, email: email) }
  describe 'as_json' do
    subject { UserRepresenter.new(user).as_json }
    it 'returns the correct hash' do
      expect(subject).to eq({
        id: user.id,
        email: email
      })
    end
  end
end
