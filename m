Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD003264FD
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558456; cv=none; b=PwNKbSv6MVETcwYAVjM1gRV2QQgnwzS8sA70klmIHfDTTXvXWjyUWFFIxnPOy9lJWgQuGBa0nCjVFk6jXjOaew/7UP0VM2KVTmefmsOaUb+wpMuUOD7X6KEWNigeuYm+5amvyoKFGi+t84Eqt+FbvW/MzImVm4pEN4FgkIAFlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558456; c=relaxed/simple;
	bh=pabOeosSWMU9M1rzRU+bWUkg0CpGXv4hE027wKrT3gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQfukp+CwpgqbINqydKgBg4mWhii4iUX07z72W3tpFtNCX/TLJCN1wiGiD30OwK9r6u8P3JrUGmcqzbksCaBDxY8QfLuJqlr6NWOzHtVAx+haahFV4EwOMo0LockqmgHddBh3RcpbvrEphSLZcXpG16kDfk3MkOmfqLQXsYjSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfgvYv8P; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfgvYv8P"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0df0bb2d6so843729a91.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558454; x=1791163254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+4cD82D480m1fv/g5FMu9AjvBoGSNDXP4ZPsfJiWeUE=;
        b=WfgvYv8PD25HKj2Xu4urdS2IuwASAZ19oQTSSe9+F44yr0Pn/Ccg7+Mjowig05lG34
         0MWqJ0o6DTCysM0cA6OrRUhQcPwkT+i2Lsg9qeZlluYuYTdv22DMbUm83whnwtzv8Qf7
         8K5TBMys7avpiHkFCpId45RN65UB72OXt28qFLl2toR10daaoeU/cBPed4uxYeqtZvB5
         nzw2CIZ7j3OWldR3WWj5OKaFZ0XmiFvdGHx2bNFmneUOrpYj5Eelc4zxPq9apBx2xqCh
         RNU1RFcW424JLP6G3KQ8t97EYV43P92E2RQew2NWSoAuTW2Jht7qHgTvMXSX4Qtg8CkI
         WwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558454; x=1791163254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+4cD82D480m1fv/g5FMu9AjvBoGSNDXP4ZPsfJiWeUE=;
        b=XjqWHP1qiLWqyknwygXZUKA/7xEHsc3Cjxq4aFyXLU1XLV4w6u9P+OTra+A4RP0mJu
         EOwpYgx1Msxua/EodKnyyKK1rhUjJV+I3BkCqMg1+AklDa9DnjVSfOnJfKP8DsmzqRMp
         iRAX9LaKKmStuyH8nEw/44FjISpWbyyw5n+ac7y6cNJZR3VZyZWq0EE1U++VLWN7TbfN
         KeW7I5aX2/poSJBnAXTY+GfhPQxbe8tKVGnkm3Q3CEyxj76/gcxd/cJkSE94SuDnxcou
         JvvfpnlWNuRiFFlwnqO26WnvQujmQwA4WvFIbL2SADN5vmeUwk4KHrbemVu+1GnNhauL
         dBow==
X-Forwarded-Encrypted: i=1; AKwUvBz0c3YhlDnGLJFUZd0DZMDABqiYo9CqRb7/B+mHoNdYdjSp3NnNYMrusrOhGOvmtzzFat1RK/GjcCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzZHJKIF6ijWkpXXP8yABlpUTs+/q3AVuhsdPqe0mJcF4D7fa2
	0WnhnZh9daJxH24tAKPj/JnCm4Wfe4w3Znx829sV5Q09CqPJP+oJqzuQ
