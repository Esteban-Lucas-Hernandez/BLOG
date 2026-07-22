require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "should not save project with invalid status" do
    project = Project.new(title: "Test", status: "invalid", client: clients(:one))
    assert_not project.save
  end

  test "progress_percentage calculates correctly" do
    project = Project.create!(title: "Test", status: "active", client: clients(:one))
    assert_equal 0, project.progress_percentage
    
    Task.create!(title: "T1", done: true, project: project)
    Task.create!(title: "T2", done: false, project: project)
    
    assert_equal 50, project.progress_percentage
  end
end
