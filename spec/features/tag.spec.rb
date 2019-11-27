require 'rails_helper'
RSpec.feature "タスク管理機能", type: :feature do
  background do
    page.driver.browser.authorize('admin','password')
    FactoryBot.create(:first_user)
    FactoryBot.create(:first_tag)
    FactoryBot.create(:second_tag)
    visit tags_path
    #fill_in 'Email' , with: 'spectestuser02@gmail.com'
    #fill_in 'Password' , with: 'password'
    #click_on 'Log in'
  end

  scenario "タグ一覧のテスト" do
    visit tags_path
    expect(page).to have_content 'testtag02'
    expect(page).to have_content 'testtag03'
  end

  scenario "ラベルを作成できるかテスト" do
    visit tags_path
    click_on '新しくタグ追加する'
    fill_in 'title' , with: 'testtag01'
    click_on '登録する'
    expect(page).to have_content 'testtag01'
  end

  #save_and_open_page
end