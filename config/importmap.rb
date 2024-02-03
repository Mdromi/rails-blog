# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
# pin "tw-elements", to: "tw-elements"
pin_all_from "app/javascript/controllers", under: "controllers"
# pin "tw-elements", to: "./node_modules/tw-elements"