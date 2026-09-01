Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376139CD10
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224783; cv=none; b=pOq0FX0sxsCzulbswnlfFfEAb3jCRCyUejN5JLkRBSLoFFlFBIYXQ7RI9L7cJYAYr5dcYEqSS4xZWnMZV56ZCgbo0zEOPnPVYrpA2AKbTBbZjLN2QtNjPAt0Ma6FbN516fuDjZZ3+nb8/JAAXGTRbpNce900cG+GM/M2nZuB2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224783; c=relaxed/simple;
	bh=kTHJ/QPkYNd//c0TESdkc13fbM/gd48KpcZp89S1ub0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9jm7pqJj5GIF/anqN5XODiLYkQ0UeEtWqh14ooJdCeID9Tt6EIhXgh16Kl3lrb/kkQjEK7V4Nsyb/32i/1b54t8Ut5HF4v/aiHNhFzfQ1Fb30oaP0Zs9WdpgXJjNGjvgnXvTnHVMCWG1HGSxwh5S+SwQXqlD6IVBVloF7bVBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHOFBNpd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHOFBNpd"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so6245636a91.1
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224780; x=1788829580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j3Gr1v/xD1HJHe6jn4Cyq8fVkwF8e8ZZjnc+itEfv9M=;
        b=ZHOFBNpdyVjr2HD26WAAEX9Tez3CPlFiTL9fR5zgNUokL96n3TZR+EUUqmQJTooe5o
         wGvXtDEkSMERd22HeKpBE558+kQzC50fCgJdPeDgy2SJ4pmiZUcY4X/j4c2NXO7xFQ0w
         Rbmqr2Ykea61ozqw7v1BqjIA3pdoiC0ACxK1hud5ljGTDYTcoFtHXez+nf4kz9dasjEl
         v1xiIamLI4Ec3yN+/Ft80NGAFE0pt495aZOBa+I7tkA0n6hl6Ga4EJUL6NbIlhvTY0aD
         HDjgH1XBnhsIIieDf41JFBOaZpB7QLbGd7TzPnmq0+Hp72a9wFdkOc35qhqbEHoxGk0b
         kYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224780; x=1788829580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3Gr1v/xD1HJHe6jn4Cyq8fVkwF8e8ZZjnc+itEfv9M=;
        b=b+OfRTU51lDDCF28gsX97kzmYGXSdcxrz8sKg3/sZxovSQ5oXV2u5cshBMf/Z3laPl
         Kf8VBXKLMzBH0mKJyZ4ETO6//p/IYA2VuZ68z19ArUU6OJRXyzAsFbz3Xtjy8MuTbdPg
         tRaNJbrdhFJJfy4ptyyjHd3eocwYdfC9UQbBtKf97p2IdlJQ0la4UKBdvZxCC96D99EY
         z9GwGYluxH0mrGNSNNulY8Bh380LOKBlaSMDNVRzHdM6EhIwcApIciJYKgVvCN6aICqH
         /9OMl24OOhBVoBIgJahqDPH9b7JIf7nrlb1wjxxVDeDryuMecV0bvjVjUm7n/NAWoYwC
         jlkw==
X-Gm-Message-State: AFuF++nDZws6v3IMtvrZVZjXSgA1y0uvsuTi5HNuzvV55zwRoXRNlGR5
	8naG1TrRNxZkLCJuHJgQLnIo3017FgRGW02I0rmpuGOU8DnQjVv1wzdmJEGmTQ==
X-Gm-Gg: AYBFou1zo9rVgtidPcCAt7FFnsEvm41epjxOsjRqLZcda9sUqeiedtw5pi/2wbVKDMv
	w7crZslLraTHliAuMtUVpPmXK6jjUBllY504ZwsKOsicSJD3rx4Kf1kHKXcyVHOV0o0yS2JFPom
	XOA+RURQRsC+o8uSgO/aif0HG/T2PrAWpz9/hZnS788CKaa9x9RJ2LDkpVaEkw1Jp3xEKn2yf6I
	+6w/l1GUmPsRa0b6e6Pkt4ypt+XGNvMubzqL+xehNFIwOIMn/U0bxAeJ/2Opzye+tAAUri18G1R
	uTlqEwL0a/MtbZmOQKG6Yk0Pbr5BEioURmPQQgo6vsnUn1T2eesZuG9oDkRsUy4oRTPBHiV+C+C
	DPOPeuHLLucWXtL670um/08fe/khRauvucLH74xRz8ZAVflkI/VuTASnn4bRADvTnK5Y++e7zDR
	KzY3SCI06RBivSRV4k2yg/iJASxtnHw+cdgyFFBKkBv7JyAG5jcngLzyiHJt7Y3oNBbVUVPE1K1
	oZRJZY=
