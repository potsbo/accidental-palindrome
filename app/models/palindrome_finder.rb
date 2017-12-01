class PalindromeFinder
  MAX_WORDS = 20

  def initialize(param)
    param ||= {}
    @text = param[:text]
  end

  def result
    {
      text: highlighted,
      longest_palindrome: longest_palindrome.summary,
    }
  end

  def highlighted
    palindrome = longest_palindrome&.surface
    str = @text
    str = str.gsub(palindrome, "<strong>#{palindrome}</strong>") if palindrome.present?
    str
  end

  def longest_palindrome
    @longest_palindrome ||= palindromes.max || PalindromeCandidate.no_result
  end

  def indices
    size = yomis.size
    (0..size).to_a.
      map{|i| (i..(i+MAX_WORDS)).to_a }.
      map{|i| i.map{|j| [i[0], j]}}.
      flatten(1).uniq.
      reject{|i| i[1] >= size }
  end

  def candidates
    @candidates ||= indices.
      map{|i| PalindromeCandidate.new(index: i, yomis: yomis[i[0]..i[1]])}
  end

  def palindromes
    @palindromes ||= candidates.select{|c| c.is_palindrome? }
  end

  def yomis
    @yomis ||= words.map{|s| Yomi.new(s) }
  end

  def words
    @words ||= natto.parse(@text).split("\n").reject{|s| s == 'EOS'}
  end

  private

  def natto
    @natto ||= Natto::MeCab.new
  end
end