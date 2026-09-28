Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EF360ED0
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559096; cv=none; b=aWF+fwWuwd4KOeKun7KwJ8TECkaV/2T3dGvbpk4x+1iC3EGdWrDSHycwuzLGqH+nmPF3nUyDF0BdnxF1EKiiArMGh+oLI1UMG4U1TmMn6hA8aL9VTdAnQcq8Q6fG5MSGocXdLLG2Mga/gwZbRWUKRmc0OGPTkbH9eHHXzJoeCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559096; c=relaxed/simple;
	bh=yZJky22DK8SoOEpKSdAy5qWRF+Ef1Q8RltBsE50v/BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+m8st5vCj9w9gRCDSxo+Pp4zCrJIKs9epXl6pLpB7/ZyKoiQCsdwM/bCffxMUVWGbb7agOgqDXgNvD4BWTIbDUV85Cw3MOv6Xf6hPYerQRv7xdfRIdimGRCLVgnioh080wy0P0Sr3TuzFWcShFJ6VYgGIMSrnj9UTYJXLX10L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjN3D6/i; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjN3D6/i"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1282667a91.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790559094; x=1791163894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dirh2UEA4WtZV+9yohxG/1+RZRfECh/4CcVZeUY5/Aw=;
        b=FjN3D6/iX6V2G9kUvqo7VMoWG8X2GwZokIdETRbLrvtbPutfidQwHT+zoGBvKjKvK9
         /doRn4Ewe0emBwc1JDAInoF8rN9h/nczc9PrMATpNus1Hw2er/bfqFAZ/QRfCZsL3zZE
         6AFXUk5D/zpFstO1stkLrlPbXRikjMjwsgWpoVivRMb+ZHxkG/GB8nywQthMhe8VJrC9
         NpXz6Q3F3dDgQEkONPmMRK5Us4DVlDD3GdPEkZsl6Uy/WC4wGo4+txR8hNKNLz0ExvTd
         FUpyql55GuDlIUIRRXWhB9D/JwkX2wKlveMDJohO1AIcXMa7RHeHPyPNWq72jlgNS/6Y
         K1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790559094; x=1791163894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dirh2UEA4WtZV+9yohxG/1+RZRfECh/4CcVZeUY5/Aw=;
        b=rcrLidgf6wVKNKQ1Epxov1f3Fvo/ThoHNYFg8gKPaqo2cCE0J8gSnPY1ddMR84dP+M
         qgiXb8nHmSm7jgzOLYy55cYSnS6wWPckh9LtELMlUe27JJsF2uMKoD01ngbimPGschk8
         Xob9avK74upDzlQG1+SFXJlMPsVtqzCVrRTETOiI4xL+5QktbGKgI8pyYJLUyzSrs4v6
         yKD7VDQNwPHFSmb8HQhkU9zecYcdlA6L3Ksr8jEsEB1nWCsd4DhMqhcDZ7/jylfedJLs
         iCuDKxNxOa9HSJpcGy+mDj3mtfgAgbUNWdMqgu/rirF+j7f3aXXcPeTjOl7LZUke5/5S
         Tnrw==
X-Forwarded-Encrypted: i=1; AKwUvBzBLxtjDnyCTz1fOXYHGj+CumxxNWPtfWS3hVjxHHtu5FHxBdvD27VPOVskXFZZlKaOmj/CtAm5sMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiV5SDWqx58Q8AiNNKwrkFxr+cIgQ+T6wVQaxyWx3k10ukMNJ5
	CJAHtxtuAvf5FnrqRrCe+xsgrABUs8fE7tl+YWub4u++eGUkflI3T80v
X-Gm-Gg: AYBFou05KxAg+k+mEqD8m6nj8wbUejYu7tLjDgtjuGk8mMFa+n/HPORg+M1MYGocyAk
	jl8uVcSDoknl4yWLhyGBsXNPxQ74AzzsfQEpbCngK4slBpKC06kBi2PcSyd8hqqFz1nsi7fgBe9
	N3odETh/ViQI3dPYmQyoXjM3vcKS/TUWwoZiOho2cX0sGvyMTse4vcIrHndklDOirok0DrZ8m4z
	BbqCiXwAnNYAoL+giz4EsQlDhy4fpvLR7hFrPTSQAKsAvpLjlpe2TB/B4pe3n1pfsi+tepVbEAa
	kmTIS9nhX31bMZx45vizWC6oz4LHrqz1NHZ2XC/hFHAzDj7t+kr5oztHVDRt67VJ/oEUWgPxqIE
	KEB7POl+jo5sUYzZC8mGmqBwVEFIVZgPdItg+m6plALpKZJm+KFDXJiO2jkg1Ww24FBKiNxMTPs
	fpSNjEvw6OvOSxPAnqMYZefDQdylPrzM9bXcQZlnOOOEGZoqdSotkmSbvcrv+X3xRuQw9MFQGq2
	J7YvUxN6wQSGqKg
