Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6335CBCB
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402905; cv=none; b=RVgQCX4M8hk2LLLD2u/687y0KDuR5yjmBoFOpUAN4Cp2cXOY2aIepaLQE6jjHqIWyefuGkuIl73lrXR+9UkLoRe9KaOt7GCQSRMLD2es23pcEfJ1KvpA1QR7G7oBqDZOMU/2lqSyaOBo+XZOzi8+FUv8C4gs3Z3J3B4IT5vLxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402905; c=relaxed/simple;
	bh=/wgIjAR3Nkn0dkLJ5F4noRZR2nevYpV3/NPEpvosUDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iGimMR3MGCKtbmcm2ltxGtu5BwaNdkjkm99aZh/Od7dF4vxPaR+TiPv9SXFjcLol4GZUzdyFG/UN9YmznvUn+L/bZlfQbdUaF9HIuITj1EYPdbLeh4aoNppMiIGCfJyW0yaIGsNQcX75DrZQ35p7RVjeHkpczN3oP7T/KSVCduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3lZ6ICk; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--loganodell.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3lZ6ICk"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-385d2703b64so551898a91.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 19:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788402898; x=1789007698; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1Sj3SZIoFO1IrO+MibWwCI7jpIestNZ9bFRqEQ8nhA=;
        b=f3lZ6ICkbIJFpDxVz8UVHh9oCNeKKlpg0O7UGb/r6FHUQJ/RKpTjOxD1wu1bMtUt+T
         jonCDqyWb0xSrgy59OkMklvqlrUGhdcjwoZUKlZLDgY6mZNIedvsM2fn82UU+w5X1/N+
         EjWvmLxlqfUmMl6tjc51y1mmXx0POeRVSi1TX8prirOYD65FAHWEMRBMx+KmFvMSu4tE
         Rpq0Jjx25HoQyCpC7YoI32m2caYtHzixf5Ytl2Y98AlRgwozi/+PEECuQMv7An49n45K
         XapHRLYx02/uobXZOAUW07ETGunKzmH5sD+bodXHMI74YFcVbu2gcWHB4zEIL+g0lEBB
         aaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402898; x=1789007698;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1Sj3SZIoFO1IrO+MibWwCI7jpIestNZ9bFRqEQ8nhA=;
        b=UUSz7gzfBRADvT4PNiBdTvSf39QilWCfgKTxTT5FHJfZIiK98pTwk+m2NmmqaSm9Rx
         X/V4hkCsNEOjylSgen15z9VKTZJF1KXXbrALLT2aU0HTrJemY4d2EvZ4MQMUdFjXU9Yv
         6AIQ99abS/TkGoNCNFyj9RnPs54dpeYv6gSbVLHm7zM64VhUc2upGmZT8EsXjIMjG/JY
         QmnpNT4fPF9p8ldBUzQkq9hYvwNM/7qo6rqro7nNma5Xo0DFiUGrTHS1uxA89L7rqxfn
         MRtUr+QDoOnV62Pju02XxyQ3ZNxXu3Kkc6w7OBQ65lPh06UQvvfyruxaContrGz20s7e
         n0hw==
X-Forwarded-Encrypted: i=1; AKwUvBw4wPHM6dBBd35L3TW0tx78HL7Qkkb48x+UK+18Q6hqpCahNlKbZb5WCT7OzZJs5wLbVwggv0edWY4=@vger.kernel.org
X-Gm-Message-State: AFuF++m7OJ/3tfTjmZ7CMAUuueDZ54sz5v9gF2oeQRM2zVPA3CUoEkYg
	Y8+RY61pltdkzEhzlhS0TpLdYWbQiiG23tftKEVHN7mLapYgGfPdJErBob6SjRNDsjJklUH6Qnm
	Lck2XLnb+W1+Xj5dLNIpSXQ==
