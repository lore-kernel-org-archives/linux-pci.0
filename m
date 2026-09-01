Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1938A72B
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 01:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224660; cv=none; b=gclL0a09EO8HiIEuNERLDSm6IbHeZw46kLx435wM8aXjEdfFF1QJPZ7X7DSsZi08FSplQ29H+dR1qo3I3pnO7Wh6uG9q5/zaOEZsynphcJ6JACIQW0u7zKOiLIaU2EoejNpa+Psxd1SyuGf1dLUQ8VeJoGamNfDhf5wVDKzTMqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224660; c=relaxed/simple;
	bh=/K808TfOsG2VgzhfRJeQIUFlgb9kInuGTOzKUhgrVD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWyfkm894hQlXa14os6mFiEAt8HnKWK1uS2/K/BsaSXqW1R68jqJJkFZe+oOKMB73i2H1LZ9DE1p44LuyoFS5i+TRxaRgAdtBYm2ASiiCi6qt7bpKQIATDrW9LRPpGkBIM5ac/bQIvvg72InZ2sdMs+cOrJ7tTEOM87xArA0Bng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFZmBkn9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFZmBkn9"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso271662a12.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 18:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788224658; x=1788829458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=65bCRT2r3FA+N3VTYVba2Ft1meiSRlWorEkESgZc4wU=;
        b=MFZmBkn9ITqAj+D8M4z1VAm/gGyM7yal2PcmNAlFIl0DgcnwBVK8Ua1xLXcAgdAttR
         /A9/KqjICeKXH4metmRh7+1aNKNZl47nH/Jg7ZJuXsVsUPeyHHZZV4x6e++fy/VVFy7f
         jdUNUi98GUdDtKFsa7DOYYba5XgoEhRWT/FiL2MANQK5QelH0ye1AA1CER1KvpUhIgKY
         RwLtpOrfevs0vyTayos3DsYCV+zj3eoD3UFSt64gmn4Ywrdark6gHviCXiz4En1wysp+
         dZZZ7fvMny86iHlAKTBEZS4BWgV7OlCZ4xNf2okgCWT7oP1WsMHxw6VpwMZP9ZYbSqAu
         Hn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224658; x=1788829458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=65bCRT2r3FA+N3VTYVba2Ft1meiSRlWorEkESgZc4wU=;
        b=k1UXRRVv/axItn/6rhfo9EFGt27yVekkMM7yMuHcUZupJxgdUBAYkZKwFfIhzbuSUI
         3MZ6z5wzmDybVcqxLoxjiSH7J0EK/NKUlIl8OSTWX7mFaatt/J4SolWbDs7A6ZfFPLik
         Fqol5frCjrBl/73uox/OyPMDChvXLyK5cuRbEOel/mUvVWFSbojgPp+i99iuMPkdtHZU
         Jc8pj1svR00K20PE1FIfas3iC5YCrk6bnKzsbh5Iq9UL/BnpCDB0JhHsLyOFajvHZ7o+
         jdYJimTpaUWDt+iU+PlJyYZhSeG4JMETMD1UW18nGEjsWKysSu4jHQ/kPH1iicto4N7Y
         CEPw==
X-Gm-Message-State: AFuF++m9XcNbGaomtyKr7MM3PABx6x5lYh4ONxs4w+SK+ANbvo15Qj07
	aMFWMMGihNshkm0EKKkkaS+jkVd/npzU+P6AQgOEKaNk+/pCHDQwWlfhJcGaaQ==
X-Gm-Gg: AYBFou07SFWZubTROdZzQj5sy5jAXh8V10w5wxuEYWJtanWAkC1e/WwayDQiRZSraon
	MBpvP58iau29OK6Bj06FelZF7kXqKA3iLkZjrxawApGcj308HAUCa/0k/nk8PVc6FBJkSpVGL4y
	jRkA/JjDk2jRsxjJawBjRC1AW3CXnwhlMqSuh/act1ucJrJ8p9i+/Tpk2FmxNbPiJghVf4ZNi+e
	KWjLFFp/PtnIMSYs7FGCei5PfoK6IPDlGYr+NOE1YWHpt+at0a+G8cyRH9mWlzYGEzR82ouHMy9
	+2KAbywbFy6ua/pZdqoHLY+ZL4rE6cKp0i4Y++avqqpPseR0Lhwdr8IeQoq50wWBGKJb9DDmuuR
	H0tX7I7t4o0E+G3Nbbq75qKrJnNzoiSuvEp4/yqUcHhoeEZvUrVoPmH0Sflwa7rr7wOjCMC9kLg
	zjB+EX7VONeze7g0CAdnu0lj4GrYpppIWPZVjwwAaFprNulM4w0FeVnpLUtaUGdYWJV5TCPdSic
	TzrW5tWesgXhCvk
X-Received: by 2002:a17:90a:dfcc:b0:380:f389:447b with SMTP id 98e67ed59e1d1-396d0fd3a24mr48514295a91.11.1788224657525;
        Mon, 31 Aug 2026 18:04:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d49e9e0sm2372024a91.11.2026.08.31.18.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:04:16 -0700 (PDT)
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
Subject: [PATCH v3 02/21] rust: create basic untrusted data API
Date: Tue,  1 Sep 2026 11:03:28 +1000
Message-ID: <20260901010347.2614656-3-alistair.francis@wdc.com>
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
index 4d5c96ddc49c..239f8325b40a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -143,6 +143,7 @@
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
2.55.0

