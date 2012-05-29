require 'spec_helper'

describe CommentsController do

  before(:each) do
    @mentor = Factory(:mentor)
    @kid = Factory(:kid, :mentor => @mentor)
    @journal =  Factory(:journal, :kid => @kid, :mentor => @mentor)
  end


  context 'as a mentor' do
    before(:each) do
      sign_in @mentor
    end
  
    it 'should render the new template' do
      get :new, :kid_id => @kid.id, :journal_id => @journal.id
      response.should be_successful
    end

    it 'should not render the new template for foreign journal entries' do
      @foreign = Factory(:journal)
      expect { get :new, :kid_id => @foreign.kid.id, :journal_id => @foreign.id}.to raise_error(CanCan::AccessDenied)
    end

    it 'should not create an invalid journal entry' do
      post :create, :kid_id => @kid.id, :journal_id => @journal.id
      response.should be_success
    end

    it 'should create a journal entry' do
      post :create, :kid_id => @kid.id, :journal_id => @journal.id, :comment => { :by => 'by', :body => 'body' }
      response.should be_redirect
    end
  end

end
