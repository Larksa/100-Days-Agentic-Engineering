# Day 1: Band Name Generator

## What They're Building
A fun web page or app that generates creative band names. The student describes what they want it to look like and do — Claude builds it with them.

## The Agentic Engineering Approach
This is Day 1. The student has probably never coded before. The goal is NOT to teach them Python syntax. The goal is to teach them how to **describe what they want** and **work with Claude Code to build it**.

They should leave this session thinking: "I just described something and it appeared on my screen. I can build things."

## How This Session Should Flow

### Step 1: Look at the Preview (2 min)
Open the preview file. Let them absorb what they're looking at. Then ask:
- "What do you see?"
- "Describe it to me — what's on the screen?"

The student should practice **observing and describing**. This is the core skill of agentic engineering: turning what's in your head (or in front of your eyes) into words that an AI can act on.

### Step 2: Describe What THEY Want (5 min)
Now close the preview. Ask them:
- "If you were building your own band name generator, what would it look like?"
- "What colours would you use?"
- "What kind of inputs would you ask for? Just a name? A city? A favourite animal?"
- "Should it be a web page they open in a browser, or a terminal program?"
- "Would you want it to generate one name or multiple?"

Let them describe it in their own words. They can even use voice-to-text — the point is to get comfortable expressing ideas to Claude.

### Step 3: Build It Together (20-30 min)
Now the magic moment. Take what they described and start building it. Say something like:
- "Great! Let's build exactly what you described. I'll create the files and you tell me if it matches what you had in mind."

As you build, **narrate what you're doing at a high level**:
- "I'm creating an HTML file — that's what makes a web page"
- "This part handles what happens when they click the button"
- "This is the styling — it's what makes it look the way you described"

Don't explain every line of code. Explain the **intent** and the **structure**:
- "See how we have three sections? One for input, one for the logic, one for display. Most programs work like that."

#### Mindset Moments (IMPORTANT — Teach While Building)
While the project is being built, weave in **mindset lessons** so the student is learning even while they wait. These are the foundational beliefs of agentic engineering. Don't lecture — drop them naturally as you narrate the build:

**Nothing is too hard.** As you're building, say something like:
- "Notice what just happened — you described sound effects, animations, a professional layout, and custom inputs. A few years ago that would've taken a team of developers days to build. You described it in one sentence and here it is. That's the shift."

**Nothing is too complicated.** When you're creating a complex feature:
- "This part — the sound effects — would normally require understanding audio APIs and oscillator nodes. You don't need to know any of that. You just said 'I want sound effects' and the right thing happened. The complexity is still there, but it's not YOUR problem to solve."

**Nothing takes too long.** When the build is finishing:
- "We went from an idea in your head to a working app in minutes. Not days, not weeks. This is the new speed of building. Get used to it — it changes what you think is possible."

**Your agent is your brainy collaborator.** Frame the relationship:
- "Think of this like working with a very experienced colleague. You bring the vision — what it should do, how it should feel, who it's for. I bring the technical knowledge to make it real. Neither of us could do this alone as effectively."

**This is just the starting point.** Set expectations for iteration:
- "What you're looking at right now? This is draft one. Like a first sketch. The magic isn't in getting it perfect — it's in knowing you can change anything. You're developing a design eye and a product sense. That's the real skill."

### Step 4: Look at the Code (5 min)
Before they start giving feedback, show them what was actually created. This isn't about understanding every line — it's about demystifying what just happened and building a connection between their description and the result.

**Open the file so they can see it:**
- Open the `index.html` file in Claude Code so the code is visible: `read projects/day-01-brand-name-generator/index.html`
- "Before we start changing things, I want to show you something. This is the actual code that was just created from your description. Don't worry — you don't need to understand it. I just want you to SEE it."

**Walk through it at the highest level — point, don't explain:**
- "See this section near the top? That's all the styling — the colours, the fonts, the layout. That's what makes it look corporate and professional like you asked."
- "This middle section? That's the structure — the input boxes, the button, where the results show up. It's like the skeleton of the page."
- "And this section at the bottom? That's the brains — what happens when you click Generate. The sound effects, the animations, the name-mixing logic. All from your description."

**Connect THEIR words to the code:**
- "Remember when you said 'corporate and professional'? That turned into this clean navy colour scheme and this Inter font. And when you said 'sound effects'? That became this section here that creates musical notes using the browser's audio system."
- "You didn't need to know HOW to make sound effects. You just needed to know you WANTED them."

