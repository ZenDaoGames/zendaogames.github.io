---
title: /devblog/ Chopping Trees
---

This week I focused on making decent “tree chopping” for my game- about 13 hours total working on this single feature. I think Valheim has an incredible experience for this, so there’s a lot of inspiration being pulled from there. Of course, it’s my own thing- too!

<blockquote class="twitter-tweet" data-theme="dark"><p lang="en" dir="ltr">Just some looting, equipping, and chopping! <a href="https://twitter.com/hashtag/ScreenshotSaturday?src=hash&amp;ref_src=twsrc%5Etfw">#ScreenshotSaturday</a>!<a href="https://twitter.com/hashtag/indiegamedev?src=hash&amp;ref_src=twsrc%5Etfw">#indiegamedev</a> <a href="https://twitter.com/hashtag/madewithunity?src=hash&amp;ref_src=twsrc%5Etfw">#madewithunity</a> <a href="https://twitter.com/hashtag/Unity?src=hash&amp;ref_src=twsrc%5Etfw">#Unity</a> <a href="https://t.co/NK4RFM7PUh">pic.twitter.com/NK4RFM7PUh</a></p>&mdash; Zen Dao Games (@ZenDaoGames) <a href="https://twitter.com/ZenDaoGames/status/1497797782396018688?ref_src=twsrc%5Etfw">February 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


#### Prototype

The prototype actually came together fairly quick, a couple of hours at most. This was just a cylinder that would fall over when they “died”- but it was a great motivator to keep moving forward. These small milestones are important for me, otherwise I may lose interest because I’m stuck in a rabbit hole without tangible progress to show for it.

I was able to reuse the health system for characters (from Opsive’s UCC), which was awesome. Attacks from weapons (and eventually, tools) worked, health dropped, and an event for OnDeath fired without any special effort on my part. All I needed was a custom script to handle the OnDeath event to disable isKinematic on the RigidBody, give it a slight nudge in the direction of the attack, and watch it fall using the glory of physics. Honestly, this felt so good I spent a bit of time just chopping down cylinders and watching them fall over. TIMBER!

Sidebar: I need to get better at getting screenshots and recordings during development, otherwise I’d have some sweet “in progress” material for you to see.

#### Iteration

After the prototype, it was time to iterate until it was good enough to move on to something else. I had no idea what this meant when I started iterating, but as I made changes I would update my “todo” list with ideas until it finally felt good enough.

![Chopping trees todo list](/assets/posts/{{ page.name | remove: page.ext }}/Chop+down+trees+for+wood.png "Chopping trees todo list")

*Chopping trees todo list.*

Each of these steps took time and iteration on their own. Some of them came together surprisingly quickly, like creating Particle System FX for foliage falling when the tree is chopped down. I thought this would be hard, but a simple cone shape that bursts the leafy material looked great. I just needed a few tweaks to gravity, collision, and size. Done!

Being able to reuse existing systems saved a lot of time, again. Opsive’s UCC offers a Surface Manager for generating sounds, effects, and decals based on impact definitions. I was able to create surface types (wood, grass, dirt) and impact definitions (GiantLand). Joining these two together (GiantLandOnDirt, GiantLandOnGrass, etc…) meant the system would automatically play whatever effects I configured when the collisions happened. 

Except… This Surface Manager expects a RaycastHit object when all I had was Collision. Eventually I teased out some code that calls Physics.RaycastNonAlloc during the collision event to capture the RaycastHit and pass it along. There’s a lot of nuance here I’m skipping over, and working this out took 2-3 hours itself. If you are interested in more details, reach out to me on Twitter.

#### The Biggest Challenge

While there were several challenges in getting this feature where it was “good enough”- the one that sticks with me was tuning the collisions to make sense.

Originally, collisions checked to see if what it hit had health. If so, it would do some damage to it. This includes other trees as well, since they also have health. Trees falling can damage other trees, making them fall as well. The forest can be a scary place. 

DANGER TREES! (Absolutely inspired by Valheim). 

But now even if the player walked over a resting log, they would take damage. It needed nuance.

The first thing I did was introduce force. Now, collisions would only cause damage if there was enough force to justify the damage. The simple calculation was:

    velocity * mass = force

This worked well, until the player would push logs around on the ground and take damage from them. Pushing a log forward shouldn’t hurt you, right? Using the dot product of the direction of the log and the collision point’s normal helped here, along with a threshold for what would be considered inside the “danger zone” (configurable, of course). 

Now we had the nuance we needed:

- Tree can be chopped down and turns into a log
- The log can be chopped in half
- The log halves can be chopped into “wood” material for crafting
- Logs can hurt you, and anything else with health, if in the “danger zone” with enough force
- Sounds play based on the materials that are impacted (wood, grass, dirt, etc…)
- Particle effects make it feel good

Is it perfect? NOPE!

Is it “good enough” to call done so that I can move on to the next feature? YUP!

Thanks for reading.