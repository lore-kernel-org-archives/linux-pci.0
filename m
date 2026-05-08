Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0C2F39B4
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210303; cv=none; b=RKKfZ4eT0QcUocU+3cYX7mY/gFiH1iAER5R9DDyq+nkINkUMF06KFw9CKO6BwOO0UVGvkWP+uHyuIm8zeRL1e3d/MFYd/sRVqxseAwXgzAkxYCXlwy2SagRJGnueybo9C9g9kO/Ar42rvdmXxQlBHl24+H5K82i54eS7q8wVPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210303; c=relaxed/simple;
	bh=qJWHDK+N4LoOGpeaEwJKkRsDeF4WOI9vEFrJsALVy7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teg4bNHEoEOnVKgh/6EmTDbts1D0vLxkU39h8a2Th7BUtZvooKp1xirjEyFmPJoEu3p1JfM0w89CzQGcelGNqIqO2xSVbdyoRcrbtP1rAUuTNE7n/A4+et2QJvln0PI3Gce5WPv5VVax5ynkbesUl5kJBpGnWbUWXfRq4k6U4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmDYUJHZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmDYUJHZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso14673245ad.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210297; x=1778815097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ731pPUpjKXMohpExLc/2RX1wlDvWGPLBQ6aRYUkzA=;
        b=cmDYUJHZv4Q0G0aAq5VxHaekaqC6hmwk1ID+EYKjQv3WXSJ78DJerBt8fABph21lo8
         H+pssP25hXRfRDyATNOOwYlsSisSIKV4xHIRPCLB7H1vkyouXCfIUQeSNU+fNSadlokC
         2Vw768EcRQvibMKEtz7bxnv9n1/KMO3hsmTe6V1GFr+dM2t1PQ01Q+KrFlW8y/hFQpUl
         J4MXTli+8ScvVPqsYx1PrGuIbcQUGRHagPnHvaDYxsxI67cSwMpsFoe8zJPeM8q/NWt3
         IHquxXcOB5WmuGcC/+/awV7XkF2HpVjDS+/u62t6K0URb13u7E9g4DLy7/P9zfJkSBZl
         /i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210297; x=1778815097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJ731pPUpjKXMohpExLc/2RX1wlDvWGPLBQ6aRYUkzA=;
        b=D9sHqjCH/csE6d9CaTJ6S7woPy9SRIyjoPF69xqdV42HbhhxWvvYgRLANWX3vV1yZD
         xjHQ5o2n+KOvgLFE5dN9gh/2Oon2MicBZftSRX5kthqEtnTFBlNDb6+AHKMebUhbNLhH
         RV6UJp30XY3qdSReL47pb9U7Zoykyhqud38yHRbNqgI1pjAWksdM0zomXk98iRxi+ePt
         dQ8Z+V58OI39Y/9OwLUneHSRpRefJ2dCZLZTyJMcVeHc+WD2dudzBpG16EP213Hw/nmS
         yLtytKv6GAQ1dtG847lzyOCenwFRVKQPfkQ3kX3TZccMnNA9SAskHUjCSPpXm3i08k6K
         pWYg==
X-Forwarded-Encrypted: i=1; AFNElJ/AUx8OD2Sr/OQQwikBeyuoaANO8ywguIvXlPR78P986Ue9TbQ0vdZijNE4G3dqVvfflI7R1pU+LTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylye9kyQOO5FJ09bWZet+cifWGsyNxov1mUArsDIDbCWP3hRmR
	DERNzST2MU6f1GkS6HPEO0rDSa/oDfiC8A9Y6b4+2RgoMxhY4nGFQoqG
