require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Charlie Brown", email: "charlie@example.com", age: 30)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should require a name" do
    @user.name = "   "
    assert_not @user.valid?
    assert_includes @user.errors[:name], "can't be blank"
  end

  test "should require an email" do
    @user.email = "   "
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "should accept valid email formats" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+tag@baz.cn]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end

  test "should reject invalid email formats" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
      assert_includes @user.errors[:email], "must be a valid email address"
    end
  end

  test "should enforce unique email addresses case-insensitively" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save!
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "should allow age to be nil (optional)" do
    @user.age = nil
    assert @user.valid?
  end

  test "should accept positive integer age" do
    @user.age = 25
    assert @user.valid?
  end

  test "should reject age of zero" do
    @user.age = 0
    assert_not @user.valid?
    assert_includes @user.errors[:age], "must be a positive integer"
  end

  test "should reject negative age" do
    @user.age = -15
    assert_not @user.valid?
    assert_includes @user.errors[:age], "must be a positive integer"
  end

  test "should reject non-integer age" do
    @user.age = 25.5
    assert_not @user.valid?
    assert_includes @user.errors[:age], "must be a positive integer"
  end

  test "should normalize email to lowercase and strip whitespace" do
    user = User.create!(name: "  Diana Prince  ", email: "  DIANA@Example.Com  ", age: 29)
    assert_equal "diana@example.com", user.email
    assert_equal "Diana Prince", user.name
  end
end
