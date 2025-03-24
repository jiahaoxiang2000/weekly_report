# weekly report

The report is to record the things I have done in the past week. It helps me to review my work and make a plan for the next week.
Help me to keep track of my progress and make sure I am on the right track.

## TASKS

- [ ] TODO: change the report font more beautiful.

## Delta

we had push our weekly job on the github. Then we have can automate get the weekly delta report based on the `diff` function on git.
Then use the LLMs to generate the weekly report based on the delta report.

### get delta from `diff`

To get the diff from last week to now, we need to use a date-based approach with git diff rather than just comparing the last commit:

```bash
# Get changes between now and six days ago
git diff --name-only '@{6 days ago}' HEAD

# Or for more detailed changes including content differences
git diff '@{6 days ago}' HEAD
```
