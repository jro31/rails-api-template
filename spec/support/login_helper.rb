shared_context 'login' do
  let(:email) { 'user@email.com' }
  let(:password) { 'password' }
  let!(:current_user) { create(:user, email: email, password: password) }
  before { post '/api/v1/sessions', params: { user: { email: email, password: password } } }
end
