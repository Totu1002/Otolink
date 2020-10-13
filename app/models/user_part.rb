class UserPart < ActiveHash::Base

  self.data = [
    {id: 1, name: 'ボーカル'},
    {id: 2, name: 'ギター'},
    {id: 3, name: 'ベース'},
    {id: 4, name: 'ピアノ・キーボード'},
    {id: 5, name: 'ドラム'},
    {id: 6, name: 'パーカッション'},
    {id: 7, name: '管楽器'},
    {id: 8, name: '弦楽器'},
    {id: 9, name: '作詞・作曲・編曲'},
    {id: 10, name: 'DJ'},
    {id: 11, name: 'ダンサー・パフォーマー'},
    {id: 12, name: 'その他'},
  ]

  include ActiveHash::Associations
  has_many :users

end