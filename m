Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393B40F8CE;
	Tue, 28 Apr 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382574; cv=none; b=bMcQgiVJrL50D81ySjXKxCQ30v/rrJlBqCkOqx8Z5sauJysLj9L46KLKtoQJj2qecISTguSkC8x+eYdMGQL+BAt7+qIw5hJj/bfsOB10gOSFe5F5uqzNXCuq5YrT8YcS2ltF2A9UhOwPOjwlFt0DCaqVHYbQi3jjcNs9zxiF7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382574; c=relaxed/simple;
	bh=xpUP486qEQcMDxivqRAMP/WCORbARzcSsYegsQxfSjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BHJnqgkIbpVfQeDhRE9+3Kwp/b7GHbW8uu/C9G5HOeNag6ojfaV9crwAd4PfSdz/nsu2gtCznZEAz3JrkJx5L9OFC2+lm4jsfYAjUGltrDW3dv357PPlPjggKttPodgn5zlXkA8xnox4J6btWVRhICAkI9kmFts+j9Hjcg7etLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAtF5t8w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAtF5t8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55444C2BCB9;
	Tue, 28 Apr 2026 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382574;
	bh=xpUP486qEQcMDxivqRAMP/WCORbARzcSsYegsQxfSjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DAtF5t8wHhQqVtL+BjGfGFTBz+Ko4vNLAbLwK0WyO87uQyYHwzL8ZUfoOh7CZTMOE
	 pYjLVQwwo8y1Pj509k+/dXSFaD+zC4o7P5kEMeeYs9ged8uSmPP39zpgjXsvDpHDEX
	 DDTfwTyQEboGgoTZFU6bnwq8SZ+HH2yeWokUBCbxkVq1fEo0TuUOMXVJJgZcSxxxqA
	 rXiJ9pWFCrlLyBkxBtGJjM5vGSP7cq8QZARpKzwlCa09FETrme/ql2A3c4/FiPFpcv
	 DORv+1RZzBRYVmdGzG6QgTQfhhxdyS0sseqog4KYIzDYpTD7NlDQ2g2th8+KkuP03C
	 QjtzzyZW7K3Jw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Abdiel
 Janulgue
 <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 11/11] rust: io: add copying methods
