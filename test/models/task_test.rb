require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "overdue? returns true if due_date is past and not done" do
    task = Task.new(title: "Overdue", done: false, due_date: 2.days.ago.to_date, project: projects(:one))
    assert task.overdue?
  end

  test "overdue? returns false if done even if date is past" do
    task = Task.new(title: "Done", done: true, due_date: 2.days.ago.to_date, project: projects(:one))
    assert_not task.overdue?
  end
end
