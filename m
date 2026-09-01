Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2938E8CB
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224723; cv=none; b=p4dXAlLXqqM0nI0IL3+cV35fEQKz1ZhCdMPRPLjsx++1lupnQi3BnTLEsdhi/pJRTG+/qQyL7DbAlQAuOJx4qEaHd6jl18s8XS5uKWPjrRJZUEH+mDOHtnTaunAnSvMtB6ogt11YHu514WhO5qWpk9IuDYKErpyoGOEnUpHJna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224723; c=relaxed/simple;
	bh=Uw2VLwsoDp91lblHkHXCK6pxUVZWG1IlcXaL9x6cObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtA/JKixs+UBVuLryizqcWVXJk1RoLyfZ88dIIGX/LesmKmaieS033sqoi4wnusus258Fhi7q/jjvs3dqXDMBras7sZFMjA7pjpMapedsf+TW0dkle2ZSl1BIgHH2FpEoEf18H8RWRuuoYgrnqhGyFFxx0ZXwpiABgFz6VV2epk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb3RvV1S; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb3RvV1S"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so5782440a91.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224720; x=1788829520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6liPr/5nQxFlbLIR9zEJaaR5hSXlZrWz5NGh2sBJmek=;
        b=hb3RvV1SDX8OCyQWPbjkZ6ocprc97teInRzdYIspQgEQr/h7LQwm6Ty0O/M2XTn5o5
         SLT9BE7afCo+F/5pasOultme4pvu3Jmw+4iIsV3/cHlNPqoTFzbgIArHAeCrxbuOj0AW
         dtUBuxNsU97JWIcEg5p0YkgFrPjxri3Xs427ADD7zZwCkmV7Me4l7W7t9Vcsh1C0OVNk
         Rfc/hJLKvYCAdfkga+g4zHLZyNKQjdl5bixmfEHFgxFZDScR7pOFrDdwkBBiEoXmcpqc
         UcvCGgygrNKyLumEf5nSuLnL8MN8AR1H/DTDtsv6Rpssfd1QwMkyzGbA41f4YNa/4tyv
         SbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224720; x=1788829520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6liPr/5nQxFlbLIR9zEJaaR5hSXlZrWz5NGh2sBJmek=;
        b=DfDe/k5qEsg4PZIGI1d8Mtn7rbo2El6MdZf2bYv3BNDcastB03VWslAL7xdDJP3COM
         lvJGFroePFsygcIbfiy/FP7LB+CzkzJnX9AbvK6TrTax4i83vzWxfVt5iir+JgWx8VjR
         DuU8RqKJFtWCylS/zAtRRGYBt57tYGbFZdFwwQblDDrc6VputZm8sTfrtS9cDaV4MZCi
         IYcRDVngTQPZ/C0FUhWxMD8/S7uAAe7qc9yAk369gJB0wVweDdTkqcTXLkdby14ue4YW
         /oaRAZYD+TeNGglLPKB0kuaBwSkz41+a2GL822wDxjkBawRtK3HaUimTRQWa0vNtgPge
         hVZg==
X-Gm-Message-State: AFuF++loMaQaGNPC5H4KTCTERd0usQv1ZwlsmcAQTOMLLoN6szVad3ZM
	PnWDjMNwoPDSc432dIt4El64zmd8TmsODDaosvdZ1EmteN721K9MGXQZxCIffA==
X-Gm-Gg: AYBFou3mgGWkvq5DTSUNFsIqIjWjTiOTkzdCpi1l38cQArUnLtzGJ6TXBXp2nsrqLbZ
	gl29Pwqexy4BGMPzWCkytB9XlAgzDIZ7f5WrgI+lFahKuNUHYw8ZdNJVT4FLSxy83emVVTg2Xi+
	67J2r11eKTYUwLhZG0gRmyHrbWE05ca5v5Gw/F7r+yHyqqPOCwyuBap7YzmKa7Lt7jQOSQA/kKi
	VjnjD2aO08UIlsFUoiNmvWxVBmDFbeB/zg+Uw4xqM0JMcGdDZh73Mnq2Jshy0dCPRvSgiT2zWt4
	+eeggsMRmtuJ4U9p/jAa4r7HTxUavr5QWSY0jR5sITeFLgVMVwo+FfwAkUVW1ps8y5YrDv65XKM
	sYZ9RhNnYMtKnfljOJT3BCKr5EZhDrOQqRHCcDou/nNX+QZBwneMmlFLo2czn/JcWqVFj08+tal
	miNzyYATtLjjt9ugSFUMTd1caHCp2p7mioWs55UzVvIoAcKbbrOpBJyVVH9H9Hgjb2M228LFQLx
	89iIg==
