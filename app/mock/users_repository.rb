module Mock
  class UsersRepository
    def initialize
      @users = [
        { email: "user1@example.com", password: "password1" },
        { email: "user2@example.com", password: "password2" },
        { email: "admin@example.com", password: "admin123" }
      ]
    end

    def find_by_email(email)
      @users.find { |u| u[:email] == email }
    end

    def add_user(email:, password:)
      @users << { email: email, password: password }
    end
  end
end