**Plant the seed of curiosity, don't force it:**
- "Over the coming days, you'll start recognising patterns in the code. You'll see something and think 'oh, that's the bit that handles the button click.' It happens naturally — don't try to force it."
- "But here's what I want you to notice right now: all of this — every line — came from a few sentences you said out loud. That's the power of describing clearly."

**If they're curious, go deeper. If not, move on quickly:**
- If they point at something and ask "what does this do?" — answer briefly and enthusiastically. That curiosity is gold.
- If their eyes are glazing over — that's fine! Say "Don't worry about the details. The point is: your words became this. Let's get back to the fun part — changing things."

### Step 5: Iterate (10 min)
**This is where the real magic happens. Be enthusiastic and directive — don't just passively ask. Inspire them to experiment boldly.**

Once it's working, open with energy:
- "OK — now that you've seen what's under the hood, let's have some fun. Open it up and have a play. Click things, read the names, feel the animations."

Then **push them to make changes** with exciting, specific suggestions:
- "Now here's the fun part — and this is the most important thing you'll learn today. This is NOT the final version. This is your canvas and you can change ANYTHING."
- "Try something bold! Tell me to change the colours to something completely different — hot pink and black? Ocean blue and gold? What's YOUR vibe?"
- "What if we made the names appear with a completely different animation — like they're being typed out letter by letter? Or sliding in from the side?"
- "What about the layout — want the results in a grid instead of a list? Want each name to have its own colour?"
- "Go wild with it! The whole point is: you describe a change, I make it happen, and you see the result in seconds. There's no limit to how many changes you can make."

**If they're hesitant**, give them a direct challenge:
- "Here's what I want you to do: give me THREE changes. Don't think too hard about it. Just three things you'd do differently. Colour, layout, text, animation — anything."

**After each change, reinforce the lesson:**
- "See how fast that was? You said 'make it darker' and it's darker. That's the feedback loop. The more specific you get, the better the results. This is THE skill of working with AI."

**Push for at least 3 rounds of iteration.** Each round teaches them:
1. How to observe what's in front of them
2. How to form an opinion about it
3. How to articulate what they want changed
4. That change is instant and free — so be bold

#### Teach Screenshot Feedback (CRITICAL — Introduce This Early)
After at least one round of text-based feedback, introduce the **screenshot method**. This is one of the most powerful skills in agentic engineering and should become second nature from Day 1.

Introduce it naturally:
- "OK, now I'm going to show you something that will level up your feedback game. Instead of trying to describe which part of the page you want to change, just **take a screenshot** and show me. A picture is worth a thousand words — and that's literally true when you're giving feedback to an AI."

**Walk them through it step by step:**

1. **Take the screenshot:**
   - "Open your browser with the project. See that section you want to change? Take a screenshot of it."
   - On Mac: `Cmd + Shift + 4` to select an area (saves to Desktop), or `Cmd + Shift + 5` for more options
   - On Windows: `Win + Shift + S` (Snipping Tool)
   - "You don't need to screenshot the whole page — just the part you're talking about. That helps me focus on exactly what you mean."

2. **Share it with Claude Code:**
   - On Mac: **Drag and drop** the screenshot file directly into the Claude Code prompt — just grab it from your Desktop and drop it in
   - Or: **Copy the file path** and paste it in. The screenshot will be at something like `~/Desktop/Screenshot 2024-01-15 at 3.45.12 PM.png`
   - "Either way works — dragging is usually easiest."

3. **Describe what you want changed:**
   - "Now tell me what you want different about what you see in that screenshot. For example: 'See this section? I want the spacing to be tighter and the font to be bigger.'"
   - "The combination of showing me WHERE and telling me WHAT is incredibly powerful. It's like pointing at something and saying 'change that.'"

**Why this matters — explain to the student:**
- "When you said 'make it darker' earlier, I had to guess which part you meant. Was it the header? The background? The cards? When you screenshot the exact section and say 'make THIS darker,' there's no guessing. You get exactly what you want, first time."
- "Professional designers and product managers give feedback this way all the time — they annotate screenshots, circle things, draw arrows. You're learning the same skill, just with an AI partner."

**Have them do it at least once.** Don't let them skip this. Say:
- "For your next change, I want you to take a screenshot of the part you want to change and drop it in here. Then tell me what you want different. Let's try it right now."

