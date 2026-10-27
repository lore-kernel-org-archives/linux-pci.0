Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078912;
	b=rCkWZFMfEEekyDku82VW5YB7O64p10VTPEu7Wcbxu267ykoeYCqdqcCus7UfXlXBqlhc
	 +wKUCQE5CWpznYkOhqNI9C6c9rZqAe5TQsJ5p1oWpHX9jP0Bvx1+pTjCmuQdPzbTQSXUm
	 +8aZXYvWq1PJ+3JvT5uRG9tCVjHZ6YPKhtj9KxC5GTAfYJXwUOBWRYhYgxr6mXc7VBWF9
	 yyWOIE2grH2fg2XsMpz7rWoKXeqM0TgsnkWnGVXT6kTrRhP1mYwH8aiVvLVfRSPtIdm5z
	 tsfEAWN7I/Zf82XwORKKWDmg2NsRUxSm+a1uDV8OHdC4iynR9fKU/7V2GaX2RwwYVXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aUUrd4E5Xw5s9j+rkflFuxNd81QaxojYSSWf5OfPIxE=;
	b=ND/Ko7o5gkwpMYm2Ozb4ectUjzRTvWN7TTTRVHmwS/FCTEFC5OEit2ubYCPFIyur2qGC
	 IM2Xxha4E0y4a/GTmsovUf/S7Yde17+0AvQkoeKTTUkix5l/VcTEFu+CnyrcABLd8x/B5
	 hbUtaLCs+hPnOgui6u/Eajpp4gdJQn8tgaiHh0yUotK7fjEX/ScBxq6oHjTfxt3MpOfXW
	 d3sRWE4N5utZVUz8JSY30Ti1FRf83QV6MFGkuAiH41BkYyn7LrDZyshug+LSIkdnAGkeR
	 f4PQFnLII16sQiyBNyoboy76Vbx+H01rgd9ig+NTHchONqjc/5bcxlSUi4hT+3hhjXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YTmWG1ES;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25192606A330
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25192606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YTmWG1ES
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ea7987517aso21113645ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078911; x=1793683711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUUrd4E5Xw5s9j+rkflFuxNd81QaxojYSSWf5OfPIxE=;
        b=YTmWG1ESwbN0XwH51gxbHiAuUkW+mAIjKpnvoqopHe1qhUg7eW+lbxcGz5XtZKcgkx
         LjZ6d5vGfifkLR8MRVuS5vA/rUcu627XdWcN8RkBDYq5ieXionVQSJScJ8j3c8CUZoGU
         EdkIY6SXnrOXzpf7VqU1dEg+LVQki3PVsHtAUF/CHyTkbzItIdhw/uiU6mKI5dw7CeC0
         uasVCFfjdntyQqjf1CoMkMxNuMUT4d7rU3IRh7vKIWTfxpODHg32T2UiL5iiq8rMqinB
         ViZG1BEZfHodPejx73/d2VK2f34fbW3KrBEd2ZdZ8j4tqyTVhKkUpgDYpexibRKXN8Kb
         XKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078911; x=1793683711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUUrd4E5Xw5s9j+rkflFuxNd81QaxojYSSWf5OfPIxE=;
        b=KNpxRpJMMCOw9sN/WvoWyjyDtmkoU+evh5ljhorbNhDGRYq2wB0/UG+0HZpFzeoZ3n
         eu8gKjh6Veh07kqF4lozl3pD3caeZ6JpUmNwu+7Oz0NCsE/fiaZ6JlB04jN6RdXRXmP9
         B9/a/kX/mFwAv5epnOFle5libsLVLgydl8CsYd9mFf/56JgHWO0bzIJjnN1zZ2y0JRS5
         f/pHgIVQueE4lenNuROxu/wiyYzs7MXpIrEm1/9vng0e55qzGirohhtUhZM3QyhG2YOg
         SyZ8pBnl6gUNi7zXdTEBk80QT1sHNPrGfP8avSRUNxA8zen8PteV4w8ktz/8TNy1Xvv2
         9RNg==