X-Received: by 2002:a17:90b:2686:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-39907cd5327mr6599078a91.11.1788224719415;
        Mon, 31 Aug 2026 18:05:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:05:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com
Subject: [PATCH v3 09/21] lib: rspdm: Initial commit of Rust SPDM
Date: Tue,  1 Sep 2026 11:03:35 +1000
Message-ID: <20260901010347.2614656-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

This is the initial commit of the Rust SPDM library.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS                     |  12 ++
 include/linux/spdm.h            |  37 +++++
 lib/Kconfig                     |  15 ++
 lib/Makefile                    |   2 +
 lib/rspdm/Makefile              |  10 ++
 lib/rspdm/consts.rs             |  92 +++++++++++++
 lib/rspdm/lib.rs                |  89 ++++++++++++
 lib/rspdm/state.rs              | 237 ++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs          |  92 +++++++++++++
 rust/bindings/bindings_helper.h |   1 +
 10 files changed, 587 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..36f84a02894b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24753,6 +24753,18 @@ M:	Security Officers <security@kernel.org>
 S:	Supported
 F:	Documentation/process/security-bugs.rst
 
+SECURITY PROTOCOL AND DATA MODEL (SPDM)
+M:	Jonathan Cameron <jic23@kernel.org>
+M:	Lukas Wunner <lukas@wunner.de>
+M:	Alistair Francis <alistair@alistair23.me>
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
index 000000000000..1f7207b584a8
--- /dev/null
+++ b/include/linux/spdm.h
@@ -0,0 +1,37 @@
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
+struct spdm_state *spdm_create(struct device *dev, spdm_transport *transport,
+			       void *transport_priv, u32 transport_sz,
+			       spdm_validate *validate);
+
+int spdm_authenticate(struct spdm_state *spdm_state);
+
+void spdm_destroy(struct spdm_state *spdm_state);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 4e6b34c3346d..b1792db6ddf0 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -588,6 +588,21 @@ config LWQ_TEST
 	help
 	  Run boot-time test of light-weight queuing.
 
