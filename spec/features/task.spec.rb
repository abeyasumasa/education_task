# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
  Task.create!(name: 'test_task_01', content: 'testtesttest')
  Task.create!(name: 'test_task_02', content: 'samplesample')

  # tasks_pathにvisitする（タスク一覧ページに遷移する）
  visit tasks_path

  # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
  # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
  expect(page).to have_content 'testtesttest'
  expect(page).to have_content 'samplesample'

  end

  scenario "タスク作成のテスト" do
    # new_task_pathにvisitする（タスク登録ページに遷移する）
     visit  new_task_path

     # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
     # タスクのタイトルと内容をそれぞれfill_in（入力）する
      fill_in 'Name' , with: 'cording'
      fill_in 'Content' , with: 'プログラムを作成するため'

     # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
      click_on 'Create Task'
     # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
     # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      expect(page).to have_content 'cording'
      expect(page).to have_content  'プログラムを作成するため'
  end

  scenario "タスク詳細のテスト" do
    # あらかじめタスク詳細のテストで使用するためのタスクを作成する
      Task.create!(name: 'test_task_01', content: 'testtesttest')

    # id1のタスク詳細画面に遷移
      visit task_path(4)

    # タスク詳細画面の内容が表示されたページを一致しているか
      expect(page).to have_content 'test_task_01'
      expect(page).to have_content 'testtesttest'
  end
end
