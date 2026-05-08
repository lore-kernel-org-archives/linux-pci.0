Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A36313E07
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210355; cv=none; b=PtVD0tStr+A5CdsHt2dtkQLDAJjs28UqKCY1khyQbHW8hEjmyL5Hr8vCXFNE0qpjFpGramWwxlw9rGJMZ9H8vFDOcbeWHFLwkWhOzUCF5x/MPw0hiISu9NkeRv+edKNPaXVaevfYTdREqKgItpGAVXjKKP3k2uWbvwC7LB4vWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210355; c=relaxed/simple;
	bh=T0+ZvWaKl6aU1RnDTQJKVo5xqdWjeysfv86NbgJZTQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmJKOyDWtTQzq7Yq7tDvaurFfgN4yXFRIKzptHnKL7sBv6VJLMmKBX3owsG7S07yoJD427K89cj+Og64r2Sv/37n0qwmc7+HwXcsQemWQiXHesKJKNibHmEvFqTyp2Mtio6mnAhDdHgnMUGCYokxUPTengYCqR5bfG92W8m3dE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCXaTQ7o; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCXaTQ7o"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-364c5317d67so1618237a91.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210349; x=1778815149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZVy9zCp2FVtT/BdK26xWCodS3E+jo75mkR1y+4KXx8=;
        b=aCXaTQ7o+PznnzUrtURa26K5jIefT04nUXVWmmxICywIpG2qkIVTyRAfu7HYSFyb4/
         5fWzfBy6YInOD4XOy/d4OsPZrlz772mSpEi0vDQdsr6vC+aMRBjhjr72/GcQoOh54cOo
         4Cg5TbjUix6JUC7zMmtgdz6mq2SRqV5kGNaZYcw+FDdeGvHaRVsv5EkDbF6e7bYHxDK6
         fm0BIiEWAHxiDCJVnKsJdYAogSVGc2O4dj6sj3K4H3+d205a9i7nDmDgRUxTkj11Wy0B
         IyA1JR5hty/EKgQJlBzR7IDRKzsOzIbDqp2cMe6M1Dz3IqXqIRE1e/8WpWAm2lSdKf9f
         A5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210349; x=1778815149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ZVy9zCp2FVtT/BdK26xWCodS3E+jo75mkR1y+4KXx8=;
        b=aHnPIGYCAz4VRaRaRjoiKu65C6n0nDeYPtz9lkhNP1+W6XRhYlZ56h1QwQ57mQbkBD
         +VIn5Nu0plCoYandapbQUJtv/YHJSq8p+HvaP7kJ07DU4Xjswy9uS65wxO0j3gGU5etb
         cFe2dhIzI6ck0Uo3cn8dg4SgZjrSxY0k6uhPJxkzrQ9bmd6ZBf9T06gw6OocA4rwNG9l
         D8p7pAL1WYuSdnp5IiYX90j5d0t6O5iRyPFgokAL8dNGgy0UligCqpUv1BxgzIldueTU
         WDdX4jhCDvg/Ec4RwScWj255fqu2pO45BFZD/l/vT4BWn/mAUJEXdQfx1Q22Dw1YvO5S
         32kA==
X-Forwarded-Encrypted: i=1; AFNElJ83cI5QX9st0niZWObzQKCeRdeR9sra8A3R+IIUB7ooLppdCUa/G03OWS0JA+OaYOaOslm91luBgnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLpUXJ7jN0fNcydnvaewO9k3z+a1xm/egWr2kRFb9cEr3dZ9W
	Xc8D1hT72NelIX9sfMrFzqi4FtLp0eKQPfUcn/urceam3x5utOYX6Shnh7neug==
X-Gm-Gg: Acq92OEH83w7DuS/k5S5Xe+pMdkEEy6810bKcuygvsIEfcgZ77fRfjOAv4xcOhIqbiL
	fp1D+xeDlyufuSP+C6mLKD7VUnI2Lr4f0bS8mI8A1M3Zcugt4eink50SjFva56+NZj1gK33bQ5C
	YMLTPYIuSY4sWrMencmSSoaqs77bvqll37NefEvzGQ0lliFd2vlMTXtmmROlnESZ4WEICxRS7sR
	ICki2zWGnMT7mHIMBg5D2ohomQU8LOIA8N6xpCwy+jvAWDIoMlkus4hH7eJClPO0KYA6fB6bxcu
	WeNERlUHjK5KwsgUvSanoKVeeNZvSwP51sy5PvuvlG7t7WoqiaZz376omPb2+XZIUGMuUPs40F0
	lzt+nA88h9lz5dpDyUvvcE07BILNE6rSUwOaHADr2Ghw8mnjrbVRVKTap/9Hp8KM21BiaG3dkbr
	NjeMiMTUKV5GhSsLh7hnPIL213nRfzFUBHSpMPwmwP