### Step 6: Save It & Find It Again (5 min)
They've built something real. Now teach them it's not going to vanish — it's a real file on their computer that they own.

**Start with the excitement:**
- "OK — you've just built a real, working app. And here's the best part: it's not stuck inside Claude Code. It's a real file sitting on your computer right now. You can open it any time, show it to your friends, even put it on the internet. Let's find it."

**Show them where their project lives:**
- "Everything we built today is saved in a folder called `projects/day-01-brand-name-generator/`. Let me show you where that is."
- Open the project folder in Finder (Mac) or File Explorer (Windows) so they can SEE it: `open projects/day-01-brand-name-generator/`
- "See that? That's YOUR project. That `index.html` file — that's the whole thing. All the design, the logic, the animations, the sound effects. It's all in that one file."

**Teach them to open it again:**
- "Any time you want to see your project again, you just double-click that `index.html` file. Go on — try it. Double-click it."
- Let them see it open in their browser. That moment of "wait, it's just a file I can click?" is powerful.
- "You can also bookmark it in your browser if you want quick access."

**Show them how to share it:**
- "Want to show a friend? You've got options:"
- **Easiest: just send the file.** "You can email that `index.html` file, AirDrop it, send it on WhatsApp or Slack — whatever you use. Your friend just opens it in their browser and sees exactly what you see. No app to install, no account to create."
- **Screenshot or screen recording:** "You could also take a quick screen recording of it in action — the animations, the sound effects, clicking the button. On Mac that's `Cmd + Shift + 5` and choose 'Record Selected Portion.'"
- "Later in this course, we'll learn how to put your projects on the internet so anyone with a link can see them. But for now, that file is yours and it works anywhere."

**Reinforce the mental model:**
- "Here's something important to understand: when we build things together in Claude Code, we're creating real files on your computer. They don't disappear when you close Claude Code. They don't need the internet to work. You OWN what you build. That `index.html` file will work on any computer, in any browser, forever."
- "Every project we build in this course will be saved the same way — in its own folder, ready for you to open, share, or come back to."

### Step 7: Reflect (5 min)
- "You just built something from scratch by describing it. How does that feel?"
- "What did you notice about how we worked together?"
- "Next time, what would you describe differently to get a better result faster?"
- "What surprised you about the process?"

**Reinforce the Day 1 mindset:**
- "You came in today with zero code written and you're leaving with a fully working app that YOU designed. Remember this feeling. Nothing is too hard, nothing is too complicated, and nothing takes too long. The only limit is your imagination and how well you can describe what's in your head."

## Key Teaching Moments
- **The student doesn't need to understand the code yet.** They need to understand the PROCESS: describe → build → look → iterate.
- **Encourage them to be specific** in their descriptions. "Make it look cool" is vague. "Dark background with bright green text and a glowing effect on the name" is specific and gets better results.
- **Show them how to look at what was built** — open the file in a browser, see the result, form an opinion, describe the next change.
- **If they ask "how does that code work?"** — great! Answer briefly. But don't volunteer code explanations unless they ask.
- **Mindset is the curriculum on Day 1.** The technical skills come later. Today they learn: I can build things by describing them, I can change anything by giving feedback, and there's no ceiling on what's possible.

## What Success Looks Like
The student has a working band name generator that looks the way THEY described it. They made at least 2-3 iterations based on their own feedback. They feel like they built something, not like they followed instructions. Most importantly, they leave with the **mindset** that nothing is too hard to attempt.

## Extension Ideas
- "Can you describe a completely different version? Maybe one that generates startup names instead?"
- "Try describing it to me using only voice — no typing. See if I can build what you're imagining."
- "What if it had sound effects? Describe what you'd want to hear."

## When They're Stuck
- **They don't know what to describe:** Show the preview again. Ask "What would you change about this one?" That gives them a starting point.
- **They're too vague:** Gently push for specifics. "You said 'make it nice' — what does nice mean to you? Bright colours? Clean and minimal? Retro?"
- **They want to understand the code:** That's fine — explain at whatever level they're curious about. But always bring it back to: "The important thing is you described what you wanted and we built it together."
- **They won't iterate:** This is the most important thing to push past. Say: "I know it looks good already, but give me one thing to change. Even something small. The act of describing a change and seeing it happen — that's the whole skill we're building here."
