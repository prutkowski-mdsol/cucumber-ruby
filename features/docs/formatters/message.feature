Feature: Protobuf message output formatter

  Background:
    Given a file named "features/my_feature.feature" with:
      """
      Feature: Some feature

        Scenario Outline: a scenario
          Given a <status> step

        Examples:
          | status |
          | passed |
          | failed |
      """

  Scenario: it produces NDJSON messages
    When I run `cucumber features/my_feature.feature --format message`
    Then output should be valid NDJSON
    And messages types should be:
      """
      gherkinDocument
      pickle
      pickle
      test_case
      test_case
      """

  Scenario: it produces binary message if asked too
    When I run `cucumber features/my_feature.feature --format message`
    Then output should be binary protobuf messages
