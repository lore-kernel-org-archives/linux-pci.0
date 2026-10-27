Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078904;
	b=GMEGimoxgvJ9bJgw8fYInAXhftHIAQHBdXsoYRb3ZmmOu5+QwdN230yCbiWym7Vu0zPp
	 Du1PgzCQ7CXqIKZn6UG4ryDSO5WBlzGOXN5uk8ClDx+I0CQgibKBLctXvAEZGzMkZ5uuc
	 tG5k11QW4slnhHukNsldmLhvTTolyOvzHm5QYZ1jjnysMGN8O8jQWjL9ND3doRmb/DtzA
	 uQeQYfLYdROOpPkuim8v4g2Q3GnvVCY2THtOtVD/eKEs2IXWbwGFJk9COl2hKbK4yAACH
	 UMDlHhdZVHoyEV5u94om+lyJijKnRmfySDrKQbTy4QEPq6Hshu+qGOVU+/WdpHvylOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3hMKyPaWEskOkBv5OG5DqLWYBk+n+YndVnXQUQRhXr4=;
	b=q4EpBBOWmghhRLasYItqGlEl8CF4n7sEOUapscycpX2MLGTVQGdvPh0ny9MInh48cCCs
	 opbCSfG6s1bh+fJIOtL7MLFhFW9D0S0atEUifVgNZKK9ioedBB0ccPbDTCEIRiGfBZFvg
	 fMiq2T5Zl1LlIdhyr6Civ7Bfu4T8U4vCUMBAVqRgMQ+zeoDprD9kvk21LFGoJ0jh14u7Z
	 /W3rMgzhYuy+dCcQoon0s2CFgR0+tXXCUZnSJdY6BtL3kSMtxjoEcLbo84yqv9r2Td0B4
	 V76NyY0r++/zWEi11Wgj6BCgwZCHgj9q+wYmygc2aO2stE7d9jAKWVGby7ZQJU/3c+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="YmQ/doa3";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838BA606A323
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 838BA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmQ/doa3
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9ae391a05so4129845ad.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078904; x=1793683704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hMKyPaWEskOkBv5OG5DqLWYBk+n+YndVnXQUQRhXr4=;
        b=YmQ/doa3Tp9ADiNWK9TKhBal34RqpzT+ddGpWNx00MH8fgCJWAnWAV/NTFOkEgLo3n
         kU1EkuRLZtCaYK8MxHf/5EJ+Bn0740V11yy7Zph3QgLB33pXnppAeRzg2Fjoo5ScN1lc
         AHTIhuBI98zFCVN00yliB3O2sJ0/lyagaM0DbMx3xSVFC+Y3eRg42ZnYGqnx92to6k4P
         1sh7N9tAPLGJr1iwOxe+CkBsEbW9f9X7Fo3ZNY97TR4ZUliEGLy15OlmnzS4JqW5Zh4J
         8gJz/G/CNd8RJz9VpfeMHyo199bp1EWPxOIH292Q8qJ456+HTdb1NXTqtt+St2MV2Wov
         iQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078904; x=1793683704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3hMKyPaWEskOkBv5OG5DqLWYBk+n+YndVnXQUQRhXr4=;
        b=PFCpuvBioL941jX3f7HfJUu/pacXGt5bh7dyJKdKe0Pr3VyUCCTiLw8E50IkDR6csw
         yK2drjmEqwgIIqQfm8LU5PbMqOl2EQIOm7wS9mksPVOyeb7h0WI6SaBqHooy4c38lpEY
         BXuGTryuHnbaQRrj3xVV2WFLvyQnpAUEB2weD53DQwYyz1d8rHLIpPfHsAEbZL/w4HlN
         SjRRa1KiUMo3GR3SLjfoYPHhpGOK8b0/FR1JxUjzX9FzQJZvZMUhv/V54s0DxjILA6Os
         SIRc4zy1YN9eKQYBc0tn0vajQCF0IH3ohra60xSknElYWeJUuD5pxQZKqsJPK6VRHfl9
         RJig==
X-Forwarded-Encrypted: i=1; AKwUvBxwdocUx6LLO9XDeqmavEvH1hfOS/JBiotWhRkM10PikOM7JHgYsk+Mf7hwSnI8OCJG/Y3otyLQy0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJURA9CtC96E6mq1G9QLm1ZapVlcIZP+GN1yfvYyTga5c9iWoo
	tPjCKEEPR01T9peXnOYfKIXkfj2t+Mp1AccNi5eE3CkRlwnylI+EOLxr
