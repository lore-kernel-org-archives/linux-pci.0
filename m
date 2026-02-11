Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA85344D9D
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2026 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780598; cv=none; b=MEqH5iNyuci/TDQ9CPYYv6lZVop0qGI1vtaHFfXOtjeIJDUNkviHJduPWPUeb9FDWRzOpNZhjeJz/TKinbRYm5g0r1hR1mr/9fbYjIgtqcxwkjOtmFhrhUW/MNo9BIFuFbigiee6lMVen6I+a9shO1WookAne+6l7TCKdM7O9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780598; c=relaxed/simple;
	bh=s85C2OKbKyG80Gcr37rqh3lRTMRzMhKOlhnVwYinKmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/M7f7aZdu5cq4p9QYhAIbXXwMnZWPAQUDX7uaqMmfwPb6+S8PmthIynAxcPdJbpfpkVJ9Cu/JzdTCMhONNA3+aKfYpRF1iNzPDC+a9CWWminP3c5VkUf+/tgvR3xcZTvEM7yFE8xBpKIGT08+tVqmizeBns1ixbvM2SK5B8ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je8ICFxC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je8ICFxC"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so731671b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780593; x=1771385393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3JSMx43NpMgl9bRcYgyX8dtvUWeN3vQot3jC8EV0N4=;
        b=Je8ICFxCSo7Mny16fvuG9JIfGZKxjcJBLvp55eRv2reQQuLw0OWxUla9snJfB8+JmJ
         E0wj7Xs6vtwEmswuqb/16RescIFQOt/4RHZDXLq92aC396CtEnodaAigPAT8Jg3ax2Vz
         zhS5IlqeI20DsIkUhbSVF0z0044g85ebh+/BR1ofvmZXzlhX3J9lNtkibXHubLi36DHX
         6zozR56q5rxVyCejsm7dnlkatGiDu6e7REdgPCQHJlzGGPV6Ph94E9hWsVzlHvWyyUVW
         2nYBy9CCTqhy7+4TlEdm6WMv3JT2HXyJqPatE8eBt2mVjLvTpv3qfPdXVM7MWK/tMUEE
         J72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780593; x=1771385393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3JSMx43NpMgl9bRcYgyX8dtvUWeN3vQot3jC8EV0N4=;
        b=xGNEh+LEtlFNd9F3KznhhCQz4fRcB72t2QAU2MzFwBwbrrGzRT0HIL/ocbN/1BM5xy
         Zah2C/wxYuTcP8X95TlByH34UQ1IzvASkKn+Lp0DYiWGYBy44XPBc+siu6fMHoRXKMCU
         ejq2hdzmGxrx/pEbMFMDlK+Jf+I8p4qA0NvJHUXRnoilokSw2YayP3aQwCJ2/SbtbgdC
         jYVF9QHb32BoE9luYIrj+YBnpPXCREI9K0+9iRhDBdlKm6QRUa5/1+8RUvw3qp/ZKsBO
         otQmV6o6xKLUH5LM6/NG1BGJnITVNHp4Ctc31wODBUSUjHq3NoS6PV12p5byA3C5LxDR
         AErA==
X-Forwarded-Encrypted: i=1; AJvYcCW3JKpvKwxvNYIio6Ok3JqXA+ffkF79NDFPXcIis5h5Q2Jje1nIlKOAAFj3cfzkNVlrgn1sWjoM1JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYdyDOk8BQO83dZUx5rjce78/o/e/J9Zjkr2SHFH4E2adAoJJ
	s5/jDDggwpzIBGZHFSk64xTDWXKmlBQ8ytWcQ2AinybHwOaRHauD0DFq
