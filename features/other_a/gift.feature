Feature: Create Gifts
  In order to make friends and influence people
  As an author
  I want to create works for other people


  Background:
    Given the following activated users exist
      | login      | password    | email            |
      | gifter     | something   | gifter@foo.com   |
      | gifter2    | something   | gifter2@foo.com  |
      | giftee1    | something   | giftee1@foo.com  |
      | giftee2    | something   | giftee2@foo.com  |
      | associate  | something   | associate@foo.com |
      And I am logged in as "gifter" with password "something"
      And I set up the draft "GiftStory1"


  Scenario: Giving a work as a gift when posting directly

    Given I give the work to "giftee1"
    When I press "Post Without Preview"
    Then I should see "For giftee1"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Giving a work as a gift when posting after previewing

    Given I give the work to "giftee1"
      And I press "Preview"
      And I should see "For giftee1"
      And 0 emails should be delivered
    When I press "Post"
    Then I should see "For giftee1"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Edit a draft to add a recipient, then post after previewing

    Given I press "Preview"
      And I press "Edit"
      And I give the work to "giftee1"
      And I press "Preview"
      And 0 emails should be delivered
    When I press "Post"
    Then I should see "For giftee1"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Edit an existing work to add a recipient, then post directly

    Given I press "Post Without Preview"
      And I follow "Edit"
      And I give the work to "giftee1"
    When I press "Post Without Preview"
    Then I should see "For giftee1"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Edit an existing work to add a recipient, then post after previewing

    Given I press "Post Without Preview"
      And I follow "Edit"
      And I give the work to "giftee1"
    When I press "Preview"
    # this next thing is broken on beta currently, will settle for not breaking it worse
    Then 0 emails should be delivered
    When I press "Edit"
    Then "giftee1" should be listed as a recipient in the form
    When I press "Preview"
    Then 0 emails should be delivered
    When I press "Update"
    Then I should see "For giftee1"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Give two gifts to the same recipient

    Given I give the work to "giftee1"
      And I press "Post Without Preview"
      And I set up the draft "GiftStory2"
      And I give the work to "giftee1"
    When I press "Post Without Preview"
      And I follow "giftee1"
    Then I should see "Gifts for giftee1"
      And I should see "GiftStory1"
      And I should see "GiftStory2"


  Scenario: Add another recipient to a posted gift

    Given I give the work to "giftee1"
      And I press "Post Without Preview"
      And I should see "For giftee1"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"
      And all emails have been delivered
      And I follow "Edit"
      And I give the work to "giftee1, giftee2"
    When I press "Post Without Preview"
    Then I should see "For giftee1, giftee2"
      And 0 emails should be delivered to "giftee1@foo.com"
      And "giftee2@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Add another recipient to a draft gift

    Given I give the work to "giftee1"
      And I press "Preview"
      And I should see "For giftee1"
      And 0 emails should be delivered to "giftee1@foo.com"
      And I press "Edit"
      And I give the work to "giftee1, giftee2"
    When I press "Post Without Preview"
    Then I should see "For giftee1, giftee2"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"
      And "giftee2@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Add two recipients, post, then remove one

    Given I give the work to "giftee1, giftee2"
      And I press "Post Without Preview"
      And I should see "For giftee1, giftee2"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"
      And "giftee2@foo.com" should be notified by email about their gift "GiftStory1"
      And all emails have been delivered
      And I follow "Edit"
      And I give the work to "giftee1"
    When I press "Post Without Preview"
    Then I should see "For giftee1"
      And I should not see "giftee2"
      And 0 emails should be delivered to "giftee1@foo.com"
      And 0 emails should be delivered to "giftee2@foo.com"


  Scenario: Add two recipients, preview, then remove one

    Given I give the work to "giftee1, giftee2"
      And I press "Preview"
      And I should see "For giftee1, giftee2"
      And 0 emails should be delivered
      And I press "Edit"
      And I give the work to "giftee1"
    When I press "Post Without Preview"
    Then I should see "For giftee1"
      And I should not see "giftee2"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"
      And 0 emails should be delivered to "giftee2@foo.com"


  Scenario: Edit a posted work to replace one recipient with another

    Given I give the work to "giftee1"
      And I press "Post Without Preview"
      And I should see "For giftee1"
      And "giftee1@foo.com" should be notified by email about their gift "GiftStory1"
      And all emails have been delivered
      And I follow "Edit"
      And I give the work to "giftee2"
    When I press "Post Without Preview"
    Then I should see "For giftee2"
      And I should not see "giftee1"
      And 0 emails should be delivered to "giftee1@foo.com"
      And "giftee2@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: Edit a draft to replace one recipient with another

    Given I give the work to "giftee1"
      And I press "Preview"
      And I should see "For giftee1"
      And 0 emails should be delivered
      And I press "Edit"
      And I give the work to "giftee2"
    When I press "Post Without Preview"
    Then I should see "For giftee2"
      And I should not see "giftee1"
      And 0 emails should be delivered to "giftee1@foo.com"
      And "giftee2@foo.com" should be notified by email about their gift "GiftStory1"


  Scenario: When a user is notified that a co-authored work has been given to them as a gift, the e-mail should link to each author's URL instead of showing escaped HTML

    Given I add the co-author "gifter2"
      And I give the work to "giftee1"
      And I post the work without preview
    Then 1 email should be delivered to "gifter2"
      And the email should contain "You have been listed as a coauthor on the following work"
    Then 1 email should be delivered to "giftee1"
      And the email should link to gifter's user url
      And the email should not contain "&lt;a href=&quot;http://archiveofourown.org/users/gifter/pseuds/gifter&quot;"
      And the email should link to gifter2's user url 
      And the email should not contain "&lt;a href=&quot;http://archiveofourown.org/users/gifter2/pseuds/gifter2&quot;"

  Scenario: A gift work should have an associations list

    Given I give the work to "associate"
    When I press "Post Without Preview"
    Then I should find a list for associations
      And I should see "For associate"

  Scenario: A user should not be able to gift a work twice to the same person

    Given "associate" has the pseud "associate2"
      And I am logged in as "troll"
      And I set up the draft "Yuck"
      And I have given the work to "associate, associate2 (associate)"
    Then I should not see "For associate, associate2"
      And I should see "For associate"
      And 1 email should be delivered to "associate@foo.com"
    When all emails have been delivered
      And I edit the work "Yuck"
      And I give the work to "associate, associate2 (associate)"
      And I post the work without preview
    Then I should see "You cannot give a gift to the same user twice."
      And I should not see "For associate, associate2"
      And 0 emails should be delivered to "associate@foo.com"
      
  Scenario: A user should be able to refuse a gift

    Given I have given the work to "associate"
      And I am logged in as "someone_else"
      And I am on associate's gifts page
    Then I should not see "Refuse Gift"
      And I should not see "Refused Gifts"
    When I am logged in as "associate" with password "something"
      And I go to my gifts page
    Then I should see "GiftStory1"
      And I should see "Refuse Gift"
      And I should see "Refused Gifts"
    When I follow "Refuse Gift"
    Then I should see "This work will no longer be listed among your gifts."
      And I should not see "GiftStory1"
    When I follow "Refused Gifts"
    Then I should see "GiftStory1"
      And I should not see "by gifter for associate"
    When I view the work "GiftStory1"
    Then I should not see "For associate"
      And I should not see "For ."
        
  Scenario: A user should be able to re-accept a gift
  
    Given I have refused the work
      And I am on my gifts page
      And I follow "Refused Gifts"
    Then I should see "Accept Gift"
      And I should not see "by gifter for giftee1"
    When I follow "Accept Gift"
    Then I should see "This work will now be listed among your gifts."
      And I should see "GiftStory1"
      # TODO: Touch work so the blurb updates with recip info when gift is re-accepted
      # And I should see "by gifter for giftee1"
    When I view the work "GiftStory1"
    Then I should see "For giftee1"

  Scenario: An admin should see that a gift has been refused

    Given I have refused the work
      And I am logged in as an admin
      And I view the work "GiftStory1"
    Then I should see "Refused As Gift: giftee1"

  Scenario: Can't remove a recipient who has refused the gift
  
    Given I have refused the work
      And I am logged in as "gifter"
    When I edit the work "GiftStory1"
    Then "giftee1" should not be listed as a recipient in the form
      And the gift for "giftee1" should still exist on "GiftStory1"
    When I have removed the recipients
    Then the gift for "giftee1" should still exist on "GiftStory1"

  Scenario: Opt to disable notifications, then receive a gift (with no collection)
 
    Given I am logged in as "giftee1" with password "something"
      And I set my preferences to turn off notification emails for gifts
    When I am logged in as "gifter" with password "something"
      And I post the work "QuietGift" as a gift for "giftee1, giftee2"
    Then 0 emails should be delivered to "giftee1@foo.com"
      And "giftee2@foo.com" should be notified by email about their gift "QuietGift" 
 
  Scenario: Opt to disable notifications, then receive a gift posted to a non-hidden collection
 
    Given I am logged in as "giftee1" with password "something"
      And I set my preferences to turn off notification emails for gifts
      And I have the collection "Open Skies"
    When I am logged in as "gifter" with password "something"
      And I post the work "QuietGift" in the collection "Open Skies" as a gift for "giftee1, giftee2"
    Then 0 emails should be delivered to "giftee1@foo.com"
      And "giftee2@foo.com" should be notified by email about their gift "QuietGift" 
 
  Scenario: Opt to disable notifications, then receive a gift posted to a hidden collection and later revealed
 
    Given I am logged in as "giftee1" with password "something"
      And I set my preferences to turn off notification emails for gifts
      And I have the hidden collection "Hidden Treasures"
    When I am logged in as "gifter" with password "something"
      And I post the work "QuietGift" in the collection "Hidden Treasures" as a gift for "giftee1, giftee2"
      And I reveal works for "Hidden Treasures"
    Then 0 emails should be delivered to "giftee1@foo.com"
      And "giftee2@foo.com" should be notified by email about their gift "QuietGift" 
  
