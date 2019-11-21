FactoryBot.define do
  factory :tagging do
    factory :first_tagging, class: Tagging do
      task_id { 2 }
      tag_id { 2 }
    end

    factory :second_tagging, class: Tagging do
      task_id { 2 }
      tag_id { 3 }
    end

  end

end
