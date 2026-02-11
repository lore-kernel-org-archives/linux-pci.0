Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE7344D81
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780673; cv=none; b=ISlV8fQ7RG+pbOPIVHn6bpJUqRzyLdV2BDBSp2FTGkNT2LuCuRJolXGaZ6NW9CYRHdZZhRWNO/DFkDliLB92PGyQPMRyBRrqx7drhZ/0o7EcX/+2XtScCNpV6lXxb1moRZYze/BPWUf7g7AMYB+lAK6P3Bt+eC8Lcfjp0Z05lAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780673; c=relaxed/simple;
	bh=ggZ0casIP8pm1D8jNoCOP6ICbzQ2CQUo7npwmTUPjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWSpUFWnPZS+YiqPzexxCmTJtoCRhlCefRGfyz8lbJ7R7m8BMvU2H1bbbw8nyJ48omLghQ3Ys9tA0uI/mlC/HM2qTRZKlqjiiY3p4YlDdDHSb5LX4BDO9IsoBF/o6IdtgIzf4fILmxMtCX7W+acGWq0b2LuiQAzV08UJhKv+iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lun180/L; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lun180/L"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c633984fbeeso183969a12.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780672; x=1771385472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd79arduRCDAlNKbcxg57zbXwsYD/G+5bc7S2bWrry0=;
        b=lun180/LZBG+3fBHdkLXtA5NoQ+zx/YEXDY5uu4QqgO9FXm9EY7TLORS76aLtNALIn
         F3fJG9WmBliLBy5Oo7jMyCZK5knu2RT0wTi77PQZpR4dKb8Gi8gqWKKOrN9+7TlxQQHq
         tUhjZPz/vSph5gxwkgCUyp+G0fvYrKSAcmKm8t8IeBWHVs1aAKDzywVjyS3n4aCbj5fj
         3hUtI0zLAdKVS7YPC/uni85TCHhJRMdYLnDVGgdTb6QUcevaNSnVTopUximr4xq7uSJp
         iaeNRCFZ12hqIopzkkdAJCw2jnK5Nr7dGrvWdwsDq6akbBpXLwVnG9E+T6JfCCbKAEw7
         IH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780672; x=1771385472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nd79arduRCDAlNKbcxg57zbXwsYD/G+5bc7S2bWrry0=;
        b=UoROtk1oIvmPIOMpHFOA6RmundvtWn3pSp+wUQMrVf7Dt4vDuoov0hAq5N9rzpPvhf
         mhZAlvbw0n06NUqKSPuoJ1g8ch+AUi8xucleXUciEyVlRy0K1Wm2MbKiBsiY7J+wtJPV
         zjIj3Es4tQ5uFGTEo2NuCHbjzfIvL8usnJ6SV1hica07JS64QZb6sKCDX2VnsrKmopf3
         +eGJysAmpVcDOiYN4mv5dwAfWf354ozx1/2koIYsK0/cDO5FJQRbt3sp6e+I8Q9FFF0V
         yMxokmy1o1Loj7Gza1IPJz+qznKfULqj4t/LIORpi4khdM3S7MORlrQ9Kfl/cF+txAS8
         FciQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDc0hIC93dFwyMRYmtHR4NCNRxyBXyzrf/LndB4hp/x/rR8LBnPUx4DsrnWjmOSkqBc92GCfKvkmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpliVk/xUI0ojPQtjilGtpVnDRoxQyJBg0dkd9zTUS0eZ2o6R
	T302Aw4KfMQicYpCGa4ZOTkowSEefLHI5+oATgcixHz4pzO2YkHnsWeI
X-Gm-Gg: AZuq6aJM5sNvsjicjXA+kGSBLu4TQ8at014Z/5++p03izMT11pLvyFq1M8y1L+Arfj1
	HXiMoxLT/HxmmbXa5ptD1lU4RO+WpWyDs5pnh92QZs9UoEnWKA0VYZ50ADiRPkEXOEMPta65KG3
	ZUc7jYPmQvUB1O0MJDQIz8l36NMjx3hyT6fR2GHS5oROUhc8iTXI1g143D7r2rK2N9GgR6MPEKT
	ylBODCROvVPVUlejBhl5cWRweNfrJ9LdqzBjcMXUjHD+jv40G5GgbDniT+DbxkF2wMRE+QdMEnV
	g8vAhlup+vNUjXtKzgxiPdHsOFXkeycgj33/imDHtOnnpiEio4i4os0RyKaKK7PsXLL/HJyJ5CI
	6AEBLI5wE6kmVMPqzM/gc9uTATRsjzFYjcKqJDm1GEqd+58qIrTn9dzb+O4M42S5CQxnoaQV9qP
	bjlw7wiokQUF8/8TzowxhJSN6/rK03mXKhTfrpjNU+og==
X-Received: by 2002:a05:6a20:2585:b0:38e:95f9:8cc1 with SMTP id adf61e73a8af0-39415bdbdbdmr4618591637.12.1770780671775;
        Tue, 10 Feb 2026 19:31:11 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:31:11 -0800 (PST)
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
Subject: [RFC v3 12/27] lib: rspdm: Support SPDM get_version
Date: Wed, 11 Feb 2026 13:29:19 +1000
Message-ID: <20260211032935.2705841-13-alistair.francis@wdc.com>
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

Support the GET_VERSION SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    | 17 +++++++++++
 lib/rspdm/lib.rs       |  6 +++-
 lib/rspdm/state.rs     | 58 ++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 67 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 40ce60eba2f3..38f48f0863e2 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,6 +7,20 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::SpdmHeader;
