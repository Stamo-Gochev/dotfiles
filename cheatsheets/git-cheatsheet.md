Cherry picking from a different repo:

Here are the steps to add a remote, fetch branches, and cherry-pick a commit

# Cloning a fork
git clone git@github.com:ifad/rest-client.git

# Adding (as "endel") the repo from we want to cherry-pick
git remote add endel git://github.com/endel/rest-client.git

git remote add kendo git@github.com:telerik/kendo.git

# Fetch their branches
git fetch endel

# List their commits
git log endel/master

# Cherry-pick the commit we need
git cherry-pick 97fedac
