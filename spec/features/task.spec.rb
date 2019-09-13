require 'rails_helper'
RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task, content: 'testtesttest' ,updated_at: Time.current + 1.days)
    FactoryBot.create(:second_task, content: 'samplesample', updated_at: Time.current + 2.days)
  end
  scenario "タスク一覧のテスト" do
  visit tasks_path
  expect(page).to have_content 'testtesttest'
  expect(page).to have_content 'samplesample'

  end

  scenario "タスク作成のテスト" do
     visit  new_task_path
      fill_in 'Name' , with: 'cording'
      fill_in 'Content' , with: 'プログラムを作成するため'
      click_on 'Create Task'
      expect(page).to have_content 'cording'
      expect(page).to have_content  'プログラムを作成するため'
  end

  scenario "タスク詳細のテスト" do
      visit task_path(7)
      expect(page).to have_content 'testtesttest'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    expect(Task.desc_sort.map(&:id)).to eq [8,7]
    save_and_open_page
  end
end
