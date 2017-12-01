class Palindrome < ApplicationRecord
  def self.from_result(param)
    summary = param[:longest_palindrome]
    return if summary[:size].zero? rescue nil

    pal = self.find_or_initialize_by(text: param[:text])
    unless pal.persisted?
      pal.update(size: summary[:size], body: summary[:surface])
    end
  end
end
