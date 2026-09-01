Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAC3ACA61
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224801; cv=none; b=uZiAdSv57SUpDhTYT5nJ9f51XeprZ0LiRlWr69NqbDRfSyAy8EQcBOPARuXZgxV/8ZeYgBy4VDVGGoBulwxz30BrtxUhWJihFXX3c4byPvs/ulkuwUsxyFyG+C73ua/R9Z7Y62f6COAxOaXnvd4Yt856MPZfMZG5MbfBMILXRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224801; c=relaxed/simple;
	bh=IWnqH1KNMEWGoDHsmLCK8gxjTirLjJDTUkD7YT6d8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP9R/u1mE9h9PSinIJGRh7npHfMPr3tI31p5i0Z5DQ29SUkimBYN+1ibuVaSdpoUmlzpRtzfy7p6h7yWootfcxhgCtUGtaqtjNynvcQo2t4XPjaTVC4ZpVhuygr3Ien+cplHkuywyefrxsjq3C769lh9LoTdZDhKsEdLGFYLZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRkcKlL4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRkcKlL4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso460629a91.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224797; x=1788829597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcjtJK01U5ABqRyyI3Y6HZHJVX25NC98kRl2mqG1tN8=;
        b=XRkcKlL4ni86UP4S+ALp/zMjhnu2mZkviTAZJkRjJpRCTmE7uJyxcrrG+WauGdj+F3
         0PyfJFd/bnWavJV6lGxSrgOEtptEAGqFCIAlwoQpjnNAMQfPPKHUvDcITEMRqG42LTe/
         PgnR+TBnvpQpgbPbP73VbWA1qulPz55oUZ3XSfww9bmpaR8d08Kz5T2bRjt98VSJJwGl
         HTka5VS1l5InjDvIf5I42qV4tvQEhA6NserWOZADuLokh4jaRb7awVLGahOhgqlFftBC
         9MJYzri1c2ihr/OmDFCUzwvZxvW9EV9UgWxs0UkPxvFLyt0gh0dg9OP+29gIfHT/KFy4
         EcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224797; x=1788829597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcjtJK01U5ABqRyyI3Y6HZHJVX25NC98kRl2mqG1tN8=;
        b=R9USDta67zNsi5xhBNCiug1EnlIKWpZiAH4kdnrlQvpzAA5rex+y0BJU5/+2Hkp6t6
         yLv70pzSi4OFtP4cbncmyZ05I7d1CUPLcO/jlmxDKDwUvVWCKtIaytwpWT7T/ZDc32/0
         CDrTGxVlrIDllinMaXJKw6LLF27AEL8EgGRYDVTTfA+0muVy2C5DReDOYdyv/iXDjr6U
         RSwmkrC1xe3HzQ9dKSR+HrajUE+41i4LNEWaK6JfoWpH50sosOMNK14zS0LtryxLzbOA
         Fe7ThV8/EihaDRtfIFrjS0bx/2Cf3q3NItnHSBjSkNLrDqwZZ6ye8jUkEmzXgFQm7JX9
         r6Fw==
X-Gm-Message-State: AFuF++lKRGi+XDPZEmd9tV4XShMnM499hHNwL/nmaIIsXmIkh0f08wrc
	ieYwveINZYkbd7epoWiQ84bqM6Batbps+OkhmcaQR3s4/+XCmKNX/zVkkr3w8A==
X-Gm-Gg: AYBFou2+q75QEiAnbMVyZxpg1FfYsVVhbHHnI3tXo7RXCu/WQ7H2SGJ7/NMD+j3vbIu
	wOVQy7oNdTXmISWI78Yl9ySnpqvPv2HLfBXVA9XPqOY17OBvjc0nQZy6tFIFQi/RzlzFCMVBfDe
	2/Ryea58pfzvU+Z0sj1f8bk6yBJ8RUzX41+RcMyo9/4Zr868vtNwhNkS1MwSbZ28svXQZeSED2s
	kyh8ugQDqtuycxzHMyQpkfLZvUuhn2zBLQqloyvsRe4zzc0W5qSke7F9ub6Im4OEsuCAgrd4AXd
	9nL126NG5xcJD97jzQXTY2Y6mJPcIrg6b1kqT1gXFgSh6F7xFCgQbeWWMAySyhaDNA897Rvryp9
	1dmjdQE53IAwrceH8PE/EQbqY6f2RPW5oIdJbhdsFE4aa5/f7UDngrt9Ee3gMJXTphp68H+UNmj
	OHqN0MBPlOjlQoH/auhYTExvFGnIB/6mZLosmt2nWp3TSl5KQA/0n7IyUubdcVGmd3Kz/q5FX1x
	zFJDJT68JIIvQpL
