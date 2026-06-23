Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE873A8FF6
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190635; cv=none; b=Up/8v4rqjDFfz/sWPdbX5eZ4AlF30wacM0G8k1HbZutQu3JsGcGv9uqvm+t/8aE/qmCM5u2esXhYUuHZm7074stPRJaxcAwtwPWi3ooFQ19ajnKD5W8vds1HKiwkdoo5uB33VoIxrH+xSsqDLTEFIOkzY1w/YfrSZaGT36XGT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190635; c=relaxed/simple;
	bh=Mw8NkYsmBR6ESAc0dqr5Ove/VUU44rijqa5ICCADj4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO4fRZRXjhQZ7quKKEfRf8UrGLFQCYiL4eeXXf50gxQc6LV+srHsot8H3bFRzM7Q/HypstlyQ7jOl04QkQnRZuUVZsmCY+M3o9HIp3HD4aYSqhxerNmIiO9Wqv9QB4u8tyIanoHKt/EYJQnwfV7QmByyPeXFdqthCoe5f7djDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coISZFD4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coISZFD4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso55300615ad.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190633; x=1782795433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkeA6BX6Sh1BZCRARlyEG/YVG0LIDez0LrcQTOxN6Ic=;
        b=coISZFD4jR8XYSQQDXgAuYDBFBcldRNWk6sSQaXOpAWiQ0v79DNMUgcdxKcuRXQPWY
         7Hnam7427zVxjf4ONBH5xqU3vWcfppsczvQGjDlaQPShIM/AnH+q8Rdh/IFc4yjzyeD0
         MKaHPr9arsZ5HzEUZO25tfG5Kouml3jAvADh257GOlz5eKlVH772nwDaAQ5hC6Y7qkyq
         XJA2DbtwkeKQ8uyGLajb1zMBAA8CbDRqD1nIzfVZiJj2cuQ66Mj/SKyzXaPV2LU7ePK/
         Q2wOrIQQ3pTDJynCluV8KHmtJHvWbD820iSDWB+7zhiaXIcBCuQGJLmGEDHT1a4mC0mq
         wPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190633; x=1782795433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KkeA6BX6Sh1BZCRARlyEG/YVG0LIDez0LrcQTOxN6Ic=;
        b=NXbgjIQIDCd2x4oytbFLi0V/e4HZCqQsO0gMy6HYLTWHOmxhUig98EHmXqHeACwWk4
         Xt1uq1CqE3WG0nzYRRpfLgcY/FyRgRcyjlmQDW15os5aghDc3aoHxn/ul+VXDl0+Ij2Y
         NPK03s3GOvofXkq1dVTekow6yvZ/tSvDtb3sljQf8J7Sj0r4Cbg2WldHEJjYUjdBC4qb
         lL2c4mDHWEty3DfpIeg9eYXU+FZjLuUKGI2kzBt57D1JBTCSQEFcI3aD/CNsJcyJZKHC
         Bho2aRcTCje56wk/6eMpG01XSXca19h5srqEPcfyQWfhJAmQhVHcTxWGfFVLJbO9YLE5
         bXhg==
X-Forwarded-Encrypted: i=1; AHgh+RrY0UqJIQrlpMPdsYeX5MOGHphMRcJBzdePxQ1SZ5FBA1tTWGRBO2NPiWLh5JIYgRkUvZL3tIZjU2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXaCgFFSje0lOffNWaMJb6fHNfcqG6mXEaYG2c6Nbdjzx0mPG
	tUt1hjnVxBTpmOMkqoDt8jLCeU0lLKiNZeXZNg1z+OfNsiDfmGbVuCr1
