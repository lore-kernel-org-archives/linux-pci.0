Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A6347BA5
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780695; cv=none; b=WASGrAuFGNoq4ixqLwn1GlrrRuPrS35W2BtP6mn/w09pn9waAQlX0yTKlXB2M4fYKiqT4MjBCQriBzh3JbtZyCXv5FTaIk4p8g+WUb8RuY2U81jkN+OgKR5R3djIsmd5MLIeaJSDOMeEjfRKIibecvrQkBmUChWnEfyDXVJZKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780695; c=relaxed/simple;
	bh=CWbi7ALF7uXVajfdmBOV0S2JNV4FoET3qqXamDPH+P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sqr2E3kHWjPyavusyO569TkT9KFzcoHqsuxJa2n3ruEA+BqAaV2AnBNZlpd3AkdNx/m9ZJiIbuDdBfpPpBFrjNXVZHOKNWGrqgHU9hEafFaPVjZMaepVQJ+6iqTGAo+uWyPhahX/H/0AgQvelX1tewXRC7y1XLKzYxPB5gkmKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbrmKSgh; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbrmKSgh"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3566af9900eso759915a91.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780693; x=1771385493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj5rwsWyL707FPhO2cj5eD0A9z9ELu50StQ0l12ODmY=;
        b=RbrmKSghA9aC9myCEnjAI6fgEDO33Hk1lxbYOvLR6YqEywSIVwyIXy0qjNuK/ZoLq8
         bfXiSlSkH+XhgJYmkfErOM38woxQfm+ooVHgeCR5xTzZAIm0OKlEEzpsTNc4fxBh79VY
         PFZvrMLGYQ2dVG6D2zT0Nm0X5uazDLvVfaYCi6wNBpEUvBxK6KJtYz1QelBrmWDznKQ4
         C33KuSYLzH/8stqekGxk4MBnDN2Ct4vW52t5GVBSFYKzwXYgulM/49JNCetnt3/Ltlb3
         2W1WnWzkSFAS5y9grVwuw507URpCdeg2gvNl//P+ZS7MxT33l/QiEH22y4xZkAYD9n2L
         68OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780693; x=1771385493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj5rwsWyL707FPhO2cj5eD0A9z9ELu50StQ0l12ODmY=;
        b=hd1mYisIIGSP1urKZmHft+o8aOQldLjsyciydbi9bS0lXWoLv/TFzbVzifCQ0YncCo
         1zXAWozZB0Q3MyXmoyjDkebi/UPxon7/RWEu1KEVzG1cFdffcYw8dKFPIv1A/Ok3MVQZ
         Xtcr/7Miivig8V5N55iivpC9DZURRxw0lbtCH4+QY+6wd35iPaKfJ8DFYy53nYmFG+AG
         rIO6YCL5rBun7cz1Js06AE+lHEBzSMhFF1RHt4LsQkczM+8VLfMbK7lBI4VL5PKAMp4t
         rHHoCz52QaAOFeq4b46eHRIWcs/YIJifBXgk+1uDJbYalrNVMYS3Kjl8dfsq+uk/cE0Q
         nLtw==
X-Forwarded-Encrypted: i=1; AJvYcCXtfNKPvBrRosNLx8Z/bEnyV/cQo6VkSumNGj4lkNouQD3OmzNECVe9HVTbhsu7Panpb6ktL4jmero=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFmHUpf2UVqOFRy3rMpPOoVT5bfLv+rLjOKb6JKnS1d7MVuNm
	t6shYTAiibmHO/W0g4eNvUvF974XjTIEVsO2VNaV2FzHpwJukBNY/Sq1
X-Gm-Gg: AZuq6aJRB/ZgI7XFkeLZv+1R+1SuyRth7nRbFjCcjXfwxJHpuYJJeh9z7mlP+FvVbtT
	F6QrsMptFlZqMAiV5IZH7WZUa/aSf2LlqAOzPWoAemLhIgPRxWSSJAap8WuQsQ/vmhQO9ICVrBh
	eoqxBCkG4OtHQmn/s6/4MtpApq9tm4QuUAQSWNP/+D3gc3Ht97OWFOuFMTzZza3UclBEyD0OZhP
	qlIpwbXSsSXGdukPunva7w+O9YgbR/u5qNNh2I0tuWGHGPPmdLvEtuq/Kes7HZ7gnnVXK8uCsle
	utnLyxKC2EYtK88xTQvhptZNawFxKuj2kY3w6qsxb8rrUbFUK/ywqDXiKboWG0hMjwZzfyC+MvQ
	EhG4SJBqhWo5TmFBnXb3uJltOFQIzHpFBPTd7mGiKcO+1WHuJGcytAPZARKoNRuIJgSzWSpeQOh
	K76VzgLw59nXHVoXlcIhy4eKoxr0oyf/iqvc1OxriywQ==
