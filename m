Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078816;
	b=QSwSUy4ijZakUVWEi+Bf38ZyOrpiqHjtKgPwUAON6Jo9ujljSBipdKbxt3FEmvx8i6zf
	 TqLq1Lq37n7xxPT71SOrPCZZxBCBaAJQzbx+tvUxfHaYiNX8E2sc7ntasiGteslok0spy
	 CeMEnCawpur4/OWU2WqDrParZ1B8KSGgFUPmff9nXxAL32Twcz9g/iCUXgrCDMUqJyan+
	 OPB2wVZC7nm0UxmfM78veUye2iAFYAle/XBY0IuHzmTOrkB6AFXVNJBaXfICgTp99PGeU
	 PgFJBd6CrSuq+kpS+rsbeF55F9WsxZva5ajjESLY+pbTKqoNaXgqvxNim44xYNzo1Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uWpZkoUcD+11mT8IYyyOzkMFSXWipikoIkz7JmVhAWo=;
	b=5GS640ZhLRg5KQf+IkA6R/BDW/bbVH5Nm4qdcuOPTjEY7DU1UAHgCC6ULFu6Hbr9uBE7
	 IMmxHdchMjr56VflXzGBmJ9z7LDBU7Gk7YhFH1cQ7pY9UEv4onsaHJwIT4aE10lghyN3x
	 yW3dKGLqjBViepTujYe07SCUQpgVcbwZHHsr11pRoK9LsUw94fKt5B6B0zOq8O5iIBLDK
	 kD1c509oPaLvPUESuXyRlGBRHQ44PpjfwPmltRhEnoUiJtXk6pzNEa6w5QRNiW0FZZSNt
	 ijbWzFIM9mh6zYwpiWUeMUe8LiS2wbbqiGa5NhNYIOlvVE6fHhrO2LWWJm/tNnp5S2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=stlmzcfE;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEB606A31E
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDDEB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=stlmzcfE
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8b20a899fso23385495ad.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078814; x=1793683614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uWpZkoUcD+11mT8IYyyOzkMFSXWipikoIkz7JmVhAWo=;
        b=stlmzcfE0yubIwKonY8KIMkzFfeQ5G3tvxrLV3PWv6c04aL+lIquD7U+wxrkxO60HA
         KVd000RR5Z9DE5lo++v/oDKYW4quxHkV2uDY5H+dtAs/Z0ha+LMb8+hd/j+pyFBzk7om
         miV/uxOAjrIcAPGHmeebm/2NOb8fNCE6ESakI/50U5bbyHtGRRt9B2t8Mq33OPkps4F4
         vVJ1KSksyycAk5uLWtrpcXwh+RfdCZyVlGQ9cu8PuL+IYBESjZWEohLTLw+lLtoyTewg
         s2pJG+XYfxTRSV8cqGZOMXyW9sRMNQ76hb75WOIxeQL9sGE/hl0qu0eQZSUwo9lDjIXH
         AKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078814; x=1793683614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uWpZkoUcD+11mT8IYyyOzkMFSXWipikoIkz7JmVhAWo=;
        b=1ck46DQJloyuTO01qhIsuvpWPR4itVH4a3b71Q7KV6mxgSxi96K6lnPcCVk6+2sjbW
         a2lIGqqoC68EiwEgBgKW9ZkO6wAwFpncx+ivMUFmLtB/GD+ay01JzWXBgfHPYTvWTU4S
         O5jkODJMR3T3gt/Eo9Ga14VJQjjFjPRAcBTmHChqufhUyuWMGkqyqmxheBazLg7Qh8L0
         /mELtKLeQp159sxt0sUwpA4UIYREiCIJC43427dTcm25ZzPEfm1XCdnPQYT6HVdkFXL3
         6LVLn0X0ZvQzu6SJpMzpVn38+tOioSmox/yEfrL9lvTo/msnUb3K3pwPjSsOJ8Ts1NSh
         lmqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWPqRCEb58BcPX6Pg8a04LlkUCGcB8L9/b0ScKc871aiaIwluwgk7Mgq5ESN3mJjHLVAful0E0g6k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJXMQJUO69+3N1apzyK2Bjw9oXoawbEmHQY5SW6yEP5qqajrQYG
	KK+w//2L09xkziYEZ609O6Bp06oweUr00EMmcdzBghDTtu1XPxBApHco
