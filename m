Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284404;
	b=KPs72439ybrnSzukB5gxnC2OX74vT0JgvtK2YsSHDPejcw5/GS25oJaMF4LJiGP96+Ap
	 9cnWq27Nkmc3xQ4rDqQuzH6qoB8/OsfTbAuihoQZ/HnTH5HmGU54fE9TDMvS4n+bAfkkL
	 3HSz0UELuUrjvnB9HdFAB9tzjKvz079QiqNjpBt3pfhIBra5LtZtADL0zBFnZDAuLNtj6
	 n2Qea74l7sjtZ8Lo1T44Nnj/xSNlIs1sodCPb5SoeT6E3B7RENwB4+sc+ane1iIwu9GoZ
	 917FLq9hoYvLsKAHU0agywByunhLYBxlBsc5TJG9UErOSep/byCoyAQuq2DxQ3NR2Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/j1vxkv2xlXauiH8ozctJ/Ku5H3gX6r5YbvPFEUHpd8=;
	b=AXu0RJCHRt9ncU+x1KfpRk7xXXqHTF4Qy73gDVrirg3Py4Jq/WhyTdhvnXC42Kb06QfP
	 yFGOmx+jT8KoKpXuVfA1/M1aqyfTcgTzR/5l/j2Jn3IDArgQ/x3Ir/kT/RPaFvpBXtWhI
	 sj6sACEH1JEH7zqpDH0laCBjMIBaM6puJcDdj6OfAZ1pWBKfx637tzmhyH/tGCbZTydoW
	 i9t6k4TbyiZkotjN09N/FUctqS0mJdYsRO4yT3IQB3lmaqNWQi8cPERSwYWgKZbnDKdb6
	 9tTh1Y1pxyOB9guB83K+fRnWrNUN4mYlQhxR7NEQT4Ko2Yix/r1YgMBMNsCjyBk+a7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKs19k91;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064D60A2622
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2064D60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GKs19k91
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1485913c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284402; x=1794889202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/j1vxkv2xlXauiH8ozctJ/Ku5H3gX6r5YbvPFEUHpd8=;
        b=GKs19k91MS4aA1UK9yfOs935PRNHhIUtaaoRw6lZV1QgV3kvIQWORfQOaBk8dgomv/
         aCe+smT4g0FLXLeE+AqfJZL7ZWCTs7ApgYWS6bCXtMYeZzIOpl9P4xmbFzXXwBmw8INT
         aaqSdUw3gPphODyz49orSlePTt9j/ecAM1FRmVC7eCJv6Gr1uWqpgLAupFzq7GkW2u0k
         5OSPLVre0HEJxiSgMu/6dtLcGOaGBESYHzYEgBHAuDpYtkN30xAibucFE/wG9kDSUQLK
         PQOeL+m3xPaJ7QbUXmBKkSvuT0l0/spRuOGQidHB7bEskWHWAONSA0jK/LWQNJqDwsd0
         vn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284402; x=1794889202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/j1vxkv2xlXauiH8ozctJ/Ku5H3gX6r5YbvPFEUHpd8=;
        b=XKTEDPSkKQrlu+yJKpu8MQOJ5ErEqD88bZJHZ8MIAZJfdmOj5eOkL3wZ5HeZIHw8Tg
         7vcUW4+OYygyhr4ZSAKlMWlPFGLD226ik1A+12EJOoBfpko2nlUhIY5E8KitlB6IzLDK
         yB9sFjS7Bqbsx0Hcg/846ThFQdLL5WpSNq5GtH23KHhH5QsOsvxmYDah6plypDphPQnd
         ROcpSk0v4OIvxU5G6QZhz3qb6M367rNteKFmDApPm863LRmraW26tZgwMMcY36UF5m/l
         4/yJIyOEjGZVl1IUPFzNTAOcPjMNUuIFy7PAHWOzasnhlLVMEOJ2hH6oSTkJvojeu5Ft
         L6XQ==
X-Forwarded-Encrypted: i=1; AL+hErFRZsCmDY6ryplnRiukDfpVsjzYRp76uHqWqxPfBjeMrl+63N6Tn/5PYKvvtS5kU/cR0tFM2j381uw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0yd0m8OixUqXErvh8EgxtvC0Xnt+5zhXuFnDGVwXudmd4HhmU
	YdchaN5fLO64EullCcRJTsYEXkV81+eYA0wWQg0Y1xOWUVNAeM55Uq7w
