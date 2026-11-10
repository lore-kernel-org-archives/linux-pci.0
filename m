Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284472;
	b=QDFqqeTucUTXEvjG1vU+/7IPb7o87AIzgC9D8CmNfb7zL/r1IF9MPexMqvIfAXoExwC3
	 xbNEWEx/cjowGSSdY7Cg/ac4AmlAHko1gL+gnr+a/IewqsH5GcCsLOi09w1FzaE6xQ/Db
	 evhKby8+H7hGbNnL0NSDzWljNhloKrLzDymzmqGWsjM5o50uTQ/Bf02Qzu4Nz21fbkVna
	 YnDQX9vqWMNss0gbCGNvCibiCN9VTuH18B6AZ0hpeOYE05LuFw1EZaBW7/WgoSFGQAi7p
	 aNYWX+lfLE4oZcN4YIsl0uxItKJpSsgi9psZssLcGzhgsPX1OSpCr4r6AQTdIcSFavA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EwvKeArnVMX8NeJ2nNsuyd5kMrTehXi5rqXuoXnCGcg=;
	b=jrgnJq+AGKlnvxtHC2O9y9sRhIxzPwjeWn1qQ/qnqiJBDfpFA0l5uvguc0m6zg6ArsCD
	 fVkL0h1wapSxAWVydqxK9J8PzA2OBi/tHzKUL6sEm12CLZ7ATANbjPUhbfefwCbmlxbr7
	 He1B1UwaVmN2sAfpLMC/dncPsf+ns/BotILHgU4DFROfkwg9up4AarvEz6IP6lv/eBJOP
	 mS8XFSFzH3GJDzGM+DF8yiAz9wYHzW9Gj+Y1bbxMyjANL2I5IWCcmUPbUz4Opdbn//g9G
	 lczVom28pdD1eFOGUEMwMZzzrVIgrmNF2ym7m21K65UOtCIRNd4UY0WTCL0B/Wr1Pgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3rIShRz;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF0606E8CF
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59DF0606E8CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3rIShRz
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15dd124bbe7so1816032c88.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284470; x=1794889270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EwvKeArnVMX8NeJ2nNsuyd5kMrTehXi5rqXuoXnCGcg=;
        b=J3rIShRzN2KguKAmQhaFKFuHxwesvB+olgoPQtkl5cftOOC7HsGyEIVJ+lQQftbGyD
         RLrL9zCFTaIlNbRiCneDRWNfi7kzFG3Rs/tGtPcbLTWSC/+FmlSxyCZEgWtCEXyW6WeL
         lgbInQAcoOmpZiBEDlcMPdWxAjPOzoZuABeo+Rs/Py/LP8219h105acmsJsAWCY83fqj
         qXJWKJY4JLAYM2ZBPPDUKgTUbQ3BHVPICvxQ2eiIjcluLRGmblrtVYqk+D3TcfE6fmT9
         qX60S5qfAqGkRIHGK34YJZErCjdn1M1pHNVkOr3ka0Ie7b/1fnQSfi7TP2OD69UsZjrO
         BlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284470; x=1794889270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EwvKeArnVMX8NeJ2nNsuyd5kMrTehXi5rqXuoXnCGcg=;
        b=sks3IycEzsXliyX2SG2TRWGoUJEqlk+JYnBwe2sjuy8gkblgpm+pa3D0Hz/rdnSK80
         p7RjEiV9VCweVySNssihR5e+qYCyvVYwRtzuafSRW/Cm4kzzSV5K1lDS3tVCzjcXP+23
         jgUqSdja3MVp+R7kduNAASzkHqgvr+eK9MZ/NyN//mKAOJD7NO0eyqJhuFLK6udOVrvK
         QSfD9YAhGSrUMUzEsMXpJvLfTMb/EOvNSsPfaEYLSvq1wEcEZAChPSLWDZlDkfFNL12l
         LAETbcrLxHPgFXFYQ4UzXe7lbeRdimCulDPNyDons1Ytv3QAeXl3QUOiCOrM8KUt8Tj9
         oU2w==
