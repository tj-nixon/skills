# AWS Bedrock Model IDs — Complete Reference

Last verified: 2026-05-31 via `aws bedrock list-foundation-models`

## Cross-Region Inference

Bedrock offers three inference routing options:

| Type | Prefix | Description | Use when |
|------|--------|-------------|----------|
| In-Region | (none) | Request stays in one region | Strict compliance, data residency |
| Geo Cross-Region | `us.`, `eu.`, `au.`, `jp.` | Routes within a geography | Data residency + higher throughput |
| Global Cross-Region | `global.` | Routes anywhere worldwide | Max throughput, ~10% cost savings |

To use geo/global inference, prepend the prefix to the base model ID:
- Base: `amazon.nova-pro-v1:0`
- US Geo: `us.amazon.nova-pro-v1:0`
- EU Geo: `eu.amazon.nova-pro-v1:0`

No additional cost for cross-region routing. Price is based on source region.

---

## AI21 Labs

| Model | Model ID | Context |
|-------|----------|---------|
| Jamba 1.5 Large | `ai21.jamba-1-5-large-v1:0` | 256K |
| Jamba 1.5 Mini | `ai21.jamba-1-5-mini-v1:0` | 256K |

---

## Amazon

### Nova (Text/Multimodal)

| Model | Model ID | Context | Max Output | Geo Profiles |
|-------|----------|---------|------------|--------------|
| Nova Premier | `amazon.nova-premier-v1:0` | 1M | 20K | us |
| Nova Pro | `amazon.nova-pro-v1:0` | 300K | 5K | us, eu |
| Nova Lite | `amazon.nova-lite-v1:0` | 300K | 5K | us, eu |
| Nova Micro | `amazon.nova-micro-v1:0` | 128K | 5K | us, eu |
| Nova 2 Lite | `amazon.nova-2-lite-v1:0` | 256K | 5K | — |
| Nova 2 Sonic | `amazon.nova-2-sonic-v1:0` | — | — | — |
| Nova Sonic | `amazon.nova-sonic-v1:0` | — | — | — |

### Nova (Image/Video Generation)

| Model | Model ID |
|-------|----------|
| Nova Canvas | `amazon.nova-canvas-v1:0` |
| Nova Reel | `amazon.nova-reel-v1:0` |

### Titan & Embeddings

| Model | Model ID |
|-------|----------|
| Titan Text Embeddings V2 | `amazon.titan-embed-text-v2:0` |
| Titan Multimodal Embeddings G1 | `amazon.titan-embed-image-v1:0` |
| Titan Embeddings G1 - Text | `amazon.titan-embed-text-v1` |
| Titan Image Generator G1 v2 | `amazon.titan-image-generator-v2:0` |
| Nova Multimodal Embeddings | `amazon.nova-2-multimodal-embeddings-v1:0` |

---

## Anthropic

| Model | Model ID | Context | Max Output | Geo Profiles |
|-------|----------|---------|------------|--------------|
| Claude Opus 4.8 | `anthropic.claude-opus-4-8` | 1M | 128K | us, eu, au, global |
| Claude Opus 4.7 | `anthropic.claude-opus-4-7` | 1M | 128K | us, eu, au, global |
| Claude Opus 4.6 | `anthropic.claude-opus-4-6-v1` | 1M | 128K | us, eu, au, global |
| Claude Opus 4.5 | `anthropic.claude-opus-4-5-20251101-v1:0` | 1M | 128K | us, eu, global |
| Claude Opus 4.1 | `anthropic.claude-opus-4-1-20250805-v1:0` | 200K | 32K | us, global |
| Claude Opus 4 | `anthropic.claude-opus-4-20250514-v1:0` | 200K | 32K | us, eu, global |
| Claude Sonnet 4.6 | `anthropic.claude-sonnet-4-6` | 1M | 64K | us, eu, au, jp, global |
| Claude Sonnet 4.5 | `anthropic.claude-sonnet-4-5-20250929-v1:0` | 1M | 64K | us, eu, global |
| Claude Sonnet 4 | `anthropic.claude-sonnet-4-20250514-v1:0` | 200K | 64K | us, eu, global |
| Claude Haiku 4.5 | `anthropic.claude-haiku-4-5-20251001-v1:0` | 200K | 64K | us, eu, au, jp, global |
| Claude 3.5 Haiku | `anthropic.claude-3-5-haiku-20241022-v1:0` | 200K | 8K | us, eu, global |
| Claude 3.5 Sonnet v2 | `anthropic.claude-3-5-sonnet-20241022-v2:0` | 200K | 8K | us, eu |
| Claude 3.5 Sonnet | `anthropic.claude-3-5-sonnet-20240620-v1:0` | 200K | 8K | us |
| Claude 3 Haiku | `anthropic.claude-3-haiku-20240307-v1:0` | 200K | 4K | us, eu |
| Claude 3 Sonnet | `anthropic.claude-3-sonnet-20240229-v1:0` | 200K | 4K | us |
| Claude Mythos Preview | `anthropic.claude-mythos-preview-1-200k-v1:0` | 200K | — | — |

