require 'spec_helper'

describe User do

  before { @user = User.new(name: 'Havelock Vetinari', email: 'vetinari@ankh-morpork.gov', username: 'Patrician',
                            password: 'Donotletmedetainyou', password_confirmation: 'Donotletmedetainyou') }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should be_valid }

  describe 'validations' do
    describe 'missing data' do
      [:name, :email, :username].each do |attr|
        context "when #{attr} is missing" do
          before { @user.send("#{attr}=", '') }
          it { should_not be_valid }
        end
      end
    end

    describe 'remember_token' do
      before { @user.save }
      its(:remember_token) { should_not be_blank }
    end

    context 'when username is too long' do
      before { @user.username = 'a' * 16 }
      it { should_not be_valid }
    end

    context 'when username contains invalid characters' do
      %w(*Pat p@t p(a)t p$t p%# ).each do |username|
        before { @user.username = username }
        it { should_not be_valid }
      end
    end

    context 'when username contains only valid characters' do
      %w(Pat Pat_rician p ptr p_A_t_r).each do |username|
        before { @user.username = username }
        it { should be_valid }
      end
    end

    context 'when email format is invalid' do
      %w(vetinari@ankh,gov vetinari_ankh.gov vetinari@ankh @ankh.gov vetinari@ankh+morpork.gov vet@ankh..gov).each do |invalid_email|
        before { @user.email = invalid_email }
        it { should_not be_valid }
      end
    end

    context 'when email format is valid' do
      %w(vetinari@ankh-morpork.gov vetinari@ankh.city.gov the_patrician@ankh.gov h.vetinari@ankh.gov h+v@a-m.gov).each do |valid_email|
        before { @user.email = valid_email }
        it { should be_valid }
      end
    end

    context 'when email address is already taken' do
      before { User.create(name: 'Rincewind', email: @user.email.upcase, username: 'Wizzard',
                           password: 'Whizzard', password_confirmation: 'Whizzard') }
      it { should_not be_valid } # since 'it' (@user) has email that already belongs to another user in the database
    end

    context 'when username is already taken' do
      before { User.create(name: 'Rincewind', email: 'rincewind@unseen.edu', username: @user.username,
                           password: 'Whizzard', password_confirmation: 'Whizzard') }
      it { should_not be_valid }
    end

    context 'wihout a password' do
      before do
        @user.password = ' '
        @user.password_confirmation = ' '
      end
      it { should_not be_valid }
    end

    context 'when password is too short' do
      before { @user.password = @user.password_confirmation = 'a' * 5 }
      it { should_not be_valid }
    end

    context 'when confirmation does not match password' do
      before do
        @user.password = 'Ankh'
        @user.password_confirmation = 'Morpork'
      end
      it { should_not be_valid }
    end
  end

  describe 'methods' do

    describe '.downcase_email' do
      mixed_case_email = 'veTinari@ANKH-Morpork.gOv'
      before do
        @user.email = mixed_case_email
        @user.save
        @user.reload
      end
      its(:email) { should eq mixed_case_email.downcase }
    end

    describe '.authenticate' do
      before { @user.save }
      let(:found_user) { User.find_by(email: @user.email) }

      context 'when password is correct' do
        it { should eq found_user.authenticate(@user.password) }
      end

      context 'when password is incorrect' do
        let(:wrong_password_user) { found_user.authenticate('octarine') }
        it { should_not eq wrong_password_user }
        specify { expect(wrong_password_user).to be_false }
      end
    end
  end
end
