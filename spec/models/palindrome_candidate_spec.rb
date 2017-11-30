require 'rails_helper'

describe PalindromeCandidate do

  let(:text) { 'なんか文章' }
  let(:cand) { PalindromeCandidate.new(text: text) }

  describe '#longest_palindrome' do
    it 'should return a String' do
      expect(res).to be_a String
    end

    cases = [
      { input: '竹やぶ焼けた', output: '竹やぶ焼けた' },
      { input: 'どうやら、竹やぶ焼けた', output: '竹やぶ焼けた' },
      { input: 'どうやら、竹やぶ焼けたようだ', output: '竹やぶ焼けた' },
      { input: '竹やぶ、焼けた', output: '竹やぶ、焼けた' },
    ]

    cases.each_with_index do |c,i|
      input  = c[:input]
      output = c[:output]
      let(:res) { cand.longest_palindrome }
      let(:text) { input }
      it "#{i+1}: should return '#{output}' for '#{input}'" do
        expect(res).to eq output
      end
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