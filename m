Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078862;
	b=zzKqPCDnvKdOGYEeUF/H8VtcqUDKuMz1QAgJybQYSAk1b86t71PwpgvWfmhjJjY5soat
	 fsNxU2t+vKR87XPVoVaZFFbsR0LJTP/ujhhSwKRQ/UdwbRrBPjiNB2tGdAFdbcg/5zp4z
	 COv545sysL5dO/FhsXz6UMFaFVEBw9R9y1tfhv1GrTt4BUeOjjNLbTwBrxW5T00thhYqH
	 3zpiOt1Hf2yTvseMA71FhaGd7TmDYO4dsyj7GxFpCK3BiusVSdjX6sDoF2MdQ1JxlNNnQ
	 VeUdZvuZGenJBdJrIxNCbs/+WgA8AhIb5S8Omb1cW/99pqFzPL4yI1Os8k02Pjw7uYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m0nJrlnfoOSOvcfyWHeQMMPNOJzq0tbyqlK5fc75ELI=;
	b=siDfL956jMp8M6j4Z83Ry+QrF+4zCu1c+XFbVp7c4H7KF+jNxjjV9TGZihNUqdwcLKUv
	 pLO0h6cDnXe/CjwFBw5nFYPTC3fe+kDnjLHl92VHx5mwlpbCR9LFg5WdfHO7Sdv8iOilw
	 vW9fYvHbhNa4gvIsG2AW6ELdu7ya2K5fVbZhd0Yg+2KqRQc9ca9urEXDyOS3Zsda6H0iR
	 jqW1XJ4Y5EDYD+tkvy3R1JWCVPgCvHWxjlaOziN+GCbKpXh8SyaxCdFLsUUPno5A5KxmC
	 ILa36/R0rYmD0syhbbWwGVFS/1BiQQ6FV0UegUjvbOu1AwG+QYvJTUe4+IiqhTQ6hXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExBgSUb6;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA5606A331
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5AA5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExBgSUb6
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9995ce866so34938135ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078861; x=1793683661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0nJrlnfoOSOvcfyWHeQMMPNOJzq0tbyqlK5fc75ELI=;
        b=ExBgSUb63vzFTMoFanSDnjYmgrn6etR1qxF6pWrUrPMWIkGN+daQuWQGCIAkraFMp3
         qMEGcrVUlzklN37bw9UvJhGpy+1NrBmHov6MUn7bBKOYJcwfgZdQWfiWbf45pdj3ACsQ
         A+4DpnYhgs+9Y1t0v7qHKq1EcBYMMHk/dafRMzhBmXwHdJDV009Do6UhX34kv7OjffB3
         VZ9EWV9nfRplSNcwQKTfhHMR8eDM1vTalTZeq4T5y7woktv+t0yfo/tU4Tp+eabdbUlO
         Ijq9xiGI+c65Qwd0L6+xnxSgkbElDgE6J+6/APXoCLGQbAuidRd0mBIuh9ul7RMsdjhc
         3F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078861; x=1793683661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0nJrlnfoOSOvcfyWHeQMMPNOJzq0tbyqlK5fc75ELI=;
        b=DoMPFx8XCxvxU/4tNFbdlX/V3lRWnBweL+ZBi5GwP3qYr8PmgqrPeyNchuTgAuJuZI
         ukFyAUA3OIkd5xhVLCa89Je+CSx/w2WMLusCtV1WYr+wr5tttm8VupFOkWBKpIKhtol3
         wKFtTFxxTJb588R9UJ3Tyo96lNshTy8BEyTbSk/xaqu1ltL0SCR6YaegoKHotEN1eV7l
         iTof4uiGZYPxTJmJlOtO95XDEmBcnLejM2A0Jkza6WR3ANYiEykX2zZ2MX4r0OK3Vx5u
         y1yKlPq6ULz47WCW/lUHlx/eA9LxFU5/PZt3NFT6yOLYYFjIe/LVa/sfEmhgAHxhpLQf
         hX8A==