X-Gm-Gg: Acq92OFWmlnR0Ks0U5prpwWspkpjJcCGogQxvpW2RF/eUPppE9PafXjamhtHYlRWe0N
	Nts2WVh15sOTlqhfBgwmT+4kEIFuijBdH4CFfomicyy6pLzxVFDYNSBvB9qy6tT4jimSjye30Ek
	52QqIgrNS16kj8uOCdFU4q6wczmhoy432BimT0WYWy387L88PQTy9Pg+5f5FfneG6ZtIQnimXai
	bsRkS1aywyclYYdiAp1IL6tSb97lht0NjdXu2b47gVChyiBVdFCOxI47bTO0NskHJgUJn7JLKkA
	FmNzDSrCKdYUazwozf5S8PIb87U9lrKhwte5vJdG9AYRUUvIjlZb0WSQcaKpt8kE/x9I6zjir6O
	YOkX9Dt21/6QAyvIOpmsloVPzDJrA6Xd8TC0ceCZuYcu/+zJHzULFkRRqp8ZbO5flCzknnBxalf
	6u0Oi0u2Dy08rAsuQuEB8sqwD9NwjOjRAXrXR4bTndFZXKt48W9hc=
X-Received: by 2002:a17:903:3887:b0:2ba:83f8:7b7b with SMTP id d9443c01a7336-2ba83f87cfcmr97037775ad.33.1778210296937;
        Thu, 07 May 2026 20:18:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:18:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com
Subject: [PATCH 07/18] lib: rspdm: Initial commit of Rust SPDM
Date: Fri,  8 May 2026 13:16:59 +1000
Message-ID: <20260508031710.514574-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

This is the initial commit of the Rust SPDM library. It is based on and
compatible with the C SPDM library in the kernel (lib/spdm).

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 MAINTAINERS                     |  12 ++
 include/linux/spdm.h            |  39 ++++++
 lib/Kconfig                     |  17 +++
 lib/Makefile                    |   2 +
 lib/rspdm/Makefile              |  10 ++
 lib/rspdm/consts.rs             |  56 ++++++++
 lib/rspdm/lib.rs                | 116 ++++++++++++++++
 lib/rspdm/state.rs              | 235 ++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs          |  73 ++++++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/error.rs            |   2 +
 11 files changed, 564 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..2e8ad57fec5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24164,6 +24164,18 @@ M:	Security Officers <security@kernel.org>
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
index 000000000000..e23e386ed97a
--- /dev/null
+++ b/include/linux/spdm.h
@@ -0,0 +1,39 @@
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
+typedef ssize_t (spdm_transport)(void *priv, struct device *dev,
+				 const void *request, size_t request_sz,
+				 void *response, size_t response_sz);
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
+extern const struct attribute_group spdm_attr_group;
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 00a9509636c1..5a248709132e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -592,6 +592,23 @@ config LWQ_TEST
 	help
           Run boot-time test of light-weight queuing.
 
