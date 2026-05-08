Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4B2F83A0
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210381; cv=none; b=Lk46zMmHMrxEypOSnjGaigVyS2LGGrjUcWmr4+Bx8kbHeDDGlO8XOKEkNXpPwdcKcNfGVuLTRjIa7FEuX6s3tzAihTYeu/TUZxdStOTsh4H3WShv80dnkqG9rqEdG66O0k/30UTJr1GeV8cFRVin7MujbXTD5QWHrhvxhDP9JF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210381; c=relaxed/simple;
	bh=48LvjpVIfzqjq0xGyaF+qPR4OSFXmF4Q/GbzHzxPS+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBUEDT6WxaJslUM7zN9OUekhMcAVWIIkBlicb3OYyWynpe5d4JYRWzCvduNDgC7Qdp1QQcXUgUXtPVRVyPgsrfpEvDHE7T8bF/9TQOk2U1V89FrMQ6OvTQpCh84ou0fCLX21/jqesLciNRHSwpOq12eXNhNwjV8FkljtcKP0Nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plWTWO3o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plWTWO3o"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b458ca2296so9970715ad.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210379; x=1778815179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pprsevTDOKLZVgl88a8cDB8UwOK0KvhkdrcSb/4STD4=;
        b=plWTWO3ouZ2OFZF9f3MfW+mFw+xX8jGk6Ci/BYA53GTUZexHVkel8cEloM7Fcw2sG5
         5DDq1OQyyiNJ3wOltYRMa2R15q8FK1l20SUKr0G8zY4ai6s9+umvLKPY8xkxgppxPM9x
         TmsfCWGq5GcdYlZ54+VRWxr6/Plg2MNqWYNj4aTGTfX7WNuHreM2j2ypFd0MFfrjK9ZV
         fSzQR2VYbP5cOPP6h+eNYJp4vyhUQPhkDoc3PsfNUaLHjJkhhQbgP3OHUTqMijBaIfDC
         R5d2QYRuQQ29M/IzB7cp55yPDK8pBsxtxksmg9eQQ5goMKqm6yXt7l06owVI+zj20kw8
         mOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210379; x=1778815179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pprsevTDOKLZVgl88a8cDB8UwOK0KvhkdrcSb/4STD4=;
        b=rqtoQAylEYK0hzakv+fdnTvfiVtlY9E30uDoxapuRcdXjgwBwa4PlF2RthZGIk4xq3
         agmG0LSsX/PwGoUOaEnuCUuxQq5NlQldQeCnZ/gzwdWlLvGlJEDfQEzXcHDD4D24K/2U
         zeg1gaWgvOT25Eu/WJ8p/oICSOpFUyp6iK7zSD1CCFKWuEL+ets9JVD/Abn33Z+31YfU
         1e7v8jgfxILonQV9eyJq8bdbxRXQXDgVHFGI5a2e+NrpCSRDvVijt/z3BrEq7TE8ri3u
         vOiGtN5B3sFizwZDntc1dHrU2gHRtueFlZGXSK4/+oFJGaAO/IBMXDawLcg0RC1DdSjl
         jWOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dvvh3SCRh4+jzzWsuFda47NJH9oy2yxeq7O0D3DBs9E5rmLvbpq22a5jFLsLkvgiVzi+jOlgZ8K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnPKniEDo/YA4wM0PjfdrfeFdHv/3u7h1qDq7np3jKrCtB+dl
	qwjB3ejGGdJRJYSSWIiPpmwX3pjPxsyM0x8gc/+9KpdtrkQd6O6fPkWw
X-Gm-Gg: Acq92OGiKsk4HFq8vVORzfQzrKbj7j3EsiRIHYWPRDfRV+55E6EU7J2I2XpzWBfbu3g
	P5kPXkoxxpdUBLBdMaiC+2lH/w+xHKD82Kdi3X/q9/AESKHxXr5KZQYMvXFXW9htyOZfu2Gz6gg
	L4+9n/iUzX85Co68XApzSz5ASTrK8wggkmV0ejsnFZ66q5H2DEZjE4+KsEewaPPGvYwHPeLb5Ft
	lD0whMjtxq7rwFxvAGS9qJZ7GGKTJNjALHc7ZJyg4K+qVYkRL/IoiAg6KOxGOXh2JpXuEVLp3PQ
	JGvFXVVr0GqxNJguaJzuVOsiKHuefb57j1TZ/0253ksx2QAFs2GXAVUgZiPXAwXVSdFFlTMxD2q
	DcNtGN5yh5lHLq2jR5iPL3ufaK/y8XzngsX6v/qGEUXPC+Sn36wzoog5geITZL2fGXs1mhcVaCk
	yXNBtC72bckBmFOVRDKj+nTbOQZP3lPKqnBksWA9o2TmafTaiMnAs=
