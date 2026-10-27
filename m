Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078887;
	b=h2VY1S3shu53gQ1VPQN7JvyqOSDBvkblt4D6mINX9oHVl9AONDQsWRMP3C3MRlSRtjVn
	 3lMjAEUqJ6ndJmOQjoVZQ39RiscLKwLV5BAufj9NE+pZu+40fLRyeL57x4GuCPIBDRKcc
	 22Ke5W+eAqX3anGwCQXXW+U4UhRZ+NAwln2iyZMqmAAocRDs+IjcmNvb0KUqJS/AVrI+N
	 bLzYjBacnA71moMQq69bPtuehxdlmKkBjD5WonxRPE17Ztrs1kjo5pj5gRePcD16mM4g4
	 /C4JGsMlSiGsjRay9Ra0v3U286GBQIU1H4mxS3m4MyFhIsscG5XWKH7LeRI5KB7EMBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CxrG9aWJ5Sg0J8a+Po4yS4C8JvicGpcPP85E8KyGvy4=;
	b=hvGHkDt9D0aaJC6/z3LKtA+AnVtNv+cfQPWXCJmI7YNUpWd6EJ7jBHqyy5nQnNJHEMi8
	 bKkDx8CMt/Lsbjs4d/ViKM2kRNm72vD3KW6tr1oNN26arMezmZyAWPGvWFRw5O5xHC50C
	 B8EtTdIHmQQf934jjGrxt5ERXkBP1P8L8K3U6v4TmmeRrV+SMQDBTSREZm3olakxOtgxI
	 4XHGGz4QYb2wGYVwlPofyola1O/Yguouz1UgjN5P9Ck9hxttYE6MTjNiLt8sv5oZnUlMF
	 3ihCCdM/ehExZfJDKem3/da9JOoP7Qs9myCkDHiGAQtoMX1Nfn0NoRbujip8imWeYaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eZ7kj3+B;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD5606A322
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFAD5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eZ7kj3+B
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso19777795ad.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078886; x=1793683686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CxrG9aWJ5Sg0J8a+Po4yS4C8JvicGpcPP85E8KyGvy4=;
        b=eZ7kj3+BQoKSpfg23gU0JlKQYypVAfO8biw59MjnCeVfnkPd3xb1Jq0lUtlTgTtzcP
         2CvpwksroXdsfSvQsOyHWeitZXXjbHh6iPdxEaxeyJhHnjPuVPGeuBB413eDgIR8Ew9T
         hqzR3jq3dkoJ37Ygk1zCIj/EGzAo/ObIfcIe1qQ+QfjCtL1Mcd0hN0xbNGCXnp1onvtu
         pDdDNplGWUmkslUVajA/e/sBmy9sT4NKEVjDaAgq4NORE6mx5AIplKdJjwr+wfmy9qRI
         HxHBO+S612zcQ1BhleTMvQJGk/RDz4EhoZsmflMa8iKYieU+BkDmLaCzcIiVx1gtPe1B
         gnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078886; x=1793683686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CxrG9aWJ5Sg0J8a+Po4yS4C8JvicGpcPP85E8KyGvy4=;
        b=ncPNDXOn8FzSSndawZ4PxM9K7Cepk08of64DqtmI2CPc6HwrZdJBK9DPRvBHgdFLFw
         bUmfN25Hs21h7GR1nlcSbb8nyj6pez9hfNDaTCV4yMdSr/KJQftVpbvNU1ZCgdSd8mYo
         QVvamhpFn+JjQWIuy5Q2kDm45+rZ3SzJZSTtDeGt6nlwZL9Yfi8PEJKBV0X/y76eieEs
         1GqzqGj+6tNSgFZzZIGlkRjIafJ0uM1g2l3dldIfi9FAMbYrwcD6VrRxFCLTnANGwUKX
         OFFrxCfo8Buq4kWfvJhEVhgvfhYjCoWAFOJLy2jDWqvKRvdKZeYyUO++SVBx/sNwZTjr
         +gZQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5t9ae7CxbMN9Es7EAiNCnz5X2Pi/8p8fK/vDhRMYNLftJiLiWvpmKXXkr4CmqRn1RgP0q8fiL9lo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIic1UMHuMSLcdmzXIBtpOFK+O3wdO6oNd2hp3Tr/AGg+vSfDUJ
	UgICI4sIlN8lj9D5tNzGvp2bb9yztBzVV0MJnkwx+3XP1kUWsdNgLuzi
