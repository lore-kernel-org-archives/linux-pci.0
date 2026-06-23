Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AF3A960E
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190617; cv=none; b=QKDWxSkwDq8IeAXNRzEt8mk3dgLweUVRk7GFlPZlMDtCyJIIjkRV1fDyyJuzvjhlpc4ZY83IZHZ3A5UghGSJx0LHDFebRozqizcSX4ku27TS+/tMnwIXOC+I56jhKv9EZOIVcWx+AME/Rlb0NMnPIXljlaiu/4XpBkzJSOJhWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190617; c=relaxed/simple;
	bh=/8AyZYI1padpIuCVfTLviH/wSYVxp4IDDFJCxQYE3Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBWA88YC9xx6jyD0jvSFQLz9pmW7whARnipdKUmDTGcLer4ivnMcAd3N/e2juWoSt03UHaesceyMT0W950LTSKKkc2CKgDIWoyzY6bbBDbrJggM6WX9pyItCzXCMMi6Aa6HNXRNK2IwoQz/fja1ugPSrBVYqiTPVwt+wUbCa8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8GIpJa4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8GIpJa4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c77d52bec4so3187765ad.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190615; x=1782795415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3/geuZ39tEW0rqigK2jT3/6auLK2rSxHMYe/Ce2+nk=;
        b=R8GIpJa4v+niCHpArZ9rvfgS2SreIsgh9TXSz6oEAdyA/jUUAtI0eXeC52zVhJxLJi
         rrnX0OJNV5LcxAaMUAk/MBEALjZkiGavaMfSxW4DQkRJVJQFe+BGONdY0tuxwa+qbxZc
         YpmlrXOOdhVvmkRVR4RvVNGXXRbbPCzHCxw6ScVKcgB8xBYixDJyM2czTXOz8h9iscVl
         mR4QHVrA2YSxfJ9jQkw1APsBvh063tFMisJVYw3UQifwxRSIgMed7tf3wTCR0AsNUx1V
         zMG6JVd5vq1hpYQtTCWboawjiS4ywnYOxk6uegB+xPZuGLCN3xs7FuG9eWfG04rKKMU6
         DalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190615; x=1782795415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3/geuZ39tEW0rqigK2jT3/6auLK2rSxHMYe/Ce2+nk=;
        b=nPtUWH7r/6Gt+cq/ow6uFCuUEGxMj84qtbVIOYUc9ilfpxom/QKKFGxkJYWGy+HZ9h
         RnnujNprjZ1OsBNhItqwGnCuC2Xrs86u/+q1j/X0XA1GuQNmWKEqXookqWQbwchRsr0N
         ob/dGSdittvgJdFIEGu6tEU6f+2mJWF35pjk1OULeVoWwPht7BZSNEEMuv9i1wgPhJGf
         ORt8TGClOQnUKkuaBlors+Fviaz2rWboNkRRtWyM3Mftfl37ppoa7RSfn+Ggi2q5/0FA
         sX2MQjOwmQGoG8yriv+YHVWtC4Og8ijKD6cbfWjxG8vcwK+btz+xk+Fh/r/55OnMF7K4
         CVcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTMk99wiq7SV1B/wRlwWCkCydZt9T6blXVcVCibEIbzSol8p0QtlUKuun7oi1nLNIjgzwsxfmNTv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdIiM3TuDHUGTfuSw+ngS8uVXsv/FEtE8cyGUS7Tx+MgPH3ol
	R8MjAr2KzWbtCcWVp2UnX1LyGB5OqH5ux4EP90a6z3HOf2g0WjzYVq0S23LfRw==
