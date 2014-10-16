class SearchesController < ApplicationController
  def cities
    keyword = (params[:q] || "Ha").downcase
    all_cities = Settings.cities.values.flat_map(&:values)
    cities = all_cities.select { |x| x.downcase.match(/#{keyword}/).present? }
    render json: cities.as_json
  end
end