+config RSPDM
+	bool "Rust SPDM"
+	select RUST
+	select CRYPTO
+	select KEYS
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
index f33a24bf1c19..ef2d33224d89 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -282,6 +282,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
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
index 000000000000..2feddde67885
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Constants used by the library
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+/* SPDM versions supported by this implementation */
+pub(crate) const SPDM_VER_10: u8 = 0x10;
+
+pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
+
+pub(crate) const SPDM_REQ: u8 = 0x80;
+pub(crate) const SPDM_ERROR: u8 = 0x7f;
+
+#[expect(dead_code)]
+#[derive(Clone, Copy)]
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
+impl core::fmt::LowerHex for SpdmErrorCode {
+    /// A debug print format for the SpdmSessionInfo struct
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        writeln!(f, "{:#x}", *self as u8)?;
+
+        Ok(())
+    }
+}
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
new file mode 100644
index 000000000000..758d43fba5cb
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,116 @@
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
+use crate::bindings::spdm_state;
+use core::ffi::{
+    c_int,
+    c_void, //
+};
+use core::ptr;
+use core::slice::from_raw_parts_mut;
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
+/// `keyring`: Trusted root certificates
+/// `validate`: Function to validate additional leaf certificate requirements
+///  (optional, may be %NULL)
+///
+/// Return a pointer to the allocated SPDM session state or NULL on error.
+#[export]
+pub unsafe extern "C" fn spdm_create(
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
+/// spdm_exchange() - Perform SPDM message exchange with device
+///
+/// @spdm_state: SPDM session state
+/// @req: Request message
+/// @req_sz: Size of @req
+/// @rsp: Response message
+/// @rsp_sz: Size of @rsp
+///
+/// Send the request @req to the device via the @transport in @spdm_state and
+/// receive the response into @rsp, respecting the maximum buffer size @rsp_sz.
+/// The request version is automatically populated.
+///
+/// Return response size on success or a negative errno.  Response size may be
+/// less than @rsp_sz and the caller is responsible for checking that.  It may
+/// also be more than expected (though never more than @rsp_sz), e.g. if the
+/// transport receives only dword-sized chunks.
+#[no_mangle]
+pub unsafe extern "C" fn spdm_exchange(
+    state: &'static mut SpdmState,
+    req: *mut c_void,
+    req_sz: usize,
+    rsp: *mut c_void,
+    rsp_sz: usize,
+) -> isize {
+    let request_buf: &mut [u8] = unsafe { from_raw_parts_mut(req as *mut u8, req_sz) };
+    let response_buf: &mut [u8] = unsafe { from_raw_parts_mut(rsp as *mut u8, rsp_sz) };
+
+    match state.spdm_exchange(request_buf, response_buf) {
+        Ok(ret) => ret as isize,
+        Err(e) => e.to_errno() as isize,
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
+/// Perform internal locking to serialize multiple concurrent invocations.
+/// Can be called repeatedly for reauthentication.
+///
+/// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
+/// indicates authentication is not supported by the device.
+#[export]
+pub unsafe extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+    0
+}
+
+/// spdm_destroy() - Destroy SPDM session
+///
+/// @spdm_state: SPDM session state
+#[export]
+pub unsafe extern "C" fn spdm_destroy(_state_ptr: *mut spdm_state) {}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 000000000000..18e81f24c724
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,235 @@
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
+pub struct SpdmState {
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
+    pub(crate) fn spdm_exchange(
+        &self,
+        request_buf: &mut [u8],
+        response_buf: &mut [u8],
+    ) -> Result<i32, Error> {
+        let header_size = core::mem::size_of::<SpdmHeader>();
+        let request: &mut SpdmHeader = Untrusted::new_mut(request_buf).validate_mut()?;
+        let response: &SpdmHeader = Untrusted::new_ref(response_buf).validate()?;
+
+        let transport_function = self.transport.ok_or(EINVAL)?;
+        // SAFETY: `transport_function` is provided by the new(), we are
+        // calling the function.
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
+        if response.code == SPDM_ERROR {
+            if length as usize >= core::mem::size_of::<SpdmErrorRsp>() {
+                // SAFETY: The response buffer will be at least as large as
+                // `SpdmErrorRsp` so we can cast the buffer to `SpdmErrorRsp` which
+                // is a packed struct.
+                self.spdm_err(unsafe { &*(response_buf.as_ptr() as *const SpdmErrorRsp) })?;
+            } else {
+                return Err(EINVAL);
+            }
+        }
+
+        if response.code != request.code & !SPDM_REQ {
+            pr_err!(
+                "Response code {:#x} does not match request code {:#x}\n",
+                response.code,
+                request.code
+            );
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        Ok(length)
+    }
+}
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
new file mode 100644
index 000000000000..58039f532b7d
--- /dev/null
+++ b/lib/rspdm/validator.rs
@@ -0,0 +1,73 @@
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
+        Unvalidated,
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
+impl Validate<&Unvalidated<[u8]>> for &SpdmHeader {
+    type Err = Error;
+
+    fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw();
+        if raw.len() < mem::size_of::<SpdmHeader>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_ptr();
+        // CAST: `SpdmHeader` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<SpdmHeader>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        Ok(unsafe { &*ptr })
+    }
+}
+
+impl Validate<&mut Unvalidated<[u8]>> for &mut SpdmHeader {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<SpdmHeader>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `SpdmHeader` only contains integers and has `repr(C)`.
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
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d73142078240..0231e4f87f20 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -87,10 +87,12 @@
 #include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/slab.h>
+#include <linux/spdm.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
 #include <linux/usb.h>
+#include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 5463addbfd95..386110a1e19f 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -89,6 +89,8 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ECONNRESET, "Connection reset by peer.");
+    declare_err!(EINPROGRESS, "Operation now in progress.");
 }
 
 /// Generic integer kernel error.
-- 
2.52.0

