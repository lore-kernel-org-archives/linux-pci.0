Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB4344DAA
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780780; cv=none; b=vBG5JQaqaeotBwsM+slkygfZrt7IJcrIFiqze6hkVo5ujtzdoL20ah8YnjtxSwnHONFyGe2n4oE/sS9ztDL/WdUFleQ96IARDKhatHZBBYLoSk0EA79SCHLpRJJ+YG/Kj1r4EosWlzlVQnRTOb4DeDvezpCNA+vx70TRvCYN6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780780; c=relaxed/simple;
	bh=LeL9rMOoVhCYJDLJkyeUhx+7gewNtABy5Yqg9bwzEIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZALALVn0iNJTQdtpCppNfL9a2aVUbBCgr5hv3mksLxhOAk0MlVefx/1ITgFhzH7aUM230b6byu4mxEggV4oOlPll/ukK48ZsP7iA0mYa7o3ghaXacs1IuY43itrGGAniNVDKROGgiLupyP6VDN2Evwlq0/5g1J1VsrANyZPXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTShwKvq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTShwKvq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e1d3e4dc4so11843a12.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780778; x=1771385578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94DHUwq8TzwnOUxAyFNL8ck6qlmcEGwk0NGsy0qgL20=;
        b=FTShwKvqwIrPKd6U3EjJxwAF008fBB6OJUISw15YoqS5H+/aMBuM6ZFnDDYptkeMdO
         INF9H1Fne2FqDBnbDdby+CFW6IaVJndLHMPgL8CfafNW5xM9AjuSoLi1+tFZ1FTqOxMx
         /cZMy4PE1hK+SHpeapjQuauBmIr6OdW6uI87F6iDbBhpolhhFrrCnwOJPd1p+DzYxjVz
         Rnq6kQ6FKUUF6s5co963JsugZZoPh7AKShC9L8tInB9utgr5oLbcCLpIVRPxsCwl6V8v
         OfzIYcqvenjpRdCijMlOXXGwJCPECTxQlZSN7gYNxYuftZejEPHWNErZ1FUfe8sjjI2G
         hCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780778; x=1771385578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94DHUwq8TzwnOUxAyFNL8ck6qlmcEGwk0NGsy0qgL20=;
        b=D34QgHL94l6//sX/HkXFWb53aY91/a+OletVXkBLd2aZTKfdOSmdUkgFpcGfUFURIh
         vrN0EHf/TSaUONcCJ7QIEvtUb/I9ktUrqB4vY96hYzPvQjPr7YZ99ahWUyJIW7yE1UcH
         Xmen/1NBL1r85h/2KVeTQPWTH7Ou23MfGpOOH4Wz8C9XUL/6BwMO69OgZM38Zga5gXNp
         m4rvrD6NkD5xxPGG8+HNOGkRh/calzlLuyDu2l5XArcxiyhLAsCgI5/Kyn69yXvbeEOm
         K3KcRkLiq1810tK3RQYjGGezn/7qpzhHKCDyZbZYPd1X4NqaLYznbv04O5arFZJgSzn9
         uksg==
X-Forwarded-Encrypted: i=1; AJvYcCU+1Zsn508YDvhHMS+v+uN0JhAsxJoJrr5wW5vJD6YA8iBSe9TrjIddkynSkDf9OC6Bo9Z8iiPy3qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyIhJnGIjdD0/j/tk+nZjWvYSThqituSBCDJ9CrfhlbrBJczqD
	fvp/7a00LuvPeCO7En72A3zRAsZ6Zooq82pdscimJa2Tmvn0baPfUUa2
X-Gm-Gg: AZuq6aJ63YZ1+9/PJbku+Y4Y/wgQEpydrl2c4fvj00BP30XY1OKGHpospVTWIp2UcQS
	1LcShrsE+hPFMPYzSggU54261IS9CGOIYW7nOfWF6OBXL5qyX1BX0ItYxuKYCl3KO+JNNdJo5zn
	oXEyCQ6K1CGaerscV8DzM49UQvX0ijyXws4KY04DvXJnzXhwp+ENzXF9utxLhRE6N/FMDuiWCb8
	Q0JO1LUO4whX7+kcvEuJ0PGObD0vBKTzEuO/22xf4M0dLPRYPSPrAe5HuXUkJQhUZF1M5QMLq5o
	2RstDrYJPaVGxsn+3KVK+BWXPhgxKRixfjOGuT7xjI2kny9DfQnVihgujkLJjezoP0fv+9YJdFU
	2vDTUgywrQp8Ds770fhal31n7M2/FVIK+AdwGqXBPujk0F5mVQIra5G0Tn6NdymTdcHh6q/3nnl
	z7xr9zm6rAUT9+NCmrha/cTqx2p/3/VIFqnB6pZflI/Q==