X-Received: by 2002:a17:90b:240e:b0:356:1edc:b68 with SMTP id 98e67ed59e1d1-3561edc10a7mr8858788a91.12.1770780693030;
        Tue, 10 Feb 2026 19:31:33 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:31:32 -0800 (PST)
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
Subject: [RFC v3 15/27] lib: rspdm: Support SPDM get_digests
Date: Wed, 11 Feb 2026 13:29:22 +1000
Message-ID: <20260211032935.2705841-16-alistair.francis@wdc.com>
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

Support the GET_DIGESTS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |  4 ++
 lib/rspdm/lib.rs       |  4 ++
 lib/rspdm/state.rs     | 87 ++++++++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 52 ++++++++++++++++++++++++-
 4 files changed, 142 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index e8a05fd4299b..4d39ca2cb584 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -16,6 +16,8 @@
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 pub(crate) const SPDM_VER_13: u8 = 0x13;
 
+pub(crate) const SPDM_SLOTS: usize = 8;
+
 pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
 pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_13;
 
@@ -170,6 +172,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_HASH_SHA_384: u32 = 1 << 1;
 pub(crate) const SPDM_HASH_SHA_512: u32 = 1 << 2;
 
+pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
+
 #[cfg(CONFIG_CRYPTO_RSA)]
 pub(crate) const SPDM_ASYM_RSA: u32 =
     SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 33f706a55e09..a7af86d1dc0b 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -121,6 +121,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_digests() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index d0b10f27cd9c..2606b825c494 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -23,11 +23,11 @@
     SPDM_ASYM_RSASSA_4096, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_HASH_ALGOS, SPDM_HASH_SHA_256,
     SPDM_HASH_SHA_384, SPDM_HASH_SHA_512, SPDM_KEY_EX_CAP, SPDM_MAX_VER, SPDM_MEAS_CAP_MASK,
     SPDM_MEAS_SPEC_DMTF, SPDM_MIN_DATA_TRANSFER_SIZE, SPDM_MIN_VER, SPDM_OPAQUE_DATA_FMT_GENERAL,
-    SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
+    SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq,
-    NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetDigestsReq, GetDigestsRsp, GetVersionReq,
+    GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
 };
 
 /// The current SPDM session state for a device. Based on the
@@ -54,6 +54,10 @@
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
@@ -68,6 +72,9 @@
 /// @desc: Synchronous hash context for @base_hash_alg computation.
 /// @hash_len: Hash length of @base_hash_alg (in bytes).
 ///  H in SPDM specification.
+/// @slot: Certificate chain in each of the 8 slots.  NULL pointer if a slot is
+///  not populated.  Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
+/// @slot_sz: Certificate chain size (in bytes).
 #[expect(dead_code)]
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
@@ -83,6 +90,8 @@ pub struct SpdmState {
     pub(crate) base_asym_alg: u32,
     pub(crate) base_hash_alg: u32,
     pub(crate) meas_hash_alg: u32,
+    pub(crate) supported_slots: u8,
+    pub(crate) provisioned_slots: u8,
 
     /* Signature algorithm */
     base_asym_enc: &'static CStr,
@@ -93,6 +102,9 @@ pub struct SpdmState {
     pub(crate) shash: *mut bindings::crypto_shash,
     pub(crate) desc: Option<&'static mut bindings::shash_desc>,
     pub(crate) hash_len: usize,
+
+    // Certificates
+    pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
 }
 
 impl SpdmState {
@@ -116,12 +128,15 @@ pub(crate) fn new(
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
 
@@ -539,4 +554,70 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
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
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (core::mem::size_of::<GetDigestsRsp>() as i32) {
+            pr_err!("Truncated digests response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut GetDigestsRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        if rc
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
+        if self.version >= 0x13 && (response.param2 & !response.param1 != 0) {
+            pr_err!("Malformed digests response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        let supported_slots = if self.version >= 0x13 {
+            response.param1
+        } else {
+            0xFF
+        };
+
+        if self.supported_slots != supported_slots {
+            self.supported_slots = supported_slots;
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 036a077c71c3..2150a23997db 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -17,8 +17,8 @@
 };
 
 use crate::consts::{
-    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_VERSION, SPDM_HASH_ALGOS,
-    SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
+    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_DIGESTS, SPDM_GET_VERSION,
+    SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
 };
 
 #[repr(C, packed)]
@@ -316,3 +316,51 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
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

