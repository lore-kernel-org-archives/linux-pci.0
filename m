Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60D30EF82
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210338; cv=none; b=LBgP2DpN1NPWSFzbx+BYBZAFiOa64PWfjRf64oMAJyREde/27m7BFs8qvvhvAsF5mK3/iOZ59b/LQ3Y1DJX47ZKIXsrzf9+E2AvSP3V2EwRmCl7sJy4m94+8ifa/gr+A5hzw/43Q1C2NEwMOpwVz1sqTslmt0CQ+uux50Yw+uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210338; c=relaxed/simple;
	bh=pgki4w7RWc81YTCI0ulFXlX7HnZjkRUDYahaKFjwBrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezYwqilrygEe+IvAG0FVTFB49PECSGfS/Qd1k1bLCDzLbvbKQ5eMrGo8/CzMyScnP4XdfycMb7Oaa/J3IqnqRyMwnuOFYE+N6tncEB/Hg3kMWZyoes+J4hWbH/Ig8Yw3PXiDu6G1HMiQ9ISsk5xoztoARsuTbwQiKvqPA7RuA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5yyXS3T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5yyXS3T"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba4efedbeaso11157435ad.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210334; x=1778815134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcbWqg6jBmtAgedbxHyaToXZ0xvL9n8c+k1cA5Ncp9c=;
        b=s5yyXS3Tq4hRomHX1+ENW+n73wPP/CbxuD5Z8LCDEw94z6LeEdsEortXwfia4YNHBc
         SCp52PXZzYkRqZ9fJH0zSeHgLFV37EmA1Bdls8ffa59xfqstqR10e9P7KOmbb4dQ1TcB
         LZ3MmpZfkaHaW+kAluIGe8VVjvmfJg2gCb+k22Z8LKpRJgZvnXBLhXWyCKPtM1JfvBSE
         mq+q4x0VnncjdqnT6x96kRQO8tfvFW7aA2ItuIV7bEBuiE3j6j7BavoPSNkwUyec+90g
         80p5kRgWWMTz/WIX6xGYRLA1m7K404OXvjheprNDtMgThPc7BUs1yuv80QoA1xDWLweP
         GlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210334; x=1778815134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VcbWqg6jBmtAgedbxHyaToXZ0xvL9n8c+k1cA5Ncp9c=;
        b=XZ81/B2Hfi5alsQXf8aOS0jbmJp4i5K8jzxnE3yYg7M7KFbcRASs34HzyRLAXdREhK
         YUTF/ir6IYHIbFxnPLraQvygJY0rvF8ehmTxP/WoYGE6i0uc1DmxGXZHpnuJtjh/94AH
         hy7breOk+iRQgd2xrHziITZ4TGeoUVL13cBPbAys8+yUzCb7/1Q8ScqQrmugOA9/W6O6
         M97g/3vZwjGU3mrwiEnSOAe5eAM74B1V4kNyR1xHrJqcXdEz5fxL4XUtqNUfNUA+R3OM
         9JsVenI4E0C0Z9v/MEKdlg5NDJNK/Ar+SuFQLvvhfDhjk3RtR9T5coAiKaGf2yEF+i+9
         DgTA==
X-Forwarded-Encrypted: i=1; AFNElJ+wpcno1nMdY8WrYO0ztQEvRMh1KIxBDdBJ8u6vIPtcpHiBQYji2b1dj9GR9uGN5WBg0uRfM2MN7Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqYeeOrkDXNEfoLTS2mjLNxenb2w/Xv3RnH5+t5c8igbAWwyh
	WG8/A6bm0WAMdAgRIQkwodLZlJg6fpRn37FpgDjlaKsYmU9grfRzKD5H
