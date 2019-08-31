require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: 'patty', email: 'patty@gmail.com', password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: 'Italian pizza', description: 'Amazing italian pizza cooked for 20 minutes', chef: @chef)
  end

  test 'successfully delete a recipe' do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe), text: 'Delete this recipe'
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end

end
