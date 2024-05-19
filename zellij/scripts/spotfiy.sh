#!/bin/zsh

cecho(){
    bold=$(tput bold)
    green=$(tput setaf 2)
    reset=$(tput sgr0)
    echo $bold$green"$1"$reset
}

isSpotifyRunning() {
    if [ "$(osascript -e 'application "Spotify" is running')" = "false" ]; then
        return 1
    else
        return 0
    fi
}

showArtist() {
    echo $(osascript -e 'tell application "Spotify" to artist of current track as string')
}

showAlbum() {
    echo $(osascript -e 'tell application "Spotify" to album of current track as string')
}

showTrack() {
    echo $(osascript -e 'tell application "Spotify" to name of current track as string')
}

showState() {
    echo $(osascript -e 'tell application "Spotify" to player state as string')
}

showDuration() {
    echo $(osascript -e 'tell application "Spotify"
            set durSec to (duration of current track / 1000) as text
            set tM to (round (durSec / 60) rounding down) as text
            if length of ((durSec mod 60 div 1) as text) is greater than 1 then
                set tS to (durSec mod 60 div 1) as text
            else
                set tS to ("0" & (durSec mod 60 div 1)) as text
            end if
            set myTime to tM as text & ":" & tS as text
            end tell
            return myTime')
}

getDurationSeconds() {
    echo $(osascript -e 'tell application "Spotify" to (duration of current track / 1000) as integer')
}

showPosition() {
    echo $(osascript -e 'tell application "Spotify"
            set pos to player position
            set nM to (round (pos / 60) rounding down) as text
            if length of ((round (pos mod 60) rounding down) as text) is greater than 1 then
                set nS to (round (pos mod 60) rounding down) as text
            else
                set nS to ("0" & (round (pos mod 60) rounding down)) as text
            end if
            set nowAt to nM as text & ":" & nS as text
            end tell
            return nowAt')
}

getPositionSeconds() {
    echo $(osascript -e 'tell application "Spotify" to player position as integer')
}

showProgress() {
    duration=$(getDurationSeconds)
    position=$(getPositionSeconds)
    progress=$(echo "scale=4; $position / $duration" | bc)

    if (( $(echo "$progress >= 0.935" | bc -l) )); then
        echo "██"
    elif (( $(echo "$progress >= 0.875" | bc -l) )); then
        echo "█▉"
    elif (( $(echo "$progress >= 0.75" | bc -l) )); then
        echo "█▊"
    elif (( $(echo "$progress >= 0.625" | bc -l) )); then
        echo "█▋"
    elif (( $(echo "$progress >= 0.5" | bc -l) )); then
        echo "█▌"
    elif (( $(echo "$progress >= 0.375" | bc -l) )); then
        echo "█▍"
    elif (( $(echo "$progress >= 0.25" | bc -l) )); then
        echo "█▎"
    elif (( $(echo "$progress >= 0.125" | bc -l) )); then
        echo "█▏"
    elif (( $(echo "$progress > 0" | bc -l) )); then
        echo "█ "
    else
        echo "  "
    fi
}

showStatus () {
    if isSpotifyRunning; then
        state=$(showState)
        cecho "Spotify is currently $state."
        duration=$(showDuration)
        position=$(showPosition)
        progress=$(showProgress)

        echo -e $reset"Artist: $(showArtist)\nAlbum: $(showAlbum)\nTrack: $(showTrack)\nPosition: $position / $duration\nProgress: $progress"
    fi
}

showStatusMini() {
    if isSpotifyRunning; then
        progress=$(showProgress)
        artist=$(showArtist)
        track=$(showTrack)
        statusLine="#[fg=#e69875,bg=#4a555b,bold]$progress#[fg=#4a555b,bg=#a7c080,bold] $artist  $track"
        # statusLine="$progress $artist - $track"
        
        # Truncate if longer than 35 characters
        # if [ ${#statusLine} -gt 35 ]; then
        #     statusLine="${statusLine:0:32}..."
        # fi
        if [ ${#statusLine} -gt 90 ]; then # 32 + 58 (the 58 is the length of the color explination)
            statusLine="${statusLine:0:87}..."
        fi
        
        echo $statusLine
    fi
}

# showStatus
showStatusMini