X-Received: by 2002:a17:903:1b28:b0:2ba:881f:6192 with SMTP id d9443c01a7336-2baf0dd629cmr8678865ad.22.1778210378477;
        Thu, 07 May 2026 20:19:38 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:19:38 -0700 (PDT)
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
Subject: [PATCH 18/18] lib: rspdm: Support SPDM challenge
Date: Fri,  8 May 2026 13:17:10 +1000
Message-ID: <20260508031710.514574-19-alistair.francis@wdc.com>
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

Support the CHALLENGE SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs             |   6 +
 lib/rspdm/lib.rs                |   8 +-
 lib/rspdm/state.rs              | 216 +++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs          |  62 +++++++++
 rust/bindings/bindings_helper.h |   1 +
 5 files changed, 291 insertions(+), 2 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 302bc0285478..9d41928da0c6 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -116,6 +116,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
 
+pub(crate) const SPDM_CHALLENGE: u8 = 0x83;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
@@ -147,3 +149,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 // pub(crate) const SPDM_MAX_REQ_ALG_STRUCT: usize = 4;
 
 pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
+
+pub(crate) const SPDM_PREFIX_SZ: usize = 64;
+pub(crate) const SPDM_COMBINED_PREFIX_SZ: usize = 100;
+pub(crate) const SPDM_MAX_OPAQUE_DATA: usize = 1024;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index d6421b2fab7d..7fcf5a2d3071 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -135,17 +135,23 @@
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut verify = true;
     let mut provisioned_slots = state.provisioned_slots;
     while (provisioned_slots as usize) > 0 {
         let slot = provisioned_slots.trailing_zeros() as u8;
 
         if let Err(e) = state.validate_cert_chain(slot) {
-            return e.to_errno() as c_int;
+            pr_err!("Certificate in slot {slot} failed to verify: {e:?}");
+            verify = false;
         }
 
         provisioned_slots &= !(1 << slot);
     }
 
+    if let Err(e) = state.challenge(state.provisioned_slots.trailing_zeros() as u8, verify) {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 4c8ee553bb69..3cf7236af7b2 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -8,6 +8,7 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
 use core::ffi::c_void;
+use core::mem::offset_of;
 use core::slice::from_raw_parts_mut;
 use kernel::prelude::*;
 use kernel::{
@@ -19,6 +20,7 @@
         Error, //
     },
     str::CStr,
+    str::CString,
     validate::Untrusted,
 };
 
@@ -31,6 +33,7 @@
     SPDM_ASYM_RSASSA_2048,
     SPDM_ASYM_RSASSA_3072,
     SPDM_ASYM_RSASSA_4096,
+    SPDM_COMBINED_PREFIX_SZ,
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
     SPDM_HASH_ALGOS,
@@ -38,12 +41,14 @@
     SPDM_HASH_SHA_384,
     SPDM_HASH_SHA_512,
     SPDM_KEY_EX_CAP,
+    SPDM_MAX_OPAQUE_DATA,
     SPDM_MAX_VER,
     SPDM_MEAS_CAP_MASK,
     SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
     SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_PREFIX_SZ,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_SLOTS,
@@ -53,6 +58,8 @@
     SPDM_VER_13, //
 };
 use crate::validator::{
+    ChallengeReq,
+    ChallengeRsp,
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
     GetCertificateReq,
@@ -67,6 +74,8 @@
     SpdmHeader, //
 };
 
+const SPDM_CONTEXT: &str = "responder-challenge_auth signing";
+
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
 ///
@@ -108,6 +117,14 @@
 ///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
 /// @leaf_key: Public key portion of leaf certificate against which to check
 ///  responder's signatures.
+/// @transcript: Concatenation of all SPDM messages exchanged during an
+///  authentication or measurement sequence.  Used to verify the signature,
+///  as it is computed over the hashed transcript.
+/// @next_nonce: Requester nonce to be used for the next authentication
+///  sequence.  Populated from user space through sysfs.
+///  If user space does not provide a nonce, the kernel uses a random one.
+///
+/// `authenticated`: Whether device was authenticated successfully.
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -134,9 +151,15 @@ pub struct SpdmState {
     pub(crate) desc: Option<&'static mut bindings::shash_desc>,
     pub(crate) hash_len: usize,
 
+    pub(crate) authenticated: bool,
+
     // Certificates
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
     pub(crate) leaf_key: Option<*mut bindings::public_key>,
+
+    transcript: VVec<u8>,
+
+    pub(crate) next_nonce: KVec<u8>,
 }
 
 #[repr(C, packed)]
