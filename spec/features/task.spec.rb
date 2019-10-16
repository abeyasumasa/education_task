require 'rails_helper'
RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task, content: 'testtesttest' ,created_at: Time.current + 1.days ,expiration_date:Time.now ,state: '未着手')
    FactoryBot.create(:second_task, content: 'samplesample', created_at: Time.current + 2.days ,expiration_date:Time.now + 1.day ,state: ' 着手中')
    page.driver.browser.authorize('admin','password')
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
      fill_in 'Expiration_date' , with: '2019/9/30'
      click_on '登録する'
      expect(page).to have_content 'cording'
      expect(page).to have_content  'プログラムを作成するため'
  end

  scenario "タスク詳細のテスト" do
      visit task_path(7)
      expect(page).to have_content 'samplesample'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    visit tasks_path
    click_on '作成日時順にする'
    tds = page.all('td')
    expect(tds[1]).to have_content 'samplesample'
    expect(tds[9]).to have_content 'testtesttest'
  end

    scenario "タスクが終了日時の降順に並んでいるかのテスト" do
      visit tasks_path
      click_on '終了期限でソートする'
      tds = page.all('td')
      expect(tds[1]).to have_content 'samplesample'
      expect(tds[9]).to have_content 'testtesttest'
    end

  scenario "タスクのタイトル検索ができているかテスト" do
    visit tasks_path
    fill_in 'Title' , with: 'Factoryで作ったデフォルトのタイトル１'
    click_on '登録する'
    tds = page.all('td')
    expect(tds[0]).to have_content 'Factoryで作ったデフォルトのタイトル１'
  end

  scenario "タスクのステータス検索ができているかテスト" do
    visit tasks_path
    select "未着手", from: "task_state"
    click_on '登録する'
    tds = page.all('td')
    expect(tds[4]).to have_content '未着手'
  end

  scenario "タスクのステータス検索,タイトル検索が両方できているかテスト" do
    visit tasks_path
    fill_in 'Title' , with: 'Factoryで作ったデフォルトのタイトル１'
    select "未着手", from: "task_state"
    click_on '登録する'
    tds = page.all('td')
    expect(tds[0]).to have_content 'Factoryで作ったデフォルトのタイトル１'
    expect(tds[4]).to have_content '未着手'
    save_and_open_page
  end

end
