class ParseController < ApplicationController
  def find
    res = PalindromeFinder.new(text: text).result
    render json: res
  end

  # for test
  def parse
    nm = Natto::MeCab.new
    res = nm.parse(text)
    render json: {result: res}
  end

  private

  def text
    params[:text]
  end
end
