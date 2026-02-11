Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8C3446B1
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780702; cv=none; b=PUZ0jrUW0T96VZsSycMB9CfwJWmxvOcyfvFSkoE7s0C4UrJgFxFjbybMA9So3SsCODmv6mmZSt0LkQRlNglIIZtaP2aS9afJVAnG2tyru3euS4r6XvEFGHJf0TXUaY493IqJZoRVlVZUg/ee7rDObhmYGhe6mjLK8MCzxaq/Uac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780702; c=relaxed/simple;
	bh=wwQdaFdguyOpRhGX726OhemxFT7tG742bz91Nmlzmjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7B5FBswMFQMlYlACxoMsTIlGBZ0GDi65sVkdmqe+X016Eau1MqFGs6SNjcJshLWOr64/ehpRcbGJ6jkH6svzf2AC/O/9+lDZTtXYD27F7D6A0/Rt81wLlzCpn9TMNe7QdsxE+EGhv3JAPqKrcSwJlqGD5ul+yIZEO/jj+gzrKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaGl4XBK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaGl4XBK"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso552389a12.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780700; x=1771385500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ/8xHDMdhMHTTYwlL4evaNX3TwyhC8RfbkwEhmL2HQ=;
        b=AaGl4XBKbX7Qk4WYmWHHwL4g+UxHNI1P31054D2YiaGE7t5N7LFR5QyCC+Us04U9zX
         QsT7NkO80dIuQEPN3dBNZfsymoxf6Vic1PSqJH6fQcylhqC45JXXmlMFW+FVuheupK5b
         ksZlYL3HTWPKt4FOIn7pa+BFTfCxFVvBdFRC5MyGlykmZ/e5ObpcOuXOI3TSy+aqacn9
         CCP9DxtWN1gUoHqKwKqVrr8NJIqniGzfzh6pSOabASLG6W5D90q33j8Iv/fmigp+DpL4
         7gx/AagMK4RK3M4Kvv5NFxjUrcwJIemLy1JskhOetqvqwvp5HutHJoTMILYqfjT3WObW
         WtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780700; x=1771385500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJ/8xHDMdhMHTTYwlL4evaNX3TwyhC8RfbkwEhmL2HQ=;
        b=QNik8o+mDRjGY4XYVRTmz3cDhPeYiGVMDbWwRDaoNUNX5Akc+y4P7jl2sTiWtjrwi8
         E/CNMQA81Am5Ox/njx1mNU1wSqLSIAer8WzOFDibnad6ty5TRTcJzB5/r9/kcGIOHCzw
         Sj8XqyvRlvGiGWTr53nVOoubMqoki6filYK5mck+eNTNriX9fFejpkUhbefVy6JNyj7D
         m5q00ztrcJFNuJcNYdvRsuaA2JzA9VaYr7shlh9RSrYqK1A7eAgwXLsBDa0tb+9H9JQM
         wz2R4YneQNoOojhM+d4nCiyQFkKBZHRL0QZVU6/tuYt4J5EMR/pDvsLJ4Qf5GaBl9vM3
         SFuA==
X-Forwarded-Encrypted: i=1; AJvYcCUirT7xLNyTmI0Ni104VZ+ysu8wDTDarlQpneH7yRGU/VyR9Gk0c3jf7C1mxVuMosVt8NqY4fvMOyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTQtfT7FrB8moHQN2r1tce4VE/AKYkSzUlI5i/abYDHiLqYzT
	6PU122NY/tcJ/ugVlEfKpoe2djylWlCS9NRyRg5aS7T0uqM5zkZ9DM7e
X-Gm-Gg: AZuq6aJ7qRn+3tknqr35kUu/Qqp8O6rcWXSwyHF1D+D04FUrx61BdXEceZSH8PZoGnM
	3bj5zef0ByDNMeIqSyrpRSAlKX+iEANz5I8tw1HqtoMHALaCR5erZIioW8U3NEYoqinaLeLz2+Q
	PTnvQep3j1kISqfU9qnMwWAHbTs+ztXCgLh/GLtv/zrUqEkVf6hsnf5lIDhkMoGeeZ0Ge+BLdH0
	eu77cdJANeHXgEwbzPFee4PX35z1O4srAdJp2EXEojC7T/n+3WpY/UOe2IeW6WIL5lOG+EtNAao
	/10LsXR9HkICHkswKm3HO7jzGdUQenhxXsnlHHxCchfqYu5MsgY++ucYipmuFVy7eQEaDv8aZp9
	vwxDvmmCi4HVfXU6Rcci/2djSPwcfcAfm4e4UJjP9pRGoeklx3/+lRQ31hTDKNbaZHIMoi2RBdL
	VvA8NWEdq33z7DB3PJ2T4wISYfREP19uZoEevy2RY+nUC480S115+9
