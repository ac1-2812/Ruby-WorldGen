Rails.application.routes.draw do
  root "terrain_editor#index"

  get "/terrain_editor", to: "terrain_editor#index"
end
