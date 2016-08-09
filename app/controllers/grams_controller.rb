class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def show
    # .find_by_id will return nil if a Gram can not be found
    @gram = Gram.find_by_id(params[:id])
    if @gram.blank?
      render text: "Not Found", status: :not_found
    end
  end

  def new
    @gram = Gram.new
  end

  def create
    #@gram = Gram.create(gram_params)
    # b/c we specified that Users will have_many grams, we can now call
    # create on current_user.grams, which will populate the user_id field
    # when creating a gram
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end
end
