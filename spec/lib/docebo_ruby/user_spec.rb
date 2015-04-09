require 'spec_helper'

describe DoceboRuby::Resource do
  describe '.check_username' do
    context 'user exists' do
      it 'shows user existence as true' do
        existence = DoceboRuby::User.check_username('jahuang')
        expect(existence).to be_truthy
      end
    end

    context 'user not found' do
      it 'shows user existence as false' do
        existence = DoceboRuby::User.check_username('nouser')
        expect(existence).to be_falsey
      end
    end
  end
end