X-Received: by 2002:a17:90a:608f:b0:3a0:b61e:e31f with SMTP id 98e67ed59e1d1-3a0b61eea38mr3748176a91.28.1790559093919;
        Sun, 27 Sep 2026 18:31:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm14951084a91.7.2026.09.27.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:31:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: djbw@kernel.org,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	akpm@linux-foundation.org,
	jic23@kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org
Cc: aliceryhl@google.com,
	gregkh@linuxfoundation.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	tmgross@umich.edu,
	wilfred.mallawa@wdc.com,
	alex.gaynor@gmail.com
Subject: [PATCH v4 19/22] lib: rspdm: Support SPDM get_certificate
Date: Mon, 28 Sep 2026 11:31:20 +1000
Message-ID: <20260928013123.566184-1-alistair.francis@wdc.com>
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

Support the GET_CERTIFICATE SPDM command.

The kernel will send a GET_CERTIFICATE request to the the responder and
then iterate over all of the certificates returned.

Certificate validation happens in the next commit.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  15 ++++
 lib/rspdm/state.rs     | 110 ++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 152 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 11e080815aa6..234534c7aa6d 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -148,6 +148,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 92035b1070d1..ee17f4818aeb 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -109,6 +109,21 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
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
index 502d99eb13a6..780b9d459abf 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -52,16 +52,21 @@
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetCertificateReq,
+    GetCertificateRsp,
     GetDigestsReq,
     GetDigestsRsp,
     GetVersionReq,
     GetVersionRsp,
     NegotiateAlgsReq,
     NegotiateAlgsRsp,
+    SpdmCertChain,
     SpdmErrorRsp,
     SpdmHeader,
     GET_CAPABILITIES_RSP_SZ,
-    NEGOTIATE_ALGS_RSP_SZ, //
+    GET_CERTIFICATE_RSP_HDR_SZ,
+    NEGOTIATE_ALGS_RSP_SZ,
+    SPDM_CERT_CHAIN_HDR_SZ, //
 };
 
 /// The current SPDM session state for a device.
@@ -654,4 +659,107 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn get_cert_exchange(
+        &mut self,
+        request_buf: &mut [u8],
+        response_vec: &mut KVec<u8>,
+    ) -> Result<GetCertificateRsp, Error> {
+        let len = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+        response_vec.truncate(len);
+
+        let response: GetCertificateRsp =
+            Untrusted::new(response_vec.as_slice()).validate(&*self)?;
+
+        Ok(response)
+    }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        let rsp_sz =
+            (GET_CERTIFICATE_RSP_HDR_SZ as u32 + u16::MAX as u32).min(self.transport_sz) as usize;
+
+        request.offset = 0;
+        request.length = (rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ) as u16;
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let mut request_buf = request.to_bytes()?;
+        let response = self.get_cert_exchange(request_buf.as_mut_slice(), &mut response_vec)?;
+
+        if (response.header.param1 & 0xF) != slot {
+            pr_err!("Invalid slot response\n");
+            return Err(EPROTO);
+        }
+
+        let portion_length = response.portion_length;
+        let rem_length = response.remainder_length;
+
+        let total_cert_len = portion_length as usize + rem_length as usize;
+
+        let mut certs_buf: KVec<u8> = KVec::new();
+
+        certs_buf.extend_from_slice(&response.cert_chain, GFP_KERNEL)?;
+
+        let mut offset: u16 = portion_length;
+        let mut remainder_length = rem_length as usize;
+
+        while remainder_length > 0 {
+            request.offset = offset;
+            request.length = (remainder_length.min(rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ)) as u16;
+
+            let mut request_buf = request.to_bytes()?;
+
+            response_vec.resize(
+                request.length as usize + GET_CERTIFICATE_RSP_HDR_SZ,
+                0,
+                GFP_KERNEL,
+            )?;
+
+            let response = self.get_cert_exchange(request_buf.as_mut_slice(), &mut response_vec)?;
+
+            let portion_length = response.portion_length;
+            let rem_length = response.remainder_length;
+
+            if portion_length == 0
+                || (response.header.param1 & 0xF) != slot
+                || offset as usize + portion_length as usize + rem_length as usize != total_cert_len
+            {
+                pr_err!("Malformed certificate response\n");
+                return Err(EPROTO);
+            }
+
+            certs_buf.extend_from_slice(&response.cert_chain, GFP_KERNEL)?;
+            let (val, overflow) = offset.overflowing_add(portion_length);
+            if overflow {
+                pr_err!("portion_length  response overflowed\n");
+                return Err(EPROTO);
+            }
+            offset = val;
+            remainder_length = rem_length as usize;
+        }
+
+        let header_length = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len;
+
+        if total_cert_len < header_length || total_cert_len != certs_buf.len() {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        let certs: SpdmCertChain = Untrusted::new(certs_buf.as_slice()).validate(&*self)?;
+        let cert_chain_length = certs.length as usize;
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
index c058dde31440..f4e9485179d0 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -26,6 +26,7 @@
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
@@ -794,3 +795,154 @@ fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self
         })
     }
 }
