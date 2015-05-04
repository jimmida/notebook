require 'rails_helper'

RSpec.describe "lessons/index", type: :view do
  before(:each) do
    assign(:lessons, [
      Lesson.create!(
        :course_id => "",
        :name => "Name",
        :url => "Url"
      ),
      Lesson.create!(
        :course_id => "",
        :name => "Name",
        :url => "Url"
      )
    ])
  end

  it "renders a list of lessons" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