X-Received: by 2002:a17:90b:5281:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39907aff83dmr6193773a91.5.1788224780251;
        Mon, 31 Aug 2026 18:06:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:06:19 -0700 (PDT)
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
Subject: [PATCH v3 16/21] lib: rspdm: Support SPDM negotiate_algorithms
Date: Tue,  1 Sep 2026 11:03:42 +1000
Message-ID: <20260901010347.2614656-17-alistair.francis@wdc.com>
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

Support the NEGOTIATE_ALGORITHMS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |  56 +++++++++-
 lib/rspdm/lib.rs       |   9 +-
 lib/rspdm/state.rs     | 243 ++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 110 ++++++++++++++++++-
 4 files changed, 412 insertions(+), 6 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 15d69631ed8c..e222821bad5d 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -9,7 +9,10 @@
 
 use crate::validator::GetVersionRsp;
 use core::mem;
-use kernel::bits::bit_u32;
+use kernel::bits::{
+    bit_u32,
+    bit_u8, //
+};
 use kernel::error::{code::EINVAL, Error};
 
 // SPDM versions supported by this implementation
@@ -114,6 +117,57 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_CERT_CAP: u32 = bit_u32(1);
 pub(crate) const SPDM_CHAL_CAP: u32 = bit_u32(2);
+pub(crate) const SPDM_KEY_EX_CAP: u32 = bit_u32(9);
 
 pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
 pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+
+pub(crate) const SPDM_NEGOTIATE_ALGS: u8 = 0xe3;
+
+pub(crate) const SPDM_MEAS_SPEC_DMTF: u8 = bit_u8(0);
+
+pub(crate) const SPDM_ASYM_RSASSA_2048: u32 = bit_u32(0);
+pub(crate) const _SPDM_ASYM_RSAPSS_2048: u32 = bit_u32(1);
+pub(crate) const SPDM_ASYM_RSASSA_3072: u32 = bit_u32(2);
+pub(crate) const _SPDM_ASYM_RSAPSS_3072: u32 = bit_u32(3);
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P256: u32 = bit_u32(4);
+pub(crate) const SPDM_ASYM_RSASSA_4096: u32 = bit_u32(5);
+pub(crate) const _SPDM_ASYM_RSAPSS_4096: u32 = bit_u32(6);
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P384: u32 = bit_u32(7);
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P521: u32 = bit_u32(8);
+pub(crate) const _SPDM_ASYM_SM2_ECC_SM2_P256: u32 = bit_u32(9);
+pub(crate) const _SPDM_ASYM_EDDSA_ED25519: u32 = bit_u32(10);
+pub(crate) const _SPDM_ASYM_EDDSA_ED448: u32 = bit_u32(11);
+
+pub(crate) const SPDM_HASH_SHA_256: u32 = bit_u32(0);
+pub(crate) const SPDM_HASH_SHA_384: u32 = bit_u32(1);
+pub(crate) const SPDM_HASH_SHA_512: u32 = bit_u32(2);
+
+// If the crypto support isn't enabled don't offer the algorithms
+// to the responder
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
+pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 76325babdff2..d418d15e4c70 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -94,7 +94,7 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
     // exclusive `&mut SpdmState` lives entirely inside the lock guard, so
     // concurrent FFI callers serialize on the mutex and can never form
     // aliased `&mut SpdmState` references.
-    let mutex: &Mutex<SpdmState> = unsafe { &*(state_ptr as *const Mutex<SpdmState>) };
+    let mutex: &Mutex<SpdmState<'_>> = unsafe { &*(state_ptr as *const Mutex<SpdmState<'_>>) };
 
     let mut state = mutex.lock();
 
@@ -106,6 +106,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
@@ -117,11 +121,12 @@ pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
     if state_ptr.is_null() {
         return;
     }
+
     // SAFETY: `state_ptr` was returned from `spdm_create()`, which leaked a
     // `Pin<KBox<Mutex<SpdmState>>>` via `KBox::into_raw`.  The caller
     // guarantees the state is no longer in use.  Reconstructing the pinned
     // box and dropping it runs `Drop` for the `Mutex` and `SpdmState` and
     // frees the allocation.
