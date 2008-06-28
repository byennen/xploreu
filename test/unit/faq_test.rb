require File.dirname(__FILE__) + '/../test_helper'

class FaqTest < Test::Unit::TestCase
  fixtures :faqs

  def setup
    @valid_faq = faqs(:valid_faq)
  end

  def test_max_lengths
    Faq::QUESTIONS.each do |question|
      assert_length :max, @valid_faq, question, DB_TEXT_MAX_LENGTH
    end
  end
end