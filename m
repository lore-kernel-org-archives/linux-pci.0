Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE9352C4F
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558013; cv=none; b=slnPBvGZ92nFSd6WjVDH/xHG9N6Fw6Y8sJ6ujICUPZNEkz0uQFvZInBomj+y+SAPUrvYjxWKfUDGD4u4bEMslHlqSMSFxNWoFHVra1jBa3u7jxPFzWLcbWLOA+/qHQWnJ6btlgtu928W4eMhdw9pCF3lFQSuNErpw5Di8MdOonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558013; c=relaxed/simple;
	bh=K4b8oGf/npTfhQIAQumHPo3T6lbcx3vmmyv7yrZW/Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlK8N1iI4nNzIo3wQuUq6prj++2uxL1W/n2GqlCPL9+ae7rHk8R6Aa2fj+zaZrMo0i0roFiB0qShXEimamVH3Fi29ptQiw82+lhX4hLV4Yyl2RBxYFUYbryVIGv2829ahF6abqXeilJfw03ZpsmHsbmwR2496hv60q5aou8vyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTFcpHVi; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTFcpHVi"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so941400a91.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790558010; x=1791162810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YF1Mo4BqjcJcm8eDyNQdhw6U5Ooj8srxFJaWTvAdSZc=;
        b=iTFcpHVi1rHuF0Re6CmTPvCo7gesKcZN3e/pwcYPDK+1RDBZLKZogfLncaTzzEGNLu
         qRgy33Vm+cgnv58TCNckS7bCfnvFVzlS2ckGt2sM60PsznmYDg/zc3Byf4qJHUJ7mscO
         KnFz4paLtr3S7dPEuTLOwzcACkFiruznRIcw8drwcCAmzVXV7Pp3Kfbmt3VkQQK17rgJ
         CNG1dJo7+shwi/7N44tJ7wWQNx9lt+8YxHi/gHgoW1Lswk/MpM7yvGbq1H7EF2uoSLte
         Mw9ueNtXxhHQ0vEAhoICw4s/w0+Fp9Gd76HfXTjrAS9X3v+uSY6ZLi19wWErLUOb8uzc
         i05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558010; x=1791162810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YF1Mo4BqjcJcm8eDyNQdhw6U5Ooj8srxFJaWTvAdSZc=;
        b=T09ByLDZCduyIUFTpNbb9qMxcO0i9o5jye0U1/SfSu30zHNScfG5RCWMMsC7/etPXL
         lq4INQGqqjMWJQtJ7YAWIpdbhlX5IWqbEO9SqyYBYuPK+MpvkYh1zoL1Lc+Yg5E+MjLS
         QMq8pRGI61J8LVHbMFKDBv6PAEaHck/BOj5uS3im0TH8Ipvt+ryCPnSRSlpBkykg+ffG
         rtj+7S3J8+jlpFXlLBL6qsPUVy4scG5ssONFVkuhNo7F3vmXTMRZ6SetJGivA1XyUe/+
         /Db2n3vB06n4Fy6HikK0wn8sIqQ3IMbpTGNJNgZh2FRhYJ9U9Xki/kig9V1cf9e3uZww
         ntAA==
X-Forwarded-Encrypted: i=1; AKwUvBy4uzsCIZkDwseaEPqKAArQaehdCHG/2gJEZNfcz6xpIpu18bF0omOHmyVAWDQk0vWlQqv4U1wJhUE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKo+KYzub/uEVeyMreiCwcJMyOYeLi6tOO5ZX9tLQmzxw0+UfDb
	YRkdHP3vFlOC/1kYmYYBZkTbWwtm6+zv0onGxenJrqozV6hoFGpoyAK1
