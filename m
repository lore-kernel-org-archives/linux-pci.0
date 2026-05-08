Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEF2FA0C6
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210348; cv=none; b=PAWyvNAFi9a1IHXohj71wzfr4Xq/EoF+KwNspSVmpU0Cg3/ztyVCfbYHr3Su34+wZsUqnkJkw3wBFglZ9JvGCtBoREjZIAUYnS8hgce1W2tFRzbqL5rlMYg/lGLPjC6JdeSTZOQIczb/WVQH0tGcbiKCjXse1RpMEY0U99WNgKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210348; c=relaxed/simple;
	bh=AEIRQMFJ78obs/Fig6dF1+21hQUwsD8gqjiemnD2yGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOQGQhbMPXkHD19u4NcWnL30KbuH0hd9LBJ68KZAGgU/MANkAeiI+SduUVU/O9kGiA3vpOzER7l1ZfBc/CfiZTsbqDSB1dg0UnTzUMYOqlKMBkSY4OWvHtTS/DCjdjlD8wJrfeiEekbzO9fgndCAc8ZoSwIFL6vCZqA7pqq7MGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA/eIkm7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA/eIkm7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b4650d5f5cso5724635ad.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210342; x=1778815142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67SIRNlN4DFhJcQDNjNjH5wMdIlffhQXlWGApt2+Y0k=;
        b=iA/eIkm7wnGuzAdFikXNwpvsyoNZ7NMjztzH8sDawquOmCqwzIAaqzbvQCr8qDpArq
         BMWyvsuXXxBve/Xzgdagevj2iULFZoD37rZQLgLnTNQe//bhaIjfUhnD/OgWrowTiFIz
         gzIIiJBsQf3nD2bPT2E3T+eHwhUPkEpNzSp5iG+o9EYhafostVMyTptHfeXwpjyWSVcA
         luucz3v9qZvyNAVBFp/m/2WRNpq/afWkJ9fjG6YP+Y7uHIK6Y2LlCNE7tEeo8aSb0urJ
         4cQrNlvioUA/+hMMJvkUXfZ4nhsYnYt1FTHe2roEbjXCl1ROthApvT1U4yoIWsoVucco
         nxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210342; x=1778815142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67SIRNlN4DFhJcQDNjNjH5wMdIlffhQXlWGApt2+Y0k=;
        b=YAIznyR+a4CwkrcRFGSNllhr9qLRsS5EkixMzbBxdxRacWLnHJYil2RmMnWkOkxacp
         j+8yP2BTkPFH+2f545jkz2T8f3sn493G9DDZp5HVkykF+z6cUepj+Es+Nxm/f5QThBT1
         dx4T1bnkCUr4zf10VzPr3vC45DDnRB+9ZXXoROIpQf8VkCfk0GmXfU1hUXfgf1q7w2MQ
         qC5TPiMzA7X1ESPdJrE0wK1nLxDKs1D8noThhWyAWNU4uk8+oOasDofKu9pKC4NKKDqv
         HkpqYmb4uszHhaT5+EGysz8uNmMlVUFWHXBURtA267BZS7DYBgAb1tUzNw60h4opqQ/q
         L38g==
X-Forwarded-Encrypted: i=1; AFNElJ/3CCNa05gFT8Yf0ZuHZl5yLmjD3xOg8ssbnTWFZ3sb1ayqB2Qthx2iyXu0MDEiwIQ/A234AXqHg8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtN9EzdifQ/hUmQqovFSLVoEw2cFuDrXtb5JvMipPz42hk2gzU
	m8cVyvgsRs3/o2o1F/M5/3hY3G+q/Zo+8XVYiM6QLGulrIseqgx9V0+M
X-Gm-Gg: Acq92OEOfqascKWV7/YRebWcn/DZhjq8QsDZqkTBoS2kUFFHrgHGrBJQF4mmaLaerOI
	7uSMph/4LPnlNb9kR1xokBwKf2OS4P3wfF9SFe8drBur/i/HpkyrlB30E1Rd+tBW+wBJ/2cmqoh
	P2pJziQNJxKlVZp24aIpeYI3alWN5fGJ1rPM1e6rRT1SLTOjNikBA6t5pHLreGhX2RLt6nbRyY4
	7B1AyhPyqHOdvfdURvhiEnmYGsVMrR+/NVLYNvGBxuMjo53VegS8sr7ZTUZ5TmKWcY0g9GvId/A
	A33zS6g0mG2cy3d/7jJTWIFmIMA/frpu0w9NaB5Bqw0wiQSevQHD33amc8bs3HZY7L3sFQDEwq/
	p9ZoNik41eVa5sBQ/jIGp4LcSbgAew/NrcBL70wGsJx6J10lqRS1/P5QiqC3OmlTqAIWJShfh4A
	+UYR4EP95kMw6jzeEbVNO75j6aCVhIUc2pbely4RvW
