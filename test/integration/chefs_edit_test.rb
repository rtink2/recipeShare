require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest

  def setup
   @chef = Chef.create!(chefname: "patty", email: "patty@gmail.com", password: "password", password_confirmation: "password")
  end

  test 'reject an invalid edit' do
      sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname: ' ', email: 'patty@gmail.com' }}
    assert_template 'chefs/edit'
    assert_select 'h2.card-title'
    assert_select 'div.card-body'
  end

  test 'accept valid signup' do
      sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname: 'patty1', email: 'patty1@gmail.com' }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match 'patty1', @chef.chefname
    assert_match 'patty1@gmail.com', @chef.email
  end

end