X-Received: by 2002:a17:90b:54c6:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-396d0e24bdamr49357609a91.1.1788224796951;
        Mon, 31 Aug 2026 18:06:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:06:36 -0700 (PDT)
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
Subject: [PATCH v3 18/21] lib: rspdm: Support SPDM get_certificate
Date: Tue,  1 Sep 2026 11:03:44 +1000
Message-ID: <20260901010347.2614656-19-alistair.francis@wdc.com>
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

Support the GET_CERTIFICATE SPDM command.

The kernel will send a GET_CERTIFICATE request to the the responder and
then iterate over all of the certificates returned.

Certificate validation happens in the next commit.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  15 ++++
 lib/rspdm/state.rs     | 156 +++++++++++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs |  65 +++++++++++++++++
 4 files changed, 238 insertions(+)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index c4d9521866af..2fbc4ab41869 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -146,6 +146,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index bda5f91ca13c..488203be821d 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -114,6 +114,21 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if state.provisioned_slots == 0 {
+        return -(bindings::EIO as c_int);
+    }
+
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.get_certificate(slot) {
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 131c22319b26..1e8a4402e634 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -53,6 +53,8 @@
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetCertificateReq,
+    GetCertificateRsp,
     GetDigestsReq,
     GetDigestsRsp,
     GetVersionReq,
@@ -159,6 +161,17 @@ fn drop(&mut self) {
     }
 }
 
