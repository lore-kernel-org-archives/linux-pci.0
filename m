Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078927;
	b=PLY0oeLqvlYG1W/DA+lVhZdccB+CZP0L+cQS+jrDT38XxoE0RCWINDOwWvTo/Wp/UBOd
	 ykX/NJSerOElnxoIRCvQPBPqJsbW+yVflEnB3W+U2MNpwLUAOkY5sBZgqxMoE2ORQnBNH
	 wdh6L0pA4mReI3l+EzkMwOTZM9VQJjFY6zOPdXT8TC0kAVLuyURx/v0B8PFWhwdQ39TZa
	 B7z0/Pt3KGp0mkkyJpX6m3aTbxatE25X7bAP6g2vQZ0mbTrcq/O+U7nPIi/KNrAfagHt6
	 NNNgP/b6px5LHGXMISmPVH/x0sjYn0Yvb5Z6wyaFUoOeaUvwsHqX/coZIeQW3t3HtUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MBDbNM7TRvq5+8s9EZqfWE5ac+V/TJ/PFg9Dwo4zUWU=;
	b=vum0pZn/KNTGSh9dHOqgeHkxnpw8bM4Kxb1dKJIMffZbiTlAcWiOTUpRj4m6qqxl1Wmb
	 NsxqAglMBiRH1r5oWrXnWbBJmtDOVRl4/smawR5rAUuycb7cMMg0JC1BcwlkrMjimLIWf
	 khfBUICq/kPwn81tTO4HbCYTNm23+3J8SZRvgXkcFDbfHhQKh/xq6XCE7Lkdij6HrcOmQ
	 V7G9biJRgUM4Xpij+o2KY6EMcX8VyDFDwPnsRzRGvjXLbdy2ADPAKLDOkfPsbIu9Ph449
	 KK8W4T00uq3DV6sGKCU8r4pzswAtV/8Se4dj2xORe7H+pq5sczLxo5NNhFZOIBfThhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FelR6Xf5;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEB606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3BEB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FelR6Xf5
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8246b13cbso33037385ad.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078926; x=1793683726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MBDbNM7TRvq5+8s9EZqfWE5ac+V/TJ/PFg9Dwo4zUWU=;
        b=FelR6Xf5Hxy+dgyEBgakpjWok6AuO3G8N0BbFXmApMGagXdx8VUovSR8mETyuhzrVk
         PFCz3xfrA/7n06YAQtJ0FNAU1IUjB/ZeUiESaUfJeZ/7t0/TspkbZXjkbd7mYB/hBEYE
         SBPHpLNUywYBN1eYoi55sUy2J7TPLeuAZ2FSgHnAocX1gVtnT0oe/nOnZTg8M5yGRJBY
         5d9tgYORcMz5VTB3lfR1V8LhqSYr2ZZQB9N2pK3uO1P5RnFV0RFyI4QBGuuQogsoVe+g
         p9f1Yjg43t1EkFzEG+LDVz+WYlZ1Jdhl8rR3zXuf4emmu5fTvRYfsQavGpf9e3MLKBDb
         Zs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078926; x=1793683726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MBDbNM7TRvq5+8s9EZqfWE5ac+V/TJ/PFg9Dwo4zUWU=;
        b=CU4kGCHry7KLKNPn7KLs1bE53OpllMysrcx5rt72Y6afQFypz+i/SCwAhYK262y/f7
         b3Kqee1J4QmVbXR0n82Y/nk2vYrmcNGVhTWwfkM/ruQUTCHjsHrFNg/IqGf5wxwTvr35
         nmfMPymulQmcxy7caM0mdBH9ICT2YxtGUE3r1VRQKp/uDjCWiDLCBRkDJOqXERWejDMv
         EpfRwen8P64EHQQq7PSkDiN5JX0YqURTSHYWk9HcIkDiIrfVYXapBQfgIjbhSoohwcKC
         F3iuSJ88E2xNFKqwA18OyWwxlROHm4vBWT2pwSo1HTbDMiYZsznbbl4p0wUHdKP1PjV7
         La+A==
