Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078880;
	b=wX0mUpYap4Uz5Uvi2jRB9raSZUzJKTB56oVFGDLW2GjTeGuQQHq/Eclvd20c8lpsiuHs
	 LzIJmAhhiM1X6BxTI53qk99m4dmqcH0HtkoxSO13lBdxnh3SX3m2VngQnpSBFvwkVrrMg
	 okYFfmGVpVUxpJlze3CwCQSBFqu2k1G1kzgsEXcyswHeZ3aoqsoCMucV4J3wgT4XHQarr
	 3cRumliDetQ74nfVObJFqRhvbfI4/jfj79oM85NsER8drz8HDbSNwJL954BDPhKieyl1q
	 zWFfPCN3xQ0F+p0FAJkbNHfcUw6HeVNAX2ojMQqvNXdaup2fa8bmca/pO+GPiCTJtkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wj8UfhZHsROY/X5TVyb93mx6L1+TkOSqzPURXO4/Kp8=;
	b=rD3YKYeLMaQSaKFnwfOSByzzSTZRR2OUwNyv1MxwkTGWNNPYGURUTJXnYgjUjih41SOZ
	 oDfzYkuTMnT0G+ecIvS+/CcnXK3QiIXX5Z1m5iKPvxaRRDVANxyUmj68dlJhS6kTDobSw
	 7nhSvulwdccAasU3OUR0+nSXfOYaN+mNfmFf0Wg5E7YHZAfiJcu/gjHSQx+azPeYW0RNo
	 ts/hfOFNgzjv9mO+N1DaOVCJiZf7LawU9fKObGFgDsnsdx1MucqnTbVKCDIMk0+2jg87i
	 4xjKf4RXQo9oly0LGGVGP9ygCnThBccwhXrmA9ZsJkToxNdfUsKngkAvZjrZVrBcOmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fljQQyCT;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8EB606A333
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 05:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E8EB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fljQQyCT
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so23861045ad.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 22:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793078879; x=1793683679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wj8UfhZHsROY/X5TVyb93mx6L1+TkOSqzPURXO4/Kp8=;
        b=fljQQyCTzgm2bs0bNzGGaNSaFFDUI7KELM4Q95BKObG1Iq7GnY+H1DYM1yr/xbRDGl
         +hSWkICLl+AkSwzwSsxqFQIVrUglPNw76NFBUxK4Q73fCUjDAnbaZF3yfav1FDaVjibB
         bpwVtElQwy+Jk7gp1kmdaWHHalMrsoN6gsEOuK9zKC15cjVswj7UFHebS5bLZcZIWyBn
         MIAgX81SEUTpKsaETCAz3itD7LD/V0V8hqnbo3OkZpMqiPAdebfbTo9DOUlZXHpfMHdW
         uAmULvfcOMJaC+HNk7O3qwx9RIV48WgS21aCWc+TKmuf8CoL12AFcgkEeXyFphLmpax7
         a98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078879; x=1793683679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wj8UfhZHsROY/X5TVyb93mx6L1+TkOSqzPURXO4/Kp8=;
        b=A57PijKB4oQqQSKqBwvdmgJ+ns+jER6uHZsOIZpiraIOsEqvgsWYNyor5TFAwGtv1l
         29NVLF7SRHQsIrX6vMs95qpEAO24tvddHnrh5pylpyDkj1nW+Zv7ngdsdap9LqXQpryh
         A9r32HExW1sjrHh3n/VB8Rg2K159Q8KKirBsuPhsx/neVYAvUbskmnsQIbjkzYxAC7/j
         92Pdr4CvgypE1GUvwYCGlqi1MBKt72tIR9Uju1MLlani4EDWgNq/fZ9DJcEX8X0F9mVL
         Sqyxj6cdPLWt55ZUxIXBGnpWj44KvflMni6Luw4H3099NODHRPcGFfQ1Je7+id/xpeHv
         DwZg==
X-Forwarded-Encrypted: i=1; AKwUvBwJnCoB6RtBHfzb7so1vDEiNb0CK/ig7OMiTVbVsHPMbFGYocI0GhHChBykgbF6zsRVKoB0US7WEqo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIlWoCjTXoWuBgoexmlcdsbx40h5eDuB8P5iAjdxlQYteVWlWb
	2zIdCqpPMufUgTIdQWs+vt8klu87sOttnXb2uyOVrzUVYPCqtpb2+S1Z
X-Gm-Gg: AYBFou1Phqs/t/OmH8fss4Sdn81elpl5VCc1HyExmibU9lQByr/U3eApw+6HxhdQqfb
	jPYWpVQEHEvX+/5wiM3TXUfEWuybobHx6VOAf5nQlt/swFZT+rTDsSUoF3s0Nw1pGDrFJgo4g2l
	weBSZRYolRd3jArTOoIQCrEsyfWyB6r2IYPtqQJDiCSuCG1GP9nUFd1D+/qR4NJPjLOU89VJhp2
	fBkFmIclXx4IMqLgpHNjD1YBMLIrdAafZnO9nL4s3MCyifD/0l+SbzC3QPYdEH0X24wRtaryg1e
	6F4Wmt2HFK9PUpRtnurlAHj2v4TGgKJ6JLa76HC/atpnBbwvLgoscGjabHOfUxDHrW9MpO6Xk0S
	QLq0kvwV0PupKfw8ac0eS/v0Ps0HRLvEPnvmLXqky5WZ27vhPdCA8qOU392OY8ErRO/Tcq6hFtL
	ySw5lDlySFHcQUS78ZFRO8KlgR6a46DCYS3PBHAlrioMvxpHFSzSMSqK5hqMapHkQMxoAqhm/9f
	FFf88C0skRG81XLXbsKQV9w5E0LxpEyPqz+vH/RPH3JnJI4NNUrrW/B5rA+5oDnjVhcXS86ow==
