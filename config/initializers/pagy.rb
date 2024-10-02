# Optionally override some pagy default with your own in the pagy initializer
Pagy::DEFAULT[:limit]    = 50 # items per page
Pagy::DEFAULT[:size]     = 9  # nav bar links
Pagy::DEFAULT[:overflow] = :last_page

# Better user experience handled automatically
require 'pagy/extras/overflow'
require 'pagy/extras/bootstrap'
