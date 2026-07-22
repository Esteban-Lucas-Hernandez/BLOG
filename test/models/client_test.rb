require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "should not save client without name" do
    client = Client.new(email: "test@example.com")
    assert_not client.save, "Saved the client without a name"
  end

  test "should not destroy client if they have active projects" do
    client = clients(:one) # assuming fixtures are setup, or we create one
    project = Project.create!(title: "Active Proj", status: "active", client: client)
    assert_not client.destroy
    assert client.errors[:base].include?("No se puede eliminar el cliente porque tiene proyectos activos.")
  end
end
