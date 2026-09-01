Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA963A5E89
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224766; cv=none; b=T4kTpA4Qa5OUFSaqphYZjS5Ys98waMqxuG3X6r2xt1sDxmkVNTyKHEYBlaXKEmTu2wDSdXsY4lJlemBGDDqpHrQ1Z5WoZVG/QRsZNm+I89kySV1uTVDntSFeZlAIoi1sB/8xUhgKd8r1ZfM3uKjkqgvaIL6zsfnStipqoFGNWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224766; c=relaxed/simple;
	bh=HthUjnldegi+9zjWtI3LcXV1ZM2WtC6ROPpK/XuRS6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuNbp4Su53b3NP0Q3gE9ARVJ7Ez5JWu+b+EvPPatIFdQx71X92AB180pJ6PEAlLl9TR+PzxMuwLiEtSJ2/W8dJWmi4oOh2tbUZQWaHNZMl5TdKlTbZfH0VCQ+7KIzjCrQzrG5QQ+15wqexJfNRC/eX4PIYCzOS5gXDFQ05N846w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAPjRNmi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAPjRNmi"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d956fe30a0so2203355ad.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224764; x=1788829564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YcvUkNy7YSfO/SiCL7bc9lxpci0543rqGrGQfdfumlI=;
        b=iAPjRNmi1u4QLYVZi0Xyq5YwCpXdQLJi/T5VEocWqpJM0szM3SZgxu9ZtwgjABceqR
         OXjdxlR642Z7rZH3DZW/sb4W1m/gbasuj7L+k2+Hsat45NBnt47j++Z8GVBu4VF1o9GN
         dRqABvS8k20nnoSu3Z/Net1V40YuVn7YRwifhOKX6VAPbQYau9uTm/13bzZW+sD5kJsO
         H4M907dp5U7lA91pObOZfLlPqhKiAha93L5VJ4GD+/3bR2cvjSA2lUsBNzskufqDl/yg
         oepWiTMtYodw808JJlgWyfFZEjcNTIBcAz6DXNCXzInPOHmjroXcIGoxRjof2lMyiCrw
         hJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224764; x=1788829564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YcvUkNy7YSfO/SiCL7bc9lxpci0543rqGrGQfdfumlI=;
        b=bgIYtI0Y7d2pZc4D9ffi4vfB0BK0sbitqQAslXS2I89UsPuEg5uICViA/iouRuKDKq
         zjYe5U1AbYOeMFM5ub169T/PlbgJPQuO/u9TtADotXRoSz+SptkOfkSEBoF4wMrzs40b
         iwvBC4AtB7jfZh/YavCy4XrNgPRITZXLpCPrCkFMLGD4xHwYO6xYcDpgIzcs6zSIGiqY
         0Rdh44GTfdLDaey2whUmWjJ98HT6fJ9MqjDn+TtpmZyjHp4q9sKnh5kaFSZ5YuqospRm
         9MmtUdkiYOBBwupmE/4MsS2yXA8hhBlaNeyKsOHU4DlJHpGuz7NnMAu5zri6Z+yfaHFP
         g1gA==
X-Gm-Message-State: AFuF++nFiY7IkFde/Qc5i5Ugpu0Gy/gbbNYebK9td7XBr9eNBhZdPKpG
	CPkiMFydQttK+8F5paeGrioYI3DxsrpOEDy8ePK2KOyHgPzdSpGLllWyg1W44A==