X-Gm-Gg: AYBFou0THPUUcxJBx+nnkorJLIQh6unDMZ8nO3PNcUzwhCjcnLeqExRY7ndM5E7DEkl
	qW9KVsZQ3uT7SVc2F4Zu/KKFHCLHIEtbNaXnmqDTGk91qbpv/enZP4er4Tb/SrtAL5+4R+pMlUL
	1Vyo7Gwn7Jfn4yuT8dGAj0tmGH/wZFAsT7y/2TDO8WIpkabV54AzfM4FbqNicFuLmGz9G6OR0OL
	o3II2/AkmkzoemqkuxksxFRdV2NRuSMKI14fh0YR6DUHuJYuUjEBppVEihSR4zSIwtl93F0laq3
	ilBp4XSL57DdVHP+2A9l46C0L8hOuWK0XP/c45Dgb5H9WsiMHIRqZ9GQ8+ZupLAezycMLLYLgPC
	rrb4TrOUAZDiK3R36tVa5xvktHAWAjgsg9wUdloYWLKZjUuLXTrol5QBeqonTWYMLDPr0shuvT6
	RUbzKhcp6U6m04U45GImP2aOwqSGUgF0CBzFJ8nk5Jc36WGqA86xk0p3ibOvSCWrig55WUhDLf/
	wKosRet8PjauNTRRwlJb8NAyFjNz4FkRniEe6RX8WAZu9U0KRkMKPbZwO/mU1xqu2wjA8dQdNnY
	/kTPPgoYfkBk9DXmnghm7zmKlduBEtGWPEcxsj1tLDgCdsA=
X-Received: by 2002:a05:7022:e884:b0:14d:c53a:f6a0 with SMTP id a92af1059eb24-1b3b60618fcmr2444243c88.13.1794284402035;
        Mon, 09 Nov 2026 20:20:02 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:20:01 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v6 09/25] lib: rspdm: Initial commit of Rust SPDM
Date: Tue, 10 Nov 2026 14:18:16 +1000
Message-ID: <20261110041832.1730924-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
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

