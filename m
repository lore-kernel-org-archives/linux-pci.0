Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F23A3804
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190477; cv=none; b=KBPr+Gao0QkZPJrQVZnsgLPIkGimn9lDbJ7r/rqSQdBvYelmLoN5bliYa5RzV3OIiJQ7JBg9Yjdg9AloHZkVnD3LUr9SER/GDPAMthuss3KGxbrReYj1lZRQkCcu8/0+tWxMJ1UA7iBb3MCBfq6ZMp+EuzA1cqlsGM5iEexx4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190477; c=relaxed/simple;
	bh=6g8qUc8FCq1CnK+XKm/AncchNHM3Qel/DID7TCn/4dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyGOmryygX0c7vXsT94bXZOeGy5qtuaj+FyBso9zi8geNYbrD7UW1UY2zRcJ8zOSppxxz+ob/dMGv1vCaeJjKm9d+HK2rLZGv6dxD70YRRekePdc6X3Q0KGNtS9vYgt+PybZnkmT5iE+c8dCS62pNnqjtga7lXvpEpfKXMMlgrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB1zH3S7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB1zH3S7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2247e38eso59048355ad.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190474; x=1782795274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukv3JrrvOYdolrSr5/I1MGzSjkItvq535Qfo/fGV5j4=;
        b=XB1zH3S7gb35GpxbJVMMQjUQof/gdP1PfQjf2m6u9qIVnOqBlX+dXkVWcHfZbA78T7
         VnVeGhJYAlhHa5VrshtAI4HOMjAL/Y5HRjy1EMOMoIVG1JkxhoLo8EGk6Ofbeg+Uodke
         h6z1tnws1xanNv6n02ngborA9Pm41JBF2sk9Merfl+T9b1S+25Z02FwBDQQhGTHiv+iY
         uFBxsb6e39jQn2eSFKt3gIWuywXxoGH91QLMYxvvpbhkP4pSrM8maUd1hy/1D9OffJUh
         wxQsBBsrzmLm0pEfBSTJruLqAI/OqpukMuRJTImWZiMWjju7JT5dsSeBFryJoGxTcx/9
         kEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190474; x=1782795274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ukv3JrrvOYdolrSr5/I1MGzSjkItvq535Qfo/fGV5j4=;
        b=d980b7em/dJPdvwUR6torUe5K1sJ5EIsQ+aLqO7YLy3MCrdzzJzFw+F6ZRAZez7hjv
         9MEkP6X++Qyx9zcmlHZ+4dVblyNhg3FKhXStOBer4irxTYfNlolvuZbzqPeyaeasHNne
         P26A/FRXtJdytLnBTR4/J8nRH72LxvToQpOz71x5au+U54F//xAzVPuZh69VdAAZbGY1
         /xNajcbBCnz46rK6oNAMQpSlUxZCVMj8r3k2fZj5sSSHl6ZP7SfJYlVPYti8nG61Ifmu
         wewK75aROrrEaLIHlbjskE83YN6nCnKLEgx24ImU0c9YAZal76eqLt0GgL4dVdXGwuop
         HW0A==
X-Forwarded-Encrypted: i=1; AHgh+RoD3EM4e7jiADsJ0fcpI9umwDXFUNh4WdhQY49j9VtJC7oIM5neySY965wb+S+Gf+YghBZpxd6I2R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4O6wtE1eklptwmF4rViKVGhlAPWGxTk3P1M9eCV++h7d1mgfy
	RJ7/freoFU/pw2Um6oDFSTQmgQgGM/rX0VVL99wu8k2DxdHCLApiyKEI
X-Gm-Gg: AfdE7cn8inXuMj3cF9ftBZA72FDXlAbBYggZylrWQajkSQxgcSB8Blfg9B5u4vvO9Tr
	CrOP3hzGhbdbEnkhbOzTGOALme+9dfBxK5svft9sgVKUedy3Ft2Ds7r+cb+s1CQkY8p1vPvXoFh
	kFXqAWrJ4DW+Xy/pHNweDqva9mq0fiWCn0kD+RhoLnVn++bp2ySM2//zcEz2umAeAwUa2qYrMfD
	88zF4RexNQejqEz8NUfkOp0yxygSytOY4WYREXNEZm5IALvLuhKAiikB40ISFpm6XpxCAXBfDWt
	Yj8Dzf2vSZoj+HN+FPE9CXE4FjP3dhgkoQVH2rdQ+y25Pes3Afih4Uq7ogembt8goHovn03NHGe
	G5U0+mMKsdlLCqk4PYotTeZQvgDnoCzPzlwCqixtnDzoBxu8otza53BV931LGHqldgYuXbOcM1x
	K283+T4sEo6+rJPCEH0hjgfkxjwErT5w==
X-Received: by 2002:a17:902:e547:b0:2ba:924b:3948 with SMTP id d9443c01a7336-2c718ee158dmr179781315ad.15.1782190474309;
        Mon, 22 Jun 2026 21:54:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:54:33 -0700 (PDT)
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
Subject: [PATCH v2 02/21] rust: create basic untrusted data API
Date: Tue, 23 Jun 2026 14:53:47 +1000
Message-ID: <20260623045406.2589547-3-alistair.francis@wdc.com>
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
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/validate.rs | 148 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 rust/kernel/validate.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..af7a7558cde2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -134,6 +134,7 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+pub mod validate;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
new file mode 100644
index 000000000000..2b28625c25ef
--- /dev/null
+++ b/rust/kernel/validate.rs
@@ -0,0 +1,148 @@
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
+use core::ops::{Deref, DerefMut};
+
+use crate::{
+    alloc::{
+        Allocator,
+        Vec, //
+    },
+    transmute::{
+        cast_slice,
+        cast_slice_mut, //
+    },
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
+/// derefs to `KVec<Untrusted<T>>`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
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
+/// The reason for this is that `&mut Untrusted<[u8]>` can beconverted into `&mut [Untrusted<u8>]`
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
+    pub fn new(value: T) -> Self
+    where
+        T: Sized,
+    {
+        Self(value)
+    }
+}
+
+impl<T> Deref for Untrusted<[T]> {
+    type Target = [Untrusted<T>];
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`.
+        unsafe { cast_slice(&self.0) }
+    }
+}
+
+impl<T> DerefMut for Untrusted<[T]> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`.
+        unsafe { cast_slice_mut(&mut self.0) }
+    }
+}
+
+impl<T, A: Allocator> Deref for Untrusted<Vec<T, A>> {
+    type Target = Vec<Untrusted<T>, A>;
+
+    fn deref(&self) -> &Self::Target {
+        let ptr: *const Untrusted<Vec<T, A>> = self;
+        // CAST: `Untrusted<T>` transparently wraps `T`.
+        let ptr: *const Vec<Untrusted<T>, A> = ptr.cast();
+        // SAFETY: `ptr` is derived from the reference `self`.
+        unsafe { &*ptr }
+    }
+}
+
+impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        let ptr: *mut Untrusted<Vec<T, A>> = self;
+        // CAST: `Untrusted<T>` transparently wraps `T`.
+        let ptr: *mut Vec<Untrusted<T>, A> = ptr.cast();
+        // SAFETY: `ptr` is derived from the reference `self`.
+        unsafe { &mut *ptr }
+    }
+}
-- 
2.54.0