X-Gm-Gg: AYBFou3cbnB/JtjAZ16QzBR0rvWCoatq6xIbiXLAafO2vQmqHj1M1U2oyVjAV+xyrja
	5EHogTaG8S9cIHG1w/yLjK1Yp796xZJQ1enaSop/LN+VGZWfUIiF0VvF+2XEDC/lQa4jeNjLkk+
	nG5De0vYkF82kuAYgGnkgpyx/ddTFxu3SM62MgoyIOo8MwqPy3zt/wYpL4Q2SXj7fwThxOGnLMf
	mRb3sbTNdPNmvchXQu2veswjWH8JP4J2M4J9FGERsdaMVUJbAUV5ER9Bq+NCpwkt+9Q/Iwbdp2Z
	lXyyk9Oq259o2SzyR/64GIcFxBmQYlIh1TMRjbw/vnDWTtPSpxgjYNQmwNU5rqhzxnZQPuElhFP
	KgU4FuKS0AkiZbqmiSobZbgIVxM/17LSuAhowsllSzfw5rUZDlOoiS2kwl6exK4J9UQcbML4lR5
	qhrI4b/EW5mqtTGbJTwxgwn4oBfrLZOR1AjYN1psqCYyJL4P7TR8zkfOx6ab9HL2mLKIHZF+bI0
	aQYDMLcQdZXJ9Ab
X-Received: by 2002:a17:90b:1cc8:b0:3a2:b036:ed62 with SMTP id 98e67ed59e1d1-3a2b036f440mr1083821a91.37.1790558453486;
        Sun, 27 Sep 2026 18:20:53 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e151be04sm11010527a91.9.2026.09.27.18.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:20:52 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	djbw@kernel.org,
	alistair@alistair23.me,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	benno.lossin@proton.me,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	a.hindborg@kernel.org
Subject: [PATCH v4 22/22] lib: rspdm: Support SPDM challenge
Date: Mon, 28 Sep 2026 11:20:21 +1000
Message-ID: <20260928012021.484003-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928012021.484003-1-alistair.francis@wdc.com>
References: <20260928012021.484003-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

Support the CHALLENGE SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs             |   6 +
 lib/rspdm/lib.rs                |  10 +-
 lib/rspdm/state.rs              | 215 +++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs          | 153 ++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |   1 +
 5 files changed, 375 insertions(+), 10 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 234534c7aa6d..d4d743f260c6 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -150,6 +150,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
 
+pub(crate) const SPDM_CHALLENGE: u8 = 0x83;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
@@ -178,3 +180,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_HASH_ALGOS: u32 = SPDM_HASH_SHA2_256 | SPDM_HASH_SHA2_384_512;
 
 pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
+
+pub(crate) const SPDM_PREFIX_SZ: usize = 64;
+pub(crate) const SPDM_COMBINED_PREFIX_SZ: usize = 100;
+pub(crate) const SPDM_MAX_OPAQUE_DATA: usize = 1024;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 50ff92741086..e555c565faae 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -11,8 +11,7 @@
 //! from other subsytems.
 
 use crate::bindings::{
-    spdm_state,
-    EPROTONOSUPPORT, //
+    spdm_state, //
 };
 use core::ffi::{
     c_int,
@@ -136,7 +135,12 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         provisioned_slots &= !(1 << slot);
     }
 
-    -(EPROTONOSUPPORT as i32)
+    let provisioned_slots = state.provisioned_slots.trailing_zeros();
+    if let Err(e) = state.challenge(provisioned_slots as u8) {
+        return e.to_errno() as c_int;
+    }
+
+    0
 }
 
 /// spdm_destroy() - Destroy SPDM session
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 9f7f6d0ffac6..d6ece65a6fc0 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -18,6 +18,7 @@
         Error, //
     },
     str::CStr,
+    str::CString,
     validate::Untrusted,
 };
 
@@ -30,6 +31,7 @@
     SPDM_ASYM_RSASSA_2048,
     SPDM_ASYM_RSASSA_3072,
     SPDM_ASYM_RSASSA_4096,
+    SPDM_COMBINED_PREFIX_SZ,
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
     SPDM_HASH_ALGOS,
@@ -37,10 +39,12 @@
     SPDM_HASH_SHA_384,
     SPDM_HASH_SHA_512,
     SPDM_KEY_EX_CAP,
+    SPDM_MAX_OPAQUE_DATA,
     SPDM_MAX_VER,
     SPDM_MEAS_RESP_CAP,
     SPDM_MIN_VER,
     SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_PREFIX_SZ,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_SLOTS,
