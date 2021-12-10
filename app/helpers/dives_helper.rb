module DivesHelper

  def render_with_hashtags(body)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/dive/hashtag/#{word.delete("#")}"}.html_safe
  end

end