In-Reply-To: <20260421-io_projection-v2-11-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-11-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 15:22:10 +0200
Message-ID: <87lde7p6d9.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> One feature that was lost from the old `dma_read!()` and `dma_write!()`
> when moving to `io_read!()` and `io_write!()` was the ability to read/write
> a large structs. However, the semantics was unclear to begin with, as there
> was no guarantee about their atomicity even for structs that were small
> enough to fit in u32. Re-introduces the capability in the form of copying
> methods.
>
>     dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
>     dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)
>
> The semantics for these are modelled after memcpy so user has clear
> expectation of lack of atomicity. As an additional benefit of this change,
> this now works for MMIO as well, which maps to `memcpy_{from,to}io`.
>
> For slices, which is unsized so the API above can't work, `copy_from_slice`
> and `copy_to_slice` were added to copy from/to normal memory, and
> `copy_from_io_slice` and `copy_to_io_slice` were added to copy from/to
> other `Io` regions. They're optimized if at least one end is mapped to
> system memory; if none are, the copy occurs with an intermediate stack
> buffer.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/dma.rs |   8 +-
>  rust/kernel/io.rs  | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 238 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index bbdeb117c145..307f5769ca0a 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -16,7 +16,8 @@
>      fs::file,
>      io::{
>          Io,
> -        IoCapable, //
> +        IoCapable,
> +        IoCopyable, //
>      },
>      prelude::*,
>      ptr::KnownSize,
> @@ -997,6 +998,11 @@ unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
>      u64
>  );
>  
> +// SAFETY: `Coherent` is mapped to CPU address space.
> +unsafe impl<T: ?Sized + KnownSize> IoCopyable for Coherent<T> {
> +    const IS_MAPPED: bool = true;
> +}
> +
>  impl<'a, B: ?Sized + KnownSize, T: ?Sized> crate::io::View<'a, Coherent<B>, T> {
>      /// Returns a DMA handle which may be given to the device as the DMA address base of
>      /// the region.
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index efcd7e6741d7..0b1ed68c0f9b 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
>  
> +use core::mem::MaybeUninit;
> +
>  use crate::{
>      bindings,
>      prelude::*,
> @@ -233,6 +235,55 @@ pub trait IoCapable<T> {
>      unsafe fn io_write(&self, value: T, address: *mut T);
>  }
>  
> +/// Trait indicating that an I/O backend supports memory copy operations.
> +///
> +/// # Safety
> +///
> +/// If [`IS_MAPPED`] is overridden to true, it must be correct per documentation.
> +pub unsafe trait IoCopyable {
> +    /// Whether the pointers for this I/O backend are in the CPU address space, and are coherently
> +    /// mapped.
> +    ///
> +    /// When this is true, it means that memory can be accessed with byte-wise atomic memory copy.
> +    const IS_MAPPED: bool = false;
> +
> +    /// Copy `size` bytes from `address` to `buffer`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - The range `[address..address + size]` must be within the bounds of `Self`.

We should probably specify what "bounds of `Self`" means here. It's not
the bounds of `Self`, it is the bounds of the memory region `Self`
represents.

> +    /// - `buffer` is valid for write for `size` bytes.
> +    #[inline]
> +    unsafe fn copy_from_io(&self, address: *mut u8, buffer: *mut u8, size: usize) {
> +        const_assert!(Self::IS_MAPPED);
> +
> +        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
> +        // SAFETY:
> +        // - `buffer` is valid for write for `size` bytes.
> +        // - `IS_MAPPED` guarantees `address` is in CPU address space, with safety requirements
> +        //   `address` is valid for read for `size` bytes.
> +        unsafe { bindings::memcpy(buffer.cast(), address.cast(), size) };
> +    }

You could just leave out the default impl and implement each case for
`Coherent<_>` and `Mmio<_>`. Do you expect more implementers that can
share the default impl?

> +
> +    /// Copy `size` bytes from `buffer` to `address`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - The range `[address..address + size]` must be within the bounds of `Self`.
> +    /// - `buffer` is valid for read for `size` bytes.
> +    #[inline]
> +    unsafe fn copy_to_io(&self, address: *mut u8, buffer: *const u8, size: usize) {
> +        const_assert!(Self::IS_MAPPED);
> +
> +        // Use `bindings::memcpy` instead of copy_nonoverlapping for volatile.
> +        // SAFETY:
> +        // - `IS_MAPPED` guarantees `address` is in CPU address space, with safety requirements
> +        //   `address` is valid for write for `size` bytes.
> +        // - `buffer` is valid for read for `size` bytes.
> +        unsafe { bindings::memcpy(address.cast(), buffer.cast(), size) };
> +    }
> +}
> +
>  /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
>  /// into.
>  ///
> @@ -841,6 +892,19 @@ unsafe fn io_write(&self, value: $ty, address: *mut $ty) {
>      writeq
>  );
>  
> +// SAFETY: `IS_MAPPED` is not overridden.
> +unsafe impl<T: ?Sized + KnownSize> IoCopyable for Mmio<T> {
> +    unsafe fn copy_from_io(&self, address: *mut u8, buffer: *mut u8, size: usize) {
> +        // SAFETY: Per safety requirement.
> +        unsafe { bindings::memcpy_fromio(buffer.cast(), address.cast(), size) };
> +    }
> +
> +    unsafe fn copy_to_io(&self, address: *mut u8, buffer: *const u8, size: usize) {
> +        // SAFETY: Per safety requirement.
> +        unsafe { bindings::memcpy_toio(address.cast(), buffer.cast(), size) };
> +    }
> +}
> +
>  impl<T: ?Sized + KnownSize> Io for Mmio<T> {
>      type Type = T;
>  
> @@ -1029,6 +1093,173 @@ pub fn write_val(&self, value: T) {
>      }
>  }
>  
> +impl<'a, IO: ?Sized, T> View<'a, IO, [T]> {
> +    /// Returns the length of the slice in number of elements.
> +    #[inline]
> +    pub fn len(self) -> usize {
> +        self.as_ptr().len()
> +    }
> +
> +    /// Returns `true` if the slice has a length of 0.
> +    #[inline]
> +    pub fn is_empty(self) -> bool {
> +        self.len() == 0
> +    }
> +}
> +
> +impl<T, IO: ?Sized + Io + IoCopyable> View<'_, IO, T> {
> +    /// Copy-read from I/O memory.
> +    ///
> +    /// There is no atomicity gurantee.

Please add examples for the public functions.

> +    #[inline]
> +    pub fn copy_read(self) -> T
> +    where
> +        T: FromBytes,
> +    {
> +        // Optimized path if I/O backend is CPU mapped.
> +        if IO::IS_MAPPED {
> +            // SAFETY:
> +            // - `IS_MAPPED` guarantees `self.ptr` is in CPU address space, with type invariants
> +            //   `self.ptr` is valid for read for `size` bytes.
> +            // - `T: FromBytes` guarantee that all bit patterns are valid.
> +            // - Using read_volatile() here so that race with hardware is well-defined.
> +            // - Using read_volatile() here is not sound if it races with other CPU per Rust
> +            //   rules, but this is allowed per LKMM.
> +            return unsafe { self.ptr.read_volatile() };
> +        }
> +
> +        let mut buf = MaybeUninit::<T>::uninit();
> +        // SAFETY:
> +        // - Per type invariants.
> +        // - `buf.as_mut_ptr()` is valid for write for `size_of::<T>()` bytes.
> +        unsafe {
> +            self.io
> +                .copy_from_io(self.ptr.cast(), buf.as_mut_ptr().cast(), size_of::<T>())
> +        };
> +        // SAFETY: T: FromBytes` guarantee that all bit patterns are valid.
> +        unsafe { buf.assume_init() }
> +    }
> +
> +    /// Write to I/O memory.
> +    ///
> +    /// There is no atomicity gurantee.
> +    #[inline]
> +    pub fn copy_write(self, value: T)
> +    where
> +        T: AsBytes,
> +    {
> +        // Optimized path if I/O backend is CPU mapped.
> +        if IO::IS_MAPPED {
> +            // SAFETY:
> +            // - `IS_MAPPED` guarantees `self.ptr` is in CPU address space, with safety requirements
> +            //   `self.ptr` is valid for write for `size` bytes.
> +            // - Using write_volatile() here so that race with hardware is well-defined.
> +            // - Using write_volatile() here is not sound if it races with other CPU per Rust
> +            //   rules, but this is allowed per LKMM.
> +            unsafe { self.ptr.write_volatile(value) };
> +            return;
> +        }
> +
> +        // SAFETY:
> +        // - Per type invariants.
> +        // - `&raw const value` is valid for read for `size_of::<T>()` bytes.
> +        unsafe {
> +            self.io
> +                .copy_to_io(self.ptr.cast(), (&raw const value).cast(), size_of::<T>())
> +        };
> +        core::mem::forget(value);
> +    }
> +}
> +
> +impl<IO: ?Sized + Io + IoCopyable> View<'_, IO, [u8]> {
> +    /// Copy bytes from slice to I/O memory.
> +    #[inline]
> +    pub fn copy_from_slice(self, data: &[u8]) {
> +        assert_eq!(self.len(), data.len());

Do you really want a panic here?


Best regards,
Andreas Hindborg


