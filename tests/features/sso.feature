@redhat-sso-7/sso70
Feature: Standalone SSO tests

  Scenario: Test console is available
    When container is ready
    Then check that page is served
         | property | value |
         | port     | 8080  |
         | path     | /auth/admin/master/console/#/realms/master |
         | expected_status_code | 200 |

