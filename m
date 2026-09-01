Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0083A759C
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224826; cv=none; b=ImbRcO1hyVsH3sT+pJRdEbqrXeCdyEMyZuRTw6Sh+moMTccNFlqbS6GApxrIA+YqmA/7b4aaZNRysKgX9Gpt4gXqwoF5neQS4szS8xMUeKeMt/BPutEvKMr0W/vyM+KXPdSQiCGSOhgcCiKxrZgdpiZzPLg0EGVDpa7RQfin2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224826; c=relaxed/simple;
	bh=4PPZUjy5GMkvTRr2oGK0IblPeYeT8JMRqXmbwdI9pqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+BbKog2CIoAqIbS+3Eo0Y4GgYMEJvf58oMwzYb7S5Bek/afp66Wjs2hqUMYIbrDw8VEJx0qDty+RsnSDxrxme2j7Iupjm1qyKZmxh3BjCMAcW7gR7KnUYOn+hR6OLd/m9WDnzIVsj8GHJrHJLkL+tOOLLtplDPipK68Idhp5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP+1scjO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP+1scjO"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2970072a91.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224823; x=1788829623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5JB8c4S0Th+kTTgtPCyCVSVH7o5Gb2vhrXhBM7pAc4g=;
        b=OP+1scjOGF7sqxw1AcySr1fGcT5kJXVj6kUcHpa5RN5oxxqehgX8Sj/NH12G9CH8Ac
         jdoct4AhKFO4qJGmY4b3XoIXCm2+TL7Jy9BQ3cPIeN+mgXa1jvHFycJ+7MZMh4v6AQ+H
         s13VGpdC9Cb7DwuGNmLGQ0qglei9D5JA/mic+dIvy5uSOZhCYrTkeVEecpEcYd0tBxOw
         7LrcGCgboNhrH4E+3BaHobopg/LI1eb1oQwTO/J+HQ++IBuPqbwAWT8eF75LjYsgoLI4
         /3Y5c8ZoPztfsJ0rmg4wsad7Zudp27802HM+4loev2HX4GkTYgkKxREjBusR7KMTHRcJ
         2khA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224823; x=1788829623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5JB8c4S0Th+kTTgtPCyCVSVH7o5Gb2vhrXhBM7pAc4g=;
        b=Lm/4yGqfcQjAb1hsBKIPAKeOWLuCqYyAM996W1RXCzZRB9nTtJyIXVbXDo6XunkmTY
         dvBxqehS6R1abK7cORr+gRwVT0K7IyrOmnhrVn2PSTKx44rtdSPTMq26F937HI8SiWcW
         LnwbRVGd+QAUrYFHmaA8s1Lx+cNBb7qJtEs80nxKZrf22maoSA97ZrC5GwafFqfmgDu8
         aOOaqVyhpnzX+SQk2AUjto7/aoG07bXQr0VW2U0CdnKBJbR+Nn+caTGH0MwGv9Oy5C6F
         VpeFZPlJNbNsriICf3s17CVGgpDXKVjXBTuL1YeiLVEBhFYr5CE1Aln96+AY9oHmCxSk
         7pVA==
X-Gm-Message-State: AFuF++nOo2CXMHPndu2Wu8QlMQ9xdADZfZpXelCqBNr/kYE58afe+zlW
	MUQWPQN1LsfEE1j4OlVor4U2r6beY8qO0b+2OWKEOViJ4IenwWhkup9iWk288A==
X-Gm-Gg: AYBFou0LzpGog+BIlhx8MCwX1CB7SbiTV82/kAz+UgPehSqShQ+TRcJJTtghrIav7C+
	W4yJicYVu6jueUoewoqERwnSKSbwNJkcy5mZUJ/PoCq4Br9oJd+New48G8EUvcLwsJknb2GyL2T
	HEjh5rNzEsp1gi98ysBbLecS2yUehHH5nUwPC1nZaaN03ufQ8ahgMKA9dDIO0aHIR/R0azWFaOh
	F2SpcNeVi+WQB7KaYau2eq2ebYeah7G7sfM57UIWKN54LQNViZFRSDg8bi0A+T+C0WSFjO5NNOa
	Tk6VzZI9OIBj9HPq5ykltlYrKvBUnXaYS0j3dxk2b3X4Gf7VIXj/D7s1DOXx2tSAzY7Z/AYMT5i
	zdCX99mLJFbxJrpyHq6v8tSJWuSUSKeCXs3btTHHgWC4f4/b0NTCSWrMuuPCWIO9BjXQjDtDgJv
	RBiZOOKYsqovb9ZyE+YGqnsMIj0/yQD6QsevGPOAZzylXcXoLzjAbAMotp1/NDC9QyY8ow0SMx8
	rK4Qg==
