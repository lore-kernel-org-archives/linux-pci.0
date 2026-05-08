Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278D2F260F
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210332; cv=none; b=kYzxbzsvRAjCYycFLNivxC3/SlgPbHp6KXEQ//LMdTsfThWc9hQ/j6XVBwSfx5XCmC4LJgGpxOJGcJcEh8gBgDsmmpfCQIt2RZy4eRBmCDEzgB+X3w7OQ9OOYFZWbdmuPM1PHbG2+nZZRq2xoSVXHHSD0zO4YioCvAzppvlhxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210332; c=relaxed/simple;
	bh=oxNrGjcZCazizcSxSSIR96HPVNGWilr6D9NtWMsT9rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHP1TCb0kogIWy8WJX5Jq52Mv62GCGi7Vl3XR9W0GZmP7OiaihAWg+Dz8EDiRjlwGqmCZHuJ1j3exQYwUma5jtC2rPyvUfB7Z+AZJ8eYoZ0lMFqZx4rZX3zRFZRLGvu+dQt7KO2cW0TV7DZf6wO3KYQqb7wWn2YRwhxYbu3bMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+a6o51L; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+a6o51L"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2baca78cfaaso8654405ad.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210327; x=1778815127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdaY8XVDz6HV3abuC4HHO5UewMGlDvcsArdslgC4GX0=;
        b=a+a6o51LnORkrj8YRpE5Xy8JhOmLgr/EPwjAL1nxVAAUF7J/76zW8cfLLpMBpc+jns
         XcNxlEblsg+g11U2adOV+fhOn2uS9A6CY3/bNdrFONHCmqaIAsgl0q/hr5WfpCg8bM5b
         6vf/vijWohGSxuTGnjTDAbGb0ACVYYMjaGSu0RObcl2b5X+i20WV80p62/qFMKtB6821
         RRr5M3CCWanHzG5v+6a+O1729SgJnff7wzrEFHwSxKZetRdHfXOAhzH2ojVYlwoIoJ2a
         0QMvd14MRAivzBwj11Ad1oHAyb9kYXAvUf8hmH9dkE1ixQNdqyt0N1XL+SmuK+9NffPp
         NNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210327; x=1778815127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sdaY8XVDz6HV3abuC4HHO5UewMGlDvcsArdslgC4GX0=;
        b=gH3yiqP8bUhzTzz/PlBVTnytDHXbt8oNETXk6WqSIlsxk7IAZbT0FMOg4sjPCWdzgt
         Wby3L8ANBUauyLUbYBu+XUJmnNi8g2VJ9XMtbYle2tir5lTucqZmbPpYX0UKzszmHe90
         6X1IYaw5oNWQP22ewA0YfOnHS09gu7l2VY22JA4TAMXoEOQUu+GCPZkwHp9mhvArF2+2
         nDv2f8MaGtgJzJ5KvOg8h2qLYkWy7Mv8HedxAsq6frYr9ebGfcSnDF/Y696AjIhdDt5H
         OnVTtdrK8xoh2RFak7/DYbwW7OpInGs/B85ATxGIsMMP9F5seNuFUWdwFgJbM3y03IV4
         hINA==
X-Forwarded-Encrypted: i=1; AFNElJ+/OnLlVvv65IV0Yyql99VI0yGfvTuIiaTW9DzoCj7/0VWHs3IIWeAOuWJ+WAngIZHp37NX72N3zhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7P/iHwSYl1bpdzKhx2xUiQPL1b92xeQXNVojnk0J/AFue+Cwx
	KVownEdsEZkw1zGb7Iw+SMxBMrJkWUkNozDhXREXTUbTWTyAfmEiwkJx
X-Gm-Gg: Acq92OGlDslE4wmuLKwaKaKxe3jiSkcs+JZdU41t08M5G6f8Erg/huNW8mtVtBpVVps
	bnh/+2y6GIt6po3JGuDzVBSR9Htn1GVrIKu4beA+tKi8xO9Lo1gnjkiMgoe/fCRgm+Im6F/AgKw
	7rH70bTz7JiJzGqIW7ZLd+A/foUq9En6L2bCKu1FtuhSFGqD+o5XMTN3F3C+XU19cqG+Xame+Lk
	mi8mX7/94C0N98QgYdpBQnug3DXERt2Zr8V59dMHT3JJ/jmejNcbyQJC/gmUwqUt0MKb0KV19Te
	mt0KUF7od3+wtDtJHxtjhbTnoDNjJqb5608OPnB4FRgQd8dmnYSQ7rKTzEnNQBAZeP9IWuhBhAD
	Yfo9v9ekbotsu5zeGlMnxSyq4M4ZrSZfhhwwiMjTv8vyHj9ulzjYnmwBFpvrxIuQNOCdCtgTMsf
	IiR5SzQ8NZmT4sk9Stm3QGLOK34hfjI4qDdJ9zAswk
X-Received: by 2002:a17:903:1af0:b0:2ad:bd4c:a5 with SMTP id d9443c01a7336-2ba78f63c82mr112714875ad.1.1778210327123;
        Thu, 07 May 2026 20:18:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:18:46 -0700 (PDT)
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
Subject: [PATCH 11/18] lib: rspdm: Support SPDM get_version
Date: Fri,  8 May 2026 13:17:03 +1000
Message-ID: <20260508031710.514574-12-alistair.francis@wdc.com>
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

