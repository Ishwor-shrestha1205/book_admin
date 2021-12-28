class Book < ApplicationRecord
    enum sales_status: {
        reservation: 0,
        now_on_sale: 1,
        end_of_print: 2,
    }
    scope :costly, -> {where("price > ?", 3000)}
    # Book.costly.written_about("java")書くことで、3000円以上のjava書いている本を探す。
    scope :written_about, -> (theme) { where("name > ?", "%#{theme}%")}
    # Book.find_by(price: 1000)はnilけどBook.find_price(10000)の時はないと全部
    scope :find_price, ->(price) { find_by(price: price)}
    belongs_to :publisher
    has_many :book_authors
    has_many :authors, through: :book_authors
    validates :name, presence: true
    validates :name, length: { maximum: 25}
    validates :price, numericality: {greater_than_or_equal_to: 0}
    validate do |book|
        if book.name.include?("exercise")
            book.errors[:name] << "I don't like exercise."
        end
    end

    before_validation :add_lovely_to_cat

    def add_lovely_to_cat
        self.name = self.name.gsub(/Cat/) do |matched|
            "lovely #{matched}"
        end
    end

    after_destroy do
        Rails.logger.info "Book is deleted: #{self.attributes}"
    end

    after_destroy :if => :high_price? do
        Rails.logger.warn "Book with high price is deleted: #{self.attributes}"
        Rails.logger.warn "Please check!!"
    end

    def high_price?
        price >= 5000
    end
end
