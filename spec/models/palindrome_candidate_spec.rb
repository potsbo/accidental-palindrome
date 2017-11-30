require 'rails_helper'

describe PalindromeCandidate do

  let(:text) { 'なんか文章' }

  describe '#longest_palindrome' do
    let(:res) { PalindromeCandidate }
    it 'should return a String' do
      expect(res).to be_a String
    end
  end
end