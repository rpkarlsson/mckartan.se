require "rails_helper"
RSpec.describe "routes", :type => :routing do

  context "/sections routes" do
    it "GET to sections#index" do
      expect(get: "sections").to route_to(
            controller: "sections",
            action: "index")
    end

    it "POST to section#create" do
      expect(post: "sections").to route_to(
            controller: "sections",
            action: "create")
    end
  end

  context "/sections/:id routes" do
    it "GET to sections#show" do
      expect(get: "sections/1").to route_to(
            controller: "sections",
            action: "show",
            id: "1")
    end
  end

end
