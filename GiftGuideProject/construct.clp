(defrule system-banner
  =>
  (assert (display "What is the gender of the person receiving your gift?")
                    (valid-answers "Male" "Female")
                    (fact-name gender)))

(defrule question-male
  (gender Male)
  =>
  (assert (display "This is gonna be hard. Guys don't buy gifts for other guys. Why are you buying him a gift?")
                    (valid-answers "Dad" "Brother" "Crazy Uncle Charlie" "Co-worker" "Father-in-law")
                    (fact-name person)))

(defrule question-dad
  (gender Male)
  (person Dad)
  =>
  (assert (display "What did you get him last holiday season?")
                    (valid-answers "A tie" "Power tools" "A mug that says World's #1 Dad" "A new grill")
                    (fact-name gift)))

(defrule question-tie
  (gender Male)
  (person Dad)
  (gift A tie)
  =>
  (assert (display "How original... how many ties does he own now?")
                    (valid-answers ">75" "<75 but >30")
                    (fact-name ties-number)))

(defrule question-power-tools
  (gender Male)
  (person Dad)
  (gift Power tools)
  =>
  (assert (display "So Dad is pretty handy huh ?")
                    (valid-answers "Yes" "No, he just thinks he is. In reality, he just ends up making things worst when he tries to fix them.")
                    (fact-name response-tools)))

