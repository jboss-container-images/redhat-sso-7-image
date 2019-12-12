#!/bin/sh
set -u
set -e

ARCH=$(uname -i)

# Keep OpenJ9 JDK runtime on s390x arch, and OpenJDK JDK runtime on x86_64 arch
case "${ARCH}" in
  x86_64)
    JDK_VARIANT_TO_KEEP="openjdk"
    JDK_VARIANT_TO_REMOVE="openj9"
    ;;
  s390x)
    JDK_VARIANT_TO_KEEP="openj9"
    JDK_VARIANT_TO_REMOVE="openjdk"
    ;;
  *)
    echo "Unsupported architecture: ${ARCH}!"
    exit 1
esac

if ! rpm -q java-1.8.0-${JDK_VARIANT_TO_KEEP}-devel; then
  exit
fi

# For the variant of JDK runtime, not applicable to this specific arch
# remove all of 'java-1.8.0-variant', 'java-1.8.0-variant-devel', and
# 'java-1.8.0-variant-headless' RPM packages

# NOTE: The enclosing double quote in the list of values specification of the
# for loop below is intentionally not at the end to perform shell expansion first
for pkg in "java-1.8.0-${JDK_VARIANT_TO_REMOVE}"{,-devel,-headless}; do
    if rpm -q "$pkg"; then
        rpm -e --nodeps "$pkg"
    fi
done
