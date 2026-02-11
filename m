Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA323446B1
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780758; cv=none; b=DjMYBJxYKiuH0MNMd8/K/DK6qo4q9bcKlhbgcHMgDg2Ec/7ukk0UIPScRcV48+1tdEBwY6H8X56WccPEdTUeW630TlQhujEwryFvn9L8NYRg1mE/ZitXrozpm78O8Xuse/nNFk1r8xk8tPCwIslXyv6lnCsZ8n3Nz3M7Ijpa3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780758; c=relaxed/simple;
	bh=OHYeXBOEWikJ5tM3JO1c9NWGzCdzDjoaW7Gx9KKZKx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcwdwmHHYLLFcYbRWLpmHuC+YreFTX2F73XhBWkikmyGivJAF52UY0/lEM0jc7UqaLfiqGBbN4wUUkwFurXaiU1oKMM8Sy5vfFiB+yo47je34QKEf9F+gC+uNqOh6VMexDd702LED2zBurMebwV7XOVqdFPqgf9ovatu+7BAcwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIeZhnER; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIeZhnER"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso5291010b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780756; x=1771385556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBL0ioZW+u5dvBBFyAK8qPVd1Z14bb+2hhlX3XvqGrU=;
        b=QIeZhnER28hP6UgNV0hd6NQ2DCUMiwDDCFWLkhFBo/rtbS2BwAs4ZUyNIfoie8IWHM
         WnQ6p/3EOoGOBRP1y4fE6WojiqnTGzp2obuD3dijZ5Nac++h0nt2IVAc/r8IGlnWoUZA
         iyRxMl/dhFKJ5P9ut7tOertyGtk0xh8+BstcP4eMwlTWuCNsA9RUgTdkREPPjoPTnrE1
         TWFliBLObGijLuombhz9/On9T7fzzcLbcIlljr2vXRqln8BgD2UUyGSvgiwWnKTe5zf6
         Zw3eF5f3XeraX2Iu3f60lfeH7LMclaM1SvPTz09VcM1BfbP6gAC+mbCn1dnvWc3DA1Eh
         ZfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780756; x=1771385556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gBL0ioZW+u5dvBBFyAK8qPVd1Z14bb+2hhlX3XvqGrU=;
        b=wddH3CWyLNeO56o73MQqofZRFII0yl9+RDZDUIVm6/2xltBw1LO861N/vXp7uRlION
         jX8N4T+yG34TQmFjGsRDauxyjI+w2tIVEQnDY0NY303Lx7+xTS0dw7hWP/sS5nO/GCto
         IacRTUW91OCRBvDSZKr1GJ8mFu31sUVVuMQnTC5oaYBtIbYZq2zwitSKQTDxtrLIbrGU
         KSlnvSgXIC6jJ6uKbRrq8TklvChRnT8H1H6gZZprCnAUHq8G81xMmx1NBReu1j7+VEfS
         Jo2G2+UzaCV87tDspxxENL8Q4hA5bePP55oiFjCccsOhtE4ArfNutC0fHe/b4596DmVS
         PYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUHoUKSis4dqq5A1c+QYB9zXGpdCxByKRwRnjwyNbOrHWHUTiBdAgWR1uLJWHTF78XNCIvjAnv8XCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdwpdSZIOQJs8n0waFzPPC2Gx8ntG+TsAIS/gKOUEYtjY64TZ
	2jHPClaNrJaAmyJHVdUPXY4TjwtCOfVCFqp+TPJJKHu04d239SY5FkQv
X-Gm-Gg: AZuq6aLl8GzASJ+1A8y4lb3pkBWwrBPUbVe1pit76JnBSlgehm0Y9wDQGOFcilh8lDt
	HuxtWXEsXWRd2YOPchHScbFW3UWNyWZfUJTQoEMBlSIisMAdOuxZw9uS1+ggbwJwUZifcwsCbIj
	HevTM+QuuZkb/dT/xVBn0fZKhX/QfZPm2WPx6iYQP7cOvQOXWhOME5xFB1bLBgPX8he590zCXZA
	ycBPEGV3eKI/y2BwYbv7MTrTvXGFFy00s+f71RPYKyvJwFQKim2AGXwvmIUcJ+QjL5cF09VXgOE
	gd4ADDnDa34Dtsz9bS1dosPhtFOzVRyvdN+lueTDbtgPFkPaWyPDn1BGj3pLLJlJZrEisNBNPyC
	npcYTADToIoupFF3adI1TM8nUHpINMqZ3aka7O5cfch7Qv4zgLvyqDNIihyxDR3toSAnjSlMtn0
	kf9vmWpIu+jftazQhucrrb3aLKcF3ykewV9mCAFLzUxg==
