*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false
    New Page         https://marketsquare.github.io/robotframework-browser/Browser.html
    Get Title      ==    Browser
