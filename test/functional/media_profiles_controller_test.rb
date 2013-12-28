require 'test_helper'

class MediaProfilesControllerTest < ActionController::TestCase
  setup do
    @media_profile = media_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create media_profile" do
    assert_difference('MediaProfile.count') do
      post :create, media_profile: { company_name: @media_profile.company_name, designation: @media_profile.designation, email: @media_profile.email, media_type: @media_profile.media_type, name: @media_profile.name, office_phone: @media_profile.office_phone, phone: @media_profile.phone, title: @media_profile.title }
    end

    assert_redirected_to media_profile_path(assigns(:media_profile))
  end

  test "should show media_profile" do
    get :show, id: @media_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @media_profile
    assert_response :success
  end

  test "should update media_profile" do
    put :update, id: @media_profile, media_profile: { company_name: @media_profile.company_name, designation: @media_profile.designation, email: @media_profile.email, media_type: @media_profile.media_type, name: @media_profile.name, office_phone: @media_profile.office_phone, phone: @media_profile.phone, title: @media_profile.title }
    assert_redirected_to media_profile_path(assigns(:media_profile))
  end

  test "should destroy media_profile" do
    assert_difference('MediaProfile.count', -1) do
      delete :destroy, id: @media_profile
    end

    assert_redirected_to media_profiles_path
  end
end
