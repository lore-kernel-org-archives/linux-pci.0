Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC9373BE8
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224792; cv=none; b=DvaHghB43pSZKnNeIFXElI220FG8VYeojOVU+T205grR6waEnq/Qvc3jKprz5peEl5GybsDIvFNZf0jSUVN1Jo5EH02xRo22DSKF4CALp5/v92xlQclzIxfQtx3yEVu2BQ+091YDqELZfqOH0B40Z4RvyToewyVSTj9iJ+fBk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224792; c=relaxed/simple;
	bh=cZDs5FSiErKhdb59fvbIO2wHQUXcvwBVv5IZLUaKgNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8qmaPHG4yOFQyYB/IuxOdsTxoOlb4wQBNSXp6hh+19VrKPUnGWazJPNud6gzk3kwwTqBQKctHpvwgt5saXTgRNh6VY5tu7GeWrXjr6pp44+BRNFAY8rVReCqTdZLA3goblln2LEKvD3pmfoVhKBZN6PgQ6FIOD3+6AN1x56OGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2zPAKrk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2zPAKrk"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca80d708489so384720a12.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224789; x=1788829589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zc/YFp8CPqmIoAvXYTRy9XGxn2OzKW6NDo5dSVttpB0=;
        b=U2zPAKrkYs9/Qd3uQgfs6Z8/63NsBzbHH+3HqV/uHOjPB2ZQIDuOfA3t+pA5AgxYeZ
         pSSc6/2WrUBC1Z0eBM2rZs/qBL5j1pyLd/8DjjMYC5cwdxQwe+jbGJTIAGyL2UsRMcg7
         q+fsvmkVJTeK4doZQyPk3dJPcQXSZcp9CfQffCgSsL8UoLmcslU4NwiTIKYdUMHGIPwX
         ++pLY2EJyJKFGKLmFIK8hfxuBpJSzu0EsRz9/7DYKUGK9ZPqwzLmSzZ0IaOZQ79Sq4at
         +4yXHxNeRwuDbzl1w2kZ3H2so5aFOh3AY//xswmt4TNyObPlHMuA+Z+iER/LyFnV9pKN
         XicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224789; x=1788829589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zc/YFp8CPqmIoAvXYTRy9XGxn2OzKW6NDo5dSVttpB0=;
        b=BHA5i1RtO12jVy7BybGjrKavsbXW6sHLKkDYkJNmXp1JXLfnjjrksIqQBHcphA7Abn
         97FTlq7kpP+vh02R5eYg0+i0Mw2qT+UEAf+iwUwlWDePRVsoJJUh9+b6RUwgBj7eJYni
         01JVJ2zyfuGnywQVTmhenW/pv69zEpM0j8Msp86e27crOMw3+NMpeOSmTMHcsLBTZ4zt
         CqKsNU+xrUbV74lddvsGxEK2088oNJzf+7m8lUeHfzSHsf5eJbkoyT5t10Sw1dyVn8ze
         a4tuGa2ufBV66CMRRS4mHQUtTiezSqS88IESm5fh+Z/OulQLavYchWJkP42MO47bIeCD
         7hrA==
X-Gm-Message-State: AFuF++nsmp5jFJ1WNcDEqJ4C/19k3X/Zr/fBFSgc/IJziXJYYqiWFIeP
	R0PtfddAAzPIO4ddlVgmP36OlYmCmlIKCd8hKyCNrdF7Yf/lqQkvdt6DpRrE3g==
X-Gm-Gg: AYBFou29iXYR9L3Uqw34D+yM5uIeDjET7Q8tMpuasKAYXzYr1t3HLl0/8L+0afVCQ7O
	PYDF8hQyDW9I7zyVxa2BNjRvHZuMUPbXs2gmTWdqQTpiqRzqU6H3m/IpvJ3FaLM1egZ+My9hC1v
	gMc1nWxyiO9A0RiNvQG0X1LjCycdR9EGGaZCkFxkmggfD69xPO+RwOIPy5DyHZV6+Uv0vypQLxC
	65YQI7usrj74pNmR674YSfSEQnRsfufLheIYOG20p2BccGdlV2qNbX7hc0rMh3BXCnsbIisiOvc
	ScQl0EQbRhjaIK9uNAplEeb+5w3kJpnTM9QADpmHdtFqbPqyuaYHGUaWPuI/YditPtXIY8bpqIA
	OfzdZrTFbcWf/i70jFcAwpHPl2sOW2IgGZbcuOmeJd6gq3lx+EL7agMdoL9WIzFbW6rlxYdyyYS
	Q+GrCTNSXT8Oq+xpaHw9nbxnEVu3fl/qSMymUI1wURx4iuYAMxXztTDyW85DLALn7ubh9cZERbm
	xX9nXNIxzydA0/8
X-Received: by 2002:a17:90b:5828:b0:390:84db:888e with SMTP id 98e67ed59e1d1-3990f7cc65fmr1561750a91.7.1788224788686;
        Mon, 31 Aug 2026 18:06:28 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:06:28 -0700 (PDT)
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
Subject: [PATCH v3 17/21] lib: rspdm: Support SPDM get_digests
Date: Tue,  1 Sep 2026 11:03:43 +1000
Message-ID: <20260901010347.2614656-18-alistair.francis@wdc.com>
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
index b78086c75370..131c22319b26 100644
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
@@ -163,12 +178,15 @@ pub(crate) fn new(
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
 
@@ -612,4 +630,64 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
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
index 4f7a82d4b210..ddbf5c448bd7 100644
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
+impl<'a> Validate<Untrusted<&'a [u8]>> for &'a GetDigestsRsp {
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
2.55.0