X-Forwarded-Encrypted: i=1; AKwUvBz3HKSUYsFpm1zSBe5VpsSxJuvZ3HtvMdisLfbdK1UOG9i0QIHLukzkkToJ8pjxiGRoaGPzPlFij1o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHxH43N2zMZGUNTDGWvl/r5jX7wKKWgdP6xrZ86wV/RaKMz9tc
	oqcSbroWOGDk7p17jYO3PEemb804PeO+Sah+kf1ci2bGPTWZK/CvRl8P
X-Gm-Gg: AYBFou0Fuugs21fNgPgfsSP7fDsEgOLc1/Q4M8U3/C02MdWFDRecnQ+wp5/Zs3ffu3W
	4E87X/UnIGAI3Bm9OjRbo+8XgQD4PJxH6qoA+R0Bqzfv6RFufNmhve+QRx1OU3tVKgJWgl22H0A
	01C6wsVZtqE2F6C1hDZtVJzB66V87RNc6IiPFp9shM2rTv5SUJJ6aTuZjDm3kcOFfP0D4nzQHDf
	wpieHpZmqauExLlr5bF1gk1s6i7BNK5zOcI5+aQT8bMBjNB9ptpP/h0A/2X5ciJ+gGXEoS9IDrY
	NDUVdGf8qdxzWCkErzWov2qukn8/1XDun79u6lc/e/8f2zi7o51fXmgv2cHOX154Vegd5rUEDv/
	kHRzVqYluCg/byjCCfiB3Vp4cTQBG3i+DtkbVytElrqarCLngLpqk2vbhRsMlRW0qUOoM/ONDkH
	mKqd10IjabkieZGtASd1SHd9k/nrB+DOYSerBTU9FnVYpfpjpI8SujSb34xoNGN4IlMKYuLVuBv
	Ra7Z5W9xNVZ9xAxmJnEmdkIDvNZk5sGZtyej32pXV4mRj3pSr4i91Enp2aCT2vj43QU+uO9tROy
	bNmcPWudszCw7Avfv5XcwQyrhUew29zuhZzh5hwtUqsykyY=
X-Received: by 2002:a17:902:ef4c:b0:2e9:5eee:e087 with SMTP id d9443c01a7336-2ea9c7bd84cmr79180225ad.43.1793078926071;
        Mon, 26 Oct 2026 22:28:46 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:28:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	alistair@alistair23.me,
	rust-for-linux@vger.kernel.org,
	jic23@kernel.org
Cc: ojeda@kernel.org,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	alistair23@gmail.com,
	wilfred.mallawa@wdc.com,
	bjorn3_gh@protonmail.com,
	gregkh@linuxfoundation.org,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	tmgross@umich.edu,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 23/23] lib: rspdm: Support SPDM challenge
Date: Tue, 27 Oct 2026 15:25:36 +1000
Message-ID: <20261027052536.1722081-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027052536.1722081-1-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Support the CHALLENGE SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/consts.rs    |   6 ++
 lib/rspdm/lib.rs       |  10 ++-
 lib/rspdm/state.rs     | 188 +++++++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 156 ++++++++++++++++++++++++++++++++--
 4 files changed, 347 insertions(+), 13 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 964ae2a21c6da..f2cb04d82d529 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -77,6 +77,8 @@
 
 pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
 
+pub(crate) const SPDM_CHALLENGE: u8 = 0x83;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
@@ -105,3 +107,7 @@
 pub(crate) const SPDM_HASH_ALGOS: u32 = SPDM_HASH_SHA2_256 | SPDM_HASH_SHA2_384_512;
 
 pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
+
+pub(crate) const SPDM_PREFIX_SZ: usize = 64;
+pub(crate) const SPDM_COMBINED_PREFIX_SZ: usize = 100;
+pub(crate) const SPDM_MAX_OPAQUE_DATA: usize = 1024;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 5277fc8c56fb8..3d03f9dee8f33 100644
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
@@ -301,7 +300,12 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
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
 
 /// Destroys an SPDM session.
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index aa36d4ce7b41a..993d19cd60935 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -21,6 +21,7 @@
     hash::Shash,
     public_key::PublicKey,
     str::CStr,
