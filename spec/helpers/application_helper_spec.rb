require 'spec_helper'

describe ApplicationHelper do
  describe 'full_title' do
    it 'should build a full page title' do
      expect(full_title('Ankh-Morpork')).to eq 'quoth. | Ankh-Morpork'
    end

    it 'should not include a bar for pages with no unique title' do
      expect(full_title('')).not_to match(/\|/)
    end
  end
end