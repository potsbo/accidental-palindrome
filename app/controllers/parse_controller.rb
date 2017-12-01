class ParseController < ApplicationController
  def find
    res = PalindromeFinder.new(text: text).result
    Palindrome.from_result(res)
    render json: res
  end

  def palindromes
    render json: Palindrome.order('size DESC').limit(10).as_json
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