@@ -50,6 +54,8 @@
     SPDM_VER_13, //
 };
 use crate::validator::{
+    ChallengeReq,
+    ChallengeRsp,
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
     GetCertificateReq,
@@ -69,6 +75,8 @@
     SPDM_CERT_CHAIN_HDR_SZ, //
 };
 
+const SPDM_CONTEXT: &str = "responder-challenge_auth signing";
+
 /// The current SPDM session state for a device.
 ///
 /// Concurrent access is serialised by wrapping the whole struct in a
@@ -119,6 +127,12 @@
 ///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
 /// @leaf_key: Public key portion of leaf certificate against which to check
 ///  responder's signatures.
+/// @transcript: Concatenation of all SPDM messages exchanged during an
+///  authentication or measurement sequence.  Used to verify the signature,
+///  as it is computed over the hashed transcript.
+/// @next_nonce: Requester nonce to be used for the next authentication
+///  sequence.  Populated from user space through sysfs.
+///  If user space does not provide a nonce, the kernel uses a random one.
 pub(crate) struct SpdmState<'a> {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -137,7 +151,7 @@ pub(crate) struct SpdmState<'a> {
 
     /* Signature algorithm */
     base_asym_enc: &'a CStr,
-    sig_len: usize,
+    pub(crate) sig_len: usize,
 
     /* Hash algorithm */
     base_hash_alg_name: &'a CStr,
@@ -148,6 +162,10 @@ pub(crate) struct SpdmState<'a> {
     // Certificates
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
     pub(crate) leaf_key: Option<*mut bindings::public_key>,
+
+    transcript: VVec<u8>,
+
+    pub(crate) next_nonce: KVec<u8>,
 }
 
 impl Drop for SpdmState<'_> {
@@ -198,6 +216,8 @@ pub(crate) fn new(
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
             leaf_key: None,
+            transcript: VVec::new(),
+            next_nonce: KVec::new(),
         }
     }
 
@@ -329,13 +349,15 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
     pub(crate) fn spdm_exchange(
-        &self,
+        &mut self,
         request_buf: &mut [u8],
         response_buf: &mut [u8],
     ) -> Result<i32, Error> {
         let header_size = core::mem::size_of::<SpdmHeader>();
         let request: SpdmHeader = Untrusted::new(&request_buf[..]).validate(&*self)?;
 
+        self.transcript.extend_from_slice(request_buf, GFP_KERNEL)?;
+
         let transport_function = self.transport.ok_or(EINVAL)?;
         // SAFETY: `transport_function` is provided by the new(), we are
         // calling the function.
@@ -385,6 +407,18 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         request.header.version = SPDM_MIN_VER;
         self.version = SPDM_MIN_VER;
 
+        self.transcript.clear();
+
+        // Clear the leaf cert as we are re-authenticating
+        if let Some(leaf_key) = self.leaf_key.take() {
+            // SAFETY: `leaf_key` was extracted from a x509 certificate
+            // in `validate_cert_chain()` so it is valid to pass to
+            // `public_key_free()`.
+            unsafe {
+                bindings::public_key_free(leaf_key);
+            }
+        }
+
         let mut request_buf = request.to_bytes()?;
 
         let mut response_vec: KVec<u8> = KVec::from_elem(0u8, SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
@@ -400,6 +434,9 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
         let response: GetVersionRsp = Untrusted::new(response_vec.as_slice()).validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response_vec.get(..response.len()).ok_or(EIO)?, GFP_KERNEL)?;
+
         let mut foundver = false;
         for &entry in response.version_number_entries.iter() {
             let alpha_version = (entry & 0xF) as u8;
@@ -452,7 +489,11 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
         let response: GetCapabilitiesRsp =
             Untrusted::new(response_vec.as_slice()).validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response_vec.get(..response.len()).ok_or(EIO)?, GFP_KERNEL)?;
+
         self.rsp_caps = response.flags;
+
         if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
             pr_err!(
                 "{:#x} capabilities are supported, which don't meet required {:#x}\n",
@@ -601,6 +642,9 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
         let response: NegotiateAlgsRsp =
             Untrusted::new(response_vec.as_slice()).validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response_vec.get(..response.len()).ok_or(EIO)?, GFP_KERNEL)?;
+
         self.base_asym_alg = response.base_asym_sel;
         self.base_hash_alg = response.base_hash_sel;
         self.meas_hash_alg = response.measurement_hash_algo;
@@ -652,6 +696,9 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         let response: GetDigestsRsp = Untrusted::new(response_vec.as_slice()).validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response_vec.get(..response.len()).ok_or(EIO)?, GFP_KERNEL)?;
+
         let mut deprovisioned_slots = self.provisioned_slots & !response.header.param2;
         while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
             let slot = deprovisioned_slots.trailing_zeros() as usize;
