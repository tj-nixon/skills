#!/usr/bin/env bash
set -euo pipefail

# Refresh AWS Bedrock model reference data.
#
# Queries a minimal set of regions to get complete model IDs and inference profiles:
#   - us-east-1 + us-west-2: superset of all model IDs
#   - us-east-1: all us. and global. inference profiles
#   - eu-west-1: all eu. inference profiles
#   - ap-southeast-2: all au. and apac. inference profiles
#   - ap-northeast-1: all jp. inference profiles
#   - ca-central-1: all ca. inference profiles
#
# Outputs models.md to stdout (redirect to references/models.md).
#
# Usage:
#   ./scripts/refresh-models.sh --profile chatsaas > references/models.md
#
# Requirements: AWS CLI v2.27+, jq, python3

PROFILE=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --profile) PROFILE="--profile $2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

# Check dependencies
for cmd in jq python3; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "Error: $cmd is required" >&2; exit 1; }
done

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "Fetching models from us-east-1..." >&2
aws $PROFILE --region us-east-1 bedrock list-foundation-models \
  --query "modelSummaries[?modelLifecycle.status=='ACTIVE'].{id:modelId,name:modelName,provider:providerName}" \
  --output json > "$TMPDIR/models_us_east_1.json"

echo "Fetching models from us-west-2..." >&2
aws $PROFILE --region us-west-2 bedrock list-foundation-models \
  --query "modelSummaries[?modelLifecycle.status=='ACTIVE'].{id:modelId,name:modelName,provider:providerName}" \
  --output json > "$TMPDIR/models_us_west_2.json"

echo "Fetching inference profiles from us-east-1..." >&2
aws $PROFILE --region us-east-1 bedrock list-inference-profiles \
  --query "inferenceProfileSummaries[].{id:inferenceProfileId,name:inferenceProfileName}" \
  --output json > "$TMPDIR/profiles_us_east_1.json"

echo "Fetching inference profiles from eu-west-1..." >&2
aws $PROFILE --region eu-west-1 bedrock list-inference-profiles \
  --query "inferenceProfileSummaries[].{id:inferenceProfileId,name:inferenceProfileName}" \
  --output json > "$TMPDIR/profiles_eu_west_1.json"

echo "Fetching inference profiles from ap-southeast-2..." >&2
aws $PROFILE --region ap-southeast-2 bedrock list-inference-profiles \
  --query "inferenceProfileSummaries[].{id:inferenceProfileId,name:inferenceProfileName}" \
  --output json > "$TMPDIR/profiles_ap_southeast_2.json"

echo "Fetching inference profiles from ap-northeast-1..." >&2
aws $PROFILE --region ap-northeast-1 bedrock list-inference-profiles \
  --query "inferenceProfileSummaries[].{id:inferenceProfileId,name:inferenceProfileName}" \
  --output json > "$TMPDIR/profiles_ap_northeast_1.json"

echo "Fetching inference profiles from ca-central-1..." >&2
aws $PROFILE --region ca-central-1 bedrock list-inference-profiles \
  --query "inferenceProfileSummaries[].{id:inferenceProfileId,name:inferenceProfileName}" \
  --output json > "$TMPDIR/profiles_ca_central_1.json"

echo "Generating reference..." >&2

python3 - "$TMPDIR" << 'PYTHON'
import json
import sys
from collections import defaultdict
from datetime import date

tmpdir = sys.argv[1]

# Load models from both US regions (together = superset)
all_models = {}
for fname in ["models_us_east_1.json", "models_us_west_2.json"]:
    with open(f"{tmpdir}/{fname}") as f:
        for entry in json.load(f):
            mid = entry["id"]
            # Skip context-window variants (e.g., :24k, :128k, :200k)
            if ":" in mid:
                parts = mid.split(":")
                if len(parts) > 2:
                    continue
                if len(parts) == 2 and parts[1] not in ("0", "1", "2"):
                    continue
            all_models[mid] = {
                "name": entry["name"],
                "provider": entry["provider"],
            }

# Load inference profiles from all three regions
all_profiles = set()
for fname in ["profiles_us_east_1.json", "profiles_eu_west_1.json", "profiles_ap_southeast_2.json", "profiles_ap_northeast_1.json", "profiles_ca_central_1.json"]:
    with open(f"{tmpdir}/{fname}") as f:
        for entry in json.load(f):
            all_profiles.add(entry["id"])

