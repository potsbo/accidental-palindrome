class PalindromeCandidate
  def initialize(param)
    param ||= {}
    @text = param[:text]
  end

  def longest_palindrome
    @text
  end

  def words
    natto.parse(@text).split("\n")
  end

  private

  def natto
    @natto ||= Natto::MeCab.new
  end
end