X-Gm-Gg: AYBFou3AVZojd/MkKX5FjGFBb1Ghj4clBOUtJ3uL8YTTzPxhTb2x6nIpdxKnwdvI2ig
	ozJJ/B6l6tpVVe/v1xSeg6Grlh7O9a4LAuzJ/xrVWY+ShN3GRSiRxSwXH79b+LRwZ1aZ0rv+1yE
	4O1250VlRX9bGk6ffP+9pNYMFcOF2SJQ0/SacX2BrWEYZIgmkSqFRPIfxX/TVWVNtFveMxIna/r
	j+XCJPa7dLB1CUAyVjig/pgmMX7UETLGVDexwYTOv7KEWPIeA0P53Qb1SqGoQLiUJ9N0tAdydg5
	zfFncRsgMM/awIKlqdjjHeqIHb+ITgiwx0o/bOqHNq4SgKJvYZTMI77aS9w/QIKqnbZBWhi98P4
	0OsJWmt1EKCuDepzIJynGGmFAtR9i/E+a9zBYo9Bb5ACa0VKQDBBN/VyFrH3g+J/GE3zucrG0S1
	IFE3JxmGu5qef/yAs+Hd+4IO+R9Rgx3sUwHCquotdpanmGoMSd+U5kGxLsrheWpfnQef9haxxpr
	vBJNyQ8zhOzJjKl
X-Received: by 2002:a17:90b:5783:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-3a09860ee65mr6453057a91.6.1790558010441;
        Sun, 27 Sep 2026 18:13:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:13:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 16/22] lib: rspdm: Support SPDM get_capabilities
Date: Mon, 28 Sep 2026 11:11:17 +1000
Message-ID: <20260928011123.450800-17-alistair.francis@wdc.com>
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

Support the GET_CAPABILITIES SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 lib/rspdm/consts.rs    |  23 ++-
 lib/rspdm/lib.rs       |   4 +
 lib/rspdm/state.rs     |  70 +++++++++-
 lib/rspdm/validator.rs | 309 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 401 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index cb0fc2b55206..cbba95944ef9 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -9,13 +9,15 @@
 
 use crate::validator::SpdmHeader;
 use core::mem;
+use kernel::bits::{
+    bit_u32,
+    bit_u8, //
+};
 use kernel::error::{code::EINVAL, Error};
 
 // SPDM versions supported by this implementation
 pub(crate) const SPDM_VER_10: u8 = 0x10;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_11: u8 = 0x11;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 #[expect(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
@@ -102,3 +104,20 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
 pub(crate) const SPDM_GET_VERSION_LEN: usize =
     mem::size_of::<SpdmHeader>() + 2 + (u8::MAX as usize) * mem::size_of::<u16>();
+
+pub(crate) const SPDM_GET_CAPABILITIES: u8 = 0xe1;
+pub(crate) const SPDM_CAP_SUPPORTED_ALGORITHMS: u8 = bit_u8(0);
+pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42; // SPDM 1.2.0 margin no 226
+
+// SPDM cryptographic timeout of this implementation:
+// Assume calculations may take up to 1 sec on a busy machine, which equals
+// roughly 1 << 20.  That's within the limits mandated for responders by CMA
+// (1 << 23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec 6.30.2).
+// Used in GET_CAPABILITIES exchange.
+pub(crate) const SPDM_CTEXPONENT: u8 = 20;
+
+pub(crate) const SPDM_CERT_CAP: u32 = bit_u32(1);
+pub(crate) const SPDM_CHAL_CAP: u32 = bit_u32(2);
+
+pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index df3b97a05c41..1109a9334713 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -97,6 +97,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_capabilities() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 3bbe55d965f7..fb43260f4800 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -25,13 +25,20 @@
     SPDM_GET_VERSION_LEN,
     SPDM_MAX_VER,
     SPDM_MIN_VER,
-    SPDM_REQ, //
+    SPDM_REQ,
+    SPDM_RSP_MIN_CAPS,
+    SPDM_VER_10,
+    SPDM_VER_11,
+    SPDM_VER_12, //
 };
 use crate::validator::{
+    GetCapabilitiesReq,
+    GetCapabilitiesRsp,
     GetVersionReq,
     GetVersionRsp,
     SpdmErrorRsp,
-    SpdmHeader, //
+    SpdmHeader,
+    GET_CAPABILITIES_RSP_SZ, //
 };
 
 /// The current SPDM session state for a device.
@@ -55,6 +62,8 @@
 ///
 /// `version`: Maximum common supported version of requester and responder.
 ///  Negotiated during GET_VERSION exchange.