+config RSPDM
+	bool "Rust SPDM"
+	depends on RUST
+	select ASYMMETRIC_KEY_TYPE
+	select CRYPTO
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
index dfab958327c5..22776b7e9416 100644
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
index 000000000000..1f62ee2a882d
--- /dev/null
+++ b/lib/rspdm/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+# https://www.dmtf.org/dsp/DSP0274
+#
+# Copyright (C) 2024 Western Digital
+
+obj-$(CONFIG_RSPDM) += spdm.o
+
+spdm-y := lib.o
diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
new file mode 100644
index 000000000000..01f008958a1f
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Constants used by the library
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+use kernel::error::{code::EINVAL, Error};
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
+#[derive(Clone, Copy)]
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
+impl core::fmt::LowerHex for SpdmErrorCode {
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        write!(f, "{:#x}", *self as u8)
+    }
+}
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
new file mode 100644
index 000000000000..1883579b817a
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
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
+    bindings, //
+};
+
+use crate::state::SpdmState;
+
+const __LOG_PREFIX: &[u8] = b"spdm\0";
+
+mod consts;
+mod state;
+mod validator;
+
+/// spdm_create() - Allocate SPDM session
+///
+/// `dev`: Responder device
+/// `transport`: Transport function to perform one message exchange
+/// `transport_priv`: Transport private data
+/// `transport_sz`: Maximum message size the transport is capable of (in bytes)
+/// `validate`: Function to validate additional leaf certificate requirements
+///  (optional, may be %NULL)
+///
+/// Return a pointer to the allocated SPDM session state or NULL on error.
+#[export]
+pub extern "C" fn spdm_create(
+    dev: *mut bindings::device,
+    transport: bindings::spdm_transport,
+    transport_priv: *mut c_void,
+    transport_sz: u32,
+    validate: bindings::spdm_validate,
+) -> *mut spdm_state {
+    match KBox::new(
+        SpdmState::new(dev, transport, transport_priv, transport_sz, validate),
+        flags::GFP_KERNEL,
+    ) {
+        Ok(ret) => KBox::into_raw(ret) as *mut spdm_state,
+        Err(_) => ptr::null_mut(),
+    }
+}
+
+/// spdm_authenticate() - Authenticate device
+///
+/// @spdm_state: SPDM session state
+///
+/// Authenticate a device through a sequence of GET_VERSION, GET_CAPABILITIES,
+/// NEGOTIATE_ALGORITHMS, GET_DIGESTS, GET_CERTIFICATE and CHALLENGE exchanges.
+///
+/// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
+/// indicates authentication is not supported by the device.
+#[export]
+pub extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+    -(EPROTONOSUPPORT as i32)
+}
+
+/// spdm_destroy() - Destroy SPDM session
+///
+/// @spdm_state: SPDM session state
+#[export]
+pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
+    if state_ptr.is_null() {
+        return;
+    }
+    // SAFETY: `state_ptr` was returned from `spdm_create` (which uses
+    // `KBox::into_raw`) and the caller guarantees the state is no longer
+    // in use.  Reconstructing the `KBox` and dropping it frees the state.
+    drop(unsafe { KBox::from_raw(state_ptr as *mut SpdmState) });
+}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 000000000000..e1f74d19ac4b
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! The `SpdmState` struct and implementation.
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+use core::ffi::c_void;
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    error::{
+        code::EINVAL,
+        to_result,
+        Error, //
+    },
+    validate::Untrusted,
+};
+
+use crate::consts::{
+    SpdmErrorCode,
+    SPDM_ERROR,
+    SPDM_MIN_VER,
+    SPDM_REQ, //
+};
+use crate::validator::{
+    SpdmErrorRsp,
+    SpdmHeader, //
+};
+
+/// The current SPDM session state for a device. Based on the
+/// C `struct spdm_state`.
+///
+/// `dev`: Responder device.  Used for error reporting and passed to @transport.
+/// `transport`: Transport function to perform one message exchange.
+/// `transport_priv`: Transport private data.
+/// `transport_sz`: Maximum message size the transport is capable of (in bytes).
+///  Used as DataTransferSize in GET_CAPABILITIES exchange.
+/// `validate`: Function to validate additional leaf certificate requirements.
+///
+/// `version`: Maximum common supported version of requester and responder.
+///  Negotiated during GET_VERSION exchange.
+#[expect(dead_code)]
+pub(crate) struct SpdmState {
+    pub(crate) dev: *mut bindings::device,
+    pub(crate) transport: bindings::spdm_transport,
+    pub(crate) transport_priv: *mut c_void,
+    pub(crate) transport_sz: u32,
+    pub(crate) validate: bindings::spdm_validate,
+
+    // Negotiated state
+    pub(crate) version: u8,
+}
+
+impl SpdmState {
+    pub(crate) fn new(
+        dev: *mut bindings::device,
+        transport: bindings::spdm_transport,
+        transport_priv: *mut c_void,
+        transport_sz: u32,
+        validate: bindings::spdm_validate,
+    ) -> Self {
+        SpdmState {
+            dev,
+            transport,
+            transport_priv,
+            transport_sz,
+            validate,
+            version: SPDM_MIN_VER,
+        }
+    }
+
+    #[allow(dead_code)]
+    fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
+        match rsp.error_code {
+            SpdmErrorCode::InvalidRequest => {
+                pr_err!("Invalid request\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::InvalidSession => {
+                if rsp.version == 0x11 {
+                    pr_err!("Invalid session {:#x}\n", rsp.error_data);
+                    Err(EINVAL)
+                } else {
+                    pr_err!("Undefined error {:#x}\n", rsp.error_code);
+                    Err(EINVAL)
+                }
+            }
+            SpdmErrorCode::Busy => {
+                pr_err!("Busy\n");
+                Err(EBUSY)
+            }
+            SpdmErrorCode::UnexpectedRequest => {
+                pr_err!("Unexpected request\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::Unspecified => {
+                pr_err!("Unspecified error\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::DecryptError => {
+                pr_err!("Decrypt error\n");
+                Err(EIO)
+            }
+            SpdmErrorCode::UnsupportedRequest => {
+                pr_err!("Unsupported request {:#x}\n", rsp.error_data);
+                Err(EINVAL)
+            }
+            SpdmErrorCode::RequestInFlight => {
+                pr_err!("Request in flight\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::InvalidResponseCode => {
+                pr_err!("Invalid response code\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::SessionLimitExceeded => {
+                pr_err!("Session limit exceeded\n");
+                Err(EBUSY)
+            }
+            SpdmErrorCode::SessionRequired => {
+                pr_err!("Session required\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::ResetRequired => {
+                pr_err!("Reset required\n");
+                Err(ECONNRESET)
+            }
+            SpdmErrorCode::ResponseTooLarge => {
+                pr_err!("Response too large\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::RequestTooLarge => {
+                pr_err!("Request too large\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::LargeResponse => {
+                pr_err!("Large response\n");
+                Err(EMSGSIZE)
+            }
+            SpdmErrorCode::MessageLost => {
+                pr_err!("Message lost\n");
+                Err(EIO)
+            }
+            SpdmErrorCode::InvalidPolicy => {
+                pr_err!("Invalid policy\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::VersionMismatch => {
+                pr_err!("Version mismatch\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::ResponseNotReady => {
+                pr_err!("Response not ready\n");
+                Err(EINPROGRESS)
+            }
+            SpdmErrorCode::RequestResynch => {
+                pr_err!("Request resynchronization\n");
+                Err(ECONNRESET)
+            }
+            SpdmErrorCode::OperationFailed => {
+                pr_err!("Operation failed\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::NoPendingRequests => Err(ENOENT),
+            SpdmErrorCode::VendorDefinedError => {
+                pr_err!("Vendor defined error\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::RequestSessionTerminated => {
+                pr_err!("Request session terminated\n");
+                Err(EINVAL)
+            }
+            SpdmErrorCode::InvalidState => {
+                pr_err!("Invalid State\n");
+                Err(EINVAL)
+            }
+        }
+    }
+
+    /// Start a SPDM exchange
+    ///
+    /// The data in `request_buf` is sent to the device and the response is
+    /// stored in `response_buf`.
+    #[allow(dead_code)]
+    pub(crate) fn spdm_exchange(
+        &self,
+        request_buf: &mut [u8],
+        response_buf: &mut [u8],
+    ) -> Result<i32, Error> {
+        let header_size = core::mem::size_of::<SpdmHeader>();
+        let request: &SpdmHeader = Untrusted::new(&request_buf[..]).validate()?;
+
+        let transport_function = self.transport.ok_or(EINVAL)?;
+        // SAFETY: `transport_function` is provided by the new(), we are
+        // calling the function.
+        // We have a immutable reference to request_buf above, and pass
+        // another reference here.
+        // We don't have any references to the mutable response_buf
+        let length = unsafe {
+            transport_function(
+                self.transport_priv,
+                self.dev,
+                request_buf.as_ptr() as *const c_void,
+                request_buf.len(),
+                response_buf.as_mut_ptr() as *mut c_void,
+                response_buf.len(),
+            ) as i32
+        };
+        to_result(length)?;
+
+        if (length as usize) < header_size {
+            return Ok(length); // Truncated response is handled by callers
+        }
+
+        let response: &SpdmHeader = Untrusted::new(&response_buf[..]).validate()?;
+
+        if response.code == SPDM_ERROR {
+            let error_rsp: &SpdmErrorRsp =
+                Untrusted::new(&response_buf[..header_size as usize]).validate()?;
+            self.spdm_err(error_rsp)?;
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
+        Ok(length)
+    }
+}
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
new file mode 100644
index 000000000000..323242e84580
--- /dev/null
+++ b/lib/rspdm/validator.rs
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Related structs and their Validate implementations.
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+use crate::consts::SpdmErrorCode;
+use core::mem;
+use kernel::prelude::*;
+use kernel::{
+    error::{
+        code::EINVAL,
+        Error, //
+    },
+    validate::{
+        Untrusted,
+        Validate, //
+    },
+};
+
+#[repr(C, packed)]
+pub(crate) struct SpdmHeader {
+    pub(crate) version: u8,
+    pub(crate) code: u8, /* RequestResponseCode */
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl Validate<Untrusted<&[u8]>> for &SpdmHeader {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<SpdmHeader>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `SpdmHeader` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<SpdmHeader>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        Ok(unsafe { &*ptr })
+    }
+}
+
+impl Validate<Untrusted<&mut [u8]>> for &mut SpdmHeader {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut [u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<SpdmHeader>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_mut_ptr();
+        // CAST: `SpdmHeader` only contains integers and has `repr(C, packed)`.
+        let ptr = ptr.cast::<SpdmHeader>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        Ok(unsafe { &mut *ptr })
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct SpdmErrorRsp {
+    pub(crate) version: u8,
+    /// This will always be SPDM_ERROR (0x7F)
+    pub(crate) code: u8,
+    pub(crate) error_code: SpdmErrorCode,
+    pub(crate) error_data: u8,
+}
+
+impl<'a> Validate<Untrusted<&'a [u8]>> for &'a SpdmErrorRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<SpdmErrorRsp>() {
+            return Err(EINVAL);
+        }
+
+        // Reject responses whose `error_code` byte is not a known
+        // `SpdmErrorCode` discriminant before exposing the struct to callers.
+        SpdmErrorCode::try_from(unvalidated[mem::offset_of!(SpdmErrorRsp, error_code)])?;
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `SpdmErrorRsp` only contains `u8` fields and `SpdmErrorCode` which
+        // we have already checked and has `repr(C, packed)`.
+        let ptr = ptr.cast::<SpdmErrorRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        Ok(unsafe { &*ptr })
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index fd223b6c5aaf..d2781c27794b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -89,6 +89,7 @@
 #include <linux/security.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
+#include <linux/spdm.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
-- 
2.55.0

