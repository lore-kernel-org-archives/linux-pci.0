Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596335;
	b=3K6X5RnkJSziUv5C9NhrPgMxeIQVOBWcY/mhRF1oE89Ta9BO2IC2qFqNLhfZAVRRAspB
	 7KDMLIvfElmhrGpbGaB5/UCZ6/0+GB65pP1PlaipcdbA379BB5YbQgdlu2qVSYiD3lE2W
	 2EQcK1yqosa/GB0BDFqmvA87X+uLZGboQD9D49qkh+D357tlk9fyMDu0LC22ymQEpb1dK
	 3kOAYOy3NhsVMo3Qz66lfBAuNIx7T+DEV78oVjqCmEpKblqgXv+Idm4sPAxYZq9FNVvdH
	 NxmwdmTq/5wAZrOiASdhmbDvMlmkf9UXKBELbxW18dkQpA7eYdxqhZlMQW6VVAXG5Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ZbIjwDEfIR1joauMn2U7a5Pk6EzKnprQ0hMzYPZ02Lc=;
	b=n4biikur80t10wk6obcqW96dkfz2IEB1sUpney1JjiDcm1OAgAFwsAwcDHEcwOYxBdBh
	 LT2ntWEodzYIJdoY2xbSd0jI+PjuXqaf7ePM6k/nY4yge6sHSaolrBzvb5RkkZVCAnX2r
	 61PGOgZ9/Hpk6G3OzkgwiV0bMj3HtiYJQnFOOvIjLIfhQ9o5uyJVt2OCyhtRdfretDsK2
	 yqTeyDWDJaWjaSc4Q6oxiGHfbpBoGb3TG42uJjdDlB7CEK8tL9GMiOyoVGhRiot1vXrol
	 t5nPAUQS0B0+RNHrbfDy4jufhboZEC1R+yoL0W6qrp9XddnMQHjC5PSdU7KQu/40TSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dScoVOdk;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B960A262B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 15:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 787B960A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dScoVOdk
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d7162so1239821a12.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792596333; x=1793201133; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbIjwDEfIR1joauMn2U7a5Pk6EzKnprQ0hMzYPZ02Lc=;
        b=dScoVOdkhjgrp//ufjf66iV3smajU+tkiL9+CW7JI8cCckXOUa4mI8FL22mUy0uukA
         ATa1yn5ovbm3pjVZmHOkthDSkzKrVjZpXsO/p5vcNalxvsZMFp1I9w1iIkdeXKxtKhu7
         Iv9OvTvajIMN/4e2yB3LRIcb/sgmfVGY8ZQguhQVAqdTsfMTz3wpgjpMvHHekUJ+Nae8
         SiVScVvIDNRJTx9wOhGWXG4T0xPhuNomSbjC4IlUqReVeX9etDKmEXmwzXFZyaotOAuR
         e9Lbn47raNpPhcHYz9a8KMyGI70wJeSPeZdgWpa//kLFcCIHpEVT/KH9CUAxXp2ARVGu
         7lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596333; x=1793201133;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZbIjwDEfIR1joauMn2U7a5Pk6EzKnprQ0hMzYPZ02Lc=;
        b=EjwHmAzF7GrNGBpVos7XpEWWSEJU14ZkJtPrQXZUcFN/Oe7k+tr2b1E3vFEPOGKkKD
         oGnI58kPwyvyhA/HOtMkSGk9Wf2TZz2Sw1sJWrnSVhZUsHvPTgS9n20oOR7vBERKMvOm
         82ArrYuhsGlBTYSCl/diUbe9w2fQMP4UkMnsxzCqSMH037BYK7FW+GUFFtYwVLZnb9uJ
         Ow/w7m0T76yt2ObBq7M7Rz9Nx5WamfMAeBMMw1cvI8w1nT31jMDselS6ERPYuXIZJBea
         8iPP3mqlKc84ucDj7Me5PuRuCM5B9NiznAKM++GVj/p2kKC3fTZiTiYIlt+3NLKsE4OK
         rcEw==
X-Forwarded-Encrypted: i=1; AKwUvBwG+INxFfwcCryIWd3ZkOsKHxYk/d/kLwN5UVXM3513laqLk+9mpZF0deLG8gJrh1QdmF3o3ip8nLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhSAN2O/lgjDzHwU8Z771kFg4WZo1XNj9QkCC80El6ejB9nPSM
	ewprSElmijhs+ilfp+x0QFVp7ZAU6PBSIK3Dg8u6NKoI3gz5Ayl4KtPn+PeTm86dV4bNWlXDbKs
	lw7DCwO4rfgR3eDPRUw==
