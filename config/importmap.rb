# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "three", preload: true # @0.167.1
pin "objLoader", preload: true # @0.167.1
pin "orbitControls", preload: true # @0.167.1
pin_all_from "app/javascript/controllers", under: "controllers"