X-Gm-Gg: AYBFou2QWFOxSY9SgPxVnS6qAl9BN1HlP86wFRYa8cm1wCu6M0mdyRrVgOhGkDDUlYn
	eE0GuAykcxWX0YrNuz5DCL0VJJ1sKCfuytRNyXg5lpj6CvNTvwg6yOOQHMzgHOuItSDVERPz9ut
	aKkgwXaQey/dVbQtxCRotqnSH1Yvw91VgaQTYQjO+31e2Lniwt4xTRvk/x5MfK3A7/x9cxwwC1y
	EnDIQ/kbvMRiGoPeUnZNfF/OrOieKRTXL/ibCcaxAl2pabjjVLPPboqbAWxT8lexKKSdJQ18O2s
	7dLqrT0oix26KafBumMc3D/wap5UMkh7GVi1e5yv1ek7KywQmRnpOBL977Ki9LwbQdpcjgXkboW
	r/oL5WhWnkKJltuBjStKg9PxJNXu9+9icdXRdJLI7HB5of5zKddzdirCa8o/xtPTNYXMRgNgBEW
	b+kCQI+9yRE6CdmFgam9qku4gBNKIrEVt7fLtTdId3YTKFIC5/dartfluT0i6oLrUch1vVIR3Jq
	5derlQkpWvJEcI8YDnjrPZ4u/T+GWYDphnSpbz5pFuzcpf8FARwjRhk8Xogqv772Ub1hofEWf6N
	fN89ZVTgwrEWui84iFk=
X-Received: by 2002:a17:903:2983:b0:2e9:cd03:b432 with SMTP id d9443c01a7336-2ea9c8fba40mr75320315ad.60.1793078814034;
        Mon, 26 Oct 2026 22:26:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:26:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 09/23] lib: rspdm: Initial commit of Rust SPDM
Date: Tue, 27 Oct 2026 15:25:22 +1000
Message-ID: <20261027052536.1722081-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

This is the initial commit of the Rust SPDM library.

Security Protocols and Data Models (SPDM) [1] is used for authentication,
attestation and key exchange. SPDM is generally used over a range of
transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.

From the kernels perspective SPDM is used to authenticate and attest devices.

This initial commit setups the framework for SPDM support. This uses the
`Validate` and `Untrusted` traits, which means we can treat the
responses as `Untrusted` until we validate them.

The next few patches add SPDM functionality, which allows us to perform
basic authentication.

1: https://www.dmtf.org/standards/spdm

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 MAINTAINERS                     |  12 ++
 include/linux/spdm.h            |  66 ++++++++
 lib/Kconfig                     |  17 +++
 lib/Makefile                    |   2 +
 lib/rspdm/Makefile              |  10 ++
 lib/rspdm/consts.rs             |  18 +++
 lib/rspdm/lib.rs                | 263 ++++++++++++++++++++++++++++++++
 lib/rspdm/state.rs              | 145 ++++++++++++++++++
 lib/rspdm/validator.rs          |  92 +++++++++++
 rust/bindings/bindings_helper.h |   1 +
 10 files changed, 626 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 03649f08c7c75..783da0b234541 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25290,6 +25290,18 @@ M:	Security Officers <security@kernel.org>
 S:	Supported
 F:	Documentation/process/security-bugs.rst
 
+SECURITY PROTOCOL AND DATA MODEL (SPDM)
+M:	Alistair Francis <alistair@alistair23.me>
+M:	Lukas Wunner <lukas@wunner.de>
+M:	Jonathan Cameron <jic23@kernel.org>
+L:	linux-coco@lists.linux.dev
+L:	linux-cxl@vger.kernel.org
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
+F:	include/linux/spdm.h
+F:	lib/rspdm/
+
 SECURITY SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
 M:	James Morris <jmorris@namei.org>
