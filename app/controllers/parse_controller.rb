class ParseController < ApplicationController
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
