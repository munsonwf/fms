require 'test_helper'

class CaseFilesControllerTest < ActionController::TestCase
  setup do
    @case_file = case_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:case_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create case_file" do
    assert_difference('CaseFile.count') do
      post :create, case_file: { client_id: @case_file.client_id, date_closed: @case_file.date_closed, date_opened: @case_file.date_opened, file_no: @case_file.file_no, location: @case_file.location, matter: @case_file.matter, name: @case_file.name }
    end

    assert_redirected_to case_file_path(assigns(:case_file))
  end

  test "should show case_file" do
    get :show, id: @case_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @case_file
    assert_response :success
  end

  test "should update case_file" do
    patch :update, id: @case_file, case_file: { client_id: @case_file.client_id, date_closed: @case_file.date_closed, date_opened: @case_file.date_opened, file_no: @case_file.file_no, location: @case_file.location, matter: @case_file.matter, name: @case_file.name }
    assert_redirected_to case_file_path(assigns(:case_file))
  end

  test "should destroy case_file" do
    assert_difference('CaseFile.count', -1) do
      delete :destroy, id: @case_file
    end

    assert_redirected_to case_files_path
  end
end
