Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C6347500
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557969; cv=none; b=jcgdDkorDGIn0cQKA6FjHJ7MUlBotwGcnfLTKiYQ9AeMTzgvRwX9X9LW5dYW2IdmFsnQH2Ag32jByKxn047JPYACiKd4BDTYchUXUj3UGbxzny+JKHMfvWvEZdr5W1Yr79NmjEn3+mSJuZOIOhU3skMM4sjznSiF+vV7v1X1+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557969; c=relaxed/simple;
	bh=63FrloXCOr5dD1lze4Uhw8RrAp0L/Tgy7UEiNJU/BQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p15TpotZD5IKNfvWBoOs4BIpAJCjgw4nCEn3MdXKyV+NnHAcvGta8CkyjfRZeaveGZJokjNDL4cdGbvuOWwwiCLRfq2FCdG7rXNBbjWbRvy32LUE57ZHJ2WpBFGqPvquXBMrKLskucg9EuCbjcfokdUHh33ToQYd9MFUsLL/4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsdRLrJs; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsdRLrJs"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1377054a91.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557966; x=1791162766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRzo4Xi/e2r9wVIj1peiZEHiJq/qEMc409uDyNp3Rac=;
        b=OsdRLrJskHGn0aB18bAr1+wmaU/Dybdw/O6FGvKaKk6epIaO6O1iHFNGcTYEOiJdwk
         8CKWdV4SZnM9Aa96IdPNMG2NYv2tXJul4sUcOFxPyUgHLULGANil3seTeTgNxSPf1N4e
         T3gKSZevLvRX0dv7XFjXh/6ZD46gH+kCf2RJgDZYOWCy/tbOFCNnMC7N2olH6z+Po1BT
         WuNGoJuYPCyB53qGlyHlvTvGoN7Wy3jKCsQutNvjuYoAayrIdCZwX3GVvzMX9aLwM26T
         zlr36JhC+hBBEqYNHPSJaWLjO/5cN82yqb702t296XD8S2H+5GqUkP4gHCK8sSW/m64E
         S5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557966; x=1791162766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRzo4Xi/e2r9wVIj1peiZEHiJq/qEMc409uDyNp3Rac=;
        b=nDkKZrPqp2fUv8uT38T50ZKzHlkJZgQXqiFfPOgzri4tcQCEnC3qmLDeRGEQUWUxGN
         p1rrw/tFhYiUe73gNqqzmwcbxlKcfHr3HB4nPPyUn0/DyRMivvjqU5F7N8Fdfvnrv2eP
         8VegwZsJ0ncjm4ZR/W1joUB/LAWkLZiX/XC0z/UtkZW/vp/PTFK3qjE6/oYc706licO1
         B6udAbI/MYxWtrSlofSOwM+rwygYPMVnTQ+PhDUVp0k1/IY+Ys28StS+0UAp1NzNAcDZ
         rH85FJSVnKRavw6nxPGg6eep74bes0zvAbA7XFyUjqrh8znAjljOA0wroz1IFku6bSvW
         0xYw==
X-Forwarded-Encrypted: i=1; AKwUvBzDYuBlm81NlcdTJ8WHvH/PQPJKXpR3I3d0abSyqiyvB+bK8ZK4/TwipE5swRwHqL83X1I7Pcg2/bE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5EcBJDDiskU3HosERWGk0CfTry7v+3wxzQOcx0vkpbzGobXsO
	lKGVYte7GZCWH0zI9hbFGcerqcoStCnL6fcbDfOW8SrYLIpc0ZRmhGxc
X-Gm-Gg: AYBFou1QSIiOVJ4w1DrFCpqZzvFFcwNYUtFXDB/pkK0/rqH9EHQisZOYY4wXmef1DBC
	XNL5clmzG8ohsoOLHz4vfyn5hRYV6cLYCu8hwEgD7kvT6okhMv77jpZH6ev32V2emw8fuKYa0Pw
	NloiT0e6GoY1T1L7D2tudsyKH9+sP1hQtoiYgLFelhUoX85JBlfbFMUIiWITh2O4er/j8MbQ6jk
	125Cyt8GxrbdvVnvw385YDNehKL5FditKAPKyhR0UKMdcxRqM82t3DMaD8DNpDEwbPqmdD8vOfN
	fzc/ux6RzIipTmD5A27poem+82tl286AIdjPga/5ZY7d6Xud0mIqWUT/zXtHHptxEKmWiSuFEeB
	5s+0ecBwWXdL7QWIrj2cmASPg78cb3FV87f3jpG2xSh+OULQXJmQYMO7rjc8FjEqXFOA2Vf01OY
	9Ozi6vESELAfPZzgmyjcDmbDJKM9ix19g1hnq4okmbotDVp648pxUhh884kJM0JSRmn00C002Xv
	NPkL1LEmLqFrFJLyx/Ul45p/Vk=
X-Received: by 2002:a17:90b:5384:b0:3a4:7194:1805 with SMTP id 98e67ed59e1d1-3a4719421cfmr565973a91.62.1790557965944;
        Sun, 27 Sep 2026 18:12:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 10/22] lib: rspdm: Initial commit of Rust SPDM
Date: Mon, 28 Sep 2026 11:11:11 +1000
Message-ID: <20260928011123.450800-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 MAINTAINERS                     |  12 ++
 include/linux/spdm.h            |  37 +++++
 lib/Kconfig                     |  17 +++
 lib/Makefile                    |   2 +
 lib/rspdm/Makefile              |  10 ++
 lib/rspdm/consts.rs             |  92 ++++++++++++
 lib/rspdm/lib.rs                |  96 +++++++++++++
 lib/rspdm/state.rs              | 241 ++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs          |  93 ++++++++++++
 rust/bindings/bindings_helper.h |   1 +
 10 files changed, 601 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index cc6a2d0e0d38..424e25710ed2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24748,6 +24748,18 @@ M:	Security Officers <security@kernel.org>
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
index 4e6b34c3346d..b84facfa88bc 100644
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
index 000000000000..3f5cae33ccb8
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
index 000000000000..9709f51849d7
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
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
index 000000000000..1010bd38df6d
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,96 @@
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
+    new_mutex,
+    sync::Mutex,
+    types::ForeignOwnable, //
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
+    // Wrap the `SpdmState` in a `Mutex` so that concurrent FFI callers (for
+    // example, two threads racing on `spdm_authenticate()` for the same
+    // device) serialize on the lock and never form aliased `&mut SpdmState`
+    // references.
+    let state = SpdmState::new(dev, transport, transport_priv, transport_sz, validate);
+    match KBox::pin_init(new_mutex!(state), flags::GFP_KERNEL) {
+        Ok(b) => b.into_foreign() as *mut spdm_state,
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
+
+    // SAFETY: `state_ptr` was returned from `spdm_create()` which used `into_foreign()`
+    // to create the pointer.
+    let mutex: KBox<Mutex<SpdmState>> = unsafe { KBox::from_foreign(state_ptr as *mut c_void) };
+
+    drop(mutex);
+}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 000000000000..c894cf30bb87
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
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
+/// The current SPDM session state for a device.
+///
+/// Concurrent access is serialised by wrapping the whole struct in a
+/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` callers
+/// run one at a time and the locked `&mut SpdmState` is the only way to
+/// reach the inner fields.
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
+        let request: SpdmHeader = Untrusted::new(&request_buf[..]).validate(&*self)?;
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
+        let response: SpdmHeader = Untrusted::new(&response_buf[..]).validate(&*self)?;
+
+        if response.code == SPDM_ERROR {
+            let error_rsp: SpdmErrorRsp =
+                Untrusted::new(&response_buf[..header_size as usize]).validate(&*self)?;
+            self.spdm_err(&error_rsp)?;
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
index 000000000000..b14c066e6a51
--- /dev/null
+++ b/lib/rspdm/validator.rs
@@ -0,0 +1,93 @@
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
+    consts::SpdmErrorCode,
+    SpdmState, //
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
+#[repr(C, packed)]
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
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmHeader {
+    type Err = Error;
+
+    type Context = &'c SpdmState;
+
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Result<Self, Self::Err> {
+        Ok(SpdmHeader {
+            version: *unvalidated.get(0).ok_or(EIO)?,
+            code: *unvalidated.get(1).ok_or(EIO)?,
+            param1: *unvalidated.get(2).ok_or(EIO)?,
+            param2: *unvalidated.get(3).ok_or(EIO)?,
+        })
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct SpdmErrorRsp {
+    pub(crate) version: u8,
+    /// This will always be SPDM_ERROR (0x7F)
+    pub(crate) code: u8,
+    pub(crate) error_code: SpdmErrorCode,
+    pub(crate) error_data: u8,
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmErrorRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState;
+
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Result<Self, Self::Err> {
+        Ok(SpdmErrorRsp {
+            version: *unvalidated.get(0).ok_or(EIO)?,
+            code: *unvalidated.get(1).ok_or(EIO)?,
+            // `try_from` rejects unknown `SpdmErrorCode` discriminants.
+            error_code: SpdmErrorCode::try_from(*unvalidated.get(2).ok_or(EIO)?)?,
+            error_data: *unvalidated.get(3).ok_or(EIO)?,
+        })
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

