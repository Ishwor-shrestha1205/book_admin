class BooksController < ApplicationController
    protect_from_forgery except:[:destroy]
    before_action :set_book, only : [:show, :destroy]
    around_action : action_logger, only: [:destroy]

    def show
        @book = Book.find(param[:id])
        respond_to do |format|
            format.html
            format.json
        end
    end

    def destroy
        @book = Book.find(param[:id])
        @boo = Book.destroy
        respond_to do |format|
            format.html {redirect_to "/"}
            format.json {head: no_content}
        end
    end

    private

    def set_book
        @book = book.find(param[:id])
    end

    def action_logger
        logger.info "around-before"
        yeild
        logger.info "around-after"
    end
end
