Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679173515E9
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 01:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557917; cv=none; b=tPz3kgKpnL0MrouLUmNOTaQPqpFDD23UmZMwK6I68f7o68TFeq1+UC8biBw/hsDUAkjPF3stSq8bmEBGb5UQN1AqgdZ65cPgx1pGusB69tHy8BtshUeIx5pJoZ17Yg+/fXEUdNzRembfT9VTuss/SpYkBcnsba2F7QW8nn5n6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557917; c=relaxed/simple;
	bh=dsXzgnyl2UYn9dmtmBMnKODDz/19kF4yAulyuEd6BCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExyDLQ5h49rwYH09fdjTgOXGhPOLuwTXSmYrNZ7Xf7G+Yg0N/QbHcBroFLDqSOiTvs2FzEwmVnSmcwSSXqnnvcbG5YZBmeS/U/kH3hmNOjWsjmV72OPLd9y2AXx2A4NPbysyUqLiWy+WHTqw7v+uEu6tcifIwwcTdwjHsVIoaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdq4yN4m; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdq4yN4m"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1129113a91.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557915; x=1791162715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jLCB1A1F2wJgb//jZGOYxa8Pgyl9b3mGsSN4HtIriU=;
        b=Qdq4yN4mAQV8ptz4eXYAcPHrgeCSlJNDTLs4ff+R9oX6gOLH/j+IWPLR0AY/tPAVlV
         PK2+Ihf1bwEhD/V+pQGKDRwHbyzAx5OyUOoWePu1prwqm/IpEMLSD4aRyyTK4SkMU74D
         0v/o+K6uqt+tUBLuynVxrFoMBOozS3YkI4rd+BcExfb+j52FbJsPyxid/s9r5EOO3ew0
         ZB9to/l6U3vwWLJiZ7JdecwEazdPWX/ONnDVJTDSm3BiXWojgPI+ercz035nmm218IaK
         l2A+r0oeoeNlAtd28e8FLVVKcdEefWeZugMoIe/69sImjBhhLMG4wN4osp/H6VKILIaN
         Wc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557915; x=1791162715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jLCB1A1F2wJgb//jZGOYxa8Pgyl9b3mGsSN4HtIriU=;
        b=f+drHZWGm38BuRIkjdkSdVF8odj8Jmhw4gMhSBHd/ZwMe5aZF8NqpquxKarj6aV1ca
         lVUYOL0Q6yw2aIpiiaGS+OSb+ASqUvs0XoulV7EOE4MIGUcXMgwW87YXnwFoL1xeVcz8
         kGHFaw9We9BMWepY8kTzcq4mXhJQM2g+AY0aHEvcWAseG/TOsKffs0FukDuO83l3+Eej
         v+aVhMyWA2eC9m2hTDoL5COekVXs3/4Z4aN1I8nYHZtXJhdnG/fPdFUQuror6xnuHUd8
         bbZdazkWKHB+LDBcjHvqoMn1aSH4vbOmIvaDcFEAyu/EFo2ztBjiiq/yJpIKUoD4PtWX
         GQag==
X-Forwarded-Encrypted: i=1; AKwUvBxd7mpTXr643bLZUDDNjJgtZ/bRMjuc5bAIcW22YlmvtI/m+l1frGSBH+9E0wKaFBwEfHIENswTYL4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGSWobijUTSJ+X1CqLffRgnZ6v/l0SqDxusXgk5ayYekqhBwUF
	NfC0TV5+M+eI5Ixe2bD+yYFoVI2FynpPiyMgTC+XbPWCdTJyYwX9be2X
X-Gm-Gg: AYBFou1dam4y3oBoPKnrPBjEvKAAGD3dqM6HZk8l8hoMvUXjoL4AYyBJ57u4NVTQ4B+
	mwScfCWn5UrqstoRRmLLZiH6x8AjE3TkbMovB5kuUdwuTflCwf+iCIpna0CaR/c2JR6cJZhXTgS
	z1HhQtlNOEETIitCNFslXEg5kxLK86045yJ2nRU++EtJmk71Q5ytt/ixS0+uiT+Js8q3XmFSkLP
	rmv46sHQ56Zn0aVPlkEUEDl1pgkJk8L9XfvSzTjG8gc33yQH/cWbtC6gF3Cny6hQnhgL+BuYE8v
	4P6iqZj7Jp5fjv1NOi5rOVWkab+y2mUS6xeRROHKmvQvNXgsMXaeNSIqPYJUYFpMde/ogrpsq4L
	n7PWlVZLPPy0LH7f/ZP+SsEqvYNKptMtKXskPqDY2HLxBeXQGpNi0YjFM+mZyFBknhCzhwts/4o
	T/o9NZfOPBpI+FflExBiHCbVuHfl0bB6aLxraYNtE6pst/07U6lrUTqDXn6CGWz5QBrUAddAbiz
	YOKULayC3HPTtdC
X-Received: by 2002:a17:90b:5807:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3a0985bc669mr8736728a91.18.1790557914620;
        Sun, 27 Sep 2026 18:11:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:11:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 03/22] rust: create basic untrusted data API
Date: Mon, 28 Sep 2026 11:11:04 +1000
Message-ID: <20260928011123.450800-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
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
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/validate.rs | 147 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)
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
index 000000000000..ca2e5abda3e2
--- /dev/null
+++ b/rust/kernel/validate.rs
@@ -0,0 +1,147 @@
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
+    #[inline]
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
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`.
+        unsafe { cast_slice(&self.0) }
+    }
+}
+
+impl<T> DerefMut for Untrusted<[T]> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`.
+        unsafe { cast_slice_mut(&mut self.0) }
+    }
+}
+
+impl<T, A: Allocator> Deref for Untrusted<Vec<T, A>> {
+    type Target = [Untrusted<T>];
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`.
+        unsafe { cast_slice(self.0.as_slice()) }
+    }
+}
+
+impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: `Untrusted<T>` transparently wraps `T`.
+        unsafe { cast_slice_mut(self.0.as_mut_slice()) }
+    }
+}
-- 
2.55.0

