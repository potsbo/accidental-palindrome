class PalindromeCandidate
  attr_reader :yomis
  INVALID_CHARS = ['(', ')']
  INVALID_PARTS = ['記号']

  def self.no_result
    PalindromeCandidate.new
  end

  def initialize(index: [], yomis: [])
    @start  = index[0]
    @finish = index[1]
    @yomis  = yomis
  end

  # attributes
  def pronounce
    @pronounce ||= @yomis.
      reject{|y| INVALID_PARTS.include? y.part}.
      map{|y| y.pronounce}.join
  end

  def surface
    return @surface if @surface
    joint = @yomis.all?{|y| y.surface.ascii_only? } ? ' ' : nil
    @surface = @yomis.map{|y| y.surface}.join(joint)
    Yomi::BLACK_LIST.each do |char|
      @surface.gsub!(" #{char}", char)
    end
    @surface
  end

  def is_palindrome?
    return @is_palindrome unless @is_palindrome.nil?
    return @is_palindrome = false unless valid?
    for num in 1..pronounce.size/2 do
      return @is_palindrome = false if pronounce[num-1] != pronounce[-num]
    end
    @is_palindrome = true
  end

  def summary
    {
      start: @start,
      finish: @finish,
      size: pronounce.size,
      surface: surface.presence,
      pronounce: pronounce.presence,
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
    return false if first.nil?
    return false if INVALID_PARTS.include? first.part
    return false if INVALID_CHARS.include? first.surface
    return false if pronounce.size <= 1
    true
  end
end