X-Received: by 2002:a17:903:1c8:b0:2b4:65d8:6a20 with SMTP id d9443c01a7336-2ba78f50177mr116458145ad.2.1778210341840;
        Thu, 07 May 2026 20:19:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:19:01 -0700 (PDT)
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
Subject: [PATCH 13/18] lib: rspdm: Support SPDM negotiate_algorithms
Date: Fri,  8 May 2026 13:17:05 +1000
Message-ID: <20260508031710.514574-14-alistair.francis@wdc.com>
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

Support the NEGOTIATE_ALGORITHMS SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |  65 ++++++++++++-
 lib/rspdm/lib.rs       |  18 +++-
 lib/rspdm/state.rs     | 211 +++++++++++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs | 115 +++++++++++++++++++++-
 4 files changed, 404 insertions(+), 5 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index ef7d2d1d8e6e..e4652b18eb2a 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -9,7 +9,11 @@
 
 use crate::validator::SpdmHeader;
 use core::mem;
-use kernel::bits::bit_u32;
+use kernel::bits::{
+    bit_u32,
+    bit_u8,
+    genmask_u32, //
+};
 
 /* SPDM versions supported by this implementation */
 pub(crate) const SPDM_VER_10: u8 = 0x10;
@@ -73,13 +77,68 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 // SPDM cryptographic timeout of this implementation:
 // Assume calculations may take up to 1 sec on a busy machine, which equals
-// roughly 1 << 20.  That's within the limits mandated for responders by CMA
-// (1 << 23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec 6.30.2).
+// roughly bit_u32(20.  That's within the limits mandated for responders by CMA
+// (bit_u32(23 usec, PCIe r6.2 sec 6.31.3) and DOE (1 sec, PCIe r6.2 sec 6.30.2).
 // Used in GET_CAPABILITIES exchange.
 pub(crate) const SPDM_CTEXPONENT: u8 = 20;
 
 pub(crate) const SPDM_CERT_CAP: u32 = bit_u32(1);
 pub(crate) const SPDM_CHAL_CAP: u32 = bit_u32(2);
+pub(crate) const SPDM_MEAS_CAP_MASK: u32 = genmask_u32(3..=4);
+pub(crate) const SPDM_KEY_EX_CAP: u32 = bit_u32(9);
 
 pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
 pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+
+pub(crate) const SPDM_NEGOTIATE_ALGS: u8 = 0xe3;
+
+pub(crate) const SPDM_MEAS_SPEC_DMTF: u8 = bit_u8(0);
+
+pub(crate) const SPDM_ASYM_RSASSA_2048: u32 = bit_u32(0);
+pub(crate) const _SPDM_ASYM_RSAPSS_2048: u32 = bit_u32(1);
+pub(crate) const SPDM_ASYM_RSASSA_3072: u32 = bit_u32(2);
+pub(crate) const _SPDM_ASYM_RSAPSS_3072: u32 = bit_u32(3);
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P256: u32 = bit_u32(4);
+pub(crate) const SPDM_ASYM_RSASSA_4096: u32 = bit_u32(5);
+pub(crate) const _SPDM_ASYM_RSAPSS_4096: u32 = bit_u32(6);
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P384: u32 = bit_u32(7);
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P521: u32 = bit_u32(8);
+pub(crate) const _SPDM_ASYM_SM2_ECC_SM2_P256: u32 = bit_u32(9);
+pub(crate) const _SPDM_ASYM_EDDSA_ED25519: u32 = bit_u32(10);
+pub(crate) const _SPDM_ASYM_EDDSA_ED448: u32 = bit_u32(11);
+
+pub(crate) const SPDM_HASH_SHA_256: u32 = bit_u32(0);
+pub(crate) const SPDM_HASH_SHA_384: u32 = bit_u32(1);
+pub(crate) const SPDM_HASH_SHA_512: u32 = bit_u32(2);
+
+// If the crypto support isn't enabled don't offer the algorithms
+// to the responder
+#[cfg(CONFIG_CRYPTO_RSA)]
+pub(crate) const SPDM_ASYM_RSA: u32 =
+    SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
+#[cfg(not(CONFIG_CRYPTO_RSA))]
+pub(crate) const SPDM_ASYM_RSA: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_ECDSA)]
+pub(crate) const SPDM_ASYM_ECDSA: u32 =
+    SPDM_ASYM_ECDSA_ECC_NIST_P256 | SPDM_ASYM_ECDSA_ECC_NIST_P384 | SPDM_ASYM_ECDSA_ECC_NIST_P521;
+#[cfg(not(CONFIG_CRYPTO_ECDSA))]
+pub(crate) const SPDM_ASYM_ECDSA: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_SHA256)]
+pub(crate) const SPDM_HASH_SHA2_256: u32 = SPDM_HASH_SHA_256;
+#[cfg(not(CONFIG_CRYPTO_SHA256))]
+pub(crate) const SPDM_HASH_SHA2_256: u32 = 0;
+
+#[cfg(CONFIG_CRYPTO_SHA512)]
+pub(crate) const SPDM_HASH_SHA2_384_512: u32 = SPDM_HASH_SHA_384 | SPDM_HASH_SHA_512;
+#[cfg(not(CONFIG_CRYPTO_SHA512))]
+pub(crate) const SPDM_HASH_SHA2_384_512: u32 = 0;
+
+pub(crate) const SPDM_ASYM_ALGOS: u32 = SPDM_ASYM_RSA | SPDM_ASYM_ECDSA;
+pub(crate) const SPDM_HASH_ALGOS: u32 = SPDM_HASH_SHA2_256 | SPDM_HASH_SHA2_384_512;
+
+/* Maximum number of ReqAlgStructs sent by this implementation */
+// pub(crate) const SPDM_MAX_REQ_ALG_STRUCT: usize = 4;
+
+pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 9628f258854c..72886a5dfd69 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -116,6 +116,10 @@
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
@@ -123,4 +127,16 @@
 ///
 /// @spdm_state: SPDM session state
 #[export]
