### To-Do: Urgent
- DONE Create middleware so that from login it will redirect to welcome page if the user session is set.
- DONE Create middleware so that from all other pages it will redirect to login if the user session is not set.
- Implement Logout
- Create sign-up page

### To-Do: Nice
- Refactor the database migrations setup to depend on the same file as the rest of the app for its database name, user, and password
- Change the users.find method to use a callback instead of events: it will be cleaner.


### Dependency inclusion in the routes is a little messy.
- See where the authenticate controller includes models and settings.  How can I make this cleaner so I do not have to include these things in every file?

### I am still using plain-text passwords
- Yeah...  you need to change this if you are actually going to use the user accounts functionality in a production site.

