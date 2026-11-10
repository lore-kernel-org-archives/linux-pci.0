Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284342;
	b=qHoc5pVsGq6Jdp5mL+afEo2hYYKmt/lNn/zfx8n/jmfVeiSAuA2DDRqWRWjayq3sny1m
	 MuL6R+FT+8WxwJ0pOdEXCAexMsvcS7dtmMfV4puSn9+BWikMILrjJa4LVowugkJpyawjN
	 Z8w1kVFka6ONNrA2Ur76Qe6py6GiDvB0y8p+PiP79fRTSXGTRRgPIhddcQcEx5pUEPS/f
	 kU4FbUBRElTkcKfbxgdRJTL7JPzXxnOG1trSRNEtla1Xn8HCKbNeoCzr9iYLsT2YlStB+
	 UKK4DwtWWXG9hgLGmtSBKX/Su+APNA3OgoaXsrmdBeUzJ6ihiitye7eQYHB9zTb9r5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=voHVtFiTaOYWQ2BNxOE2wKBfGbWc/Y1RKhh4B4Lqnjs=;
	b=cUkYMadSZvBtlJjukvhn8UrjES7wuZGqKFVKFF+6YLVGYZVpaoKnM61/4XmsDeh4rmkV
	 HRkdmxwGtHvRmX4rf+RqLiUj2kvu8NjSZdtVQrwQ6UH65BM2mWfPSy2aWSNM14JiuHZdX
	 egjuEzlAO01qy/48KU1zUyioHNfRVCoB15idN9aDkjxsUFyVQ1++iivg/XQq/7ymyt40x
	 XcfkAwmRerzq2drIDNbm5l3MJS1gE9rS/+A1GwOYzWuGnDx76uytfAwq2nfBAqaDqqxH5
	 4Hd0/nsBg3kZD2MJMVyiiUtwMY3LfNBPEzusUZc/5fOpT86D4ELIPOrUjNmWu45Z6sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjwpMGCY;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3031606A330
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3031606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gjwpMGCY
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b244fb7fffso2023702c88.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284341; x=1794889141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voHVtFiTaOYWQ2BNxOE2wKBfGbWc/Y1RKhh4B4Lqnjs=;
        b=gjwpMGCYWu9fVD3xJFJUcav6+Pc6FcjuLP6yvMN9InwnjkBJ5mccfVJ59HuwqmvWkJ
         /+lTYUYL69NC2HIRS2EKeb3OKJpaMtphBzz3KgYLGDwv0Yp1iofGrJhGmh+FlheC+N5Y
         HZzDZk76wk8/YxwzqvATwU8KYIH0ui30WoR/pCXLxju4OmQqDgCCEb5jtG604Iw4JsKG
         CG10VHY+eB8fhZVHbtQJGyIyiXtCwAO1k+/cCzH3yrdcq/mI0AdehPQu+JZgZbnmFMxn
         hlb1NsvIoEOIqbBgVVcdB6PYwrf53DrsLLxwI2YerdGtkUa0tD66yDOY46BmUAB8poOL
         b0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284341; x=1794889141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=voHVtFiTaOYWQ2BNxOE2wKBfGbWc/Y1RKhh4B4Lqnjs=;
        b=YBD601Mgg4nBJLuNoITYSzqhMzO7oHy5VunmqWrzkp562Dxa3vEMYWmCqWH29et57B
         +kpjsA/S0kEG7CV9jAvah1Y4SDSBBrrQhgsvDaYQ94zD7FyCkbFk+JqbdGZmSLvMMnPh
         L48SUrC0yYS2Dg4MvW5xI9v+AqxUWwTHKA54todAYC8QlzKQWjO3+CiD9w4o/WzW+HFl
         e1mwoq3g7TW0N4jLHwaN5pDnBNyZITn77LdY9Y/ZYuV/1YQhuWu/DNAdqwFwgQWIi/9Q
         JJy8ccIVV6QsSQ2YLSiAIOl3qwPUZx4CpBKmv5vx4/xtvra3uLFyHOiQCL6QDAqtcrJY
         C2gA==
X-Forwarded-Encrypted: i=1; AL+hErH/d29EeyOrB3VvHZZojrN8l48iuj6Ixqqxx5Z/0t3TxPhfDz8Sk7cW0SIYS/kob6o0vCtcYxVQymg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1kAm+Dg+0Rf5YfMrUuaVEelBmU62DOVQDD32aiNUaqVrNYZE3
	t5dPL+Md0q+PKolq+sTswsVRZz0PpNGv+0R/bodIN94FHF6adCGV4vb3