X-Forwarded-Encrypted: i=1; AL+hErGMtZM8s7d1tPDtiMSVUVotYce6hrsMEbxqksa/exMM9AE+vU720ewFPCOI/FqjMoxOqRYHN28D4n4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7nTEqGb2JU4h/OpAF41xLmEGIF/C3RGVClPFqm/GMKuEDF4RI
	5yIZ5k581BYrWOJkXdB6Vs4SLULGZaHPBRmqajk4FwOtw67Zm5ZBFjjd
X-Gm-Gg: AYBFou1y1lk02a0ReG1RLeumT95RIGHTk3xlApPxlZcUQAK0H70m9CvCsp5bH/pWPxb
	Sp3oxSrumpbgz2Q5D6rSykgyJTyX1BumQzb13ojLsCdlZI+gwno/A/75VFUzml2McH4Giks4JJ5
	BkOTHcVrPIio/jyiPzu1z0lkJ3cP2FSpDCSeyMDGV3/tRfYF2pSDmFSOhuO6FIUn6X+egcaMJem
	e+ZJNvTG/Ezdt1bKwGLo0yNMAmkhUnB33G2sB8dQuW6yzBYsAY0l3RfxvPfwiLbUhAwL5RdS6zQ
	6UHnH/A/KrFmNYiHMqrGEBUkF3CiwZN/b/Dvpootvr/cCkp9De1zN56wxJJhi4hjhrJB9WAXrm1
	5MD2AqO/DPIJBq1lRqX7XKcom1d4YNanHBvoZGuwDPNKzgB/n3jGzmLC7qK6FcMuaCJ4wyMwEE0
	E5nQMPvVg7mxtBa0wsXWl9wLPdLsgujcU1TUGYtTjgb8FiXSShvO+VXwHPI+sK0oRg895wPb0FE
	83W/CRsffd/cSAO8W++5Pr5sd7HMXiZrC+AslsjT6YhEr1idDHzNUCKdoh4QyITZlHguVFahbSm
	rsIDXRSEO02+bVPuw1Hu4GVUeIHVt46ma5adX30Jjq60Sas=
X-Received: by 2002:a05:701b:2613:b0:1b3:b6d3:b91c with SMTP id a92af1059eb24-1b3b6d3b976mr1747101c88.7.1794284470328;
        Mon, 09 Nov 2026 20:21:10 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:09 -0800 (PST)
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
Subject: [PATCH v6 17/25] lib: rspdm: Support SPDM negotiate_algorithms
Date: Tue, 10 Nov 2026 14:18:24 +1000
Message-ID: <20261110041832.1730924-18-alistair.francis@wdc.com>
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

Support the NEGOTIATE_ALGORITHMS SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/consts.rs    |  61 +++++++++++
 lib/rspdm/lib.rs       |   4 +
 lib/rspdm/state.rs     | 169 +++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 233 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 466 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 43be144251190..bcc149de77425 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -45,7 +45,68 @@
 
 pub(crate) const SPDM_CERT_CAP: u32 = bit_u32(1);
 pub(crate) const SPDM_CHAL_CAP: u32 = bit_u32(2);
+pub(crate) const SPDM_MEAS_RESP_CAP: u32 = bit_u32(3) | bit_u32(4);
+pub(crate) const SPDM_KEY_EX_CAP: u32 = bit_u32(9);
 pub(crate) const SPDM_MULTI_KEY_CAP: u32 = bit_u32(26) | bit_u32(27);
 
 pub(crate) const SPDM_REQ_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
 pub(crate) const SPDM_RSP_MIN_CAPS: u32 = SPDM_CERT_CAP | SPDM_CHAL_CAP;