# Match profiles to models
GEO_PREFIXES = ("us", "eu", "au", "jp", "ca", "apac")

# Group by provider
providers = defaultdict(list)
for mid, data in sorted(all_models.items(), key=lambda x: (x[1]["provider"], x[0])):
    providers[data["provider"]].append((mid, data))

today = date.today().isoformat()

print(f"# AWS Bedrock Model IDs — Complete Reference")
print()
print(f"Last generated: {today} via `refresh-models.sh`")
print()
print("## Cross-Region Inference")
print()
print("Bedrock offers three inference routing options:")
print()
print("| Type | Prefix | Description |")
print("|------|--------|-------------|")
print("| In-Region | (none) | Request stays in one region |")
print("| Geo Cross-Region | `us.`, `eu.`, `au.`, `jp.`, `ca.`, `apac.` | Routes within a geography |")
print("| Global Cross-Region | `global.` | Routes anywhere worldwide |")
print()
print("Prefixes: `us.`, `eu.`, `au.`, `jp.`, `ca.`, `apac.` (legacy), `global.`")
print()
print("Supported regions: ap-northeast-1, ap-northeast-2, ap-south-1, ap-southeast-1, ap-southeast-2, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, sa-east-1, us-east-1, us-east-2, us-gov-east-1, us-west-2")
print()
print("---")

print()
print("## All Model IDs")
print()
print("| Model | Model ID |")
print("|-------|----------|")
for provider in sorted(providers.keys()):
    models = providers[provider]
    for mid, data in models:
        all_ids = [mid]
        for p in GEO_PREFIXES:
            if f"{p}.{mid}" in all_profiles:
                all_ids.append(f"{p}.{mid}")
        if f"global.{mid}" in all_profiles:
            all_ids.append(f"global.{mid}")
        for model_id in all_ids:
            print(f"| {data['name']} | `{model_id}` |")

print()
print("## Model Access")
print()
print("If a Bedrock call returns `AccessDeniedException`, the model's Marketplace subscription hasn't been set up. Bedrock normally auto-subscribes on first invoke, but this only works if the calling IAM role has `aws-marketplace:Subscribe` and `aws-marketplace:ViewSubscriptions` permissions.")
print()
print("Some providers bypass Marketplace entirely and never need subscriptions: Amazon, DeepSeek, Meta, Mistral AI, OpenAI, Qwen. All other third-party providers go through Marketplace.")
print()
print("Anthropic models additionally require a one-time \"First Time Use\" form per AWS account — submit via Bedrock console or `aws bedrock put-use-case-for-model-access`.")
print()
print("### Diagnose")
print()
print("```bash")
print("aws bedrock get-foundation-model-availability --model-id <model-id> --region <region>")
print("```")
print()
print("Check `agreementAvailability.status` — AVAILABLE means ready, NOT_AVAILABLE means subscription missing, PENDING means recently accepted (wait up to 2 minutes).")
print()
print("### Fix")
print()
print("Either add Marketplace permissions to the IAM role (enables auto-subscription going forward), or manually subscribe to a specific model:")
print()
print("```bash")
print("aws bedrock create-foundation-model-agreement \\\\")
print("  --model-id <model-id> --region <region> \\\\")
print('  --offer-token "$(aws bedrock list-foundation-model-agreement-offers \\\\')
print("    --model-id <model-id> --region <region> \\\\")
print("    --query 'offers[0].offerToken' --output text)\"")
print()
print("```")
print()
print("Reference: https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html")
print()
print("---")
print()
print("## Documentation")
print()
print("- **Model cards:** https://docs.aws.amazon.com/bedrock/latest/userguide/model-cards.html")
print("- **Pricing:** https://aws.amazon.com/bedrock/pricing/")
print("- **Quotas & limits:** https://docs.aws.amazon.com/general/latest/gr/bedrock.html#limits_bedrock")
print("- **Cross-region inference:** https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html")
print("- **Regional availability:** https://docs.aws.amazon.com/bedrock/latest/userguide/models-region-compatibility.html")
print()
print("---")
print()
print("## Staleness Warning")
print()
print(f"This file was last generated on **{today}**.")
print()
print("To regenerate:")
print("```bash")
print("./scripts/refresh-models.sh --profile <your-profile> > references/models.md")
print("```")
PYTHON

echo "Done." >&2