X-Received: by 2002:a17:90b:57cf:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-398d132c2e0mr19298028a91.21.1788224822695;
        Mon, 31 Aug 2026 18:07:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:07:02 -0700 (PDT)
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
Subject: [PATCH v3 21/21] lib: rspdm: Support SPDM challenge
Date: Tue,  1 Sep 2026 11:03:47 +1000
Message-ID: <20260901010347.2614656-22-alistair.francis@wdc.com>
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

Support the CHALLENGE SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs             |   6 +
 lib/rspdm/lib.rs                |  10 +-
 lib/rspdm/state.rs              | 239 +++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs          |  61 ++++++++
 rust/bindings/bindings_helper.h |   1 +
 5 files changed, 313 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 2fbc4ab41869..e67be8e6b057 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -148,6 +148,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
 
+pub(crate) const SPDM_CHALLENGE: u8 = 0x83;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
@@ -176,3 +178,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_HASH_ALGOS: u32 = SPDM_HASH_SHA2_256 | SPDM_HASH_SHA2_384_512;
 
 pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
+
+pub(crate) const SPDM_PREFIX_SZ: usize = 64;
+pub(crate) const SPDM_COMBINED_PREFIX_SZ: usize = 100;
+pub(crate) const SPDM_MAX_OPAQUE_DATA: usize = 1024;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index fa5513e8bd4e..33c16f7ffb46 100644
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
@@ -141,7 +140,12 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
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
index fc7df9dd7b97..1fd691037fa5 100644
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
@@ -38,10 +41,12 @@
     SPDM_HASH_SHA_384,
     SPDM_HASH_SHA_512,
     SPDM_KEY_EX_CAP,
+    SPDM_MAX_OPAQUE_DATA,
     SPDM_MAX_VER,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
     SPDM_OPAQUE_DATA_FMT_GENERAL,
+    SPDM_PREFIX_SZ,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_SLOTS,
@@ -51,6 +56,8 @@
     SPDM_VER_13, //
 };
 use crate::validator::{
+    ChallengeReq,
+    ChallengeRsp,
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
     GetCertificateReq,
@@ -65,6 +72,8 @@
     SpdmHeader, //
 };
 
+const SPDM_CONTEXT: &str = "responder-challenge_auth signing";
+
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
 ///
@@ -111,6 +120,12 @@
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
@@ -140,6 +155,10 @@ pub(crate) struct SpdmState<'a> {
     // Certificates
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
     pub(crate) leaf_key: Option<*mut bindings::public_key>,
+
+    transcript: VVec<u8>,
+
+    pub(crate) next_nonce: KVec<u8>,
 }
 
 impl Drop for SpdmState<'_> {
@@ -212,6 +231,8 @@ pub(crate) fn new(
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
             leaf_key: None,
+            transcript: VVec::new(),
+            next_nonce: KVec::new(),
         }
     }
 
