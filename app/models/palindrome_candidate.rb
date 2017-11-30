class PalindromeCandidate
  def initialize(param)
    param ||= {}
    @text = param[:text]
  end

  def longest_palindrome
    @text
  end

  def yomis
    @yomis ||= words.
      map{|s| s.split("\t")}.
      map{|a| [a[0], a[1].split(',')[8]]}.
      map{|a| {surface: a[0], pronounce: a[1]}}
  end

  def words
    @words ||= natto.parse(@text).split("\n").reject{|s| s == 'EOS'}
  end

  private

  def natto
    @natto ||= Natto::MeCab.new
  end
end