Support the GET_VERSION SPDM command.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/consts.rs    | 14 +++++++++
 lib/rspdm/lib.rs       |  8 ++++-
 lib/rspdm/state.rs     | 61 ++++++++++++++++++++++++++++++++++++
 lib/rspdm/validator.rs | 70 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 2feddde67885..5482a0f6cee0 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,10 +7,21 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::SpdmHeader;
+use core::mem;
+
 /* SPDM versions supported by this implementation */
 pub(crate) const SPDM_VER_10: u8 = 0x10;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_11: u8 = 0x11;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_12: u8 = 0x12;
+#[allow(dead_code)]
+pub(crate) const SPDM_VER_13: u8 = 0x13;
+pub(crate) const SPDM_VER_14: u8 = 0x14;
 
 pub(crate) const SPDM_MIN_VER: u8 = SPDM_VER_10;
+pub(crate) const SPDM_MAX_VER: u8 = SPDM_VER_14;
 
 pub(crate) const SPDM_REQ: u8 = 0x80;
 pub(crate) const SPDM_ERROR: u8 = 0x7f;
@@ -54,3 +65,6 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
         Ok(())
     }
 }
+
+pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
+pub(crate) const SPDM_GET_VERSION_LEN: usize = mem::size_of::<SpdmHeader>() + u8::MAX as usize;
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 758d43fba5cb..1cc6c33516fb 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -105,7 +105,13 @@
 /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
 /// indicates authentication is not supported by the device.
 #[export]
-pub unsafe extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+pub unsafe extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
+    let state: &mut SpdmState = unsafe { &mut (*(state_ptr as *mut SpdmState)) };
+
+    if let Err(e) = state.get_version() {
+        return e.to_errno() as c_int;
+    }
+
     0
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 18e81f24c724..26b90942b298 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -8,6 +8,7 @@
 //! <https://www.dmtf.org/dsp/DSP0274>
 
 use core::ffi::c_void;
+use core::slice::from_raw_parts_mut;
 use kernel::prelude::*;
 use kernel::{
     bindings,
@@ -22,10 +23,14 @@
 use crate::consts::{
     SpdmErrorCode,
     SPDM_ERROR,
+    SPDM_GET_VERSION_LEN,
+    SPDM_MAX_VER,
     SPDM_MIN_VER,
     SPDM_REQ, //
 };
 use crate::validator::{
+    GetVersionReq,
+    GetVersionRsp,
     SpdmErrorRsp,
     SpdmHeader, //
 };
@@ -232,4 +237,60 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
     }
+
+    /// Negotiate a supported SPDM version and store the information
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
+        // SAFETY: `response_vec` is SPDM_GET_VERSION_LEN length, initialised, aligned
+        // and won't be mutated
+        let response_buf =
+            unsafe { from_raw_parts_mut(response_vec.as_mut_ptr(), SPDM_GET_VERSION_LEN) };
+
+        let rc = self.spdm_exchange(request_buf, response_buf)?;
+
+        // SAFETY: `rc` is the length of data read, which will be smaller
+        // than the capacity of the vector
+        unsafe { response_vec.inc_len(rc as usize) };
+
+        let response: &mut GetVersionRsp = Untrusted::new_mut(&mut response_vec).validate_mut()?;
+
+        let mut foundver = false;
+        let unaligned = core::ptr::addr_of_mut!(response.version_number_entries) as *mut u16;
+
+        for i in 0..response.version_number_entry_count {
+            // Creating a reference on a packed struct will result in
+            // undefined behaviour, so we operate on the raw data directly
+            let addr = unaligned.wrapping_add(i as usize);
+            let alpha_version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } & 0xF) as u8;
+            let version = (unsafe { core::ptr::read_unaligned::<u16>(addr) } >> 8) as u8;
+
+            if alpha_version > 0 {
+                pr_warn!("Alpha version {alpha_version} is unsupported\n");
+            }
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
index 58039f532b7d..8f45bafd4d69 100644
--- a/lib/rspdm/validator.rs
+++ b/lib/rspdm/validator.rs
@@ -7,6 +7,10 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::bindings::{
+    __IncompleteArrayField,
+    __le16, //
+};
 use crate::consts::SpdmErrorCode;
 use core::mem;
 use kernel::prelude::*;
@@ -21,6 +25,11 @@
     },
 };
 
+use crate::consts::{
+    SPDM_GET_VERSION,
+    SPDM_MIN_VER, //
+};
+
 #[repr(C, packed)]
 pub(crate) struct SpdmHeader {
     pub(crate) version: u8,
@@ -71,3 +80,64 @@ pub(crate) struct SpdmErrorRsp {
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
+        let version = *(raw.get(0).ok_or(ENOMEM))? as usize;
+        if version != SPDM_MIN_VER.into() {
+            return Err(EINVAL);
+        }
+
+        let version_number_entries = *(raw.get(5).ok_or(ENOMEM))? as usize;
+        let total_expected_size =
+            version_number_entries * mem::size_of::<__le16>() + mem::size_of::<GetVersionRsp>();
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
+        Ok(rsp)
+    }
+}
-- 
2.52.0

