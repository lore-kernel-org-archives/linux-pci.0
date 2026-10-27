Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078895;
	b=z2xT/YOmQ0oo7HoItcA6Ai5pLvavhOWrPRihYsBed7nx0Yl+z7fm9nZuaWXw32BJ+6Rd
	 6LF3TEYLKRpcbzqqNKqgS2bmmrxdVGfAgS9kS5I+u7/XW1Ns2OYWUBRMoJxlS1KtC8C2i
	 8G86ZNo3uwE9/sfEuk1R0Yn0a742RDRhs526uXtX8at/iE5aZEG1fVMWo3iUhr08CFbuN
	 ZEn8EQDfFr9pHoUZjH8i/tSx7sxOap6U0grbDHG+RiP3QGWlI3X0Ugz/F6c5Cxac5ynAR
	 qtz5IiMAmkWsoDYqqepIUZWj4UQpSdZBOAMuJe7aXiIjDZxBrG9ShQRct5OKPR6Bo4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078895;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2qxG0IV7oHSsxVohiC35AuoAmHVp7nCjFSNAcc89WrE=;
	b=Nwux9zRBIwf3Lx1mHxn0VIUh52Zd4kxkr1MLXLyX6ftPno6FqGjTEbsGagiYdVMsYGE1
	 mqkpZgLriw2ZbH5d0yTOG+S3b3XR4q2eCpxaxeSOA2A9NI0Wwfna/anfIg1aT6dEPmZAQ
	 Oen3UsyNjlzhRdoLJVrbOj0ddwjYeBt2Tn4JD5z8IviEJZXsxnTGtMORX0n99NrPRckP9
	 hsmNiUmg3NXTqKZQia+orkfkWTJGJSxTeo/TI+8jFgKZPgwFJrwYt1lcnMS+kog4dWZw0
	 shAf/I6orDVmApfaH0bMxUF0rWPR4yz52dBuF0F1PoltwLQY21kxI8ykRMyzDUMkGJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rSm8yHgr;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F031606A32A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F031606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rSm8yHgr
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9995ce866so34941535ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078895; x=1793683695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qxG0IV7oHSsxVohiC35AuoAmHVp7nCjFSNAcc89WrE=;
        b=rSm8yHgr9FPHE0kcDZAAT55JxUi+PjbKN5XUkWRx7KHlUqD8IBh0P3P0wqxdF1jIgF
         h3B6eLFBq+vwH2k1Z91Xyw8PFuvnB/lL2ElNBSHDq6g3MFm26IXYtM4U+tE9NlDA/iFN
         VrroccmH5dA9VAxbfXN4z2Y2QR0rMypBdfjEyTTriYvzAW+LPFQi9zaluQAqBEbggRI3
         hl/W9MGDmfoMu1xAJMkkNMelPbQf+n89zku8BQF6YVqN86nfSPNZYWNeePV9S5RZxMR4
         zeKqb27hRYuxFs0dfNvs9wkFK+8Ba3WHg2MMfdWlbCcM34HnaSAbND6mBRVEBBXOgZ9S
         nMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078895; x=1793683695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2qxG0IV7oHSsxVohiC35AuoAmHVp7nCjFSNAcc89WrE=;
        b=h6esMTEc/ZnF8GJ9Axj/0OS4neZd+Z6l+yemzOuE1Wec9JbOMH161irWWHlPjQdJ2r
         AguD+w5AatetBFn3fqLj2aG1MqLVciPX/rJD1LZQ5gwWVQo4rhWBQNi5q30S19UNrpUI
         rv1knzkG8GAPIGoeixPJz14+crLNNfTQT0L2U47Qx4pN+ueVEBBTtAqjCW6C+IG8/rkG
         3REdP29fCXMJqNQS48SOMjzOVeKrVwgtDwcuCSnQn0ztk48L9fXnSJEoFFWGNIZLnwye
         CCsjWFb3JqSkNXi6s1SDMQ1yfFcCHFhqUBbr297MFWIfa/5v1urXIAwEAQlqq3jAuaCz
         lSOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwl/CZPwhw1S7RAwUFad450St+RILfGkPXw8nS8zL88aDo4QKWOf2yxvF9OFWqa7+kHZGTAFqs7J94=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzBV+tgt6YVbQl9wkyGOJ34A4obgQr+Cr7p/NifQRwVvbgod8b
	kFIdNuk/UUhlbNN4g/wLsJR5/DSTr01kkTXmXWJIBoj/b6vi2znhQT88
