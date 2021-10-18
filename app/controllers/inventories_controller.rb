class InventoriesController < AuthorizedBaseApiController
  before_action :set_inventory, :authorize_user, only: %i[show update destroy update_status]
  before_action :authorize_create_user, only: :create

  def index
    @inventories = policy_scope(Inventory)
    render json: @inventories
  end

  def create
    @inventory = Inventory.create!(
      inventory_params.merge!({
        company_id: @current_user.company_id,
        created_by_id: @current_user.id
      })
    )
    render json: @inventory
  end

  def show
    render json: @inventory
  end

  def update
    @inventory.update!(inventory_params)
    render json: @inventory
  end

  def destroy
    @inventory.destroy!
    render json: @inventory
  end

  def update_status
    @inventory.update!(inventory_approve_params.merge!({ status_updated_at: Time.now.utc }))
    render json: @inventory
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end

  def inventory_approve_params
    params.require(:inventory).permit(:approved)
  end

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def authorize_user
    authorize @inventory
  end

  def authorize_create_user
    authorize Inventory
  end
end
