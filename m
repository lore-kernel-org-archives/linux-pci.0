Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E8346FA2
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780688; cv=none; b=rf4t6Pc7x0r9KS5+WvmZ9S7VApxeaNA4fmka8bvOcUuYWZtTvGwFn/rNeFnCI77SpoVP+YE7id/21x833mfgq8w2A0TKQzEYOm1puUQ1x57XbufTeFxC8c3+SIHB8UNWL21/qHifiqIBisLpiR803OaG9I//B7xtkYhpBmD2VY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780688; c=relaxed/simple;
	bh=F0QPRi4Cr/kqrQqoZ0RP0Sczcg8ZftafBi6pfegt1k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nrm2YqLLBVPkjmjbFlOkQx9sI62E9iTeeMR9vAMhwa6cVZ96csuNbvznATMwM7ziClPKAzBQYed9IaG/nuDoomEj1dfUWdxLseSR0hqfCKT9irOnTHq+Yxcv7nSbrZ7dpxLwbaClXoOlV3u2h9jhWcQZuUPfu7ApmlTY+uuSA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncGWTr9/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncGWTr9/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c62239decbeso1788007a12.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780686; x=1771385486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq+I562YFt2ssteRsuZO53DNGRtLr+SzLx+58OWHihw=;
        b=ncGWTr9/g4DW3/ZN6SPEK/CjpSH21NoRAGaDWjucUPfb8xmgJIs8nkuVkYYCoKX5dD
         BbKzwicB/tzXiNNCyRG5Z3gPNzTp1XDGtFlMF+qcgNgmjhjKI9/ahe39o/knRd7CYb9f
         fULFsfkWl+5TaRl0ONmSi87tMo8aAhYuF/LJdsB7lZ6H8nszcX/iZBsgafEW+f+CO3Dh
         6xMUCRI0SWJQu4RIGlCFBJipeZAMlMI66PxWPKYZE5r/JLcQuNQS+RKAzGbH4DTeFUl4
         d05d6JN5LZf5K1JJxS0RprDM/m0bvrAcCNl2NYS+IT7G7e2LuTq5cytcFTdj9YeUfE0B
         wr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780686; x=1771385486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rq+I562YFt2ssteRsuZO53DNGRtLr+SzLx+58OWHihw=;
        b=CeG4iiJrMP//0w4vMqUkSgAk0pmUJlQMa+ia94fSO0mJcxcVkZTYp4VdXbzrHt+QXW
         Xalc/FQd2kcF1/NapeWIhD+ZRnkE+aX3yF/wPUOw6zEhsegCiwNQ2ve7qVExopRh/CQc
         FwBj0aIQqCCs0wCYiwDIN7JPNKCfAjx8+QA6ca4dlWIjhUI6WfQCkofyEf820zOe9Mok
         PXcJ2ki6MAllRlrqj0BV/GFuPQoeB0FSPl/lzCSJjkX2wUJUzVNnfRS6Y6ZWqlB42vgK
         TchBN2xroe893zS9jhpPxRBKY/Nc+86LOplDFdn9ir6PLIiMCkEM7Mj/b0XrHWlsIuWa
         ddtw==
X-Forwarded-Encrypted: i=1; AJvYcCWU3MczsTJupRkCT56XoD3pq8ChuXV8jFq6PCmpji9BDRHcLAwISV2cXQEIouW6YrvaAiYjDmY+Nlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypFs+UjVs36NNwIfkbocPWQ2xoKaeUhsVeBV3syLEciNCP6NAa
	ceq1ZZrvv2YzAyhT9Bp6NXeH4fYIefpab/UtEP+GOKR6JPjP4w6kqCE5