+
+pub(crate) const SPDM_NEGOTIATE_ALGS: u8 = 0xe3;
+
+pub(crate) const SPDM_MEAS_SPEC_DMTF: u8 = bit_u8(0);
+
+#[cfg(CONFIG_CRYPTO_RSA)]
+pub(crate) const SPDM_ASYM_RSASSA_2048: u32 = bit_u32(0);
+pub(crate) const _SPDM_ASYM_RSAPSS_2048: u32 = bit_u32(1);
+#[cfg(CONFIG_CRYPTO_RSA)]
+pub(crate) const SPDM_ASYM_RSASSA_3072: u32 = bit_u32(2);
+pub(crate) const _SPDM_ASYM_RSAPSS_3072: u32 = bit_u32(3);
+#[cfg(CONFIG_CRYPTO_ECDSA)]
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P256: u32 = bit_u32(4);
+#[cfg(CONFIG_CRYPTO_RSA)]
+pub(crate) const SPDM_ASYM_RSASSA_4096: u32 = bit_u32(5);
+pub(crate) const _SPDM_ASYM_RSAPSS_4096: u32 = bit_u32(6);
+#[cfg(CONFIG_CRYPTO_ECDSA)]
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P384: u32 = bit_u32(7);
+#[cfg(CONFIG_CRYPTO_ECDSA)]
+pub(crate) const SPDM_ASYM_ECDSA_ECC_NIST_P521: u32 = bit_u32(8);
+pub(crate) const _SPDM_ASYM_SM2_ECC_SM2_P256: u32 = bit_u32(9);
+pub(crate) const _SPDM_ASYM_EDDSA_ED25519: u32 = bit_u32(10);
+pub(crate) const _SPDM_ASYM_EDDSA_ED448: u32 = bit_u32(11);
+
+#[cfg(CONFIG_CRYPTO_SHA256)]
+pub(crate) const SPDM_HASH_SHA_256: u32 = bit_u32(0);
+#[cfg(CONFIG_CRYPTO_SHA512)]
+pub(crate) const SPDM_HASH_SHA_384: u32 = bit_u32(1);
+#[cfg(CONFIG_CRYPTO_SHA512)]
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
+pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 9b0211ae76f55..2d5eddd9fdc8c 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -272,6 +272,10 @@ fn from(code: SpdmErrorCode) -> Self {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index cb6a351fe6085..169d0d3fee9bd 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -12,31 +12,62 @@
     bindings,
     device::Device,
     error::Error,
+    hash::Shash,
     page::PAGE_SIZE,
+    str::CStr,
     sync::aref::ARef,
     validate::Untrusted, //
 };
 
 use crate::consts::{
+    SPDM_ASYM_ALGOS,
     SPDM_ERROR,
     SPDM_GET_VERSION_LEN,
+    SPDM_HASH_ALGOS,
+    SPDM_KEY_EX_CAP,
     SPDM_MAX_VER,
+    SPDM_MEAS_RESP_CAP,
+    SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_VER,
     SPDM_MULTI_KEY_CAP,
+    SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_VER_10,
     SPDM_VER_11,
     SPDM_VER_12, //
 };
+
+#[cfg(CONFIG_CRYPTO_SHA256)]
+use crate::consts::SPDM_HASH_SHA_256;
+#[cfg(CONFIG_CRYPTO_ECDSA)]
+use crate::consts::{
+    SPDM_ASYM_ECDSA_ECC_NIST_P256,
+    SPDM_ASYM_ECDSA_ECC_NIST_P384,
+    SPDM_ASYM_ECDSA_ECC_NIST_P521, //
+};
+#[cfg(CONFIG_CRYPTO_RSA)]
+use crate::consts::{
+    SPDM_ASYM_RSASSA_2048,
+    SPDM_ASYM_RSASSA_3072,
+    SPDM_ASYM_RSASSA_4096, //
+};
+#[cfg(CONFIG_CRYPTO_SHA512)]
+use crate::consts::{
+    SPDM_HASH_SHA_384,
+    SPDM_HASH_SHA_512, //
+};
 use crate::validator::{
     GetCapabilitiesReq,
     GetCapabilitiesRsp,
     GetVersionReq,
     GetVersionRsp,
+    NegotiateAlgsReq,
+    NegotiateAlgsRsp,
     SpdmErrorRsp,
     SpdmHeader,
-    GET_CAPABILITIES_RSP_SZ, //
+    GET_CAPABILITIES_RSP_SZ,
+    NEGOTIATE_ALGS_RSP_SZ, //
 };
 
 /// Transport for exchanging SPDM messages with a responder device.
