module ApplicationHelper
  # these methods are only available to the views
  # custom helper definition
  # setting "options" configuration argument's size attribute with a default value
  def gravatar_for(user, options: { size: 80, class_string: '' })
    # https://en.gravatar.com/site/implement/images/ruby/
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    class_string = options[:class_string]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    # return an image tag using the built in image_tag helper
    image_tag(gravatar_url, alt: "#{user.username}'s profile image", class: class_string)
  end
end
