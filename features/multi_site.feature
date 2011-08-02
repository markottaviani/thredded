Feature: Multiple websites for a single installation
  In order to serve multiple domains
  An install of thredded
  Should serve the appropriately scoped messageboards and threads

  Scenario: Default domain "example.com" has its own messageboards
    Given the default website is "example.com"
      And the permission for "example.com" is "public"
      And the default website has two messageboards named "lol" and "kek"
     When I go to "example.com"
     Then I should see messageboards "lol" and "kek"

  Scenario: Two sites use their own subdomains  
    Given the default website is "example.com"
      And a subdomain site exists called "red.example.com"
      And a subdomain site exists called "blue.example.com"
      And "red.example.com" has two messageboards named "foo" and "bar"
      And "blue.example.com" has two messageboards named "baz" and "carl"
     When I go to "red.example.com"
     Then I should see messageboards "foo" and "bar"
      And I go to "blue.example.com"
     Then I should see messageboards "baz" and "carl"

  Scenario: One subdomain site and one custom domain site
    Given the default website is "example.com"
      And a subdomain site exists called "red.example.com"
      And a custom domain site exists called "www.forum.com"
      And "red.example.com" has two messageboards named "foo" and "bar"
      And "www.forum.com" has two messageboards named "baz" and "carl"
     When I go to "red.example.com"
     Then I should see messageboards "foo" and "bar"
      And I go to "www.forum.com"
     Then I should see messageboards "baz" and "carl"

  Scenario: Website is behind a login
    Given the default website is "example.com"
      And the permission for "example.com" is "logged_in"
     When I go to "example.com"
     Then I should see the login form