---

## Cohere

| Model | Model ID |
|-------|----------|
| Command R+ | `cohere.command-r-plus-v1:0` |
| Command R | `cohere.command-r-v1:0` |
| Embed v4 | `cohere.embed-v4:0` |
| Embed English v3 | `cohere.embed-english-v3` |
| Embed Multilingual v3 | `cohere.embed-multilingual-v3` |
| Rerank 3.5 | `cohere.rerank-v3-5:0` |

---

## DeepSeek

| Model | Model ID | Context | Geo Profiles |
|-------|----------|---------|--------------|
| DeepSeek V3.2 | `deepseek.v3.2` | — | — |
| DeepSeek V3.1 | `deepseek.v3-v1:0` | 128K | us |
| DeepSeek R1 | `deepseek.r1-v1:0` | 128K | us |

---

## Google

| Model | Model ID |
|-------|----------|
| Gemma 3 27B IT | `google.gemma-3-27b-it` |
| Gemma 3 12B IT | `google.gemma-3-12b-it` |
| Gemma 3 4B IT | `google.gemma-3-4b-it` |

---

## Meta

| Model | Model ID | Context | Geo Profiles |
|-------|----------|---------|--------------|
| Llama 4 Maverick 17B | `meta.llama4-maverick-17b-instruct-v1:0` | 1M | us |
| Llama 4 Scout 17B | `meta.llama4-scout-17b-instruct-v1:0` | 10M | us |
| Llama 3.3 70B | `meta.llama3-3-70b-instruct-v1:0` | 128K | us |
| Llama 3.2 90B (vision) | `meta.llama3-2-90b-instruct-v1:0` | 128K | us |
| Llama 3.2 11B (vision) | `meta.llama3-2-11b-instruct-v1:0` | 128K | us |
| Llama 3.2 3B | `meta.llama3-2-3b-instruct-v1:0` | 128K | us |
| Llama 3.2 1B | `meta.llama3-2-1b-instruct-v1:0` | 128K | us |
| Llama 3.1 405B | `meta.llama3-1-405b-instruct-v1:0` | 128K | us |
| Llama 3.1 70B | `meta.llama3-1-70b-instruct-v1:0` | 128K | us |
| Llama 3.1 8B | `meta.llama3-1-8b-instruct-v1:0` | 128K | us |
| Llama 3 70B | `meta.llama3-70b-instruct-v1:0` | 8K | — |
| Llama 3 8B | `meta.llama3-8b-instruct-v1:0` | 8K | — |

---

## MiniMax

| Model | Model ID |
|-------|----------|
| MiniMax M2.5 | `minimax.minimax-m2.5` |
| MiniMax M2.1 | `minimax.minimax-m2.1` |
| MiniMax M2 | `minimax.minimax-m2` |

---

## Mistral AI

| Model | Model ID | Context |
|-------|----------|---------|
| Mistral Large 3 (675B) | `mistral.mistral-large-3-675b-instruct` | 256K |
| Devstral 2 (123B) | `mistral.devstral-2-123b` | — |
| Magistral Small 2509 | `mistral.magistral-small-2509` | — |
| Pixtral Large | `mistral.pixtral-large-2502-v1:0` | — |
| Voxtral Small 24B | `mistral.voxtral-small-24b-2507` | — |
| Voxtral Mini 3B | `mistral.voxtral-mini-3b-2507` | — |
| Ministral 14B 3.0 | `mistral.ministral-3-14b-instruct` | — |
| Ministral 3 8B | `mistral.ministral-3-8b-instruct` | — |
| Ministral 3B | `mistral.ministral-3-3b-instruct` | — |
| Mistral Large (24.02) | `mistral.mistral-large-2402-v1:0` | 32K |
| Mistral Small (24.02) | `mistral.mistral-small-2402-v1:0` | 32K |
| Mixtral 8x7B | `mistral.mixtral-8x7b-instruct-v0:1` | 32K |
| Mistral 7B | `mistral.mistral-7b-instruct-v0:2` | 32K |

---

## Moonshot AI

| Model | Model ID |
|-------|----------|
| Kimi K2.5 | `moonshotai.kimi-k2.5` |
| Kimi K2 Thinking | `moonshot.kimi-k2-thinking` |