X-Received: by 2002:a17:903:1450:b0:2b4:5cd0:b6c3 with SMTP id d9443c01a7336-2ba79be16c0mr123514345ad.29.1778210349207;
        Thu, 07 May 2026 20:19:09 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:19:08 -0700 (PDT)
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
Subject: [PATCH 14/18] lib: rspdm: Support SPDM get_digests
Date: Fri,  8 May 2026 13:17:06 +1000
Message-ID: <20260508031710.514574-15-alistair.francis@wdc.com>
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

Support the GET_DIGESTS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |  7 +++-
 lib/rspdm/lib.rs       |  4 ++
 lib/rspdm/state.rs     | 85 +++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 54 +++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index e4652b18eb2a..092205dab74d 100644
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
 
@@ -73,7 +74,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + u8::MAX as usize;
 
 pub(crate) const SPDM_GET_CAPABILITIES: u8 = 0xe1;
-pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42;
+pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42; // SPDM 1.2.0 margin no 226
 
 // SPDM cryptographic timeout of this implementation:
 // Assume calculations may take up to 1 sec on a busy machine, which equals
@@ -111,6 +112,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_HASH_SHA_384: u32 = bit_u32(1);
 pub(crate) const SPDM_HASH_SHA_512: u32 = bit_u32(2);
 
+pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 72886a5dfd69..e42cfdd35524 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -120,6 +120,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_digests() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 34676744e509..bcb1cc955c4c 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -46,13 +46,17 @@
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
@@ -83,6 +87,10 @@
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
@@ -94,6 +102,8 @@
 /// @desc: Synchronous hash context for @base_hash_alg computation.
 /// @hash_len: Hash length of @base_hash_alg (in bytes).
 ///  H in SPDM specification.
+/// @certs: Certificate chain in each of the 8 slots. Empty KVec if a slot is
+///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
 #[expect(dead_code)]
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
@@ -108,6 +118,8 @@ pub struct SpdmState {
     pub(crate) base_asym_alg: u32,
     pub(crate) base_hash_alg: u32,
     pub(crate) meas_hash_alg: u32,
+    pub(crate) supported_slots: u8,
+    pub(crate) provisioned_slots: u8,
 
     /* Signature algorithm */
     base_asym_enc: &'static CStr,
@@ -118,6 +130,9 @@ pub struct SpdmState {
     pub(crate) shash: *mut bindings::crypto_shash,
     pub(crate) desc: Option<&'static mut bindings::shash_desc>,
     pub(crate) hash_len: usize,
+
+    // Certificates
+    pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
 }
 
 impl SpdmState {
@@ -139,12 +154,15 @@ pub(crate) fn new(
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
 
@@ -578,4 +596,69 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
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
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+        // SAFETY: `response_vec` is rsp_sz length, initialised, aligned
+        // and won't be mutated
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let len = self.spdm_exchange(request_buf, response_buf)?;
+
+        if len < (core::mem::size_of::<GetDigestsRsp>() as i32) {
+            pr_err!("Truncated digests response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `len` is the length of data read, which will be smaller
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(len as usize) };
+
+        let response: &mut GetDigestsRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        if len
+            < (core::mem::size_of::<GetDigestsReq>()
+                + response.param2.count_ones() as usize * self.hash_len) as i32
+        {
+            pr_err!("Truncated digests response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        let mut deprovisioned_slots = self.provisioned_slots & !response.param2;
+        while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
+            let slot = deprovisioned_slots.trailing_zeros() as usize;
+            self.certs[slot].clear();
+            deprovisioned_slots &= !(1 << slot);
+        }
+
+        self.provisioned_slots = response.param2;
+        if self.provisioned_slots == 0 {
+            pr_err!("No certificates provisioned\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        if self.version >= SPDM_VER_13 && (response.param2 & !response.param1 != 0) {
+            pr_err!("Malformed digests response\n");
+            to_result(-(bindings::EPROTO as i32))?;
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
index 9d738133399d..1e5ee8a7582b 100644
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
@@ -349,3 +350,56 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
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
+    // CertificatInfo, added in 1.3
+
+    // KeyUsageMask, added in 1.3
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetDigestsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetDigestsRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetDigestsRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetDigestsRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetDigestsRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

