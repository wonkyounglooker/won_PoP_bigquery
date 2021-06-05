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

explore: pop_parameters_multi_period {
  label: "PoP Method 4: Compare multiple templated periods"
  extends: [pop_parameters]
  sql_always_where:
        {% if pop_parameters_multi_period.current_date_range._is_filtered %} {% condition pop_parameters_multi_period.current_date_range %} ${created_raw} {% endcondition %}
        {% if pop_parameters_multi_period.previous_date_range._is_filtered or pop_parameters_multi_period.compare_to._in_query %}
        {% if pop_parameters_multi_period.comparison_periods._parameter_value == "2" %}
            or ${created_date} between ${period_2_start} and ${period_2_end}
        {% elsif pop_parameters_multi_period.comparison_periods._parameter_value == "3" %}
            or ${created_date} between ${period_2_start} and ${period_2_end}
            or ${created_date} between ${period_3_start} and ${period_3_end}
        {% elsif pop_parameters_multi_period.comparison_periods._parameter_value == "4" %}
            or ${created_date} between ${period_2_start} and ${period_2_end}
            or ${created_date} between ${period_3_start} and ${period_3_end} or ${created_date} between ${period_4_start} and ${period_4_end}
        {% else %} 1 = 1
        {% endif %}
        {% endif %}
        {% else %} 1 = 1
        {% endif %};;
}

explore: pop_parameters_with_custom_range {
  label: "PoP Method 5: Compare current period with another arbitrary period"
  always_filter: {
    filters: [current_date_range: "1 month", previous_date_range: "2 months ago for 2 days"]
  }
}

explore: pop_arbitrary {
  label: "PoP Method 6: Compare two arbitrary date ranges"
  always_filter: {
    # filters: [first_period_filter, second_period_filter, period_selected:"-NULL"]
    filters: [first_period_filter: "1 year", second_period_filter: "2 years ", period_selected:"-NULL"]
  }
}
