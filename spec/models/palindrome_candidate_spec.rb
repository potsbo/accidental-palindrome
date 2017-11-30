require 'rails_helper'

describe PalindromeCandidate do

  let(:text) { 'なんか文章' }
  let(:cand) { PalindromeCandidate.new(text: text) }

  describe '#longest_palindrome' do
    let(:res) { cand.longest_palindrome }
    it 'should return a String' do
      expect(res).to be_a String
    end
  end

  describe '#words' do
    let(:res) { cand.words }
    it 'should return an Array' do
      expect(res).to be_an Array
    end
  end
end