X-Gm-Gg: Acq92OFpA1I0bRL1q0remoOLDH5+alS1NV+ZHmRHDmi4ML7U9yRnX6Dc3Hr6CuTNXfM
	+P+Ce6g/zlOqrtvTXVfiWubQhTvJIQp+359DaLfsYEtjD1gQmX3uQfUjmYaZSDT/ub8zUlQbHRw
	YufnqSPtukihT7rnIrdtr1FSQDBxs9oteslUslVuImql68MrtIQBoSQ3D6Wuly1d4fmIERQc9IF
	gVMNkHiLHq0B8dHWhZ2F5std3zs5YHn+1PlSM2TUts4gdHFkB3LaubBYM6taCfi1qDou7OxYww3
	OVu/72gC4iYwUMTcNPGFJjK3kLi08ohEeKnejVSwjmAHQAB6ecC8nLfUrCuksslsIysOOisdzX+
	ippMiuPY8W+043ycy7bsJ+UpYgjRSHAdb61XLgJJPA/OZ6+b8wopgf2byzJLoILmv++mXNaFspP
	bRHcrGkiCB+uRKCF3LhMaT9Ybjn17R1GNTomEzqFJojCO7HCpOwT8=
X-Received: by 2002:a17:902:fa07:b0:2b2:549f:7d2b with SMTP id d9443c01a7336-2ba794b9766mr73480655ad.11.1778210334411;
        Thu, 07 May 2026 20:18:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:18:53 -0700 (PDT)
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
Subject: [PATCH 12/18] lib: rspdm: Support SPDM get_capabilities
Date: Fri,  8 May 2026 13:17:04 +1000
Message-ID: <20260508031710.514574-13-alistair.francis@wdc.com>
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

Support the GET_CAPABILITIES SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    | 19 ++++++++-
 lib/rspdm/lib.rs       |  4 ++
 lib/rspdm/state.rs     | 76 ++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 97 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 192 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 5482a0f6cee0..ef7d2d1d8e6e 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -9,12 +9,11 @@
 
 use crate::validator::SpdmHeader;
 use core::mem;
+use kernel::bits::bit_u32;
 
 /* SPDM versions supported by this implementation */
 pub(crate) const SPDM_VER_10: u8 = 0x10;
-#[allow(dead_code)]
 pub(crate) const SPDM_VER_11: u8 = 0x11;
-#[allow(dead_code)]
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 #[allow(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
@@ -68,3 +67,19 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
 pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + u8::MAX as usize;
+
+pub(crate) const SPDM_GET_CAPABILITIES: u8 = 0xe1;
+pub(crate) const SPDM_MIN_DATA_TRANSFER_SIZE: u32 = 42;
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
index 1cc6c33516fb..9628f258854c 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -112,6 +112,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_capabilities() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 26b90942b298..e7119ffa9a69 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -25,10 +25,17 @@
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
     SPDM_MAX_VER,
+    SPDM_MIN_DATA_TRANSFER_SIZE,
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
@@ -47,6 +54,8 @@
 ///
 /// `version`: Maximum common supported version of requester and responder.
 ///  Negotiated during GET_VERSION exchange.
+/// @rsp_caps: Cached capabilities of responder.
+///  Received during GET_CAPABILITIES exchange.
 #[expect(dead_code)]
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
@@ -57,6 +66,7 @@ pub struct SpdmState {
 
     // Negotiated state
     pub(crate) version: u8,
+    pub(crate) rsp_caps: u32,
 }
 
 impl SpdmState {
@@ -74,6 +84,7 @@ pub(crate) fn new(
             transport_sz,
             validate,
             version: SPDM_MIN_VER,
+            rsp_caps: 0,
         }
     }
 
