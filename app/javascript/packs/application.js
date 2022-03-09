import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import 'channels'
import 'bootstrap'
import $ from 'jquery';
import 'select2'
import 'select2/dist/css/select2.css'
import './book_details'
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel';
import 'toastr'
import '@popperjs/core';

require('jquery')
require('toastr')

window.addEventListener('DOMContentLoaded', () => {
  $('.js-states').select2()
})

$(document).ready(function() {
    $('.author-multiple').select2();
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
