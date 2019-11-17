# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'
RSpec.feature "タスク管理機能", type: :feature do
  background do
    page.driver.browser.authorize('admin','password')
    FactoryBot.create(:first__user)
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    visit tasks_path
    fill_in 'Email' , with: 'spectestuser02@gmail.com'
    fill_in 'Password' , with: 'password'
    click_on 'Log in'
  end

  scenario "タスク一覧のテスト" do
  visit tasks_path
  expect(page).to have_content 'test01_content'
  expect(page).to have_content 'test02_content'
  end

  scenario "タスク作成のテスト" do
     visit  new_task_path
      fill_in 'Name' , with: 'cording'
      fill_in 'Content' , with: 'プログラムを作成するため'
      fill_in 'Expiration_date' , with: '2019/9/30'
      select "未着手", from: "task_state"
      click_on '登録する'
      expect(page).to have_content 'cording'
      expect(page).to have_content  'プログラムを作成するため'
  end

  scenario "タスク詳細のテスト" do
      visit task_path(7)
      expect(page).to have_content 'test02_content'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    click_on '作成日時順にする'
    tds = page.all('td')
    expect(tds[2]).to have_content 'test02_content'
    expect(tds[12]).to have_content 'test01_content'
  end

    scenario "タスクが終了日時の降順に並んでいるかのテスト" do
      visit tasks_path
      click_on '終了期限でソートする'
      tds = page.all('td')
      expect(tds[2]).to have_content 'test02_content'
      expect(tds[12]).to have_content 'test01_content'
    end

  scenario "タスクのタイトル検索ができているかテスト" do
    visit tasks_path
    fill_in 'Title' , with: 'test01'
    click_on '検索する'
    tds = page.all('td')
    expect(tds[2]).to have_content 'test01_content'
  end

  scenario "タスクのステータス検索ができているかテスト" do
    visit tasks_path
    select "未着手", from: "task_state"
    click_on '検索する'
    tds = page.all('td')
    expect(tds[5]).to have_content '未着手'
  end

  scenario "タスクのステータス検索,タイトル検索が両方できているかテスト" do
    visit tasks_path
    fill_in 'Title' , with: 'test01'
    select "未着手", from: "task_state"
    click_on '検索する'
    tds = page.all('td')
    expect(tds[2]).to have_content 'test01_content'
    expect(tds[5]).to have_content '未着手'
  end

  scenario "タスクに優先度を設定し、降順に表示できているかテスト" do
    visit tasks_path
    click_on '優先度でソートする'
    tds = page.all('td')
    expect(tds[6]).to have_content '高'
  end
end