X-Received: from edqi13.prod.google.com ([2002:aa7:c70d:0:b0:6b1:b15e:791f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:d0e:b0:6ac:765e:def2 with SMTP id 4fb4d7f45d1cf-6b408ee816dmr1817334a12.41.1792596332369;
 Wed, 21 Oct 2026 08:25:32 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:25:26 +0000
In-Reply-To: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021152527.375070-4-tarunsahu@google.com>
Subject: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with a
 2-bit pair feature header
From: Tarun Sahu <tarunsahu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, 
	loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, 
	alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, 
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

LUO and its file handlers validate handed-over state with monolithic
compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
structure, even an optional additive one, must bump the string, which
breaks live update between adjacent kernels. Replace the string in
struct luo_ser with a feature header, so that the target kernel can
accept or reject the source kernel state per feature.

struct luo_feature_hdr is a fixed 128-byte header: the serialized
structure size from the source kernel followed by 15 chained u64 feature
flags entries. The fixed size keeps payload field offsets identical in
every kernel, regardless of how many flags entries a source kernel uses.

Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
holds 31 features, and bits [63:62] = 0b11 chain to the next entry (465
features in total). Each subsystem defines its feature states as a
static const u8 array indexed by its feature enum, which
luo_feature_hdr_init() packs into 64-bit flags entries with
LUO_FEAT_EXT_MASK chain bits. The target kernel validates the header from
the source kernel against its own feature array via
luo_feature_hdr_validate() according to the per-feature (req, active)
truth table:

  Source Target Action
  (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without active)
  (x,x)  (1,0)  Reject -EINVAL + WARN_ON_ONCE: invalid target kernel
  (0,0)  (0,0)  Accept: feature absent
  (0,0)  (0,1)  Accept: feature absent
  (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
  (0,1)  (0,0)  Accept: ignore payload data
  (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
  (x,1)  (x,1)  Accept: use payload data

The relative order and offsets of fields in serialized structures must
remain unchanged as features are added or retired. New fields are always
appended at the end of the structure under a new feature flag, and
retired fields are kept in place so that the offsets of subsequent
fields never shift. If the type or format of a field needs to change, the
existing field and feature are kept intact (and retired when no longer
needed) and a new feature flag with a new appended field of the new type
is added.

In the target kernel, fields of a LUO_FEAT_REQUIRED feature are
guaranteed to be present once luo_feature_hdr_validate() succeeds,
whereas fields of a LUO_FEAT_OPTIONAL feature should be accessed only
after verifying that the feature is active in the source kernel header:

  if (luo_feature_is_active(&ser->features, FEAT_X))
          val = ser->x_field;

All current struct luo_ser fields (liveupdate_num, sessions_pa, flbs_pa)
belong to LUO_CORE_FEAT_CORE (LUO_FEAT_REQUIRED in luo_core_features).
Future changes add new entries to enum luo_core_feature before
LUO_CORE_FEAT_MAX.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h  | 345 +++++++++++++++++++++++++++++++----
 kernel/liveupdate/luo_core.c |  27 ++-
 2 files changed, 332 insertions(+), 40 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 5fb2f46425d7..be35cfbfdb2b 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -9,19 +9,53 @@
  * DOC: Live Update Orchestrator ABI
  *
  * Live Update Orchestrator uses the stable Application Binary Interface
- * defined below to pass state from a pre-update kernel to a post-update
- * kernel. The ABI is built upon the Kexec HandOver framework and registers
- * the central `struct luo_ser` via the KHO raw subtree API.
+ * defined below to pass state from a source kernel to a target kernel.
+ * The ABI is built upon the Kexec HandOver framework and registers the
+ * central `struct luo_ser` via the KHO raw subtree API.
  *
- * This interface is a contract. Any modification to the structure fields,
- * compatible strings, or the layout of the `__packed` serialization
- * structures defined here constitutes a breaking change. Such changes require
- * incrementing the version number in the relevant `_COMPATIBLE` string to
- * prevent a new kernel from misinterpreting data from an old kernel.
+ * This interface is a contract. Serialized structures start with a fixed
+ * 128-byte feature header (`struct luo_feature_hdr`) holding the source
+ * kernel's structure `size` and 15 chained 64-bit feature flags entries
+ * (`flags[LUO_FEAT_NR_FLAGS]`). Each entry encodes up to 31 features as
+ * 2-bit `0b<req><active>` pairs (`enum luo_feat_state`), with
+ * `LUO_FEAT_EXT_MASK` in bits `[63:62]` chaining to the next entry (up to
+ * 465 features total). Because the header size is fixed at 128 bytes,
+ * payload field offsets do not depend on how many flags entries a source
+ * kernel uses.
  *
- * Changes are allowed provided the compatibility version is incremented;
- * however, backward/forward compatibility is only guaranteed for kernels
- * supporting the same ABI version.
+ * Truth table (`(req,active)` pairs per feature)::
+ *
+ *   Source Target Action
+ *   (1,0)  (x,x)  Reject -EINVAL: invalid source kernel (req without active)
+ *   (x,x)  (1,0)  Reject -EINVAL: invalid target kernel (req without active)
+ *   (0,0)  (0,0)  Accept: feature absent
+ *   (0,0)  (0,1)  Accept: feature absent
+ *   (0,0)  (1,1)  Reject -EOPNOTSUPP: target kernel requires the feature
+ *   (0,1)  (0,0)  Accept: ignore payload data
+ *   (1,1)  (0,0)  Reject -EOPNOTSUPP: source kernel requires the feature
+ *   (x,1)  (x,1)  Accept: use payload data
+ *
+ * The relative order and offsets of fields in serialized structures must
+ * remain unchanged as features are added or retired. New fields are always
+ * appended at the end of the structure under a new feature flag, and
+ * retired fields are kept in place so that the offsets of subsequent
+ * fields never shift. If a field's type or format needs to change, the
+ * existing field and feature are kept intact (and retired when no longer
+ * needed) and a new feature flag with a new appended field of the new type
+ * is added.
+ *
+ * In the target kernel, fields of a `LUO_FEAT_REQUIRED` feature are
+ * guaranteed to be present once `luo_feature_hdr_validate()` succeeds,
+ * whereas fields of a `LUO_FEAT_OPTIONAL` feature should be accessed only
+ * after verifying that the feature is active in the source kernel's header::
+ *
+ *   if (luo_feature_is_active(&ser->features, FEAT_X))
+ *           val = ser->x_field;
+ *
+ * All current `struct luo_ser` fields (`liveupdate_num`, `sessions_pa`,
+ * `flbs_pa`) belong to `LUO_CORE_FEAT_CORE` (`LUO_FEAT_REQUIRED` in
+ * `luo_core_features`). Future changes add new entries to
+ * `enum luo_core_feature` before `LUO_CORE_FEAT_MAX`.
  *
  * KHO Structure Overview:
  *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
@@ -30,8 +64,9 @@
  * Serialization Structures:
  *   - struct luo_ser:
  *     The central ABI structure that contains the overall state of the LUO.
- *     It includes the compatibility string, the liveupdate-number, and pointers
- *     to sessions and FLBs.
+ *     It includes the feature header (with struct size and 2-bit feature flag
+ *     pairs), and the core feature (`LUO_CORE_FEAT_CORE`) fields: the
+ *     liveupdate-number and pointers to sessions and FLBs.
  *
  *   - struct luo_session_ser:
  *     Metadata for a single session, including its name and a physical pointer
@@ -40,8 +75,9 @@
  *
  *   - struct luo_file_ser:
  *     Metadata for a single preserved file. Contains the handler `name` string
- *     to find the correct handler in the new kernel, a user-provided `token`
- *     for identification, and an opaque `data` handle for the handler to use.
+ *     to find the correct handler in the target kernel, a user-provided
+ *     `token` for identification, and an opaque `data` handle for the handler
+ *     to use.
  *
  *   - struct luo_flb_header_ser:
  *     Header for the FLB array. Contains the total page count of the
@@ -57,20 +93,265 @@
 #ifndef _LINUX_KHO_ABI_LUO_H
 #define _LINUX_KHO_ABI_LUO_H
 
-#include <linux/align.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/build_bug.h>
+#include <linux/errno.h>
 #include <linux/kho/abi/block.h>
+#include <linux/types.h>
 #include <uapi/linux/liveupdate.h>
 
 /*
  * The LUO state is registered under this KHO entry name.
  */
 #define LUO_KHO_ENTRY_NAME	"LUO"
-#define LUO_ABI_COMPATIBLE	"luo-v5"
-#define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
+
+#define LUO_FEAT_PER_FLAGS	31
+#define LUO_FEAT_NR_FLAGS	15
+#define LUO_FEAT_MAX		(LUO_FEAT_NR_FLAGS * LUO_FEAT_PER_FLAGS)
+#define LUO_FEAT_EXT_MASK	GENMASK_ULL(63, 62)
+#define LUO_FEAT_ACTIVE_MASK	(0x5555555555555555ULL & ~LUO_FEAT_EXT_MASK)
+#define LUO_FEAT_REQ_MASK	(0xaaaaaaaaaaaaaaaaULL & ~LUO_FEAT_EXT_MASK)
+
+#define LUO_FEAT_FLAGS_IDX(f)	((unsigned int)(f) / LUO_FEAT_PER_FLAGS)
+#define LUO_FEAT_SLOT(f)	((unsigned int)(f) % LUO_FEAT_PER_FLAGS)
+
+#define LUO_FEAT_ACTIVE(f)	BIT_ULL(2 * LUO_FEAT_SLOT(f))
+#define LUO_FEAT_REQ(f)		BIT_ULL(2 * LUO_FEAT_SLOT(f) + 1)
+
+/**
+ * enum luo_feat_state - 2-bit state of a LUO feature (`0b<req><active>`).
+ * @LUO_FEAT_DISABLED: Feature is inactive (`req=0, active=0`).
+ * @LUO_FEAT_OPTIONAL: Feature is active and optional (`req=0, active=1`).
+ * @LUO_FEAT_REQUIRED: Feature is active and required (`req=1, active=1`).
+ */
+enum luo_feat_state {
+	LUO_FEAT_DISABLED = 0b00,
+	LUO_FEAT_OPTIONAL = 0b01,
+	LUO_FEAT_REQUIRED = 0b11,
+};
+
+/**
+ * struct luo_feature_hdr - Fixed 128-byte header for serialized LUO ABI structures.
+ * @size:  Size in bytes of the source kernel's enclosing serialized structure.
+ * @flags: Chained 64-bit feature flags entries (`0 .. LUO_FEAT_NR_FLAGS - 1`).
+ *         Each entry holds 31 2-bit feature pairs (`[2*slot + 1 : 2*slot]`)
+ *         plus %LUO_FEAT_EXT_MASK in bits `[63:62]` when the next entry is
+ *         active.
+ */
+struct luo_feature_hdr {
+	u64 size;
+	u64 flags[LUO_FEAT_NR_FLAGS];
+} __packed;
+
+static_assert(sizeof(struct luo_feature_hdr) == 128);
+
+/**
+ * luo_feature_hdr_for_each_flags - Iterate over chained flags entries in @hdr.
+ * @hdr: Pointer to the &struct luo_feature_hdr to iterate.
+ * @idx: Loop cursor of type `unsigned int` (`0 .. LUO_FEAT_NR_FLAGS - 1`).
+ */
+#define luo_feature_hdr_for_each_flags(hdr, idx)			\
+	for ((idx) = 0; (idx) < LUO_FEAT_NR_FLAGS;			\
+	     (idx) = (((hdr)->flags[idx] & LUO_FEAT_EXT_MASK) ==	\
+		      LUO_FEAT_EXT_MASK) ? (idx) + 1 : LUO_FEAT_NR_FLAGS)
+
+/**
+ * luo_feature_hdr_get_flags - Get the flags entry containing feature @feat.
+ * @hdr:  Pointer to the source kernel's feature header.
+ * @feat: Feature index (`0 .. LUO_FEAT_MAX - 1`).
+ *
+ * Return: The u64 flags entry containing @feat if the extension chain reaches
+ *         it, or 0 otherwise.
+ */
+static inline u64
+luo_feature_hdr_get_flags(const struct luo_feature_hdr *hdr,
+			  unsigned int feat)
+{
+	unsigned int target_idx = LUO_FEAT_FLAGS_IDX(feat);
+	unsigned int idx;
+
+	if (target_idx >= LUO_FEAT_NR_FLAGS)
+		return 0;
+
+	luo_feature_hdr_for_each_flags(hdr, idx) {
+		if (idx == target_idx)
+			return hdr->flags[idx];
+	}
+
+	return 0;
+}
+
+/**
+ * luo_feature_is_active - Test whether feature @feat is active in @hdr.
+ * @hdr:  Pointer to the source kernel's feature header.
+ * @feat: Feature index (`0 .. LUO_FEAT_MAX - 1`).
+ *
+ * Return: true if the source kernel marked @feat active, false otherwise.
+ */
+static inline bool luo_feature_is_active(const struct luo_feature_hdr *hdr,
+					 unsigned int feat)
+{
+	return luo_feature_hdr_get_flags(hdr, feat) & LUO_FEAT_ACTIVE(feat);
+}
+
+/**
+ * luo_feature_is_req - Test whether feature @feat is required in @hdr.
+ * @hdr:  Pointer to the source kernel's feature header.
+ * @feat: Feature index (`0 .. LUO_FEAT_MAX - 1`).
+ *
+ * Return: true if the source kernel marked @feat required, false otherwise.
+ */
+static inline bool luo_feature_is_req(const struct luo_feature_hdr *hdr,
+				      unsigned int feat)
+{
+	return luo_feature_hdr_get_flags(hdr, feat) & LUO_FEAT_REQ(feat);
+}
+
+/**
+ * luo_feature_pack_entry - Pack up to 31 feature states into a flags entry.
+ * @features:    Array of &enum luo_feat_state values indexed by feature ID.
+ * @nr_features: Number of elements in @features.
+ * @idx:         Flags entry index (`0 .. LUO_FEAT_NR_FLAGS - 1`).
+ *
+ * Return: The packed 64-bit flags entry for @idx (without %LUO_FEAT_EXT_MASK).
+ */
+static inline u64
+luo_feature_pack_entry(const u8 *features, size_t nr_features,
+		       unsigned int idx)
+{
+	unsigned int base = idx * LUO_FEAT_PER_FLAGS;
+	unsigned int slot;
+	u64 flags = 0;
+
+	for (slot = 0; slot < LUO_FEAT_PER_FLAGS && base + slot < nr_features;
+	     slot++)
+		flags |= (u64)(features[base + slot] & 0b11) << (2 * slot);
+
+	return flags;
+}
+
+/**
+ * __luo_feature_hdr_init - Initialize a serialized LUO feature header.
+ * @hdr:         Pointer to the feature header to initialize.
+ * @size:        Byte size of the enclosing serialized structure.
+ * @features:    Array of &enum luo_feat_state values for the source kernel.
+ * @nr_features: Number of elements in @features (`<= LUO_FEAT_MAX`).
+ */
+static inline void
+__luo_feature_hdr_init(struct luo_feature_hdr *hdr, u64 size,
+		       const u8 *features, size_t nr_features)
+{
+	bool ext = false;
+	int idx;
+
+	hdr->size = size;
+	for (idx = LUO_FEAT_NR_FLAGS - 1; idx >= 0; idx--) {
+		u64 flags = luo_feature_pack_entry(features, nr_features, idx);
+
+		WARN_ON_ONCE(((flags & LUO_FEAT_REQ_MASK) >> 1) &
+			     ~(flags & LUO_FEAT_ACTIVE_MASK));
+		if (ext)
+			flags |= LUO_FEAT_EXT_MASK;
+		else if (flags)
+			ext = true;
+		hdr->flags[idx] = flags;
+	}
+}
+
+/**
+ * luo_feature_hdr_init - Initialize a serialized LUO feature header.
+ * @hdr:      Pointer to the feature header to initialize.
+ * @size:     Byte size of the enclosing serialized structure.
+ * @features: Fixed-size `u8` array of &enum luo_feat_state entries.
+ */
+#define luo_feature_hdr_init(hdr, size, features)			\
+({									\
+	BUILD_BUG_ON(ARRAY_SIZE(features) > LUO_FEAT_MAX);		\
+	__luo_feature_hdr_init(hdr, size, features,			\
+			       ARRAY_SIZE(features));			\
+})
+
+/**
+ * __luo_feature_hdr_validate - Validate a source kernel's LUO feature header
+ *                              against the target kernel's feature array.
+ * @hdr:         Pointer to the feature header from the source kernel.
+ * @features:    Array of &enum luo_feat_state values for the target kernel.
+ * @nr_features: Number of elements in @features (`<= LUO_FEAT_MAX`).
+ *
+ * Return: 0 if compatible, -EINVAL on malformed header or `(req=1, active=0)`
+ *         feature state, or -EOPNOTSUPP on required feature mismatch.
+ */
+static inline int
+__luo_feature_hdr_validate(const struct luo_feature_hdr *hdr,
+			   const u8 *features, size_t nr_features)
+{
+	bool src_ext = true, target_ext = (nr_features > 0);
+	unsigned int idx;
+
+	if (hdr->size < sizeof(*hdr))
+		return -EINVAL;
+
+	for (idx = 0; idx < LUO_FEAT_NR_FLAGS && (src_ext || target_ext); idx++) {
+		u64 src = src_ext ? hdr->flags[idx] : 0;
+		u64 target = target_ext ?
+			luo_feature_pack_entry(features, nr_features, idx) : 0;
+		u64 ext = src & LUO_FEAT_EXT_MASK;
+		u64 src_act = src & LUO_FEAT_ACTIVE_MASK;
+		u64 src_req = (src & LUO_FEAT_REQ_MASK) >> 1;
+		u64 target_act = target & LUO_FEAT_ACTIVE_MASK;
+		u64 target_req = (target & LUO_FEAT_REQ_MASK) >> 1;
+
+		if (ext && (ext != LUO_FEAT_EXT_MASK ||
+			    idx == LUO_FEAT_NR_FLAGS - 1))
+			return -EINVAL;
+		if (src_req & ~src_act)
+			return -EINVAL;
+		if (WARN_ON_ONCE(target_req & ~target_act))
+			return -EINVAL;
+		if ((src_req & ~target_act) || (target_req & ~src_act))
+			return -EOPNOTSUPP;
+
+		src_ext = (ext == LUO_FEAT_EXT_MASK);
+		target_ext = ((idx + 1) * LUO_FEAT_PER_FLAGS < nr_features);
+	}
+
+	return 0;
+}
+
+/**
+ * luo_feature_hdr_validate - Validate a source kernel's LUO feature header
+ *                            against the target kernel's feature array.
+ * @hdr:      Pointer to the feature header from the source kernel.
+ * @features: Fixed-size `u8` array of &enum luo_feat_state entries.
+ *
+ * Return: 0 if compatible, -EINVAL on malformed header or feature state, or
+ *         -EOPNOTSUPP on required feature mismatch.
+ */
+#define luo_feature_hdr_validate(hdr, features)				\
+({									\
+	BUILD_BUG_ON(ARRAY_SIZE(features) > LUO_FEAT_MAX);		\
+	__luo_feature_hdr_validate(hdr, features,			\
+				   ARRAY_SIZE(features));		\
+})
+
+/**
+ * enum luo_core_feature - Feature indices for &struct luo_ser.
+ * @LUO_CORE_FEAT_CORE: Core feature covering `liveupdate_num`, `sessions_pa`,
+ *                      and `flbs_pa`.
+ * @LUO_CORE_FEAT_MAX:  Number of defined &enum luo_core_feature features.
+ */
+enum luo_core_feature {
+	LUO_CORE_FEAT_CORE = 0,
+	LUO_CORE_FEAT_MAX,
+};
+
+static_assert((int)LUO_CORE_FEAT_MAX <= LUO_FEAT_MAX);
 
 /**
  * struct luo_ser - Centralized LUO ABI header.
- * @compatible:     Compatibility string identifying the LUO ABI version.
+ * @features:       ABI feature and size header for luo_ser.
  * @liveupdate_num: A counter tracking the number of successful live updates.
  * @sessions_pa:    Physical address of the first session block header.
  * @flbs_pa:        Physical address of the FLB header.
@@ -78,7 +359,7 @@
  * This structure is the root of all preserved LUO state.
  */
 struct luo_ser {
-	char compatible[LUO_ABI_COMPAT_LEN];
+	struct luo_feature_hdr features;
 	u64 liveupdate_num;
 	u64 sessions_pa;
 	u64 flbs_pa;
@@ -90,7 +371,7 @@ struct luo_ser {
  * @data:        Private data
  * @token:       User provided token for this file
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Layout changes must be gated by a required feature in &enum luo_core_feature.
  */
 struct luo_file_ser {
 	char name[LIVEUPDATE_HNDL_NAME_LENGTH];
@@ -121,10 +402,10 @@ struct luo_file_set_ser {
  *
  * This structure is used to package session-specific metadata for transfer
  * between kernels via Kexec Handover. An array of these structures (one per
- * session) is created and passed to the new kernel, allowing it to reconstruct
- * the session context.
+ * session) is created and passed to the target kernel, allowing it to
+ * reconstruct the session context.
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Layout changes must be gated by a required feature in &enum luo_core_feature.
  */
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
@@ -145,7 +426,7 @@ struct luo_session_ser {
  * This structure is located at the physical address specified by the
  * flbs_pa in luo_ser.
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Layout changes must be gated by a required feature in &enum luo_core_feature.
  */
 struct luo_flb_header_ser {
 	u64 pgcnt;
@@ -155,19 +436,19 @@ struct luo_flb_header_ser {
 /**
  * struct luo_flb_ser - Represents the serialized state of a single FLB object.
  * @name:    The unique name string of the FLB object, used to find the
- *           corresponding &struct liveupdate_flb handler in the new kernel.
+ *           corresponding &struct liveupdate_flb in the target kernel.
  * @data:    The opaque u64 handle returned by the FLB's .preserve() operation
- *           in the old kernel. This handle encapsulates the entire state needed
- *           for restoration.
+ *           in the source kernel. This handle encapsulates the entire state
+ *           needed for restoration.
  * @count:   The reference count at the time of serialization; i.e., the number
  *           of preserved files that depended on this FLB. This is used by the
- *           new kernel to correctly manage the FLB's lifecycle.
+ *           target kernel to correctly manage the FLB's lifecycle.
  *
  * An array of these structures is created in a preserved memory region and
- * passed to the new kernel. Each entry allows the LUO core to restore one
- * global, shared object.
+ * passed to the target kernel. Each entry allows the LUO core to restore
+ * one global, shared object.
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Layout changes must be gated by a required feature in &enum luo_core_feature.
  */
 struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_NAME_LENGTH];
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..3627a206a79c 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -70,6 +70,10 @@ static struct {
 	u64 liveupdate_num;
 } luo_global;
 
+static const u8 luo_core_features[LUO_CORE_FEAT_MAX] = {
+	[LUO_CORE_FEAT_CORE] = LUO_FEAT_REQUIRED,
+};
+
 /*
  * luo_register_rwlock - Protects registration of file handlers and FLBs.
  */
@@ -107,15 +111,21 @@ static int __init luo_early_startup(void)
 		return 0;
 	}
 
-	if (len < sizeof(*luo_ser)) {
-		pr_err("LUO state is too small (%zu < %zu)\n", len, sizeof(*luo_ser));
-		return -EINVAL;
+	luo_ser = phys_to_virt(luo_ser_phys);
+	if (len < sizeof(luo_ser->features) || luo_ser->features.size > len) {
+		pr_err("LUO state size invalid (source kernel header size=%llu, KHO len=%zu)\n",
+		       len >= sizeof(luo_ser->features) ? luo_ser->features.size : 0,
+		       len);
+		err = -EINVAL;
+		goto out_free_ser;
 	}
 
-	luo_ser = phys_to_virt(luo_ser_phys);
-	if (strncmp(luo_ser->compatible, LUO_ABI_COMPATIBLE, LUO_ABI_COMPAT_LEN)) {
-		pr_err("LUO state is incompatible with '%s'\n", LUO_ABI_COMPATIBLE);
-		return -EINVAL;
+	err = luo_feature_hdr_validate(&luo_ser->features, luo_core_features);
+	if (err) {
+		pr_err("LUO state feature header validation failed (size=%llu, flags[0]=%#llx): %pe\n",
+		       luo_ser->features.size, luo_ser->features.flags[0],
+		       ERR_PTR(err));
+		goto out_free_ser;
 	}
 
 	luo_global.liveupdate_num = luo_ser->liveupdate_num;
@@ -162,7 +172,8 @@ static int __init luo_state_setup(void)
 		return PTR_ERR(luo_ser);
 	}
 
-	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
+	luo_feature_hdr_init(&luo_ser->features, sizeof(*luo_ser),
+			     luo_core_features);
 	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
 
 	luo_session_setup_outgoing(&luo_ser->sessions_pa);
-- 
2.56.0.212.g129ede20d9-goog

