import json                                # this allows python to access the .json file for this program
from difflib import get_close_matches      # this allows the program to provide a suggestion for a potential mispelled word
data = json.load(open("trial_data.json"))  # data is the dictionary of terms in the .json file created

# function that goes through the json file and potentially return the definition
def getDef(word):
    #word = word.lower()             # word is lowercased since nouns are lowercased in the json file
    if word.lower() in data:        # takes care of non proper nouns as first case like rain, ecstatic
        return data[word.lower()]
    elif word.title() in data:      # capitalizes the first letter of the word if the word is a proper noun like Paris
        return data[word.title()]
    elif word.upper() in data:      # the entire word is uppercased, is the word is an acronym like DNA, USA
        return data[word.upper()]
    elif len(get_close_matches(word, data.keys())) > 0: # this is meant to give a suggestion should the word be mispelled
        # should suggest a word that was misspelled
        yn = input("Did you mean %s instead? Enter Y if yes, or N if no: " % get_close_matches(word, data.keys())[0])
        if yn.lower() == "y":   # if the answer is Y then it return the definition of the word suggested
            return data[get_close_matches(word, data.keys())[0]]
        elif yn.lower() == "n": # if the answer is N then the word does not exist in the json file
            return "The word doesn't exist. Double check the spelling"
        else:           # should the input provided is neither Y or N
            return "We did not understand your entry...."
    else:               # should the word fail all test cases provided
        return "The word doesn't exist. Please double check it."

phrase = input("Enter a word: ")
definition = getDef(phrase)
if type(definition) == list:    # prints the definition if the word does exist in the json file
    for word in definition:
        print(word)
else:                           # else it just prints out a user friendly error message
    print(definition)