X-Received: from dybdb19.prod.google.com ([2002:a05:7300:b093:b0:328:684d:3f7])
 (user=loganodell job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b04:b0:396:4ce0:6400 with SMTP id 98e67ed59e1d1-39b07f33963mr3591851a91.2.1788402897557;
 Wed, 02 Sep 2026 19:34:57 -0700 (PDT)
Date: Wed,  2 Sep 2026 19:34:51 -0700
In-Reply-To: <20260903023452.721732-1-loganodell@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903023452.721732-1-loganodell@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903023452.721732-3-loganodell@google.com>
Subject: [RFC PATCH 2/3] luo: Export feature support to vmlinux section
From: Logan Odell <loganodell@google.com>
To: arnd@arndb.de, pasha.tatashin@soleen.com, rppt@kernel.org, 
	pratyush@kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, maz@kernel.org, oupton@kernel.org, seanjc@google.com, 
	bhelgaas@google.com, alex@shazbot.org, jgg@nvidia.com, kevin.tian@intel.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	Logan Odell <loganodell@google.com>
Content-Type: text/plain; charset="UTF-8"

Create a liveupdate_features section that contains the feature
information for a given liveupdate component. Add the LUO component
first. These can be compared between two kernels to determine live
update compatibility. Features marked as required in the running kernel
will need to have that feature marked as supported in the next kernel to
be eligible for compatibility.

Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Logan Odell <loganodell@google.com>
---
 include/asm-generic/vmlinux.lds.h | 12 +++++++++++
 include/linux/kho/abi/luo.h       | 34 +++++++++++++++++++++++++++++++
 include/linux/liveupdate.h        | 12 +++++++++++
 kernel/liveupdate/luo_core.c      | 16 +++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..aed4e282a78c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -359,6 +359,17 @@
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_LIVEUPDATE
+#define LIVEUPDATE_FEATURES						\
+	. = ALIGN(8);							\
+	.liveupdate_features : AT(ADDR(.liveupdate_features) - LOAD_OFFSET) {	\
+		KEEP(*(.liveupdate_sec_hdr))				\
+		KEEP(*(.liveupdate_features))				\
+	}
+#else
+#define LIVEUPDATE_FEATURES
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -554,6 +565,7 @@
 	RO_EXCEPTION_TABLE						\
 	NOTES								\
 	BTF								\
+	LIVEUPDATE_FEATURES						\
 									\
 	. = ALIGN((align));						\
 	__end_rodata = .;
diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 0a7662a0cf9a..5b25e1b48cf5 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -230,4 +230,38 @@ struct luo_flb_ser {
 #define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
 #endif
 
+#define LIVEUPDATE_VER_HDR_MAGIC	0x4c565550 /* 'LVUP' */
+#define LIVEUPDATE_VER_HDR_VER		1
+
+/**
+ * struct liveupdate_ver_hdr - Header of vmlinux section with version lists
+ * @magic:     Magic number ('LVUP').
+ * @version:   Version of the header format.
+ *
+ * This struct is the header for the vmlinux section ".liveupdate_features". The
+ * section contains the list of feature/version entries that the kernel supports.
+ */
+struct liveupdate_ver_hdr {
+	u32 magic;
+	u32 version;
+} __packed;
+
+/**
+ * struct liveupdate_feature_entry - Live update feature/version entry
+ * @name:       Name of the subsystem or feature ("luo" for core).
+ * @feat_bytes: Number of bytes covered by supp, req, and active bitmaps (e.g. 8).
+ * @reserved:   Reserved / padding for alignment.
+ * @supp:       Bitmask of supported features.
+ * @req:        Bitmask of required features.
+ * @active:     Bitmask of active features.
+ */
+struct liveupdate_feature_entry {
+	char name[LIVEUPDATE_HNDL_COMPAT_LENGTH];
+	u32 feat_bytes;
+	u32 reserved;
+	u64 supp;
+	u64 req;
+	u64 active;
+} __packed;
+
 #endif /* _LINUX_KHO_ABI_LUO_H */
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 6051abc0612c..e058df23fed1 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -229,6 +229,16 @@ struct liveupdate_flb {
 
 #ifdef CONFIG_LIVEUPDATE
 
+#define LIVEUPDATE_FEATURE_ENTRY(_id, _name, _supp, _req, _active)	\
+	static const struct liveupdate_feature_entry __lu_feat_##_id	\
+	__used __section(".liveupdate_features") __aligned(8) = {	\
+		.name       = _name,					\
+		.feat_bytes = sizeof(u64),				\
+		.supp       = (_supp),					\
+		.req        = (_req),					\
+		.active     = (_active),				\
+	}
+
 /* Return true if live update orchestrator is enabled */
 bool liveupdate_enabled(void);
 
@@ -259,6 +269,8 @@ int liveupdate_get_token_outgoing(struct liveupdate_session *s,
 
 #else /* CONFIG_LIVEUPDATE */
 
+#define LIVEUPDATE_FEATURE_ENTRY(_id, _name, _supp, _req, _active)
+
 static inline bool liveupdate_enabled(void)
 {
 	return false;
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 6add1ecc463f..27413f895174 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -64,6 +64,22 @@
 #include "kexec_handover_internal.h"
 #include "luo_internal.h"
 
+/*
+ * This is the header for the ".liveupdate_features" section in vmlinux.
+ * The linker makes sure that this header precedes the entries.
+ */
+static const struct liveupdate_ver_hdr ver_hdr
+	__used __section(".liveupdate_sec_hdr") __aligned(8) = {
+	.magic   = LIVEUPDATE_VER_HDR_MAGIC,
+	.version = LIVEUPDATE_VER_HDR_VER,
+};
+
+/* Core LUO features */
+LIVEUPDATE_FEATURE_ENTRY(luo_core, "luo",
+			 LUO_CORE_FEATURES_SUPP,
+			 LUO_CORE_FEATURES_REQ,
+			 LUO_CORE_FEATURES_ACTIVE);
+
 static struct {
 	bool enabled;
 	struct luo_ser *luo_ser_out;
-- 
2.55.0.979.g7e5102b832-goog