Security Protocols and Data Model (SPDM) [1] is used for authentication,
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
 include/linux/spdm.h            |  71 +++++++++
 lib/Kconfig                     |  17 ++
 lib/Makefile                    |   2 +
 lib/rspdm/Makefile              |  10 ++
 lib/rspdm/consts.rs             |  20 +++
 lib/rspdm/lib.rs                | 274 ++++++++++++++++++++++++++++++++
 lib/rspdm/state.rs              | 148 +++++++++++++++++
 lib/rspdm/validator.rs          |  92 +++++++++++
 rust/bindings/bindings_helper.h |   1 +
 10 files changed, 647 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065d..7af01251af461 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25384,6 +25384,18 @@ M:	Security Officers <security@kernel.org>
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
index 0000000000000..386038ab85ead
--- /dev/null
+++ b/include/linux/spdm.h
@@ -0,0 +1,71 @@
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
+			    const struct x509_certificate *leaf_cert);
+
+/**
+ * spdm_create() - Allocate SPDM session
+ * @dev: Responder device. Used for error reporting and passed to @transport.
+ *	The session takes its own device reference, so @dev does not need
+ *	to stay bound to a driver.
+ * @transport: Transport function to perform one message exchange.
+ * @transport_priv: Transport function private data. Must remain valid
+ *	until spdm_destroy() is called, as it is passed back to @transport
+ *	on each exchange.
+ * @transport_sz: Maximum message size the transport is capable of
+ *	(in bytes). Must be at least the SPDM minimum data transfer size
+ *	(42 bytes).
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
index 1e42f5167c68b..daf219282f441 100644
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
index 0000000000000..6fe4dbdd67204
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,20 @@
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
+
+pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42; // SPDM 1.2.0 margin no 226
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
new file mode 100644
index 0000000000000..7d87d19c9b782
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,274 @@
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
+use core::ptr;
+use kernel::prelude::*;
+use kernel::{
+    alloc::flags,
+    bindings,
+    device::Device,
+    error::to_result,
+    ffi::{
+        c_int,
+        c_void, //
+    },
+    new_mutex,
+    sync::Mutex,
+    types::ForeignOwnable, //
+};
+
+use crate::consts::SPDM_MIN_DATA_TRANSFER_SIZE;
+use crate::state::{
+    SpdmState,
+    Transport, //
+};
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
+    fn exchange(&self, dev: &Device, request: &[u8], response: &mut [u8]) -> Result<usize, Error> {
+        let func = self.func.ok_or(EINVAL)?;
+
+        // SAFETY: `func` is non-NULL as checked above. By the safety
+        // requirements of `spdm_create()`, `priv_` remains valid until
+        // `spdm_destroy()` is called, and `dev` remains alive for the
+        // lifetime of the session (the session holds a device reference).
+        // `request` and `response` are valid slices that outlive this call,
+        // and the callback must not retain either of them.
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
+pub(crate) enum SpdmErrorCode {
+    InvalidRequest,
+    /// This was removed in version 1.2.0 and is now reserved
+    InvalidSession,
+    Busy,
+    UnexpectedRequest,
+    Unspecified,
+    DecryptError,
+    UnsupportedRequest,
+    RequestInFlight,
+    InvalidResponseCode,
+    SessionLimitExceeded,
+    SessionRequired,
+    ResetRequired,
+    ResponseTooLarge,
+    RequestTooLarge,
+    LargeResponse,
+    MessageLost,
+    InvalidPolicy,
+    VersionMismatch,
+    ResponseNotReady,
+    RequestResynch,
+    OperationFailed,
+    NoPendingRequests,
+    RequestSessionTerminated,
+    InvalidState,
+    VendorDefinedError,
+    /// Not a standard SPDM error code (e.g. from a future spec version).
+    /// The raw code is kept for logging via the derived `Debug` impl.
+    #[expect(dead_code)]
+    Unknown(u8),
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
+            v => Self::Unknown(v),
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
+            SpdmErrorCode::Unknown(_) => EPROTO,
+        }
+    }
+}
+
+/// Allocates an SPDM session.
+///
+/// See `include/linux/spdm.h` for the full C API documentation.
+///
+/// # Safety
+///
+/// The caller must guarantee that `dev` is a valid, non-NULL pointer to a
+/// `struct device` with a live reference count. The session takes its own
+/// reference, so the device does not need to stay bound to its driver for
+/// the session's lifetime. The caller must also guarantee that
+/// `transport_priv` remains valid until `spdm_destroy()` is called, as it
+/// is passed back to `transport` on each exchange.
+#[export]
+pub unsafe extern "C" fn spdm_create(
+    dev: *mut bindings::device,
+    transport: bindings::spdm_transport,
+    transport_priv: *mut c_void,
+    transport_sz: u32,
+    validate: bindings::spdm_validate,
+) -> *mut spdm_state {
+    if dev.is_null() {
+        return ptr::null_mut();
+    }
+
+    // SAFETY: By the safety requirements of this function, `dev` is a valid
+    // pointer to a `struct device` with a live reference count, so a new
+    // reference can be taken.
+    let dev = unsafe { Device::get_device(dev) };
+
+    if transport_sz < SPDM_MIN_DATA_TRANSFER_SIZE {
+        dev_err!(
+            &dev,
+            "Transfer size {transport_sz} below SPDM minimum {SPDM_MIN_DATA_TRANSFER_SIZE}\n"
+        );
+        return ptr::null_mut();
+    }
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
+///
+/// # Safety
+///
+/// `state_ptr` must be a valid pointer returned by a previous call to
+/// `spdm_create()` that has not yet been passed to `spdm_destroy()`.
+#[export]
+pub unsafe extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+    -(EPROTONOSUPPORT as i32)
+}
+
+/// Destroys an SPDM session.
+///
+/// See `include/linux/spdm.h` for the full C API documentation.
+///
+/// # Safety
+///
+/// `state_ptr` must have been returned by a previous call to
+/// `spdm_create()` and must not be passed to this function more than once.
+#[export]
+pub unsafe extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
+    if state_ptr.is_null() {
+        return;
+    }
+
+    // SAFETY: `state_ptr` was returned from `spdm_create()` which used
+    // `into_foreign()` to create the pointer.
+    let mutex = unsafe {
+        <Pin<KBox<Mutex<SpdmState<CTransport>>>> as ForeignOwnable>::from_foreign(
+            state_ptr.cast::<c_void>(),
+        )
+    };
+
+    drop(mutex);
+}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 0000000000000..4f87441e84a67
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,148 @@
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
+    device::Device,
+    error::Error,
+    sync::aref::ARef,
+    validate::Untrusted, //
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
+    fn exchange(&self, dev: &Device, request: &[u8], response: &mut [u8]) -> Result<usize, Error>;
+}
+
+/// The current SPDM session state for a device.
+///
+/// Concurrent access is serialised by wrapping the whole struct in a
+/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` callers
+/// run one at a time and the locked `&mut SpdmState` is the only way to
+/// reach the inner fields.
+///
+/// The responder device is kept alive via a reference count (`ARef`), so
+/// it does not need to stay bound to its driver. `T` is data and an
+/// exchange function owned by the caller, so the borrow checker enforces
+/// that the transport data outlives `SpdmState`.
+#[expect(dead_code)]
+pub(crate) struct SpdmState<T: Transport> {
+    /// Responder device (reference counted). Used for error reporting and
+    /// passed to `transport`.
+    pub(crate) dev: ARef<Device>,
+    /// Transport used to perform message exchanges. Typically a reference
+    /// to transport data owned by the caller, which then must outlive the
+    /// session.
+    pub(crate) transport: T,
+    /// Maximum message size the transport is capable of (in bytes). Used as
+    /// DataTransferSize in GET_CAPABILITIES exchange.
+    pub(crate) transport_sz: u32,
+    /// Maximum message size negotiated with the responder for this session
+    /// (`min(transport_sz, responder's DataTransferSize)`). Used to size
+    /// response buffers.
+    pub(crate) data_transfer_sz: u32,
+    /// Function to validate additional leaf certificate requirements.
+    pub(crate) validate: bindings::spdm_validate,
+
+    /// Maximum common supported version of requester and responder.
+    /// Negotiated during GET_VERSION exchange.
+    pub(crate) version: u8,
+}
+
+impl<T: Transport> SpdmState<T> {
+    /// Creates a new SPDM session for `dev` using `transport` for message
+    /// exchanges.
+    ///
+    /// `transport_sz` is the maximum message size the transport can carry,
+    /// and must be at least the SPDM minimum data transfer size (42 bytes).
+    pub(crate) fn new(
+        dev: ARef<Device>,
+        transport: T,
+        transport_sz: u32,
+        validate: bindings::spdm_validate,
+    ) -> Self {
+        SpdmState {
+            dev,
+            transport,
+            transport_sz,
+            data_transfer_sz: transport_sz,
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
+        let length =
+            self.transport
+                .exchange(&self.dev, request_buf, response_buf.as_mut_slice())?;
+
+        // The transport must not report more bytes than the buffer can hold.
+        if length > response_buf.len() {
+            dev_err!(&self.dev, "Transport returned invalid length {length}\n");
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
+            dev_err!(&self.dev, "Error response: {error_rsp:?}\n");
+            return Err(error_rsp.error_code.into());
+        }
+
+        if response.code != request.code & !SPDM_REQ {
+            dev_err!(
+                &self.dev,
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
index 0000000000000..2898b4c5ee412
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
+impl<'a, 'c, T: Transport> Validate<'c, Untrusted<&'a [u8]>, &'c SpdmState<T>> for SpdmHeader {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        // Read only the header prefix, as the input may contain a payload
+        // after the header (as is the case for requests).
+        let (header, _payload) = SpdmHeader::read_from_prefix(unvalidated).or(Err(EPROTO))?;
+
+        Ok(header)
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
+impl<'a, 'c, T: Transport> Validate<'c, Untrusted<&'a [u8]>, &'c SpdmState<T>> for SpdmErrorRsp {
+    type Err = Error;
+
+    #[allow(clippy::get_first)]
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        Ok(SpdmErrorRsp {
+            version: *unvalidated.get(0).ok_or(EPROTO)?,
+            code: *unvalidated.get(1).ok_or(EPROTO)?,
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