@@ -87,6 +118,27 @@ pub(crate) struct SpdmState<T: Transport> {
     /// Cached capabilities of responder. Received during GET_CAPABILITIES
     /// exchange.
     pub(crate) rsp_caps: u32,
+    /// Asymmetric key algorithm for signature verification of CHALLENGE_AUTH
+    /// and MEASUREMENTS messages. Selected by responder during
+    /// NEGOTIATE_ALGORITHMS exchange.
+    pub(crate) base_asym_alg: u32,
+    /// Hash algorithm for signature verification of CHALLENGE_AUTH and
+    /// MEASUREMENTS messages. Selected by responder during
+    /// NEGOTIATE_ALGORITHMS exchange.
+    pub(crate) base_hash_alg: u32,
+    /// Hash algorithm for measurement blocks. Selected by responder during
+    /// NEGOTIATE_ALGORITHMS exchange.
+    pub(crate) meas_hash_alg: u32,
+
+    /// Human-readable name of `base_asym_alg`'s signature encoding. Passed
+    /// to the crypto subsystem when calling `verify_signature()`.
+    base_asym_enc: &'static CStr,
+    /// Signature length of `base_asym_alg` (in bytes). S or SigLen in SPDM
+    /// specification.
+    sig_len: usize,
+
+    /// Hash transformation for `base_hash_alg` computation.
+    crypto: Option<Shash>,
 }
 
 impl<T: Transport> SpdmState<T> {
@@ -109,6 +161,12 @@ pub(crate) fn new(
             validate,
             version: SPDM_MIN_VER,
             rsp_caps: 0,
+            base_asym_alg: 0,
+            base_hash_alg: 0,
+            meas_hash_alg: 0,
+            base_asym_enc: c"",
+            sig_len: 0,
+            crypto: None,
         }
     }
 
