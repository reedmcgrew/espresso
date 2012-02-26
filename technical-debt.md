### To-Do
- Keep user ids in the session so they can be used throughout the site. Try using last_insert_id
- Add first name and last name to the signup page


### To-Do: Code Cleanup
- The account creation controller is really messy (create.coffee).  It needs to be simplified

### To-Do: Nice
- Implement Logout
- Refactor the database migrations setup to depend on the same file as the rest of the app for its database name, user, and password
- Change the users.find method to use a callback instead of events: it will be cleaner.


### Dependency inclusion in the routes is a little messy.
- See where the authenticate controller includes models and settings.  How can I make this cleaner so I do not have to include these things in every file?

### I am still using plain-text passwords
- Yeah...  you need to change this if you are actually going to use the user accounts functionality in a production site.