---

## NVIDIA

| Model | Model ID |
|-------|----------|
| Nemotron 3 Super 120B | `nvidia.nemotron-super-3-120b` |
| Nemotron Nano 3 30B | `nvidia.nemotron-nano-3-30b` |
| Nemotron Nano 12B v2 VL | `nvidia.nemotron-nano-12b-v2` |
| Nemotron Nano 9B v2 | `nvidia.nemotron-nano-9b-v2` |

---

## OpenAI (Open Source)

| Model | Model ID |
|-------|----------|
| GPT OSS 120B | `openai.gpt-oss-120b-1:0` |
| GPT OSS 20B | `openai.gpt-oss-20b-1:0` |
| GPT OSS Safeguard 120B | `openai.gpt-oss-safeguard-120b` |
| GPT OSS Safeguard 20B | `openai.gpt-oss-safeguard-20b` |

---

## Qwen

| Model | Model ID |
|-------|----------|
| Qwen3 Coder Next | `qwen.qwen3-coder-next` |
| Qwen3 VL 235B A22B | `qwen.qwen3-vl-235b-a22b` |
| Qwen3 Next 80B A3B | `qwen.qwen3-next-80b-a3b` |
| Qwen3 Coder 480B A35B | `qwen.qwen3-coder-480b-a35b-v1:0` |
| Qwen3 Coder 30B A3B | `qwen.qwen3-coder-30b-a3b-v1:0` |
| Qwen3 32B | `qwen.qwen3-32b-v1:0` |
| Qwen3 235B A22B 2507 | `qwen.qwen3-235b-a22b-2507-v1:0` |

---

## Stability AI (Image)

| Model | Model ID |
|-------|----------|
| Stable Image Creative Upscale | `stability.stable-creative-upscale-v1:0` |
| Stable Image Conservative Upscale | `stability.stable-conservative-upscale-v1:0` |
| Stable Image Fast Upscale | `stability.stable-fast-upscale-v1:0` |
| Stable Image Control Sketch | `stability.stable-image-control-sketch-v1:0` |
| Stable Image Control Structure | `stability.stable-image-control-structure-v1:0` |
| Stable Image Erase Object | `stability.stable-image-erase-object-v1:0` |
| Stable Image Inpaint | `stability.stable-image-inpaint-v1:0` |
| Stable Image Outpaint | `stability.stable-outpaint-v1:0` |
| Stable Image Remove Background | `stability.stable-image-remove-background-v1:0` |
| Stable Image Search and Recolor | `stability.stable-image-search-recolor-v1:0` |
| Stable Image Search and Replace | `stability.stable-image-search-replace-v1:0` |
| Stable Image Style Guide | `stability.stable-image-style-guide-v1:0` |
| Stable Image Style Transfer | `stability.stable-style-transfer-v1:0` |

---

## TwelveLabs

| Model | Model ID |
|-------|----------|
| Pegasus v1.2 | `twelvelabs.pegasus-1-2-v1:0` |
| Marengo Embed 3.0 | `twelvelabs.marengo-embed-3-0-v1:0` |
| Marengo Embed v2.7 | `twelvelabs.marengo-embed-2-7-v1:0` |

---

## Writer

| Model | Model ID |
|-------|----------|
| Palmyra X5 | `writer.palmyra-x5-v1:0` |
| Palmyra X4 | `writer.palmyra-x4-v1:0` |
| Palmyra Vision 7B | `writer.palmyra-vision-7b` |

---

## Z.AI

| Model | Model ID |
|-------|----------|
| GLM 5 | `zai.glm-5` |
| GLM 4.7 | `zai.glm-4.7` |
| GLM 4.7 Flash | `zai.glm-4.7-flash` |

---

## Documentation & Pricing

- **Model cards (capabilities, quotas, regional availability):** https://docs.aws.amazon.com/bedrock/latest/userguide/model-cards.html
- **Pricing:** https://aws.amazon.com/bedrock/pricing/
- **Quotas & limits:** https://docs.aws.amazon.com/general/latest/gr/bedrock.html#limits_bedrock
- **Cross-region inference:** https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html
- **Supported regions per model:** https://docs.aws.amazon.com/bedrock/latest/userguide/models-region-compatibility.html

---

## Staleness Warning

This file was last verified on **2026-05-31**. AWS adds new models frequently.

If a model is not listed here, or you suspect outdated information:

```bash
aws bedrock list-foundation-models --region <region> \
  --query "modelSummaries[].{id:modelId,name:modelName,provider:providerName}" \
  --output table
```

Or check: https://docs.aws.amazon.com/bedrock/latest/userguide/model-cards.html
