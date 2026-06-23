Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB537267B
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190599; cv=none; b=FG0VMYqq0oH5/KqYnlpbXtOWM8t9oxhZHI8cxzWPcbHRQUaSppHN7Q43bsYUtelf6AQtHnvAOpUEwxvYso7x+dFQm4Yn2WKGxdT7ISB7tdwVKaRVznQZUTHwJWwQypge+WyD4k6Y2U4TOvIwVITdWXSYO+JKaBx5zhSF2D2fAmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190599; c=relaxed/simple;
	bh=Ry1zThOe11RTnuyy6dW3/cZLQmpBjOrI7wBt2Cq8giM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQcSoDDsUyYWS7m3YaLGFdyNgJd6V8E6VXZidnf/AMw1DRrbUiKA/SRyMMlBwLrQFe455tw5Sokkeq3T8CFA7i63VZfl3LRxU3NaKNey3Qby86/EFpBNBcPlv67RIipgCESko4JkDm3SII+GjPIe6zF+JDFE7jkthzabd4SceD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwJrkErr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwJrkErr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6d31bfc70so32877395ad.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190598; x=1782795398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc0PaRTDGCtg5oibAtHAtpTZVaLH0gZMUuZdNA2Oll4=;
        b=PwJrkErrUAS9OEUosVzDFBLjyIIS+9d6Bw3nLSHdWQ6vJjAg4k0b1283APWTI4drCV
         LbF3GzddU7wQSdz8+j9muoMunT6f5gciFKQXj6BXKCFjrgEyxvQ7B9LfWGfst0lBT9ro
         /T44Wvce+mGsu7IcNA3Oh0DaRbvOqP8xSBAQZm50XoBY92RU16hPeBBXOM7RjHhSF9HY
         +zKPgCGWVUg+c7n5S5S0V1w8k8nb8BRalJkJ4zetExUz3Z44Bat9K94Z2YyVV8jpssaE
         2zZ7cbAWRhHiX6V9G7ng+j0+ugCr8AKFtAx2titLky78pQrtyaTWc11OgqdDPBJOZct8
         k1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190598; x=1782795398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nc0PaRTDGCtg5oibAtHAtpTZVaLH0gZMUuZdNA2Oll4=;
        b=i3PMQj11LhHyxDm8uLJV9PznZvGTA73dabi0j3pYpA2tBz5T5hlPeld7SDJqyUFsgS
         i66hiZ7NN0vkAjKTTAFuJbK0es0XqLKjpzJ+F+PXi4phqt8eDvOlZ4L5js2umBn5dI6S
         LZx2slXTB8geYPEec4hQoMmdrzJojYVX4EAHM2lVyXMOcxDJub72b9F/zpWvdUc9b6Kb
         qG4qxJPpVgmSnDWO5KupFpi2Sn8eC6BbamVsPIfumXri1IzCJnBoBt2Q7JUmg41DjhRi
         v592Uo9ENL7l19LAl+ShzyGNno+W3bBQfWJkcTkMwuOhKWZJL33U307GdgFw04GX3Hm2
         kxUw==
X-Forwarded-Encrypted: i=1; AHgh+RqQ9+w7Shpe/HUtS+9r1MXb9K79zhkNVtEPN4CatUzBmELEPRYn33Zpokt0px2HSguIYw1Vhdljt6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VNV5ra6ewyFsPr0TmnGOFFhl8PqYR/O+aPQn/7xxMXDDYWGp
	LSZP2oaFWavk246sHUxxpwKhdj2sXB/CppChKELO18lHgmZ+Yo8scp7V
X-Gm-Gg: AfdE7ckCyGRS6STCl05+zYNrRVJicDwP0txg0wkHPghmFjT6WBryuClW4f3Jx9AQE3m
	S1ONZoEmHwxQCyZNALKodJSRk5hXkD5tCdMa4qgrJRlurEt1Fy/3hiiaygFV7j6cCFGDaGTRpC1
	7LU3/uX5agoUbgTZhJpmhQsokjUHzZa3n//m3lL1T3N4RGxBpSno23az143szF2+hYhTKho9N/Q
	I8Lz0bpQSJTUVHKfkM4A2Ho+aIiXpkanQdtMZWQzTKlDflFBb7nF9Euv4TEj2vmLrKBIgGk+hOA
	ZXGMDQs3enz4bpn7uucHLpoqIvcXXZrPqQkAKgFlXocNH26ApidSIfk+wzXnBY57Mk2uAOt1+pv
	CFmktkqj6EYwAU/zztcGuw4yXjOUTAqh/9HNBFUSaDl2LSQH60uqPfzpNXVtv+AGI60fXDRIgvV
	Dzt1nWp+oXGdU2raiExZJpTfMvBnnGKA==
X-Received: by 2002:a17:902:f68b:b0:2c6:d5da:838d with SMTP id d9443c01a7336-2c7c76fa522mr14944465ad.33.1782190597650;
        Mon, 22 Jun 2026 21:56:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:56:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu
Subject: [PATCH v2 15/21] lib: rspdm: Support SPDM get_capabilities
Date: Tue, 23 Jun 2026 14:54:00 +1000
Message-ID: <20260623045406.2589547-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
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
 lib/rspdm/consts.rs    |  19 +++++++-
 lib/rspdm/lib.rs       |   4 ++
 lib/rspdm/state.rs     |  78 ++++++++++++++++++++++++++++-
 lib/rspdm/validator.rs | 108 ++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/error.rs   |   1 +
 5 files changed, 206 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 055671d43abd..15d69631ed8c 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -9,13 +9,12 @@
 
 use crate::validator::GetVersionRsp;
 use core::mem;