X-Gm-Gg: AZuq6aLx8Y188bHQx5y8SfRLA8pKXwHWVdMHKG87YpuXqaU1szzqNpjmfrucAFBQ4Vp
	CYykHisQ+MsZCuYBvajr+b5wSPLZLBgO3bC9lC5gKTraKzQtW3yTNUnzZyLmf6lJ9hklbVzvYV/
	wBSdA8PJREXYWFMG5NJwZGgK3xmTdFbTQgWU4bLuTgp23W4GiyQpPywm11074w92Im2ZLUSdUe4
	TuggyuteY4nO3jodjz5HX1Apunsa28W+jcVhw/RlmdM4fTicUYQkaj34//qfGAFNI3XP4PFg+uK
	/YsMZ7bPNFrrMuJXlEc1KbN/zta7X61WTArd7C2oRZdrjqeSeOxyUpHt4/3BSHSNorZc9fP9V+F
	wCO8PNks/BOaP/4K8BdYvWPC7YCwOlyk9TvJ8J4FdZRDUdDcBbVgldOtuO7cYZ8ItfXIr5RibmJ
	NttKiV68pPIthJ5Gh9iOLyx7CAVi7x8d1jmMxbd/WsEA==
X-Received: by 2002:a05:6a21:9ccb:b0:38d:edd4:2fc7 with SMTP id adf61e73a8af0-393ad002927mr16562707637.26.1770780593127;
        Tue, 10 Feb 2026 19:29:53 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:29:52 -0800 (PST)
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
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [RFC v3 01/27] rust: add untrusted data abstraction
Date: Wed, 11 Feb 2026 13:29:08 +1000
Message-ID: <20260211032935.2705841-2-alistair.francis@wdc.com>
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

From: Benno Lossin <benno.lossin@proton.me>

When reading data from userspace, hardware or other external untrusted
sources, the data must be validated before it is used for logic within
the kernel. This abstraction provides a generic newtype wrapper
`Untrusted`; it prevents direct access to the inner type. The only way
to use the underlying data is to call `.validate()` on such a value.

Doing so utilizes the new `Validate` trait that is responsible for all
of the validation logic. This trait gives access to the inner value of
`Untrusted` by means of another newtype wrapper `Unvalidated`. In
contrast to `Untrusted`, `Unvalidated` allows direct access and
additionally provides several helper functions for slices.

Having these two different newtype wrappers is an idea from Simona
Vetter. It has several benefits: it fully prevents safe access to the
underlying value of `Untrusted` without going through the `Validate`
API. Additionally, it allows one to grep for validation logic by simply
looking for `Unvalidated<`.

Any API that reads data from an untrusted source should return
`Untrusted<T>` where `T` is the type of the underlying untrusted data.
This generic allows other abstractions to return their custom type
wrapped by `Untrusted`, signaling to the caller that the data must be
validated before use. This allows those abstractions to be used both in
a trusted and untrusted manner, increasing their generality.
Additionally, using the arbitrary self types feature, APIs can be
designed to explicitly read untrusted data:

    impl MyCustomDataSource {
        pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
    }