+
+pub(crate) struct GetCertificateReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) offset: u16,
+    pub(crate) length: u16,
+}
+
+impl GetCertificateReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        out.extend_from_slice(&self.offset.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&self.length.to_le_bytes(), GFP_KERNEL)?;
+
+        Ok(out)
+    }
+}
+
+impl Default for GetCertificateReq {
+    fn default() -> Self {
+        GetCertificateReq {
+            header: SpdmHeader::new(SPDM_GET_CERTIFICATE),
+
+            offset: 0,
+            length: 0,
+        }
+    }
+}
+
+pub(crate) const GET_CERTIFICATE_RSP_HDR_SZ: usize = mem::size_of::<SpdmHeader>() + 4;
+
+pub(crate) const SPDM_CERT_CHAIN_HDR_SZ: usize = mem::size_of::<u16>() + 2;
+
+/// A parsed SPDM certificate chain
+#[expect(dead_code)]
+pub(crate) struct SpdmCertChain {
+    // `length` is a u16 (with 2 bytes reserved) for SPDM versions 1.3
+    // and lower and u32 for 1.4. We don't currently support `LargeOffset`
+    // and `LargeLength`, so let's pretend this is always a u16
+    pub(crate) length: u16,
+
+    pub(crate) root_hash: KVec<u8>,
+
+    pub(crate) certificates: KVec<u8>,
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for SpdmCertChain {
+    type Err = Error;
+
+    type Context = &'c SpdmState<'c>;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
+        let length = u16::from_le_bytes(
+            unvalidated
+                .get(0..2)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+
+        let root_hash_end = SPDM_CERT_CHAIN_HDR_SZ + context.hash_len;
+        let mut root_hash = KVec::new();
+        root_hash.extend_from_slice(
+            unvalidated
+                .get(SPDM_CERT_CHAIN_HDR_SZ..root_hash_end)
+                .ok_or(EIO)?,
+            GFP_KERNEL,
+        )?;
+
+        let cert_chain_end = length as usize - root_hash_end;
+        let mut certificates = KVec::new();
+        certificates.extend_from_slice(
+            unvalidated.get(root_hash_end..cert_chain_end).ok_or(EIO)?,
+            GFP_KERNEL,
+        )?;
+
+        Ok(SpdmCertChain {
+            length,
+            root_hash,
+            certificates,
+        })
+    }
+}
+
+pub(crate) struct GetCertificateRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) portion_length: u16,
+    pub(crate) remainder_length: u16,
+
+    pub(crate) cert_chain: KVec<u8>,
+
+    /// Size of the response, not public
+    length: usize,
+}
+
+impl GetCertificateRsp {
+    #[expect(dead_code)]
+    pub(crate) fn len(&self) -> usize {
+        self.length
+    }
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetCertificateRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState<'c>;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CERTIFICATE - 0x80 {
+            return Err(EINVAL);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let portion_length = u16::from_le_bytes(
+            unvalidated
+                .get(4..6)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+        let remainder_length = u16::from_le_bytes(
+            unvalidated
+                .get(6..8)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+
+        let cert_chain_end = 8 + portion_length as usize;
+
+        let mut cert_chain = KVec::new();
+        cert_chain.extend_from_slice(unvalidated.get(8..cert_chain_end).ok_or(EIO)?, GFP_KERNEL)?;
+
+        Ok(GetCertificateRsp {
+            header,
+            portion_length,
+            remainder_length,
+            cert_chain,
+            length: cert_chain_end,
+        })
+    }
+}
-- 
2.55.0