X-Gm-Gg: AZuq6aKRUmj16GAiYzRdVUveZOwtIT0aUoNXigu0+I9gLInlPFyR1RcYW9lFLy2F8Et
	3cBnshfSCbMDrvZNsc6E1IX9sNS4MazznNqA5MDmNx+6VZaAaVCBii3nwLWjdEUejJeARrQBSrW
	zoK5fwGbO95ongeDw1KCiPJm0ILZ3Paw3BxnQ3vMxPvwhCDtAmlgdjHUzmxJgX1B/MozNGw0Y91
	9Hl1jgrm5lCSe2Z2K9yaHkYVx6zx0QfTk7UL1K7FZm1vltXebJ+5XEGLd5sYGsuSRsAuJhDglmy
	o9eRTWH+Bu68O+NrCwnAz8ocLQCoeSXGqnJq/qIzDhjSRNPgaytM6x/gi3CATh7nfWzAmAXKjT1
	GwvRkozKXQ+JvbPChgqTHGBi4mwDjzlVpNQcPH8zOzJmGHTTw1ZgwsayyzFYT5zVJzcS0zt/AVo
	sObuFGwFZVhnlInwAKjKJ/qd5BQWCp3+AJ2cPPDO6X7w==
X-Received: by 2002:a05:6a20:258d:b0:35f:b96d:af11 with SMTP id adf61e73a8af0-3942e384f48mr1325597637.5.1770780685920;
        Tue, 10 Feb 2026 19:31:25 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:31:25 -0800 (PST)
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
Subject: [RFC v3 14/27] lib: rspdm: Support SPDM negotiate_algorithms
Date: Wed, 11 Feb 2026 13:29:21 +1000
Message-ID: <20260211032935.2705841-15-alistair.francis@wdc.com>
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

Support the NEGOTIATE_ALGORITHMS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |  53 ++++++++++
 lib/rspdm/lib.rs       |  16 ++-
 lib/rspdm/state.rs     | 214 ++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 115 +++++++++++++++++++++-
 4 files changed, 391 insertions(+), 7 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index a6a66e2af1b5..e8a05fd4299b 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -143,6 +143,59 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_CERT_CAP: u32 = 1 << 1;
 pub(crate) const SPDM_CHAL_CAP: u32 = 1 << 2;
+pub(crate) const SPDM_MEAS_CAP_MASK: u32 = 3 << 3;
+pub(crate) const SPDM_KEY_EX_CAP: u32 = 1 << 9;
 
 pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
 pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+
+pub(crate) const SPDM_NEGOTIATE_ALGS: u8 = 0xe3;
+
+pub(crate) const SPDM_MEAS_SPEC_DMTF: u8 = 1 << 0;
+
+pub(crate) const SPDM_ASYM_RSASSA_2048: u32 = 1 << 0;
+pub(crate) const _SPDM_ASYM_RSAPSS_2048: u32 = 1 << 1;
+pub(crate) const SPDM_ASYM_RSASSA_3072: u32 = 1 << 2;
+pub(crate) const _SPDM_ASYM_RSAPSS_3072: u32 = 1 << 3;
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P256: u32 = 1 << 4;
+pub(crate) const SPDM_ASYM_RSASSA_4096: u32 = 1 << 5;
+pub(crate) const _SPDM_ASYM_RSAPSS_4096: u32 = 1 << 6;
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P384: u32 = 1 << 7;
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P521: u32 = 1 << 8;
+pub(crate) const _SPDM_ASYM_SM2_ECC_SM2_P256: u32 = 1 << 9;
+pub(crate) const _SPDM_ASYM_EDDSA_ED25519: u32 = 1 << 10;
+pub(crate) const _SPDM_ASYM_EDDSA_ED448: u32 = 1 << 11;
+
+pub(crate) const SPDM_HASH_SHA_256: u32 = 1 << 0;
+pub(crate) const SPDM_HASH_SHA_384: u32 = 1 << 1;
+pub(crate) const SPDM_HASH_SHA_512: u32 = 1 << 2;
+
+#[cfg(CONFIG_CRYPTO_RSA)]
+pub(crate) const SPDM_ASYM_RSA: u32 =
+    SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
+#[cfg(not(CONFIG_CRYPTO_RSA))]
+pub(crate) const SPDM_ASYM_RSA: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_ECDSA)]
+pub(crate) const SPDM_ASYM_ECDSA: u32 =
+    SPDM_ASYM_ECDSA_ECC_NIST_P256 | SPDM_ASYM_ECDSA_ECC_NIST_P384 | SPDM_ASYM_ECDSA_ECC_NIST_P521;
+#[cfg(not(CONFIG_CRYPTO_ECDSA))]
+pub(crate) const SPDM_ASYM_ECDSA: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_SHA256)]
+pub(crate) const SPDM_HASH_SHA2_256: u32 = SPDM_HASH_SHA_256;
+#[cfg(not(CONFIG_CRYPTO_SHA256))]
+pub(crate) const SPDM_HASH_SHA2_256: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_SHA512)]
+pub(crate) const SPDM_HASH_SHA2_384_512: u32 = SPDM_HASH_SHA_384 | SPDM_HASH_SHA_512;
+#[cfg(not(CONFIG_CRYPTO_SHA512))]
+pub(crate) const SPDM_HASH_SHA2_384_512: u32 = 0;
+
+pub(crate) const SPDM_ASYM_ALGOS: u32 = SPDM_ASYM_RSA | SPDM_ASYM_ECDSA;
+pub(crate) const SPDM_HASH_ALGOS: u32 = SPDM_HASH_SHA2_256 | SPDM_HASH_SHA2_384_512;
+
+/* Maximum number of ReqAlgStructs sent by this implementation */
+// pub(crate) const SPDM_MAX_REQ_ALG_STRUCT: usize = 4;
+
+pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = 1 << 1;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 5f6653ada59d..33f706a55e09 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -117,6 +117,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
@@ -124,4 +128,14 @@
 ///
 /// @spdm_state: SPDM session state
 #[no_mangle]
