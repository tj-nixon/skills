---
name: bedrock-models
description: "AWS Bedrock model IDs and cross-region inference profiles. Use this skill whenever code references AWS Bedrock model IDs (modelId), cross-region inference, or model selection. Triggers on: amazon.nova-*, anthropic.claude-*, cohere.*, deepseek.*, meta.llama*, mistral.*, qwen.*, any Bedrock InvokeModel/Converse call, BedrockRuntimeClient, or questions about which model to use on Bedrock. NEVER guess or invent model IDs — they are inconsistent across providers (some have dates, some don't, some have :0 suffix, some don't). Always check this skill first."
---

# AWS Bedrock Model IDs

NEVER guess or invent Bedrock model IDs. Model ID formats are inconsistent across providers and even across models from the same provider. Always use this skill to get the correct ID.

## How to use

1. Read `references/models.md` for the complete model catalogue with verified IDs
2. If a model is not listed, it may be newer than this skill — use the fallback below

## Staleness fallback

If the model you need is NOT in the reference file, or you suspect data is outdated:

1. **Run the AWS CLI** (preferred — always authoritative):
   ```bash
   aws bedrock list-foundation-models --region <region> --query "modelSummaries[].{id:modelId,name:modelName,provider:providerName}" --output table
   ```

2. **Check the AWS docs**: https://docs.aws.amazon.com/bedrock/latest/userguide/model-cards.html
   - Click any model -> scroll to "Programmatic Access" table for exact model IDs and geo inference IDs

## Critical rules

- Model IDs are NOT predictable. Some have dates (`-20251001-v1:0`), some don't (`-4-6`), some have `-v1` without `:0`. Do not construct them by pattern.
- Cross-region geo IDs use a prefix: `us.`, `eu.`, `au.`, `jp.`, `global.` prepended to the base model ID.
- Not all models support all geo profiles. Check the reference.
- Context window suffixes (`:24k`, `:128k`, `:300k`) are optional variants — use the base ID unless you specifically need to constrain context.

Last verified: 2026-05-31
