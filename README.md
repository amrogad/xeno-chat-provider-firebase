# Xeno Chat
A chat room app created with Provider, Firebase and using the MVVM app structure.

# Features:
- Create your own account
- Create a room with 4 default categories
- Add room description
- Browse other rooms
- All textfields require validation with valid error messages
- Snackbars that shows if any error has occurred
- A white and blue theme

I have made sure to keep all the logic in the view models of each view that way I can keep the view very clean, I have created custom widgets for each component in the app like textfields, buttons, scaffold and message bubbles.

That way I'm able to update or maintain them all at once and I don't have to repeate any code.

I'm using a custom validator class to ensure validation in all textfields, I made sure to make the validators in their own class instead of being in the view itself that way since we have 2 email and 2 passwords textfields (at sign up and sign in) we can use the same validators for them.

![sign in](https://github.com/amrogad/xeno-chat-provider-mvvm-firebase/assets/109547418/c794cd2c-64af-466f-a3e1-f232ef3a19ac)
![sign up](https://github.com/amrogad/xeno-chat-provider-mvvm-firebase/assets/109547418/2bade229-4ff9-425d-bce6-6bd81bf9e361)
![create room](https://github.com/amrogad/xeno-chat-provider-mvvm-firebase/assets/109547418/9cfb91cd-3a1a-4272-97e0-fe1c0b71c7d7)
![chat rooms](https://github.com/amrogad/xeno-chat-provider-mvvm-firebase/assets/109547418/3a6e3493-d0a8-4f37-8959-005da2e0eb9d)
![inside chat](https://github.com/amrogad/xeno-chat-provider-mvvm-firebase/assets/109547418/77b3cff7-6f15-4e5c-b76c-4ace0e781a97)
