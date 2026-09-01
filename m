Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D03ABD8D
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224808; cv=none; b=ZPixx6vVxCmanoZnpZrDJB5RF766xbCpoqcb2xRk0rE7KuKj5n5+b7onyqfl3UJM7Mv7Viy2raz1MxRCyr4LU/pp3TryaK+tpjBVBiEo4WmNzrkyZlL6QAtV+Smssd5LRWCPeZ+4SamSUuK4/b19jjcQwMEvhFtD8hnbxEUcysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224808; c=relaxed/simple;
	bh=J2T7JILoVByS1MCnyW03kxxqDPc+zD1Y62mEstcjhGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1p6bVmn900q4Re/K80+OCjvz/ES40GXplIF+8mez0CUoq3uIVWc4BspalGrqHZ83apzjtiww9OWm6bXnlUi45IYUvyRC4bxjioXIvieFwbdtqyHji6ULuezwB0cUhGgVrr08ROw9OQcknlViQ8EjL487Ag0k1/HdZnb6faf278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKD2k6AN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKD2k6AN"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4101222a91.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224805; x=1788829605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6+g1amS8TRdiwzXTKVJFNhTGQRsJ1L567PEixpjliHU=;
        b=AKD2k6ANVeCaqQk72UsRW/MXsWjkC9sv3DG5oxLDONtGMacee/UJHIQ7666bdKDVB/
         yot9DhVmSutCQlxYl/cq3hmQ+gZ93xfjsC7dnejV2Vu1cE1s2uRFkuyni6Obum5BGfRt
         M4yNCzwvkUCAqnggj2VGgd+4+HcbTCRPRw9uYvFIXQwoZFOf0pKvoCU480RAV8n599FK
         5CCy/TrNO5g6OKK6haz6RfKgjGzsoW0BCmx/FAB0wbGZL5iSxaRwDxXHFwaXuvnWNBU4
         cOLs2rwmOenWUyMxlZNkdC2CKXHurNZw05s2ENmGPvZJZahqsSOTzSpcxftRZSph/PG3
         /0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224805; x=1788829605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+g1amS8TRdiwzXTKVJFNhTGQRsJ1L567PEixpjliHU=;
        b=VTpG2v2RqIHG+IZ2LaIk14+jLr9Hfa8ZWKaZjocVxUCp1A98uFYqfetrK+tAIZPY1A
         rGt3UM6cDcaEmBvVyPot77ZDW/qRlxreYfW7ONfn7vHku/17sVpNV34y23F4DX+dUFGd
         ljVEdUZ7qyAMMbb1hnlb0u41D8xoi3qhMAhrKcPp+705jhH4V7VPEeFXCCAJFdm6DbqG
         gPlOPWqvZ48OXWzORhMzLMguSOM+wVBvPpHUrpc+6MRMvaUJVqMDdc0J8TACA78GVUlZ
         ntJ58AsZmgvCCGB6m49/1JmUV+Lro8nsh0djo/vIURflRtNiZ8VJ8DPEOGxTPH+gurnE
         JrsQ==
X-Gm-Message-State: AFuF++lcCiuw7L04xNiY4G4E0NMmwsf4ephoLHYobvD3TumWzPAKRd1b
	XMcQbEVW3lghc/zMdQMP3PkYhONQKRZ2JrXb3Sb5Y+bxzxsdixtCiKUBvff29w==
X-Gm-Gg: AYBFou2HOhtY5EG4OMxvji9GLSvip6wumJOuq41EaG16z50pCyxhZH19rcS/hSAAzLQ
	CFOyVbwSVyrGB8JJL0UPssJkyFGQtyjHQSCBST2ADt7K2jQDOxCacxR26AZrxBLa+CmAAJ70UR+
	BJUkcC9DsMOWmTFt1shlz15fFV3Wy9nZgJZYJ78pszulgM97NaVBGJ35cVVOL7UF3GWSbnJ6Yd+
	R0u/z7r3eeSwMX4trghwK35tNGKBJHdmk2Es/0n3lFPX41tM3UNUaU5jnT8DPcuJT8NIz+QQ7Wk
	2p7o03SLel0ozpiHoJRyjD5G+POu95cEYcwfnBNgeWssOmJzf1wUXOvylgvXHP6wlPkAkVO472+
	gcAy55dVh4FYv7WT7ttB8eHIyt1utw362qmxvepJw6W/pF6deMkYjyZplnh29BIw0xzvB1EX3Ke
	cboWeJ2YhT5ZnGS9Vd6SUS//cRZb6mdI7lZ+XKxbD5GJT67QOPIgY6Qq5HPipz/MFXF8Fml1K5U
	xn57A==
X-Received: by 2002:a17:90b:5544:b0:398:bd37:6a49 with SMTP id 98e67ed59e1d1-398bd376c65mr24254913a91.12.1788224805187;
        Mon, 31 Aug 2026 18:06:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:06:44 -0700 (PDT)
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
Subject: [PATCH v3 19/21] lib: rspdm: Support SPDM certificate validation
Date: Tue,  1 Sep 2026 11:03:45 +1000
Message-ID: <20260901010347.2614656-20-alistair.francis@wdc.com>
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

Support validating the SPDM certificate chain. This only performs basic
sanity checks on the chain before we continue on. This does not ensure
that the root CA is trusted, we leave that for userspace to check and
enforce. Instead we just make sure that the chain is correct, uses
supported signatures and that it isn't blacklisted in the kernel.

We then store the first leaf certificate for use later.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/lib.rs                |  12 +++
 lib/rspdm/state.rs              | 146 +++++++++++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |   2 +
 3 files changed, 159 insertions(+), 1 deletion(-)

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
index 1e8a4402e634..fc7df9dd7b97 100644
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
@@ -200,6 +211,7 @@ pub(crate) fn new(
             desc: None,
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -846,4 +858,136 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
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
+        if offset >= cert_chain_len {
+            return Err(EPROTO);
+        }
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
index d2781c27794b..5cc71552b524 100644
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
-- 
2.55.0