-pub unsafe extern "C" fn spdm_destroy(_state_ptr: *mut spdm_state) {}
+pub unsafe extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
+    let state: &mut SpdmState = unsafe { &mut (*(state_ptr as *mut SpdmState)) };
+
+    if let Some(desc) = &mut state.desc {
+        unsafe {
+            bindings::kfree(*desc as *mut _ as *mut c_void);
+        }
+    }
+
+    unsafe {
+        bindings::crypto_free_shash(state.shash);
+    }
+}
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index e7119ffa9a69..34676744e509 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -14,19 +14,36 @@
     bindings,
     error::{
         code::EINVAL,
+        from_err_ptr,
         to_result,
         Error, //
     },
+    str::CStr,
     validate::Untrusted,
 };
 
 use crate::consts::{
     SpdmErrorCode,
+    SPDM_ASYM_ALGOS,
+    SPDM_ASYM_ECDSA_ECC_NIST_P256,
+    SPDM_ASYM_ECDSA_ECC_NIST_P384,
+    SPDM_ASYM_ECDSA_ECC_NIST_P521,
+    SPDM_ASYM_RSASSA_2048,
+    SPDM_ASYM_RSASSA_3072,
+    SPDM_ASYM_RSASSA_4096,
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
+    SPDM_HASH_ALGOS,
+    SPDM_HASH_SHA_256,
+    SPDM_HASH_SHA_384,
+    SPDM_HASH_SHA_512,
+    SPDM_KEY_EX_CAP,
     SPDM_MAX_VER,
+    SPDM_MEAS_CAP_MASK,
+    SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
+    SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_VER_10,
@@ -38,6 +55,8 @@
     GetCapabilitiesRsp,
     GetVersionReq,
     GetVersionRsp,
+    NegotiateAlgsReq,
+    NegotiateAlgsRsp,
     SpdmErrorRsp,
     SpdmHeader, //
 };
@@ -56,6 +75,25 @@
 ///  Negotiated during GET_VERSION exchange.
 /// @rsp_caps: Cached capabilities of responder.
 ///  Received during GET_CAPABILITIES exchange.
