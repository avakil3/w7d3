FactoryBot.define do
  factory :user do
    username {Faker::FunnyName.name}
    email {Faker::Internet.email}
    password {Faker::Cannabis.strain}
  end

  factory :funny_user do
	username {'jim carey'}
	end
  
end
