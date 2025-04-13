# BMad's Best Practices Roo Custom Agents and Rules Generator

BMad Version: 3.1 (March 30, 2025)
Roo Version: 0.48+

Note from BMad: This repo has become much more successful than I originally envisioned, and I want to thank everyone for the feedback, support, contributions, and also feedback on the youtube channel. I now realize that many are using what I originally thought would be just a way to document some best practices around roo rules and a simple rule that helps generate the rules - all with the intent of creating a separate updated workflow repo and set of documentation. But this has evolved.

With that in mind, going forward after this correction update - any major changes will follow a versioning standard, and upgrade paths or instructions to migrate if you are already using a prior version of rules or workflows whenever there is a significant potentially breaking change - although I will try to avoid that somehow depending on what comes with Roo updates or workflow improvements. Keep in mind most changes are to keep up to date with the constantly evolving Roo IDE and feature release - so there will be continuos changes. Also with that in mind, know that the long game end goal is to build and work in ways that will be less prone to needing to change or flaky as roo makes changes. This is one reason for example that the workflows outlined further on are now evolving to the superior custom agent modes.

The name of the repo has changed to BMad Roo Master Workflow Agent and Rules - this is still the ever evolving same project regarding rules best practices, but its evolving and expanding in features and capability as roo evolves, becoming more and more powerful to meet the needs of the Roo and AI Development community, as this may eventually expand beyond roo.

Please view the [CHANGELOG](./CHANGELOG.md) for important updates and usage announcements.

## Important Updates TL;DR (March 25, 2025)

> 💡 **IDE Setting HIGHLY Suggested:** For best results with rule generation, update your Roo settings by adding:
>
> ```json
> "workbench.editorAssociations": {
>   "*.mdc": "default"
> }
> ```

This prevents UI rendering issues with .mdc files in a custom rules form and ensures proper save functionality, and makes it easier to see what the actual rules look like (specifically around hidden FrontMatter).

## Overview

