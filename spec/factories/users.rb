require 'random_data'

FactoryGirl.define do
  pw = RandomData.random_sentence
#we declare the name of the factory as :user
  factory :user do
    name RandomData.random_name
#each User that the factory builds will have a unique email address using sequence.
#sequences can generate unique values in a specific format, for example, email addresses. 
    sequence(:email){|n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
    role :member
  end
end