X-Received: by 2002:a05:6a20:cfa6:b0:366:14ac:e1ee with SMTP id adf61e73a8af0-394324a76d9mr666383637.64.1770780756092;
        Tue, 10 Feb 2026 19:32:36 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:32:35 -0800 (PST)
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
Subject: [RFC v3 24/27] lib: rspdm: Support SPDM challenge
Date: Wed, 11 Feb 2026 13:29:31 +1000
Message-ID: <20260211032935.2705841-25-alistair.francis@wdc.com>
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

Support the CHALLENGE SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs             |   6 +
 lib/rspdm/lib.rs                |   8 +-
 lib/rspdm/state.rs              | 218 +++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs          |  65 +++++++++-
 rust/bindings/bindings_helper.h |   1 +
 5 files changed, 289 insertions(+), 9 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index eaf2132da290..904d8272a1d0 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -176,6 +176,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
 
+pub(crate) const SPDM_CHALLENGE: u8 = 0x83;
+
 #[cfg(CONFIG_CRYPTO_RSA)]
 pub(crate) const SPDM_ASYM_RSA: u32 =
     SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
@@ -205,3 +207,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 // pub(crate) const SPDM_MAX_REQ_ALG_STRUCT: usize = 4;
 
 pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = 1 << 1;
+
+pub(crate) const SPDM_PREFIX_SZ: usize = 64;
+pub(crate) const SPDM_COMBINED_PREFIX_SZ: usize = 100;
+pub(crate) const SPDM_MAX_OPAQUE_DATA: usize = 1024;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index c016306116a3..05fa471bb1e2 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -136,17 +136,23 @@
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut verify = true;
     let mut provisioned_slots = state.provisioned_slots;
     while (provisioned_slots as usize) > 0 {
         let slot = provisioned_slots.trailing_zeros() as u8;
 
         if let Err(e) = state.validate_cert_chain(slot) {
-            return e.to_errno() as c_int;
+            pr_debug!("Certificate in slot {slot} failed to verify: {e:?}");
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
index 728b920beace..a4d803af48fe 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -14,23 +14,27 @@
     bindings,
     error::{code::EINVAL, from_err_ptr, to_result, Error},
     str::CStr,
+    str::CString,
     validate::Untrusted,
 };
 
 use crate::consts::{
     SpdmErrorCode, SPDM_ASYM_ALGOS, SPDM_ASYM_ECDSA_ECC_NIST_P256, SPDM_ASYM_ECDSA_ECC_NIST_P384,
     SPDM_ASYM_ECDSA_ECC_NIST_P521, SPDM_ASYM_RSASSA_2048, SPDM_ASYM_RSASSA_3072,
-    SPDM_ASYM_RSASSA_4096, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_HASH_ALGOS, SPDM_HASH_SHA_256,
-    SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK,
-    SPDM_MEAS_SPEC_DMTF, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_ASYM_RSASSA_4096, SPDM_COMBINED_PREFIX_SZ, SPDM_ERROR, SPDM_GET_VERSION_LEN,
+    SPDM_HASH_ALGOS, SPDM_HASH_SHA_256, SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP,
+    SPDM_MAX_OPAQUE_DATA, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK, SPDM_MEAS_SPEC_DMTF,
+    SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL, SPDM_PREFIX_SZ,
     SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetCertificateReq, GetCertificateRsp, GetDigestsReq,
-    GetDigestsRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg,
-    SpdmErrorRsp, SpdmHeader,
+    ChallengeReq, ChallengeRsp, GetCapabilitiesReq, GetCapabilitiesRsp, GetCertificateReq,
+    GetCertificateRsp, GetDigestsReq, GetDigestsRsp, GetVersionReq, GetVersionRsp,
+    NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
 };
 
+const SPDM_CONTEXT: &str = "responder-challenge_auth signing";
+
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
 ///
@@ -78,6 +82,14 @@
 /// @slot_sz: Certificate chain size (in bytes).
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
@@ -105,9 +117,15 @@ pub struct SpdmState {
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
+    next_nonce: Option<&'static mut [u8]>,
 }
 
 #[repr(C, packed)]
@@ -147,8 +165,11 @@ pub(crate) fn new(
             shash: core::ptr::null_mut(),
             desc: None,
             hash_len: 0,
+            authenticated: false,
             certs: [const { KVec::new() }; SPDM_SLOTS],
             leaf_key: None,
+            transcript: VVec::new(),
+            next_nonce: None,
         }
     }
 