X-Forwarded-Encrypted: i=1; AKwUvBwcaoV6m7GgqahKZtJ+uhpNlptr54Uqn2KnpODBr9MgbUCg0+N+12T4Fo1xSWdv/EPjsozTdgyORgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5Fl860NUCoVfGfQuZ4EdwhvLuUFx1cAH8MI+SG9pPGw7lvAsD
	8brhTDcMmBixH2QK9tnSi1+9UVDdo05EK1K097YwQ2WTu+P93ra1GDZg
X-Gm-Gg: AYBFou0U2G9B4YKif983QkS82nwwDrTVhQx531sW7cXtVbIK4E68zCElruGvpv3dlaR
	Z+hEm7M1vXMFu+BwfzSUk5Dlw74Yq5lIEZtArVEQwCr/G/GwSwtu8PXVI3UcjYT5S9+wq//vV71
	zS9AgAfm7tGyKaEAB19NHH41EPOWpvMg5JH3z3ur2V1wxcWrOOUbXTo02T8pwHQ79ZvrSDY4BsY
	dWwa/am+/TvwwvzLIQ8adwhxOpexoOJ+zGZWY10CEsHuFeGLSQav896zM9uHKi4n5HsDjc2wjPC
	2XDnztnL5yxLAEO92bY8S+J68BRlHsr8y3j6sHYO0bNKGFj9iHANZI+W6NaPyKELrrk5I+45pbS
	NvbNr9eHlmqhSKxUuJ3IUKkOuGCz7Ge+at0LP2ZtPRfMKlHrah+xcpgwBLGwt+5nEkhnjh+yUYe
	9J2D5zMAVpfwcOqx2NYGm58PkLPNefd/S/kMNVIlIfqe+Ir8Al8vCOTEjx1k2YZrbpW5jELsN7D
	5rvCpjFl2q0mKiYwO2U0J9dGtIIbvZ9cCTEWMcsoUJ4cCq+GVliA+K6FjVTkHIYghazOEIjbfx+
	Zj7LLmmxIEo6UPt/0mEO
X-Received: by 2002:a17:902:ce0d:b0:2e9:7b4f:b994 with SMTP id d9443c01a7336-2ea9c7c8254mr73796515ad.33.1793078911484;
        Mon, 26 Oct 2026 22:28:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:28:30 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 21/23] rust: x509: Add X509 certificate bindings
Date: Tue, 27 Oct 2026 15:25:34 +1000
Message-ID: <20261027052536.1722081-22-alistair.francis@wdc.com>
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

Initial support for the kernel x509 parser bindings,
which will be used by the SPDM library.

This is just a few functions that the Rust SPDM implementation will use
in the next few commits.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/x509.rs             | 118 ++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 rust/kernel/x509.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index da8855899c530..66e18819d52b0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -39,6 +39,8 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_ioctl.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/bitmap.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e8b652faa3b49..aa95aafff8c49 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -153,6 +153,8 @@
 pub mod usb;
 pub mod validate;
 pub mod workqueue;
+#[cfg(CONFIG_CRYPTO)]
+pub mod x509;
 pub mod xarray;
 
 #[doc(hidden)]
