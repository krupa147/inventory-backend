# frozen_string_literal: true

module Paginator
  extend ActiveSupport::Concern
  def pagination_params
    {
      per_page: params[:per_page] || 10,
      page: params[:page] || 1
    }
  end
end
