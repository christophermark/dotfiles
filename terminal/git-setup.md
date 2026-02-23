## git setup

- [ ] [Create an SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) with a secure passphrase
  - [ ] Register the key with Github [as an authentication key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
  - [ ] Register the key again [as an SSH signing key](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification#ssh-commit-signature-verification)
- [ ] Clone this dotfiles project
    ```
    mkdir ~/dev
    cd ~/dev
    git clone git@github.com:christophermark/dotfiles.git
    ```
- [ ] Copy all dotfiles
    ```
    cp ~/dev/dotfiles/.* ~/
    ```
- [ ] Set your email in `.gitconfig`
- [ ] Check that commits and commit verification works by pushing a change to a private repo
- [ ] Set up `gh`, the [GitHub CLI](https://cli.github.com/)
