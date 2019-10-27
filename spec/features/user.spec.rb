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
     visit user_path(3)
     expect(page).to_not have_content 'spectestuser02@gmail.com'
     save_and_open_page
   end
end
