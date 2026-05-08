Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67F30649C
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210362; cv=none; b=oGO9mWJHnbYcfb8I8Mc02ylGa4dzIVffnyabjCcF9xUkpMZDGIxlq3tYmnPzMz5OQ1DCsnyhpLGdx2bRbXIG9bTHulHinIdto64Kdw51jdeR8w33RjhRyw7Mjf9JUh2lAXcatBgEol4Nsxv71Ul3PnsGwQAt0QRZmglSbQKTybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210362; c=relaxed/simple;
	bh=+u7xQEzNizVtFbuUgfS6lhYyyTH742ns1cL9wfJM1LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQwBp7LehJnA1p9QOC12ECDtArGsr+orafR1TimxugM2JW4bAlIDDGZ52GHDwRElF4zdfIGHA7bxGiOU3WDl5m8TBjVOi60PSAKrwQXStQUoo/Xnx6Y3ouvc1ReZpKh8B7+e/yFe4vlF4Xyx+36Jc4AsDTshPwemzKBn9llDSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3ck/rJI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3ck/rJI"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b4583f0a1aso9821685ad.3
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210357; x=1778815157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5yFibE0g6zKCTQxNoAPCceSLwiIHsT8Mf+vzQJztPA=;
        b=I3ck/rJICN2ZFPqPiH+rpsijlFvCQoQKQlzdLmOJ3lXyUbXrgHj+Clcxn1s+QwzdBk
         qpLDJe58hAcVvs2lhQfTa8geuFB2ZxY2K7/Rqn7gA3GRzwv818d1xCdvDtaxGO9nDiUU
         nytMs9SgQAEWLvJyhYURzElcOo8Na2xsvEMcHWnYfK/O4uJA9DUmLLZ6z+SO2AOPF6aY
         WPtS+62nWKy0zSv9UHlPqwi/h+1k8oNOQcxBfhmwZXMA1ceEBErQkSv9kq/uOsvnqDdV
         dm2bhcvT+h6Gd1mMP8HkVdm27E4/XqmZ2Du3G6kBXLaUbg4cUyWfizUle2THSm+c7i8M
         B98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210357; x=1778815157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u5yFibE0g6zKCTQxNoAPCceSLwiIHsT8Mf+vzQJztPA=;
        b=HDmA5KQfK5oww5oHP4XVznNj434g4XJjtPY6QoFg0N47izTkHUXwu+biJuPZueL3fb
         ddTV+MTB0aFpP2PuH6ghx6qdYJ/x6pn4ngzcX8tSdP1k+a1up293npqtGLL0mP0/2GXV
         o9R72PNzZbQn8Y9jztVL7hB2IJRxzrsR+g8mrl/SdfGb1to+LAc85Y/ZNgbGbVorRJT6
         DWR6TCnGQTyVxZPrlK+aZ0tmVzykclWHAX+beYUR3a2tbtXG51uifoWp217IRoEEvgim
         RthUqLFGSxwbtKKWwnnFhJlpwatS7tyl+dAD3USWYpwTGCiXJeuDdeLhzsN4BNd8B3bf
         fh8A==
X-Forwarded-Encrypted: i=1; AFNElJ+aZ1r6UC28XALSbQUrq7D+jI36POTZ3pSDYbUKkzCgLdQJZqCO8MtHv8jKtD2KEgFEyl0MqqT1FxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtgW6t83Sh0R9o4sa0fAaaV5ukwiy7Z3hyJ2eYhcfcnkB3vuz
	oZimFReBBPlCow49Om+xgA30K4jITgrtou1LWBPGQKAgsUxqOHMtFk1J
X-Gm-Gg: Acq92OEjZp4N1PKgOBwtOagok2VA/EaG+PwTQTamQsKE+7AZN356kTV/ADwAZ8uSJH7
	THDZxgm6aNDMdQ9BIiGS+Sfivgy/5I8hQrWx5gldIzE6rx51iPOQE7oYhGGNRGsM1TLAM4iuGni
	IUl7/5jYpn/+E6hsSj2vXlx4nanhTL8We6YLYNa9mVFVB+jka04Oc7284Nj57Jng/sIlFz8+DD2
	gADdiAmXZ00mYJ8nxb9ItriDyPypf6peVh4qqGTzbNkV5No81PN6SIta2fCg7bInOoXGwdc3Mk0
	do3hGrtuPV1Cd2lcYkCzJqL6yy5kOtKqkLBSU3fVQXizm/oYOyjhjKcxs4gBoXeajQV/SpJ64jJ
	jP9cQTc82x4zm6gH5jkhPTuHpqZYc75Pnrz5WxxegcXttPaUH2QLIQ9sQk7g74/k4apPm0AfFLV
	hsr7vlIZCtwcG6HsNHKX4AAij3BHyjsxS+tnKSK1RT
