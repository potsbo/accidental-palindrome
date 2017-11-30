class PalindromeCandidate < ApplicationRecord
  def initialize(param)
    param ||= {}
    @text = param[:text]
  end

  def longest_palindrome
    @text
  end
end