X-Received: by 2002:a17:903:3c67:b0:2e8:591a:fa36 with SMTP id d9443c01a7336-2ea9c8820e6mr67609885ad.72.1793078878566;
        Mon, 26 Oct 2026 22:27:58 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9757bsm3307715ad.58.2026.10.26.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:27:57 -0700 (PDT)
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
Subject: [PATCH v5 17/23] lib: rspdm: Support SPDM negotiate_algorithms
Date: Tue, 27 Oct 2026 15:25:30 +1000
Message-ID: <20261027052536.1722081-18-alistair.francis@wdc.com>
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

Support the NEGOTIATE_ALGORITHMS SPDM command.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/consts.rs    |  52 ++++++++++
 lib/rspdm/lib.rs       |   4 +
 lib/rspdm/state.rs     | 157 +++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 226 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 438 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index fe5c79e0dd911..7a75bd1e4649c 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -45,6 +45,58 @@
 
 pub(crate) const SPDM_CERT_CAP: u32 = bit_u32(1);
 pub(crate) const SPDM_CHAL_CAP: u32 = bit_u32(2);
+pub(crate) const SPDM_KEY_EX_CAP: u32 = bit_u32(9);
+pub(crate) const SPDM_MEAS_RESP_CAP: u32 = bit_u32(3) | bit_u32(4);
 
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
+pub(crate) const SPDM_OPAQUE_DATA_FMT_GENERAL: u8 = bit_u8(1);
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 728910273a2ce..4c219b32098ab 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -266,6 +266,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.negotiate_algs() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 815f332fabad8..79819c492b07b 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -15,14 +15,30 @@
         Device, //
     },
     error::Error,
+    hash::Shash,
+    str::CStr,
     validate::Untrusted,
 };
 
 use crate::consts::{
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
+    SPDM_MEAS_RESP_CAP,
     SPDM_MIN_VER,
+    SPDM_OPAQUE_DATA_FMT_GENERAL,
     SPDM_REQ,
     SPDM_RSP_MIN_CAPS,
     SPDM_VER_10,
@@ -34,9 +50,12 @@
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
@@ -89,6 +108,27 @@ pub(crate) struct SpdmState<'a, T: Transport> {
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
 
 impl<'a, T: Transport> SpdmState<'a, T> {
@@ -105,6 +145,12 @@ pub(crate) fn new(
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
 
@@ -239,4 +285,113 @@ pub(crate) fn get_capabilities(&mut self) -> Result<(), Error> {
 
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
+                pr_err!("Unknown asym algorithm\n");
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
+                pr_err!("Unknown hash algorithm\n");
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
+        let rsp_sz =
+            (NEGOTIATE_ALGS_RSP_SZ as u32 + u32::from(u16::MAX)).min(self.transport_sz) as usize;
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
+            pr_err!("No common supported algorithms\n");
+            return Err(EPROTO);
+        }
+
+        let meas_hash_valid = if self.rsp_caps & SPDM_MEAS_RESP_CAP != 0
+            && response.measurement_specification_sel != 0
+        {
+            self.meas_hash_alg.count_ones() == 1
+        } else {
+            self.meas_hash_alg == 0
+        };
+
+        // /* Responder shall select exactly 1 alg (SPDM 1.0.0 table 14) */
+        if self.base_asym_alg.count_ones() != 1
+            || self.base_hash_alg.count_ones() != 1
+            || !meas_hash_valid
+            || response.other_params_sel != request.other_params_support
+        {
+            pr_err!("Malformed algorithms response\n");
+            return Err(EPROTO);
+        }
+
+        self.update_response_algs()?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 080c2f2c49376..9afcb3f8bcb6c 100644
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
@@ -493,3 +497,225 @@ fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self
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
+impl<'c, T: Transport> Validate<'c, Untrusted<KVec<u8>>, &'c SpdmState<'c, T>>
+    for NegotiateAlgsRsp
+{
+    type Err = Error;
+
+    fn validate(unvalidated: KVec<u8>, context: &'c SpdmState<'c, T>) -> Result<Self, Self::Err> {
+        let header: SpdmHeader =
+            Untrusted::new(unvalidated.get(0..4).ok_or(EPROTO)?).validate(context)?;
+
+        if header.code != SPDM_NEGOTIATE_ALGS - 0x80 {
+            return Err(EPROTO);
+        }
+
+        if header.version != context.version {
+            pr_err!("Invalid version response\n");
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
+            pr_err!("Responder selected unsupported extended algorithms\n");
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
+            let fixed_alg_count = (alg_count & 0xf) as usize;
+            let ext_alg_count = (alg_count >> 4) as usize;
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
+            pr_err!("Incorrect response length reported\n");
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