+use kernel::bits::bit_u32;
 use kernel::error::{code::EINVAL, Error};
 
 // SPDM versions supported by this implementation
 pub(crate) const SPDM_VER_10: u8 = 0x10;
-#[allow(dead_code)]
 pub(crate) const SPDM_VER_11: u8 = 0x11;
-#[allow(dead_code)]
 pub(crate) const SPDM_VER_12: u8 = 0x12;
 #[allow(dead_code)]
 pub(crate) const SPDM_VER_13: u8 = 0x13;
@@ -102,3 +101,19 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
 pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
 pub(crate) const SPDM_GET_VERSION_LEN: usize =
     mem::size_of::<GetVersionRsp>() + (u8::MAX as usize) * mem::size_of::<u16>();
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
index 58d86ea06fd9..76325babdff2 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -102,6 +102,10 @@ pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
         return e.to_errno() as c_int;
     }
 
+    if let Err(e) = state.get_capabilities() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 9e8c65a12199..5ef14c8ed237 100644
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
@@ -52,6 +59,8 @@
 ///
 /// `version`: Maximum common supported version of requester and responder.
 ///  Negotiated during GET_VERSION exchange.
+/// `rsp_caps`: Cached capabilities of responder.
+///  Received during GET_CAPABILITIES exchange.
 #[expect(dead_code)]
 pub(crate) struct SpdmState {
     pub(crate) dev: *mut bindings::device,
@@ -62,6 +71,7 @@ pub(crate) struct SpdmState {
 
     // Negotiated state
     pub(crate) version: u8,
+    pub(crate) rsp_caps: u32,
 }
 
 impl SpdmState {
@@ -79,6 +89,7 @@ pub(crate) fn new(
             transport_sz,
             validate,
             version: SPDM_MIN_VER,
+            rsp_caps: 0,
         }
     }
 
@@ -297,4 +308,69 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
 
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
+            SPDM_VER_10 => (
+                core::mem::size_of::<SpdmHeader>(),
+                core::mem::size_of::<SpdmHeader>() + 4 + core::mem::size_of::<u32>(),
+            ),
+            SPDM_VER_11 => {
+                let len = core::mem::size_of::<SpdmHeader>() + 4 + core::mem::size_of::<u32>();
+                (len, len)
+            }
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
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, rsp_sz, GFP_KERNEL)?;
+
+        let rc = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if rc > response_vec.len() {
+            pr_err!("Overflowed capabilities response\n");
+            return Err(EIO);
+        }
+        response_vec.truncate(rc);
+
+        let response: &mut GetCapabilitiesRsp = Untrusted::new(&mut response_vec).validate()?;
+
+        self.rsp_caps = u32::from_le(response.flags);
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
+            let data_transfer_size = u32::from_le(response.data_transfer_size);
+            if data_transfer_size < SPDM_MIN_DATA_TRANSFER_SIZE {
+                pr_err!("Malformed capabilities response\n");
+                return Err(EPROTO);
+            }
+            self.transport_sz = self.transport_sz.min(data_transfer_size);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 4570b5f41f8c..7b5aca5d50f8 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -26,8 +26,13 @@
 };
 
 use crate::consts::{
+    SPDM_CTEXPONENT,
+    SPDM_GET_CAPABILITIES,
     SPDM_GET_VERSION,
-    SPDM_MIN_VER, //
+    SPDM_MIN_VER,
+    SPDM_REQ_CAPS,
+    SPDM_VER_10,
+    SPDM_VER_11, //
 };
 
 #[repr(C, packed)]
@@ -159,3 +164,104 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
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
+            flags: SPDM_REQ_CAPS.to_le(),
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
+impl Validate<Untrusted<&mut KVec<u8>>> for &mut GetCapabilitiesRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut KVec<u8>) -> Result<Self, Self::Err> {
+        let version = *(unvalidated.get(0).ok_or(EINVAL))?;
+
+        let expected_length = match version {
+            SPDM_VER_10 | SPDM_VER_11 => {
+                core::mem::size_of::<SpdmHeader>() + 4 + core::mem::size_of::<u32>()
+            }
+            _ => {
+                // Check to see if param1 is set
+                if *(unvalidated.get(2).ok_or(EINVAL))? == 0 {
+                    mem::size_of::<GetCapabilitiesRsp>()
+                        - mem::size_of::<__IncompleteArrayField<__le16>>()
+                } else {
+                    // Not currently supported by Linux, we don't set the bit
+                    // so the responder shouldn't either.
+                    return Err(EINVAL);
+                }
+            }
+        };
+
+        // Make sure the response meets the SPDM spec version requirements
+        if unvalidated.len() < expected_length {
+            return Err(EINVAL);
+        }
+
+        // If the response is shorter than GetCapabilitiesRsp
+        // (which is valid for older spec versions and when param1 is
+        // set to 0) then we need to pad the vector to ensure
+        // GetCapabilitiesRsp will be initialised.
+        while unvalidated.len() < mem::size_of::<GetCapabilitiesRsp>() {
+            unvalidated.push(0, GFP_KERNEL)?;
+        }
+
+        let ptr = unvalidated.as_mut_ptr();
+        // CAST: `GetCapabilitiesRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetCapabilitiesRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetCapabilitiesRsp = unsafe { &mut *ptr };
+
+        Ok(rsp)
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e71f65eb1d40..6413de18df80 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -94,6 +94,7 @@ macro_rules! declare_err {
     declare_err!(ECONNRESET, "Connection reset by peer.");
     declare_err!(EINPROGRESS, "Operation now in progress.");
     declare_err!(EPROTO, "Protocol error");
+    declare_err!(EPROTONOSUPPORT, "Protocol not supported");
 }
 
 /// Generic integer kernel error.
-- 
2.54.0

