# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
require 'zip'

#管理者ログイン情報
Admin.create!(
  name: "admin",
  email: "admin@login.com",
  password: "adminpassword"
  )


#Prefectyreテーブルに都道府県の情報を供給する
#日本郵政より都道府県ZIPファイルを入手
DLURL           = "http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
SAVEDIR         = "db/"
CSVROW_PREFNAME = 6
savePath = ""

#ZIPファイル入手→解凍→CSVとして保存
open(URI.escape(DLURL)) do |file|
  ::Zip::File.open_buffer(file.read) do |zf|
    zf.each do |entry|
      savePath = SAVEDIR + entry.name
      zf.extract(entry, savePath) { true }
    end
  end
end

#CSVを読み込みDBに保存
CSV.foreach(savePath, encoding: "Shift_JIS:UTF-8") do |row|
  prefName = row[CSVROW_PREFNAME]
  Prefecture.find_or_create_by(:name => prefName)
end

#保存したCSVファイルを削除
File.unlink savePath