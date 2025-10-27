# notes_app

Solo App

## What those it do?
Loom Link: https://www.loom.com/share/1c5eaf1bee034d46bb8656d225d819b6 
The app stores a list of user-created text notes using 'shared_preferences'.
Each note contains a single string field ('content').

### Storage Choice
I used shared_preferences because it provides easy storae for small notes or to-dos

## How to run
1. Run 'flutter pub get'
2. Launch the app in your emulator or device.
3. Add notes using the text field + “Add” button.
4. Close and reopen the app — data persists automatically.

## Data Format
Notes are saved as a JSON list of objects, for example
[{"listt":"Complete solo app one"},{"list":"practice flutter"}]