X-Gm-Gg: AfdE7clEGoMGzj+7wNQ0xLhWpyfIRddRBPk0oHg3DZXTF/TzYBSDti0Cf47rZJuWGZZ
	rtixmp/zbMuVC3aQrKUa9T1lV+gpsqpeUu+cahpM2P1gIK9UbrQeqyfZJh+HvvnXK2c8BBps3gU
	r9mMD7Axy2y2yd8rvozaD//Zi9j4HY1msBPB79+fVu3w6BTM/S+in6KtGeZUkzMOMvtBMERlPp1
	W9SwfuX2BxjXK/UmEUZoMnWh8p2gN3q7GoED9qGgpJ0lVpt5Zv/iKJ34SUHpwzpEolCAgHzc1BU
	SEXA2HSG9NARoMxDvTfHLfPRGB3GG4AzkXWxKYxOWvc+/MtLe/2ExSCiCLYGJmle9cUZAFy43oX
	G7Rb94G4uFT4bvZjlmZjaUd9pbMlsQ2EkR95sQyrh8vIRy0RGTuzaIUj2kem/oogy1V6t8amQbY
	LHc4cNwnKQxrOhZj9+0sbdmG32PUgskJwM5qcPGXg2
X-Received: by 2002:a17:903:38cc:b0:2bd:5ae4:26d1 with SMTP id d9443c01a7336-2c7c3ecdde9mr17016125ad.17.1782190615222;
        Mon, 22 Jun 2026 21:56:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:56:54 -0700 (PDT)
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
Subject: [PATCH v2 17/21] lib: rspdm: Support SPDM get_digests
Date: Tue, 23 Jun 2026 14:54:02 +1000
Message-ID: <20260623045406.2589547-18-alistair.francis@wdc.com>
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

Support the GET_DIGESTS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |  7 ++--
 lib/rspdm/lib.rs       |  4 +++
 lib/rspdm/state.rs     | 80 +++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 53 ++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index e222821bad5d..c4d9521866af 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -19,10 +19,11 @@
 pub(crate) const SPDM_VER_10: u8 = 0x10;
 pub(crate) const SPDM_VER_11: u8 = 0x11;
 pub(crate) const SPDM_VER_12: u8 = 0x12;
-#[allow(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
 pub(crate) const SPDM_VER_14: u8 = 0x14;
 
+pub(crate) const SPDM_SLOTS: usize = 8;
+
 pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
 pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_14;
 
@@ -106,7 +107,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
     mem::size_of::<GetVersionRsp>() + (u8::MAX as usize) * mem::size_of::<u16>();
 
 pub(crate) const SPDM_GET_CAPABILITIES: u8 = 0xe1;
-pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42;
+pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42; // SPDM 1.2.0 margin no 226
 
 // SPDM cryptographic timeout of this implementation:
 // Assume calculations may take up to 1 sec on a busy machine, which equals
@@ -143,6 +144,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_HASH_SHA_384: u32 = bit_u32(1);
 pub(crate) const SPDM_HASH_SHA_512: u32 = bit_u32(2);
 
+pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index d418d15e4c70..bda5f91ca13c 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -110,6 +110,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_digests() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index e4eb009a977c..055f37289c8b 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -44,13 +44,17 @@
     SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
+    SPDM_SLOTS,
     SPDM_VER_10,
     SPDM_VER_11,
-    SPDM_VER_12, //
+    SPDM_VER_12,
+    SPDM_VER_13, //
 };
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetDigestsReq,
+    GetDigestsRsp,
     GetVersionReq,
     GetVersionRsp,
     NegotiateAlgsReq,
@@ -86,6 +90,10 @@
 ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
 /// @meas_hash_alg: Hash algorithm for measurement blocks.
 ///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @supported_slots: Bitmask of responder's supported certificate slots.
+///  Received during GET_DIGESTS exchange (from SPDM 1.3).
+/// @provisioned_slots: Bitmask of responder's provisioned certificate slots.
+///  Received during GET_DIGESTS exchange.
 /// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
 ///  Passed to crypto subsystem when calling verify_signature().
 /// @sig_len: Signature length of @base_asym_alg (in bytes).
@@ -97,6 +105,8 @@
 /// @desc: Synchronous hash context for @base_hash_alg computation.
 /// @hash_len: Hash length of @base_hash_alg (in bytes).
 ///  H in SPDM specification.
