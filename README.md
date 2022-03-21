# wordle_stata

Program ``wordle_stata`` was designed to replicate Josh Wardle's  [``Wordle``](https://www.powerlanguage.co.uk/wordle/) game. I used Prof. Donald E. Knuth's list of [five-letter words](https://www-cs-faculty.stanford.edu/~knuth/sgb-words.txt) as the input of the program. 

## How to play:

Guess the valid five-letter word in six tries <br/>
<font color='red'>red :</font> not in the word <br/>
<font color='yellow'>yellow :</font> in the word but wrong spot <br/>
<font color='green'>green :</font> in the word and correct spot 

## Note:

When you see the notification: ``<run do-file again to restart game>`` <br/>
You need to restart game by running the command: <br/>
``do wordle_stata.do``

## Example:
``wordle_stata smile`` <br/>
``wordle_stata stone`` <br/>
``wordle_stata storm`` <br/>
``wordle_stata stomp`` <br/>

**win**
![image](https://user-images.githubusercontent.com/60907709/159275457-f2f11b67-e724-4d32-aee8-f4d38bf32862.png)

**lose**
![image](https://user-images.githubusercontent.com/60907709/159276467-f7374615-ad0a-4bed-9409-fb8defab8f73.png)