@@ -327,13 +348,15 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
     pub(crate) fn spdm_exchange(
-        &self,
+        &mut self,
         request_buf: &mut [u8],
         response_buf: &mut [u8],
     ) -> Result<i32, Error> {
         let header_size = core::mem::size_of::<SpdmHeader>();
         let request: &SpdmHeader = Untrusted::new(&request_buf[..]).validate()?;
 
+        self.transcript.extend_from_slice(request_buf, GFP_KERNEL)?;
+
         let transport_function = self.transport.ok_or(EINVAL)?;
         // SAFETY: `transport_function` is provided by the new(), we are
         // calling the function.
@@ -383,6 +406,8 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         request.version = SPDM_MIN_VER;
         self.version = SPDM_MIN_VER;
 
+        self.transcript.clear();
+
         // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
         let request_buf = unsafe {
             from_raw_parts_mut(
@@ -402,6 +427,16 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         response_vec.truncate(rc);
 
         let response: &GetVersionRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>()
+            + 2
+            + response.version_number_entry_count as usize * 2;
+
+        if rsp_sz > response_vec.len() {
+            return Err(EIO);
+        }
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         let mut foundver = false;
         let entry_count = response.version_number_entry_count;
@@ -471,6 +506,13 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
         }
         response_vec.truncate(rc);
 
+        if rsp_sz > response_vec.len() {
+            return Err(EIO);
+        }
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
         let response: &mut GetCapabilitiesRsp = Untrusted::new(&mut response_vec).validate()?;
 
         self.rsp_caps = u32::from_le(response.flags);
@@ -629,6 +671,9 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
         let response: &NegotiateAlgsRsp = Untrusted::new(response_vec.as_slice()).validate()?;
 
+        self.transcript
+            .extend_from_slice(&response_vec, GFP_KERNEL)?;
+
         self.base_asym_alg = u32::from_le(response.base_asym_sel);
         self.base_hash_alg = u32::from_le(response.base_hash_sel);
         self.meas_hash_alg = u32::from_le(response.measurement_hash_algo);
@@ -678,6 +723,14 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
         response_vec.truncate(len);
 
         let response: &GetDigestsRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + response.param2 as usize * self.hash_len;
+
+        if rsp_sz > response_vec.len() {
+            return Err(EIO);
+        }
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if len
             < core::mem::size_of::<GetDigestsRsp>()
@@ -735,6 +788,14 @@ fn get_cert_exchange<'a>(
         response_vec.truncate(len);
 
         let response: &GetCertificateRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + 4 + response.portion_length as usize;
+
+        if rsp_sz > response_vec.len() {
+            return Err(EIO);
+        }
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
 
         if len
             < core::mem::size_of::<GetCertificateRsp>()
@@ -990,4 +1051,180 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
 
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
+            return Err(EPROTO);
+        }
+
+        if self.version <= SPDM_VER_11 {
+            sig.m = m[SPDM_COMBINED_PREFIX_SZ..].as_mut_ptr();
+        } else {
+            let major = self.version >> 4;
+            let minor = self.version & 0xF;
+
+            let prefix = CString::try_from_fmt(fmt!("dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;
+            let mut buf = prefix.into_vec();
+            let zero_pad_len = SPDM_COMBINED_PREFIX_SZ - SPDM_PREFIX_SZ - SPDM_CONTEXT.len() - 1;
+
+            buf.extend_with(zero_pad_len, 0, GFP_KERNEL)?;
+            buf.extend_from_slice(SPDM_CONTEXT.as_bytes(), GFP_KERNEL)?;
+
+            if buf.len() != SPDM_COMBINED_PREFIX_SZ {
+                pr_err!("combined_spdm_prefix calculation is incorrect");
+                return Err(EPROTO);
+            }
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
+                return Err(EPROTO);
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
+            return Err(EPROTO);
+        }
+    }
+
+    pub(crate) fn challenge(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = ChallengeReq::default();
+        request.version = self.version;
+        request.param1 = slot;
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
+        let req_sz = if self.version <= SPDM_VER_12 {
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
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let rc = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if rc < core::mem::size_of::<ChallengeRsp>() {
+            pr_err!("Truncated challenge response\n");
+            return Err(EIO);
+        }
+        response_vec.truncate(rc);
+
+        let _response: &ChallengeRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+
+        // MSHLength is 0 as no measurement summary hash requested
+        let opaque_len_offset = core::mem::size_of::<SpdmHeader>() + self.hash_len + nonce_len;
+
+        if opaque_len_offset + 2 > response_vec.len() {
+            return Err(EIO);
+        }
+
+        let opaque_len = u16::from_le_bytes(
+            response_vec[opaque_len_offset..(opaque_len_offset + 2)]
+                .try_into()
+                .unwrap_or([0, 0]),
+        );
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, opaque_len as usize);
+
+        if rsp_sz > response_vec.len() {
+            pr_err!("Truncated challenge response\n");
+            return Err(EIO);
+        }
+
+        self.transcript
+            .extend_from_slice(&response_vec[..rsp_sz], GFP_KERNEL)?;
+
+        /* Verify signature at end of transcript against leaf key */
+        let sig_start = rsp_sz - self.sig_len;
+        let signature = &mut response_vec[sig_start..rsp_sz];
+
+        match self.verify_signature(signature) {
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
index 2584bed73979..f623ac1d2860 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -28,6 +28,7 @@
 
 use crate::consts::{
     SPDM_ASYM_ALGOS,
+    SPDM_CHALLENGE,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_CERTIFICATE,
@@ -491,3 +492,63 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
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
+impl<'a> Validate<Untrusted<&'a [u8]>> for &'a ChallengeRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<ChallengeRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `ChallengeRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<ChallengeRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &ChallengeRsp = unsafe { &*ptr };
+
+        Ok(rsp)
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