Cc: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Message-ID: <20240925205244.873020-2-benno.lossin@proton.me>
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/validate.rs | 605 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 606 insertions(+)
 create mode 100644 rust/kernel/validate.rs

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 696f62f85eb5..915499704405 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -154,6 +154,7 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+pub mod validate;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
new file mode 100644
index 000000000000..ae0aa20e27b4
--- /dev/null
+++ b/rust/kernel/validate.rs
@@ -0,0 +1,605 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for handling and validating untrusted data.
+//!
+//! # Overview
+//!
+//! Untrusted data is marked using the [`Untrusted<T>`] type. See [Rationale](#rationale) for the
+//! reasons to mark untrusted data throughout the kernel. It is a totally opaque wrapper, it is not
+//! possible to read the data inside; but it is possible to [`Untrusted::write`] into it.
+//!
+//! The only way to "access" the data inside an [`Untrusted<T>`] is to [`Untrusted::validate`] it;
+//! turning it into a different form using the [`Validate`] trait. That trait receives the data in
+//! the form of [`Unvalidated<T>`], which in contrast to [`Untrusted<T>`], allows access to the
+//! underlying data. It additionally provides several utility functions to simplify validation.
+//!
+//! # Rationale
+//!
+//! When reading data from an untrusted source, it must be validated before it can be used for
+//! logic. For example, this is a very bad idea:
+//!
+//! ```
+//! # fn read_bytes_from_network() -> Box<[u8]> {
+//! #     Box::new([1, 0], kernel::alloc::flags::GFP_KERNEL).unwrap()
+//! # }
+//! let bytes: Box<[u8]> = read_bytes_from_network();
+//! let data_index = bytes[0];
+//! let data = bytes[usize::from(data_index)];
+//! ```
+//!
+//! While this will not lead to a memory violation (because the array index checks the bounds), it
+//! might result in a kernel panic. For this reason, all untrusted data must be wrapped in
+//! [`Untrusted<T>`]. This type only allows validating the data or passing it along, since copying
+//! data from one userspace buffer into another is allowed for untrusted data.
+
+use crate::prelude::Init;
+use core::{
+    mem::MaybeUninit,
+    ops::{Index, IndexMut},
+    ptr, slice,
+};
+
+/// Untrusted data of type `T`.
+///
+/// When reading data from userspace, hardware or other external untrusted sources, the data must
+/// be validated before it is used for logic within the kernel. To do so, the [`validate()`]
+/// function exists and uses the [`Validate`] trait.
+///
+/// Also see the [module] description.
+///
+/// [`validate()`]: Self::validate
+/// [module]: self
+#[repr(transparent)]
+pub struct Untrusted<T: ?Sized>(Unvalidated<T>);
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
+        Self(Unvalidated::new(value))
+    }
+
+    /// Marks the value behind the reference as untrusted.
+    ///
+    /// # Examples
+    ///
+    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
+    /// a `foo_hardware_read` function that reads some data directly from the hardware.
+    /// ```
+    /// use kernel::{error, types::Opaque, validate::Untrusted};
+    /// use core::ptr;
+    ///
+    /// # #[allow(non_camel_case_types)]
+    /// # mod bindings {
+    /// #     pub(crate) struct foo_hardware;
+    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardware, _len: &mut usize) -> *mut u8 {
+    /// #         todo!()
+    /// #     }
+    /// # }
+    /// struct Foo(Opaque<bindings::foo_hardware>);
+    ///
+    /// impl Foo {
+    ///     fn read(&mut self, mut len: usize) -> Result<&Untrusted<[u8]>> {
+    ///         // SAFETY: just an FFI call without preconditions.
+    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
+    ///         let data = error::from_err_ptr(data)?;
+    ///         let data = ptr::slice_from_raw_parts(data, len);
+    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid for reads as long as the
+    ///         // `foo_hardware` object exists. That function updated the
+    ///         let data = unsafe { &*data };
+    ///         Ok(Untrusted::new_ref(data))
+    ///     }
+    /// }
+    /// ```
+    pub fn new_ref(value: &T) -> &Self {
+        let ptr: *const T = value;
+        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and contain a `T`.
+        let ptr = ptr as *const Self;
+        // SAFETY: `ptr` came from a shared reference valid for `'a`.
+        unsafe { &*ptr }
+    }
+
+    /// Marks the value behind the reference as untrusted.
+    ///
+    /// # Examples
+    ///
+    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
+    /// a `foo_hardware_read` function that reads some data directly from the hardware.
+    /// ```
+    /// use kernel::{error, types::Opaque, validate::Untrusted};
+    /// use core::ptr;
+    ///
+    /// # #[allow(non_camel_case_types)]
+    /// # mod bindings {
+    /// #     pub(crate) struct foo_hardware;
+    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardware, _len: &mut usize) -> *mut u8 {
+    /// #         todo!()
+    /// #     }
+    /// # }
+    /// struct Foo(Opaque<bindings::foo_hardware>);
+    ///
+    /// impl Foo {
+    ///     fn read(&mut self, mut len: usize) -> Result<&mut Untrusted<[u8]>> {
+    ///         // SAFETY: just an FFI call without preconditions.
+    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
+    ///         let data = error::from_err_ptr(data)?;
+    ///         let data = ptr::slice_from_raw_parts_mut(data, len);
+    ///         // SAFETY: `data` returned by `foo_hardware_read` is valid for reads as long as the
+    ///         // `foo_hardware` object exists. That function updated the
+    ///         let data = unsafe { &mut *data };
+    ///         Ok(Untrusted::new_mut(data))
+    ///     }
+    /// }
+    /// ```
+    pub fn new_mut(value: &mut T) -> &mut Self {
+        let ptr: *mut T = value;
+        // CAST: `Self` and `Unvalidated` are `repr(transparent)` and contain a `T`.
+        let ptr = ptr as *mut Self;
+        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
+        unsafe { &mut *ptr }
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> Result<V, V::Err> {
+        V::validate(&self.0)
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
+        &'a mut self,
+    ) -> Result<V, V::Err> {
+        V::validate(&mut self.0)
+    }
+
+    /// Sets the underlying untrusted value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// let mut untrusted = Untrusted::new(42);
+    /// untrusted.write(24);
+    /// ```
+    pub fn write(&mut self, value: impl Init<T>) {
+        let ptr: *mut T = &mut self.0 .0;
+        // SAFETY: `ptr` came from a mutable reference and the value is overwritten before it is
+        // read.
+        unsafe { ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` came from a mutable reference and the initializer cannot error.
+        match unsafe { value.__init(ptr) } {
+            Ok(()) => {}
+            Err(_) => unreachable!(),
+        }
+    }
+
+    /// Turns a slice of untrusted values into an untrusted slice of values.
+    pub fn transpose_slice(slice: &[Untrusted<T>]) -> &Untrusted<[T]>
+    where
+        T: Sized,
+    {
+        let ptr = slice.as_ptr().cast::<T>();
+        // SAFETY: `ptr` and `len` come from the same slice reference.
+        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
+        Untrusted::new_ref(slice)
+    }
+
+    /// Turns a slice of uninitialized, untrusted values into an untrusted slice of uninitialized
+    /// values.
+    pub fn transpose_slice_uninit(
+        slice: &[MaybeUninit<Untrusted<T>>],
+    ) -> &Untrusted<[MaybeUninit<T>]>
+    where
+        T: Sized,
+    {
+        let ptr = slice.as_ptr().cast::<MaybeUninit<T>>();
+        // SAFETY: `ptr` and `len` come from the same mutable slice reference.
+        let slice = unsafe { slice::from_raw_parts(ptr, slice.len()) };
+        Untrusted::new_ref(slice)
+    }
+
+    /// Turns a slice of uninitialized, untrusted values into an untrusted slice of uninitialized
+    /// values.
+    pub fn transpose_slice_uninit_mut(
+        slice: &mut [MaybeUninit<Untrusted<T>>],
+    ) -> &mut Untrusted<[MaybeUninit<T>]>
+    where
+        T: Sized,
+    {
+        // CAST: `MaybeUninit<T>` and `MaybeUninit<Untrusted<T>>` have the same layout.
+        let ptr = slice.as_mut_ptr().cast::<MaybeUninit<T>>();
+        // SAFETY: `ptr` and `len` come from the same mutable slice reference.
+        let slice = unsafe { slice::from_raw_parts_mut(ptr, slice.len()) };
+        Untrusted::new_mut(slice)
+    }
+}
+
+impl<T> Untrusted<MaybeUninit<T>> {
+    /// Sets the underlying untrusted value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// let mut untrusted = Untrusted::new(42);
+    /// untrusted.write(24);
+    /// ```
+    pub fn write_uninit<E>(&mut self, value: impl Init<T, E>) -> Result<&mut Untrusted<T>, E> {
+        let ptr: *mut MaybeUninit<T> = &mut self.0 .0;
+        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
+        let ptr = ptr.cast::<T>();
+        // SAFETY: `ptr` came from a reference and if `Err` is returned, the underlying memory is
+        // considered uninitialized.
+        unsafe { value.__init(ptr) }.map(|()| {
+            let this = self.0.raw_mut();
+            // SAFETY: we initialized the memory above.
+            Untrusted::new_mut(unsafe { this.assume_init_mut() })
+        })
+    }
+}
+
+impl<T> Untrusted<[MaybeUninit<T>]> {
+    /// Sets the underlying untrusted value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::validate::Untrusted;
+    ///
+    /// let mut untrusted = Untrusted::new(42);
+    /// untrusted.write(24);
+    /// ```
+    pub fn write_uninit_slice<E>(
+        &mut self,
+        value: impl Init<[T], E>,
+    ) -> Result<&mut Untrusted<[T]>, E> {
+        let ptr: *mut [MaybeUninit<T>] = &mut self.0 .0;
+        // CAST: `MaybeUninit<T>` is `repr(transparent)`.
+        let ptr = ptr as *mut [T];
+        // SAFETY: `ptr` came from a reference and if `Err` is returned, the underlying memory is
+        // considered uninitialized.
+        unsafe { value.__init(ptr) }.map(|()| {
+            let this = self.0.raw_mut().as_mut_ptr();
+            // CAST: `MaybeUninit<T>` is `repr(transparent)`.
+            let this = this.cast::<T>();
+            // SAFETY: `this` and `len` came from the same slice reference.
+            let this = unsafe { slice::from_raw_parts_mut(this, self.0.len()) };
+            Untrusted::new_mut(this)
+        })
+    }
+}
+
+/// Marks types that can be used as input to [`Validate::validate`].
+pub trait ValidateInput: private::Sealed + Sized {}
+
+mod private {
+    pub trait Sealed {}
+}
+
+impl<'a, T: ?Sized> private::Sealed for &'a Unvalidated<T> {}
+impl<'a, T: ?Sized> ValidateInput for &'a Unvalidated<T> {}
+
+impl<'a, T: ?Sized> private::Sealed for &'a mut Unvalidated<T> {}
+impl<'a, T: ?Sized> ValidateInput for &'a mut Unvalidated<T> {}
+
+/// Validates untrusted data.
+///
+/// # Examples
+///
+/// The simplest way to validate data is to just implement `Validate<&Unvalidated<[u8]>>` for the
+/// type that you wish to validate:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::{CStr, CString},
+///     validate::{Unvalidated, Validate},
+/// };
+///
+/// struct Data {
+///     flags: u8,
+///     name: CString,
+/// }
+///
+/// impl Validate<&Unvalidated<[u8]>> for Data {
+///     type Err = Error;
+///
+///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+///         let raw = unvalidated.raw();
+///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
+///         let name = CStr::from_bytes_with_nul(name)?.to_cstring()?;
+///         Ok(Data { flags, name })
+///     }
+/// }
+/// ```
+///
+/// This approach copies the data and requires allocation. If you want to avoid the allocation and
+/// copying the data, you can borrow from the input like this:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::CStr,
+///     validate::{Unvalidated, Validate},
+/// };
+///
+/// struct Data<'a> {
+///     flags: u8,
+///     name: &'a CStr,
+/// }
+///
+/// impl<'a> Validate<&'a Unvalidated<[u8]>> for Data<'a> {
+///     type Err = Error;
+///
+///     fn validate(unvalidated: &'a Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+///         let raw = unvalidated.raw();
+///         let (&flags, name) = raw.split_first().ok_or(EINVAL)?;
+///         let name = CStr::from_bytes_with_nul(name)?;
+///         Ok(Data { flags, name })
+///     }
+/// }
+/// ```
+///
+/// If you need to in-place validate your data, you currently need to resort to `unsafe`:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::CStr,
+///     validate::{Unvalidated, Validate},
+/// };
+/// use core::mem;
+///
+/// // Important: use `repr(C)`, this ensures a linear layout of this type.
+/// #[repr(C)]
+/// struct Data {
+///     version: u8,
+///     flags: u8,
+///     _reserved: [u8; 2],
+///     count: u64,
+///     // lots of other fields...
+/// }
+///
+/// impl Validate<&Unvalidated<[u8]>> for &Data {
+///     type Err = Error;
+///
+///     fn validate(unvalidated: &Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+///         let raw = unvalidated.raw();
+///         if raw.len() < mem::size_of::<Data>() {
+///             return Err(EINVAL);
+///         }
+///         // can only handle version 0
+///         if raw[0] != 0 {
+///             return Err(EINVAL);
+///         }
+///         // version 0 only uses the lower 4 bits of flags
+///         if raw[1] & 0xf0 != 0 {
+///             return Err(EINVAL);
+///         }
+///         let ptr = raw.as_ptr();
+///         // CAST: `Data` only contains integers and has `repr(C)`.
+///         let ptr = ptr.cast::<Data>();
+///         // SAFETY: `ptr` came from a reference and the cast above is valid.
+///         Ok(unsafe { &*ptr })
+///     }
+/// }
+/// ```
+///
+/// To be able to modify the parsed data, while still supporting zero-copy, you can implement
+/// `Validate<&mut Unvalidated<[u8]>>`:
+///
+/// ```
+/// use kernel::{
+///     error::{code::EINVAL, Error},
+///     str::CStr,
+///     validate::{Unvalidated, Validate},
+/// };
+/// use core::mem;
+///
+/// // Important: use `repr(C)`, this ensures a linear layout of this type.
+/// #[repr(C)]
+/// struct Data {
+///     version: u8,
+///     flags: u8,
+///     _reserved: [u8; 2],
+///     count: u64,
+///     // lots of other fields...
+/// }
+///
+/// impl Validate<&mut Unvalidated<[u8]>> for &Data {
+///     type Err = Error;
+///
+///     fn validate(unvalidated: &mut Unvalidated<[u8]>) -> Result<Self, Self::Err> {
+///         let raw = unvalidated.raw_mut();
+///         if raw.len() < mem::size_of::<Data>() {
+///             return Err(EINVAL);
+///         }
+///         match raw[0] {
+///             0 => {},
+///             1 => {
+///                 // version 1 implicitly sets the first bit.
+///                 raw[1] |= 1;
+///             },
+///             // can only handle version 0 and 1
+///             _ => return Err(EINVAL),
+///         }
+///         // version 0 and 1 only use the lower 4 bits of flags
+///         if raw[1] & 0xf0 != 0 {
+///             return Err(EINVAL);
+///         }
+///         if raw[1] == 0 {}
+///         let ptr = raw.as_ptr();
+///         // CAST: `Data` only contains integers and has `repr(C)`.
+///         let ptr = ptr.cast::<Data>();
+///         // SAFETY: `ptr` came from a reference and the cast above is valid.
+///         Ok(unsafe { &*ptr })
+///     }
+/// }
+/// ```
+pub trait Validate<I: ValidateInput>: Sized {
+    /// Validation error.
+    type Err;
+
+    /// Validate the given untrusted data and parse it into the output type.
+    fn validate(unvalidated: I) -> Result<Self, Self::Err>;
+}
+
+/// Unvalidated data of type `T`.
+#[repr(transparent)]
+pub struct Unvalidated<T: ?Sized>(T);
+
+impl<T: ?Sized> Unvalidated<T> {
+    fn new(value: T) -> Self
+    where
+        T: Sized,
+    {
+        Self(value)
+    }
+
+    fn new_ref(value: &T) -> &Self {
+        let ptr: *const T = value;
+        // CAST: `Self` is `repr(transparent)` and contains a `T`.
+        let ptr = ptr as *const Self;
+        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
+        unsafe { &*ptr }
+    }
+
+    fn new_mut(value: &mut T) -> &mut Self {
+        let ptr: *mut T = value;
+        // CAST: `Self` is `repr(transparent)` and contains a `T`.
+        let ptr = ptr as *mut Self;
+        // SAFETY: `ptr` came from a mutable reference valid for `'a`.
+        unsafe { &mut *ptr }
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate_ref<'a, V: Validate<&'a Unvalidated<T>>>(&'a self) -> Result<V, V::Err> {
+        V::validate(self)
+    }
+
+    /// Validates and parses the untrusted data.
+    ///
+    /// See the [`Validate`] trait on how to implement it.
+    pub fn validate_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
+        &'a mut self,
+    ) -> Result<V, V::Err> {
+        V::validate(self)
+    }
+
+    /// Gives immutable access to the underlying value.
+    pub fn raw(&self) -> &T {
+        &self.0
+    }
+
+    /// Gives mutable access to the underlying value.
+    pub fn raw_mut(&mut self) -> &mut T {
+        &mut self.0
+    }
+}
+
+impl<T, I> Index<I> for Unvalidated<[T]>
+where
+    I: slice::SliceIndex<[T]>,
+{
+    type Output = Unvalidated<I::Output>;
+
+    fn index(&self, index: I) -> &Self::Output {
+        Unvalidated::new_ref(self.0.index(index))
+    }
+}
+
+impl<T, I> IndexMut<I> for Unvalidated<[T]>
+where
+    I: slice::SliceIndex<[T]>,
+{
+    fn index_mut(&mut self, index: I) -> &mut Self::Output {
+        Unvalidated::new_mut(self.0.index_mut(index))
+    }
+}
+
+/// Immutable unvalidated slice iterator.
+pub struct Iter<'a, T>(slice::Iter<'a, T>);
+
+/// Mutable unvalidated slice iterator.
+pub struct IterMut<'a, T>(slice::IterMut<'a, T>);
+
+impl<'a, T> Iterator for Iter<'a, T> {
+    type Item = &'a Unvalidated<T>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.0.next().map(Unvalidated::new_ref)
+    }
+}
+
+impl<'a, T> IntoIterator for &'a Unvalidated<[T]> {
+    type Item = &'a Unvalidated<T>;
+    type IntoIter = Iter<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        Iter(self.0.iter())
+    }
+}
+
+impl<'a, T> Iterator for IterMut<'a, T> {
+    type Item = &'a mut Unvalidated<T>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.0.next().map(Unvalidated::new_mut)
+    }
+}
+
+impl<'a, T> IntoIterator for &'a mut Unvalidated<[T]> {
+    type Item = &'a mut Unvalidated<T>;
+    type IntoIter = IterMut<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        IterMut(self.0.iter_mut())
+    }
+}
+
+impl<T> Unvalidated<[T]> {
+    /// Returns the number of elements in the underlying slice.
+    pub fn len(&self) -> usize {
+        self.0.len()
+    }
+
+    /// Returns true if the underlying slice has a length of 0.
+    pub fn is_empty(&self) -> bool {
+        self.0.is_empty()
+    }
+
+    /// Iterates over all items and validates each of them individually.
+    pub fn validate_iter<'a, V: Validate<&'a Unvalidated<T>>>(
+        &'a self,
+    ) -> impl Iterator<Item = Result<V, V::Err>> + 'a {
+        self.into_iter().map(|item| V::validate(item))
+    }
+
+    /// Iterates over all items and validates each of them individually.
+    pub fn validate_iter_mut<'a, V: Validate<&'a mut Unvalidated<T>>>(
+        &'a mut self,
+    ) -> impl Iterator<Item = Result<V, V::Err>> + 'a {
+        self.into_iter().map(|item| V::validate(item))
+    }
+}
-- 
2.52.0

