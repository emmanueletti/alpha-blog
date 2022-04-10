require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # setup method gets run before each test since instance variables all get deleted
  # after each test is finished
  def setup
    @category = Category.new(name: 'Sport')
  end

  test 'category should be valid' do
    assert(@category.valid?)
  end

  test 'name should be present' do
    @category.name = ' '
    # assert that the category gets invalidated due to the lack of a proper name
    assert_not(@category.valid?)
  end

  test 'name should be unique' do
    @category.save
    @second_category = Category.new(name: 'sport')
    assert_not(@second_category.valid?)
  end

  test 'name should not be too long ' do
    @category.name = 'a' * 26
    assert_not(@category.valid?)
  end

  test 'name should not be too short' do
    @category.name = 'aa'
    assert_not(@category.valid?)
  end
end