X-Received: by 2002:a05:6300:2206:b0:366:14af:9bd2 with SMTP id adf61e73a8af0-393ad3a27aamr17344339637.72.1770780778321;
        Tue, 10 Feb 2026 19:32:58 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:57 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 27/27] rspdm: Multicast received signatures via netlink
Date: Wed, 11 Feb 2026 13:29:34 +1000
Message-ID: <20260211032935.2705841-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

This is based on Lukas's patch from [1]. This exposes all of the SPDM
information to userspace via netlink. This includes the certificate
chain and communication transcript.

1: https://github.com/l1k/linux/commit/fe90b5700ee9bc595a21c030192eac4060eaeae1

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Jérôme Glisse <jglisse@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
[ Change by AF:
 - Fixup yaml spec issues
 - Include certificate chain
 - Port to support Rust SPDM
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 Documentation/netlink/specs/spdm.yaml | 136 ++++++++++++++++++
 include/uapi/linux/spdm_netlink.h     |  49 +++++++
 lib/rspdm/Makefile                    |   1 +
 lib/rspdm/netlink-autogen.c           |  33 +++++
 lib/rspdm/netlink-autogen.h           |  22 +++
 lib/rspdm/req-netlink.c               | 197 ++++++++++++++++++++++++++
 lib/rspdm/spdm.h                      |  28 ++++
 lib/rspdm/state.rs                    |  52 +++++++
 rust/bindings/bindings_helper.h       |   4 +
 9 files changed, 522 insertions(+)
 create mode 100644 Documentation/netlink/specs/spdm.yaml
 create mode 100644 include/uapi/linux/spdm_netlink.h
 create mode 100644 lib/rspdm/netlink-autogen.c
 create mode 100644 lib/rspdm/netlink-autogen.h
 create mode 100644 lib/rspdm/req-netlink.c

diff --git a/Documentation/netlink/specs/spdm.yaml b/Documentation/netlink/specs/spdm.yaml
new file mode 100644
index 000000000000..1eb349bdc0d1
--- /dev/null
+++ b/Documentation/netlink/specs/spdm.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: spdm
+
+doc: |
+  DMTF Security Protocol and Data Model (SPDM)
+  https://www.dmtf.org/dsp/DSP0274
+
+protocol: genetlink
+
+uapi-header: linux/spdm_netlink.h
+
+definitions:
+  -
+    type: enum
+    name: spdm-reqrsp-code
+    doc: SPDM request or response code of a signed message (SPDM 1.0.0 table 4)
+    entries:
+      -
+        name: challenge-auth
+      -
+        name: endpoint-info
+      -
+        name: measurements
+      -
+        name: key-exchange-rsp
+      -
+        name: finish
+  -
+    type: enum
+    name: hash-algo
+    doc: SPDM-supported hash algorithm (SPDM 1.0.0 table 13)
+    entries:
+      -
+        name: sha256
+      -
+        name: sha384
+      -
+        name: sha512
+      -
+        name: sha3-256
+      -
+        name: sha3-384
+      -
+        name: sha3-512
+    header: uapi/linux/hash_info.h
+
+attribute-sets:
+  -
+    name: sig
+    doc: |
+      Signature received from a device, together with all ancillary data
+      needed for re-verification.
+
+      Meant for remote attestation services which do not trust the kernel
+      to have verified the signature correctly or which want to apply
+      policy constraints of their own.
+    attributes:
+      -
+        name: device
+        doc: |
+          Path under sysfs of the device generating the signature.
+        type: string
+      -
+        name: rsp-code
+        doc: |
+          SPDM response code of the message containing the signature,
+          to determine what kind of event caused signature generation.
+          Equivalent to the "context" string of SPDM 1.2.0 sec 15,
+          but represented numerically for easier parsing.
+        type: u8
+        enum: spdm-reqrsp-code
+      -
+        name: slot
+        doc: |
+          Certificate slot used for signature generation.  Note that
+          if the slot has since been provisioned with a different
+          certificate chain, re-verification of the signature will fail.
+        type: u8
+      -
+        name: hash-algo
+        doc: |
+          Hash algorithm used for signature generation.
+        type: u16
+        enum: hash-algo
+      -
+        name: sig-offset
+        doc: |
+          Offset of signature in @transcript.  The signature is located
+          at the end of @transcript, hence its size equals @transcript
+          size minus this offset.
+        type: u32
+      -
+        name: req-nonce-offset
+        doc: |
+          Offset of 32 byte nonce chosen by requester in @transcript.
+          Allows remote attestation services to verify freshness
+          (uniqueness) and entropy adequacy of the nonce.
+        type: u32
+      -
+        name: rsp-nonce-offset
+        doc: |
+          Offset of 32 byte nonce chosen by responder in @transcript.
+          Allows remote attestation services to verify freshness
+          (uniqueness) and entropy adequacy of the nonce.
+        type: u32
+      -
+        name: combined-spdm-prefix
+        doc: |
+          Only included in the message with SPDM version 1.2.0 or newer.
+        type: binary
+        checks:
+          exact-len: 100
+      -
+        name: certificate-chain
+        type: binary
+      -
+        name: transcript
+        type: binary
+        multi-attr: true
+
+operations:
+  list:
+    -
+      name: sig
+      doc: Signature event
+      attribute-set: sig
+      event:
+        attributes:
+          - sig
+      mcgrp: sig
+
+mcast-groups:
+  list:
+    -
+      name: sig
diff --git a/include/uapi/linux/spdm_netlink.h b/include/uapi/linux/spdm_netlink.h
new file mode 100644
index 000000000000..a7fa183757db
--- /dev/null
+++ b/include/uapi/linux/spdm_netlink.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/spdm.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _UAPI_LINUX_SPDM_NETLINK_H
+#define _UAPI_LINUX_SPDM_NETLINK_H
+
+#define SPDM_FAMILY_NAME	"spdm"
+#define SPDM_FAMILY_VERSION	1
+
+/*
+ * SPDM request or response code of a signed message (SPDM 1.0.0 table 4)
+ */
+enum spdm_spdm_reqrsp_code {
+	SPDM_SPDM_REQRSP_CODE_CHALLENGE_AUTH,
+	SPDM_SPDM_REQRSP_CODE_ENDPOINT_INFO,
+	SPDM_SPDM_REQRSP_CODE_MEASUREMENTS,
+	SPDM_SPDM_REQRSP_CODE_KEY_EXCHANGE_RSP,
+	SPDM_SPDM_REQRSP_CODE_FINISH,
+};
+
+enum {
+	SPDM_A_SIG_DEVICE = 1,
+	SPDM_A_SIG_RSP_CODE,
+	SPDM_A_SIG_SLOT,
+	SPDM_A_SIG_HASH_ALGO,
+	SPDM_A_SIG_SIG_OFFSET,
+	SPDM_A_SIG_REQ_NONCE_OFFSET,
+	SPDM_A_SIG_RSP_NONCE_OFFSET,
+	SPDM_A_SIG_COMBINED_SPDM_PREFIX,
+	SPDM_A_SIG_CERTIFICATE_CHAIN,
+	SPDM_A_SIG_TRANSCRIPT,
+
+	__SPDM_A_SIG_MAX,
+	SPDM_A_SIG_MAX = (__SPDM_A_SIG_MAX - 1)
+};
+
+enum {
+	SPDM_CMD_SIG = 1,
+
+	__SPDM_CMD_MAX,
+	SPDM_CMD_MAX = (__SPDM_CMD_MAX - 1)
+};
+
+#define SPDM_MCGRP_SIG	"sig"
+
+#endif /* _UAPI_LINUX_SPDM_NETLINK_H */
diff --git a/lib/rspdm/Makefile b/lib/rspdm/Makefile
index f15b1437196b..2f29d0a62c1e 100644
--- a/lib/rspdm/Makefile
+++ b/lib/rspdm/Makefile
@@ -8,4 +8,5 @@
 obj-$(CONFIG_RSPDM) += spdm.o
 
 spdm-y := lib.o
+spdm-$(CONFIG_NET) += req-netlink.o netlink-autogen.o
 spdm-$(CONFIG_SYSFS) += req-sysfs.o
diff --git a/lib/rspdm/netlink-autogen.c b/lib/rspdm/netlink-autogen.c
new file mode 100644
index 000000000000..4dc950133514
--- /dev/null
+++ b/lib/rspdm/netlink-autogen.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/spdm.yaml */
+/* YNL-GEN kernel source */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "netlink-autogen.h"
+
+#include <uapi/linux/spdm_netlink.h>
+#include <uapi/linux/hash_info.h>
+
+/* Ops table for spdm */
+static const struct genl_split_ops spdm_nl_ops[] = {
+};
+
+static const struct genl_multicast_group spdm_nl_mcgrps[] = {
+	[SPDM_NLGRP_SIG] = { "sig", },
+};
+
+struct genl_family spdm_nl_family __ro_after_init = {
+	.name		= SPDM_FAMILY_NAME,
+	.version	= SPDM_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= spdm_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(spdm_nl_ops),
+	.mcgrps		= spdm_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(spdm_nl_mcgrps),
+};
diff --git a/lib/rspdm/netlink-autogen.h b/lib/rspdm/netlink-autogen.h
new file mode 100644
index 000000000000..2797d194604f
--- /dev/null
+++ b/lib/rspdm/netlink-autogen.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/spdm.yaml */
+/* YNL-GEN kernel header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
+
+#ifndef _LINUX_SPDM_GEN_H
+#define _LINUX_SPDM_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/spdm_netlink.h>
+#include <uapi/linux/hash_info.h>
+
+enum {
+	SPDM_NLGRP_SIG,
+};
+
+extern struct genl_family spdm_nl_family;
+
+#endif /* _LINUX_SPDM_GEN_H */
diff --git a/lib/rspdm/req-netlink.c b/lib/rspdm/req-netlink.c
new file mode 100644
index 000000000000..65db5ec6a16c
--- /dev/null
+++ b/lib/rspdm/req-netlink.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Requester role: netlink interface
+ *
+ * Copyright (C) 2025 Intel Corporation
+ * Copyright (C) 2026 WD Corporation
+ */
+
+#include "netlink-autogen.h"
+
+#include <linux/bitfield.h>
+#include <linux/mutex.h>
+#include <linux/spdm.h>
+
+#include <crypto/hash_info.h>
+
+#include "spdm.h"
+
+#define SPDM_NONCE_SZ 32 /* SPDM 1.0.0 table 20 */
+#define SPDM_PREFIX_SZ 64 /* SPDM 1.2.0 margin no 803 */
+#define SPDM_COMBINED_PREFIX_SZ 100 /* SPDM 1.2.0 margin no 806 */
+#define SPDM_MAX_OPAQUE_DATA 1024 /* SPDM 1.0.0 table 21 */
+
+static void spdm_create_combined_prefix(u8 version, const char *spdm_context,
+					void *buf)
+{
+	u8 major = FIELD_GET(0xf0, version);
+	u8 minor = FIELD_GET(0x0f, version);
+	size_t len = strlen(spdm_context);
+	int rc, zero_pad;
+
+	rc = snprintf(buf, SPDM_PREFIX_SZ + 1,
+		      "dmtf-spdm-v%hhx.%hhx.*dmtf-spdm-v%hhx.%hhx.*dmtf-spdm-v%hhx.%hhx.*dmtf-spdm-v%hhx.%hhx.*",
+		      major, minor, major, minor, major, minor, major, minor);
+	WARN_ON(rc != SPDM_PREFIX_SZ);
+
+	zero_pad = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - 1 - len;
+	WARN_ON(zero_pad < 0);
+
+	memset(buf + SPDM_PREFIX_SZ + 1, 0, zero_pad);
+	memcpy(buf + SPDM_PREFIX_SZ + 1 + zero_pad, spdm_context, len);
+}
+
+int spdm_netlink_sig_event(struct device *dev,
+			   u8 version,
+			   const void *transcript,
+			   size_t transcript_len,
+			   const void *cert_chain,
+			   size_t cert_chain_len,
+			   enum hash_algo base_hash_alg,
+			   size_t sig_len,
+			   int rsp_code, u8 slot,
+			   size_t req_nonce_off, size_t rsp_nonce_off,
+			   const char *spdm_context)
+{
+	unsigned int seq, msg_sz, nr_msgs, nr_pages, nr_frags;
+	struct sk_buff *msg;
+	struct nlattr *nla;
+	void *hdr;
+	const void *ptr;
+	int rc, i;
+
+	if (!genl_has_listeners(&spdm_nl_family, &init_net, SPDM_NLGRP_SIG))
+		return 0;
+
+	char *devpath __free(kfree) = kobject_get_path(&dev->kobj,
+						       GFP_KERNEL);
+	if (!devpath)
+		return -ENOMEM;
+
+	nr_pages = transcript_len / PAGE_SIZE;
+	nr_msgs = DIV_ROUND_UP(nr_pages, MAX_SKB_FRAGS);
+
+	/* Calculate exact size to avoid reallocation by netlink_trim() */
+	msg_sz = nlmsg_total_size(genlmsg_msg_size(
+			nla_total_size(strlen(devpath)) +
+			nla_total_size(sizeof(u8)) +
+			nla_total_size(sizeof(u8)) +
+			nla_total_size(sizeof(u16)) +
+			nla_total_size(sizeof(u32)) +
+			nla_total_size(sizeof(u32)) +
+			nla_total_size(sizeof(u32)) +
+			nla_total_size(SPDM_COMBINED_PREFIX_SZ) +
+			nla_total_size(cert_chain_len) +
+			nla_total_size(0)));
+
+	msg = genlmsg_new(msg_sz, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &spdm_nl_family,
+			  nr_msgs > 1 ? NLM_F_MULTI : 0, SPDM_CMD_SIG);
+	if (!hdr) {
+		rc = -EMSGSIZE;
+		goto err_free_msg;
+	}
+
+	if (nla_put_string(msg, SPDM_A_SIG_DEVICE, devpath) ||
+	    nla_put_u8(msg, SPDM_A_SIG_RSP_CODE, rsp_code) ||
+	    nla_put_u8(msg, SPDM_A_SIG_SLOT, slot) ||
+	    nla_put_u16(msg, SPDM_A_SIG_HASH_ALGO,
+			base_hash_alg) ||
+	    nla_put_u32(msg, SPDM_A_SIG_SIG_OFFSET,
+			transcript_len - sig_len) ||
+	    nla_put_u32(msg, SPDM_A_SIG_REQ_NONCE_OFFSET, req_nonce_off) ||
+	    nla_put_u32(msg, SPDM_A_SIG_RSP_NONCE_OFFSET, rsp_nonce_off)) {
+		rc = -EMSGSIZE;
+		goto err_cancel_msg;
+	}
+
+	if (version >= 0x12) {
+		nla = nla_reserve(msg, SPDM_A_SIG_COMBINED_SPDM_PREFIX,
+				  SPDM_COMBINED_PREFIX_SZ);
+		if (!nla) {
+			rc = -EMSGSIZE;
+			goto err_cancel_msg;
+		}
+
+		spdm_create_combined_prefix(version, spdm_context,
+					    nla_data(nla));
+	}
+
+	if (cert_chain_len >= 0)
+		nla_put(msg, SPDM_A_SIG_CERTIFICATE_CHAIN, cert_chain_len, cert_chain);
+
+	ptr = transcript;
+
+	/* Loop over Netlink messages - break condition is in loop body */
+	for (seq = 1; ; seq++) {
+		nla = nla_reserve(msg, SPDM_A_SIG_TRANSCRIPT, 0);
+		if (!nla) {
+			rc = -EMSGSIZE;
+			goto err_cancel_msg;
+		}
+
+		nr_frags = min(nr_pages, MAX_SKB_FRAGS);
+		nla->nla_len = nr_frags * PAGE_SIZE;
+		nr_pages -= nr_frags;
+
+		/* Loop over fragments of this Netlink message */
+		for (i = 0; i < nr_frags; i++) {
+			struct page *page = vmalloc_to_page(ptr);
+			size_t sz = min(transcript_len, PAGE_SIZE);
+
+			skb_add_rx_frag(msg, i, page, 0, sz, sz);
+			ptr += PAGE_SIZE;
+			transcript_len -= PAGE_SIZE;
+		}
+
+		genlmsg_end(msg, hdr);
+		rc = genlmsg_multicast(&spdm_nl_family, msg, 0,
+				       SPDM_NLGRP_SIG, GFP_KERNEL);
+		if (rc)
+			return rc;
+
+		if (nr_pages == 0) /* End of loop - entire transcript sent */
+			break;
+
+		/* Start new message for remainder of transcript */
+		msg_sz = nlmsg_total_size(genlmsg_msg_size(nla_total_size(0)));
+
+		msg = genlmsg_new(msg_sz, GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		hdr = genlmsg_put(msg, 0, seq, &spdm_nl_family,
+				  NLM_F_MULTI, SPDM_CMD_SIG);
+		if (!hdr) {
+			rc = -EMSGSIZE;
+			goto err_free_msg;
+		}
+	}
+
+	return 0;
+
+err_cancel_msg:
+	nlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return rc;
+}
+
+static int __init spdm_netlink_init(void)
+{
+	return genl_register_family(&spdm_nl_family);
+}
+
+static void __exit spdm_netlink_exit(void)
+{
+	genl_unregister_family(&spdm_nl_family);
+}
+
+arch_initcall(spdm_netlink_init);
+module_exit(spdm_netlink_exit);
diff --git a/lib/rspdm/spdm.h b/lib/rspdm/spdm.h
index 43ef56a073c0..36bc1b47a796 100644
--- a/lib/rspdm/spdm.h
+++ b/lib/rspdm/spdm.h
@@ -12,6 +12,34 @@
 #ifndef _LIB_SPDM_H_
 #define _LIB_SPDM_H_
 
+#include <uapi/linux/hash_info.h>
+
+#ifdef CONFIG_NET
+int spdm_netlink_sig_event(struct device *dev,
+			   u8 version,
+			   const void *transcript,
+			   size_t transcript_len,
+			   const void *cert_chain,
+			   size_t cert_chain_len,
+			   enum hash_algo base_hash_alg,
+			   size_t sig_len,
+			   int rsp_code, u8 slot,
+			   size_t req_nonce_off, size_t rsp_nonce_off,
+			   const char *spdm_context);
+#else
+static inline int spdm_netlink_sig_event(struct device *dev,
+			   u8 version,
+			   const void *transcript,
+			   size_t transcript_len,
+			   const void *cert_chain,
+			   size_t cert_chain_len,
+			   enum hash_algo base_hash_alg,
+			   size_t sig_len,
+			   int rsp_code, u8 slot,
+			   size_t req_nonce_off, size_t rsp_nonce_off,
+			   const char *spdm_context) { return 0; }
+#endif
+
 int spdm_chall(struct spdm_state *spdm_state);
 
 #endif /* _LIB_SPDM_H_ */
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index a4d803af48fe..8b18e415d4d5 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -13,6 +13,7 @@
 use kernel::{
     bindings,
     error::{code::EINVAL, from_err_ptr, to_result, Error},
+    page::PAGE_SIZE,
     str::CStr,
     str::CString,
     validate::Untrusted,
@@ -1036,6 +1037,57 @@ pub(crate) fn challenge(&mut self, slot: u8, verify: bool) -> Result<(), Error>
             };
         }
 
+        let spdm_context = b"responder-challenge_auth signing\0";
+
+        let hash_digest_size = if self.base_hash_alg < bindings::hash_algo_HASH_ALGO__LAST {
+            // SAFETY: `base_hash_alg` is a valid offset into `hash_digest_size`
+            (unsafe { bindings::get_hash_digest_size(self.base_hash_alg) }) as usize
+        } else {
+            to_result(-(bindings::EIO as i32))?;
+            0
+        };
+
+        let req_nonce_off = self.transcript.len() + core::mem::offset_of!(ChallengeReq, nonce);
+        let rsp_nonce_off =
+            self.transcript.len() + core::mem::size_of::<ChallengeRsp>() + hash_digest_size;
+
+        // This is the actual transcript length
+        let transcript_len = self.transcript.len();
+
+        // This is how much extra capacity we need to page align the transcript buffer
+        let extra_cap = PAGE_SIZE - transcript_len.rem_euclid(PAGE_SIZE);
+        // Ensure we have the capacity
+        self.transcript.reserve(extra_cap, GFP_KERNEL)?;
+
+        // We know the buffer is this long and this value will be PAGE_SIZE aligned
+        let transcript_buf_len = transcript_len + extra_cap;
+
+        let cert_chain_len = self.certs[slot as usize].len();
+
+        let cert_chain = if cert_chain_len > 0 {
+            self.certs[slot as usize].as_ptr() as *const c_void
+        } else {
+            core::ptr::null_mut()
+        };
+
+        unsafe {
+            bindings::spdm_netlink_sig_event(
+                self.dev,
+                self.version,
+                self.transcript.as_ptr() as *const c_void,
+                transcript_buf_len,
+                cert_chain,
+                cert_chain_len,
+                self.base_hash_alg,
+                self.sig_len,
+                0x03,
+                slot,
+                req_nonce_off,
+                rsp_nonce_off,
+                spdm_context as *const _ as *const u8,
+            );
+        }
+
         Ok(())
     }
 }
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 35e4378fb9dc..64326e5f2490 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -156,3 +156,7 @@ const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
 #include "../../drivers/android/binder/rust_binder_events.h"
 #include "../../drivers/android/binder/page_range_helper.h"
 #endif
+
+#if IS_ENABLED(CONFIG_RSPDM)
+#include "../../lib/rspdm/spdm.h"
+#endif
-- 
2.52.0