X-Received: by 2002:a05:6a21:38d:b0:38e:9220:ebbe with SMTP id adf61e73a8af0-393ad01ed9emr14265861637.23.1770780700142;
        Tue, 10 Feb 2026 19:31:40 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:31:39 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v3 16/27] lib: rspdm: Support SPDM get_certificate
Date: Wed, 11 Feb 2026 13:29:23 +1000
Message-ID: <20260211032935.2705841-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

Support the GET_CERTIFICATE SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    |   2 +
 lib/rspdm/lib.rs       |  11 ++++
 lib/rspdm/state.rs     | 127 ++++++++++++++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs |  64 ++++++++++++++++++++-
 4 files changed, 200 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 4d39ca2cb584..eaf2132da290 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -174,6 +174,8 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 
 pub(crate) const SPDM_GET_DIGESTS: u8 = 0x81;
 
+pub(crate) const SPDM_GET_CERTIFICATE: u8 = 0x82;
+
 #[cfg(CONFIG_CRYPTO_RSA)]
 pub(crate) const SPDM_ASYM_RSA: u32 =
     SPDM_ASYM_RSASSA_2048 | SPDM_ASYM_RSASSA_3072 | SPDM_ASYM_RSASSA_4096;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index a7af86d1dc0b..b065b3f70356 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -125,6 +125,17 @@
         return e.to_errno() as c_int;
     }
 
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
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 2606b825c494..1e5656144611 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -26,8 +26,9 @@
     SPDM_REQ, SPDM_RSP_MIN_CAPS, SPDM_SLOTS, SPDM_VER_10, SPDM_VER_11, SPDM_VER_12,
 };
 use crate::validator::{
-    GetCapabilitiesReq, GetCapabilitiesRsp, GetDigestsReq, GetDigestsRsp, GetVersionReq,
-    GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg, SpdmErrorRsp, SpdmHeader,
+    GetCapabilitiesReq, GetCapabilitiesRsp, GetCertificateReq, GetCertificateRsp, GetDigestsReq,
+    GetDigestsRsp, GetVersionReq, GetVersionRsp, NegotiateAlgsReq, NegotiateAlgsRsp, RegAlg,
+    SpdmErrorRsp, SpdmHeader,
 };
 
 /// The current SPDM session state for a device. Based on the
@@ -107,6 +108,14 @@ pub struct SpdmState {
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
 }
 