@@ -256,7 +277,7 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
     pub(crate) fn spdm_exchange(
-        &self,
+        &mut self,
         request_buf: &mut [u8],
         response_buf: &mut [u8],
     ) -> Result<i32, Error> {
@@ -264,6 +285,8 @@ pub(crate) fn spdm_exchange(
         let request: &mut SpdmHeader = Untrusted::new_mut(request_buf).validate_mut()?;
         let response: &SpdmHeader = Untrusted::new_ref(response_buf).validate()?;
 
+        self.transcript.extend_from_slice(request_buf, GFP_KERNEL)?;
+
         let transport_function = self.transport.ok_or(EINVAL)?;
         // SAFETY: `transport_function` is provided by the new(), we are
         // calling the function.
@@ -331,6 +354,12 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         unsafe { response_vec.inc_len(rc as usize) };
 
         let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>()
+            + 2
+            + response.version_number_entry_count as usize * 2;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         let mut foundver = false;
         for i in 0..response.version_number_entry_count {
@@ -395,6 +424,9 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
         let response: &mut GetCapabilitiesRsp =
             Untrusted::new_mut(&mut response_vec).validate_mut()?;
 
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
         self.rsp_caps = u32::from_le(response.flags);
         if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
             to_result(-(bindings::EPROTONOSUPPORT as i32))?;
@@ -533,6 +565,9 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
         let response: &mut NegotiateAlgsRsp =
             Untrusted::new_mut(&mut response_vec).validate_mut()?;
 
+        self.transcript
+            .extend_from_slice(&response_vec, GFP_KERNEL)?;
+
         self.base_asym_alg = response.base_asym_sel;
         self.base_hash_alg = response.base_hash_sel;
         self.meas_hash_alg = response.measurement_hash_algo;
@@ -593,6 +628,10 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
         unsafe { response_vec.inc_len(rc as usize) };
 
         let response: &mut GetDigestsRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + response.param2 as usize * self.hash_len;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if rc
             < (core::mem::size_of::<GetDigestsReq>()
@@ -654,6 +693,10 @@ fn get_cert_exchange(
         unsafe { response_vec.inc_len(rc as usize) };
 
         let response: &mut GetCertificateRsp = Untrusted::new_mut(response_vec).validate_mut()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + 4 + response.portion_length as usize;
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if rc
             < (core::mem::size_of::<GetCertificateRsp>() + response.portion_length as usize) as i32
@@ -834,4 +877,165 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
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
+    fn verify_signature(&mut self, response_vec: &mut [u8]) -> Result<(), Error> {
+        let sig_start = response_vec.len() - self.sig_len;
+        let mut sig = bindings::public_key_signature::default();
+        let mut mhash: KVec<u8> = KVec::new();
+
+        sig.s = &mut response_vec[sig_start..] as *mut _ as *mut u8;
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
+        if let Some(nonce) = &self.next_nonce {
+            request.nonce.copy_from_slice(&nonce);
+            self.next_nonce = None;
+        } else {
+            unsafe {
+                bindings::get_random_bytes(&mut request.nonce as *mut _ as *mut c_void, nonce_len)
+            };
+        }
+
+        let req_sz = if self.version <= 0x12 {
+            core::mem::size_of::<ChallengeReq>() - 8
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
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
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
+            match self.verify_signature(&mut response_vec[..rsp_sz]) {
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
index a8bc3378676f..f8a5337841f0 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -17,7 +17,7 @@
 };
 
 use crate::consts::{
-    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_CERTIFICATE,
+    SPDM_ASYM_ALGOS, SPDM_CHALLENGE, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS, SPDM_GET_VERSION, SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS,
 };
@@ -424,3 +424,66 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
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
+        // rsp.opaque_data_len = rsp.opaque_data_len.to_le();
+
+        Ok(rsp)
+    }
+}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 52ad3e98e036..35e4378fb9dc 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -35,6 +35,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
 #include <crypto/hash.h>
+#include <crypto/public_key.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/bitmap.h>
-- 
2.52.0