+/// @certs: Certificate chain in each of the 8 slots. Empty KVec if a slot is
+///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
 #[expect(dead_code)]
 pub(crate) struct SpdmState<'a> {
     pub(crate) dev: *mut bindings::device,
@@ -111,6 +121,8 @@ pub(crate) struct SpdmState<'a> {
     pub(crate) base_asym_alg: u32,
     pub(crate) base_hash_alg: u32,
     pub(crate) meas_hash_alg: u32,
+    pub(crate) supported_slots: u8,
+    pub(crate) provisioned_slots: u8,
 
     /* Signature algorithm */
     base_asym_enc: &'a CStr,
@@ -121,6 +133,9 @@ pub(crate) struct SpdmState<'a> {
     pub(crate) shash: *mut bindings::crypto_shash,
     pub(crate) desc: Option<&'a mut bindings::shash_desc>,
     pub(crate) hash_len: usize,
+
+    // Certificates
+    pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
 }
 
 impl Drop for SpdmState<'_> {
@@ -161,12 +176,15 @@ pub(crate) fn new(
             base_asym_alg: 0,
             base_hash_alg: 0,
             meas_hash_alg: 0,
+            supported_slots: 0,
+            provisioned_slots: 0,
             base_asym_enc: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
             sig_len: 0,
             base_hash_alg_name: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
             shash: core::ptr::null_mut(),
             desc: None,
             hash_len: 0,
+            certs: [const { KVec::new() }; SPDM_SLOTS],
         }
     }
 
@@ -608,4 +626,64 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
+        let mut request = GetDigestsReq::default();
+        request.version = self.version;
+
+        let req_sz = core::mem::size_of::<GetDigestsReq>();
+        let rsp_sz = core::mem::size_of::<GetDigestsRsp>() + SPDM_SLOTS * self.hash_len;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let len = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if len > response_vec.len() {
+            pr_err!("Overflowed digests response\n");
+            return Err(EIO);
+        }
+        response_vec.truncate(len);
+
+        let response: &GetDigestsRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+
+        if len
+            < core::mem::size_of::<GetDigestsRsp>()
+                + response.param2.count_ones() as usize * self.hash_len
+        {
+            pr_err!("Overflowed digests response\n");
+            return Err(EIO);
+        }
+
+        let mut deprovisioned_slots = self.provisioned_slots & !response.param2;
+        while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
+            let slot = deprovisioned_slots.trailing_zeros() as usize;
+            self.certs[slot].clear();
+            deprovisioned_slots &= !(1 << slot);
+        }
+
+        if self.version >= SPDM_VER_13 && (response.param2 & !response.param1 != 0) {
+            pr_err!("Malformed digests response\n");
+            return Err(EPROTO);
+        }
+
+        self.provisioned_slots = response.param2;
+        if self.provisioned_slots == 0 {
+            pr_err!("No certificates provisioned\n");
+            return Err(EPROTO);
+        }
+
+        let supported_slots = if self.version >= SPDM_VER_13 {
+            response.param1
+        } else {
+            0xFF
+        };
+
+        self.supported_slots = supported_slots;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index c53828376fca..b3d5cab6a9ce 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -30,6 +30,7 @@
     SPDM_ASYM_ALGOS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
     SPDM_MEAS_SPEC_DMTF,
@@ -373,3 +374,55 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetDigestsReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl Default for GetDigestsReq {
+    fn default() -> Self {
+        GetDigestsReq {
+            version: 0,
+            code: SPDM_GET_DIGESTS,
+            param1: 0,
+            param2: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetDigestsRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) digests: __IncompleteArrayField<u8>,
+    // KeyPairIDs, added in 1.3
+
+    // CertificateInfo, added in 1.3
+
+    // KeyUsageMask, added in 1.3
+}
+
+impl Validate<Untrusted<&[u8]>> for &GetDigestsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<GetDigestsRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `GetDigestsRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetDigestsRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &GetDigestsRsp = unsafe { &*ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.54.0

