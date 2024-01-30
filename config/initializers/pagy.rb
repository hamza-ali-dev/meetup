require 'pagy/extras/overflow'
require 'pagy/extras/bootstrap'

Pagy::DEFAULT[:items] = 10        # items per page
Pagy::DEFAULT[:size]  = [1,4,4,1] # nav bar links
Pagy::DEFAULT[:overflow] = :last_page
