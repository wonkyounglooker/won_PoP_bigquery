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

explore: pop_simple {
  label: "PoP Method 2: Allow users to choose periods with parameters"
  always_filter: {
    # filters: [choose_comparison, choose_breakdown]
    filters: [choose_comparison: "Year", choose_breakdown: "Month"]
  }
} #article missing this closing parenthesis

explore: pop_parameters {
  label: "PoP Method 3: Custom choice of current and previous periods with parameters"
  always_filter: {
    filters: [current_date_range: "6 months", compare_to: "Year" ]
  }
}
