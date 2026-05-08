Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162272E5B2D
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210253; cv=none; b=Pdj/OUQF0zKf6NT/8r1JtJXvnm0MuHrGyyzEioub2mhtdVMirZ/qEW4aAcdOhPJoEZniJZxBBrPjO0y+mhswqjGs8Y85hkKtgZjeTvroGPxtKxnr88iGHKGIalw74eBL8H3J83D4KZMwIOAAHSkUjMnHg1M/3eZoKpYPQbFr7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210253; c=relaxed/simple;
	bh=LQg/AZA7eVbbVVKpeO2cgjGa7sODOFzfELG435RZYi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfZ7cUZxVet1zd7HYjpuMnncfn/V0qK6VyflvJ2+UQCb2Oo0pNmZB1RJaF6Dgb5MZMiY/wXN49kB5t6SzIEQnw9zy1O8Vfd/0VZ0FwAqOjSdnEZ3EeiElhQuSprOCus0jjUppZAZd8241D9vlEQPMY9FEoh2eO9mq4lnc0RxTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG3M7B5A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG3M7B5A"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b4583f0a1aso9816545ad.3
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210250; x=1778815050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJurxHK2KR6NiQggIlFIcPfQ0S77CgxMQQO4qIElRQ0=;
        b=mG3M7B5AG2HIaWiWqfJ7HuVkeIrqIhufKNONt2eIIukdKvdpb7YGtiCq/7/4tyj3Op
         N1Do0dHLoXhXEKZh1P0XaLEYg6s9XTZ2TBY6wPnmA+PiqlFBcUg+hEqXkqbv06a8EIuS
         nENLeHcjjWxTeWFEG0NRu0pNPTH03A21C/S8ZQpPwUmz/3cLAnRNbdEy8a3zhiyb5za0
         CANh7riiJZp5cWEn38OFEaRJfyJuPWl8W33mZA3lxPD0YA21aCxEMxWYFd7JgaHgHUex
         0j2t/KGR75lFjvi+iMMZvNamZezEbh3jP7QchpXlZ4ORs3R+P5hBLzC4KFeqqkpSJ1hd
         XYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210250; x=1778815050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJurxHK2KR6NiQggIlFIcPfQ0S77CgxMQQO4qIElRQ0=;
        b=P9lJmV5nqZayCBs76ySygSzlKfUoch3Hj4/mIG20mPpbiTyLn4dJ+2FoisNSAajxNe
         8qcrjHC++3Ui9dXX4gaOiYpP/xLMTQPVHYdHU1r8Ssgf2mdsgXSEyjo4P42xzLRFwpFO
         tmvXfg3zQ0vhoXODuaRf2yUzw7DNrNL+7pzd8DonoEwL61R13aInPokgTKEmgKn1k7RQ
         4KrTv70O6bkVJkk4TV/bbzGp2EF7XPlr0hFrmxNao2voa08eis9ygiSDJEQc+q78rREw
         ILzL/L+EiyOZJedMHBjWrmd5CI1i+g2cRDxHOxpS6WQgnwKG3+m2ygMWk/megN05DYyK
         ymkg==
X-Forwarded-Encrypted: i=1; AFNElJ9MF83Gs0VKaCPfJO3OuZWz6UkZ7Y9vKHYLrPwycOsD7lqGjk3UcLfTPFzltLdagsAy0jhiKeX48qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+zg8IUqqIP/UedA4Hps/qwlY9ItLAj0fbRsviJOwekujH6or
	nxbB6cXUl5AJ68/8liWqNzusRcdeEgBGXxICtnk67R6TvD88e+0NIPnA
X-Gm-Gg: Acq92OHhV39XTIdB2X+tBCVAGM43o9wicld4Y+x71RTQlWkDONW3z1Bl+sgmDkEu7eS
	vpJYxj80EbYC4dzUbh8jOh4FFpX+PoAzoRNIX9avtaQVRMhY/ZlJ5Ka1mdnvS4QU2Tvyxvs5Ql/
	pKNltgdapFIsmYnnvWV711mUqzA5nWQgQntO9mYDfp+GODbxS+NFXsJjKmP/pSEcovYh+r6Jb7h
	vbiLNJXqHZZc4xG4ebVDzN7Pk7A96MhT3iSeqduhhoade2nQ3QuChQl33QePmhpagXjAsdGRTOx
	AAgdikW0IvROOKyV/Zm2aMm2EDvpH500xIe3tDMh9Ke6mSwfl9X8N1Ef1hqE1VMVuWQ+UvI5sOx
	0Nge0qiOWQhyywJ+phYTCAcwzKlhifFTBmeTVUbplAjk5gt1uRfXxKp28KUVLeORlPE0fHi18J+
	cUv5SUbDnOIPsFjwBkbgJwXjmIqJFHSlT0999j42s0
X-Received: by 2002:a17:902:f08a:b0:2b9:8ee1:73ac with SMTP id d9443c01a7336-2ba78e3f13fmr68717545ad.11.1778210250078;
        Thu, 07 May 2026 20:17:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:17:29 -0700 (PDT)
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
	alistair23@gmail.com,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH 01/18] rust: add untrusted data abstraction
Date: Fri,  8 May 2026 13:16:53 +1000
Message-ID: <20260508031710.514574-2-alistair.francis@wdc.com>
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
index b72b2fbe046d..fe580fde609f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -133,6 +133,7 @@
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