X-Gm-Gg: AYBFou3riD83qceE7pdB1PaSr0G3kjBPuBu2RQq2asFBvcQ4OrMlZVxrCRxRDoRHCCp
	m4Jb3bYMKZlJYPeu2RCiHPkC46xOGi2LyMDftKVVPBqcg+lQznggGQmO3X7Wc78EgnF4vG1RCSx
	qpLi/zg4YTg2lchPc61ATTm+6cPcDymdpxy3l1UULkGsP0VshQrUT7BaOPoTvX7BRcgW8XKWMd2
	1ED5L0kI68lBULzY0dC9hUde8W6JgD01Wmnne3soK5hxOrIdapNykyYOZFAu301qeZz7Xzxf7eM
	myuUU6rMyf+SBP8FGni+a8sYzE/ffQXxSMcsr16PpAjJHeTRiDbqHh7IytTxRyqb3htyPOKW2m+
	yxSp4tdeKvRvJ3oiN9M7AhTJbc7Oc58pfCS0IENKSfYptGmGy8Lv6REllkOStTN4kCDx/u+AP6y
	DP61Jv+tjVjkfothVgAxXhIynRJ5amkcJggmEQlY3cJdsNFJ1BFPlUaEgIyI19in43u+F8sHPTF
	e17FMGTrndzGITGQF6eO+NVirhW43hqbD7UEd4RSnrbzCO2N7X5LlqYLMWlaZe7Om0EldaU122i
	p4Frj0+yzXTMh8d8PeDr2hGtBKVcVWW/SjNLANdtTcVKd9+Aop8ptSXx6kFVFRnmuAVj
X-Received: by 2002:a05:701b:2608:b0:14d:c7ae:85dd with SMTP id a92af1059eb24-1b3b5fd221dmr1835080c88.7.1794284340890;
        Mon, 09 Nov 2026 20:19:00 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:19:00 -0800 (PST)
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
Subject: [PATCH v6 02/25] rust: create basic untrusted data API
Date: Tue, 10 Nov 2026 14:18:09 +1000
Message-ID: <20261110041832.1730924-3-alistair.francis@wdc.com>
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

From: Benno Lossin <benno.lossin@proton.me>

When the kernel receives external data (e.g. from userspace), it usually
is a very bad idea to directly use the data for logic decision in the
kernel. For this reason, such data should be explicitly marked and
validated before making decision based on its value.