+#[repr(C, packed)]
+pub(crate) struct SpdmCertChain {
+    length: u16,
+    _reserved: [u8; 2],
+    root_hash: bindings::__IncompleteArrayField<u8>,
+    certificates: bindings::__IncompleteArrayField<u8>,
+}
+
 impl SpdmState {
     pub(crate) fn new(
         dev: *mut bindings::device,
@@ -620,4 +629,118 @@ pub(crate) fn get_digests(&mut self) -> Result<(), Error> {
 
         Ok(())
     }
+
+    fn get_cert_exchange(
+        &mut self,
+        request_buf: &mut [u8],
+        response_vec: &mut KVec<u8>,
+        rsp_sz: usize,
+    ) -> Result<&mut GetCertificateRsp, Error> {
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let response_buf = unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), rsp_sz) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        if rc < (core::mem::size_of::<GetCertificateReq>() as i32) {
+            pr_err!("Truncated certificate response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut GetCertificateRsp = Untrusted::new_mut(response_vec).validate_mut()?;
+
+        if rc
+            < (core::mem::size_of::<GetCertificateRsp>() + response.portion_length as usize) as i32
+        {
+            pr_err!("Truncated certificate response\n");
+            to_result(-(bindings::EIO as i32))?;
+        }
+
+        Ok(response)
+    }
+
+    pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
+        let mut request = GetCertificateReq::default();
+        request.version = self.version;
+        request.param1 = slot;
+
+        let req_sz = core::mem::size_of::<GetCertificateReq>();
+        let rsp_sz = ((core::mem::size_of::<GetCertificateRsp>() + 0xffff) as u32)
+            .min(self.transport_sz) as usize;
+
+        request.offset = 0;
+        request.length = (rsp_sz - core::mem::size_of::<GetCertificateRsp>()).to_le() as u16;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(rsp_sz, GFP_KERNEL)?;
+
+        let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
+
+        let total_cert_len =
+            ((response.portion_length + response.remainder_length) & 0xFFFF) as usize;
+
+        let mut certs_buf: KVec<u8> = KVec::new();
+
+        certs_buf.extend_from_slice(
+            &response_vec[8..(8 + response.portion_length as usize)],
+            GFP_KERNEL,
+        )?;
+
+        let mut offset: usize = response.portion_length as usize;
+        let mut remainder_length = response.remainder_length as usize;
+
+        while remainder_length > 0 {
+            request.offset = offset.to_le() as u16;
+            request.length = (remainder_length
+                .min(rsp_sz - core::mem::size_of::<GetCertificateRsp>()))
+            .to_le() as u16;
+
+            let request_buf =
+                unsafe { from_raw_parts_mut(&mut request as *mut _ as *mut u8, req_sz) };
+
+            let response = self.get_cert_exchange(request_buf, &mut response_vec, rsp_sz)?;
+
+            if response.portion_length == 0
+                || (response.param1 & 0xF) != slot
+                || offset as u16 + response.portion_length + response.remainder_length
+                    != total_cert_len as u16
+            {
+                pr_err!("Malformed certificate response\n");
+                to_result(-(bindings::EPROTO as i32))?;
+            }
+
+            certs_buf.extend_from_slice(
+                &response_vec[8..(8 + response.portion_length as usize)],
+                GFP_KERNEL,
+            )?;
+            offset += response.portion_length as usize;
+            remainder_length = response.remainder_length as usize;
+        }
+
+        let header_length = core::mem::size_of::<SpdmCertChain>() + self.hash_len;
+
+        let ptr = certs_buf.as_mut_ptr();
+        // SAFETY: `SpdmCertChain` is repr(C) and packed, so we can convert it from a slice
+        let ptr = ptr.cast::<SpdmCertChain>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let certs: &mut SpdmCertChain = unsafe { &mut *ptr };
+
+        if total_cert_len < header_length
+            || total_cert_len != usize::from_le(certs.length as usize)
+            || total_cert_len != certs_buf.len()
+        {
+            pr_err!("Malformed certificate chain in slot {slot}\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        self.certs[slot as usize].clear();
+        self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_KERNEL)?;
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 2150a23997db..a8bc3378676f 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -17,8 +17,9 @@
 };
 
 use crate::consts::{
-    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_DIGESTS, SPDM_GET_VERSION,
-    SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS, SPDM_REQ_CAPS,
+    SPDM_ASYM_ALGOS, SPDM_CTEXPONENT, SPDM_GET_CAPABILITIES, SPDM_GET_CERTIFICATE,
+    SPDM_GET_DIGESTS, SPDM_GET_VERSION, SPDM_HASH_ALGOS, SPDM_MEAS_SPEC_DMTF, SPDM_NEGOTIATE_ALGS,
+    SPDM_REQ_CAPS,
 };
 
 #[repr(C, packed)]
@@ -364,3 +365,62 @@ fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err>
         Ok(rsp)
     }
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) offset: u16,
+    pub(crate) length: u16,
+}
+
+impl Default for GetCertificateReq {
+    fn default() -> Self {
+        GetCertificateReq {
+            version: 0,
+            code: SPDM_GET_CERTIFICATE,
+            param1: 0,
+            param2: 0,
+            offset: 0,
+            length: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetCertificateRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+
+    pub(crate) portion_length: u16,
+    pub(crate) remainder_length: u16,
+
+    pub(crate) cert_chain: __IncompleteArrayField<u8>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetCertificateRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetCertificateRsp>() {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetCertificateRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCertificateRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetCertificateRsp = unsafe { &mut *ptr };
+
+        rsp.portion_length = rsp.portion_length.to_le();
+        rsp.remainder_length = rsp.remainder_length.to_le();
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