@@ -174,8 +197,11 @@ pub(crate) fn new(
             shash: core::ptr::null_mut(),
             desc: None,
             hash_len: 0,
+            authenticated: false,
             certs: [const { KVec::new() }; SPDM_SLOTS],
             leaf_key: None,
+            transcript: VVec::new(),
+            next_nonce: KVec::new(),
         }
     }
 
@@ -291,7 +317,7 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
     pub(crate) fn spdm_exchange(
-        &self,
+        &mut self,
         request_buf: &mut [u8],
         response_buf: &mut [u8],
     ) -> Result<i32, Error> {
@@ -299,6 +325,8 @@ pub(crate) fn spdm_exchange(
         let request: &mut SpdmHeader = Untrusted::new_mut(request_buf).validate_mut()?;
         let response: &SpdmHeader = Untrusted::new_ref(response_buf).validate()?;
 
+        self.transcript.extend_from_slice(request_buf, GFP_KERNEL)?;
+
         let transport_function = self.transport.ok_or(EINVAL)?;
         // SAFETY: `transport_function` is provided by the new(), we are
         // calling the function.
@@ -367,6 +395,12 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         unsafe { response_vec.inc_len(rc as usize) };
 
         let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>()
+            + 2
+            + response.version_number_entry_count as usize * 2;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         let mut foundver = false;
         let unaligned = core::ptr::addr_of_mut!(response.version_number_entries) as *mut u16;
@@ -438,6 +472,9 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
         let response: &mut GetCapabilitiesRsp =
             Untrusted::new_mut(&mut response_vec).validate_mut()?;
 
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
         self.rsp_caps = u32::from_le(response.flags);
         if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
             pr_err!(
@@ -576,6 +613,9 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
         let response: &mut NegotiateAlgsRsp =
             Untrusted::new_mut(&mut response_vec).validate_mut()?;
 
+        self.transcript
+            .extend_from_slice(&response_vec, GFP_KERNEL)?;
+
         self.base_asym_alg = response.base_asym_sel;
         self.base_hash_alg = response.base_hash_sel;
         self.meas_hash_alg = response.measurement_hash_algo;
@@ -637,6 +677,10 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
         unsafe { response_vec.inc_len(len as usize) };
 
         let response: &mut GetDigestsRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + response.param2 as usize * self.hash_len;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if len
             < (core::mem::size_of::<GetDigestsReq>()
@@ -697,6 +741,10 @@ fn get_cert_exchange(
         unsafe { response_vec.inc_len(rc as usize) };
 
         let response: &mut GetCertificateRsp = Untrusted::new_mut(response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + 4 + response.portion_length as usize;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if rc
             < (core::mem::size_of::<GetCertificateRsp>() + response.portion_length as usize) as i32
@@ -853,4 +901,170 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
+        // No measurement summary hash requested (MSHLength == 0)
+        let mut length =
+            core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len + opaque_len + 2;
+
+        if self.version >= 0x13 {
+            length += 8;
+        }
+
+        length + self.sig_len
+    }
+
+    fn verify_signature(&mut self, signature: &mut [u8]) -> Result<(), Error> {
+        let mut sig = bindings::public_key_signature::default();
+        let mut mhash: KVec<u8> = KVec::new();
+
+        sig.s = signature as *mut _ as *mut u8;
+        sig.s_size = self.sig_len as u32;
+        sig.encoding = self.base_asym_enc.as_ptr() as *const u8;
+        sig.hash_algo = self.base_hash_alg_name.as_ptr() as *const u8;
+
+        let mut m: KVec<u8> = KVec::new();
+        m.extend_with(SPDM_COMBINED_PREFIX_SZ + self.hash_len, 0, GFP_KERNEL)?;
+
+        if let Some(desc) = &mut self.desc {
+            desc.tfm = self.shash;
+
+            unsafe {
+                to_result(bindings::crypto_shash_digest(
+                    *desc,
+                    self.transcript.as_ptr(),
+                    (self.transcript.len() - self.sig_len) as u32,
+                    m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr(),
+                ))?;
+            };
+        } else {
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        if self.version <= 0x11 {
+            sig.m = m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr();
+        } else {
+            let major = self.version >> 4;
+            let minor = self.version & 0xF;
+
+            let output = CString::try_from_fmt(fmt!("dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;
+            let mut buf = output.into_vec();
+            let zero_pad_len = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - SPDM_CONTEXT.len() - 1;
+
+            buf.extend_with(zero_pad_len, 0, GFP_KERNEL)?;
+            buf.extend_from_slice(SPDM_CONTEXT.as_bytes(), GFP_KERNEL)?;
+
+            m[..SPDM_COMBINED_PREFIX_SZ].copy_from_slice(&buf);
+
+            mhash.extend_with(self.hash_len, 0, GFP_KERNEL)?;
+
+            if let Some(desc) = &mut self.desc {
+                desc.tfm = self.shash;
+
+                unsafe {
+                    to_result(bindings::crypto_shash_digest(
+                        *desc,
+                        m.as_ptr(),
+                        m.len() as u32,
+                        mhash.as_mut_ptr(),
+                    ))?;
+                };
+            } else {
+                to_result(-(bindings::EPROTO as i32))?;
+            }
+
+            sig.m = mhash.as_mut_ptr();
+        }
+
+        sig.m_size = self.hash_len as u32;
+
+        if let Some(leaf_key) = self.leaf_key {
+            unsafe { to_result(bindings::public_key_verify_signature(leaf_key, &sig)) }
+        } else {
+            to_result(-(bindings::EPROTO as i32))
+        }
+    }
+
+    pub(crate) fn challenge(&mut self, slot: u8, verify: bool) -> Result<(), Error> {
+        let mut request = ChallengeReq::default();
+        request.version = self.version;
+        request.param1 = slot;
+
+        let nonce_len = request.nonce.len();
+
+        if self.next_nonce.len() > 0 {
+            request.nonce.copy_from_slice(&self.next_nonce);
+            self.next_nonce.clear();
+        } else {
+            unsafe {
+                bindings::get_random_bytes(&mut request.nonce as *mut _ as *mut c_void, nonce_len)
+            };
+        }
+
+        let req_sz = if self.version <= 0x12 {
+            offset_of!(ChallengeReq, context)
+        } else {
+            core::mem::size_of::<ChallengeReq>()
+        };
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE_DATA);
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+        // SAFETY: `response_vec` is rsp_sz length, initialised, aligned
+        // and won't be mutated
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (core::mem::size_of::<ChallengeRsp>() as i32) {
+            pr_err!("Truncated challenge response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let _response: &mut ChallengeRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        // MSHLength is 0 as no measurement summary hash requested
+        let opaque_len_offset = core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len;
+        let opaque_len = u16::from_le_bytes(
+            response_vec[opaque_len_offset..(opaque_len_offset + 2)]
+                .try_into()
+                .unwrap_or([0, 0]),
+        );
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, opaque_len as usize);
+
+        if rc < rsp_sz as i32 {
+            pr_err!("Truncated challenge response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
+        if verify {
+            /* Verify signature at end of transcript against leaf key */
+            let sig_start = response_vec.len() - self.sig_len;
+            let signature = &mut response_vec[sig_start..rsp_sz];
+
+            match self.verify_signature(signature) {
+                Ok(()) => {
+                    pr_info!("Authenticated with certificate slot {slot}");
+                    self.authenticated = true;
+                }
+                Err(e) => {
+                    pr_err!("Cannot verify challenge_auth signature: {e:?}");
+                    self.authenticated = false;
+                }
+            };
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 8b44a056b335..1975eca81be3 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -28,6 +28,7 @@
 
 use crate::consts::{
     SPDM_ASYM_ALGOS,
+    SPDM_CHALLENGE,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_CERTIFICATE,
@@ -460,3 +461,64 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct ChallengeReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) nonce: [u8; 32],
+    pub(crate) context: [u8; 8],
+}
+
+impl Default for ChallengeReq {
+    fn default() -> Self {
+        ChallengeReq {
+            version: 0,
+            code: SPDM_CHALLENGE,
+            param1: 0,
+            param2: 0,
+            nonce: [0; 32],
+            context: [0; 8],
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct ChallengeRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) cert_chain_hash: __IncompleteArrayField<u8>,
+    pub(crate) nonce: [u8; 32],
+    pub(crate) message_summary_hash: __IncompleteArrayField<u8>,
+
+    pub(crate) opaque_data_len: u16,
+    pub(crate) opaque_data: __IncompleteArrayField<u8>,
+
+    pub(crate) context: [u8; 8],
+    pub(crate) signature: __IncompleteArrayField<u8>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut ChallengeRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<ChallengeRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `ChallengeRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<ChallengeRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut ChallengeRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4e1519b2382d..ed2377be1b44 100644
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
2.52.0

