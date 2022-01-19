FactoryBot.define do
  factory :user do
    username {Faker::FunnyName.name}
    email {Faker::Internet.email}
    password {Faker::Cannabis.strain}
 
  factory :funny_user do
	username {'jim carey'}
    # email {'jim@gmail.com'}
    password {'password'}
	end
end
end
