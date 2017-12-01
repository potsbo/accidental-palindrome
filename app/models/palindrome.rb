class Palindrome < ApplicationRecord
  def self.from_result(param)
    summary = param[:summary]
    return if summary[:size].zero?

    pal = self.find_or_initialize_by(text: param[:text])
    unless pal.persisted?
      pal.update(size: summary[:size], body: summary[:surface])
    end
  end
end