X-Gm-Gg: AYBFou3T29eivjqODoRnOHFvjLoMXo1x5k/TIWV5ZprvJJLxEtaAyIGT51HLHkbjHth
	6ze/ibvUvvNgE5CXkmApEb1dV5j0U2VWElkUatDmU8/sssgyxGTE57vZhKOEFB71sugmK8wCEJO
	jS+Hl3ngh1qyjH9p8vo/o+931ANYxMxGL+VvimWGcYGzVK6454tDkNdLz4/A4EnF6lnm/gDCccK
	rA9MdnmJZpKtADuaHjCUXBIWZLQdl+sPPxv0kak6C3b2v4qM8XCusHHCaoFOvu+79b+QevpE+B1
	56VYfvIh4awwd1nEodkls9tjzFWoRKKwMt3Qmaf7KTgc29kjoJwyclT7qtQB1wb+RgN4rclNRqi
	Sae8CLXD9ZxTzn9gBnp/Gmo/lrgqrpiJXvakIdzq2/Qh5dZUKfxvcBODNvLh51qLP4kiEZkQCMA
	NDlloFaGL1Qu75g9I6HAaEnEtZ0EXcimM4ffrrg1yO8VS5u4mKti24t2Lg7C1VtivVZLFnhuyIw
	bE3RA==
X-Received: by 2002:a17:90b:48d1:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39907b5fefamr6466281a91.10.1788224763531;
        Mon, 31 Aug 2026 18:06:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:06:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	djbw@kernel.org,
	rust-for-linux@vger.kernel.org,
	lukas@wunner.de,
	alistair@alistair23.me,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	bhelgaas@google.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: gary@garyguo.net,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com
Subject: [PATCH v3 14/21] lib: rspdm: Support SPDM get_version
Date: Tue,  1 Sep 2026 11:03:40 +1000
Message-ID: <20260901010347.2614656-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901010347.2614656-1-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
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
 lib/rspdm/consts.rs    | 16 ++++++++--
 lib/rspdm/lib.rs       | 54 +++++++++++++++++++++++++++------
 lib/rspdm/state.rs     | 67 ++++++++++++++++++++++++++++++++++++++--
 lib/rspdm/validator.rs | 69 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 14 deletions(-)

diff --git a/lib/rspdm/consts.rs b/lib/rspdm/consts.rs
index 01f008958a1f..055671d43abd 100644
--- a/lib/rspdm/consts.rs
+++ b/lib/rspdm/consts.rs
@@ -7,16 +7,24 @@
 //! Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
 //! <https://www.dmtf.org/dsp/DSP0274>
 
+use crate::validator::GetVersionRsp;
+use core::mem;
 use kernel::error::{code::EINVAL, Error};
 
 // SPDM versions supported by this implementation
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
 
-#[allow(dead_code)]
 pub(crate) const SPDM_REQ: u8 = 0x80;
-#[allow(dead_code)]
 pub(crate) const SPDM_ERROR: u8 = 0x7f;
 
 #[derive(Clone, Copy)]
@@ -90,3 +98,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
         write!(f, "{:#x}", *self as u8)
     }
 }
+
+pub(crate) const SPDM_GET_VERSION: u8 = 0x84;
+pub(crate) const SPDM_GET_VERSION_LEN: usize =
+    mem::size_of::<GetVersionRsp>() + (u8::MAX as usize) * mem::size_of::<u16>();
diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 1883579b817a..58d86ea06fd9 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -18,8 +18,10 @@
     c_int,
     c_void, //
 };
+use core::pin::Pin;
 use core::ptr;
 use kernel::prelude::*;
