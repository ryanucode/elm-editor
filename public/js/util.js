/* global URLSearchParams */

const getQueryParam = param => (new URLSearchParams(window.location.search)).get(param);
const getElement  = s => document.querySelector(s);
const getElements = s => document.querySelectorAll(s);
const getById     = i => document.getElementById(i);
const getByClass  = c => document.getElementsByClassName(c);