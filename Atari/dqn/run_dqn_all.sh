#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PROJECT_ROOT="${SCRIPT_DIR}/../../"
PYTHON=python

ALGO="dqn"
ENV="atari"
ENV_TAGs=(
  "AirRaid-v5"
  "Alien-v5"
  "Amidar-v5"
  "Assault-v5"
  "Asterix-v5"
  "Asteroids-v5"
  "Atlantis-v5"
  "BankHeist-v5"
  "BattleZone-v5"
  "BeamRider-v5"
  "Berzerk-v5"
  "Bowling-v5"
  "Boxing-v5"
  "Breakout-v5"
  "Carnival-v5"
  "Centipede-v5"
  "ChopperCommand-v5"
  "CrazyClimber-v5"
  "Defender-v5"
  "DemonAttack-v5"
  "DoubleDunk-v5"
  "Enduro-v5"
  "FishingDerby-v5"
  "Freeway-v5"
  "Frostbite-v5"
  "Gopher-v5"
  "Gravitar-v5"
  "Hero-v5"
  "IceHockey-v5"
  "Jamesbond-v5"
  "JourneyEscape-v5"
  "Kangaroo-v5"
  "Krull-v5"
  "KungFuMaster-v5"
  "MontezumaRevenge-v5"
  "MsPacman-v5"
  "NameThisGame-v5"
  "Phoenix-v5"
  "Pitfall-v5"
  "Pong-v5"
  "Pooyan-v5"
  "PrivateEye-v5"
  "Qbert-v5"
  "Riverraid-v5"
  "RoadRunner-v5"
  "Robotank-v5"
  "Seaquest-v5"
  "Skiing-v5"
  "Solaris-v5"
  "SpaceInvaders-v5"
  "StarGunner-v5"
  "Tennis-v5"
  "TimePilot-v5"
  "Tutankham-v5"
  "UpNDown-v5"
  "Venture-v5"
  "VideoPinball-v5"
  "WizardOfWor-v5"
  "Zaxxon-v5"
)

for ENV_TAG in ENV_TAGs; do
  ENV_ID="ALE/${ENV_TAG}"
  CONFIG_PATH="${SCRIPT_DIR}/${ALGO}_atari.yaml"

  OUT_ROOT="${SCRIPT_DIR}/results/${ENV_TAG}"


  for SEED in 1 2 3 4 5; do
    WORKDIR="${OUT_ROOT}/seed_${SEED}"
    mkdir -p "${WORKDIR}"

    echo "========== [Benchmark START] seed=${SEED} =========="

    START_TIME=$(date +%s)
    if ${PYTHON} "${PROJECT_ROOT}/benchmark.py" \
      --algo "${ALGO}" \
      --env "${ENV}" \
      --env-id "${ENV_ID}" \
      --seed "${SEED}" \
      --config-path "${CONFIG_PATH}"\
      --result-path "${OUT_ROOT}/seed_${SEED}"; then
    END_TIME=$(date +%s)
    ELAPSED=$((END_TIME - START_TIME))
    STATUS="SUCCESS"
    else
      STATUS="FAILED"
    fi

    echo "========== [Benchmark END] seed=${SEED} | status=${STATUS} | time=${ELAPSED}s =========="
    echo
  done
done