+use kernel::sync::{new_mutex, Mutex};
 use kernel::{
     alloc::flags,
     bindings, //
@@ -51,11 +53,22 @@ pub extern "C" fn spdm_create(
     transport_sz: u32,
     validate: bindings::spdm_validate,
 ) -> *mut spdm_state {
-    match KBox::new(
-        SpdmState::new(dev, transport, transport_priv, transport_sz, validate),
-        flags::GFP_KERNEL,
-    ) {
-        Ok(ret) => KBox::into_raw(ret) as *mut spdm_state,
+    // Wrap the `SpdmState` in a `Mutex` so that concurrent FFI callers (for
+    // example, two threads racing on `spdm_authenticate()` for the same
+    // device) serialize on the lock and never form aliased `&mut SpdmState`
+    // references.
+    let state = SpdmState::new(dev, transport, transport_priv, transport_sz, validate);
+    match KBox::pin_init(new_mutex!(state), flags::GFP_KERNEL) {
+        Ok(b) => {
+            // `Mutex<SpdmState>` is `!Unpin` and must remain pinned in
+            // memory.  The C side stores the raw pointer; `spdm_destroy()`
+            // re-pins via `Pin::new_unchecked` before dropping, preserving
+            // the pin invariant.
+            // SAFETY: The contents are not moved between here and the
+            // matching `KBox::from_raw` in `spdm_destroy()`.
+            let raw = KBox::into_raw(unsafe { Pin::into_inner_unchecked(b) });
+            raw as *mut spdm_state
+        }
         Err(_) => ptr::null_mut(),
     }
 }
@@ -70,7 +83,25 @@ pub extern "C" fn spdm_create(
 /// Return 0 on success or a negative errno.  In particular, -EPROTONOSUPPORT
 /// indicates authentication is not supported by the device.
 #[export]
-pub extern "C" fn spdm_authenticate(_state_ptr: *mut spdm_state) -> c_int {
+pub extern "C" fn spdm_authenticate(state_ptr: *mut spdm_state) -> c_int {
+    if state_ptr.is_null() {
+        return -(bindings::EINVAL as c_int);
+    }
+
+    // SAFETY: `state_ptr` was returned from `spdm_create()` (which leaks a
+    // `Pin<KBox<Mutex<SpdmState>>>`) and has not yet been passed to
+    // `spdm_destroy()`.  We only form a shared reference to the mutex; the
+    // exclusive `&mut SpdmState` lives entirely inside the lock guard, so
+    // concurrent FFI callers serialize on the mutex and can never form
+    // aliased `&mut SpdmState` references.
+    let mutex: &Mutex<SpdmState> = unsafe { &*(state_ptr as *const Mutex<SpdmState>) };
+
+    let mut state = mutex.lock();
+
+    if let Err(e) = state.get_version() {
+        return e.to_errno() as c_int;
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
@@ -82,8 +113,11 @@ pub extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
     if state_ptr.is_null() {
         return;
     }
-    // SAFETY: `state_ptr` was returned from `spdm_create` (which uses
-    // `KBox::into_raw`) and the caller guarantees the state is no longer
-    // in use.  Reconstructing the `KBox` and dropping it frees the state.
-    drop(unsafe { KBox::from_raw(state_ptr as *mut SpdmState) });
+    // SAFETY: `state_ptr` was returned from `spdm_create()`, which leaked a
+    // `Pin<KBox<Mutex<SpdmState>>>` via `KBox::into_raw`.  The caller
+    // guarantees the state is no longer in use.  Reconstructing the pinned
+    // box and dropping it runs `Drop` for the `Mutex` and `SpdmState` and
+    // frees the allocation.
+    let b = unsafe { KBox::from_raw(state_ptr as *mut Mutex<SpdmState>) };
+    drop(unsafe { Pin::new_unchecked(b) });
 }
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index e1f74d19ac4b..9e8c65a12199 100644
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
@@ -33,6 +38,11 @@
 /// The current SPDM session state for a device. Based on the
 /// C `struct spdm_state`.
 ///
+/// Concurrent access is serialized by wrapping the whole struct in a
+/// `Mutex<SpdmState>` at the FFI boundary, so `spdm_authenticate()` callers
+/// run one at a time and the locked `&mut SpdmState` is the only way to
+/// reach the inner fields.
+///
 /// `dev`: Responder device.  Used for error reporting and passed to @transport.
 /// `transport`: Transport function to perform one message exchange.
 /// `transport_priv`: Transport private data.
@@ -72,7 +82,6 @@ pub(crate) fn new(
         }
     }
 
-    #[allow(dead_code)]
     fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
         match rsp.error_code {
             SpdmErrorCode::InvalidRequest => {
@@ -184,7 +193,6 @@ fn spdm_err(&self, rsp: &SpdmErrorRsp) -> Result<(), Error> {
     ///
     /// The data in `request_buf` is sent to the device and the response is
     /// stored in `response_buf`.
-    #[allow(dead_code)]
     pub(crate) fn spdm_exchange(
         &self,
         request_buf: &mut [u8],
@@ -234,4 +242,59 @@ pub(crate) fn spdm_exchange(
 
         Ok(length)
     }
+
+    /// Negotiate a supported SPDM version and store the information
+    /// in the `SpdmState`.
+    pub(crate) fn get_version(&mut self) -> Result<(), Error> {
+        let mut request = GetVersionReq::default();
+        request.version = SPDM_MIN_VER;
+        self.version = SPDM_MIN_VER;
+
+        // SAFETY: `request` is repr(C) and packed, so we can convert it to a slice
+        let request_buf = unsafe {
+            from_raw_parts_mut(
+                &mut request as *mut _ as *mut u8,
+                core::mem::size_of::<GetVersionReq>(),
+            )
+        };
+
+        let mut response_vec: KVec<u8> = KVec::from_elem(0u8, SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
+
+        let rc = self.spdm_exchange(request_buf, response_vec.as_mut_slice())? as usize;
+
+        // The transport must report a length within the buffer we provided.
+        if rc > response_vec.len() {
+            return Err(EINVAL);
+        }
+        response_vec.truncate(rc);
+
+        let response: &GetVersionRsp = Untrusted::new(response_vec.as_slice()).validate()?;
+
+        let mut foundver = false;
+        let entry_count = response.version_number_entry_count;
+        let entries_offset = core::mem::offset_of!(GetVersionRsp, version_number_entries);
+
+        for i in 0..entry_count as usize {
+            let off = entries_offset + i * core::mem::size_of::<u16>();
+            let entry = u16::from_le_bytes([response_vec[off], response_vec[off + 1]]);
+            let alpha_version = (entry & 0xF) as u8;
+            let version = (entry >> 8) as u8;
+
+            if alpha_version > 0 {
+                pr_warn!("Alpha version {alpha_version} is not specifically supported\n");
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
+            return Err(EPROTO);
+        }
+
+        Ok(())
+    }
 }
diff --git a/lib/rspdm/validator.rs b/lib/rspdm/validator.rs
index 323242e84580..5990ff7ada29 100644
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
@@ -90,3 +99,63 @@ fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
         Ok(unsafe { &*ptr })
     }
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
+impl<'a> Validate<Untrusted<&'a [u8]>> for &'a GetVersionRsp {
+    type Err = Error;
+
+    fn validate(unvalidated: &[u8]) -> Result<Self, Self::Err> {
+        if unvalidated.len() < mem::size_of::<GetVersionRsp>() {
+            return Err(EINVAL);
+        }
+
+        let version = *(unvalidated.get(0).ok_or(ENOMEM))? as usize;
+        if version != SPDM_MIN_VER.into() {
+            return Err(EINVAL);
+        }
+
+        let version_number_entries = *(unvalidated.get(5).ok_or(ENOMEM))? as usize;
+        let total_expected_size =
+            version_number_entries * mem::size_of::<__le16>() + mem::size_of::<GetVersionRsp>();
+        if unvalidated.len() < total_expected_size {
+            return Err(EINVAL);
+        }
+
+        let ptr = unvalidated.as_ptr();
+        // CAST: `GetVersionRsp` only contains integers and has `repr(C)`.
+        let ptr = ptr.cast::<GetVersionRsp>();
+        // SAFETY: `ptr` came from a reference and the cast above is valid.
+        let rsp: &GetVersionRsp = unsafe { &*ptr };
+
+        Ok(rsp)
+    }
+}
-- 
2.55.0