X-Gm-Gg: AYBFou31PPPsL7prxynX7aaPhthijGIlnylUjCT+Adjui0aMFS19l7TehIN2AsDaNZz
	CYqFVHVkN747sdnfV4Xscyl3O3j2rF9DRB/ig51mDucdfkfNWZ7Qx8/PQdNyVikkgrkZmnMGSVs
	tdtd5HF9IUisYaILf4UcVwiJZRNA66JrNv5hTBRafS2zVGLRwRtNfOvpiEGljgoRwjbbW92egcA
	sm38/YZVhjgmhDd+7d4STVDRpivGGciQTYHtwIyiqx0XkdAn5FxD2oI9Li8+7/+945CFIUlKXzC
	+lrUun/AhLblfNDr3ipD1B+34Mf4zjfUY8MVAcmK7tEWOUZgm/rnaOdoD1d6De2jk9JW3Irnatj
	e3HmBjZSsNL+Y0IJ/gkDd08OGvz4ppfsUJfH9756qsqSOYu8ahPKELZywwMVS0C+mwPgIpzn1g3
	KD8m+epbYtHqvlfeUqKEKBEuX05PB7dTc/HbzN2XnyF5A2Ver0fqR8BDmvP0k5ZKL4ew8QZlRm3
	Mr7komDTO2+oNzV7Mi9D2HwxPtyleDD+/V7KGXlryJe16lmViKrAr2vb6p1MY3CeuP+0eViww==
X-Received: by 2002:a17:903:2ecd:b0:2e9:3a86:b995 with SMTP id d9443c01a7336-2eae39fdae1mr11913125ad.15.1793078903879;
        Mon, 26 Oct 2026 22:28:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:28:22 -0700 (PDT)
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
Subject: [PATCH v5 20/23] rust: public_key: Add crypto public key bindings
Date: Tue, 27 Oct 2026 15:25:33 +1000
Message-ID: <20261027052536.1722081-21-alistair.francis@wdc.com>
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

Initial support for the kernel crypto public key (asymmetric-keys) bindings,
which will be used by the SPDM library.

This is just a few functions that the Rust SPDM implementation will use
in the next few commits.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  2 +
 rust/kernel/public_key.rs       | 69 +++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 rust/kernel/public_key.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a2512fda77e1f..da8855899c530 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -29,6 +29,7 @@
 #include <linux/hrtimer_types.h>
 
 #include <crypto/hash.h>
+#include <crypto/public_key.h>
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <drm/drm_device.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f7db5975e7621..e8b652faa3b49 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -122,6 +122,8 @@
 pub mod print;
 pub mod processor;
 pub mod ptr;
+#[cfg(CONFIG_CRYPTO)]
+pub mod public_key;
 #[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
 pub mod pwm;
 pub mod ratelimit;
diff --git a/rust/kernel/public_key.rs b/rust/kernel/public_key.rs
new file mode 100644
index 0000000000000..e1d51333c1179
--- /dev/null
+++ b/rust/kernel/public_key.rs
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Western Digital
+
+//! Wrappers around the Linux kernel crypto public key APIs.
+//!
+//! C headers: [`include/crypto/public_key.h`](srctree/include/crypto/public_key.h).
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/crypto/asymmetric-keys.html>
+
+use core::ptr::NonNull;
+use kernel::prelude::*;
+use kernel::{
+    bindings,
+    error::to_result,
+    str::CStr, //
+};
+
+/// Owned `struct public_key` wrapper.
+pub struct PublicKey {
+    key: NonNull<bindings::public_key>,
+}
+
+impl PublicKey {
+    /// Create a Rust `PublicKey` from a valid C `struct public_key` pointer.
+    pub fn from_raw(key: NonNull<bindings::public_key>) -> Self {
+        Self { key }
+    }
+
+    /// Verify a signature using this public key.
+    pub fn verify_signature(
+        &self,
+        signature: &[u8],
+        encoding: &'static CStr,
+        hash_algo: &'static CStr,
+        message: &[u8],
+    ) -> Result {
+        let sig = bindings::public_key_signature {
+            s: signature.as_ptr().cast_mut(),
+            s_size: signature.len() as u32,
+            encoding: encoding.as_char_ptr().cast::<u8>(),
+            hash_algo: hash_algo.as_char_ptr().cast::<u8>(),
+            m: message.as_ptr().cast_mut(),
+            m_size: message.len() as u32,
+            ..Default::default()
+        };
+
+        // SAFETY: `self.key` is a valid public key handle, and `sig` points to
+        // valid signature/message data owned by the caller for the duration of
+        // this call.
+        unsafe {
+            to_result(bindings::public_key_verify_signature(
+                self.key.as_ptr(),
+                &sig,
+            ))
+        }
+    }
+}
+
+impl Drop for PublicKey {
+    fn drop(&mut self) {
+        // SAFETY: `self.key` was either returned by `x509_cert_parse()` or
+        // manually transferred from an `x509_certificate` and has not been
+        // freed yet.
+        unsafe {
+            bindings::public_key_free(self.key.as_ptr());
+        }
+    }
+}
-- 
2.56.0

