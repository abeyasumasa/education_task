FactoryBot.define do
  factory :user do
    factory :first__user, class: User do
      id { "2" }
      name { "spectestuser02" }
      email { "spectestuser02@gmail.com" }
      password { "password" }
      password_confirmation { "password" }
  end

  factory :second_user, class: User do
    id { "3" }
    name { "spectestuser03" }
    email { "spectestuser03@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    end
  end
end
