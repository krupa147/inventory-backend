class UsersController < AuthorizedBaseApiController
  before_action :set_user, :authorize_user, only: %i[show update destroy]
  before_action :authorize_create_user, only: :create
  before_action :role_validation, only: %i[create update]

  def index
    @users = policy_scope(User)
    paginate json: @users, per_page: pagination_params[:per_page], page: pagination_params[:page]
  end

  def create
    @user = User.create!(user_params)
    @user.generate_password_token!
    UserMailer.with(user: @user).onboard.deliver_later
    render json: @user
  end

  def show
    render json: @user
  end

  def update
    @user.update(user_params)
    render json: @user
  end

  def destroy
    @user.destroy!
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end

  def user_update_params
    params.require(:user).permit(:role)
  end

  def set_user
    @user = policy_scope(User).find(params[:id])
  end

  def authorize_user
    authorize @user
  end

  def authorize_create_user
    authorize User
  end

  def role_validation
    unless %w[inventory_manager quality_check_person sales_manager IT_admin].include? user_params[:role]
      raise ActionController::ParameterMissing.new(:role)
    end
  end
end