The `Untrusted<T>` wrapper type marks a value of type `T` as untrusted.
The particular meaning of "untrusted" highly depends on the type `T`.
For example `T = u8` ensures that the value of the byte cannot be
retrieved. However, `T = [u8]` still allows to access the length of the
slice. Similarly, `T = KVec<U>` allows modifications.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20250814124424.516191-3-lossin@kernel.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/validate.rs | 198 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 rust/kernel/validate.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557a..a3c54971e9dea 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -147,6 +147,7 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+pub mod validate;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
new file mode 100644
index 0000000000000..5926d0697d3ff
--- /dev/null
+++ b/rust/kernel/validate.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Untrusted data API.
+//!
+//! # Overview
+//!
+//! Untrusted data is marked using the [`Untrusted<T>`] type. See [Rationale](#rationale) for the
+//! reasons to mark untrusted data throughout the kernel. It is a totally opaque wrapper, it is not
+//! possible to read the data inside.
+//!
+//! APIs that write back into userspace usually allow writing untrusted bytes directly, allowing
+//! direct copying of untrusted user data back into userspace without validation.
+//!
+//! # Rationale
+//!
+//! When reading data from an untrusted source, it must be validated before it can be used for
+//! **logic**. For example, this is a very bad idea:
+//!
+//! ```
+//! # fn read_bytes_from_network() -> KBox<[u8]> {
+//! #     Box::new([1, 0], kernel::alloc::flags::GFP_KERNEL).unwrap()
+//! # }
+//! let bytes: KBox<[u8]> = read_bytes_from_network();
+//! let data_index = bytes[0];
+//! let data = bytes[usize::from(data_index)];
+//! ```
+//!
+//! While this will not lead to a memory violation (because the array index checks the bounds), it
+//! might result in a kernel panic. For this reason, all untrusted data must be wrapped in
+//! [`Untrusted<T>`]. This type only allows validating the data or passing it along, since copying
+//! data from userspace back into userspace is allowed for untrusted data.
+
+use core::{
+    ops::{
+        Deref,
+        DerefMut, //
+    },
+    ptr::from_ref,
+    slice, //
+};
+
+use crate::alloc::{
+    Allocator,
+    Vec, //
+};
+
+/// Untrusted data of type `T`.
+///
+/// Data coming from userspace is considered untrusted and should be marked by this type.
+///
+/// The particular meaning of [`Untrusted<T>`] depends heavily on the type `T`. For example,
+/// `&Untrusted<[u8]>` is a reference to an untrusted slice. But the length is not considered
+/// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
+/// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
+/// derefs to `[Untrusted<T>]`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
+/// totally opaque.
+///
+/// # Usage in API Design
+///
+/// The exact location where to put [`Untrusted`] depends on the kind of API. When asking for an
+/// untrusted input value, or buffer to write to, always move the [`Untrusted`] wrapper as far
+/// inwards as possible:
+///
+/// ```ignore
+/// // use this
+/// pub fn read_from_userspace(buf: &mut [Untrusted<u8>]) { todo!() }
+///
+/// // and not this
+/// pub fn read_from_userspace(buf: &mut Untrusted<[u8]>) { todo!() }
+/// ```
+///
+/// The reason for this is that `&mut Untrusted<[u8]>` can be converted into `&mut [Untrusted<u8>]`
+/// very easily, but the converse is not possible.
+///
+/// For the same reason, when returning untrusted data by-value, one should move the [`Untrusted`]
+/// wrapper as far outward as possible:
+///
+/// ```ignore
+/// // use this
+/// pub fn read_all_from_userspace() -> Untrusted<KVec<u8>> { todo!() }
+///
+/// // and not this
+/// pub fn read_all_from_userspace() -> KVec<Untrusted<u8>> { todo!() }
+/// ```
+///
+/// Here too the reason is that `KVec<Untrusted<u8>>` is more restrictive compared to
+/// `Untrusted<KVec<u8>>`.
+#[repr(transparent)]
+pub struct Untrusted<T: ?Sized>(T);
+
+impl<T> From<T> for Untrusted<T> {
+    #[inline]
+    fn from(value: T) -> Self {
+        Self(value)
+    }
+}
+
+impl<T: ?Sized> Untrusted<T> {
+    /// Marks the given value as untrusted.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// # mod bindings { pub(crate) unsafe fn read_foo_info() -> [u8; 4] { todo!() } };
+    /// fn read_foo_info() -> Untrusted<[u8; 4]> {
+    ///     // SAFETY: just an FFI call without preconditions.
+    ///     Untrusted::new(unsafe { bindings::read_foo_info() })
+    /// }
+    /// ```
+    #[inline]
+    pub fn new(value: T) -> Self
+    where
+        T: Sized,
+    {
+        Self::from(value)
+    }
+}
+
+impl<T> Untrusted<T> {
+    /// Marks the data behind the given reference as untrusted.
+    ///
+    /// Unlike [`Untrusted::new`], this does not require moving the value.
+    #[inline]
+    pub const fn from_ref(value: &T) -> &Self {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`. The cast
+        // does not introduce interior mutability, as `Untrusted<T>`
+        // has interior mutability if and only if `T` has.
+        unsafe { &*from_ref(value).cast::<Self>() }
+    }
+
+    /// Marks the given slice of data as untrusted.
+    #[inline]
+    pub const fn from_slice(value: &[T]) -> &[Self] {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`. The cast
+        // does not introduce interior mutability either, as `Untrusted<T>`
+        // has interior mutability if and only if `T` has.
+        unsafe { slice::from_raw_parts(value.as_ptr().cast::<Self>(), value.len()) }
+    }
+
+    /// Marks the given mutable slice of data as untrusted.
+    ///
+    /// To obtain a mutable slice of untrusted data from a trusted buffer, mark the whole buffer
+    /// as untrusted first instead, e.g. with [`Vec::from_trusted`].
+    #[inline]
+    const fn from_mut_slice(value: &mut [T]) -> &mut [Self] {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`, see `from_slice()`; the conversion is
+        // sound here because it is only reachable via `DerefMut`, where the source is already
+        // untrusted.
+        unsafe { slice::from_raw_parts_mut(value.as_mut_ptr().cast::<Self>(), value.len()) }
+    }
+}
+
+impl<T> Deref for Untrusted<[T]> {
+    type Target = [Untrusted<T>];
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        Untrusted::from_slice(&self.0)
+    }
+}
+
+impl<T> DerefMut for Untrusted<[T]> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        Untrusted::from_mut_slice(&mut self.0)
+    }
+}
+
+impl<T, A: Allocator> Deref for Untrusted<Vec<T, A>> {
+    type Target = [Untrusted<T>];
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        Untrusted::from_slice(self.0.as_slice())
+    }
+}
+
+impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        Untrusted::from_mut_slice(self.0.as_mut_slice())
+    }
+}
+
+impl<T, A: Allocator> Vec<T, A> {
+    /// Converts `value` into a `Vec<Untrusted<T>, A>`, marking every element as untrusted.
+    #[inline]
+    pub fn from_trusted(value: Self) -> Vec<Untrusted<T>, A> {
+        let (ptr, length, capacity) = value.into_raw_parts();
+
+        // SAFETY: `Untrusted<T>` transparently wraps `T`, so `ptr`, `length` and `capacity` also
+        // describe a valid `Vec<Untrusted<T>, A>` allocation (same layout, alignment and drop
+        // behaviour).
+        unsafe { Vec::from_raw_parts(ptr.cast::<Untrusted<T>>(), length, capacity) }
+    }
+}
-- 
2.56.0

