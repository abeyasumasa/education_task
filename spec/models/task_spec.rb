require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(name: '', content: '失敗テスト', expiration_date: '2019/10/20', state:'未着手' )
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: '', expiration_date: '2019/10/21', state: '未着手' )
    expect(task).not_to be_valid
  end

  it "expiration_dateが空ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: '失敗テスト', expiration_date: '', state:'未着手' )
    expect(task).not_to be_valid
  end

  it "stateが空ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', content: '失敗テスト', expiration_date: '2019/10/21', state: '' )
    expect(task).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.new(name: '成功テスト', content: '成功テスト',expiration_date:'2019/9/30', state: '未着手' )
    expect(task).to be_valid
  end

end