+/// @base_asym_alg: Asymmetric key algorithm for signature verification of
+///  CHALLENGE_AUTH and MEASUREMENTS messages.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @base_hash_alg: Hash algorithm for signature verification of
+///  CHALLENGE_AUTH and MEASUREMENTS messages.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @meas_hash_alg: Hash algorithm for measurement blocks.
+///  Selected by responder during NEGOTIATE_ALGORITHMS exchange.
+/// @base_asym_enc: Human-readable name of @base_asym_alg's signature encoding.
+///  Passed to crypto subsystem when calling verify_signature().
+/// @sig_len: Signature length of @base_asym_alg (in bytes).
+///  S or SigLen in SPDM specification.
+/// @base_hash_alg_name: Human-readable name of @base_hash_alg.
+///  Passed to crypto subsystem when calling crypto_alloc_shash() and
+///  verify_signature().
+/// @shash: Synchronous hash handle for @base_hash_alg computation.
+/// @desc: Synchronous hash context for @base_hash_alg computation.
+/// @hash_len: Hash length of @base_hash_alg (in bytes).
+///  H in SPDM specification.
 #[expect(dead_code)]
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
@@ -67,6 +105,19 @@ pub struct SpdmState {
     // Negotiated state
     pub(crate) version: u8,
     pub(crate) rsp_caps: u32,
+    pub(crate) base_asym_alg: u32,
+    pub(crate) base_hash_alg: u32,
+    pub(crate) meas_hash_alg: u32,
+
+    /* Signature algorithm */
+    base_asym_enc: &'static CStr,
+    sig_len: usize,
+
+    /* Hash algorithm */
+    base_hash_alg_name: &'static CStr,
+    pub(crate) shash: *mut bindings::crypto_shash,
+    pub(crate) desc: Option<&'static mut bindings::shash_desc>,
+    pub(crate) hash_len: usize,
 }
 
 impl SpdmState {
@@ -85,6 +136,15 @@ pub(crate) fn new(
             validate,
             version: SPDM_MIN_VER,
             rsp_caps: 0,
+            base_asym_alg: 0,
+            base_hash_alg: 0,
+            meas_hash_alg: 0,
+            base_asym_enc: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
+            sig_len: 0,
+            base_hash_alg_name: unsafe { CStr::from_bytes_with_nul_unchecked(b"\0") },
+            shash: core::ptr::null_mut(),
+            desc: None,
+            hash_len: 0,
         }
     }
 