@@ -265,4 +323,113 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn update_response_algs(&mut self) -> Result<(), Error> {
+        match self.base_asym_alg {
+            #[cfg(CONFIG_CRYPTO_RSA)]
+            SPDM_ASYM_RSASSA_2048 => {
+                self.sig_len = 256;
+                self.base_asym_enc = c"pkcs1";
+            }
+            #[cfg(CONFIG_CRYPTO_RSA)]
+            SPDM_ASYM_RSASSA_3072 => {
+                self.sig_len = 384;
+                self.base_asym_enc = c"pkcs1";
+            }
+            #[cfg(CONFIG_CRYPTO_RSA)]
+            SPDM_ASYM_RSASSA_4096 => {
+                self.sig_len = 512;
+                self.base_asym_enc = c"pkcs1";
+            }
+            #[cfg(CONFIG_CRYPTO_ECDSA)]
+            SPDM_ASYM_ECDSA_ECC_NIST_P256 => {
+                self.sig_len = 64;
+                self.base_asym_enc = c"p1363";
+            }
+            #[cfg(CONFIG_CRYPTO_ECDSA)]
+            SPDM_ASYM_ECDSA_ECC_NIST_P384 => {
+                self.sig_len = 96;
+                self.base_asym_enc = c"p1363";
+            }
+            #[cfg(CONFIG_CRYPTO_ECDSA)]
+            SPDM_ASYM_ECDSA_ECC_NIST_P521 => {
+                self.sig_len = 132;
+                self.base_asym_enc = c"p1363";
+            }
+            _ => {
+                dev_err!(&self.dev, "Unknown asym algorithm\n");
+                return Err(EPROTO);
+            }
+        }
+
+        let hash_name = match self.base_hash_alg {
+            #[cfg(CONFIG_CRYPTO_SHA256)]
+            SPDM_HASH_SHA_256 => c"sha256",
+            #[cfg(CONFIG_CRYPTO_SHA512)]
+            SPDM_HASH_SHA_384 => c"sha384",
+            #[cfg(CONFIG_CRYPTO_SHA512)]
+            SPDM_HASH_SHA_512 => c"sha512",
+            _ => {
+                dev_err!(&self.dev, "Unknown hash algorithm\n");
+                return Err(EPROTO);
+            }
+        };
+
+        self.crypto = Some(Shash::new(hash_name)?);
+
+        Ok(())
+    }
+
+    pub(crate) fn negotiate_algs(&mut self) -> Result<(), Error> {
+        let mut request = NegotiateAlgsReq::default();
+        request.header.version = self.version;
+
+        if self.version >= SPDM_VER_12 && (self.rsp_caps & SPDM_KEY_EX_CAP) == SPDM_KEY_EX_CAP {
+            request.other_params_support = SPDM_OPAQUE_DATA_FMT_GENERAL;
+        }
+
+        // We never offer extended algorithms or algorithm structures, so a
+        // compliant response is exactly NEGOTIATE_ALGS_RSP_SZ bytes.
+        let rsp_sz = NEGOTIATE_ALGS_RSP_SZ.min(self.data_transfer_sz as usize);
+
+        request.length = NegotiateAlgsReq::WIRE_SIZE as u16;
+
+        let mut request_buf = request.to_bytes()?;
+
+        let response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let response: NegotiateAlgsRsp = self
+            .spdm_exchange(request_buf.as_mut_slice(), response_vec)?
+            .validate(&*self)?;
+
+        self.base_asym_alg = response.base_asym_sel;
+        self.base_hash_alg = response.base_hash_sel;
+        self.meas_hash_alg = response.measurement_hash_algo;
+
+        if self.base_asym_alg & SPDM_ASYM_ALGOS == 0 || self.base_hash_alg & SPDM_HASH_ALGOS == 0 {
+            dev_err!(&self.dev, "No common supported algorithms\n");
+            return Err(EPROTO);
+        }
+
+        let meas_hash_valid = if self.rsp_caps & SPDM_MEAS_RESP_CAP != 0 {
+            response.measurement_specification_sel == SPDM_MEAS_SPEC_DMTF
+                && self.meas_hash_alg.count_ones() == 1
+        } else {
+            response.measurement_specification_sel == 0 && self.meas_hash_alg == 0
+        };
+
+        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+        if self.base_asym_alg.count_ones() != 1
+            || self.base_hash_alg.count_ones() != 1
+            || !meas_hash_valid
+            || response.other_params_sel != request.other_params_support
+        {
+            dev_err!(&self.dev, "Malformed algorithms response\n");
+            return Err(EPROTO);
+        }
+
+        self.update_response_algs()?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 66212f0faf5f1..335f2f43dc07c 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -8,12 +8,16 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
 use crate::consts::{
+    SPDM_ASYM_ALGOS,
     SPDM_CAP_SUPPORTED_ALGORITHMS,
     SPDM_CTEXPONENT,
     SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
+    SPDM_HASH_ALGOS,
+    SPDM_MEAS_SPEC_DMTF,
     SPDM_MIN_DATA_TRANSFER_SIZE,
     SPDM_MIN_VER,
+    SPDM_NEGOTIATE_ALGS,
     SPDM_REQ_CAPS,
     SPDM_VER_10,
     SPDM_VER_11,
@@ -492,3 +496,232 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Se
         })
     }
 }