X-Gm-Gg: AYBFou0iTZ+PSjceBZbF96DBcXPAVPrvmO0iyjUoufwwZousEUfw7cEVbhMp5jnmWdE
	8VBjvvA+MP7lX8i6g+fFLbqjH7Ms6s8XXDHNCO+Ko7Edt13oL1osxRZz6dyHdad7L6nvyBgGKs6
	4OFX94lXy1p+cjyoEEWVV0orOwr9kjhxT2XEcopjq0Vdfept0hNiS+6QF2wCm4BlNbsTt2WrihR
	8TgG75mbNoSzS9OHLyAiqJSjKs9WiUSG0r3WOp15lEZLlB9GFsFnnoVY/UDUyyoiadSHCpIP9oP
	Pv/l5398ps8KZvr47lAuriepsdibsMs3A4jKEZUGlXrLbk1Lkway5NiCWD4ysaDC3SMnsn3wG0f
	KriXTKUUwiacQktEeXPoHArxJE+jpfBPwGf4Z58mSBvJIbef8JqKduQu1/ed/TSW5zVQee3hRB7
	fA2QYxAyUnHCgD9ZxZ7KlvIEwRnsYP5ujAAlX6dSuOuzXgDx8zEhS4zA7/IBOh6UcnTtSNSjA3X
	Di6GLQK7XUY1kG812oxYyEmB9doLPEL1VlJ7PHw8e1UBqwaqgsHecVesu3LlM7ynbSgRjO/RQ==
X-Received: by 2002:a17:902:f609:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2ea9c62160fmr76192135ad.14.1793078894499;
        Mon, 26 Oct 2026 22:28:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:28:13 -0700 (PDT)
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
Subject: [PATCH v5 19/23] lib: rspdm: Support SPDM get_certificate
Date: Tue, 27 Oct 2026 15:25:32 +1000
Message-ID: <20261027052536.1722081-20-alistair.francis@wdc.com>
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

Support the GET_CERTIFICATE SPDM command.

The kernel will send a GET_CERTIFICATE request to the the responder and
then iterate over all of the certificates returned.

Certificate validation happens in the next commit.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  15 ++++
 lib/rspdm/state.rs     | 100 ++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 162 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 68f347a046859..964ae2a21c6da 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -75,6 +75,8 @@
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index ee7e9be5b41c1..6b0be0a0303fa 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -274,6 +274,21 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
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
index 73c39847d7335..7799d4ac70c3f 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -50,16 +50,21 @@
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
 
 /// Transport for exchanging SPDM messages with a responder device.
@@ -453,4 +458,97 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        let rsp_sz = (GET_CERTIFICATE_RSP_HDR_SZ as u32 + u32::from(u16::MAX))
+            .min(self.transport_sz) as usize;
+
+        request.offset = 0;
+        request.length = (rsp_sz - GET_CERTIFICATE_RSP_HDR_SZ) as u16;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let mut request_buf = request.to_bytes()?;
+        let response: GetCertificateRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
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
+            let response_vec: KVec<u8> = KVec::from_elem(
+                0u8,
+                request.length as usize + GET_CERTIFICATE_RSP_HDR_SZ,
+                GFP_KERNEL,
+            )?;
+
+            let response: GetCertificateRsp = self
+                .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+                .validate(&*self)?;
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
+        let header_length = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len();
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
index f7ad46aef1b88..469a5722368f2 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -12,6 +12,7 @@
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_CERTIFICATE,
     SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
@@ -819,3 +820,164 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self
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
+impl<'a, 'c, T: Transport> Validate<'c, Untrusted<&'a [u8]>, &'c SpdmState<'c, T>>
+    for SpdmCertChain
+{
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        let length = u16::from_le_bytes(
+            unvalidated
+                .get(0..2)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        let root_hash_end = SPDM_CERT_CHAIN_HDR_SZ + context.hash_len();
+        let mut root_hash = KVec::new();
+        root_hash.extend_from_slice(
+            unvalidated
+                .get(SPDM_CERT_CHAIN_HDR_SZ..root_hash_end)
+                .ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        let cert_chain_end = length as usize;
+        let mut certificates = KVec::new();
+        certificates.extend_from_slice(
+            unvalidated
+                .get(root_hash_end..cert_chain_end)
+                .ok_or(EPROTO)?,
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
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl GetCertificateRsp {
+    #[expect(dead_code)]
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<'c, T>>
+    for GetCertificateRsp
+{
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CERTIFICATE - 0x80 {
+            return Err(EPROTO);
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
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+        let remainder_length = u16::from_le_bytes(
+            unvalidated
+                .get(6..8)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        let cert_chain_end = 8 + portion_length as usize;
+
+        let mut cert_chain = KVec::new();
+        cert_chain.extend_from_slice(
+            unvalidated.get(8..cert_chain_end).ok_or(EPROTO)?,
+            GFP_KERNEL,
+        )?;
+
+        Ok(GetCertificateRsp {
+            header,
+            portion_length,
+            remainder_length,
+            cert_chain,
+            length: cert_chain_end,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