If you would like to see a [Video Demo and Walkthrough](https://youtu.be/jEhvwYkI-og) start here, please also subscribe for more Roo tutorials all coming real soon!

This template dramatically improves AI workflows in Agent and Custom mode by providing:

1. **Automated Rule Generation:** Create and update rules through natural language requests for all 4 main supported rule types correctly following the required Roo conventions
2. **Automated Custom Agent Generation:** Create and update new custom agents by describing it to the AI, who will then add or update entires in .roo/modes.json
3. **Consistent AI Behavior:** Rules are applied automatically when appropriate or on demand or always depending on which of the 4 rule types are created/exist
4. **Quick Project Setup:** A script that will set up a new project with core rules and workflow, or add the rule generator to an existing project in a non destructive manner to existing roo rules.
5. **Custom Agent Workflow Instructions:** A new guide is COMING SOON along with a new video on how to follow the massively scalable and successful Agent Agile workflow with multiple specialized Custom Agents, that are much safer and more reliable than any full blown single agent being driven by a massive workflow and extensive rules (the previous way of working)
6. **Custom Agent Samples:** This repo contains both a vanilla set of sample custom agents in a defined modes.json file that will get copied over when running the apply-rules script, and also has some more fun character personality based options in the samples folder, which exists for illustration (although can be used just as successfully and with more fun when working with the agent) - these will not copy to the new project folder automatically.

> 💡 **Note:** For a complete guide to the Agile-Roo Workflow system without using custom agents (no longer recommended), see [Agile Workflow Documentation](docs/agile-readme.md).

## Key Concepts Regarding Roo Rules

- Rules use frontmatter with proper YAML format (description, globs, alwaysApply)
- Rules will be generated with explicitly requesting a rule be create, or implied by asking for corrective behavior from the agent
- Rules are enhanced by including both a valid and invalid example to better train the llm
- Short, focused rules (target: 25 lines, maximum: 50 lines)
- Four rule types within an automatically organized subfolder categorization structure
- Rules will be generated in the proper location under .roo/rules/sub-folder - remember though sub folder or not - roo rules must be in the .roo/rules or a subfolder, and must have the extension .mdc.

## Quick Start Options

### A) New Project Setup

Start a new project with the Agile Workflow and Rules Generator:

```bash
# Clone this repository
git clone https://github.com/bmadcode/roo-auto-rules-agile-workflow.git
cd roo-auto-rules-agile-workflow

# Create new project with rules
./apply-rules.sh /path/to/your/project

# Example:
./apply-rules.sh ~/projects/my-project
```

The script creates your project folder (if needed) with all rules, documentation, and configuration files to start with the agile workflow.

### B) Add to Existing Project

Enhance your current project with the rules generator:

```bash
# Clone this repository
git clone https://github.com/bmadcode/roo-auto-rules-agile-workflow.git
cd roo-auto-rules-agile-workflow

# Apply rules to your project
./apply-rules.sh /path/to/your/project
```

The script will:

1. Copy template rules to your project's `.roo/rules/` directory
2. Add workflow documentation
3. Preserve any existing rules

## How Rule Generation Works

```mermaid
graph TD
    subgraph User Actions
        A[User requests rule creation<br>in agent chat] --> B[Agent processes rule request]
        H[User continues<br>development with new rule] --> A
    end

    subgraph Rule Processing
        B --> C[rule-generating-agent monitors<br>for rule creation requests]
        C --> D[Agent determines rule type:<br>Agent, Always, Auto, or Manual]
        D --> E[Agent creates rule with<br>appropriate frontmatter configuration]
        E --> F[Agent categorizes rule<br>and adds to proper subfolder]
        F --> G[Agent responds with<br>rule creation summary]
    end

    subgraph Continuous Improvement
        G --> H
    end

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#bbf,stroke:#333,stroke-width:2px
    style C fill:#dfd,stroke:#333,stroke-width:2px
    style D fill:#dfd,stroke:#333,stroke-width:2px
    style E fill:#dfd,stroke:#333,stroke-width:2px
    style F fill:#dfd,stroke:#333,stroke-width:2px
    style G fill:#dfd,stroke:#333,stroke-width:2px
    style H fill:#f9f,stroke:#333,stroke-width:2px
```

## Example Rule Generation Prompts

No need to explicitly say "create a rule" - just describe the desired behavior:

- "Create a typescript file commenting standard that balances thoroughness with brevity"
- "Please create an agent rule so that whenever I request deep research specifically on a topic you will first always inject the system date time into the context and use the Tavily search MCP tool to improve the results."
- "Never create JS files again, you will only create TS or JSON files!" or "I asked you to set up Jest for our project and you created a JestConfig.js file, yet this is a TypeScript only project. Never again create any JS files. Always use TypeScript or JSON if necessary." - the second version of this request will ensure that the rule examples includes this specific call out, helping the agent learn better from actual mistakes made.
- "Ensure proper error handling in all TypeScript files"
- "Talk like a pirate in communications but not in code or documentation"
- "Update testing standards to require 80% coverage"
- "Enforce consistent naming conventions in my code"
- "Standardize documentation formats"
- "Keep imports organized in groups alphabetically in TypeScript files"

The AI automatically:

1. Creates/updates the rule file
2. Places it in the correct location
3. Follows formatting standards
4. Maintains version control

## Rule Types

| Rule Type        | Usage                                            | description Field | globs Field           | alwaysApply field |
| ---------------- | ------------------------------------------------ | ----------------- | --------------------- | ----------------- |
| Agent Selected   | Agent sees description and chooses when to apply | critical          | blank                 | false             |
| Always           | Applied to every chat and cmd-k request          | blank             | blank                 | true              |
| Auto Select      | Applied to matching existing files               | blank             | critical glob pattern | false             |
| Auto Select+desc | Better for new files                             | included          | critical glob pattern | false             |
| Manual           | User must reference in chat                      | blank             | blank                 | false             |

## Private Rules, MCP Config and Custom Agents.

If you want to have rules that are not used by others in the repository - you can add rules to a .roo/rules folder in your user folder. They will also be applied to every project you open, which is a potential benefit. Additionally you can use custom agents with their own rules, that are not shared. In the future when Roo adds the ability to have a agents.json file (or similarly named) - then you should still be able to add it to the user folder .roo folder. This also works with mcp.json.

## Custom Agent Generation

Custom Agents allow scoping and guidance to what an agent can and cannot do, more directly than using roo rules files. With a custom agent, you can specify what tools the agent can and cannot use (both roo native and mcp), and more importantly you can control what model it uses and give it a custom prompt to guide how it operates. This is like a direct injection of a clear always rule for this specific type of agent you have created. When combined with the Agile workflow, you can have a dedicated Project Manager Agent, an Architect Agent, Designer and UX Expert Agents, Front End, Back End, and Language Specific Expert Developers and keep them all focused on what they are good at, and providing them real guardrails.

Roo in an upcoming update will allow the creation and maintainability of these in a JSON file - in the meantime, these have to be created manually 1 by one in a gui that is a bit flaky and the text entry are is very small.

So I have come up with a file format to store all the information of my custom agents - which not currently used by roo, it is an easy way to configure all of their options and define their custom prompts in a text editor - and then input or update via the GUI.

You can see in the samples a star-trek-agents.md file - which is a themed fun take on the various roles or agents I might need that I used chatGPT to create and brain storm on. I then use a template and custom rule to transform that file to what becomes modes.json. For the sample, I took that output and saved it instead as star-trek-agents-modes.json in the samples folder. The modes.json file under .roo is a more practical approach to some agents you can make that will work great with the agile workflow method.

In the future, that modes.json file will be replaced by the official file format from roo, at which time this repo will be updated with the new convention.

## Best Practices

### Rule Creation

- Let AI handle rule creation and updates - but if you find stuff that is excessive or redundant, dont be afraid to prune the rules to help get them down to their core utility and essence
- Be specific about desired behaviors
- Provide examples of good/bad patterns
- For new projects, allow organic rule emergence and try to have overall less rules, and rely more also on custom instructions for your custom agents.
- If you start to have many very small rules applied to the same concept - for example you see your typescript rules subfolder has many files - you can ask the agent to consolidate and condense them down to a single file if they all generally apply and get picked up by the agent at the same time.

### AI Behavior Control

- Create rules when noticing inconsistent behavior
- Use clear, descriptive language
- Verify AI understanding by reviewing rules

### Workflow Integration

- Start with template rules
- Let AI evolve rules as your project grows
- Maintain consistency using AI for rule management

### Rule Removal

- Some rules become unnecessary as codebase grows as the AI will follow surrounding code styles and conventions
- The minimal amount of rules, the better - so prune rules as the codebase changes or models improve
- A rule you need today, may be a rule you do not need tomorrow, and then again you might need it another day - trial and error and evolution is the key to dealing with the nondeterministic nature of what we are working with here.

## Files Excluded from Indexing

The `.rooindexingignore` feature allows certain files to be accessible but excluded from indexing:

- Templates moved to `.roo/templates` folder
- Included in `.rooindexingignore` but not in `.rooignore`
- XNotes remains in `.rooignore` (files that need to move elsewhere to be used)

> 💡 **Compatibility:** Tested with Claude Sonnet 3.5, 3.7, 3.7 Thinking, o3-mini, and GPT-4o.
> [Agile Workflow Documentation](docs/agile-readme.md)

## Contributing

Contributions to improve base rules or suggest new templates are welcome. Please follow the established standards.

## License

MIT 🚀