@@ -367,4 +427,155 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn update_response_algs(&mut self) -> Result<(), Error> {
+        match self.base_asym_alg {
+            SPDM_ASYM_RSASSA_2048 => {
+                self.sig_len = 256;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_RSASSA_3072 => {
+                self.sig_len = 384;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_RSASSA_4096 => {
+                self.sig_len = 512;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"pkcs1\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P256 => {
+                self.sig_len = 64;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P384 => {
+                self.sig_len = 96;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            SPDM_ASYM_ECDSA_ECC_NIST_P521 => {
+                self.sig_len = 132;
+                self.base_asym_enc = CStr::from_bytes_with_nul(b"p1363\0")?;
+            }
+            _ => {
+                pr_err!("Unknown asym algorithm\n");
+                return Err(EINVAL);
+            }
+        }
+
+        match self.base_hash_alg {
+            SPDM_HASH_SHA_256 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha256\0")?;
+            }
+            SPDM_HASH_SHA_384 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha384\0")?;
+            }
+            SPDM_HASH_SHA_512 => {
+                self.base_hash_alg_name = CStr::from_bytes_with_nul(b"sha512\0")?;
+            }
+            _ => {
+                pr_err!("Unknown hash algorithm\n");
+                return Err(EINVAL);
+            }
+        }
+
+        /*
+         * shash and desc allocations are reused for subsequent measurement
+         * retrieval, hence are not freed until spdm_reset().
+         */
+        self.shash =
+            unsafe { bindings::crypto_alloc_shash(self.base_hash_alg_name.as_char_ptr(), 0, 0) };
+        from_err_ptr(self.shash)?;
+
+        let desc_len = core::mem::size_of::<bindings::shash_desc>()
+            + unsafe { bindings::crypto_shash_descsize(self.shash) } as usize;
+
+        let mut desc_vec: KVec<u8> = KVec::with_capacity(desc_len, GFP_KERNEL)?;
+        // SAFETY: `desc_vec` is `desc_len` long
+        let desc_buf = unsafe { from_raw_parts_mut(desc_vec.as_mut_ptr(), desc_len) };
+
+        let desc = unsafe {
+            core::mem::transmute::<*mut c_void, &mut bindings::shash_desc>(
+                desc_buf.as_mut_ptr() as *mut c_void
+            )
+        };
+        desc.tfm = self.shash;
+
+        self.desc = Some(desc);
+
+        /* Used frequently to compute offsets, so cache H */
+        self.hash_len = unsafe { bindings::crypto_shash_digestsize(self.shash) as usize };
+
+        if let Some(desc) = &mut self.desc {
+            unsafe { to_result(bindings::crypto_shash_init(*desc)) }
+        } else {
+            Err(ENOMEM)
+        }
+    }
+
+    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
+        let mut request = NegotiateAlgsReq::default();
+        request.version = self.version;
+
+        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
+            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
+        }
+
+        let req_sz = core::mem::size_of::<NegotiateAlgsReq>();
+        let rsp_sz = core::mem::size_of::<NegotiateAlgsRsp>();
+
+        request.length = req_sz as u16;
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
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut NegotiateAlgsRsp =
+            Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        self.base_asym_alg = response.base_asym_sel;
+        self.base_hash_alg = response.base_hash_sel;
+        self.meas_hash_alg = response.measurement_hash_algo;
+
+        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
+            pr_err!("No common supported algorithms\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+        if self.base_asym_alg.count_ones() != 1
+            || self.base_hash_alg.count_ones() != 1
+            || response.ext_asym_sel_count != 0
+            || response.ext_hash_sel_count != 0
+            || response.param1 > request.param1
+            || response.other_params_sel != request.other_params_support
+        {
+            pr_err!("Malformed algorithms response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        if self.rsp_caps & SPDM_MEAS_CAP_MASK == SPDM_MEAS_CAP_MASK
+            && (self.meas_hash_alg.count_ones() != 1
+                || response.measurement_specification_sel != SPDM_MEAS_SPEC_DMTF)
+        {
+            pr_err!("Malformed algorithms response\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        self.update_response_algs()?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 7dc55882c880..9d738133399d 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -9,7 +9,8 @@
 
 use crate::bindings::{
     __IncompleteArrayField,
-    __le16, //
+    __le16,
+    __le32, //
 };
 use crate::consts::SpdmErrorCode;
 use core::mem;
@@ -26,10 +27,14 @@
 };
 
 use crate::consts::{
+    SPDM_ASYM_ALGOS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
+    SPDM_HASH_ALGOS,
+    SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_VER,
+    SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS, //
     SPDM_VER_11,
 };
@@ -236,3 +241,111 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct RegAlg {
+    pub(crate) alg_type: u8,
+    pub(crate) alg_count: u8,
+    pub(crate) alg_supported: u16,
+    pub(crate) alg_external: __IncompleteArrayField<__le32>,
+}
+
+#[repr(C, packed)]
+pub(crate) struct NegotiateAlgsReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8, // size of resp_alg_struct
+    param2: u8,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification: u8,
+    pub(crate) other_params_support: u8,
+
+    pub(crate) base_asym_algo: u32,
+    pub(crate) base_hash_algo: u32,
+
+    reserved1: [u8; 12],
+
+    pub(crate) ext_asym_count: u8,
+    pub(crate) ext_hash_count: u8,
+    reserved2: u8,
+    pub(crate) mel_specification: u8,
+
+    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
+    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
+    pub(crate) resp_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl Default for NegotiateAlgsReq {
+    fn default() -> Self {
+        NegotiateAlgsReq {
+            version: 0,
+            code: SPDM_NEGOTIATE_ALGS,
+            param1: 0, // Size of resp_alg_struct
+            param2: 0,
+            length: 32,
+            measurement_specification: SPDM_MEAS_SPEC_DMTF,
+            other_params_support: 0,
+            base_asym_algo: SPDM_ASYM_ALGOS.to_le(),
+            base_hash_algo: SPDM_HASH_ALGOS.to_le(),
+            reserved1: [0u8; 12],
+            ext_asym_count: 0,
+            ext_hash_count: 0,
+            reserved2: 0,
+            mel_specification: 0,
+            ext_asym: __IncompleteArrayField::new(),
+            ext_hash: __IncompleteArrayField::new(),
+            resp_alg_struct: __IncompleteArrayField::new(),
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct NegotiateAlgsRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification_sel: u8,
+    pub(crate) other_params_sel: u8,
+
+    pub(crate) measurement_hash_algo: u32,
+    pub(crate) base_asym_sel: u32,
+    pub(crate) base_hash_sel: u32,
+
+    reserved1: [u8; 11],
+
+    pub(crate) mel_specification_sel: u8,
+    pub(crate) ext_asym_sel_count: u8,
+    pub(crate) ext_hash_sel_count: u8,
+    reserved2: [u8; 2],
+
+    pub(crate) ext_asym: __IncompleteArrayField<__le32>,
+    pub(crate) ext_hash: __IncompleteArrayField<__le32>,
+    pub(crate) resp_alg_struct: __IncompleteArrayField<RegAlg>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut NegotiateAlgsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<NegotiateAlgsRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `NegotiateAlgsRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<NegotiateAlgsRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut NegotiateAlgsRsp = unsafe { &mut *ptr };
+
+        rsp.base_asym_sel = rsp.base_asym_sel.to_le();
+        rsp.base_hash_sel = rsp.base_hash_sel.to_le();
+        rsp.measurement_hash_algo = rsp.measurement_hash_algo.to_le();
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

