/* Copyright 2019 Google LLC. All Rights Reserved.
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

// Modified from
//   https://github.com/tensorflow/tensorflow/blob/v2.0.0/tensorflow/lite/experimental/ruy/platform.h

#ifndef PLATFORMS_PLATFORMS_H_
#define PLATFORMS_PLATFORMS_H_

#define PLATFORM(X) ((DONOTUSEDIRECTLY_##X) != 0)

// -------------------- OS --------------------

// Detect APPLE.
#ifdef __APPLE__
#define DONOTUSEDIRECTLY_APPLE 1
#else
#define DONOTUSEDIRECTLY_APPLE 0
#endif

// Detect ANDROID.
#ifdef __ANDROID__
#define DONOTUSEDIRECTLY_ANDROID 1
#else
#define DONOTUSEDIRECTLY_ANDROID 0
#endif

// Detect GNU LINUX
#if defined(__gnu_linux__)
#define DONOTUSEDIRECTLY_GNU_LINUX 1
#else
#define DONOTUSEDIRECTLY_GNU_LINUX 0
#endif

// -------------------- ARCH --------------------

// Detect x86.
#if defined(__x86_64__) || defined(__i386__) || defined(__i386) || \
    defined(__x86__) || defined(__X86__) || defined(_X86_) ||      \
    defined(_M_IX86) || defined(_M_X64)
#define DONOTUSEDIRECTLY_X86 1
#else
#define DONOTUSEDIRECTLY_X86 0
#endif

// Detect ARM 32-bit.
#ifdef __arm__
#define DONOTUSEDIRECTLY_ARM_32 1
#else
#define DONOTUSEDIRECTLY_ARM_32 0
#endif

// Detect ARM 64-bit.
#ifdef __aarch64__
#define DONOTUSEDIRECTLY_ARM_64 1
#else
#define DONOTUSEDIRECTLY_ARM_64 0
#endif

// Combined ARM.
#define DONOTUSEDIRECTLY_ARM \
  (DONOTUSEDIRECTLY_ARM_64 || DONOTUSEDIRECTLY_ARM_32)

// -------------------- ISA --------------------

#if PLATFORM(X86) && defined(__SSE4_2__)
#define DONOTUSEDIRECTLY_SSE4_2 1
#else
#define DONOTUSEDIRECTLY_SSE4_2 0
#endif

#if PLATFORM(X86) && defined(__AVX2__)
#define DONOTUSEDIRECTLY_AVX2 1
#else
#define DONOTUSEDIRECTLY_AVX2 0
#endif

// These CPU capabilities will all be true when Skylake, etc, are enabled during
// compilation.
#if PLATFORM(X86) && defined(__AVX512F__) && defined(__AVX512CD__) && \
    defined(__AVX512VL__) && defined(__AVX512DQ__) && defined(__AVX512BW__)
#define DONOTUSEDIRECTLY_AVX512 1
#else
#define DONOTUSEDIRECTLY_AVX512 0
#endif

// Detect NEON. Explictly avoid emulation, or anything like it, on x86.
#if (defined(__ARM_NEON) || defined(__ARM_NEON__)) && !PLATFORM(X86)
#define DONOTUSEDIRECTLY_NEON 1
#else
#define DONOTUSEDIRECTLY_NEON 0
#endif

// Define ARM 32-bit NEON.
#define DONOTUSEDIRECTLY_NEON_32 \
  (DONOTUSEDIRECTLY_NEON && DONOTUSEDIRECTLY_ARM_32)

// Define ARM 64-bit NEON.
// Note: NEON is implied by ARM64, so this define is redundant.
// It still allows some conveyance of intent.
#define DONOTUSEDIRECTLY_NEON_64 \
  (DONOTUSEDIRECTLY_NEON && DONOTUSEDIRECTLY_ARM_64)

#endif  // PLATFORMS_PLATFORMS_H_
