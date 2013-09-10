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