+/// `rsp_caps`: Cached capabilities of responder.
+///  Received during GET_CAPABILITIES exchange.
 #[expect(dead_code)]
 pub(crate) struct SpdmState {
     pub(crate) dev: *mut bindings::device,
@@ -65,6 +74,7 @@ pub(crate) struct SpdmState {
 
     // Negotiated state
     pub(crate) version: u8,
+    pub(crate) rsp_caps: u32,
 }
 
 impl SpdmState {
@@ -82,6 +92,7 @@ pub(crate) fn new(
             transport_sz,
             validate,
             version: SPDM_MIN_VER,
+            rsp_caps: 0,
         }
     }
 
@@ -290,4 +301,59 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    /// Obtain the supported capabilities from an SPDM session and store the
+    /// information in the `SpdmState`.
+    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
+        let mut request = GetCapabilitiesReq::default();
+        request.header.version = self.version;
+
+        let rsp_sz = match self.version {
+            SPDM_VER_10 | SPDM_VER_11 => {
+                core::mem::size_of::<SpdmHeader>() + 4 + core::mem::size_of::<u32>()
+            }
+            _ => {
+                request.data_transfer_size = self.transport_sz;
+                request.max_spdm_msg_size = self.transport_sz;
+
+                (GET_CAPABILITIES_RSP_SZ as u32 + u16::MAX as u32).min(self.transport_sz) as usize
+            }
+        };
+
+        let mut request_buf = request.to_bytes()?;
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let rc =
+            self.spdm_exchange(request_buf.as_mut_slice(), response_vec.as_mut_slice())? as usize;
+        response_vec.truncate(rc);
+
+        let response: GetCapabilitiesRsp =
+            Untrusted::new(response_vec.as_slice()).validate(&*self)?;
+
+        self.rsp_caps = response.flags;
+        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
+            pr_err!(
+                "{:#x} capabilities are supported, which don't meet required {:#x}\n",
+                self.rsp_caps,
+                SPDM_RSP_MIN_CAPS
+            );
+            self.rsp_caps = 0;
+            return Err(EPROTONOSUPPORT);
+        }
+
+        if self.version >= SPDM_VER_12 {
+            if response.data_transfer_size < 42 {
+                pr_err!(
+                    "Invalid minimum transport size {}, must be at least 42\n",
+                    response.data_transfer_size
+                );
+                return Err(EPROTONOSUPPORT);
+            }
+
+            self.transport_sz = self.transport_sz.min(response.data_transfer_size);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index d0b6691365c0..ca837bd9cfcc 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -22,8 +22,16 @@
 };
 
 use crate::consts::{
+    SPDM_CAP_SUPPORTED_ALGORITHMS,
+    SPDM_CTEXPONENT,
+    SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
-    SPDM_MIN_VER, //
+    SPDM_MIN_DATA_TRANSFER_SIZE,
+    SPDM_MIN_VER,
+    SPDM_REQ_CAPS,
+    SPDM_VER_10,
+    SPDM_VER_11,
+    SPDM_VER_12, //
 };
 
 #[repr(C, packed)]
@@ -175,3 +183,302 @@ fn validate(unvalidated: &[u8], context: &'c SpdmState) -> Result<Self, Self::Er
         })
     }
 }