(defrule question-mug
  (gender Male)
  (person Dad)
  (gift A mug that says World's #1 Dad)
  =>
  (assert (display "And does he actually use this mug?")
                    (valid-answers "Yes, that's the problem. He takes it everywhere and it's super embarrassing" "No, I don't know why I even bother getting him gifts if he's not going to use them anyway")
                    (fact-name response-mug)))

(defrule question-grill
  (gender Male)
  (person Dad)
  (gift A new grill)
  =>
  (assert (display "Was he so excited to test out the new grill right away that almost started the house on fire?")
                    (valid-answers "Yes, that is exactly what happened" "No... he actually did start the house on fire")
                    (fact-name response-grill)))

(defrule question-brother
  (gender Male)
  (person Brother)
  =>
  (assert (valid-answers "Younger" "Older")
           (fact-name brother-age)))

(defrule question-younger
  (gender Male)
  (person Brother)
  (brother-age Younger)
  =>
  (assert (display "So you probably picked on him when you were growing up?")
                    (valid-answers "Yeah, sure did" "No, never!")
                    (fact-name response-you-picked)))

(defrule question-older
  (gender Male)
  (person Brother)
  (brother-age Older)
  =>
  (assert (display "So he probably picked on you when you were growing up?")
                    (valid-answers "He was a master of the noogie." "No, never!")
                    (fact-name response-he-picked)))

(defrule question-crazy-uncle-charlie
  (gender Male)
  (person Crazy Uncle Charlie)
  =>
  (assert (display "Ah, yes Crazy Uncle Charlie... When was the last time you saw him?")
                    (valid-answers "Last Christmas- He drank too much eggnog and passed out on the couch while watching basketball." "A couple weeks ago at Thanksgiving- He ate too much turkey and passed out on the couch while watching football." "Last week when he invited himself over then passed out on couch while watching 'Scandal'.")
                    (fact-name uncle-when)))

(defrule question-co-worker-male
  (gender Male)
  (person Co-worker)
  =>
  (assert (display "Is this person your boss?")
                    (valid-answers "Yes" "No")
                    (fact-name boss)))

(defrule question-co-worker-male-yes
  (gender Male)
  (person Co-worker)
  (boss Yes)
  =>
  (assert (display "Do you like him?")
                    (valid-answers "Yes" "No")
                    (fact-name like-boss)))

(defrule question-female
  (gender Female)
  =>
  (assert (display "Let's face it, you are in trouble. Why are you buying her a gift?")
                    (valid-answers "Wife" "Girlfriend" "Mom" "Mother-in-law" "Sister" "Co-worker")
                    (fact-name person)))

(defrule question-girlfriend
  (gender Female)
  (person Girlfriend)
  =>
  (assert (display "Is she a Brewers fan?")
                    (valid-answers "Yes" "Not yet")
                    (fact-name girlfriend-brewers)))

(defrule question-wife
  (gender Female)
  (person Wife)
  =>
  (assert (display "Is she a Brewers fan?")
                    (valid-answers "Yes" "Not yet")
                    (fact-name wife-brewers)))

(defrule question-wife-no
  (gender Female)
  (person Wife)
  (wife-brewers Not yet)
  =>
  (assert (display "That's unfortunate, but she'll come around. Have you considered buying her clothes?")
                    (valid-answers "Yes" "No")
                    (fact-name wife-clothes)))

(defrule question-wife-no-yes
  (gender Female)
  (person Wife)
  (wife-brewers Not yet)
  (wife-clothes Yes)
  =>
  (assert (display "Really? You should know by now that no woman actually wants a man picking out her clothes. Do you even know her size?")
                    (valid-answers "Sure. I'm a size 36 so she's probably like a 32" "Not a Chance.")
                    (fact-name wife-size)))

(defrule question-mom
  (gender Female)
  (person Mom)
  =>
  (assert (display "Is she a Brewers fan?")
                    (valid-answers "Yes" "She's not really in to sports")
                    (fact-name mom-brewers)))

(defrule question-mom-no
  (gender Female)
  (or (and (person Mom) (mom-brewers She's not really in to sports)) (and (person Mother-in-law) (next response-right)))
  =>
  (assert (display "What else does she like?")
                    (valid-answers "A fun day/night out" "Quality time with family/friends" "Delicious food and drink" "Collecting holiday ornaments")
                    (fact-name mom-gift)))

(defrule question-mother
  (gender Female)
  (person Mother-in-law)
  =>
  (assert (display "What does she really want for the holidays?")
                    (valid-answers "Fruit cake" "A 'Home is Where the Heart Is' Plaque" "Hand-knit sweater for help lap dog" "One of those creepy posters where the kids are dressed up like adults")
                    (fact-name mother-in-law-gift)))

(defrule question-mother-cake
  (gender Female)
  (person Mother-in-law)
  (mother-in-law-gift Fruit cake)
  =>
  (assert (display "Have you ever actually tried fruitcake? Nobody likes that stuff.")
            (difficult-decision left-dec right-dec)))

(defrule question-mother-home
  (gender Female)
  (person Mother-in-law)
  (mother-in-law-gift A 'Home is Where the Heart Is' Plaque)
  =>
  (assert (display "As if she doesn't already have enough of those...")
            (difficult-decision left-dec right-dec)))

(defrule question-mother-sweater
  (gender Female)
  (person Mother-in-law)
  (mother-in-law-gift Hand-knit sweater for help lap dog)
  =>
  (assert (display "We both know how much you hate hand-knit sweaters. And lap dogs. And dogs in human clothes.")
            (difficult-decision left-dec right-dec)))

(defrule question-mother-poster
  (gender Female)
  (person Mother-in-law)
  (mother-in-law-gift One of those creepy posters where the kids are dressed up like adults)
  =>
  (assert (display "Do you really want to endure the strange looks you will get when you buy this?")
            (difficult-decision left-dec right-dec)))

(defrule question-mother-left
  (gender Female)
  (person Mother-in-law)
  (or (mother-in-law-gift Fruit cake) (mother-in-law-gift A 'Home is Where the Heart Is' Plaque) (mother-in-law-gift Hand-knit sweater for help lap dog) (mother-in-law-gift One of those creepy posters where the kids are dressed up like adults))
  (mother-in-law-gift left-dec)

  =>
  (assert (display "For just a minute, forget about what she wants...")
            (fact-name next)
            (decision response-left)))

(defrule question-mother-right
  (gender Female)
  (person Mother-in-law)
  (mother-in-law-gift right-dec)
  =>
  (assert (display "You'd better keep thinking... She's still mad at you for running Christmas last year.")
            (fact-name next)
            (decision response-right)))

(defrule question-sister
  (gender Female)
  (person Sister)
  =>
  (assert (valid-answers "Older" "Younger")
           (fact-name sister-age)))

(defrule question-sister-younger
  (gender Female)
  (person Sister)
  (sister-age Younger)
  =>
  (assert (display "Was she spoiled as a child?")
                    (valid-answers "No, she was adorable!" "Got everything she ever wanted. One Christmas, she got a pony. The best thing I got that year was a pack of new socks.")
                    (fact-name sister-spoiled)))

(defrule question-spoiled-yes
  (gender Female)
  (person Sister)
  (sister-age Younger)
  (sister-spoiled Got everything she ever wanted. One Christmas, she got a pony. The best thing I got that year was a pack of new socks.)
  =>
  (assert (display "You're still dwelling on this?")
                    (valid-answers "Time to start fresh 'Tis the season for giving and forgiving!")
                    (fact-name sister-forgive)))

(defrule question-co-worker-female
  (gender Female)
  (person Co-worker)
  =>
  (assert (display "Do you know anything about this person?")
                    (valid-answers "I think she has a cat." "Nope. Drew her name out of a hat for Secret Santa.")
                    (fact-name cat-or-santa)))




(defrule response-dad-tie-75
  (gender Male)
  (person Dad)
  (gift A tie)
  (ties-number >75)
  =>
  (assert (display "I think you can skip a year of the ties. How about this year you get him a gift that won't end up thrown in the back of the closet? Like a Holiday 4-Pack.")
            (state final)))

(defrule response-dad-tie-30
  (gender Male)
  (person Dad)
  (gift A tie)
  (ties-number <75 but >30)
  =>
  (assert (display "I know you are worried that Dad needs another tie, but if he can go an entire month without wearing the same tie twice I think he is ok on ties. \n Let, go with a Holiday 4-Pack this year.")
            (state final)))

(defrule response-dad-tools-yes
  (gender Male)
  (person Dad)
  (gift Power tools)
  (response-tools Yes)
  =>
  (assert (display "Then he already has all the tools he needs. Get him a Holiday 4-Pack instead.")
            (state final)))

(defrule response-dad-tools-no
  (gender Male)
  (person Dad)
  (gift Power tools)
  (response-tools No, he just thinks he is. In reality, he just ends up making things worst when he tries to fix them.)
  =>
  (assert (display "Stop enabling this behavior and get him a Holiday 4-Pack this year.")
            (state final)))

(defrule response-dad-mug-yes
  (gender Male)
  (person Dad)
  (gift A mug that says World's #1 Dad)
  (response-mug Yes, that's the problem. He takes it everywhere and it's super embarrassing)
  =>
  (assert (display "Here's what you do: 'accidentally' drop the mug and get him a Holiday 4-Pack to make up for your clumsiness.")
            (state final)))

(defrule response-dad-mug-no
  (gender Male)
  (person Dad)
  (gift A mug that says World's #1 Dad)
  (response-mug No, I don't know why I even bother getting him gifts if he's not going to use them anyway)
  =>
  (assert (display "Then get him a gift he will actually use... like a Holiday 4-Pack")
            (state final)))

(defrule response-dad-grill
  (gender Male)
  (person Dad)
  (gift A new grill)
  (or (response-grill Yes, that is exactly what happened) (response-grill No... he actually did start the house on fire))
  =>
  (assert (display "For the rest of the family's safety you need to get him a gift that is not a fire hazard... like a Holiday 4-pack")
            (state final)))

(defrule response-brother-younger-yeah
  (gender Male)
  (person Brother)
  (brother-age Younger)
  (response-you-picked Yeah, sure did)
  =>
  (assert (display "Show him how much you've grown and make amends for your adolescent bullying by getting him a Holiday 4-Pack.")
            (state final)))

(defrule response-brother-younger-no
  (gender Male)
  (person Brother)
  (brother-age Younger)
  (response-you-picked No, never!)
  =>
  (assert (display "You are the best older brother ever! You have probably already bought him multiple Holiday 4-Packs.")
            (state final)))

(defrule response-brother-older-master
  (gender Male)
  (person Brother)
  (brother-age Older)
  (response-he-picked He was a master of the noogie.)
  =>
  (assert (display "Here's what you do: Get him a Holiday 4-Pack, then get yourself a 10-Pack and passive-aggressively demonstrate your newfound superiority.")
            (state final)))

(defrule response-brother-older-no
  (gender Male)
  (person Brother)
  (brother-age Older)
  (response-he-picked No, never!)
  =>
  (assert (display "You have the best older brother ever! Get a pair of Holiday 4-Packs and enjoy some quality time with this great guy.")
            (state final)))

(defrule response-uncle
  (gender Male)
  (person Crazy Uncle Charlie)
  (or (uncle-when Last Christmas- He drank too much eggnog and passed out on the couch while watching basketball.)
    (uncle-when A couple weeks ago at Thanksgiving- He ate too much turkey and passed out on the couch while watching football.)
    (uncle-when Last week when he invited himself over then passed out on couch while watching 'Scandal'.))
  =>
  (assert (display "Get him a Holiday 4-Pack and get him off your couch!")
            (state final)))

(defrule response-worker-no
  (gender Male)
  (person Co-worker)
  (boss No)
  =>
  (assert (display "No need to buy this person a gift. Take the money you would have spent and put it towards a Holiday 4+-Pack of your own")
            (state final)))

(defrule response-worker-yes-no
  (gender Male)
  (person Co-worker)
  (boss Yes)
  (like-boss No)
  =>
  (assert (display "Get him a Holiday 4-Pack consisting of 4 weekday, day games and enjoy the extra time he is out of the office.")
            (state final)))

(defrule response-worker-yes-yes
  (gender Male)
  (person Co-worker)
  (boss Yes)
  (like-boss Yes)
  =>
  (assert (display "Get him a Holiday 4-Pack. Can you say 'promotion'?")
            (state final)))

(defrule response-father-in-law
  (gender Male)
  (person Father-in-law)
  =>
  (assert (display "Face it, you'll never be good enough for his daughter. Your best chance of redeeming yourself would be to get him a Holiday 4-Pack.")
            (state final)))


(defrule response-wife-yes
  (gender Female)
  (person Wife)
  (wife-brewers Yes)
  =>
  (assert (display "You have found yourself a true like partner. Get her a Holiday 4-Pack as a sign of your gratitude.")
            (state final)))

(defrule response-wife-no-clothes
  (gender Female)
  (person Wife)
  (wife-brewers Not yet)
  (wife-clothes No)
  =>
  (assert (display "Good decision. You know your limitations. Get her a Holiday 4-Pack and spend your next few weekends watching college football instead of braving shopping malls only to get her a shirt she will return anyway.")
            (state final)))

(defrule response-wife-yes-clothes-36
  (gender Female)
  (person Wife)
  (wife-brewers Not yet)
  (wife-clothes Yes)
  (wife-size Sure. I'm a size 36 so she's probably like a 32)
  =>
  (assert (display "Oh boy, just get her the Holiday 4-Pack. trust us, you'll thanks us later.")
            (state final)))

(defrule response-wife-yes-clothes-not
  (gender Female)
  (person Wife)
  (wife-brewers Not yet)
  (wife-clothes Yes)
  (wife-size Not a Chance.)
  =>
  (assert (display "Time to pull the plug on this little experiment and just get her a Holiday 4-Pack.")
            (state final)))

(defrule response-girlfriend-yes
  (gender Female)
  (person Girlfriend)
  (girlfriend-brewers Yes)
  =>
  (assert (display "Nice, Bro! Get her a Holiday 4-Pack to make sure you don't screw this up.")
            (state final)))

(defrule response-girlfriend-no
  (gender Female)
  (person Girlfriend)
  (girlfriend-brewers Not yet)
  =>
  (assert (display "Dup her. But first give her a Holiday 4-Pack to soften the blow.")
            (state final)))

(defrule response-mom-yes
  (gender Female)
  (person Mom)
  (mom-brewers Yes)
  =>
  (assert (display "Obviously you got your brains from your mother. Earn the title of 'favorite child' by getting her a Holiday 4-Pack.")
            (state final)))

(defrule response-mom-gift
  (gender Female)
  (or (person Mom) (person Mother-in-law))
  (or (mom-gift A fun day/night out) (mom-gift Quality time with family/friends) (mom-gift Delicious food and drink))
  =>
  (assert (display "Well that was easy... Get her a Holiday 4-Pack. She can enjoy all of those things at Miller Park.")
            (state final)))

(defrule response-mother-gift-free
  (gender Female)
  (or (person Mom) (person Mother-in-law))
  (mom-gift Collecting holiday ornaments)
  =>
  (assert (display "Perfect! You get a free Bernie Brewer with every pair of Holiday 4-Packs you buy.")
            (state final)))

(defrule response-mother-left
  (gender Female)
  (person Mother-in-law)
  (mother-in-law-gift left-dec)
  (next response-left)
  =>
  (assert (display "AH HA! Get ger a gift you will not be ashamed to buy- like a Holiday 4-Pack.")
        (state final)))

(defrule response-sister-older
  (gender Female)
  (person Sister)
  (sister-age Older)
  =>
  (assert (display "The woman probably changed your diapers when you were a baby. You owe her BUG TIME. Get her a Holiday 4-Pack.")
            (state final)))

(defrule response-sister-younger
  (gender Female)
  (person Sister)
  (sister-age Younger)
  (or (sister-spoiled No, she was adorable!) (sister-forgive Time to start fresh 'Tis the season for giving and forgiving!))
  =>
  (assert (display "You know you can't wait to see her face light up when she opens that Holiday 4-Pack. Just think of the memories you'll make.")
            (state final)))

(defrule response-co-worker-cat
  (gender Female)
  (person Co-worker)
  (cat-or-santa I think she has a cat.)
  =>
  (assert (display "You could get her a cat toy... Of course, then she will know that you think she is the crazy cat lady. A Holiday 4-Pack is safer.")
            (state final)))

 (defrule response-co-worker-santa
  (gender Female)
  (person Co-worker)
  (cat-or-santa Nope. Drew her name out of a hat for Secret Santa.)
  =>
  (assert (display "Get her a Holiday 4-Pack. You can never go wrong with that")
            (state final)))