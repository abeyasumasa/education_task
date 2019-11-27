FactoryBot.define do
  factory :tag do
    factory :first_tag, class: Tag do
    id { "2" }
    title { "testtag02" }
    end

    factory :second_tag, class: Tag do
      id { "3" }
      title { "testtag03" }
    end
  end
end
