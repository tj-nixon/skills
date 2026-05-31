# Agent Skills

A collection of agent skills for AI coding assistants. Works with Claude Code, Cursor, Continue, Kiro, and any agent that supports the Agent Skills format.

## Install

```bash
# All skills
npx skills add tj-nixon/skills

# Individual skill
npx skills add tj-nixon/skills@bedrock-models
```

## Skills

### bedrock-models

Complete reference of AWS Bedrock model IDs and cross-region inference profiles.

Made out of frustration caused by AI guessing model ids and no central reference in AWS documentation. Bedrock model IDs are inconsistent across providers — some have dates (`anthropic.claude-haiku-4-5-20251001-v1:0`), some don't (`anthropic.claude-sonnet-4-6`), some have `-v1` without `:0` (`anthropic.claude-opus-4-6-v1`). AI coding assistants frequently guess these wrong. This skill provides the verified IDs so they don't have to.

**Includes:**

- Verified model IDs for all providers on Bedrock (AI21, Amazon, Anthropic, Cohere, DeepSeek, Google, Meta, MiniMax, Mistral, Moonshot, NVIDIA, OpenAI, Qwen, Stability AI, TwelveLabs, Writer, Z.AI)
- Cross-region inference patterns (in-region, geo, global)
- Geo prefix rules (`us.`, `eu.`, `au.`, `jp.`, `global.`)
- Links to AWS pricing, quotas, and regional availability docs
- Staleness fallback via `aws bedrock list-foundation-models` CLI command

Last verified: 2026-05-31