X-Forwarded-Encrypted: i=1; AKwUvBwgQw52s8D93UzU2exbgcCIRrGSclqqaHBiGBE+q2DhCcyhUrY5TsGUubc0deTEl9I576k78jry2yg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzwGHP+848g3Cs4jDifbW8ZeWVWd/UvI+nMd8GksSqkC1EcabW
	NGp+BHXyNhvATLXuTlyDwNDCl61BEJ6UhRU0kwKxa4JdTkWrMSM0lHyu
X-Gm-Gg: AYBFou1sV4YBOv5DU5/ROh4nl4dOmR+ZEeIoAfCaNxZmmqVlm4cQewgPhbpjj6MDohJ
	xjw05PpWDfKkkp5PwZu+L7GAAua40QxLn3U7zr4zvDACF6GBYZ8TzfOeAs+RRgTnuKtDr9wO5yF
	nLV7SB0zYM3dG5cyAuOvOkZ0dq2LpUliz2NgLdck23/jSSfCRCLOP1SzjJedRelH5dIhDA0D8uX
	fpDI6bpPy9q0iiWTqfWO3j4Nb+V70wD546lViBkJ0j9varSMfuAB7li2iFsYl+TWWCS7cjYCELg
	1DDvxRdfiYY33BNbF6ipJJfzegOMuDbPIOBCT9yIu+wF/69cejDHhIZ+6EBUTsbVPkVYtVtQEhC
	FtSo76RyXqvgLmZHlD0KSlx8art16b93RVscLv8U40cFKtNeCO5nKmxDFC/1Rb0arwAmN0Nv9k/
	4u/DAtbwfG/cStrB1TABMHhOIKg86tnSu4QcNtPT+cXvVzacZOH+B42psVl0FsFMx/UZ6I/O2nF
	edZvXCzSYF6MQU1zCt83wcYESoMG8IE+JqYiW+LNz6BgYsny20jQVVdYm34+9ohPJGE/qvgwY4E
	9IT3wMF0hPeqYuk+/1w=
X-Received: by 2002:a17:902:ecd2:b0:2e8:30dd:523d with SMTP id d9443c01a7336-2ea9c620609mr80507945ad.13.1793078860951;
        Mon, 26 Oct 2026 22:27:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:40 -0700 (PDT)
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
Subject: [PATCH v5 15/23] lib: rspdm: Support SPDM get_capabilities
Date: Tue, 27 Oct 2026 15:25:28 +1000
Message-ID: <20261027052536.1722081-16-alistair.francis@wdc.com>
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

Support the GET_CAPABILITIES SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 lib/rspdm/consts.rs    |  23 ++-
 lib/rspdm/lib.rs       |   4 +
 lib/rspdm/state.rs     |  60 +++++++-
 lib/rspdm/validator.rs | 319 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 401 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index a130673b6473c..fe5c79e0dd911 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -9,12 +9,14 @@
 
 use crate::validator::SpdmHeader;
 use core::mem;
+use kernel::bits::{
+    bit_u32,
+    bit_u8, //
+};
 
 // SPDM versions supported by this implementation
 pub(crate) const SPDM_VER_10: u8 = 0x10;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_11: u8 = 0x11;
-#[expect(dead_code)]
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 #[expect(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
@@ -29,3 +31,20 @@
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
index e0fb7b49d4a07..728910273a2ce 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -262,6 +262,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_capabilities() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 22655b2aff258..815f332fabad8 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -23,13 +23,20 @@
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
 
 /// Transport for exchanging SPDM messages with a responder device.
@@ -79,6 +86,9 @@ pub(crate) struct SpdmState<'a, T: Transport> {
     /// Maximum common supported version of requester and responder.
     /// Negotiated during GET_VERSION exchange.
     pub(crate) version: u8,
+    /// Cached capabilities of responder. Received during GET_CAPABILITIES
+    /// exchange.
+    pub(crate) rsp_caps: u32,
 }
 
 impl<'a, T: Transport> SpdmState<'a, T> {
@@ -94,6 +104,7 @@ pub(crate) fn new(
             transport_sz,
             validate,
             version: SPDM_MIN_VER,
+            rsp_caps: 0,
         }
     }
 
