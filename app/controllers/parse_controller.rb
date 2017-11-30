class ParseController < ApplicationController
  def parse
    nm = Natto::MeCab.new
    res = nm.parse(text)
    render json: {result: res}
  end

  def find
    res = PalindromeCandidate.new(text: text).result
    render json: res
  end

  private

  def text
    params[:text]
  end
end