-pub unsafe extern "C" fn spdm_destroy(_state: &'static mut SpdmState) {}
+pub unsafe extern "C" fn spdm_destroy(state: &'static mut SpdmState) {
+    if let Some(desc) = &mut state.desc {
+        unsafe {
+            bindings::kfree(*desc as *mut _ as *mut c_void);
+        }
+    }
+
+    unsafe {
+        bindings::crypto_free_shash(state.shash);
+    }
+}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 0efad7f341cd..d0b10f27cd9c 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -12,16 +12,22 @@
 use kernel::prelude::*;
 use kernel::{
     bindings,
-    error::{code::EINVAL, to_result, Error},
+    error::{code::EINVAL, from_err_ptr, to_result, Error},
+    str::CStr,
     validate::Untrusted,
 };
 
 use crate::consts::{
-    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_DATA_TRANSFER_SIZE,
-    SPDM_MIN_VER, SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
+    SpdmErrorCode, SPDM_ASYM_ALGOS, SPDM_ASYM_ECDSA_ECC_NIST_P256, SPDM_ASYM_ECDSA_ECC_NIST_P384,
+    SPDM_ASYM_ECDSA_ECC_NIST_P521, SPDM_ASYM_RSASSA_2048, SPDM_ASYM_RSASSA_3072,
+    SPDM_ASYM_RSASSA_4096, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_HASH_ALGOS, SPDM_HASH_SHA_256,
+    SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK,
+    SPDM_MEAS_SPEC_DMTF, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader,
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq,
+    NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
 };
 
 /// The current SPDM session state for a device. Based on the
@@ -40,6 +46,28 @@
 ///  Negotiated during GET_VERSION exchange.
 /// @rsp_caps: Cached capabilities of responder.
 ///  Received during GET_CAPABILITIES exchange.
+/// @base_asym_alg: Asymmetric key algorithm for signature verification of
+///  CHALLENGE_AUTH and MEASUREMENTS messages.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @base_hash_alg: Hash algorithm for signature verification of
+///  CHALLENGE_AUTH and MEASUREMENTS messages.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @meas_hash_alg: Hash algorithm for measurement blocks.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
+///  Passed to crypto subsystem when calling verify_signature().
+/// @sig_len: Signature length of @base_asym_alg (in bytes).
+///  S or SigLen in SPDM specification.
+/// @base_hash_alg_name: Human-readable name of @base_hash_alg.
+///  Passed to crypto subsystem when calling crypto_alloc_shash() and
+///  verify_signature().
+/// @base_hash_alg_name: Human-readable name of @base_hash_alg.
+///  Passed to crypto subsystem when calling crypto_alloc_shash() and
+///  verify_signature().
+/// @shash: Synchronous hash handle for @base_hash_alg computation.
+/// @desc: Synchronous hash context for @base_hash_alg computation.
+/// @hash_len: Hash length of @base_hash_alg (in bytes).
+///  H in SPDM specification.
 #[expect(dead_code)]
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
@@ -52,6 +80,19 @@ pub struct SpdmState {
     // Negotiated state
     pub(crate) version: u8,
     pub(crate) rsp_caps: u32,
+    pub(crate) base_asym_alg: u32,
+    pub(crate) base_hash_alg: u32,
+    pub(crate) meas_hash_alg: u32,
+
+    /* Signature algorithm */
+    base_asym_enc: &'static CStr,
+    sig_len: usize,
+
+    /* Hash algorithm */
+    base_hash_alg_name: &'static CStr,
+    pub(crate) shash: *mut bindings::crypto_shash,
+    pub(crate) desc: Option<&'static mut bindings::shash_desc>,
+    pub(crate) hash_len: usize,
 }
 
 impl SpdmState {
@@ -72,6 +113,15 @@ pub(crate) fn new(
             validate,
             version: SPDM_MIN_VER,
             rsp_caps: 0,
+            base_asym_alg: 0,
+            base_hash_alg: 0,
+            meas_hash_alg: 0,
+            base_asym_enc: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
+            sig_len: 0,
+            base_hash_alg_name: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
+            shash: core::ptr::null_mut(),
+            desc: None,
+            hash_len: 0,
         }
     }
 
@@ -333,4 +383,160 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn update_response_algs(&mut self) -> Result<(), Error> {
+        match self.base_asym_alg {
+            SPDM_ASYM_RSASSA_2048 => {
+                self.sig_len = 256;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_RSASSA_3072 => {
+                self.sig_len = 384;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_RSASSA_4096 => {
+                self.sig_len = 512;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P256 => {
+                self.sig_len = 64;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P384 => {
+                self.sig_len = 96;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P521 => {
+                self.sig_len = 132;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            _ => {
+                pr_err!("Unknown asym algorithm\n");
+                return Err(EINVAL);
+            }
+        }
+
+        match self.base_hash_alg {
+            SPDM_HASH_SHA_256 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha256\0")?;
+            }
+            SPDM_HASH_SHA_384 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha384\0")?;
+            }
+            SPDM_HASH_SHA_512 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha512\0")?;
+            }
+            _ => {
+                pr_err!("Unknown hash algorithm\n");
+                return Err(EINVAL);
+            }
+        }
+
+        /*
+         * shash and desc allocations are reused for subsequent measurement
+         * retrieval, hence are not freed until spdm_reset().
+         */
+        self.shash =
+            unsafe { bindings::crypto_alloc_shash(self.base_hash_alg_name.as_char_ptr(), 0, 0) };
+        from_err_ptr(self.shash)?;
+
+        let desc_len = core::mem::size_of::<bindings::shash_desc>()
+            + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
+
+        let mut desc_vec: KVec<u8> = KVec::with_capacity(desc_len, GFP_KERNEL)?;
+        // SAFETY: `desc_vec` is `desc_len` long
+        let desc_buf = unsafe { from_raw_parts_mut(desc_vec.as_mut_ptr(), desc_len) };
+
+        let desc = unsafe {
+            core::mem::transmute::<*mut c_void, &mut bindings::shash_desc>(
+                desc_buf.as_mut_ptr() as *mut c_void
+            )
+        };
+        desc.tfm = self.shash;
+
+        self.desc = Some(desc);
+
+        /* Used frequently to compute offsets, so cache H */
+        self.hash_len = unsafe { bindings::crypto_shash_digestsize(self.shash) as usize };
+
+        if let Some(desc) = &mut self.desc {
+            unsafe { to_result(bindings::crypto_shash_init(*desc)) }
+        } else {
+            Err(ENOMEM)
+        }
+    }
+
+    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
+        let mut request = NegotiateAlgsReq::default();
+        request.version = self.version;
+
+        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
+            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
+        }
+
+        // TODO support more algs
+        let reg_alg_entries = 0;
+
+        let req_sz = core::mem::size_of::<NegotiateAlgsReq>()
+            + core::mem::size_of::<RegAlg>() * reg_alg_entries;
+        let rsp_sz = core::mem::size_of::<NegotiateAlgsRsp>()
+            + core::mem::size_of::<RegAlg>() * reg_alg_entries;
+
+        request.length = req_sz as u16;
+        request.param1 = reg_alg_entries as u8;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (rsp_sz as i32) {
+            pr_err!("Truncated capabilities response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut NegotiateAlgsRsp =
+            Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        self.base_asym_alg = response.base_asym_sel;
+        self.base_hash_alg = response.base_hash_sel;
+        self.meas_hash_alg = response.measurement_hash_algo;
+
+        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
+            pr_err!("No common supported algorithms\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+        if self.base_asym_alg.count_ones() != 1
+            || self.base_hash_alg.count_ones() != 1
+            || response.ext_asym_sel_count != 0
+            || response.ext_hash_sel_count != 0
+            || response.param1 > request.param1
+            || response.other_params_sel != request.other_params_support
+        {
+            pr_err!("Malformed algorithms response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        if self.rsp_caps & SPDM_MEAS_CAP_MASK == SPDM_MEAS_CAP_MASK
+            && (self.meas_hash_alg.count_ones() != 1
+                || response.measurement_specification_sel != SPDM_MEAS_SPEC_DMTF)
+        {
+            pr_err!("Malformed algorithms response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        self.update_response_algs()?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index cd792c46767a..036a077c71c3 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -7,7 +7,7 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
-use crate::bindings::{__IncompleteArrayField, __le16};
+use crate::bindings::{__IncompleteArrayField, __le16, __le32};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -16,7 +16,10 @@
     validate::{Unvalidated, Validate},
 };
 
-use crate::consts::{SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_REQ_CAPS};
+use crate::consts::{
+    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_HASH_ALGOS,
+    SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
+};
 
 #[repr(C, packed)]
 pub(crate) struct SpdmHeader {
@@ -205,3 +208,111 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct RegAlg {
+    pub(crate) alg_type: u8,
+    pub(crate) alg_count: u8,
+    pub(crate) alg_supported: u16,
+    pub(crate) alg_external: __IncompleteArrayField<__le32>,
+}
+
+#[repr(C, packed)]
+pub(crate) struct NegotiateAlgsReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification: u8,
+    pub(crate) other_params_support: u8,
+
+    pub(crate) base_asym_algo: u32,
+    pub(crate) base_hash_algo: u32,
+
+    reserved1: [u8; 12],
+
+    pub(crate) ext_asym_count: u8,
+    pub(crate) ext_hash_count: u8,
+    reserved2: u8,
+    pub(crate) mel_specification: u8,
+
+    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
+    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
+    pub(crate) req_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl Default for NegotiateAlgsReq {
+    fn default() -> Self {
+        NegotiateAlgsReq {
+            version: 0,
+            code: SPDM_NEGOTIATE_ALGS,
+            param1: 0,
+            param2: 0,
+            length: 0,
+            measurement_specification: SPDM_MEAS_SPEC_DMTF,
+            other_params_support: 0,
+            base_asym_algo: SPDM_ASYM_ALGOS.to_le(),
+            base_hash_algo: SPDM_HASH_ALGOS.to_le(),
+            reserved1: [0u8; 12],
+            ext_asym_count: 0,
+            ext_hash_count: 0,
+            reserved2: 0,
+            mel_specification: 0,
+            ext_asym: __IncompleteArrayField::new(),
+            ext_hash: __IncompleteArrayField::new(),
+            req_alg_struct: __IncompleteArrayField::new(),
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct NegotiateAlgsRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification_sel: u8,
+    pub(crate) other_params_sel: u8,
+
+    pub(crate) measurement_hash_algo: u32,
+    pub(crate) base_asym_sel: u32,
+    pub(crate) base_hash_sel: u32,
+
+    reserved1: [u8; 11],
+
+    pub(crate) mel_specification_sel: u8,
+    pub(crate) ext_asym_sel_count: u8,
+    pub(crate) ext_hash_sel_count: u8,
+    reserved2: [u8; 2],
+
+    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
+    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
+    pub(crate) req_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut NegotiateAlgsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<NegotiateAlgsRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `NegotiateAlgsRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<NegotiateAlgsRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut NegotiateAlgsRsp = unsafe { &mut *ptr };
+
+        rsp.base_asym_sel = rsp.base_asym_sel.to_le();
+        rsp.base_hash_sel = rsp.base_hash_sel.to_le();
+        rsp.measurement_hash_algo = rsp.measurement_hash_algo.to_le();
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

