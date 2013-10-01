require 'spec_helper'


feature 'New Post' do
  def new_post(ptitle,pcontent)
    visit new_post_path
    fill_in 'post_title' , with: ptitle
    fill_in 'post_content' , with: pcontent

    click_button "Submit"
  end
end