-    let b = unsafe { KBox::from_raw(state_ptr as *mut Mutex<SpdmState>) };
+    let b = unsafe { KBox::from_raw(state_ptr as *mut Mutex<SpdmState<'_>>) };
     drop(unsafe { Pin::new_unchecked(b) });
 }
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 5ef14c8ed237..b78086c75370 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -14,19 +14,34 @@
     bindings,
     error::{
         code::EINVAL,
+        from_err_ptr,
         to_result,
         Error, //
     },
+    str::CStr,
     validate::Untrusted,
 };
 
 use crate::consts::{
     SpdmErrorCode,
+    SPDM_ASYM_ALGOS,
+    SPDM_ASYM_ECDSA_ECC_NIST_P256,
+    SPDM_ASYM_ECDSA_ECC_NIST_P384,
+    SPDM_ASYM_ECDSA_ECC_NIST_P521,
+    SPDM_ASYM_RSASSA_2048,
+    SPDM_ASYM_RSASSA_3072,
+    SPDM_ASYM_RSASSA_4096,
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
+    SPDM_HASH_ALGOS,
+    SPDM_HASH_SHA_256,
+    SPDM_HASH_SHA_384,
+    SPDM_HASH_SHA_512,
+    SPDM_KEY_EX_CAP,
     SPDM_MAX_VER,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
+    SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_VER_10,
@@ -38,6 +53,8 @@
     GetCapabilitiesRsp,
     GetVersionReq,
     GetVersionRsp,
+    NegotiateAlgsReq,
+    NegotiateAlgsRsp,
     SpdmErrorRsp,
     SpdmHeader, //
 };
@@ -61,8 +78,27 @@
 ///  Negotiated during GET_VERSION exchange.
 /// `rsp_caps`: Cached capabilities of responder.
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
+/// @shash: Synchronous hash handle for @base_hash_alg computation.
+/// @desc: Synchronous hash context for @base_hash_alg computation.
+/// @hash_len: Hash length of @base_hash_alg (in bytes).
+///  H in SPDM specification.
 #[expect(dead_code)]
