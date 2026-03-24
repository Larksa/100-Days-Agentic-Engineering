# 100 Days of Agentic Engineering

**Learn to build real things with AI — no coding experience needed**

---

This is a hands-on course where you and an AI partner build 100 real projects together, one per day. You describe what you want, and Claude Code helps you build it. No coding experience required — you'll learn by doing, starting from Day 1.

## What You Need

- A computer (Mac, Windows, or Linux)
- An internet connection
- A Claude subscription (Pro, Team, or Enterprise) — [get one here](https://claude.ai/code)

## Getting Started

### Step 1: Install Claude Code

Visit [claude.ai/code](https://claude.ai/code) and follow the instructions for your computer.

- **Mac:** Follow the installer
- **Windows:** You'll need to install WSL first — [follow this guide](https://learn.microsoft.com/en-us/windows/wsl/install), then install Claude Code inside it. **Important:** Download the course inside WSL (your `~` home directory), not in a Windows folder like `/mnt/c/Users/...`
- **Linux:** Follow the installer

### Step 2: Download This Course

**Option A — The Quick Way (recommended)**

Open your Terminal and paste this command:

```
curl -fsSL https://raw.githubusercontent.com/Larksa/100-Days-Agentic-Engineering/main/setup.sh | bash -s -- --install
```

> **How to open Terminal:**
> - **Mac:** Press `Cmd + Space`, type "Terminal", press Enter
> - **Windows:** Open the Start menu, search for "Ubuntu"
> - **Linux:** Open your terminal application

**Option B — Manual Download**

1. [Click here to download the course](https://github.com/Larksa/100-Days-Agentic-Engineering/releases/latest) (look for the "Source code (zip)" link)
2. Unzip the downloaded file
3. Open Terminal and type these commands, pressing Enter after each:

```
cd Downloads
cd 100-Days-Agentic-Engineering-*
bash setup.sh
```

> **Windows/WSL users:** Move the unzipped folder into your WSL home directory first. In your Ubuntu terminal, type `cd ~` and work from there — not from `/mnt/c/Users/...`.

### Step 3: Start Learning

In your Terminal, make sure you're in the course folder, then type:

```
claude
```

When Claude Code opens, type:

```
day 1
```

That's it — Claude will guide you from here!

## Getting Updates

When new days or improvements are released, open Terminal in your course folder and type:

```
bash update-course.sh
```

Your projects and progress are never affected by updates — only the course materials get refreshed.

## Frequently Asked Questions

**Do I need to know how to code?**

No! This course teaches you to build things by describing what you want. Coding knowledge comes naturally through the process.

**What language will I learn?**

The course starts with web pages (HTML, CSS, JavaScript) so you can see results immediately in your browser. You can ask Claude to use a different language any time.

**How long does each day take?**

Most days take 45 to 90 minutes. There's no timer and no deadline — go at your own pace.

**Do I need to do them in order?**

Recommended but not required. Each day builds on skills from previous days, but if a project catches your eye, feel free to jump ahead.

**What if something goes wrong?**

Tell Claude Code what happened — describe what you see. It's designed to help you troubleshoot. If you're truly stuck, you can always start the day over.

**How do I show my projects to friends?**

Your projects are saved in the `projects/` folder on your computer. You can open them in a browser, send the files to a friend, or take a screen recording. We'll cover sharing in more detail during the course.

## Platform Notes

This course works on Mac, Windows (via WSL), and Linux. All instructions inside the course are given to you by Claude Code directly, so you do not need any other materials.

---

Version 1.0, March 2026 — Created by Andrew Larkey