X-Gm-Gg: AfdE7clSip1A7DstGnBUn88l7D3H1hlucYuanqXqwahgC2I1JTG+g4EzCwxXJSGmTrG
	Cvpu+0RdiueuYjO28ysAb3jAK4BdXNdlAtyJaer4RYhEavmZ3/fh12oSpXI2nwtcNpQvX6YEF6f
	uJNvHwGHJhs8avcotoxz38VLaCArhtdVpzvQr3v8ceEBnPAca14XosNofxWFi/gw97d2uolkDf6
	gxF+KEiPPRnVYrozNLzL1Ea9UK66F+peFMdd8sfY0sCf0e/HDSySMV3Jyv8f7QFk+XaI7h5gAvd
	xc2xvcmTU1EQbTzSk2wxxSsqNgOCdfAoNWz3Cfqx1cSoJtXEU2n2HBy8jZdn/boXfoXtwYyZzcN
	wABlrOk+5C5p2N/9EkQfIjmbOM4OhCNkVQH1TpWFZDvKlvmqt84BLIZTBboCLhf0U7WhqX6QozJ
	MSTR6XcetxKM695b5AuwiczhcTAVwHvA==
X-Received: by 2002:a17:903:240b:b0:2c6:937a:249 with SMTP id d9443c01a7336-2c7c76d4a85mr14161265ad.29.1782190633329;
        Mon, 22 Jun 2026 21:57:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:57:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu
Subject: [PATCH v2 19/21] lib: rspdm: Support SPDM certificate validation
Date: Tue, 23 Jun 2026 14:54:04 +1000
Message-ID: <20260623045406.2589547-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

Support validating the SPDM certificate chain. This only performs basic
sanity checks on the chain before we continue on. This does not ensure
that the root CA is trusted, we leave that for userspace to check and
enforce. Instead we just make sure that the chain is correct, uses
supported signatures and that it isn't blacklisted in the kernel.