+
+pub(crate) struct GetCapabilitiesReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) ctexponent: u8,
+
+    pub(crate) flags: u32,
+
+    /* End of SPDM 1.1 structure */
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+}
+
+impl GetCapabilitiesReq {
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        if self.header.version <= SPDM_VER_10 {
+            return Ok(out);
+        }
+
+        out.push(0u8, GFP_KERNEL)?;
+        out.push(self.ctexponent, GFP_KERNEL)?;
+
+        out.extend_from_slice(&[0u8; 2], GFP_KERNEL)?;
+        out.extend_from_slice(&self.flags.to_le_bytes(), GFP_KERNEL)?;
+
+        if self.header.version >= SPDM_VER_12 {
+            out.extend_from_slice(&self.data_transfer_size.to_le_bytes(), GFP_KERNEL)?;
+            out.extend_from_slice(&self.max_spdm_msg_size.to_le_bytes(), GFP_KERNEL)?;
+        }
+
+        Ok(out)
+    }
+}
+
+impl Default for GetCapabilitiesReq {
+    fn default() -> Self {
+        GetCapabilitiesReq {
+            header: SpdmHeader::new(SPDM_GET_CAPABILITIES),
+
+            ctexponent: SPDM_CTEXPONENT,
+            flags: SPDM_REQ_CAPS,
+            data_transfer_size: 0,
+            max_spdm_msg_size: 0,
+        }
+    }
+}
+
+/// Response AlgStructure field format
+#[expect(dead_code)]
+pub(crate) struct RespAlgStruct {
+    pub(crate) alg_type: u8,
+    pub(crate) alg_count: u8,
+    pub(crate) alg_supported: KVec<u8>,
+    pub(crate) alg_external: KVec<u32>,
+}
+
+pub(crate) const GET_CAPABILITIES_RSP_SZ: usize = mem::size_of::<SpdmHeader>() + 16;
+
+/// The GET_CAPABILITIES SupportedAlgorithms block (SPDM 1.3+).
+///
+/// Conforms to the NEGOTIATE_ALGORITHMS request message format,
+/// including all fields from Param1 through the end of the message inclusive.
+/// The `Length` field is equal to the total size of the block (`AlgSize`).
+#[expect(dead_code)]
+pub(crate) struct SupportedAlgorithms {
+    /// param1
+    pub(crate) alg_struct_count: u8,
+    pub(crate) length: u16,
+
+    pub(crate) measurement_specification: u8,
+    pub(crate) other_params_support: u8,
+
+    pub(crate) base_asym_algo: u32,
+    pub(crate) base_hash_algo: u32,
+
+    pub(crate) ext_asym_count: u8,
+    pub(crate) ext_hash_count: u8,
+
+    pub(crate) mel_specification: u8,
+
+    pub(crate) ext_asym: KVec<u32>,
+    pub(crate) ext_hash: KVec<u32>,
+    pub(crate) alg_struct: KVec<RespAlgStruct>,
+}
+
+impl SupportedAlgorithms {
+    fn from_bytes(buf: &[u8]) -> Result<Self, Error> {
+        let read_le16 = |off: usize| -> Result<u16, Error> {
+            Ok(u16::from_le_bytes(
+                buf.get(off..off + mem::size_of::<u16>())
+                    .ok_or(EIO)?
+                    .try_into()
+                    .map_err(|_| EINVAL)?,
+            ))
+        };
+        let read_le32 = |off: usize| -> Result<u32, Error> {
+            Ok(u32::from_le_bytes(
+                buf.get(off..off + mem::size_of::<u32>())
+                    .ok_or(EIO)?
+                    .try_into()
+                    .map_err(|_| EINVAL)?,
+            ))
+        };
+
+        let alg_struct_count = *buf.get(0).ok_or(EIO)?;
+        let length = read_le16(2)?;
+        let measurement_specification = *buf.get(4).ok_or(EIO)?;
+        let other_params_support = *buf.get(5).ok_or(EIO)?;
+        let base_asym_algo = read_le32(6)?;
+        let base_hash_algo = read_le32(10)?;
+        let ext_asym_count = *buf.get(26).ok_or(EIO)?;
+        let ext_hash_count = *buf.get(27).ok_or(EIO)?;
+        let mel_specification = *buf.get(29).ok_or(EIO)?;
+
+        let mut offset = 30;
+
+        let mut ext_asym = KVec::new();
+        for _ in 0..ext_asym_count {
+            ext_asym.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut ext_hash = KVec::new();
+        for _ in 0..ext_hash_count {
+            ext_hash.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut alg_struct = KVec::new();
+        for _ in 0..alg_struct_count {
+            let alg_type = *buf.get(offset).ok_or(EIO)?;
+            let alg_count = *buf.get(offset + 1).ok_or(EIO)?;
+
+            let fixed_alg_count = (alg_count & 0xf) as usize;
+            let ext_alg_count = (alg_count >> 4) as usize;
+
+            offset += 2;
+
+            let mut alg_supported = KVec::new();
+            alg_supported.extend_from_slice(
+                buf.get(offset..offset + fixed_alg_count).ok_or(EIO)?,
+                GFP_KERNEL,
+            )?;
+            offset += fixed_alg_count;
+
+            let mut alg_external = KVec::new();
+            for _ in 0..ext_alg_count {
+                alg_external.push(read_le32(offset)?, GFP_KERNEL)?;
+                offset += mem::size_of::<u32>();
+            }
+
+            alg_struct.push(
+                RespAlgStruct {
+                    alg_type,
+                    alg_count,
+                    alg_supported,
+                    alg_external,
+                },
+                GFP_KERNEL,
+            )?;
+        }
+
+        if length as usize != offset {
+            pr_err!("Malformed SupportedAlgorithms block\n");
+            return Err(EPROTO);
+        }
+
+        Ok(SupportedAlgorithms {
+            alg_struct_count,
+            length,
+            measurement_specification,
+            other_params_support,
+            base_asym_algo,
+            base_hash_algo,
+            ext_asym_count,
+            ext_hash_count,
+            mel_specification,
+            ext_asym,
+            ext_hash,
+            alg_struct,
+        })
+    }
+}
+
+#[expect(dead_code)]
+pub(crate) struct GetCapabilitiesRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) ctexponent: u8,
+    pub(crate) flags: u32,
+
+    // End of SPDM 1.1 structure
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+
+    pub(crate) supported_algorithms: Option<SupportedAlgorithms>,
+
+    /// Size of the response, not public
+    length: usize,
+}
+
+impl GetCapabilitiesRsp {
+    #[expect(dead_code)]
+    pub(crate) fn len(&self) -> usize {
+        self.length
+    }
+}
+
+impl<'a, 'c> Validate<'c, Untrusted<&'a [u8]>> for GetCapabilitiesRsp {
+    type Err = Error;
+
+    type Context = &'c SpdmState;
+
+    fn validate(unvalidated: &[u8], context: &'c SpdmState) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EIO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CAPABILITIES - 0x80 {
+            return Err(EINVAL);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let ctexponent = *unvalidated.get(5).ok_or(EIO)?;
+        let flags = u32::from_le_bytes(
+            unvalidated
+                .get(8..12)
+                .ok_or(EIO)?
+                .try_into()
+                .map_err(|_| EINVAL)?,
+        );
+
+        // DataTransferSize and MaxSPDMmsgSize only exist in SPDM 1.2 and later.
+        let (data_transfer_size, max_spdm_msg_size, supported_algorithms, length) =
+            if context.version <= SPDM_VER_11 {
+                (
+                    0,
+                    0,
+                    None,
+                    mem::size_of::<SpdmHeader>() + 4 + mem::size_of::<u32>(),
+                )
+            } else {
+                let data_transfer_size = u32::from_le_bytes(
+                    unvalidated
+                        .get(12..16)
+                        .ok_or(EIO)?
+                        .try_into()
+                        .map_err(|_| EINVAL)?,
+                );
+                let max_spdm_msg_size = u32::from_le_bytes(
+                    unvalidated
+                        .get(16..20)
+                        .ok_or(EIO)?
+                        .try_into()
+                        .map_err(|_| EINVAL)?,
+                );
+
+                if data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE {
+                    pr_err!("Malformed capabilities response\n");
+                    return Err(EPROTO);
+                }
+
+                let supported_algorithms = if header.param1 & SPDM_CAP_SUPPORTED_ALGORITHMS != 0 {
+                    Some(SupportedAlgorithms::from_bytes(
+                        unvalidated.get(GET_CAPABILITIES_RSP_SZ..).ok_or(EIO)?,
+                    )?)
+                } else {
+                    None
+                };
+
+                let length = GET_CAPABILITIES_RSP_SZ
+                    + supported_algorithms
+                        .as_ref()
+                        .map_or(0, |s| s.length as usize);
+
+                (
+                    data_transfer_size,
+                    max_spdm_msg_size,
+                    supported_algorithms,
+                    length,
+                )
+            };
+
+        Ok(GetCapabilitiesRsp {
+            header,
+            ctexponent,
+            flags,
+            data_transfer_size,
+            max_spdm_msg_size,
+            supported_algorithms,
+            length,
+        })
+    }
+}
-- 
2.55.0

