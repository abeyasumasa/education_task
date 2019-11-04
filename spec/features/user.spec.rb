# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "ユーザー登録機能", type: :feature do
   background do
     FactoryBot.create(:first__user)
     FactoryBot.create(:second_user)
    end

   scenario "ユーザー登録テスト" do
     visit new_user_path
     fill_in 'Name' , with: 'spectestuser01'
     fill_in 'Email' , with: 'spectestuser01@gmail.com'
     fill_in 'Password' , with: 'password'
     fill_in 'Password_confirmation' , with: 'password'
     click_on '作成'
     click_on 'Profile'
     expect(page).to have_content 'spectestuser01'
   end

   scenario "ユーザログインのテスト" do
     visit new_session_path
     fill_in 'Email' , with: 'spectestuser02@gmail.com'
     fill_in 'Password' , with: 'password'
     click_on 'Log in'
     click_on 'Profile'
     expect(page).to have_content 'spectestuser02'
   end

   scenario "ユーザ以外のタスクが表示されていないテスト" do
     FactoryBot.create(:task)
     visit tasks_path
     fill_in 'Email' , with: 'spectestuser02@gmail.com'
     fill_in 'Password' , with: 'password'
     click_on 'Log in'
     expect(page).to have_content 'test01_content'
     click_on 'Logout'
     fill_in 'Email' , with: 'spectestuser03@gmail.com'
     fill_in 'Password' , with: 'password'
     click_on 'Log in'
     expect(page).to_not have_content 'test01_content'
   end

   scenario "他人のマイページを表示しないテスト" do
     visit tasks_path
     fill_in 'Email' , with: 'spectestuser02@gmail.com'
     fill_in 'Password' , with: 'password'
     click_on 'Log in'
     visit user_path(4)
     expect(page).to_not have_content 'spectestuser02@gmail.com'
   end

   scenario "管理画面でユーザー一覧を表示" do
    visit tasks_path
    fill_in 'Email' , with: 'spectestuser02@gmail.com'
    fill_in 'Password' , with: 'password'
    click_on 'Log in'
    click_link '管理画面を表示'
    expect(page).to have_content 'spectestuser02'
    expect(page).to have_content 'spectestuser03'
  end

   scenario "管理画面がユーザーを作成できることの確認" do
    visit tasks_path
    fill_in 'Email' , with: 'spectestuser02@gmail.com'
    fill_in 'Password' , with: 'password'
    click_on 'Log in'
    click_link '管理画面を表示'
    click_link 'ユーザーを作成'
    fill_in 'Name' , with: 'spectestuser04'
    fill_in 'Email' , with: 'spectestuser04@gmail.com'
    fill_in 'Password' , with: 'password'
    fill_in 'Password_confirmation' , with: 'password'
    click_on '作成'
    expect(page).to have_content 'spectestuser04'
  end

  scenario "管理画面でユーザーのタスクが確認できることのテスト" do
    visit tasks_path
    fill_in 'Email' , with: 'spectestuser02@gmail.com'
    fill_in 'Password' , with: 'password'
    click_on 'Log in'
    click_link '管理画面を表示'
    click_on 'タスクの詳細',match: :first
    expect(page).to have_content 'タスク一覧　ユーザ:spectestuser03'
  end

  scenario "管理画面でユーザー情報の更新できるかテスト" do
    visit tasks_path
    fill_in 'Email' , with: 'spectestuser02@gmail.com'
    fill_in 'Password' , with: 'password'
    click_on 'Log in'
    click_link '管理画面を表示'
    click_on '編集',match: :first
    fill_in 'Name' , with: 'spectestuser05'
    fill_in 'Email' , with: 'spectestuser05@gmail.com'
    fill_in 'Password' , with: 'password'
    fill_in 'Password_confirmation' , with: 'password'
    click_on '更新'
    expect(page).to have_content 'spectestuser05'
  end

  scenario "管理画面でユーザー情報の更新できるかテスト" do
    visit tasks_path
    fill_in 'Email' , with: 'spectestuser02@gmail.com'
    fill_in 'Password' , with: 'password'
    click_on 'Log in'
    click_link '管理画面を表示'
    click_on '削除',match: :first
    expect(page).to_not have_content 'spectestuser03'
  end

#save_and_open_page
#bin/rspec spec/features/user.spec.rb
end