+
+pub(crate) struct NegotiateAlgsReq {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) length: u16,
+    pub(crate) measurement_specification: u8,
+    pub(crate) other_params_support: u8,
+
+    pub(crate) base_asym_algo: u32,
+    pub(crate) base_hash_algo: u32,
+
+    pub(crate) ext_asym_count: u8,
+    pub(crate) ext_hash_count: u8,
+    pub(crate) mel_specification: u8,
+    // ext_asym
+    // ext_hash
+    // resp_alg_struct
+}
+
+impl NegotiateAlgsReq {
+    pub(crate) const WIRE_SIZE: usize = mem::size_of::<SpdmHeader>() + 28;
+
+    pub(crate) fn to_bytes(&self) -> Result<KVec<u8>> {
+        let mut out = self.header.to_bytes()?;
+
+        out.extend_from_slice(&self.length.to_le_bytes(), GFP_KERNEL)?;
+        out.push(self.measurement_specification, GFP_KERNEL)?;
+        out.push(self.other_params_support, GFP_KERNEL)?;
+
+        out.extend_from_slice(&self.base_asym_algo.to_le_bytes(), GFP_KERNEL)?;
+        out.extend_from_slice(&self.base_hash_algo.to_le_bytes(), GFP_KERNEL)?;
+
+        out.extend_from_slice(&[0u8; 12], GFP_KERNEL)?;
+
+        out.push(self.ext_asym_count, GFP_KERNEL)?;
+        out.push(self.ext_hash_count, GFP_KERNEL)?;
+        out.push(0u8, GFP_KERNEL)?;
+        out.push(self.mel_specification, GFP_KERNEL)?;
+
+        Ok(out)
+    }
+}
+
+impl Default for NegotiateAlgsReq {
+    fn default() -> Self {
+        NegotiateAlgsReq {
+            header: SpdmHeader::new(SPDM_NEGOTIATE_ALGS),
+
+            length: 32,
+            measurement_specification: SPDM_MEAS_SPEC_DMTF,
+            other_params_support: 0,
+            base_asym_algo: SPDM_ASYM_ALGOS,
+            base_hash_algo: SPDM_HASH_ALGOS,
+            ext_asym_count: 0,
+            ext_hash_count: 0,
+            mel_specification: 0,
+        }
+    }
+}
+
+/// Size of  everything up to the variable-length algorithm arrays (ExtAsymSel).
+pub(crate) const NEGOTIATE_ALGS_RSP_SZ: usize = mem::size_of::<SpdmHeader>() + 32;
+
+#[expect(dead_code)]
+pub(crate) struct NegotiateAlgsRsp {
+    pub(crate) header: SpdmHeader,
+
+    pub(crate) measurement_specification_sel: u8,
+    pub(crate) other_params_sel: u8,
+
+    pub(crate) measurement_hash_algo: u32,
+    pub(crate) base_asym_sel: u32,
+    pub(crate) base_hash_sel: u32,
+
+    pub(crate) mel_specification_sel: u8,
+    pub(crate) ext_asym_sel_count: u8,
+    pub(crate) ext_hash_sel_count: u8,
+
+    pub(crate) ext_asym: KVec<u32>,
+    pub(crate) ext_hash: KVec<u32>,
+    pub(crate) resp_alg_struct: KVec<RespAlgStruct>,
+
+    /// The actual length of the SPDM message. `raw_bytes` might be longer
+    /// as it includes transport specific padding.
+    length: usize,
+
+    /// Entire response, used for the transcript hash.
+    raw_bytes: KVec<u8>,
+}
+
+impl NegotiateAlgsRsp {
+    #[expect(dead_code)]
+    pub(crate) fn as_bytes(&self) -> Result<&[u8], Error> {
+        self.raw_bytes.get(..self.length).ok_or(EPROTO)
+    }
+}
+
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<T>> for NegotiateAlgsRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_NEGOTIATE_ALGS - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            dev_err!(&context.dev, "Invalid version response\n");
+            return Err(EPROTO);
+        }
+
+        // Make sure all of the fixed length data is included
+        if unvalidated.len() < NEGOTIATE_ALGS_RSP_SZ {
+            dev_err!(&context.dev, "Truncated algorithm response\n");
+            return Err(EPROTO);
+        }
+
+        let resp_len = u16::from_le_bytes(
+            unvalidated
+                .get(4..4 + mem::size_of::<u16>())
+                .ok_or(EPROTO)?
+                .try_into()
+                .map_err(|_| EPROTO)?,
+        );
+
+        let measurement_specification_sel = *unvalidated.get(6).ok_or(EPROTO)?;
+        let other_params_sel = *unvalidated.get(7).ok_or(EPROTO)?;
+
+        // Helper to read a little-endian `u32`
+        let read_le32 = |offset: usize| -> Result<u32, Error> {
+            Ok(u32::from_le_bytes(
+                unvalidated
+                    .get(offset..offset + mem::size_of::<u32>())
+                    .ok_or(EPROTO)?
+                    .try_into()
+                    .map_err(|_| EPROTO)?,
+            ))
+        };
+
+        let measurement_hash_algo = read_le32(8)?;
+        let base_asym_sel = read_le32(12)?;
+        let base_hash_sel = read_le32(16)?;
+
+        let mel_specification_sel = *unvalidated.get(31).ok_or(EPROTO)?;
+        let ext_asym_sel_count = *unvalidated.get(32).ok_or(EPROTO)?;
+        let ext_hash_sel_count = *unvalidated.get(33).ok_or(EPROTO)?;
+
+        // We currently never request extended algorithms or algorithm structures
+        if header.param1 != 0 || ext_asym_sel_count != 0 || ext_hash_sel_count != 0 {
+            dev_err!(
+                &context.dev,
+                "Responder selected unsupported extended algorithms\n"
+            );
+            return Err(EPROTO);
+        }
+
+        let mut offset = NEGOTIATE_ALGS_RSP_SZ;
+
+        let mut ext_asym = KVec::new();
+        for _ in 0..ext_asym_sel_count {
+            ext_asym.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut ext_hash = KVec::new();
+        for _ in 0..ext_hash_sel_count {
+            ext_hash.push(read_le32(offset)?, GFP_KERNEL)?;
+            offset += mem::size_of::<u32>();
+        }
+
+        let mut resp_alg_struct = KVec::new();
+        for _ in 0..header.param1 {
+            let alg_type = *unvalidated.get(offset).ok_or(EPROTO)?;
+            let alg_count = *unvalidated.get(offset + 1).ok_or(EPROTO)?;
+            let fixed_alg_count = (alg_count >> 4) as usize;
+            let ext_alg_count = (alg_count & 0xf) as usize;
+            offset += 2;
+
+            let mut alg_supported = KVec::new();
+            alg_supported.extend_from_slice(
+                unvalidated
+                    .get(offset..offset + fixed_alg_count)
+                    .ok_or(EPROTO)?,
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
+            resp_alg_struct.push(
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
+        if resp_len != offset as u16 {
+            dev_err!(&context.dev, "Incorrect response length reported\n");
+            return Err(EPROTO);
+        }
+
+        Ok(NegotiateAlgsRsp {
+            header,
+            measurement_specification_sel,
+            other_params_sel,
+            measurement_hash_algo,
+            base_asym_sel,
+            base_hash_sel,
+            mel_specification_sel,
+            ext_asym_sel_count,
+            ext_hash_sel_count,
+            ext_asym,
+            ext_hash,
+            resp_alg_struct,
+            length: offset,
+            raw_bytes: unvalidated,
+        })
+    }
+}
-- 
2.56.0

