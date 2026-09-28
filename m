Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4581D356A38
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558020; cv=none; b=Os7Al76xILsBadAonFedHX/JXHWLxfb/f2MiiraAPp2VUWNIGC70y3asjAz4XfMbnz1gJInRS2di+ZJVb29+cZrupB3ZD0MSYAvnWM/3wIpDpgR7GBstYxpRD09bgUjhmgSEZQR6PuoaJmKg6XtfBvsjXZ1wykSppqwHRMRtw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558020; c=relaxed/simple;
	bh=XjS5Q6GNMcXbZVUSMm0Tu5HG1TddScPLsiXxWXR+Rkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYUk2kgDH1bOC+BtxhIr3MUO+mnJiwy6MC8ONfNfSE/lLiLrxVtm/lqfY/xIfJFacp5mJekB2s3HlCnIshf5X73PvbrB3Xoes9GIUH/pAt1BOZ2uySu5fO50j0jDvMXMo3dpiUQW6GG9+D2sGhyGM2Tqrgrs+n/3RKfr8m60kqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/phMSNA; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/phMSNA"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1597999a91.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558018; x=1791162818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp5x/cvk0+EnY4LEBiGgp5CfzdHwhSL+n9yKzCKH2JY=;
        b=p/phMSNAsJXbvsOAtrfozq82FE7FIQ+W0hocH4EuM/QpvLvv4LItXATly0+x7ywtcJ
         g1NwbHZjG8GWXfB2aeRSF8zrwym4VSObr3J+372JSDqBNoP3GgaGdOxXl/St28qmneTz
         nAu7ytMCSxYOxJSp4ocg2zl8d616lcxvQgBBhoSOG/Rat5Od+9vCe3lhHPortTQvBAOa
         eqKZt30LbuqS+bZhQOE0KtiY5917cbJGK8p/koSOVidCzK4+iI8bQ80SyOzkX1ehZfm5
         4KREWVvifyJ5XoWEIUJdkxBf76ZYlsJ68EXLtXQ5ogmNtpDyuv60hEpt9Wp83+6vWQDH
         /awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558018; x=1791162818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sp5x/cvk0+EnY4LEBiGgp5CfzdHwhSL+n9yKzCKH2JY=;
        b=P/FUFktKKUMaPMiJsWZR40hxWf6C3kaXUEgBfmG6ThABmWgUrdBMAhJq2Xtv9Xw6mU
         MkF90KwhrEKWRhLYp2PTw+nat5knLtxYZttWhMghSRFqFUuSetrWrod5CL2HnjU65/+0
         qfNjex4qPK+fA7T5QOMj7p/wpsWW3Msj9sM+0ZQU67TLvyoQhJ8vNIdxxxL4bgQjTjx/
         dJBqcqxIjrbjTB3Cm0NzniO3ZpQH3BP5D/Ol7+pZmHsPrsqrONOF0pAWSDtaP5AIInE/
         wkzvKeUDNCt0Vb5jMFEJ9/i6NcUGJnrLiaRLGlyF7ConE675JuAOBFSxohkLFXdSOTeg
         wpIA==
X-Forwarded-Encrypted: i=1; AKwUvBwE1HyIj0eRqFRQ0kUfOgir4vFdpgrW196vxgQrn87UVFW+11d6rWk5LdOv4uup/2HzACooU5N7E7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrb0KyeEpzP+LmtMwm1HXuLVE3wHSGjKVei+MfGPiOH/FpcXVy
	/1AA5MN9033nHSo5Wg9nrpdwqyqZGRoxzE3d0P4+HkbX+3JikM4vMfRR
X-Gm-Gg: AYBFou3ii1tet2ZfWTwCKAodm47tVAntlGS21STMmnJZZrZHamRBdjwoteuTj7/vZMQ
	QiXToGvbGccI1b6CpLg6YOOlo9bQzjQxuEjnYCvfz/FSxndaOGspiSP2ZZc0bqWng6c9RR4/oRP
	QBwXUDvyKJHEHdSbi4jTAOyKSBZz3GR+k0c4IRMrYWUyEvidE86CmtEjw+GZdhsUrwqVxg7bFsk
	AwGD5ykf09BabK2SLKCMBjPlf/INcmOiS9GwX0kafp62DDrb0wcdpwjRft0WfaZIeoHaxqwKkL0
	QefmFFpTtPdbPvFz/kZ4q4SQcB+oQqSZetU2DM05i+UMWzZg6MAHgAX0PFgtB4ycaVQMVZLI37X
	LgELdXdbNZ3tKbAfQGWuv0QqrwAy9yFsZiPCLQTBTbu8Ykg7OmbZLc3iRweyrRsA6tyhGxLkcif
	yeip98t1QQUdr4lrVw+kO0rncyLcqH4kAJJ79aQjTIH9x2D9Dkg3JDxk7J904UMrZgz10Cre6WA
	HBzk56FCAaWZsOU
