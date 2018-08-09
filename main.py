import hy
import main

def run():
    parts = {"head": "O", "torso": "|", "l_arm": "-", "r_arm": "-", "l_leg": "/", "r_leg": "\\"}
    print(main.game_loop({"lives": 6, "word": "hangman".lower(), "guess": [], "body": {}, "parts": parts, "letters": []}))

if __name__ == '__main__':
    run()
    while input('Replay? Y/N: ').lower() == 'y':
        run()
