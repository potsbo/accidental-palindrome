require 'rails_helper'

describe PalindromeCandidate do

  let(:text) { 'なんか文章' }
  let(:cand) { PalindromeCandidate.new(text: text) }

  describe '#longest_palindrome' do
    let(:res) { cand.longest_palindrome }
    it 'should return a String' do
      expect(res).to be_a String
    end

    let(:text) { '竹やぶ焼けた' }
    it 'should return 竹やぶ焼けた' do
      expect(res).to eq '竹やぶ焼けた'
    end

    let(:text) { 'どうやら竹やぶ焼けたようだ' }
    it 'should return 竹やぶ焼けた' do
      expect(res).to eq '竹やぶ焼けた'
    end
  end

  describe '#words' do
    let(:res) { cand.words }
    it 'should return an Array' do
      expect(res).to be_an Array
    end

    it 'should not contain EOS' do
      expect(res).not_to include 'EOS'
    end
  end
end