class Book < ApplicationRecord
    scope :costly, -> {where("price > ?", 3000)}
    # Book.costly.written_about("java")書くことで、3000円以上のjava書いている本を探す。
    scope :written_about, -> (theme) { where("name > ?", "%#{theme}%")}
    # Book.find_by(price: 1000)はnilけどBook.find_price(10000)の時はないと全部
    scope :find_price, ->(price) { find_by(price: price)}
    belongs_to :publisher
end
