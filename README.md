# Email Verification — iOS Coding Challenge (Objective-C)

## Build instructions

1. Make sure `EmailVerification/ApiKeys/kickbox.txt` exists and contains a valid kickbox.io API key.
2. Open `EmailVerification.xcworkspace`.
3. Press `Cmd+R`.

## Task

> Build an incredible experience for users entering a single email address into a text field, while at the same time impressing us with how simple and clean your code is.

## Process

1. Created initial project, set up version control, copied all-round .gitignore file which I use for iOS projects.
2. Created Model, ViewModel, Controller, View folders. In each folder a .gitkeep file was created in order to save folder structure in git.
3. Initialized a Cocoapods workspace.
4. Set explicit 11.2 requirement. No backward compatibility for the sake of brevity.
5. Created a basic UI layout. MasterController was wrapped in UINavigationController. Navigation bar got Cancel and Done buttons. UITableViewController was embedded in a container view added to MasterController. Default UITableView separators were disabled.
6. Created Ensurable protocol, make MasterController "ensurable".
7. Created EmailValidator class with tests for both valid and invalid cases.
8. Created basic MasterViewModel class.
9. Defined project-specific colors via category.
10. Created custom NSError subclass.
11. Show string status of validation.
12. Added deliverable verification using kickbox.io API. Update status messages and colors behavior based on deliverable status. Ignore deliverable errors.
13. Added suggestions.
14. Refactored code, deleted repeated lines, simplified methods.
15. Set deployment target to 9.3.

© 2019 Nikita Titov

https://titov.dev

