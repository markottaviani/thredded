Feature: Reply to a thread
  In order to reply to a thread
  A user
  Should submit new content and see it on that thread's page

  Scenario: The member adds a new reply
    Given a messageboard named "thredded" that I, "joel", am a member of
      And a thread already exists on "thredded"
     When I go to the most recently updated thread on "thredded"
      And I submit some drivel like "oh my god this is the greatest, most AMAZING thread of ALL TIME."
     Then I should see "oh my god this is the greatest, most AMAZING thread of ALL TIME."