+use core::mem;
+
+/* SPDM versions supported by this implementation */
+pub(crate) const SPDM_VER_10: u8 = 0x10;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_11: u8 = 0x11;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_12: u8 = 0x12;
+pub(crate) const SPDM_VER_13: u8 = 0x13;
+
+pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
+pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_13;
+
 pub(crate) const SPDM_REQ: u8 = 0x80;
 pub(crate) const SPDM_ERROR: u8 = 0x7f;
 
@@ -115,3 +129,6 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
         Ok(())
     }
 }
+
+pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
+pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + 255;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 2bb716140e0a..08abcbb21247 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -108,7 +108,11 @@
 /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
 /// indicates authentication is not supported by the device.
 #[no_mangle]
-pub unsafe extern "C" fn spdm_authenticate(_state: &'static mut SpdmState) -> c_int {
+pub unsafe extern "C" fn spdm_authenticate(state: &'static mut SpdmState) -> c_int {
+    if let Err(e) = state.get_version() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 68861f30e3fa..3ad53ec05044 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -8,6 +8,7 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
 use core::ffi::c_void;
+use core::slice::from_raw_parts_mut;
 use kernel::prelude::*;
 use kernel::{
     bindings,
@@ -15,8 +16,10 @@
     validate::Untrusted,
 };
 
-use crate::consts::{SpdmErrorCode, SPDM_ERROR, SPDM_REQ};
-use crate::validator::{SpdmErrorRsp, SpdmHeader};
+use crate::consts::{
+    SpdmErrorCode, SPDM_ERROR, SPDM_GET_VERSION_LEN, SPDM_MAX_VER, SPDM_MIN_VER, SPDM_REQ,
+};
+use crate::validator::{GetVersionReq, GetVersionRsp, SpdmErrorRsp, SpdmHeader};
 
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
@@ -61,7 +64,7 @@ pub(crate) fn new(
             transport_sz,
             keyring,
             validate,
-            version: 0x10,
+            version: SPDM_MIN_VER,
         }
     }
 
@@ -217,4 +220,53 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
     }
+
+    /// Negoiate a supported SPDM version and store the information
+    /// in the `SpdmState`.
+    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
+        let mut request = GetVersionReq::default();
+        request.version = self.version;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe {
+            from_raw_parts_mut(
+                &mut request as *mut _ as *mut u8,
+                core::mem::size_of::<GetVersionReq>(),
+            )
+        };
+
+        let mut response_vec: KVec<u8> = KVec::with_capacity(SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let response_buf =
+            unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), SPDM_GET_VERSION_LEN) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // then the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        let mut foundver = false;
+        for i in 0..response.version_number_entry_count {
+            // Creating a reference on a packed struct will result in
+            // undefined behaviour, so we operate on the raw data directly
+            let unaligned = core::ptr::addr_of_mut!(response.version_number_entries) as *mut u16;
+            let addr = unaligned.wrapping_add(i as usize);
+            let version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } >> 8) as u8;
+
+            if version >= self.version && version <= SPDM_MAX_VER {
+                self.version = version;
+                foundver = true;
+            }
+        }
+
+        if !foundver {
+            pr_err!("No common supported version\n");
+            to_result(-(bindings::EPROTO as i32))?;
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index a0a3a2f46952..f69be6aa6280 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -7,6 +7,7 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::bindings::{__IncompleteArrayField, __le16};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -15,6 +16,8 @@
     validate::{Unvalidated, Validate},
 };
 
+use crate::consts::SPDM_GET_VERSION;
+
 #[repr(C, packed)]
 pub(crate) struct SpdmHeader {
     pub(crate) version: u8,
@@ -64,3 +67,67 @@ pub(crate) struct SpdmErrorRsp {
     pub(crate) error_code: SpdmErrorCode,
     pub(crate) error_data: u8,
 }
+
+#[repr(C, packed)]
+pub(crate) struct GetVersionReq {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    pub(crate) param1: u8,
+    pub(crate) param2: u8,
+}
+
+impl Default for GetVersionReq {
+    fn default() -> Self {
+        GetVersionReq {
+            version: 0,
+            code: SPDM_GET_VERSION,
+            param1: 0,
+            param2: 0,
+        }
+    }
+}
+
+#[repr(C, packed)]
+pub(crate) struct GetVersionRsp {
+    pub(crate) version: u8,
+    pub(crate) code: u8,
+    param1: u8,
+    param2: u8,
+    reserved: u8,
+    pub(crate) version_number_entry_count: u8,
+    pub(crate) version_number_entries: __IncompleteArrayField<__le16>,
+}
+
+impl Validate<&mut Unvalidated<KVec<u8>>> for &mut GetVersionRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &mut Unvalidated<KVec<u8>>) -> Result<Self, Self::Err> {
+        let raw = unvalidated.raw_mut();
+        if raw.len() < mem::size_of::<GetVersionRsp>() {
+            return Err(EINVAL);
+        }
+
+        let version_number_entries = *(raw.get(5).ok_or(ENOMEM))? as usize;
+        let total_expected_size = version_number_entries * 2 + 6;
+        if raw.len() < total_expected_size {
+            return Err(EINVAL);
+        }
+
+        let ptr = raw.as_mut_ptr();
+        // CAST: `GetVersionRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetVersionRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &mut GetVersionRsp = unsafe { &mut *ptr };
+
+        // Creating a reference on a packed struct will result in
+        // undefined behaviour, so we operate on the raw data directly
+        let unaligned = core::ptr::addr_of_mut!(rsp.version_number_entries) as *mut u16;
+        for version_offset in 0..version_number_entries {
+            let addr = unaligned.wrapping_add(version_offset);
+            let version = unsafe { core::ptr::read_unaligned::<u16>(addr) };
+            unsafe { core::ptr::write_unaligned::<u16>(addr, version.to_le()) }
+        }
+
+        Ok(rsp)
+    }
+}
-- 
2.52.0

