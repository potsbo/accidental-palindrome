class Yomi
  BLACK_LIST = [',',"'"]
  attr_reader :surface, :pronounce, :part

  def initialize(str)
    @surface, info =  str.split("\t")
    info = info.split(',')
    @pronounce = info[7] || @surface
    @part      = info[0]

    normalize
  end

  private

  def normalize
    @pronounce = nil if BLACK_LIST.include? @pronounce
    @pronounce = @pronounce&.downcase
  end
end