X-Received: by 2002:a17:903:4b2b:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2ba798bb914mr119191635ad.33.1778210356592;
        Thu, 07 May 2026 20:19:16 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:19:16 -0700 (PDT)
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
Subject: [PATCH 15/18] lib: rspdm: Support SPDM get_certificate
Date: Fri,  8 May 2026 13:17:07 +1000
Message-ID: <20260508031710.514574-16-alistair.francis@wdc.com>
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

Support the GET_CERTIFICATE SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  11 ++++
 lib/rspdm/state.rs     | 125 +++++++++++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs |  57 +++++++++++++++++++
 4 files changed, 195 insertions(+)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 092205dab74d..302bc0285478 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -114,6 +114,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index e42cfdd35524..d5aee761003a 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -124,6 +124,17 @@
         return e.to_errno() as c_int;
     }
 
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
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index bcb1cc955c4c..69b6f67a6ef5 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -55,6 +55,8 @@
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetCertificateReq,
+    GetCertificateRsp,
     GetDigestsReq,
     GetDigestsRsp,
     GetVersionReq,
@@ -135,6 +137,14 @@ pub struct SpdmState {
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
 }
 
+#[repr(C, packed)]
+pub(crate) struct SpdmCertChain {
+    length: u16,
+    _reserved: [u8; 2],
+    root_hash: bindings::__IncompleteArrayField<u8>,
+    certificates: bindings::__IncompleteArrayField<u8>,
+}
+
 impl SpdmState {
     pub(crate) fn new(
         dev: *mut bindings::device,
@@ -661,4 +671,119 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn get_cert_exchange(
+        &mut self,
+        request_buf: &mut [u8],
+        response_vec: &mut KVec<u8>,
+        rsp_sz: usize,
+    ) -> Result<&mut GetCertificateRsp, Error> {
+        // SAFETY: `response_vec` is rsp_sz length, initialised, aligned
+        // and won't be mutated
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (core::mem::size_of::<GetCertificateReq>() as i32) {
+            pr_err!("Truncated certificate response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut GetCertificateRsp = Untrusted::new_mut(response_vec).validate_mut()?;
+
+        if rc
+            < (core::mem::size_of::<GetCertificateRsp>() + response.portion_length as usize) as i32
+        {
+            pr_err!("Truncated certificate response\n");
+            to_result(-(bindings::EIO as i32))?;
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
+        request.length = (rsp_sz - core::mem::size_of::<GetCertificateRsp>()) as u16;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+
+        let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
+
+        let total_cert_len =
+            ((response.portion_length + response.remainder_length) & 0xFFFF) as usize;
+
+        let mut certs_buf: KVec<u8> = KVec::new();
+
+        certs_buf.extend_from_slice(
+            &response_vec[8..(8 + response.portion_length as usize)],
+            GFP_KERNEL,
+        )?;
+
+        let mut offset: usize = response.portion_length as usize;
+        let mut remainder_length = response.remainder_length as usize;
+
+        while remainder_length > 0 {
+            request.offset = offset.to_le() as u16;
+            request.length =
+                ((remainder_length.min(rsp_sz - core::mem::size_of::<GetCertificateRsp>())) as u16)
+                    .to_le();
+
+            let request_buf =
+                unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+            let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
+
+            if response.portion_length == 0
+                || (response.param1 & 0xF) != slot
+                || offset as u16 + response.portion_length + response.remainder_length
+                    != total_cert_len as u16
+            {
+                pr_err!("Malformed certificate response\n");
+                to_result(-(bindings::EPROTO as i32))?;
+            }
+
+            certs_buf.extend_from_slice(
+                &response_vec[8..(8 + response.portion_length as usize)],
+                GFP_KERNEL,
+            )?;
+            offset += response.portion_length as usize;
+            remainder_length = response.remainder_length as usize;
+        }
+
+        let header_length = core::mem::size_of::<SpdmCertChain>() + self.hash_len;
+
+        let ptr = certs_buf.as_mut_ptr();
+        // SAFETY: `SpdmCertChain` is repr(C) and packed, so we can convert it from a slice
+        let ptr = ptr.cast::<SpdmCertChain>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let certs: &mut SpdmCertChain = unsafe { &mut *ptr };
+
+        if total_cert_len < header_length
+            || total_cert_len as u16 != certs.length
+            || total_cert_len != certs_buf.len()
+        {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        self.certs[slot as usize].clear();
+        self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_KERNEL)?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 1e5ee8a7582b..8b44a056b335 100644
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
@@ -403,3 +404,59 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
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
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCertificateRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetCertificateRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetCertificateRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCertificateRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetCertificateRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