X-Gm-Gg: AYBFou3GyZrEwJjODpCgCBwkqUznH7DGktEd57NLSgVmCYTCz/smVj6cwuzA8/s+WB2
	Vy74HmYaEYuwJCux8+0wYJngVvk6GfpHjXhPPUF98sRAJD9k2DHqMCXXWHKXSBAn2+XPGL2LuEU
	woUWIBljW/LqbcZJSyQl5sIM1H4UfuhYNIYMQcp3eEsITjbPMDX5sBcfBmt/I4UpVI7yq3AgDDq
	Yn5KPXdPG27FUFtos7GoVoFX6h8OO7IzL5vMPsktGJzN/+pgU8v0xFTYZNBsig6oezEodhZ/Bud
	Y0NwNyGi8jKsBnutd0KzREYY+If1pCWZfOJpG4uWRsDUOl+sDRVIOSAdyBaq9UFwSsBEmJ5vibW
	e60Zo45yJkNKOe51mFQg+qBbFwyyaI8lJH6HKdT3CY9rwGLcuaPxFknQDi9pIAOjf5FoSbxNJS0
	HnIrQcLn/gXbVRCdxnVE2H7NAAlWEnavxc+rGv97NNWCkPCGVCsLW91GLEWcIUvVfDZ+QlvKz6l
	kcv1Gqz4nyVPvTjDrg0Gf87y+pH42VPwPbi47LiYWvK0vwYP6BfW2IX1msvblTnUfy4uBiimg==
X-Received: by 2002:a17:902:e74b:b0:2e4:b37a:d577 with SMTP id d9443c01a7336-2ea9c819496mr71523295ad.43.1793078886044;
        Mon, 26 Oct 2026 22:28:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:28:05 -0700 (PDT)
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
	Alistair Francis <alistair.francis@wdc.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 18/23] lib: rspdm: Support SPDM get_digests
Date: Tue, 27 Oct 2026 15:25:31 +1000
Message-ID: <20261027052536.1722081-19-alistair.francis@wdc.com>
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

Support the GET_DIGESTS SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 lib/rspdm/consts.rs    |   5 +-
 lib/rspdm/lib.rs       |   4 ++
 lib/rspdm/state.rs     |  61 +++++++++++++++++++++++-
 lib/rspdm/validator.rs | 102 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 169 insertions(+), 3 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 7a75bd1e4649c..68f347a046859 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -18,10 +18,11 @@
 pub(crate) const SPDM_VER_10: u8 = 0x10;
 pub(crate) const SPDM_VER_11: u8 = 0x11;
 pub(crate) const SPDM_VER_12: u8 = 0x12;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
 pub(crate) const SPDM_VER_14: u8 = 0x14;
 
+pub(crate) const SPDM_SLOTS: usize = 8;
+
 pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
 pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_14;
 
@@ -72,6 +73,8 @@
 pub(crate) const SPDM_HASH_SHA_384: u32 = bit_u32(1);
 pub(crate) const SPDM_HASH_SHA_512: u32 = bit_u32(2);
 
+pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
+
 // If the crypto support isn't enabled don't offer the algorithms
 // to the responder
 #[cfg(CONFIG_CRYPTO_RSA)]
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 4c219b32098ab..ee7e9be5b41c1 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -270,6 +270,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_digests() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 79819c492b07b..73c39847d7335 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -41,13 +41,17 @@
     SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
+    SPDM_SLOTS,
     SPDM_VER_10,
     SPDM_VER_11,
-    SPDM_VER_12, //
+    SPDM_VER_12,
+    SPDM_VER_13, //
 };
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
+    GetDigestsReq,
+    GetDigestsRsp,
     GetVersionReq,
     GetVersionRsp,
     NegotiateAlgsReq,
@@ -119,6 +123,12 @@ pub(crate) struct SpdmState<'a, T: Transport> {
     /// Hash algorithm for measurement blocks. Selected by responder during
     /// NEGOTIATE_ALGORITHMS exchange.
     pub(crate) meas_hash_alg: u32,
+    /// Bitmask of responder's supported certificate slots. Received during
+    /// GET_DIGESTS exchange (from SPDM 1.3).
+    pub(crate) supported_slots: u8,
+    /// Bitmask of responder's provisioned certificate slots. Received during
+    /// GET_DIGESTS exchange.
+    pub(crate) provisioned_slots: u8,
 
     /// Human-readable name of `base_asym_alg`'s signature encoding. Passed
     /// to the crypto subsystem when calling `verify_signature()`.
@@ -129,6 +139,10 @@ pub(crate) struct SpdmState<'a, T: Transport> {
 
     /// Hash transformation for `base_hash_alg` computation.
     crypto: Option<Shash>,
