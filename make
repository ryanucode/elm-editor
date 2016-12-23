#!/bin/bash

#elm_modules=`printf "\
  #\nelm/Designer/Dashboard.elm\
  #\nelm/Designer/Main.elm\
  #\nelm/Student/Main.elm"`

#elm make $elm_modules --output=public/elm/elm.js
elm make --output=public/elm/elm.js