+    str::CString,
     validate::Untrusted,
     x509::Certificate,
 };
@@ -33,6 +34,7 @@
     SPDM_ASYM_RSASSA_2048,
     SPDM_ASYM_RSASSA_3072,
     SPDM_ASYM_RSASSA_4096,
+    SPDM_COMBINED_PREFIX_SZ,
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
     SPDM_HASH_ALGOS,
@@ -40,10 +42,12 @@
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
@@ -53,6 +57,8 @@
     SPDM_VER_13, //
 };
 use crate::validator::{
+    ChallengeReq,
+    ChallengeRsp,
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
     GetCertificateReq,
@@ -72,6 +78,8 @@
     SPDM_CERT_CHAIN_HDR_SZ, //
 };
 
+const SPDM_CONTEXT: &str = "responder-challenge_auth signing";
+
 /// Transport for exchanging SPDM messages with a responder device.
 ///
 /// This trait abstracts the bus-specific message transport (for example
@@ -144,7 +152,7 @@ pub(crate) struct SpdmState<'a, T: Transport> {
     base_asym_enc: &'static CStr,
     /// Signature length of `base_asym_alg` (in bytes). S or SigLen in SPDM
     /// specification.
-    sig_len: usize,
+    pub(crate) sig_len: usize,
 
     /// Hash transformation for `base_hash_alg` computation.
     crypto: Option<Shash>,
@@ -155,6 +163,16 @@ pub(crate) struct SpdmState<'a, T: Transport> {
     /// Public key portion of leaf certificate against which to check
     /// responder's signatures.
     pub(crate) leaf_key: Option<PublicKey>,
+
+    /// Concatenation of all SPDM messages exchanged during an authentication
+    /// or measurement sequence. Used to verify the signature, as it is
+    /// computed over the hashed transcript.
+    transcript: VVec<u8>,
+
+    /// Requester nonce to be used for the next authentication sequence.
+    /// Populated from user space through sysfs. If user space does not
+    /// provide a nonce, the kernel uses a random one.
+    pub(crate) next_nonce: KVec<u8>,
 }
 
 impl<'a, T: Transport> SpdmState<'a, T> {
@@ -181,6 +199,8 @@ pub(crate) fn new(
             crypto: None,
             certs: [const { KVec::new() }; SPDM_SLOTS],
             leaf_key: None,
+            transcript: VVec::new(),
+            next_nonce: KVec::new(),
         }
     }
 