@@ -683,6 +730,9 @@ fn get_cert_exchange(
         let response: GetCertificateRsp =
             Untrusted::new(response_vec.as_slice()).validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response_vec.get(..response.len()).ok_or(EIO)?, GFP_KERNEL)?;
+
         Ok(response)
     }
 
@@ -907,4 +957,165 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
+        // No measurement summary hash requested (MSHLength == 0)
+        let mut length =
+            core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len + opaque_len + 2;
+
+        if self.version >= SPDM_VER_13 {
+            length += 8;
+        }
+
+        length + self.sig_len
+    }
+
+    fn verify_signature(&mut self, signature: &mut [u8]) -> Result<(), Error> {
+        let mut sig = bindings::public_key_signature::default();
+
+        sig.s = signature as *mut _ as *mut u8;
+        sig.s_size = self.sig_len as u32;
+        sig.encoding = self.base_asym_enc.as_ptr() as *const u8;
+        sig.hash_algo = self.base_hash_alg_name.as_ptr() as *const u8;
+
+        let mut m: KVec<u8> = KVec::new();
+        m.extend_with(SPDM_COMBINED_PREFIX_SZ + self.hash_len, 0, GFP_KERNEL)?;
+
+        if !self.desc.is_null() {
+            unsafe { (*self.desc).tfm = self.shash };
+
+            // Generate the `unverified_message_hash`, which is the the hash of
+            // the `unverified_data` (Chapter 16 - "Signature Verification")
+            unsafe {
+                to_result(bindings::crypto_shash_digest(
+                    self.desc,
+                    self.transcript.as_ptr(),
+                    (self.transcript.len() - self.sig_len) as u32,
+                    m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr(),
+                ))?;
+            };
+        } else {
+            return Err(EPROTO);
+        }
+
+        // Must be in scope whenenver `sig` is used
+        let mut mhash: KVec<u8> = KVec::new();
+
+        if self.version <= SPDM_VER_11 {
+            sig.m = m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr();
+        } else {
+            let major = self.version >> 4;
+            let minor = self.version & 0xF;
+
+            // Generate the `spdm_prefix` (Chapter 15 - "Signature generation")
+            let prefix = CString::try_from_fmt(fmt!("dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;
+            let mut buf = prefix.into_vec();
+            let zero_pad_len = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - SPDM_CONTEXT.len() - 1;
+
+            // Copy in the `zero_pad` and `spdm_context` to form the `combined_spdm_prefix`
+            // (Chapter 15 - "Signature generation")
+            buf.extend_with(zero_pad_len, 0, GFP_KERNEL)?;
+            buf.extend_from_slice(SPDM_CONTEXT.as_bytes(), GFP_KERNEL)?;
+
+            // The `combined_spdm_prefix` must be 100 bytes
+            // (Chapter 15 - "Signature generation")
+            if buf.len() != SPDM_COMBINED_PREFIX_SZ {
+                pr_err!("combined_spdm_prefix calculation is incorrect");
+                return Err(EPROTO);
+            }
+
+            // `M` shall be the concatenation of the `combined_spdm_prefix`
+            // and `unverified_message_hash`. We use `M` for pub/priv
+            // signature verification below.
+            // (Chapter 16 - "Signature Verification")
+            m[..SPDM_COMBINED_PREFIX_SZ].copy_from_slice(&buf);
+
+            if !self.desc.is_null() {
+                unsafe { (*self.desc).tfm = self.shash };
+                // Generate a hash of `M` and use that for signature
+                // verification (RSA or ECDSA)
+                mhash.extend_with(self.hash_len, 0, GFP_KERNEL)?;
+
+                unsafe {
+                    to_result(bindings::crypto_shash_digest(
+                        self.desc,
+                        m.as_ptr(),
+                        m.len() as u32,
+                        mhash.as_mut_ptr(),
+                    ))?;
+                };
+            } else {
+                return Err(EPROTO);
+            }
+
+            sig.m = mhash.as_mut_ptr();
+        }
+
+        sig.m_size = self.hash_len as u32;
+
+        // Finally verify the generated signature against the public key
+        if let Some(leaf_key) = self.leaf_key {
+            unsafe { to_result(bindings::public_key_verify_signature(leaf_key, &sig)) }
+        } else {
+            return Err(EPROTO);
+        }
+    }
+
+    pub(crate) fn challenge(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = ChallengeReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        let nonce_len = request.nonce.len();
+
+        if self.next_nonce.len() > 0 {
+            let request_nonce_len = request.nonce.len();
+
+            if self.next_nonce.len() == request_nonce_len {
+                request
+                    .nonce
+                    .copy_from_slice(&self.next_nonce[..request_nonce_len]);
+            } else {
+                return Err(EINVAL);
+            }
+
+            self.next_nonce.clear();
+        } else {
+            unsafe {
+                bindings::get_random_bytes(&mut request.nonce as *mut _ as *mut c_void, nonce_len)
+            };
+        }
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE_DATA);
+
+        let mut request_buf = request.to_bytes()?;
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let rc =
+            self.spdm_exchange(request_buf.as_mut_slice(), response_vec.as_mut_slice())? as usize;
+        response_vec.truncate(rc);
+
+        let mut response: ChallengeRsp =
+            Untrusted::new(response_vec.as_slice()).validate(&*self)?;
+
+        if request.context != response.context {
+            pr_err!("Mismatched challenge context response\n");
+            return Err(EIO);
+        }
+
+        self.transcript
+            .extend_from_slice(response_vec.get(..response.len()).ok_or(EIO)?, GFP_KERNEL)?;
+
+        match self.verify_signature(&mut response.signature) {
+            Ok(()) => {
+                pr_info!("Authenticated with certificate slot {slot}\n");
+                Ok(())
+            }
+            Err(e) => {
+                pr_err!("Cannot verify challenge_auth signature: {e:?}\n");
+                Err(EPROTO)
+            }
+        }
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index f4e9485179d0..9992679f7c8a 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -24,12 +24,14 @@
 use crate::consts::{
     SPDM_ASYM_ALGOS,
     SPDM_CAP_SUPPORTED_ALGORITHMS,
+    SPDM_CHALLENGE,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
+    SPDM_MAX_OPAQUE_DATA,
     SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
@@ -142,7 +144,6 @@ pub(crate) struct GetVersionRsp {
 }
 
 impl GetVersionRsp {
-    #[expect(dead_code)]
     pub(crate) fn len(&self) -> usize {
         self.length
     }
@@ -395,7 +396,6 @@ pub(crate) struct GetCapabilitiesRsp {
 }
 
 impl GetCapabilitiesRsp {
-    #[expect(dead_code)]
     pub(crate) fn len(&self) -> usize {
         self.length
     }
@@ -577,7 +577,6 @@ pub(crate) struct NegotiateAlgsRsp {
 }
 
 impl NegotiateAlgsRsp {
-    #[expect(dead_code)]
     pub(crate) fn len(&self) -> usize {
         self.length
     }
@@ -736,7 +735,6 @@ pub(crate) struct GetDigestsRsp {
 }
 
 impl GetDigestsRsp {
-    #[expect(dead_code)]
     pub(crate) fn len(&self) -> usize {
         self.length
     }
@@ -893,7 +891,6 @@ pub(crate) struct GetCertificateRsp {
 }
 
 impl GetCertificateRsp {
-    #[expect(dead_code)]
     pub(crate) fn len(&self) -> usize {
         self.length
     }
@@ -946,3 +943,149 @@ fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self
         })
     }
 }
+
+pub(crate) struct ChallengeReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) nonce: [u8; 32],
+    pub(crate) context: [u8; 8],
+}
+
+impl ChallengeReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        out.extend_from_slice(&self.nonce, GFP_KERNEL)?;
+
+        if self.header.version > SPDM_VER_12 {
+            out.extend_from_slice(&self.context, GFP_KERNEL)?;
+        }
+
+        Ok(out)
+    }
+}
+
+impl Default for ChallengeReq {
+    fn default() -> Self {
+        ChallengeReq {
+            header: SpdmHeader::new(SPDM_CHALLENGE),
+
+            nonce: [0; 32],
+            context: [0; 8],
+        }
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct ChallengeRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) cert_chain_hash: KVec<u8>,
+    pub(crate) nonce: [u8; 32],
+
+    pub(crate) opaque_data_len: u16,
+    pub(crate) opaque_data: KVec<u8>,
+
+    /// `RequesterContext`, only present in SPDM 1.3 and later, zeroed otherwise.
+    pub(crate) context: [u8; 8],
+
+    pub(crate) signature: KVec<u8>,
+
+    /// Size of the response, not public
+    length: usize,
+}
+
+impl ChallengeRsp {
+    pub(crate) fn len(&self) -> usize {
+        self.length
+    }
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for ChallengeRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState<'c>;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
+
+        if header.code != SPDM_CHALLENGE - 0x80 {
+            return Err(EINVAL);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let hash_len = context.hash_len;
+
+        let nonce_offset = mem::size_of::<SpdmHeader>() + hash_len;
+        // MSHLength (H) is always zero as we don't support it
+        let opaque_len_offset = nonce_offset + 32;
+        let opaque_offset = opaque_len_offset + 2;
+
+        let mut cert_chain_hash = KVec::new();
+        cert_chain_hash.extend_from_slice(
+            unvalidated
+                .get(mem::size_of::<SpdmHeader>()..nonce_offset)
+                .ok_or(EIO)?,
+            GFP_KERNEL,
+        )?;
+
+        let mut nonce = [0u8; 32];
+        nonce.copy_from_slice(
+            unvalidated
+                .get(nonce_offset..nonce_offset + 32)
+                .ok_or(EIO)?,
+        );
+
+        let opaque_data_len = u16::from_le_bytes(
+            unvalidated
+                .get(opaque_len_offset..opaque_len_offset + 2)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+
+        if opaque_data_len > SPDM_MAX_OPAQUE_DATA as u16 {
+            return Err(EINVAL);
+        }
+
+        let opaque_end = opaque_offset + opaque_data_len as usize;
+        let mut opaque_data = KVec::new();
+        opaque_data.extend_from_slice(
+            unvalidated.get(opaque_offset..opaque_end).ok_or(EIO)?,
+            GFP_KERNEL,
+        )?;
+
+        // `RequesterContext` (8 bytes) is only present in SPDM 1.3 and later.
+        let mut req_context = [0u8; 8];
+        let context_end;
+        if context.version >= SPDM_VER_13 {
+            context_end = opaque_end + 8;
+            req_context.copy_from_slice(unvalidated.get(opaque_end..context_end).ok_or(EIO)?);
+        } else {
+            context_end = opaque_end;
+        }
+
+        let signature_end = context_end + context.sig_len;
+        let mut signature = KVec::new();
+        signature.extend_from_slice(
+            unvalidated.get(context_end..signature_end).ok_or(EIO)?,
+            GFP_KERNEL,
+        )?;
+
+        Ok(ChallengeRsp {
+            header,
+            cert_chain_hash,
+            nonce,
+            opaque_data_len,
+            opaque_data,
+            context: req_context,
+            signature,
+            length: signature_end,
+        })
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5cc71552b524..f3d3f6e9f60a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <crypto/hash.h>
+#include <crypto/public_key.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
-- 
2.55.0