-pub(crate) struct SpdmState {
+pub(crate) struct SpdmState<'a> {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
     pub(crate) transport_priv: *mut c_void,
@@ -72,9 +108,43 @@ pub(crate) struct SpdmState {
     // Negotiated state
     pub(crate) version: u8,
     pub(crate) rsp_caps: u32,
+    pub(crate) base_asym_alg: u32,
+    pub(crate) base_hash_alg: u32,
+    pub(crate) meas_hash_alg: u32,
+
+    /* Signature algorithm */
+    base_asym_enc: &'a CStr,
+    sig_len: usize,
+
+    /* Hash algorithm */
+    base_hash_alg_name: &'a CStr,
+    pub(crate) shash: *mut bindings::crypto_shash,
+    pub(crate) desc: Option<&'a mut bindings::shash_desc>,
+    pub(crate) hash_len: usize,
 }
 
-impl SpdmState {
+impl Drop for SpdmState<'_> {
+    fn drop(&mut self) {
+        if let Some(desc) = self.desc.take() {
+            // SAFETY: `self.shash` is a valid handle
+            let desc_len = core::mem::size_of::<bindings::shash_desc>()
+                + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
+
+            // SAFETY: `desc` was allocated as a KVec<u8> with a length of `desc_len`
+            // and then transmuted to a raw pointer with into_raw_parts()
+            let desc_ptr =
+                unsafe { core::mem::transmute::<&mut bindings::shash_desc, *mut u8>(desc) };
+            let desc_vec = unsafe { KVec::<u8>::from_raw_parts(desc_ptr, desc_len, desc_len) };
+            drop(desc_vec);
+        }
+
+        unsafe {
+            bindings::crypto_free_shash(self.shash);
+        }
+    }
+}
+
+impl SpdmState<'_> {
     pub(crate) fn new(
         dev: *mut bindings::device,
         transport: bindings::spdm_transport,
@@ -90,6 +160,15 @@ pub(crate) fn new(
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
 
@@ -373,4 +452,164 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
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
+        // This is freed in when `SpdmState` is dropped, but this call
+        // can happen multiple times.
+        if self.shash != core::ptr::null_mut() {
+            if let Some(desc) = self.desc.take() {
+                // SAFETY: `self.shash` is a valid handle
+                let desc_len = core::mem::size_of::<bindings::shash_desc>()
+                    + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
+
+                // SAFETY: `desc` was allocated as a KVec<u8> with a length of `desc_len`
+                // and then transmuted to a raw pointer with into_raw_parts()
+                let desc_ptr =
+                    unsafe { core::mem::transmute::<&mut bindings::shash_desc, *mut u8>(desc) };
+                let desc_vec = unsafe { KVec::<u8>::from_raw_parts(desc_ptr, desc_len, desc_len) };
+                drop(desc_vec);
+            }
+
+            unsafe {
+                bindings::crypto_free_shash(self.shash);
+            }
+        }
+
+        self.shash =
+            unsafe { bindings::crypto_alloc_shash(self.base_hash_alg_name.as_char_ptr(), 0, 0) };
+        if let Err(e) = from_err_ptr(self.shash) {
+            self.shash = core::ptr::null_mut();
+            return Err(e);
+        }
+
+        // SAFETY: `self.shash` is a valid handle (verified above).
+        let desc_len = core::mem::size_of::<bindings::shash_desc>()
+            + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
+
+        let desc_vec: KVec<u8> = KVec::from_elem(0u8, desc_len, GFP_KERNEL)?;
+        // Consume the desc_vec to make sure it isn't dropped, untill we
+        // manually drop it later
+        let (desc_buf, _length, _capacity) = desc_vec.into_raw_parts();
+
+        // SAFETY: We are casting the allocation to be a shash_desc
+        let desc = unsafe {
+            core::mem::transmute::<*mut c_void, &mut bindings::shash_desc>(desc_buf as *mut c_void)
+        };
+        desc.tfm = self.shash;
+
+        self.desc = Some(desc);
+
+        /* Used frequently to compute offsets, so cache H */
+        self.hash_len = unsafe { bindings::crypto_shash_digestsize(self.shash) as usize };
+
+        if let Some(desc) = &mut self.desc {
+            // SAFETY: `self.desc` is a valid and initalised `shash_desc` sized buffer
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
+        let req_sz = core::mem::size_of::<NegotiateAlgsReq>();
+        let rsp_sz = core::mem::size_of::<NegotiateAlgsRsp>();
+
+        request.length = (req_sz as u16).to_le();
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let rc = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if rc > response_vec.len() {
+            pr_err!("Overflowed capabilities response\n");
+            return Err(EIO);
+        }
+        response_vec.truncate(rc);
+
+        let response: &NegotiateAlgsRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+
+        self.base_asym_alg = u32::from_le(response.base_asym_sel);
+        self.base_hash_alg = u32::from_le(response.base_hash_sel);
+        self.meas_hash_alg = u32::from_le(response.measurement_hash_algo);
+
+        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
+            pr_err!("No common supported algorithms\n");
+            return Err(EPROTO);
+        }
+
+        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+        if self.base_asym_alg.count_ones() != 1
+            || self.base_hash_alg.count_ones() != 1
+            || self.meas_hash_alg.count_ones() != 1
+            || response.ext_asym_sel_count != 0
+            || response.ext_hash_sel_count != 0
+            || response.param1 > request.param1
+            || response.other_params_sel != request.other_params_support
+        {
+            pr_err!("Malformed algorithms response\n");
+            return Err(EPROTO);
+        }
+
+        self.update_response_algs()?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 42c0b28cdcaa..4f7a82d4b210 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -9,7 +9,8 @@
 
 use crate::bindings::{
     __IncompleteArrayField,
-    __le16, //
+    __le16,
+    __le32, //
 };
 use crate::consts::SpdmErrorCode;
 use core::mem;
@@ -26,10 +27,14 @@
 };
 
 use crate::consts::{
+    SPDM_ASYM_ALGOS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
+    SPDM_HASH_ALGOS,
+    SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_VER,
+    SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS,
     SPDM_VER_10,
     SPDM_VER_11, //
@@ -265,3 +270,106 @@ fn validate(unvalidated: &mut KVec<u8>) -> Result<Self, Self::Err> {
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
+    pub(crate) param1: u8, // size of resp_alg_struct
+    param2: u8,
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
+    pub(crate) resp_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl Default for NegotiateAlgsReq {
+    fn default() -> Self {
+        NegotiateAlgsReq {
+            version: 0,
+            code: SPDM_NEGOTIATE_ALGS,
+            param1: 0, // Size of resp_alg_struct
+            param2: 0,
+            length: 32,
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
+            resp_alg_struct: __IncompleteArrayField::new(),
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
+    pub(crate) resp_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl<'a> Validate<Untrusted<&'a [u8]>> for &'a NegotiateAlgsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<NegotiateAlgsRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `NegotiateAlgsRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<NegotiateAlgsRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &NegotiateAlgsRsp = unsafe { &*ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.55.0

