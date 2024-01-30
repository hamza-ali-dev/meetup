import {$,jQuery} from 'jquery';

window.$ = $;
window.jQuery = jQuery;

import '@hotwired/turbo-rails'
import { Turbo } from '@hotwired/turbo-rails'
import 'bootstrap'
import './controllers'

import '@nathanvda/cocoon'

Turbo.start()