diff --git a/include/linux/spdm.h b/include/linux/spdm.h
new file mode 100644
index 0000000000000..3cd5c1bf01def
--- /dev/null
+++ b/include/linux/spdm.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMTF Security Protocol and Data Model (SPDM)
+ * https://www.dmtf.org/dsp/DSP0274
+ *
+ * Copyright (C) 2021-22 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022-24 Intel Corporation
+ */
+
+#ifndef _SPDM_H_
+#define _SPDM_H_
+
+#include <linux/types.h>
+
+struct key;
+struct device;
+struct spdm_state;
+struct x509_certificate;
+
+typedef int (spdm_transport)(void *priv, struct device *dev,
+			     const void *request, size_t request_sz,
+			     void *response, size_t response_sz);
+
+typedef int (spdm_validate)(struct device *dev, u8 slot,
+			    struct x509_certificate *leaf_cert);
+
+/**
+ * spdm_create() - Allocate SPDM session
+ * @dev: Responder device. Used for error reporting and passed to @transport.
+ * @transport: Transport function to perform one message exchange.
+ * @transport_priv: Transport function private data.
+ * @transport_sz: Maximum message size the transport is capable of
+ *	(in bytes).
+ * @validate: Function to validate additional leaf certificate requirements
+ *	(optional, may be %NULL).
+ *
+ * Return a pointer to the allocated SPDM session state or NULL on error.
+ * The returned session must be freed with spdm_destroy().
+ */
+struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
+			       void *transport_priv, u32 transport_sz,
+			       spdm_validate *validate);
+
+/**
+ * spdm_authenticate() - Authenticate device
+ * @spdm_state: SPDM session state
+ *
+ * Authenticate a device through a sequence of GET_VERSION, GET_CAPABILITIES,
+ * NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE and CHALLENGE exchanges.
+ *
+ * Return 0 on success or a negative errno. In particular, -EPROTONOSUPPORT
+ * indicates authentication is not supported by the device.
+ */
+int spdm_authenticate(struct spdm_state *spdm_state);
+
+/**
+ * spdm_destroy() - Destroy SPDM session
+ * @spdm_state: SPDM session state
+ *
+ * Free a session allocated by spdm_create().
+ */
+void spdm_destroy(struct spdm_state *spdm_state);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 4e6b34c3346d5..b84facfa88bc9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -588,6 +588,23 @@ config LWQ_TEST
 	help
 	  Run boot-time test of light-weight queuing.
 
+config RSPDM
+	bool "Rust SPDM"
+	depends on RUST
+	select KEYS
+	select CRYPTO
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER
+	help
+	  The Rust implementation of the Security Protocol and Data Model (SPDM)
+	  allows for device authentication, measurement, key exchange and
+	  encrypted sessions.
+
+	  Crypto algorithms negotiated with SPDM are limited to those enabled
+	  in .config.  Users of SPDM therefore need to also select
+	  any algorithms they deem mandatory.
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index a2afe954805cb..3a79a3738975f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -297,6 +297,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 obj-$(CONFIG_ASN1) += asn1_decoder.o
 obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
+obj-$(CONFIG_RSPDM) += rspdm/
+
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
 #
