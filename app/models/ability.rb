class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :edit, Book, draft: true, user: user
    else
      can :index, BooksController
    end
    can :read, Book, Book do |book|
      !book.draft and
      book.updated_at > Time.now - 7.days
    end
  end
end
