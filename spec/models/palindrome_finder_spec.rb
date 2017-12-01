require 'rails_helper'

describe PalindromeFinder do

  let(:text) { '竹やぶ焼けた' }
  let(:cand) { PalindromeFinder.new(text: text) }

  cases = [
    { input: '竹やぶ焼けた', output: '竹やぶ焼けた' },
    { input: 'どうやら、竹やぶ焼けた', output: '竹やぶ焼けた' },
    { input: '竹やぶ、焼けた', output: '竹やぶ、焼けた' },
    { input: 'どうやら、竹やぶ焼けたようだ', output: '竹やぶ焼けた' },
    { input: 'あたりが焦げ臭い。どうやら、竹やぶ焼けたようだ。', output: '竹やぶ焼けた' },
    # { input: '酢豚作りモリモリ食ったブス', output: '酢豚作りモリモリ食ったブス' }, # スブタ"ヅ"クリ になってしまって難しい
    # { input: '肉の多い大乃国' }, # ダイノクニ
    { input: 'まさか、逆さま' },
    { input: 'どうしてもうまくいかない。まさか、逆さまなのか？いやそんなことはないと思うのだが、一応試してみよう', output: 'まさか、逆さま' },
    { input: '今朝美味しいおでんで美味しいお酒' },
    { input: '今朝美味しいおでんで美味しいお酒を飲んだので一日中が気分が良かった。毎日やりたいと思うところだがそれは色々と問題がありそうだ', output: '今朝美味しいおでんで美味しいお酒' },
    { input: '力士会館前回貸切' },
    { input: 'イタリアで暮らし楽でありたい' },
    { input: '死にたくなるよと夜泣くタニシ' },
    { input: '世界を崩したいなら泣いた雫を活かせ' },
    { input: "あなたに似たなあ" },
    { input: ")あなたに似たなあ", output: 'あなたに似たなあ' },
    { input: "世の中ね、顔かお金かなのよ" },
    { input: "もう十年以上も前のことになると思うが、昔母が「世の中ね、顔かお金かなのよ」と言ってのが非常に鮮明に記憶に残っている。", output: "世の中ね、顔かお金かなのよ" },
    { input: "菓子与え肥えたアシカ" },
    { input: "Was it a cat I saw" },
    { input: "Madam, Im Adam" },
    # { input: "Madam, I'm Adam" }, # TODO: a bit difficult
    { input: "No lemon, no melon" },
  ]

  describe '#longest_palindrome' do
    let(:res) { cand.longest_palindrome }
    it 'should return a String' do
      expect(res).to be_a PalindromeCandidate
    end

    context 'when no palindrome found' do
      let(:text) {''}
      it 'should not return nil' do
        expect(res).to be_a PalindromeCandidate
      end
    end

    cases.each_with_index do |c,i|
      input  = c[:input]
      output = c[:output] || c[:input]
      describe "#{i+1} case" do
        let(:text) { input }
        it "should return '#{output}' for '#{input}'" do
          expect(res.surface).to eq output
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

  describe '#highlighted' do
    let(:res) { cand.highlighted }
    cases.each_with_index do |c,i|
      input  = c[:input]
      output = c[:output] || c[:input]
      describe "#{i+1} case" do
        let(:text) { input }
        it "should return '#{output}' for '#{input}'" do
          expect(res).to include "<strong>#{output}</strong>"
        end
      end
    end

    context 'when no palindrome found' do
      let(:text) { '回文じゃない' }
      it 'should not raise anything' do
        expect{ res }.not_to raise_error
      end
    end
  end

  describe '#result' do
    let(:res) { cand.result }
    context 'when no palindrome found' do
      let(:text) { '回文じゃない' }
      it 'should not raise anything' do
        expect{ res }.not_to raise_error
      end
    end
  end
end