We then store the first leaf certificate for use later.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/lib.rs                |  12 +++
 lib/rspdm/state.rs              | 142 +++++++++++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/error.rs            |   1 +
 4 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 488203be821d..fa5513e8bd4e 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -129,6 +129,18 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.validate_cert_chain(slot) {
+            pr_err!("Certificate in slot {slot} failed to verify: {e:?}\n");
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 9138df30e138..e381cf3f75f9 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -109,7 +109,8 @@
 ///  H in SPDM specification.
 /// @certs: Certificate chain in each of the 8 slots. Empty KVec if a slot is
 ///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
-#[expect(dead_code)]
+/// @leaf_key: Public key portion of leaf certificate against which to check
+///  responder's signatures.
 pub(crate) struct SpdmState<'a> {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -138,10 +139,20 @@ pub(crate) struct SpdmState<'a> {
 
     // Certificates
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
+    pub(crate) leaf_key: Option<*mut bindings::public_key>,
 }
 
 impl Drop for SpdmState<'_> {
     fn drop(&mut self) {
+        if let Some(leaf_key) = self.leaf_key.take() {
+            // SAFETY: `leaf_key` was extracted from a x509 certificate
+            // in `validate_cert_chain()` so it is valid to pass to
+            // `public_key_free()`.
+            unsafe {
+                bindings::public_key_free(leaf_key);
+            }
+        }
+
         if let Some(desc) = self.desc.take() {
             // SAFETY: `self.shash` is a valid handle
             let desc_len = core::mem::size_of::<bindings::shash_desc>()
@@ -198,6 +209,7 @@ pub(crate) fn new(
             desc: None,
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -831,4 +843,132 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
+        let cert_chain_buf = &self.certs[slot as usize];
+        let cert_chain_len = cert_chain_buf.len();
+        // We skip over the RootHash
+        let header_len = 4 + self.hash_len;
+
+        let mut offset = header_len;
+        let mut prev_cert: Option<*mut bindings::x509_certificate> = None;
+
+        while offset < cert_chain_len {
+            // SAFETY: `cert_chain_buf[offset..]` is a non-empty slice of
+            // bytes valid for at least `cert_chain_len` bytes.
+            let cert_len = unsafe {
+                bindings::x509_get_certificate_length(
+                    &cert_chain_buf[offset..] as *const _ as *const u8,
+                    cert_chain_len - offset,
+                )
+            };
+
+            if cert_len < 0 {
+                pr_err!("Invalid certificate length\n");
+
+                if let Some(prev) = prev_cert {
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+                }
+
+                to_result(cert_len as i32)?;
+            }
+
+            // SAFETY: `cert_chain_buf[offset..]` is a non-empty slice of
+            // bytes valid for at least `cert_len` bytes.
+            let cert_ptr = unsafe {
+                match from_err_ptr(bindings::x509_cert_parse(
+                    &cert_chain_buf[offset..] as *const _ as *const c_void,
+                    cert_len as usize,
+                )) {
+                    Err(e) => {
+                        if let Some(prev) = prev_cert {
+                            // SAFETY: `prev_cert` is the previously parsed
+                            // certificate from a prior loop iteration.
+                            bindings::x509_free_certificate(prev);
+                        }
+                        return Err(e);
+                    }
+                    Ok(c) => c,
+                }
+            };
+            // SAFETY: Cast the `struct x509_certificate` to a Rust binding
+            let cert = unsafe { *cert_ptr };
+
+            if cert.unsupported_sig || cert.blacklisted {
+                pr_err!("Certificate was rejected\n");
+
+                if let Some(prev) = prev_cert {
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+                }
+                // SAFETY: `cert_ptr` was just returned by
+                // `x509_cert_parse()`.
+                unsafe { bindings::x509_free_certificate(cert_ptr) };
+
+                return Err(EKEYREJECTED);
+            }
+
+            if let Some(prev) = prev_cert {
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration.
+                let rc = unsafe { bindings::public_key_verify_signature((*prev).pub_, cert.sig) };
+
+                if rc < 0 {
+                    pr_err!("Signature validation error\n");
+
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+
+                    // SAFETY: `cert_ptr` was just returned by
+                    // `x509_cert_parse()`.
+                    unsafe { bindings::x509_free_certificate(cert_ptr) };
+
+                    to_result(rc)?;
+                }
+            }
+
+            if let Some(prev) = prev_cert {
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration.
+                unsafe { bindings::x509_free_certificate(prev) };
+            }
+
+            prev_cert = Some(cert_ptr);
+            offset += cert_len as usize;
+        }
+
+        if let Some(prev) = prev_cert {
+            if let Some(validate) = self.validate {
+                // SAFETY: Call the `validate` function provided.
+                let rc = unsafe { validate(self.dev, slot, prev) };
+                if let Err(e) = to_result(rc) {
+                    // SAFETY: `prev_cert` is the previously parsed
+                    // certificate from a prior loop iteration.
+                    unsafe { bindings::x509_free_certificate(prev) };
+                    return Err(e);
+                }
+            }
+
+            // The leaf key is the same for all slots, so just store the first one.
+            if self.leaf_key.is_none() {
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration.
+                self.leaf_key = unsafe { Some((*prev).pub_) };
+                // SAFETY: `prev_cert` is the previously parsed
+                // certificate from a prior loop iteration. We are setting
+                // the `pub` key to null so it isn't freed below
+                unsafe { (*prev).pub_ = core::ptr::null_mut() };
+            }
+
+            // SAFETY: `prev_cert` is the previously parsed
+            // certificate from a prior loop iteration.
+            unsafe { bindings::x509_free_certificate(prev) };
+        }
+
+        Ok(())
+    }
 }
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d63ad2b03362..e9736162c904 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -38,6 +38,8 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_ioctl.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/bitmap.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6413de18df80..10700a17eedc 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -95,6 +95,7 @@ macro_rules! declare_err {
     declare_err!(EINPROGRESS, "Operation now in progress.");
     declare_err!(EPROTO, "Protocol error");
     declare_err!(EPROTONOSUPPORT, "Protocol not supported");
+    declare_err!(EKEYREJECTED, "Key was rejected by service");
 }
 
 /// Generic integer kernel error.
-- 
2.54.0

