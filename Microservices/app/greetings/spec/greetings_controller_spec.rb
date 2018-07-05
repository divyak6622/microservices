require 'spec_helper'
require 'rails_helper'

describe GreetingsController do
  it "shows message" do
    get :hello
    response.should render_template :hello
  end
end