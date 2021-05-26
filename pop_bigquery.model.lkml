connection: "lookertest-bigquery"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: order_items {
  label: "PoP Method 1: Use Looker's native date dimension groups"
  # join: orders {
  #   type: left_outer
  #   sql_on: ${order_items.order_id} = ${orders.id} ;;
  #   relationship: many_to_one
  #   }
}
