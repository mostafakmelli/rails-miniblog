class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    context = { loaders: {} }

    result = MiniBlogApiSchema.execute(
      params[:query],
      variables: variables,
      context: context,
      operation_name: params[:operationName]
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    render json: { errors: [ { message: e.message, backtrace: e.backtrace } ] }, status: 500
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? JSON.parse(ambiguous_param) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