+
+    /// Certificate chain in each of the 8 slots. Empty `KVec` if a slot is
+    /// not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
+    pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
 }
 
 impl<'a, T: Transport> SpdmState<'a, T> {
@@ -148,12 +162,23 @@ pub(crate) fn new(
             base_asym_alg: 0,
             base_hash_alg: 0,
             meas_hash_alg: 0,
+            supported_slots: 0,
+            provisioned_slots: 0,
             base_asym_enc: c"",
             sig_len: 0,
             crypto: None,
+            certs: [const { KVec::new() }; SPDM_SLOTS],
         }
     }
 
+    /// Hash length of `base_hash_alg` (in bytes). H in SPDM specification.
+    pub(crate) fn hash_len(&self) -> usize {
+        self.crypto
+            .as_ref()
+            .map(|hash| hash.hash_len())
+            .unwrap_or(0)
+    }
+
     /// Start a SPDM exchange
     ///
     /// The data in `request_buf` is sent to the device and the response
@@ -394,4 +419,38 @@ pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
+        let mut request = GetDigestsReq::default();
+        request.header.version = self.version;
+
+        let rsp_sz = core::mem::size_of::<SpdmHeader>() + SPDM_SLOTS * self.hash_len();
+
+        let mut request_buf = request.to_bytes()?;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let response: GetDigestsRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
+
+        let mut deprovisioned_slots = self.provisioned_slots & !response.header.param2;
+        while (deprovisioned_slots.trailing_zeros() as usize) < SPDM_SLOTS {
+            let slot = deprovisioned_slots.trailing_zeros() as usize;
+            self.certs[slot].clear();
+            deprovisioned_slots &= !(1 << slot);
+        }
+
+        self.provisioned_slots = response.header.param2;
+
+        let supported_slots = if self.version >= SPDM_VER_13 {
+            response.header.param1
+        } else {
+            0xFF
+        };
+
+        self.supported_slots = supported_slots;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 9afcb3f8bcb6c..f7ad46aef1b88 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -12,6 +12,7 @@
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
+    SPDM_GET_DIGESTS,
     SPDM_GET_VERSION,
     SPDM_HASH_ALGOS,
     SPDM_MEAS_SPEC_DMTF,
@@ -19,9 +20,11 @@
     SPDM_MIN_VER,
     SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS,
+    SPDM_SLOTS,
     SPDM_VER_10,
     SPDM_VER_11,
-    SPDM_VER_12, //
+    SPDM_VER_12,
+    SPDM_VER_13, //
 };
 use crate::{
     SpdmErrorCode,
@@ -719,3 +722,100 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self
         })
     }
 }
+
+pub(crate) struct GetDigestsReq {
+    pub(crate) header: SpdmHeader,
+}
+
+impl GetDigestsReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        self.header.to_bytes()
+    }
+}
+
+impl Default for GetDigestsReq {
+    fn default() -> Self {
+        GetDigestsReq {
+            header: SpdmHeader::new(SPDM_GET_DIGESTS),
+        }
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct GetDigestsRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) digests: [KVec<u8>; SPDM_SLOTS],
+
+    // KeyPairIDs, added in 1.3
+
+    // CertificateInfo, added in 1.3
+
+    // KeyUsageMask, added in 1.3
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl GetDigestsRsp {
+    #[expect(dead_code)]
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<'c, T>> for GetDigestsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_GET_DIGESTS - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        if header.param2 == 0 {
+            pr_err!("No certificates provisioned\n");
+            return Err(EPROTO);
+        }
+
+        let mut digests: [KVec<u8>; SPDM_SLOTS] = [const { KVec::new() }; SPDM_SLOTS];
+        let mut offset = mem::size_of::<SpdmHeader>();
+        let mut slot_mask = header.param2;
+
+        while (slot_mask.trailing_zeros() as usize) < SPDM_SLOTS {
+            let slot = slot_mask.trailing_zeros() as usize;
+
+            digests[slot].extend_from_slice(
+                unvalidated
+                    .get(offset..(offset + context.hash_len()))
+                    .ok_or(EPROTO)?,
+                GFP_KERNEL,
+            )?;
+            offset += context.hash_len();
+
+            slot_mask &= !(1 << slot);
+        }
+
+        if context.version >= SPDM_VER_13 && (header.param2 & !header.param1 != 0) {
+            pr_err!("Malformed digests response\n");
+            return Err(EPROTO);
+        }
+
+        Ok(GetDigestsRsp {
+            header,
+            digests,
+            length: offset,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

