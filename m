Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BD3E121B;
	Tue, 28 Apr 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366980; cv=none; b=PekDDXlxBo3IrytCaZmN16yLEhyhvXqL8RBnTedYspN/8I4MOTDJ3f+kR6brzYZPKYRyyHNpj/DsvfVJh2VySd94eR4Eg9NqxCQZO4gvR8hZ3KGZLdHhcMXm3g74aVKsQatzRc/IV9ZgKcINpkLNLKlgvNvYEA7mgJCqz7KdEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366980; c=relaxed/simple;
	bh=sMh3Q4aYjvxwlp3vAR4VOlGoadf0UJaonFkGF4Bi6tA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lHnlwRnX4Odku9zQtc7g8J+9nTVmyMK3ysC8Yxt1fi/KzT+p9nqaLbNNVbRRbjmbZB75jtcBdKa0zQq39rMibmBmKNO5S1gNAupde0dSUK5GmB3r+gJU+Si3YSgtNHmXPGNcQCpfvjsQOgmWWUaPbx5dI2+QIN4lgDvlvRhpim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFyKzykH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFyKzykH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52EEC2BCFB;
	Tue, 28 Apr 2026 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777366980;
	bh=sMh3Q4aYjvxwlp3vAR4VOlGoadf0UJaonFkGF4Bi6tA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aFyKzykHlwyNer/6emLE2w2vZjnqPDqkR3/CfY8qwjrtva/XCUC6Nn07Q5RUBwO7d
	 JkbUclwj6yjVCzRkbIP2TRiPg3pBDCtX6ey0Oeq4deHwe8j4iq5/bfjmhtxnK1Xzim
	 AzJSOqurqt3DLQ+rRUmitgFQix2R75s3BQoluqbDSf0AW+zn25wcMeVMxyASmx0xDy
	 03Xx+xdkdw0TBYmhlXPQ39U1hI02aLAR027MG1urY8LBdp8Ho5AP9GM23twbdRnRPH
	 zz4rC+T6gSBJJ/7nsQbbfyNEmNX1oQMQigb7CHYjWZi+etDNgeJf2X9H7SsaBw6rHi
	 Jo26Cu18ObL5A==
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
Subject: Re: [PATCH v2 03/11] rust: io: use pointer types instead of address
In-Reply-To: <20260421-io_projection-v2-3-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-3-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 09:12:05 +0200
Message-ID: <87a4unr22i.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> This carries the size information with the pointer type and metadata, makes
> it possible to use I/O projections and paves the way for IO view types.
>
> With this change, minimum size information becomes available through types;
> so `KnownSize::MIN_SIZE` can be used and `IoKnownSize` trait is no longer
> necessary. The trait is kept for compatibility and can be removed when
> users stop using it for bounds.
>
> PCI config space uses only offsets and not pointers like MMIO; for this
> null pointers (with proper size metadata) is used. This is okay as I/O
> trait impl and I/O projections can operate on invalid pointers, and for PCI
> config space we will only use address info and ignore the provenance.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/devres.rs |   2 +-
>  rust/kernel/io.rs     | 123 +++++++++++++++++++++-----------------------------
>  rust/kernel/io/mem.rs |   2 +-
>  rust/kernel/pci/io.rs |  74 ++++++++++++++++++------------
>  4 files changed, 99 insertions(+), 102 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 3e22c63efb98..ea86e9c62cdf 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -101,7 +101,7 @@ struct Inner<T> {
>  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>  ///     fn drop(&mut self) {
>  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
> +///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
>  ///     }
>  /// }
>  ///
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 0b9c97c0a1d7..1682f2a0d20d 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -105,8 +105,8 @@ pub fn new_region(addr: usize, size: usize) -> Result<Self> {
>  impl<T: ?Sized + KnownSize> MmioRaw<T> {
>      /// Returns the base address of the MMIO region.
>      #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.addr.addr()
> +    pub fn as_ptr(&self) -> *mut T {
> +        self.addr
>      }
>  
>      /// Returns the size of the MMIO region.
> @@ -166,7 +166,7 @@ pub fn size(&self) -> usize {
>  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>  ///     fn drop(&mut self) {
>  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
> +///         unsafe { bindings::iounmap(self.0.as_ptr().cast()); };
>  ///     }
>  /// }
>  ///
> @@ -217,14 +217,14 @@ pub trait IoCapable<T> {
>      /// # Safety
>      ///
>      /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> -    unsafe fn io_read(&self, address: usize) -> T;
> +    unsafe fn io_read(&self, address: *mut T) -> T;
>  
>      /// Performs an I/O write of `value` at `address`.
>      ///
>      /// # Safety
>      ///
>      /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> -    unsafe fn io_write(&self, value: T, address: usize);
> +    unsafe fn io_write(&self, value: T, address: *mut T);
>  }
>  
>  /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
> @@ -291,23 +291,35 @@ fn offset(self) -> usize {
>  /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
>  /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
>  pub trait Io {
> -    /// Returns the base address of this mapping.
> -    fn addr(&self) -> usize;
> +    /// Type of this I/O region. For untyped I/O regions, [`Region`] type can be used.
> +    type Type: ?Sized + KnownSize;
> +
> +    /// Returns the base pointer of this mapping.
> +    ///
> +    /// This is a pointer to capture metadata. The specific meaning of the pointer depends on
> +    /// I/O backend and is not necessarily valid.
> +    fn as_ptr(&self) -> *mut Self::Type;
> +
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.
> +    // Always inline to optimize out error path of `build_assert`.
> +    #[inline(always)]
> +    fn io_addr_assert<U>(&self, offset: usize) -> *mut U {
> +        build_assert!(offset_valid::<U>(offset, Self::Type::MIN_SIZE));

Consider renaming this function `io_addr_build_assert` for clarity.

At any rate:

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg


