Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7103446AA
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780647; cv=none; b=EhjeuZBwppDCcjYWAQdfuaf8rDo0+BuMota1rlZa6a7D1yuxlWBmbzC9CsFBnqv+DS1xFbAzEUudB38SLEgvYpeO8YA7qzLKXihoXgxcUZThKiZCll1xITDoTM52o6xfFLfQVWTPot7irg5lpE6YsKbaq7k4PFv0u4ehsmJE2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780647; c=relaxed/simple;
	bh=C7hFCBJ4jy1LC61UrDjuGzjl8PoRstenDjFFfmrnCKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVNt6kTRwUpKXQdhwdjYdo3VZrFgnrAyCs64dBl4L165asB6nr0Zfj3uIXhQi1VotncRTxC9+6JFa7tlYPiiPDMmeteD8/wgICp+NkOIDlOdagN0tzEtResU7dxSHK/gt5aZY3pOf6CZVGr5H4u4boaG65RLyaaXHs1vLAqswcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOJ1Deb9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOJ1Deb9"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c2af7d09533so4344067a12.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780644; x=1771385444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecqWhffp6slyER88bcn38vxCbbcm7/8ZALH5p22zzrY=;
        b=WOJ1Deb96Lc0TiVnvYlaCaGvUKXdYuCtBHaijTj2xLe/SR/kDlR3xp1YLHAe4ks5sK
         0HBhDEg2BH9CXdL7lWYxqQNUtG79SL7EDQBpBREuCKRJjOVpQ1TAUQ3UNU/mJ7AXr3Oo
         i19kOFN0zUrAN7sG3BNIlO0C3Mhvnd5/vESNRTmo6xovfcHOM2XDAK58fFVrqGc3dXTZ
         kKNquT66rhQAiXczF8e10N4bHcwqOkDcUoCW8tlRrHY8sYywLUfjiYWbqYpjgxMLiXxD
         Ycv2wJVAkkjRW55Hbhx/Nm9UNt77oQCqplmnnRwwMGX53erTaMtraCoYOj60z33TkF/P
         RysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780644; x=1771385444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ecqWhffp6slyER88bcn38vxCbbcm7/8ZALH5p22zzrY=;
        b=Erya9ZAc0g4tdOSJR1zetXL9krfUOxk1KirmOtS4BkUsPBNZvz5rm0ELucoZ79Ib1w
         O3W6Gfz6Qcr+XWfO3dGyqN8E1/W5WH23dA4UHPwTGLVtbSdxQnrLGaRaOyAWDv2oH7WH
         Txt9E+OiyI0KIuTJKt6k2nvdNCRlvZYSFQcdukHnR8a4DcjmJhyEmfJCP0PXOKTrdH9T
         9CaP3XVhcxFUwNE5CD5GkK5tBf1Ie5bIe951gD64uRINdhLuzEBHkcOvm6riHMpCfZ/N
         EgFlBn28hJGU5sVkQKqThMnWSlYCQ7eiD5DG/NnPBGkEMxsFunXsYL+VEEdwztirTuvP
         VjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5ukuY/WqGiJjNF9WIMj4md2mn4Uo37GH4826IRT1bgVBpg1U/+p3bvL9YeCnX375IoqYAWHbA4l0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8C84xajUninopbnSIJmSLB9L9ORmtQDFz4fSenYKqeIf1HlHy
	NRvNt/rLaTII950/PdDac86cUPd/I+R6sxNeJ9SxaynHwlyPb9/eCpI3
X-Gm-Gg: AZuq6aKtwhvl8DVByk3wQU5H6p3IlW+2m7c2vS6gT3ME2t4aavLf4ctQ9jzKE0+fxqf
	PyPyaj3P3u6fPD8nNDgiyLMrazjjLWmDOTgCOSdgwlA+laYoms1z6xxFmGEmZAaiZ5YjX6xfkN2
	ioNHL60WiVoAfiyp9WJ12Fh1UMXzEXngSt+U71jXdQeZgu3WMS0bQ2ug4tQ6gWHiTAD4GqS1czZ
	ngYa8w0iVKcxijTPz91FHtmvx5MwB+Cr1ciLYHqiN5yQC497n4NLLmM05iw39Oo+RZ/AYB7y52w
	0rBqTkfblLlE4cLd/gIgPo8USw8cYh74/9bJ/2/oJXNYm+OpCpVPCNZsI+YTFsrGGjczrBxks/c
	4SdiQfHL7HJoDF558Vf/kZ3x+vlIahFguG5hJGVAS5jWAOfzMifO+EO79l6tV6MEJJzok7cdmA6
	Hz5D9p0VRMIG0YwnfqLiwICY9XinRw3sPQhR7p19NWLQ==
X-Received: by 2002:a05:6a20:258a:b0:366:14ac:e1f9 with SMTP id adf61e73a8af0-394325037e1mr772915637.75.1770780643986;
        Tue, 10 Feb 2026 19:30:43 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:43 -0800 (PST)
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
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v3 08/27] lib: rspdm: Initial commit of Rust SPDM
Date: Wed, 11 Feb 2026 13:29:15 +1000
Message-ID: <20260211032935.2705841-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
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
 lib/rspdm/consts.rs             | 117 +++++++++++++++++
 lib/rspdm/lib.rs                | 119 +++++++++++++++++
 lib/rspdm/state.rs              | 220 ++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs          |  66 ++++++++++
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/error.rs            |   3 +
 11 files changed, 607 insertions(+)
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/validator.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 149deedafe2c..a5c4ec16081c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23693,6 +23693,18 @@ M:	Security Officers <security@kernel.org>
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
index 000000000000..9835a3202a0e
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
+			       struct key *keyring, spdm_validate *validate);
+
+int spdm_authenticate(struct spdm_state *spdm_state);
+
+void spdm_destroy(struct spdm_state *spdm_state);
+
+extern const struct attribute_group spdm_attr_group;
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 2923924bea78..c21f9f9a5221 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -604,6 +604,23 @@ config LWQ_TEST
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
index 22d8742bba57..2f530471e8dc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -286,6 +286,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
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
index 000000000000..40ce60eba2f3
--- /dev/null
+++ b/lib/rspdm/consts.rs
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Western Digital
+
+//! Constants used by the library
+//!
+//! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
+//! <https://www.dmtf.org/dsp/DSP0274>
+
+pub(crate) const SPDM_REQ: u8 = 0x80;
+pub(crate) const SPDM_ERROR: u8 = 0x7f;
+
+#[expect(dead_code)]
+#[derive(Clone, Copy)]
+pub(crate) enum SpdmErrorCode {
+    InvalidRequest = 0x01,
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
+    VendorDefinedError = 0xff,
+}
+
+impl core::fmt::LowerHex for SpdmErrorCode {
+    /// A debug print format for the SpdmSessionInfo struct
+    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+        match self {
+            SpdmErrorCode::InvalidRequest => {
+                writeln!(f, "0x01")?;
+            }
+            SpdmErrorCode::InvalidSession => {
+                writeln!(f, "0x02")?;
+            }
+            SpdmErrorCode::Busy => {
+                writeln!(f, "0x03")?;
+            }
+            SpdmErrorCode::UnexpectedRequest => {
+                writeln!(f, "0x04")?;
+            }
+            SpdmErrorCode::Unspecified => {
+                writeln!(f, "0x05")?;
+            }
+            SpdmErrorCode::DecryptError => {
+                writeln!(f, "0x06")?;
+            }
+            SpdmErrorCode::UnsupportedRequest => {
+                writeln!(f, "0x07")?;
+            }
+            SpdmErrorCode::RequestInFlight => {
+                writeln!(f, "0x08")?;
+            }
+            SpdmErrorCode::InvalidResponseCode => {
+                writeln!(f, "0x09")?;
+            }
+            SpdmErrorCode::SessionLimitExceeded => {
+                writeln!(f, "0x0a")?;
+            }
+            SpdmErrorCode::SessionRequired => {
+                writeln!(f, "0x0b")?;
+            }
+            SpdmErrorCode::ResetRequired => {
+                writeln!(f, "0x0c")?;
+            }
+            SpdmErrorCode::ResponseTooLarge => {
+                writeln!(f, "0x0d")?;
+            }
+            SpdmErrorCode::RequestTooLarge => {
+                writeln!(f, "0x0e")?;
+            }
+            SpdmErrorCode::LargeResponse => {
+                writeln!(f, "0x0f")?;
+            }
+            SpdmErrorCode::MessageLost => {
+                writeln!(f, "0x10")?;
+            }
+            SpdmErrorCode::InvalidPolicy => {
+                writeln!(f, "0x11")?;
+            }
+            SpdmErrorCode::VersionMismatch => {
+                writeln!(f, "0x41")?;
+            }
+            SpdmErrorCode::ResponseNotReady => {
+                writeln!(f, "0x42")?;
+            }
+            SpdmErrorCode::RequestResynch => {
+                writeln!(f, "0x43")?;
+            }
+            SpdmErrorCode::OperationFailed => {
+                writeln!(f, "0x44")?;
+            }
+            SpdmErrorCode::NoPendingRequests => {
+                writeln!(f, "0x45")?;
+            }
+            SpdmErrorCode::VendorDefinedError => {
+                writeln!(f, "0xff")?;
+            }
+        }
+        Ok(())
+    }
+}
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
new file mode 100644
index 000000000000..2bb716140e0a
--- /dev/null
+++ b/lib/rspdm/lib.rs
@@ -0,0 +1,119 @@
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
+//!
+//! This mimics the C SPDM implementation in the kernel
+
+use core::ffi::{c_int, c_void};
+use core::ptr;
+use core::slice::from_raw_parts_mut;
+use kernel::prelude::*;
+use kernel::{alloc::flags, bindings};
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
+#[no_mangle]
+pub unsafe extern "C" fn spdm_create(
+    dev: *mut bindings::device,
+    transport: bindings::spdm_transport,
+    transport_priv: *mut c_void,
+    transport_sz: u32,
+    keyring: *mut bindings::key,
+    validate: bindings::spdm_validate,
+) -> *mut SpdmState {
+    match KBox::new(
+        SpdmState::new(
+            dev,
+            transport,
+            transport_priv,
+            transport_sz,
+            keyring,
+            validate,
+        ),
+        flags::GFP_KERNEL,
+    ) {
+        Ok(ret) => KBox::into_raw(ret) as *mut SpdmState,
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
+#[no_mangle]
+pub unsafe extern "C" fn spdm_authenticate(_state: &'static mut SpdmState) -> c_int {
+    0
+}
+
+/// spdm_destroy() - Destroy SPDM session
+///
+/// @spdm_state: SPDM session state
+#[no_mangle]
+pub unsafe extern "C" fn spdm_destroy(_state: &'static mut SpdmState) {}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
new file mode 100644
index 000000000000..68861f30e3fa
--- /dev/null
+++ b/lib/rspdm/state.rs
@@ -0,0 +1,220 @@
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
+    error::{code::EINVAL, to_result, Error},
+    validate::Untrusted,
+};
+
+use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
+use crate::validator::{SpdmErrorRsp, SpdmHeader};
+
+/// The current SPDM session state for a device. Based on the
+/// C `struct spdm_state`.
+///
+/// `dev`: Responder device.  Used for error reporting and passed to @transport.
+/// `transport`: Transport function to perform one message exchange.
+/// `transport_priv`: Transport private data.
+/// `transport_sz`: Maximum message size the transport is capable of (in bytes).
+///  Used as DataTransferSize in GET_CAPABILITIES exchange.
+/// `keyring`: Keyring against which to check the first certificate in
+///  responder's certificate chain.
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
+    pub(crate) keyring: *mut bindings::key,
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
+        keyring: *mut bindings::key,
+        validate: bindings::spdm_validate,
+    ) -> Self {
+        SpdmState {
+            dev,
+            transport,
+            transport_priv,
+            transport_sz,
+            keyring,
+            validate,
+            version: 0x10,
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
index 000000000000..a0a3a2f46952
--- /dev/null
+++ b/lib/rspdm/validator.rs
@@ -0,0 +1,66 @@
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
+    error::{code::EINVAL, Error},
+    validate::{Unvalidated, Validate},
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
+    pub(crate) code: u8,
+    pub(crate) error_code: SpdmErrorCode,
+    pub(crate) error_data: u8,
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 0075c4b62c29..5043eee2a8d6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -84,7 +84,9 @@
 #include <linux/slab.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
+#include <linux/spdm.h>
 #include <linux/usb.h>
+#include <linux/uaccess.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 569d9d032ab3..c9f57082e481 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -88,6 +88,9 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ECONNRESET, "Connection reset by peer.");
+    declare_err!(EMSGSIZE, "Message too long.");
+    declare_err!(EINPROGRESS, "Operation now in progress.");
 }
 
 /// Generic integer kernel error.
-- 
2.52.0