@@ -183,4 +194,49 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
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
+                (GET_CAPABILITIES_RSP_SZ as u32 + u32::from(u16::MAX)).min(self.transport_sz)
+                    as usize
+            }
+        };
+
+        let mut request_buf = request.to_bytes()?;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let response: GetCapabilitiesRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
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
+            self.transport_sz = self.transport_sz.min(response.data_transfer_size);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 98922638a228b..080c2f2c49376 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -8,8 +8,16 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
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
 use crate::{
     SpdmErrorCode,
@@ -176,3 +184,312 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self
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
+    #[allow(clippy::get_first)]
+    fn from_bytes(buf: &[u8]) -> Result<Self, Error> {
+        let read_le16 = |off: usize| -> Result<u16, Error> {
+            Ok(u16::from_le_bytes(
+                buf.get(off..off + mem::size_of::<u16>())
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            ))
+        };
+        let read_le32 = |off: usize| -> Result<u32, Error> {
+            Ok(u32::from_le_bytes(
+                buf.get(off..off + mem::size_of::<u32>())
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            ))
+        };
+
+        let alg_struct_count = *buf.get(0).ok_or(EPROTO)?;
+        let length = read_le16(2)?;
+        let measurement_specification = *buf.get(4).ok_or(EPROTO)?;
+        let other_params_support = *buf.get(5).ok_or(EPROTO)?;
+        let base_asym_algo = read_le32(6)?;
+        let base_hash_algo = read_le32(10)?;
+        let ext_asym_count = *buf.get(26).ok_or(EPROTO)?;
+        let ext_hash_count = *buf.get(27).ok_or(EPROTO)?;
+        let mel_specification = *buf.get(29).ok_or(EPROTO)?;
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
+            let alg_type = *buf.get(offset).ok_or(EPROTO)?;
+            let alg_count = *buf.get(offset + 1).ok_or(EPROTO)?;
+
+            let fixed_alg_count = (alg_count & 0xf) as usize;
+            let ext_alg_count = (alg_count >> 4) as usize;
+
+            offset += 2;
+
+            let mut alg_supported = KVec::new();
+            alg_supported.extend_from_slice(
+                buf.get(offset..offset + fixed_alg_count).ok_or(EPROTO)?,
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
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl GetCapabilitiesRsp {
+    #[expect(dead_code)]
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<'c, T>>
+    for GetCapabilitiesRsp
+{
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_GET_CAPABILITIES - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        let ctexponent = *unvalidated.get(5).ok_or(EPROTO)?;
+        let flags = u32::from_le_bytes(
+            unvalidated
+                .get(8..12)
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        // DataTransferSize and MaxSPDMmsgSize only exist in SPDM 1.2 and later.
+        let (data_transfer_size, max_spdm_msg_size, supported_algorithms, length) = if context
+            .version
+            <= SPDM_VER_11
+        {
+            (
+                0,
+                0,
+                None,
+                mem::size_of::<SpdmHeader>() + 4 + mem::size_of::<u32>(),
+            )
+        } else {
+            let data_transfer_size = u32::from_le_bytes(
+                unvalidated
+                    .get(12..16)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            );
+            let max_spdm_msg_size = u32::from_le_bytes(
+                unvalidated
+                    .get(16..20)
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            );
+
+            if data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE {
+                pr_err!(
+                        "Invalid minimum transport size {data_transfer_size}, must be at least {SPDM_MIN_DATA_TRANSFER_SIZE}\n"
+                    );
+                return Err(EPROTONOSUPPORT);
+            }
+
+            let supported_algorithms = if header.param1 & SPDM_CAP_SUPPORTED_ALGORITHMS != 0 {
+                Some(SupportedAlgorithms::from_bytes(
+                    unvalidated.get(GET_CAPABILITIES_RSP_SZ..).ok_or(EPROTO)?,
+                )?)
+            } else {
+                None
+            };
+
+            let length = GET_CAPABILITIES_RSP_SZ
+                + supported_algorithms
+                    .as_ref()
+                    .map_or(0, |s| s.length as usize);
+
+            (
+                data_transfer_size,
+                max_spdm_msg_size,
+                supported_algorithms,
+                length,
+            )
+        };
+
+        Ok(GetCapabilitiesRsp {
+            header,
+            ctexponent,
+            flags,
+            data_transfer_size,
+            max_spdm_msg_size,
+            supported_algorithms,
+            length,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