+#[repr(C, packed)]
+pub(crate) struct SpdmCertChain {
+    // `length` is a u16 (with 2 bytes reserved) for SPDM versions 1.3
+    // and lower and u32 for 1.4. We don't currently support `LargeOffset`
+    // and `LargeLength`, so let's pretend this is always a u16
+    length: u16,
+    _reserved: [u8; 2],
+    root_hash: bindings::__IncompleteArrayField<u8>,
+    certificates: bindings::__IncompleteArrayField<u8>,
+}
+
 impl SpdmState<'_> {
     pub(crate) fn new(
         dev: *mut bindings::device,
@@ -690,4 +703,147 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn get_cert_exchange<'a>(
+        &mut self,
+        request_buf: &mut [u8],
+        response_vec: &'a mut KVec<u8>,
+    ) -> Result<&'a GetCertificateRsp, Error> {
+        let len = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if len < core::mem::size_of::<GetCertificateRsp>() {
+            pr_err!("Truncated certificate response\n");
+            return Err(EIO);
+        }
+        if len > response_vec.len() {
+            pr_err!("Overflowed get certificate response\n");
+            return Err(EIO);
+        }
+        response_vec.truncate(len);
+
+        let response: &GetCertificateRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+
+        if len
+            < core::mem::size_of::<GetCertificateRsp>()
+                + u16::from_le(response.portion_length) as usize
+        {
+            pr_err!("Truncated certificate response\n");
+            return Err(EIO);
+        }
+
+        Ok(response)
+    }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.version = self.version;
+        request.param1 = slot;
+
+        let req_sz = core::mem::size_of::<GetCertificateReq>();
+        let rsp_sz = (core::mem::size_of::<GetCertificateRsp>() as u32 + u16::MAX as u32)
+            .min(self.transport_sz) as usize;
+
+        request.offset = 0;
+        request.length = ((rsp_sz - core::mem::size_of::<GetCertificateRsp>()) as u16).to_le();
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let response = self.get_cert_exchange(request_buf, &mut response_vec)?;
+
+        if response.param1 != slot {
+            pr_err!("Invalid slot response\n");
+            return Err(EPROTO);
+        }
+
+        let portion_length = response.portion_length;
+        let rem_length = response.remainder_length;
+
+        let total_cert_len = u16::from_le(portion_length) as usize
+            + u16::from_le(response.remainder_length) as usize;
+
+        let mut certs_buf: KVec<u8> = KVec::new();
+
+        certs_buf.extend_from_slice(
+            &response_vec[8..(8 + u16::from_le(portion_length) as usize)],
+            GFP_KERNEL,
+        )?;
+
+        let mut offset: u16 = u16::from_le(portion_length);
+        let mut remainder_length = u16::from_le(rem_length) as usize;
+
+        while remainder_length > 0 {
+            request.offset = offset.to_le();
+            request.length =
+                ((remainder_length.min(rsp_sz - core::mem::size_of::<GetCertificateRsp>())) as u16)
+                    .to_le();
+
+            let request_buf =
+                unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+            response_vec.resize(
+                request.length as usize + core::mem::size_of::<GetCertificateRsp>(),
+                0,
+                GFP_KERNEL,
+            )?;
+
+            let response = self.get_cert_exchange(request_buf, &mut response_vec)?;
+
+            let portion_length = response.portion_length;
+            let rem_length = response.remainder_length;
+
+            if u16::from_le(portion_length) == 0
+                || (response.param1 & 0xF) != slot
+                || offset as usize
+                    + u16::from_le(portion_length) as usize
+                    + u16::from_le(rem_length) as usize
+                    != total_cert_len
+            {
+                pr_err!("Malformed certificate response\n");
+                return Err(EPROTO);
+            }
+
+            certs_buf.extend_from_slice(
+                &response_vec[8..(8 + u16::from_le(portion_length) as usize)],
+                GFP_KERNEL,
+            )?;
+            let (val, overflow) = offset.overflowing_add(u16::from_le(portion_length));
+            if overflow {
+                pr_err!("portion_length  response overflowed\n");
+                return Err(EPROTO);
+            }
+            offset = val;
+            remainder_length = u16::from_le(rem_length) as usize;
+        }
+
+        let header_length = core::mem::size_of::<SpdmCertChain>() + self.hash_len;
+
+        if total_cert_len < header_length as usize || total_cert_len != certs_buf.len() {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        let cert_chain_length = {
+            let ptr = certs_buf.as_ptr();
+            // SAFETY: `SpdmCertChain` is repr(C) and packed. We just
+            // checked the length above so we can convert it from a slice
+            let ptr = ptr.cast::<SpdmCertChain>();
+            // SAFETY: `ptr` came from a reference and the cast above is valid.
+            let certs: &SpdmCertChain = unsafe { &*ptr };
+            u16::from_le(certs.length) as usize
+        };
+
+        if total_cert_len != cert_chain_length {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        self.certs[slot as usize].clear();
+        self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_KERNEL)?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index ddbf5c448bd7..2584bed73979 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -30,6 +30,7 @@
     SPDM_ASYM_ALGOS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
@@ -426,3 +427,67 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) offset: u16,
+    pub(crate) length: u16,
+}
+
+impl Default for GetCertificateReq {
+    fn default() -> Self {
+        GetCertificateReq {
+            version: 0,
+            code: SPDM_GET_CERTIFICATE,
+            param1: 0,
+            param2: 0,
+            offset: 0,
+            length: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) portion_length: u16,
+    pub(crate) remainder_length: u16,
+
+    pub(crate) cert_chain: __IncompleteArrayField<u8>,
+}
+
+impl<'a> Validate<Untrusted<&'a [u8]>> for &'a GetCertificateRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<GetCertificateRsp>() {
+            return Err(EINVAL);
+        }
+
+        let rsp_sz = core::mem::size_of::<SpdmHeader>()
+            + 4
+            + (*(unvalidated.get(4).ok_or(EINVAL))? as usize)
+            + ((*(unvalidated.get(5).ok_or(EINVAL))? as usize) << 8);
+
+        if unvalidated.len() < rsp_sz {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `GetCertificateRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCertificateRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &GetCertificateRsp = unsafe { &*ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.55.0