@@ -197,12 +217,14 @@ pub(crate) fn hash_len(&self) -> usize {
     /// The data in `request_buf` is sent to the device and the response
     /// is returned as untrusted data to be validated by the caller.
     pub(crate) fn spdm_exchange(
-        &self,
+        &mut self,
         request_buf: &[u8],
         mut response_buf: KVec<u8>,
     ) -> Result<Untrusted<KVec<u8>>, Error> {
         let header_size = core::mem::size_of::<SpdmHeader>();
-        let request: SpdmHeader = Untrusted::new(request_buf).validate(self)?;
+        let request: SpdmHeader = Untrusted::new(request_buf).validate(&*self)?;
+
+        self.transcript.extend_from_slice(request_buf, GFP_KERNEL)?;
 
         let length = self
             .transport
@@ -220,11 +242,11 @@ pub(crate) fn spdm_exchange(
         response_buf.truncate(length);
 
         let response: SpdmHeader =
-            Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(self)?;
+            Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(&*self)?;
 
         if response.code == SPDM_ERROR {
             let error_rsp: SpdmErrorRsp =
-                Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(self)?;
+                Untrusted::new(response_buf.get(..header_size).ok_or(EPROTO)?).validate(&*self)?;
             pr_err!("Error response: {error_rsp:?}\n");
             return Err(error_rsp.error_code.into());
         }
@@ -248,6 +270,8 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
         request.header.version = SPDM_MIN_VER;
         self.version = SPDM_MIN_VER;
 
+        self.transcript.clear();
+
         // Clear the leaf cert as we are re-authenticating
         self.leaf_key = None;
 
@@ -259,6 +283,9 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         let mut foundver = false;
         for &entry in response.version_number_entries.iter() {
             let alpha_version = (entry & 0xF) as u8;
@@ -309,7 +336,11 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         self.rsp_caps = response.flags;
+
         if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
             pr_err!(
                 "{:#x} capabilities are supported, which don't meet required {:#x}\n",
@@ -404,6 +435,9 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         self.base_asym_alg = response.base_asym_sel;
         self.base_hash_alg = response.base_hash_sel;
         self.meas_hash_alg = response.measurement_hash_algo;
@@ -450,6 +484,9 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         let mut deprovisioned_slots = self.provisioned_slots & !response.header.param2;
         while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
             let slot = deprovisioned_slots.trailing_zeros() as usize;
@@ -488,6 +525,9 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
             .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
             .validate(&*self)?;
 
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
         if (response.header.param1 & 0xF) != slot {
             pr_err!("Invalid slot response\n");
             return Err(EPROTO);
@@ -521,6 +561,9 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
                 .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
                 .validate(&*self)?;
 
+            self.transcript
+                .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
             let portion_length = response.portion_length;
             let rem_length = response.remainder_length;
 
@@ -603,4 +646,139 @@ pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn challenge_rsp_len(&mut self, nonce_len: usize, opaque_len: usize) -> usize {
+        // No measurement summary hash requested (MSHLength == 0)
+        let mut length =
+            core::mem::size_of::<SpdmHeader>() + self.hash_len() + nonce_len + opaque_len + 2;
+
+        if self.version >= SPDM_VER_13 {
+            length += 8;
+        }
+
+        length + self.sig_len
+    }
+
+    fn verify_signature(&mut self, signature: &mut [u8]) -> Result<(), Error> {
+        let crypto = self.crypto.as_ref().ok_or(EPROTO)?;
+        let leaf_key = self.leaf_key.as_ref().ok_or(EPROTO)?;
+        let hash_len = crypto.hash_len();
+        let sig_len = self.sig_len;
+
+        if self.transcript.len() <= sig_len {
+            return Err(EPROTO);
+        }
+
+        let mut m: KVec<u8> = KVec::new();
+        m.extend_with(SPDM_COMBINED_PREFIX_SZ + hash_len, 0, GFP_KERNEL)?;
+
+        // Generate the `unverified_message_hash`, which is the hash of the
+        // `unverified_data` (Chapter 16 - "Signature Verification").
+        crypto.digest(
+            &self.transcript[..(self.transcript.len() - sig_len)],
+            &mut m[SPDM_COMBINED_PREFIX_SZ..],
+        )?;
+
+        // Must be in scope whenever `sig` is used
+        let mut mhash: KVec<u8> = KVec::new();
+
+        let message = if self.version <= SPDM_VER_11 {
+            &m[SPDM_COMBINED_PREFIX_SZ..]
+        } else {
+            // `M` shall be the concatenation of the `combined_spdm_prefix`
+            // and `unverified_message_hash`. We use `M` for pub/priv
+            // signature verification below.
+            // (Chapter 16 - "Signature Verification")
+
+            let major = self.version >> 4;
+            let minor = self.version & 0xF;
+
+            // Generate the `spdm_prefix` (Chapter 15 - "Signature generation")
+            let prefix = CString::try_from_fmt(fmt!("dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*dmtf-spdm-v{major:x}.{minor:x}.*"))?;
+
+            if prefix.to_bytes().len() != SPDM_PREFIX_SZ {
+                pr_err!("spdm_prefix length is incorrect\n");
+                return Err(EPROTO);
+            }
+
+            // Build the `combined_spdm_prefix` (Chapter 15 - "Signature
+            // generation") directly in `m`: the 64 byte `spdm_prefix`, zero
+            // padding, followed by the 36 byte `spdm_context`. `m` was zero
+            // initialised above with the `unverified_message_hash` copied
+            // in at offset SPDM_COMBINED_PREFIX_SZ, so only the two
+            // non-zero portions need to be written.
+            m[..SPDM_PREFIX_SZ].copy_from_slice(prefix.to_bytes());
+            m[SPDM_COMBINED_PREFIX_SZ - SPDM_CONTEXT.len()..SPDM_COMBINED_PREFIX_SZ]
+                .copy_from_slice(SPDM_CONTEXT.as_bytes());
+
+            // Generate a hash of `M` and use that for signature
+            // verification (RSA or ECDSA)
+            mhash.extend_with(hash_len, 0, GFP_KERNEL)?;
+            crypto.digest(m.as_slice(), mhash.as_mut_slice())?;
+
+            mhash.as_slice()
+        };
+
+        // Finally verify the generated signature against the public key
+        leaf_key.verify_signature(signature, self.base_asym_enc, crypto.name(), message)
+    }
+
+    pub(crate) fn challenge(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = ChallengeReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        let nonce_len = request.nonce.len();
+
+        if !self.next_nonce.is_empty() {
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
+            // SAFETY: `request.nonce` is a valid buffer of `nonce_len` length.
+            unsafe {
+                bindings::get_random_bytes(
+                    core::ptr::from_mut(&mut request.nonce).cast::<c_void>(),
+                    nonce_len,
+                )
+            };
+        }
+
+        let rsp_sz = self.challenge_rsp_len(nonce_len, SPDM_MAX_OPAQUE_DATA);
+
+        let mut request_buf = request.to_bytes()?;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let mut response: ChallengeRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
+
+        self.transcript
+            .extend_from_slice(response.as_bytes()?, GFP_KERNEL)?;
+
+        if request.context != response.context {
+            pr_err!("Mismatched challenge context response\n");
+            return Err(EPROTO);
+        }
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
index 469a5722368f2..4ec0db6ffb59c 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -10,12 +10,14 @@
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
@@ -144,7 +146,6 @@ pub(crate) struct GetVersionRsp {
 }
 
 impl GetVersionRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -401,7 +402,6 @@ pub(crate) struct GetCapabilitiesRsp {
 }
 
 impl GetCapabilitiesRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -592,7 +592,6 @@ pub(crate) struct NegotiateAlgsRsp {
 }
 
 impl NegotiateAlgsRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -762,7 +761,6 @@ pub(crate) struct GetDigestsRsp {
 }
 
 impl GetDigestsRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -924,7 +922,6 @@ pub(crate) struct GetCertificateRsp {
 }
 
 impl GetCertificateRsp {
-    #[expect(dead_code)]
     pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
         self.raw_bytes.get(..self.length).ok_or(EPROTO)
     }
@@ -981,3 +978,152 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self
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
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl ChallengeRsp {
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<'c, T>> for ChallengeRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_CHALLENGE - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let hash_len = context.hash_len();
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
+                .ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        let mut nonce = [0u8; 32];
+        nonce.copy_from_slice(
+            unvalidated
+                .get(nonce_offset..nonce_offset + 32)
+                .ok_or(EPROTO)?,
+        );
+
+        let opaque_data_len = u16::from_le_bytes(
+            unvalidated
+                .get(opaque_len_offset..opaque_len_offset + 2)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        if opaque_data_len > SPDM_MAX_OPAQUE_DATA as u16 {
+            return Err(EPROTO);
+        }
+
+        let opaque_end = opaque_offset + opaque_data_len as usize;
+        let mut opaque_data = KVec::new();
+        opaque_data.extend_from_slice(
+            unvalidated.get(opaque_offset..opaque_end).ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        // `RequesterContext` (8 bytes) is only present in SPDM 1.3 and later.
+        let mut req_context = [0u8; 8];
+        let context_end;
+        if context.version >= SPDM_VER_13 {
+            context_end = opaque_end + 8;
+            req_context.copy_from_slice(unvalidated.get(opaque_end..context_end).ok_or(EPROTO)?);
+        } else {
+            context_end = opaque_end;
+        }
+
+        let signature_end = context_end + context.sig_len;
+        let mut signature = KVec::new();
+        signature.extend_from_slice(
+            unvalidated.get(context_end..signature_end).ok_or(EPROTO)?,
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
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

