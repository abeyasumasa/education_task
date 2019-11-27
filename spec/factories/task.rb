FactoryBot.define do

  factory :task do
    id { "2" }
    name { 'test01' }
    content { 'test01_content' }
    created_at { Time.now }
    expiration_date{ Time.current + 1.days }
    state { '未着手' }
    priority { '高' }
    user_id {'3'}
  end

  factory :second_task, class: Task do
    id { "3" }
    name { 'test02' }
    content { 'test02_content' }
    created_at { Time.now + 1.day }
    expiration_date{ Time.current + 2.days }
    state{ '着手中' }
    priority { '低' }
    user_id {'3'}
  end

end
