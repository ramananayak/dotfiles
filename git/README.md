# manage multiple git accounts

Refrence: https://gist.github.com/Jonalogy/54091c98946cfe4f8cdab2bea79430f9

This is my setup for multiple accounts,
each using separate rsa key. It doesn't matter whether it's github, bitbucket, or whatever;
this setup is not touching ssh client config, neither it uses hosts as selectors for configuration.
It uses directory structure instead,and per-dir-subtree configurations.


```bash
$HOME/.gitconfig
[user]
  name = My Public Account Name
  email = my-public-email@public.com

# public github user - IDEA
[includeIf "gitdir:~/idea/"]
  path = ~/idea/.gitconfig

# org-1 user
[includeIf "gitdir:~/idea/org-1/"]
  path = ~/idea/org-1/.gitconfig

# org-2 user
[includeIf "gitdir:~/idea/org-2/"]
  path = ~/idea/org-2/.gitconfig

# public github user - ruby
[includeIf "gitdir:~/rubymine/"]
  path = ~/rubymine/.gitconfig

# org-1 user
[includeIf "gitdir:~/rubymine/org-1/"]
  path = ~/rubymine/org-1/.gitconfig
```

And if I need to override key and user details for some projects, then I keep them in the same dir.
And in that dir I create a ".gitconfig" file, like:

```bash
$HOME/idea/org-1/.gitconfig
[user]
  name = My Org-1 Account Name
  email = my-org1-email@org-1.com

[core]
  sshCommand = "ssh -i ~/.ssh/my_org1_account_id_rsa"
```

If you wan to setup local directory specific username and email then,

```bash
git config --local user.email "name+github@gmail.com"
git config --local user.name "Codegod"
```
