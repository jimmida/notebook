require 'rails_helper'

RSpec.describe "lessons/new", type: :view do
  before(:each) do
    assign(:lesson, Lesson.new(
      :course_id => "",
      :name => "MyString",
      :url => "MyString"
    ))
  end

  it "renders new lesson form" do
    render

    assert_select "form[action=?][method=?]", lessons_path, "post" do

      assert_select "input#lesson_course_id[name=?]", "lesson[course_id]"

      assert_select "input#lesson_name[name=?]", "lesson[name]"

      assert_select "input#lesson_url[name=?]", "lesson[url]"
    end
  end
end
