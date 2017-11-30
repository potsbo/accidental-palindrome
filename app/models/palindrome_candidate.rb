class Candidate
  attr_reader :yomis
  INVALID_CHARS = ['(', ')']
  def initialize(index:, yomis:)
    @start  = index[0]
    @finish = index[1]
    @yomis  = yomis
  end

  def valid?
    first = @yomis.first
    return false if first[:part] == '記号'
    return false if INVALID_CHARS.include?(first[:surface])
    true
  end

  def pronounce
    @pronounce ||= @yomis.
      reject{|y| y[:part] == '記号'}.
      map{|y| y[:pronounce]}.join
  end

  def surface
    @surface ||= @yomis.map{|y| y[:surface]}.join
  end

  def is_palindrome?
    return @is_palindrome unless @is_palindrome.nil?
    return @is_palindrome = false unless valid?
    str = pronounce
    return @is_palindrome = false if str.size <= 1
    for num in 1..str.size/2 do
      return @is_palindrome = false if str[num-1] != str[str.size-num]
    end
    @is_palindrome = true
  end

  def summary
    {
      start: @start,
      finish: @finish,
      size: pronounce.size,
      surface: surface,
      pronounce: pronounce,
      palindrome: is_palindrome?,
    }
  end

  def <=>(other)
    pronounce.size - other.pronounce.size
    # size_def = pronounce.size - other.pronounce.size
    # return size_def unless size_def.zero?
    # surface.size - other.surface.size
  end
end

class PalindromeCandidate
  MAX_WORDS=20

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
    palindrome = longest_palindrome.surface
    @text.gsub(palindrome, "<strong>#{palindrome}</strong>")
  end

  def longest_palindrome
    @longest_palindrome ||= palindromes.max
  end

  def start_ends
    size = yomis.size
    (0..size).to_a.
      map{|i| (i..(i+MAX_WORDS)).to_a }.
      map{|i| i.map{|j| [i[0], j]}}.
      flatten(1).uniq.
      reject{|i| i[1] >= size }
  end

  def candidates
    @candidates ||= start_ends.
      map{|i| Candidate.new(index: i, yomis: yomis[i[0]..i[1]])}
  end

  def palindromes
    @palindromes ||= candidates.select{|c| c.is_palindrome? }
  end

  def yomis
    @yomis ||= words.
      map{|s| s.split("\t")}.
      map{|a| [a[0], a[1].split(',')[7], a[1].split(',')[0] ] }.
      map{|a| {surface: a[0], pronounce: a[1], part: a[2]}}
  end

  def words
    @words ||= natto.parse(@text).split("\n").reject{|s| s == 'EOS'}
  end

  private

  def natto
    @natto ||= Natto::MeCab.new
  end
end