X-Received: by 2002:a17:90a:ec8e:b0:3a0:345a:3620 with SMTP id 98e67ed59e1d1-3a098df852amr8937499a91.45.1790558017527;
        Sun, 27 Sep 2026 18:13:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:13:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org
Subject: [PATCH v4 17/22] lib: rspdm: Support SPDM negotiate_algorithms
Date: Mon, 28 Sep 2026 11:11:18 +1000
Message-ID: <20260928011123.450800-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
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
 lib/rspdm/consts.rs    |  52 +++++++++
 lib/rspdm/lib.rs       |   8 +-
 lib/rspdm/state.rs     | 250 ++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 231 +++++++++++++++++++++++++++++++++++--
 4 files changed, 528 insertions(+), 13 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index cbba95944ef9..d51b6eb06f81 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -118,6 +118,58 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_CERT_CAP: u32 = bit_u32(1);
 pub(crate) const SPDM_CHAL_CAP: u32 = bit_u32(2);
+pub(crate) const SPDM_KEY_EX_CAP: u32 = bit_u32(9);
+pub(crate) const SPDM_MEAS_RESP_CAP: u32 = bit_u32(3) | bit_u32(4);
 
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
index 1109a9334713..63db5da8aa7a 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -88,7 +88,7 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
     // concurrent FFI callers serialize on the mutex and can never form
     // aliased `&mut SpdmState` references.
     let mutex = unsafe {
-        <Pin<KBox<Mutex<SpdmState>>> as ForeignOwnable>::borrow(state_ptr as *mut c_void)
+        <Pin<KBox<Mutex<SpdmState<'_>>>> as ForeignOwnable>::borrow(state_ptr as *mut c_void)
     };
 
     let mut state = mutex.lock();
@@ -101,6 +101,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
@@ -115,7 +119,7 @@ pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
 
     // SAFETY: `state_ptr` was returned from `spdm_create()` which used `into_foreign()`
     // to create the pointer.
-    let mutex: KBox<Mutex<SpdmState>> = unsafe { KBox::from_foreign(state_ptr as *mut c_void) };
+    let mutex: KBox<Mutex<SpdmState<'_>>> = unsafe { KBox::from_foreign(state_ptr as *mut c_void) };
 
     drop(mutex);
 }
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index fb43260f4800..51055ea521d7 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -13,18 +13,34 @@
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
+    SPDM_MEAS_RESP_CAP,
     SPDM_MIN_VER,
+    SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_VER_10,
@@ -36,9 +52,12 @@
     GetCapabilitiesRsp,
     GetVersionReq,
     GetVersionRsp,
+    NegotiateAlgsReq,
+    NegotiateAlgsRsp,
     SpdmErrorRsp,
     SpdmHeader,
-    GET_CAPABILITIES_RSP_SZ, //
+    GET_CAPABILITIES_RSP_SZ,
+    NEGOTIATE_ALGS_RSP_SZ, //
 };
 
 /// The current SPDM session state for a device.
@@ -64,8 +83,27 @@
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
@@ -75,9 +113,32 @@ pub(crate) struct SpdmState {
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
+    pub(crate) desc: *mut bindings::shash_desc,
+    pub(crate) hash_len: usize,
 }
 