diff --git a/lib/rspdm/Makefile b/lib/rspdm/Makefile
new file mode 100644
index 0000000000000..3f5cae33ccb8d
--- /dev/null
+++ b/lib/rspdm/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+# https://www.dmtf.org/dsp/DSP0274
+#
+# Copyright (C) 2026 Western Digital
+
+obj-$(CONFIG_RSPDM) += spdm.o
+
+spdm-y := lib.o
diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
new file mode 100644
index 0000000000000..ef6d61d4998b5
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Constants used by the library
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+// SPDM versions supported by this implementation
+pub(crate) const SPDM_VER_10: u8 = 0x10;
+
+pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
+
+#[allow(dead_code)]
+pub(crate) const SPDM_REQ: u8 = 0x80;
+#[allow(dead_code)]
+pub(crate) const SPDM_ERROR: u8 = 0x7f;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
new file mode 100644
index 0000000000000..27449ac1ca25d
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Top level library for SPDM
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+//!
+//! Top level library, including C compatible public functions to be called
+//! from other subsytems.
+
+use crate::bindings::{
+    spdm_state,
+    EPROTONOSUPPORT, //
+};
+use core::ffi::{
+    c_int,
+    c_void, //
+};
+use core::ptr;
+use kernel::prelude::*;
+use kernel::{
+    alloc::flags,
+    bindings,
+    device::{
+        Bound,
+        Device, //
+    },
+    error::to_result,
+    new_mutex,
+    sync::Mutex,
+    types::ForeignOwnable, //
+};
+
+use crate::state::{SpdmState, Transport};
+
+const __LOG_PREFIX: &[u8] = b"spdm\0";
+
+mod consts;
+mod state;
+mod validator;
+
+/// FFI shim implementing [`Transport`] for C transport functions.
+///
+/// The private data pointer is owned by the C caller; see the safety
+/// requirements of [`spdm_create()`].
+struct CTransport {
+    func: bindings::spdm_transport,
+    priv_: *mut c_void,
+}
+
+impl Transport for CTransport {
+    fn exchange(
+        &self,
+        dev: &Device<Bound>,
+        request: &[u8],
+        response: &mut [u8],
+    ) -> Result<usize, Error> {
+        let func = self.func.ok_or(EINVAL)?;
+
+        // SAFETY: `func` is non-NULL as checked above. By the safety
+        // requirements of `spdm_create()`, `priv_` remains valid until
+        // `spdm_destroy()` is called, and `dev` remains alive and bound for
+        // the lifetime of the session. `request` and `response` are valid
+        // slices that outlive this call, and the callback must not retain
+        // either of them.
+        let length = unsafe {
+            func(
+                self.priv_,
+                dev.as_raw(),
+                request.as_ptr().cast::<c_void>(),
+                request.len(),
+                response.as_mut_ptr().cast::<c_void>(),
+                response.len(),
+            )
+        };
+        to_result(length)?;
+
+        Ok(length as usize)
+    }
+}
+
+#[derive(Clone, Copy, Debug)]
+#[repr(u8)]
+pub(crate) enum SpdmErrorCode {
+    InvalidRequest = 0x01,
+    /// This was removed in version 1.2.0 and is now reserved
+    InvalidSession = 0x02,
+    Busy = 0x03,
+    UnexpectedRequest = 0x04,
+    Unspecified = 0x05,
+    DecryptError = 0x06,
+    UnsupportedRequest = 0x07,
+    RequestInFlight = 0x08,
+    InvalidResponseCode = 0x09,
+    SessionLimitExceeded = 0x0a,
+    SessionRequired = 0x0b,
+    ResetRequired = 0x0c,
+    ResponseTooLarge = 0x0d,
+    RequestTooLarge = 0x0e,
+    LargeResponse = 0x0f,
+    MessageLost = 0x10,
+    InvalidPolicy = 0x11,
+    VersionMismatch = 0x41,
+    ResponseNotReady = 0x42,
+    RequestResynch = 0x43,
+    OperationFailed = 0x44,
+    NoPendingRequests = 0x45,
+    RequestSessionTerminated = 0x46,
+    InvalidState = 0x47,
+    VendorDefinedError = 0xff,
+}
+
+impl TryFrom<u8> for SpdmErrorCode {
+    type Error = Error;
+
+    fn try_from(value: u8) -> Result<Self, Self::Error> {
+        Ok(match value {
+            0x01 => Self::InvalidRequest,
+            0x02 => Self::InvalidSession,
+            0x03 => Self::Busy,
+            0x04 => Self::UnexpectedRequest,
+            0x05 => Self::Unspecified,
+            0x06 => Self::DecryptError,
+            0x07 => Self::UnsupportedRequest,
+            0x08 => Self::RequestInFlight,
+            0x09 => Self::InvalidResponseCode,
+            0x0a => Self::SessionLimitExceeded,
+            0x0b => Self::SessionRequired,
+            0x0c => Self::ResetRequired,
+            0x0d => Self::ResponseTooLarge,
+            0x0e => Self::RequestTooLarge,
+            0x0f => Self::LargeResponse,
+            0x10 => Self::MessageLost,
+            0x11 => Self::InvalidPolicy,
+            0x41 => Self::VersionMismatch,
+            0x42 => Self::ResponseNotReady,
+            0x43 => Self::RequestResynch,
+            0x44 => Self::OperationFailed,
+            0x45 => Self::NoPendingRequests,
+            0x46 => Self::RequestSessionTerminated,
+            0x47 => Self::InvalidState,
+            0xff => Self::VendorDefinedError,
+            _ => return Err(EINVAL),
+        })
+    }
+}
+
+impl From<SpdmErrorCode> for Error {
+    fn from(code: SpdmErrorCode) -> Self {
+        match code {
+            SpdmErrorCode::InvalidRequest => EINVAL,
+            SpdmErrorCode::InvalidSession => EINVAL,
+            SpdmErrorCode::Busy => EBUSY,
+            SpdmErrorCode::UnexpectedRequest => EINVAL,
+            SpdmErrorCode::Unspecified => EINVAL,
+            SpdmErrorCode::DecryptError => EIO,
+            SpdmErrorCode::UnsupportedRequest => EINVAL,
+            SpdmErrorCode::RequestInFlight => EINVAL,
+            SpdmErrorCode::InvalidResponseCode => EINVAL,
+            SpdmErrorCode::SessionLimitExceeded => EBUSY,
+            SpdmErrorCode::SessionRequired => EINVAL,
+            SpdmErrorCode::ResetRequired => ECONNRESET,
+            SpdmErrorCode::ResponseTooLarge => EINVAL,
+            SpdmErrorCode::RequestTooLarge => EINVAL,
+            SpdmErrorCode::LargeResponse => EMSGSIZE,
+            SpdmErrorCode::MessageLost => EIO,
+            SpdmErrorCode::InvalidPolicy => EINVAL,
+            SpdmErrorCode::VersionMismatch => EINVAL,
+            SpdmErrorCode::ResponseNotReady => EINPROGRESS,
+            SpdmErrorCode::RequestResynch => ECONNRESET,
+            SpdmErrorCode::OperationFailed => EINVAL,
+            SpdmErrorCode::NoPendingRequests => ENOENT,
+            SpdmErrorCode::RequestSessionTerminated => EINVAL,
+            SpdmErrorCode::InvalidState => EINVAL,
+            SpdmErrorCode::VendorDefinedError => EINVAL,
+        }
+    }
+}
+
+impl core::fmt::LowerHex for SpdmErrorCode {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        write!(f, "{:#x}", *self as u8)
+    }
+}
+
+/// Allocates an SPDM session.
+///
+/// See `include/linux/spdm.h` for the full C API documentation.
+///
+/// # Safety
+///
+/// The caller must guarantee that `dev` is a valid pointer to a
+/// `struct device` that stays alive and bound to its driver for the
+/// lifetime of the returned session, and must pass the session to
+/// `spdm_destroy()` before `dev` is unbound. The caller must also
+/// guarantee that `transport_priv` remains valid until `spdm_destroy()`
+/// is called, as it is passed back to `transport` on each exchange.
+#[export]
+pub unsafe extern "C" fn spdm_create(
+    dev: *mut bindings::device,
+    transport: bindings::spdm_transport,
+    transport_priv: *mut c_void,
+    transport_sz: u32,
+    validate: bindings::spdm_validate,
+) -> *mut spdm_state {
+    // SAFETY: `dev` points to a valid `struct device` that stays alive for the
+    // lifetime of the session, so the returned reference is valid for the
+    //  session's lifetime.
+    let dev: &Device = unsafe { Device::from_raw(dev) };
+
+    // SAFETY: By the safety requirements of this function, the device stays
+    // bound for the lifetime of the session, so the returned
+    // `&Device<Bound>` is valid for the session's lifetime.
+    let dev = unsafe { dev.as_bound() };
+
+    // Wrap the `SpdmState` in a `Mutex` so that concurrent FFI callers (for
+    // example, two threads racing on `spdm_authenticate()` for the same
+    // device) serialize on the lock and never form aliased `&mut SpdmState`
+    // references.
+    let state = SpdmState::new(
+        dev,
+        CTransport {
+            func: transport,
+            priv_: transport_priv,
+        },
+        transport_sz,
+        validate,
+    );
+    match KBox::pin_init(new_mutex!(state), flags::GFP_KERNEL) {
+        Ok(b) => b.into_foreign().cast::<spdm_state>(),
+        Err(_) => ptr::null_mut(),
+    }
+}
+
+/// Authenticates a device through a sequence of SPDM exchanges.
+///
+/// See `include/linux/spdm.h` for the full C API documentation.
+#[export]
+pub extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+    -(EPROTONOSUPPORT as i32)
+}
+
+/// Destroys an SPDM session.
+///
+/// See `include/linux/spdm.h` for the full C API documentation.
+#[export]
+pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
+    if state_ptr.is_null() {
+        return;
+    }
+
+    // SAFETY: `state_ptr` was returned from `spdm_create()` which used
+    // `into_foreign()` to create the pointer.
+    let mutex = unsafe {
+        <Pin<KBox<Mutex<SpdmState<'_, CTransport>>>> as ForeignOwnable>::from_foreign(
+            state_ptr.cast::<c_void>(),
+        )
+    };
+
+    drop(mutex);
+}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 0000000000000..f864d869eff0c
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! The `SpdmState` struct and implementation.
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    device::{
+        Bound,
+        Device, //
+    },
+    error::Error,
+    validate::Untrusted,
+};
+
+use crate::consts::{
+    SPDM_ERROR,
+    SPDM_MIN_VER,
+    SPDM_REQ, //
+};
+use crate::validator::{
+    SpdmErrorRsp,
+    SpdmHeader, //
+};
+
+/// Transport for exchanging SPDM messages with a responder device.
+///
+/// This trait abstracts the bus-specific message transport (for example
+/// a DOE mailbox for PCIe CMA) from the SPDM session logic.
+pub(crate) trait Transport {
+    /// Perform a single SPDM message exchange.
+    ///
+    /// Send `request` to the responder and write the response into
+    /// `response`, returning the number of bytes received on success.
+    fn exchange(
+        &self,
+        dev: &Device<Bound>,
+        request: &[u8],
+        response: &mut [u8],
+    ) -> Result<usize, Error>;
+}
+
+/// The current SPDM session state for a device.
+///
+/// Concurrent access is serialised by wrapping the whole struct in a
+/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` callers
+/// run one at a time and the locked `&mut SpdmState` is the only way to
+/// reach the inner fields.
+///
+/// The lifetime `'a` is the duration for which the responder device and the
+/// transport are guaranteed to stay alive, bounded by the responder device
+/// staying bound to its driver.
+///
+/// `T` is data and an exchange function owned by the caller,
+/// so the borrow checker enforces that the transport data outlives `SpdmState`.
+#[expect(dead_code)]
+pub(crate) struct SpdmState<'a, T: Transport> {
+    /// Responder device. Used for error reporting and passed to `transport`.
+    pub(crate) dev: &'a Device<Bound>,
+    /// Transport used to perform message exchanges. Typically a `&'a`
+    /// reference to transport data owned by the caller, which then must
+    /// outlive the session.
+    pub(crate) transport: T,
+    /// Maximum message size the transport is capable of (in bytes). Used as
+    /// DataTransferSize in GET_CAPABILITIES exchange.
+    pub(crate) transport_sz: u32,
+    /// Function to validate additional leaf certificate requirements.
+    pub(crate) validate: bindings::spdm_validate,
+
+    /// Maximum common supported version of requester and responder.
+    /// Negotiated during GET_VERSION exchange.
+    pub(crate) version: u8,
+}
+
+impl<'a, T: Transport> SpdmState<'a, T> {
+    pub(crate) fn new(
+        dev: &'a Device<Bound>,
+        transport: T,
+        transport_sz: u32,
+        validate: bindings::spdm_validate,
+    ) -> Self {
+        SpdmState {
+            dev,
+            transport,
+            transport_sz,
+            validate,
+            version: SPDM_MIN_VER,
+        }
+    }
+
+    /// Start a SPDM exchange
+    ///
+    /// The data in `request_buf` is sent to the device and the response
+    /// is returned as untrusted data to be validated by the caller.
+    #[allow(dead_code)]
+    pub(crate) fn spdm_exchange(
+        &self,
+        request_buf: &[u8],
+        mut response_buf: KVec<u8>,
+    ) -> Result<Untrusted<KVec<u8>>, Error> {
+        let header_size = core::mem::size_of::<SpdmHeader>();
+        let request: SpdmHeader = Untrusted::new(request_buf).validate(self)?;
+
+        let length = self
+            .transport
+            .exchange(self.dev, request_buf, response_buf.as_mut_slice())?;
+
+        // The transport must not report more bytes than the buffer can hold.
+        if length > response_buf.len() {
+            pr_err!("Transport returned invalid length {length}\n");
+            return Err(EMSGSIZE);
+        }
+
+        // Only validate the bytes actually received from the transport
+        // Note that `length` might be longer then the actual SPDM packet as
+        // some transports will pad the final message
+        response_buf.truncate(length);
+
+        let response: SpdmHeader =
+            Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(self)?;
+
+        if response.code == SPDM_ERROR {
+            let error_rsp: SpdmErrorRsp =
+                Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(self)?;
+            pr_err!("Error response: {error_rsp:?}\n");
+            return Err(error_rsp.error_code.into());
+        }
+
+        if response.code != request.code & !SPDM_REQ {
+            pr_err!(
+                "Response code {:#x} does not match request code {:#x}\n",
+                response.code,
+                request.code
+            );
+            return Err(EPROTO);
+        }
+
+        Ok(Untrusted::new(response_buf))
+    }
+}
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
new file mode 100644
index 0000000000000..0fe341b8dce12
--- /dev/null
+++ b/lib/rspdm/validator.rs
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Related structs and their Validate implementations.
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+use crate::{
+    SpdmErrorCode,
+    SpdmState,
+    Transport, //
+};
+use kernel::prelude::*;
+use kernel::{
+    error::Error,
+    validate::{
+        Untrusted,
+        Validate, //
+    },
+};
+
+#[derive(FromBytes)]
+#[repr(C)]
+pub(crate) struct SpdmHeader {
+    pub(crate) version: u8,
+    pub(crate) code: u8, /* RequestResponseCode */
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl SpdmHeader {
+    #[expect(dead_code)]
+    pub(crate) fn new(code: u8) -> Self {
+        SpdmHeader {
+            version: 0,
+            code,
+            param1: 0,
+            param2: 0,
+        }
+    }
+
+    #[expect(dead_code)]
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = KVec::new();
+
+        out.extend_from_slice(
+            &[self.version, self.code, self.param1, self.param2],
+            GFP_KERNEL,
+        )?;
+
+        Ok(out)
+    }
+}
+
+impl<'a, 'c, T: Transport> Validate<'c, Untrusted<&'a [u8]>, &'c SpdmState<'c, T>> for SpdmHeader {
+    type Err = Error;
+
+    #[allow(clippy::get_first)]
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        SpdmHeader::read_from_bytes(unvalidated).or(Err(EPROTO))
+    }
+}
+
+#[expect(dead_code)]
+#[derive(Debug)]
+pub(crate) struct SpdmErrorRsp {
+    pub(crate) version: u8,
+    /// This will always be SPDM_ERROR (0x7F)
+    pub(crate) code: u8,
+    pub(crate) error_code: SpdmErrorCode,
+    pub(crate) error_data: u8,
+}
+
+impl<'a, 'c, T: Transport> Validate<'c, Untrusted<&'a [u8]>, &'c SpdmState<'c, T>>
+    for SpdmErrorRsp
+{
+    type Err = Error;
+
+    #[allow(clippy::get_first)]
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        Ok(SpdmErrorRsp {
+            version: *unvalidated.get(0).ok_or(EPROTO)?,
+            code: *unvalidated.get(1).ok_or(EPROTO)?,
+            // `try_from` rejects unknown `SpdmErrorCode` discriminants.
+            error_code: SpdmErrorCode::try_from(*unvalidated.get(2).ok_or(EPROTO)?)
+                .map_err(|_| EPROTO)?,
+            error_data: *unvalidated.get(3).ok_or(EPROTO)?,
+        })
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4992bc3194e7e..a2512fda77e1f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -90,6 +90,7 @@
 #include <linux/security.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
+#include <linux/spdm.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
-- 
2.56.0

