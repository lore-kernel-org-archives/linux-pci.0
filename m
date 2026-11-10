Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284488;
	b=HfxnFxqf7Ef87ZOWxPH2f8cWKrETOpybQXlNYfWEhLOuE3W5uwJR55vq9c7WkTAgZxVF
	 aHbL0KhwlEEiaD7qefV+MWTubMijHYTnSEo6xW3xLYFjd72QQxjnFFLh5r5SmKsqo5sNO
	 2Eawywi5RAnpuuonBUt/bUe+Z/7eKXHgOpuw+9VabK+fuKh78MEomiGkBkoPAERCX+znY
	 3Rg6pitLpUPm9/R66/Q10hRVZiiIiICUJhb0zR6BSMUEU5Vk7g0ylICJXyA/byJSGGl/J
	 Oqj1/EnDoOLmKUJ++ud+Ye3XJM1OMmjikGg/YC+/lrf32ccm9dYJOoWGv4ih5orfwLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hoDZ9A+UGItROYmZGLQ23RT75hHMt9V+4cTfTF/bRJ8=;
	b=mJ1QgtUMjzgiOsnKtE4nlcto9h7y4MudB46NKoDqF/j9rAxJUhtRyjKVHICr8NO0W1e+
	 AIiMGJKCmrfMmBngGCeA6s9yTVZ26VYgULZG4bpbEUqfqDfdPQ6nP3csXnGaOD2+hQHQI
	 HwMqhMq6U32qOgRrrW7ACrD6ffeuoRwNpiMf1UNSlb5gPHpyJyNOJICrhWMIFy+nkiMed
	 XuUMmUQABsbmFvsqhaLXQEPAfk8aIr6g5yk4rAvtzU6rI7xpG3LtW5n/ZHwfs4bciRW8B
	 0CP81Ku/B9HgtvSt04QXC7TnQuZUrTa6mv1UNC2SMWwrB/0fm5PtV5+LunUNNMM5P0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Amg4URSe;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D11606A334
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D11606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Amg4URSe
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so2230652c88.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284488; x=1794889288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hoDZ9A+UGItROYmZGLQ23RT75hHMt9V+4cTfTF/bRJ8=;
        b=Amg4URSen9zLsh38hsbsl/UZMpz5KbaEgtKitqupbCIsRBf5LpjVqgFsD9ZefYDydk
         kfFxy/hYIL1wha53cHbYBWV4FzFzJ2Qc4UzCoV6C+wLU2xJJgALZHmAq4qcxxwb4g0dw
         OdXaXf/FkEapteYpQPnlB+bQF6e/kVn0ZHPGNA7aEIGGFjfe3TlARt1vjKgqaoJadmio
         9Y6N6JoHIXAnrUN7gA/Km/nOp2BXrcI+aDLr79IAmOQZpnWO5l/lfkzMe+XNIs4oqs6i
         0jVezHHQIlrzl2UrmS6bSUFUJflAJqRQajw3tSKNnRecSbK9aRGG8F+v5qdsCHoBacMS
         ToRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284488; x=1794889288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hoDZ9A+UGItROYmZGLQ23RT75hHMt9V+4cTfTF/bRJ8=;
        b=KrT1bQ4abNZudZquH5ftXws85L9x+5W7Y/xYAVxY5cpku0oZ6Iza7QVXzAGIyy9v9M
         TrzFYgBUmK0XHgM7S0sI995zlnWTS1UvWHbft67fW6o98pcZE6LbnT4IJvUTBt80dpUW
         rj+qBjA3KMAa1Y+siF+WejSAbRmRLUSyfKZ4r2JW/3mNWmvQOR6YJpXsp/xEaIpAcn5e
         OdPuPo9MQuD0Nod9BwlrCUXjrjydFmZEfJ8Cjd8rMmCTwsAAvPHZhhEcTLxUbj7EojO5
         EOEmdd23CeMMM9etvjVAXVDsyVFRcriKU0WI0SP1Nm04zqiFNk5Xhjk2LaqY4YIwk8zM
         cpsg==
X-Forwarded-Encrypted: i=1; AL+hErFsFb2xnsBuOXv1mcAwQgXhLxZ8UXmGHk+lttUOZ20csle19oZXANJhU8/SwCirdOCfUpL3oK4i+tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z86GADRGjSruy04CzVkdW9ZCi3FusMdT8P+YRkg3aaQHUKo0SZj
	AHrXQ/qAEbXogOr90pc6z4qShsvuw2jkowuC7uAwPjupINBUI/V6ht5E
