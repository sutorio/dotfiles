# Dotfiles

## Notes

- I am currently using Manjaro on WSL2, and at the minute this is highly Linux-based with no consideration that it is running on a Windows host machine.
- I was running on OSX, and expect to do so again for work soon, so there needs to be OS-specific config.
- Things that are machine specific: git config, chezmoi config, anything that exposes secrets. So there needs to be a `.gitignore` in `$HOME` that gives me basic protections.
- I want a base setup script that installs prerequisites: these are generally going to be `asdf` (then in turn running it), any tool dependencies required for the asdf plugins I use, any key tooling for the OS (is make present? is man? is git?), any standard tooling I use a lot (`fd`, `ripgrep`, `bat` _&c_).

## Dotfile management

[`chezmoi`]() is used to manage these files.

Originally, I had used the manual bare git repository method [detailed here](https://www.atlassian.com/git/tutorials/dotfiles) (also, [this is a nice reference](https://www.atlassian.com/git/tutorials/dotfiles) as well, adding scripting to the bare git method).

That had some drawbacks, and got somewhat fiddly. Hence use of a tool to handle the annoyances.

Chezmoi works by syncing dotfiles to a folder (`~/.local/share/chezmoi`). That folder is the one that is committed. It seems to _essentially_ be an ergonomic wrapper around the bare git repo method, with a load of useful conveniences thrown in.

Docs seem to be really good, seems to be very well maintained, so see how it goes.

For my reference:

### Initial [cold] setup

1. Install chezmoi -- it is a Python application, but is distributed as a binary, so just install using whichever package manager is being used on the OS; in my case it's `pamac install chezmoi`
2. Initialise chezmoi, creating a 
3. Add the dotfiles/etc required via `chezmoi add ~/.MY_IMPORTANT_CONFIG`. Works for folders, works for files, all good (TODO: does it respect .gitignore files?).
4. This will copy the files to the chezmoi folder. If they are dot-prefixed, then chezmoi will remove the period and prepend the literal string `dot_` to the copied file.
5. When ready, open a shell in the source directory using `chezmoi cd`.
6. It is already a git repo, so can just `git add -A` then `git commit -m "some explanatory message"`.
7. Push it to the remote, then exit the shell using `chezmoi exit`

### Day-to-day

1. For *new* dotfiles, just run through the above process, steps 3-7.
2. For *existing* dotfiles, I just want to keep everything in sync with the minimum of fuss.
3. For changes made to the repo that are not reflected on the current machine, run `chezmoi update`.
4. Finally,. for changes made on the current machine that are not yet pushed, well, I want that automated:

So there is a `~/.config/chezmoi/chezmoi.toml` file with git settings to autoCommit (with an additional setting to prompt for a message?) & autoPush. Still need to `chezmoi add`, but at least can keep things semi-auto.

> TODO: full automate the local changes side of things, going to forget stuff otherwise.

### New machine

Checkout the repo on a new machine, diff the expected changes, then apply them if you're happy:

```
chezmoi --init --apply https://github.com/sutorio/dotfiles.git
```

> TODO: set up a template for the `chezmoi.toml` file as well - see https://www.chezmoi.io/user-guide/setup/#create-a-config-file-on-a-new-machine-automatically
>       this is very, very much machine specific, but also important it's there as time goes on.

