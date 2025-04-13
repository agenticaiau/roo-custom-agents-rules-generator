# Changelog

## April 2025

### Fixed Clone of All Roo Indexing Ignores

Modified `apply-rules.sh` to properly copy all entries from the source `.rooindexingignore` file to target projects. Previously, the script was only checking for and adding a single entry (`.roo/templates/`).

**Note:** If you have cloned before and used the generator, be sure to manually update your `.rooindexingignore` to include all entries listed in the template's ignore file.

## March 31, 2025

Big change with this update is the creation of a samples folder with the star trek fictional characters agents, which is more of a fun illustrative (and fun way to work) example.

A more practical serious example is now in place is the modes.json file. Thank you to all feedback from the community - the samples will not be copied over.

## March 30, 2025

Beginning of changelog - prior changes available in commit / merge history - but this will be maintained going forward.

Implemented Custom Agents and add a sample of what agents I use as an example with a fun star trek flair. Not intended for actual use, more for illustrative purposes.

Introduced instructions and rules to help generate your own Agent modes.json.

Vastly improved rule generation to support better change of agent rules working more reliably.

Breaking bug introduced to apply-rules.bat that will be fixed ASAP.

A sample agent select rule for typescript was added, and the git rule has also been converted to agent select and all rules are aligned to the much improved upgraded rule generator conventions.

## Pre March 30, 2025 Important Updates

## Massive Upgrade - Please read for the BEST roo experience to date - this will change everything - March 31, 2025

### Big fix for Agent AutoSelect Rules

Thank you to feedback from the community around this repo and in the roo forums - an idea sparked about the description field that has been verified to be an amazing boost to agent auto selection of rules, becoming almost nearly not flaky - longer descriptions that really clearly tell it what types of scenarios or context it applies to - this was in the last version of this repo hidden away in more detail in the context that was broken by recent roo optimization improvements to only consider the description for rule section! The rule-generating-agent has been updated to support this, integrating what was the context into the description field basically, further optimizing it to where the agent would have to be really dumb to not select it in the right scenario, or much easier to correct it!

All example rules in the repo have been updated - and a new agent select typescript rule example has also been added, that I have tested and have confirmed loads reliably.

### Game Changer Custom Agent Generation Tools and Rule - the future of workflows is multi tab custom agents!

New in the repo - example modes.json file to define your custom agents along with a template and rule to help you create these. The repo no includes in xnotes a custom-agents.md file, an example of what could be used in a prompt to roo to then use the rule and template to generate the modes.json! While not officially used by roo - the file will be similar to what they will release soon, but in the meantime can help you create the roos by giving you the options to enter into the gui to create the custom agents (ensure you enable this current beta feature in the roo settings). As soon as the version comes out to support it in roo, this will be updated so that the rule can add to or update the new format once I have the new version that supports in in the coming weeks. But for now this is the best option, and much better than trying to manually type into the gui's tiny window for custom agent instructions. Check out .roo/modes.json for the custom agents I am using (and still constantly tweaking).

In the future I will start to have less rules - for example I am not using the manual workflow anymore as instead I talk to the proper agent in a tab that basically has the workflow built into their instruction set.

## Important Note V 0.47+

- I have updated the repo to properly add .roo/rules/\* to the .rooindexingignore - without this, you will run into a lot of flakiness when trying to edit or tweak an existing rule or change its type without reindexing the whole project. This will make A BIG difference.