@@ -293,4 +304,67 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    /// Obtain the supported capabilities from an SPDM session and store the
+    /// information in the `SpdmState`.
+    pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
+        let mut request = GetCapabilitiesReq::default();
+        request.version = self.version;
+
+        let (req_sz, rsp_sz) = match self.version {
+            SPDM_VER_10 => (4, 8),
+            SPDM_VER_11 => (8, 8),
+            _ => {
+                request.data_transfer_size = self.transport_sz.to_le();
+                request.max_spdm_msg_size = request.data_transfer_size;
+
+                (
+                    core::mem::size_of::<GetCapabilitiesReq>(),
+                    core::mem::size_of::<GetCapabilitiesRsp>(),
+                )
+            }
+        };
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+        // SAFETY: `response_vec` is rsp_sz length, initialised, aligned
+        // and won't be mutated
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (rsp_sz as i32) {
+            pr_err!("Truncated capabilities response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // or the same as the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut GetCapabilitiesRsp =
+            Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        self.rsp_caps = u32::from_le(response.flags);
+        if (self.rsp_caps & SPDM_RSP_MIN_CAPS) != SPDM_RSP_MIN_CAPS {
+            pr_err!(
+                "{:#x} capabilities are supported, which don't meet required {:#x}",
+                self.rsp_caps,
+                SPDM_RSP_MIN_CAPS
+            );
+            to_result(-(bindings::EPROTONOSUPPORT as i32))?;
+        }
+
+        if self.version >= SPDM_VER_12 {
+            if response.data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE {
+                pr_err!("Malformed capabilities response\n");
+                to_result(-(bindings::EPROTO as i32))?;
+            }
+            self.transport_sz = self.transport_sz.min(response.data_transfer_size);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 8f45bafd4d69..7dc55882c880 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -26,8 +26,12 @@
 };
 
 use crate::consts::{
+    SPDM_CTEXPONENT,
+    SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
-    SPDM_MIN_VER, //
+    SPDM_MIN_VER,
+    SPDM_REQ_CAPS, //
+    SPDM_VER_11,
 };
 
 #[repr(C, packed)]
@@ -141,3 +145,94 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetCapabilitiesReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    reserved1: u8,
+    pub(crate) ctexponent: u8,
+    reserved2: [u8; 2],
+
+    pub(crate) flags: u32,
+
+    /* End of SPDM 1.1 structure */
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+}
+
+impl Default for GetCapabilitiesReq {
+    fn default() -> Self {
+        GetCapabilitiesReq {
+            version: 0,
+            code: SPDM_GET_CAPABILITIES,
+            param1: 0,
+            param2: 0,
+            reserved1: 0,
+            ctexponent: SPDM_CTEXPONENT,
+            reserved2: [0; 2],
+            flags: (SPDM_REQ_CAPS as u32).to_le(),
+            data_transfer_size: 0,
+            max_spdm_msg_size: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetCapabilitiesRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    param2: u8,
+
+    reserved1: u8,
+    pub(crate) ctexponent: u8,
+    reserved2: [u8; 2],
+
+    pub(crate) flags: u32,
+
+    /* End of SPDM 1.1 structure */
+    pub(crate) data_transfer_size: u32,
+    pub(crate) max_spdm_msg_size: u32,
+
+    pub(crate) supported_algorithms: __IncompleteArrayField<__le16>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCapabilitiesRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+
+        if raw.len() < mem::size_of::<GetCapabilitiesRsp>() {
+            let version = *(raw.get(0).ok_or(ENOMEM))?;
+            let version_1_1_len = mem::size_of::<GetCapabilitiesRsp>()
+                - mem::size_of::<__IncompleteArrayField<__le16>>()
+                - mem::size_of::<u32>()
+                - mem::size_of::<u32>();
+
+            if version == SPDM_VER_11 && raw.len() == version_1_1_len {
+                // Version 1.1 of the spec doesn't include all of the fields
+                // So let's extend the KVec with 0s so we can cast the
+                // vector to GetCapabilitiesRsp
+
+                for _i in version_1_1_len..mem::size_of::<GetCapabilitiesRsp>() {
+                    raw.push(0, GFP_KERNEL)?;
+                }
+            } else {
+                return Err(EINVAL);
+            }
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetCapabilitiesRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCapabilitiesRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetCapabilitiesRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

