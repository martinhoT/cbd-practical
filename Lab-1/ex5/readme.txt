Keys:
-cnt:uid (user id counter)
-cnt:mid (message id counter)

-uinfo:<username> (HASH, holds basic user info, mainly used for authentication)
    -uid -> <user id>
    -pass -> <password>
-uinfo:<uid> -> <username> (Simple key, in order to facilitate uid->username correspondence)
-uinfo:<uid>:follows (SET, set of the uids of the users that <uid> follows)
-uinfo:<uid>:msgs (LIST, redundant but used for performance, lists all the messages from <uid>)

-msg:<id> (HASH, represents a message)
    -uid -> <user id>
    -content -> <the message itself>
    -to -> <-1 if it's a global message, uid if it's a directed message>

Notes:
-Counters start at 0
-The application can assume that usernames are always unique. However,
uids are used in order to maintain most of the database entries intact
if a user changes their username