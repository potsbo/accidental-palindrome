require 'rails_helper'

describe PalindromeCandidate do

  let(:text) { '竹やぶ焼けた' }
  let(:cand) { PalindromeCandidate.new(text: text) }

  describe '#longest_palindrome' do
    let(:res) { cand.longest_palindrome }
    it 'should return a String' do
      expect(res).to be_a String
    end

    context 'when no palindrome found' do
      let(:text) {''}
      it 'should return nil' do
        expect(res).to be_nil
      end
    end

    cases = [
      { input: '竹やぶ焼けた', output: '竹やぶ焼けた' },
      { input: 'どうやら、竹やぶ焼けた', output: '竹やぶ焼けた' },
      { input: 'どうやら、竹やぶ焼けたようだ', output: '竹やぶ焼けた' },
      { input: '竹やぶ、焼けた', output: '竹やぶ、焼けた' },
      # { input: '酢豚作りモリモリ食ったブス', output: '酢豚作りモリモリ食ったブス' }, # スブタ"ヅ"クリ になってしまって難しい
      # { input: '肉の多い大乃国' }, # ダイノクニ
      { input: 'まさか、逆さま？' },
      { input: '今朝美味しいおでんで美味しいお酒' },
      { input: '力士会館前回貸切' },
      { input: 'イタリアで暮らし楽でありたい' },
      { input: '死にたくなるよと夜泣くタニシ' },
      { input: '世界を崩したいなら泣いた雫を活かせ' },
      { input: "あなたに似たなあ" },
      { input: ")あなたに似たなあ", output: 'あなたに似たなあ' },
    ]

    cases.each_with_index do |c,i|
      input  = c[:input]
      output = c[:output] || c[:input]
      describe "#{i+1} case" do
        let(:text) { input }
        it "should return '#{output}' for '#{input}'" do
          expect(res).to eq output
        end
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