-impl SpdmState {
+impl Drop for SpdmState<'_> {
+    fn drop(&mut self) {
+        self.free_desc();
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
@@ -93,6 +154,31 @@ pub(crate) fn new(
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
+            desc: core::ptr::null_mut(),
+            hash_len: 0,
+        }
+    }
+
+    /// Free the `shash_desc` buffer if one is allocated.
+    fn free_desc(&mut self) {
+        if !self.desc.is_null() {
+            // SAFETY: `self.shash` is a valid handle when `desc` is allocated.
+            let desc_len = core::mem::size_of::<bindings::shash_desc>()
+                + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
+
+            // SAFETY: `desc` points to a KVec<u8> allocation of `desc_len`
+            // bytes handed out with `KVec::into_raw_parts()`.
+            let desc_vec =
+                unsafe { KVec::<u8>::from_raw_parts(self.desc as *mut u8, desc_len, desc_len) };
+            drop(desc_vec);
+            self.desc = core::ptr::null_mut();
         }
     }
 
@@ -356,4 +442,162 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn update_response_algs(&mut self) -> Result<(), Error> {
+        match self.base_asym_alg {
+            #[cfg(CONFIG_CRYPTO_RSA)]
+            SPDM_ASYM_RSASSA_2048 => {
+                self.sig_len = 256;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            #[cfg(CONFIG_CRYPTO_RSA)]
+            SPDM_ASYM_RSASSA_3072 => {
+                self.sig_len = 384;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            #[cfg(CONFIG_CRYPTO_RSA)]
+            SPDM_ASYM_RSASSA_4096 => {
+                self.sig_len = 512;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            #[cfg(CONFIG_CRYPTO_ECDSA)]
+            SPDM_ASYM_ECDSA_ECC_NIST_P256 => {
+                self.sig_len = 64;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            #[cfg(CONFIG_CRYPTO_ECDSA)]
+            SPDM_ASYM_ECDSA_ECC_NIST_P384 => {
+                self.sig_len = 96;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            #[cfg(CONFIG_CRYPTO_ECDSA)]
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
+            #[cfg(CONFIG_CRYPTO_SHA256)]
+            SPDM_HASH_SHA_256 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha256\0")?;
+            }
+            #[cfg(CONFIG_CRYPTO_SHA512)]
+            SPDM_HASH_SHA_384 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha384\0")?;
+            }
+            #[cfg(CONFIG_CRYPTO_SHA512)]
+            SPDM_HASH_SHA_512 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha512\0")?;
+            }
+            _ => {
+                pr_err!("Unknown hash algorithm\n");
+                return Err(EINVAL);
+            }
+        }
+
+        // This is freed when `SpdmState` is dropped, but this call
+        // can happen multiple times.
+        if self.shash != core::ptr::null_mut() {
+            self.free_desc();
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
+        let desc = desc_buf as *mut bindings::shash_desc;
+
+        // SAFETY: `desc` points to an allocation of `desc_len` bytes, which is
+        // large enough for a `shash_desc` header and its trailing context.
+        unsafe { (*desc).tfm = self.shash };
+
+        self.desc = desc;
+
+        // Used frequently to compute offsets, so cache H
+        self.hash_len = unsafe { bindings::crypto_shash_digestsize(self.shash) as usize };
+
+        // SAFETY: `self.desc` points to a valid `shash_desc` sized buffer
+        // with `tfm` initialised above.
+        unsafe { to_result(bindings::crypto_shash_init(desc)) }
+    }
+
+    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
+        let mut request = NegotiateAlgsReq::default();
+        request.header.version = self.version;
+
+        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
+            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
+        }
+
+        let rsp_sz =
+            (NEGOTIATE_ALGS_RSP_SZ as u32 + u16::MAX as u32).min(self.transport_sz) as usize;
+
+        request.length = NegotiateAlgsReq::WIRE_SIZE as u16;
+
+        let mut request_buf = request.to_bytes()?;
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let rc =
+            self.spdm_exchange(request_buf.as_mut_slice(), response_vec.as_mut_slice())? as usize;
+        response_vec.truncate(rc);
+
+        let response: NegotiateAlgsRsp =
+            Untrusted::new(response_vec.as_slice()).validate(&*self)?;
+
+        self.base_asym_alg = response.base_asym_sel;
+        self.base_hash_alg = response.base_hash_sel;
+        self.meas_hash_alg = response.measurement_hash_algo;
+
+        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
+            pr_err!("No common supported algorithms\n");
+            return Err(EPROTO);
+        }
+
+        let meas_hash_valid = if self.rsp_caps & SPDM_MEAS_RESP_CAP != 0
+            && response.measurement_specification_sel != 0
+        {
+            self.meas_hash_alg.count_ones() == 1
+        } else {
+            self.meas_hash_alg == 0
+        };
+
+        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+        if self.base_asym_alg.count_ones() != 1
+            || self.base_hash_alg.count_ones() != 1
+            || !meas_hash_valid
+            || response.ext_asym_sel_count != 0
+            || response.ext_hash_sel_count != 0
+            || response.header.param1 > request.header.param1
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
index ca837bd9cfcc..58f6a3d436a8 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -22,12 +22,16 @@
 };
 
 use crate::consts::{
+    SPDM_ASYM_ALGOS,
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
+    SPDM_HASH_ALGOS,
+    SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
+    SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS,
     SPDM_VER_10,
     SPDM_VER_11,
@@ -67,9 +71,9 @@ pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
 impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmHeader {
     type Err = Error;
 
-    type Context = &'c SpdmState;
+    type Context = &'c SpdmState<'c>;
 
-    fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Result<Self, Self::Err> {
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
         Ok(SpdmHeader {
             version: *unvalidated.get(0).ok_or(EIO)?,
             code: *unvalidated.get(1).ok_or(EIO)?,
@@ -91,9 +95,9 @@ pub(crate) struct SpdmErrorRsp {
 impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmErrorRsp {
     type Err = Error;
 
-    type Context = &'c SpdmState;
+    type Context = &'c SpdmState<'c>;
 
-    fn validate(unvalidated: &[u8], _context: &'c SpdmState) -> Result<Self, Self::Err> {
+    fn validate(unvalidated: &[u8], _context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
         Ok(SpdmErrorRsp {
             version: *unvalidated.get(0).ok_or(EIO)?,
             code: *unvalidated.get(1).ok_or(EIO)?,
@@ -143,9 +147,9 @@ pub(crate) fn len(&self) -> usize {
 impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetVersionRsp {
     type Err = Error;
 
-    type Context = &'c SpdmState;
+    type Context = &'c SpdmState<'c>;
 
-    fn validate(unvalidated: &[u8], context: &'c SpdmState) -> Result<Self, Self::Err> {
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
         let header: SpdmHeader =
             Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
 
@@ -396,9 +400,9 @@ pub(crate) fn len(&self) -> usize {
 impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetCapabilitiesRsp {
     type Err = Error;
 
-    type Context = &'c SpdmState;
+    type Context = &'c SpdmState<'c>;
 
-    fn validate(unvalidated: &[u8], context: &'c SpdmState) -> Result<Self, Self::Err> {
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
         let header: SpdmHeader =
             Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
 
@@ -482,3 +486,214 @@ fn validate(unvalidated: &[u8], context: &'c SpdmState) -> Result<Self, Self::Er
         })
     }
 }
+
+pub(crate) struct NegotiateAlgsReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification: u8,
+    pub(crate) other_params_support: u8,
+
+    pub(crate) base_asym_algo: u32,
+    pub(crate) base_hash_algo: u32,
+
+    pub(crate) ext_asym_count: u8,
+    pub(crate) ext_hash_count: u8,
+    pub(crate) mel_specification: u8,
+    // ext_asym
+    // ext_hash
+    // resp_alg_struct
+}
+
+impl NegotiateAlgsReq {
+    pub(crate) const WIRE_SIZE: usize = mem::size_of::<SpdmHeader>() + 28;
+
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        out.extend_from_slice(&self.length.to_le_bytes(), GFP_KERNEL)?;
+        out.push(self.measurement_specification, GFP_KERNEL)?;
+        out.push(self.other_params_support, GFP_KERNEL)?;
+
+        out.extend_from_slice(&self.base_asym_algo.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&self.base_hash_algo.to_le_bytes(), GFP_KERNEL)?;
+
+        out.extend_from_slice(&[0u8; 12], GFP_KERNEL)?;
+
+        out.push(self.ext_asym_count, GFP_KERNEL)?;
+        out.push(self.ext_hash_count, GFP_KERNEL)?;
+        out.push(0u8, GFP_KERNEL)?;
+        out.push(self.mel_specification, GFP_KERNEL)?;
+
+        Ok(out)
+    }
+}
+
+impl Default for NegotiateAlgsReq {
+    fn default() -> Self {
+        NegotiateAlgsReq {
+            header: SpdmHeader::new(SPDM_NEGOTIATE_ALGS),
+
+            length: 32,
+            measurement_specification: SPDM_MEAS_SPEC_DMTF,
+            other_params_support: 0,
+            base_asym_algo: SPDM_ASYM_ALGOS,
+            base_hash_algo: SPDM_HASH_ALGOS,
+            ext_asym_count: 0,
+            ext_hash_count: 0,
+            mel_specification: 0,
+        }
+    }
+}
+
+/// Size of  everything up to the variable-length algorithm arrays (ExtAsymSel).
+pub(crate) const NEGOTIATE_ALGS_RSP_SZ: usize = mem::size_of::<SpdmHeader>() + 32;
+
+#[expect(dead_code)]
+pub(crate) struct NegotiateAlgsRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) measurement_specification_sel: u8,
+    pub(crate) other_params_sel: u8,
+
+    pub(crate) measurement_hash_algo: u32,
+    pub(crate) base_asym_sel: u32,
+    pub(crate) base_hash_sel: u32,
+
+    pub(crate) mel_specification_sel: u8,
+    pub(crate) ext_asym_sel_count: u8,
+    pub(crate) ext_hash_sel_count: u8,
+
+    pub(crate) ext_asym: KVec<u32>,
+    pub(crate) ext_hash: KVec<u32>,
+    pub(crate) resp_alg_struct: KVec<RespAlgStruct>,
+
+    /// Size of the response, not public
+    length: usize,
+}
+
+impl NegotiateAlgsRsp {
+    #[expect(dead_code)]
+    pub(crate) fn len(&self) -> usize {
+        self.length
+    }
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for NegotiateAlgsRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState<'c>;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
+
+        if header.code != SPDM_NEGOTIATE_ALGS - 0x80 {
+            return Err(EINVAL);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let resp_len = u16::from_le_bytes(
+            unvalidated
+                .get(4..4 + mem::size_of::<u16>())
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+
+        let measurement_specification_sel = *unvalidated.get(6).ok_or(EIO)?;
+        let other_params_sel = *unvalidated.get(7).ok_or(EIO)?;
+
+        // Helper to read a little-endian `u32`
+        let read_le32 = |offset: usize| -> Result<u32, Error> {
+            Ok(u32::from_le_bytes(
+                unvalidated
+                    .get(offset..offset + mem::size_of::<u32>())
+                    .ok_or(EIO)?
+                    .try_into()
+                    .map_err(|_| EINVAL)?,
+            ))
+        };
+
+        let measurement_hash_algo = read_le32(8)?;
+        let base_asym_sel = read_le32(12)?;
+        let base_hash_sel = read_le32(16)?;
+
+        let mel_specification_sel = *unvalidated.get(31).ok_or(EIO)?;
+        let ext_asym_sel_count = *unvalidated.get(32).ok_or(EIO)?;
+        let ext_hash_sel_count = *unvalidated.get(33).ok_or(EIO)?;
+
+        let mut offset = NEGOTIATE_ALGS_RSP_SZ;
+
+        let mut ext_asym = KVec::new();
+        for _ in 0..ext_asym_sel_count {
+            ext_asym.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut ext_hash = KVec::new();
+        for _ in 0..ext_hash_sel_count {
+            ext_hash.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut resp_alg_struct = KVec::new();
+        for _ in 0..header.param1 {
+            let alg_type = *unvalidated.get(offset).ok_or(EIO)?;
+            let alg_count = *unvalidated.get(offset + 1).ok_or(EIO)?;
+            let fixed_alg_count = (alg_count & 0xf) as usize;
+            let ext_alg_count = (alg_count >> 4) as usize;
+            offset += 2;
+
+            let mut alg_supported = KVec::new();
+            alg_supported.extend_from_slice(
+                unvalidated
+                    .get(offset..offset + fixed_alg_count)
+                    .ok_or(EIO)?,
+                GFP_KERNEL,
+            )?;
+            offset += fixed_alg_count;
+
+            let mut alg_external = KVec::new();
+            for _ in 0..ext_alg_count {
+                alg_external.push(read_le32(offset)?, GFP_KERNEL)?;
+                offset += mem::size_of::<u32>();
+            }
+
+            resp_alg_struct.push(
+                RespAlgStruct {
+                    alg_type,
+                    alg_count,
+                    alg_supported,
+                    alg_external,
+                },
+                GFP_KERNEL,
+            )?;
+        }
+
+        if resp_len != offset as u16 {
+            pr_err!("Incorrect response length reported\n");
+            return Err(EPROTO);
+        }
+
+        Ok(NegotiateAlgsRsp {
+            header,
+            measurement_specification_sel,
+            other_params_sel,
+            measurement_hash_algo,
+            base_asym_sel,
+            base_hash_sel,
+            mel_specification_sel,
+            ext_asym_sel_count,
+            ext_hash_sel_count,
+            ext_asym,
+            ext_hash,
+            resp_alg_struct,
+            length: offset,
+        })
+    }
+}
-- 
2.55.0

