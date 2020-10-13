class UserGenre < ActiveHash::Base

  self.data = [
    {id: 1, name: 'ジャズ'},
    {id: 2, name: 'ブルース'},
    {id: 3, name: 'ロック'},
    {id: 4, name: 'ハードロック'},
    {id: 5, name: 'フュージョン'},
    {id: 6, name: 'パンク/メロコア'},
    {id: 7, name: 'ファンク'},
    {id: 8, name: 'ソウル/R&B'},
    {id: 9, name: 'ハウス/テクノ'},
    {id: 10, name: 'カントリー/フォーク'},
    {id: 11, name: 'メタル'},
    {id: 12, name: 'スカ'},
    {id: 13, name: 'ロカビリー'},
    {id: 14, name: 'ボサノバ/ラテン'},
    {id: 15, name: 'ヒップホップ/レゲエ'},
    {id: 16, name: 'クラシック'},
    {id: 17, name: 'ゴスペル/アカペラ'},
    {id: 18, name: 'その他'},
  ]

  include ActiveHash::Associations
  has_many :users

end