X-Gm-Gg: AYBFou2vRjj8c28ONG8HET+lLnUCUokTbnY00Wqgjp/zd4CaKYN4ed2i0MpDaioDGjO
	MMO1HGADaeXRL7SluK1xixxO6eMvBmOHKNzwqAjnYjktHcq+mAapQk+e9i9xMi0rr6/JBLamt7b
	4keCYYs+IzUoHadHYlVH7PNKf5tK9yYUV/oAvfHYT8GuPUtGEUHNLE8I6rcHQVlHNr30d0S9wL5
	O6VhMdiai2rI45MULTVaJeQ+LBeLfgDb+inaCmv/lYJpCl23Xo5LBZ4SZV+Iln1S0E0bKt7bTEn
	FPH/rgntiCp72PjqpHtEKG1PAKdOMAr0SXwmT/jRZlWrfbdZg8esS/duJLJLz6JSUPKh8oVYfQQ
	Uyl/dnN96QNyHrJ6QfchQRhVvUGj7WqF7aFRXEN60KeGLQHkq35H6OwRT/0Y5recwQeS2rBdHm3
	mx6dB8H7+rejvVAjjbLNEWns1vSdLCrTXRtvhbMJnj2ggy/1USS/XlDxv0d96japtXw4ClgQ5A7
	9caRt8sFrnKTcn3jLwOgUXFhaXFwq/H0Bivp18pSvk9LT2u2CCmpIlc8ZAA3pVyGaNx1uN3H4EQ
	Oqlx11cIRbYDy7Kd1rxYJmqmS4yWuvMXw7k6L+N1nNaxYuo=
X-Received: by 2002:a05:7022:ec17:b0:144:fdf0:9d91 with SMTP id a92af1059eb24-1b3b604c6cemr2508611c88.24.1794284487379;
        Mon, 09 Nov 2026 20:21:27 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:26 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 19/25] lib: rspdm: Support SPDM get_certificate
Date: Tue, 10 Nov 2026 14:18:26 +1000
Message-ID: <20261110041832.1730924-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
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

The kernel will send a GET_CERTIFICATE request to the responder and
then iterate over all of the certificates returned.

Certificate validation happens in the next commit.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  15 ++++
 lib/rspdm/state.rs     | 100 +++++++++++++++++++++++-
 lib/rspdm/validator.rs | 170 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 285 insertions(+), 2 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index b80c37f1ee70c..b76bab8894b9e 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -85,6 +85,8 @@
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index ee996ecfb4ce1..440589ff66b5f 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -280,6 +280,21 @@ fn from(code: SpdmErrorCode) -> Self {
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
index a44f98a941cd0..f1a55da1f1cfa 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -62,16 +62,21 @@
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
@@ -500,4 +505,97 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.header.version = self.version;
+        request.header.param1 = slot;
+
+        // Bound the per-chunk allocation to one page
+        let rsp_sz = (GET_CERTIFICATE_RSP_HDR_SZ + PAGE_SIZE).min(self.data_transfer_sz as usize);
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
+            dev_err!(&self.dev, "Invalid slot response\n");
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
+                dev_err!(&self.dev, "Malformed certificate response\n");
+                return Err(EPROTO);
+            }
+
+            certs_buf.extend_from_slice(&response.cert_chain, GFP_KERNEL)?;
+            let (val, overflow) = offset.overflowing_add(portion_length);
+            if overflow {
+                dev_err!(&self.dev, "portion_length  response overflowed\n");
+                return Err(EPROTO);
+            }
+            offset = val;
+            remainder_length = rem_length as usize;
+        }
+
+        let header_length = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len();
+
+        if total_cert_len < header_length || total_cert_len != certs_buf.len() {
+            dev_err!(&self.dev, "Malformed certificate chain in slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        let certs: SpdmCertChain = Untrusted::new(certs_buf.as_slice()).validate(&*self)?;
+        let cert_chain_length = certs.length as usize;
+
+        if total_cert_len != cert_chain_length {
+            dev_err!(&self.dev, "Malformed certificate chain in slot {slot}\n");
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
index 54207527e9f4d..dad8482525794 100644
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
@@ -24,7 +25,8 @@
     SPDM_VER_10,
     SPDM_VER_11,
     SPDM_VER_12,
-    SPDM_VER_13, //
+    SPDM_VER_13,
+    SPDM_VER_14, //
 };
 use crate::{
     SpdmErrorCode,
@@ -824,3 +826,169 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Se
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
+    // and lower and u32 for 1.4.
+    pub(crate) length: u32,
+
+    pub(crate) root_hash: KVec<u8>,
+
+    pub(crate) certificates: KVec<u8>,
+}
+
+impl<'a, 'c, T: Transport> Validate<'c, Untrusted<&'a [u8]>, &'c SpdmState<T>> for SpdmCertChain {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        let length = if context.version >= SPDM_VER_14 {
+            u32::from_le_bytes(
+                unvalidated
+                    .get(0..4)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            )
+        } else {
+            u32::from(u16::from_le_bytes(
+                unvalidated
+                    .get(0..2)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            ))
+        };
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
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<T>> for GetCertificateRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CERTIFICATE - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            dev_err!(&context.dev, "Invalid version response\n");
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

