module ApplicationHelper
  #the first argument is an array of errors. the second is a block
  #the & turns the block into a Proc, which is a block that can be reused like a variable
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << 'has-error' if errors.any?
  #This content_tag helper method is used to build the HTML & css to display the form element & any associated errors
    content_tag :div, capture(&block), class: css_class
  end

  def avatar_url(user)
     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
   end
   
end
