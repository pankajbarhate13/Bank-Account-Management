require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #show" do
  #   it "returns http success" do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    {
      "first_name" => "ABC",
      "last_name" => "XYZ"
      "phone" => "1234567890",
      "email" => "rpatil1390@gmail.com",
      "address" => "abcd"
    }  
  }

  let(:invalid_attributes) {
    # skip("Add a hash of attributes invalid for your model")
    {
      "first_name" => "",
      "last_name" => ""
      "phone" => "12345678",
      "email" => "abcgmail.com",
      "address" => "abcde"
    }  
  }

  let(:valid_session) { {} }

  
  describe "GET #index" do
    it "assigns all accounts as @accounts" do
      account = Account.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:accounts)).to eq([account])
    end
  end

  describe "GET #show" do
    it "assigns the requested account as @account" do
      account = Account.create! valid_attributes
      get :show, {:id => account.to_param}, valid_session
      expect(assigns(:account)).to eq(account)
    end
  end

  describe "GET #new" do
    it "assigns a new account as @account" do
      get :new, {}, valid_session
      expect(assigns(:account)).to be_a_new(Account)
    end
  end

  describe "GET #edit" do
    it "assigns the requested account as @account" do
      account = Account.create! valid_attributes
      get :edit, {:id => account.to_param}, valid_session
      expect(assigns(:account)).to eq(account)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Account" do
        expect {
          post :create, {:account => valid_attributes}, valid_session
        }.to change(Account, :count).by(1)
      end

      it "assigns a newly created account as @account" do
        post :create, {:account => valid_attributes}, valid_session
        expect(assigns(:account)).to be_a(Account)
        expect(assigns(:account)).to be_persisted
      end

      it "redirects to the created account" do
        post :create, {:account => valid_attributes}, valid_session
        expect(response).to redirect_to(Account.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(assigns(:account)).to be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, {:account => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => new_attributes}, valid_session
        account.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested account as @account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        expect(assigns(:account)).to eq(account)
      end

      it "redirects to the account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => valid_attributes}, valid_session
        expect(response).to redirect_to(account)
      end
    end

    context "with invalid params" do
      it "assigns the account as @account" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => invalid_attributes}, valid_session
        expect(assigns(:account)).to eq(account)
      end

      it "re-renders the 'edit' template" do
        account = Account.create! valid_attributes
        put :update, {:id => account.to_param, :account => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested account" do
      account = Account.create! valid_attributes
      expect {
        delete :destroy, {:id => account.to_param}, valid_session
      }.to change(Account, :count).by(-1)
    end

    it "redirects to the account list" do
      account = Account.create! valid_attributes
      delete :destroy, {:id => account.to_param}, valid_session
      expect(response).to redirect_to(accounts_url)
    end
  end

end
