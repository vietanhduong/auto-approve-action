# Auto Approve Pull Request Action

Auto Approve Pull Requests following **path** and **username** similar GitHub's `CODEOWNERS`.

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: vietanhduong/auto-approve-action@main
    with:
      github-token: ${{ secrets.GH_PAT }} # BOTs Token
      pr-number: "1"
      comment-body: |
        # Auto Approved
        ## This PR has been approved by the auto-approve-action
```

### `AUTOAPPROVE` file

You must provide the `AUTOAPPROVE` file in the repository root or in the `.github` directory. The `AUTOAPPROVE` file has the similar syntax with the GitHub's `CODEOWNERS` file.

```
# Global rule
* @vietanhduong

# Wildcard rule
path/to/* @user1

# Specified rule
path/to/user2 @user2
```
