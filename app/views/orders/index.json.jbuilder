json.array!(@orders) do |order|
  json.extract! order, :id, :name, :customer, :received_at, :finished_at, :deadline_at, :invoiced, :state, :spent_time, :price, :comment, :description
  json.url order_url(order, format: :json)
end