diff --git a/rust/kernel/x509.rs b/rust/kernel/x509.rs
new file mode 100644
index 0000000000000..1b5bc2a99c91c
--- /dev/null
+++ b/rust/kernel/x509.rs
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Wrappers around the Linux kernel X509 parser APIs.
+//!
+//! C headers: [`include/keys/x509-parser.h`](srctree/include/keys/x509-parser.h).
+
+use core::ffi::c_void;
+use core::ptr::{self, NonNull};
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
+    public_key::PublicKey,
+};
+
+/// Owned `struct x509_certificate` wrapper.
+pub struct Certificate {
+    cert: NonNull<bindings::x509_certificate>,
+}
+
+impl Certificate {
+    /// Parses a DER certificate from `data` and returns it with the length
+    /// of the certificate in bytes.
+    pub fn parse(data: &[u8]) -> Result<(Self, usize)> {
+        // SAFETY: `data.as_ptr()` points to at least `data.len()` valid bytes.
+        let len = unsafe { bindings::x509_get_certificate_length(data.as_ptr(), data.len()) };
+        let len = usize::try_from(len).map_err(|_| {
+            pr_err!("Invalid certificate length\n");
+            EPROTO
+        })?;
+
+        if len > data.len() {
+            pr_err!("Certificate length is larger then the buffer\n");
+            return Err(EPROTO);
+        }
+
+        // SAFETY: `data.as_ptr()` points to `data.len()` valid bytes and the
+        // caller has already checked that the DER certificate length fits in
+        // that buffer.
+        let cert = from_err_ptr(unsafe {
+            bindings::x509_cert_parse(data.as_ptr().cast::<c_void>(), len)
+        })?;
+        let cert = NonNull::new(cert).ok_or(EINVAL)?;
+
+        Ok((Self { cert }, len))
+    }
+
+    /// Returns the raw pointer for the X.509 certificate.
+    /// This is what is returned from the C function x509_cert_parse()
+    pub fn raw(&self) -> *mut bindings::x509_certificate {
+        self.cert.as_ptr()
+    }
+
+    /// Check that the certificate is not unsupported or blacklisted.
+    pub fn check_accepted(&self) -> Result {
+        // SAFETY: `self.cert` was returned by `x509_cert_parse()` and remains
+        // valid until dropped.
+        let cert = unsafe { &*self.cert.as_ptr() };
+        if cert.unsupported_sig || cert.blacklisted {
+            pr_err!("Certificate was rejected\n");
+            return Err(EKEYREJECTED);
+        }
+
+        Ok(())
+    }
+
+    /// Verify that `child`'s signature is signed by this cert's public/private key.
+    pub fn verify_signed(&self, child: &Self) -> Result {
+        // SAFETY: both certificate pointers were produced by `x509_cert_parse()`
+        // and remain valid until dropped.
+        let (prev, child) = unsafe { (&*self.cert.as_ptr(), &*child.cert.as_ptr()) };
+
+        let prev_pub = NonNull::new(prev.pub_).ok_or(EINVAL)?;
+        let child_sig = NonNull::new(child.sig).ok_or(EINVAL)?;
+
+        // SAFETY: `prev_pub` and `child_sig` are valid for at least the duration
+        // of this call.
+        unsafe {
+            to_result(bindings::public_key_verify_signature(
+                prev_pub.as_ptr(),
+                child_sig.as_ptr(),
+            ))
+        }
+    }
+
+    /// Transfers the public key out of the certificate so the certificate can be
+    /// dropped without freeing the public key.
+    pub fn take_public_key(&mut self) -> Option<PublicKey> {
+        // SAFETY: `self.cert` is a valid certificate pointer.
+        let raw = unsafe { (*self.cert.as_ptr()).pub_ };
+        let key = NonNull::new(raw)?;
+
+        // SAFETY: `self.cert` is a valid certificate pointer. Clearing `pub_`
+        // transfers ownership of the public key to the returned `PublicKey`.
+        // The `pub_` field will not be freed by `x509_free_certificate()` in
+        // Drop
+        unsafe {
+            (*self.cert.as_ptr()).pub_ = ptr::null_mut();
+        }
+
+        Some(PublicKey::from_raw(key))
+    }
+}
+
+impl Drop for Certificate {
+    fn drop(&mut self) {
+        // SAFETY: `self.cert` was produced by `x509_cert_parse()` and has
+        // not been freed yet.
+        unsafe {
+            bindings::x509_free_certificate(self.cert.as_ptr());
+        }
+    }
+}
-- 
2.56.0

