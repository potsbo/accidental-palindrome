class PalindromeCandidate
  attr_reader :yomis
  INVALID_CHARS = ['(', ')']
  INVALID_PARTS = ['記号']

  def initialize(index:, yomis:)
    @start  = index[0]
    @finish = index[1]
    @yomis  = yomis
  end

  # attributes
  def pronounce
    @pronounce ||= @yomis.
      reject{|y| INVALID_PARTS.include? y[:part]}.
      map{|y| y[:pronounce]}.join
  end

  def surface
    @surface ||= @yomis.map{|y| y[:surface]}.join
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

  private

  def valid?
    first = @yomis.first
    return false if INVALID_PARTS.include? first[:part]
    return false if INVALID_CHARS.include?(first[:surface])
    true
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
end
