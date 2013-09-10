HW Template
===

I have to tex my homework for a lot of classes. I generally reuse the same latex
template with minor modifications for each class. (The template was stolen from
when I took 15-150 two or three years ago.) If you want to use this, please do!
You'll need to set the following ENV variables:

    ANDREWID (falls back to USER)
    LEGAL\_NAME (falls back to NAME, and then ANDREWID or USER)

I assume that you go to CMU, in which case your classes have an id that looks
like this: \d{2}-\d{3}, where the first two digits are the department number
and the last three digits are the course number. If they don't, you'll need
to modifiy the script accordingly. (You'll also probably want to change the
email address in the template so that it doesn't end in @andrew.cmu.edu.)

When you run the script, it will produce one or more (more on that later)
files in the current directory. (It will also attempt to parse the course
number out of the current directory, because my CMU stuff is stored in a 
CMU/{department}/{course}/ type directory structure.) The files will look
something like `15451-tinglis-hw1.tex`, and you can get straight to editing.
If you have to turn in different problems separately, you can enter an integer
number of problems on the assignment, and then it will produce a file for each
of those, like `15451-tinglis-hw1.1.tex`, `15451-tinglis-hw1.2.tex`, etc.
