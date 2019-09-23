
- user
    - id  integer
    - name string
    - email string
    - password_digest string
- task
    - id  integer
    - user_id integer
    - content text
    - expiration date date
    - priority string
    - states string
- label
    - id  integer
    - task_id integer
    - classification text

#   task
  タスクを登録し、管理するアプリ

# Versioning
*  ruby 2.6.3
*  Rails 5.2.3
*  psql (PostgreSQL) 11.3

#  Deployment
#  ディレクトリ配下のファイルをコミット対象にする
  1. git add -A
#  コミットする
  2. git commit -m "hogehoge"
#  リモートリポジトリherokuが作成されていることの確認
  3.  git remote
#  ローカルのmasterブランチをリモートリポジトリherokuへpushする
  4. git push heroku master
#  マイグレーションは手動で実行する必要があるため、変更した場合は以下のコマンドを入力する
  5.  heroku run rails:migrate
