Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFFD43DA50;
	Wed,  8 Jul 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513417; cv=pass; b=q8rHElNfi0BfYRq+pBwSHujtUHieH4nVQ21/JYznAF2VLz/s6/ZK5+ivRImNXItQEKmnt8AaN1x8Hi8mWVvPQLkNE5Y6OmkaquzpOZSjJZ+Z0gOFcfRAkZ5IJ6PiBEnzrUSGghtF0k6fORrOtR5rGZbE/+d6BsBqkSQJS7+oN+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513417; c=relaxed/simple;
	bh=8SAa2e7iupLurhRilDkBkFWovq0PL38k2YJCr75gcfo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n+tccWZOv07H1ri/C0homPlcQaqX2p6NNob1hi3A06h+ewg8q8uKQv0EePaIektfNuhZnAyjD8PtbctGIpIopJP3KywnlReKhSjl0wv8jc/QkGBGLV+oq6TR5rLnhyMtxv4QvJtwrWnWMpdpTwDnsmNcNGaClPvZnN9ztPHmGXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ESZxBkzq; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ESZxBkzq"
ARC-Seal: i=1; a=rsa-sha256; t=1783513382; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KmWcnKzZTM2HpwSs+20JHKwKYN+FC9ZvcBXkAiJm1qkxaeeHjfddKTQlQw/7mUgA0EJ3riu0rKiwuKO7D2hFFpsXRrpkPfnDQ75KdJx8R7tF/3iC3wqnO3zCrJBrcEGKff5KXMfM0Yi3CG7IdxZJCvfKTZYjAsa6YKL6QILehMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783513382; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rDex9A1n2fSjeQf1stLpqjUWTbdQC9qSK9Rh1huGF/s=; 
	b=OC3BM2g9Q1DKUk5vFXuHFUL2AyqnoLP2Umn8exQYZT0CYoAWN+3B+SyEnughrqxkJ05teuxSyFZSRMPAnsQF7ZxekzmmwpTMvNwCliecc+MUvBDWe4lOiFx+wGAL8ZfgwBcoEL2waZMkVfGBmE90jxLdc00qwrqMVqx5WOXckZw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783513382;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rDex9A1n2fSjeQf1stLpqjUWTbdQC9qSK9Rh1huGF/s=;
	b=ESZxBkzqA+Qd94MjQ0d6uoHyfroLZx+g15ox0/0S7cHA4bs+eCdUNNCPcqlxwlQ2
	J7JF4+1DdzZso8EJt5AjzBY1r8caZDbtg5ZhkW8K/jFTNfKrG393GVOe4c+puYDOK4S
	5U7sTwR3yq+Iy8eNWAjR0fKe8lUNV9p6d81xJ6lk=
Received: by mx.zohomail.com with SMTPS id 1783513380950428.34528060883395;
	Wed, 8 Jul 2026 05:23:00 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-5-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 09:22:39 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E91DF0B-6753-4584-BC15-08CE0211E5B3@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-5-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Conceptually, `MmioRaw` is just `__iomem *`, so it should work for any
> types. Update the existing use case where it represents a region of
> compile-time known minimum size and run-time known actual size to use =
the
> dynamic-sized type `Region<SIZE>` instead. Rename `maxsize` method to
> reflect that it is the actual size (not a bound) of the region.
>=20
> Implement `Clone` and `Copy` manually, which cannot be derived due to =
the
> generic parameter. The use of raw pointers also cause the `Send` and =
`Sync`
> auto trait implementation to be lost, so add them back by manual
> implementation.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/devres.rs |  7 +++---
> rust/kernel/io.rs     | 67 =
+++++++++++++++++++++++++++++++++++++--------------
> rust/kernel/io/mem.rs |  5 ++--
> rust/kernel/pci/io.rs |  4 +--
> 4 files changed, 57 insertions(+), 26 deletions(-)
>=20
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index ed30ccc6e68e..d0c677fd7932 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -70,14 +70,15 @@ struct Inner<T> {
> ///         Io,
> ///         Mmio,
> ///         MmioRaw,
> -///         PhysAddr, //
> +///         PhysAddr,
> +///         Region, //
> ///     },
> ///     prelude::*,
> /// };
> /// use core::ops::Deref;
> ///
> /// // See also [`pci::Bar`] for a real example.
> -/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
> +/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
> ///
> /// impl<const SIZE: usize> IoMem<SIZE> {
> ///     /// # Safety
> @@ -92,7 +93,7 @@ struct Inner<T> {
> ///             return Err(ENOMEM);
> ///         }
> ///
> -///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
> +///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
> ///     }
> /// }
> ///
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 9f060dd29182..12be266d7ed7 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -88,37 +88,67 @@ fn size(p: *const Self) -> usize {
>=20
> /// Raw representation of an MMIO region.
> ///
> +/// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
> +///
> /// By itself, the existence of an instance of this structure does not =
provide any guarantees that
> /// the represented MMIO region does exist or is properly mapped.
> ///
> /// Instead, the bus specific MMIO implementation must convert this =
raw representation into an
> /// `Mmio` instance providing the actual memory accessors. Only by the =
conversion into an `Mmio`
> /// structure any guarantees are given.
> -pub struct MmioRaw<const SIZE: usize =3D 0> {
> -    addr: usize,
> -    maxsize: usize,
> +pub struct MmioRaw<T: ?Sized> {
> +    /// Pointer is in I/O address space.
> +    ///
> +    /// The provenance does not matter, only the address and metadata =
do.
> +    ptr: *mut T,
> }
>=20
> -impl<const SIZE: usize> MmioRaw<SIZE> {
> -    /// Returns a new `MmioRaw` instance on success, an error =
otherwise.
> -    pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
> -        if maxsize < SIZE {
> -            return Err(EINVAL);
> +impl<T: ?Sized> Copy for MmioRaw<T> {}
> +impl<T: ?Sized> Clone for MmioRaw<T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +// SAFETY: `MmioRaw` is just an address, so is thread-safe.
> +unsafe impl<T: ?Sized> Send for MmioRaw<T> {}
> +// SAFETY: `MmioRaw` is just an address, so is thread-safe.
> +unsafe impl<T: ?Sized> Sync for MmioRaw<T> {}
> +
> +impl<T> MmioRaw<T> {
> +    /// Create a `MmioRaw` from address.
> +    #[inline]
> +    pub fn new(addr: usize) -> Self {
> +        Self {
> +            ptr: core::ptr::without_provenance_mut(addr),
>         }
> +    }
> +}
>=20
> -        Ok(Self { addr, maxsize })
> +impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
> +    /// Create a `MmioRaw` representing a I/O region with given size.
> +    ///
> +    /// The size is checked against the minimum size specified via =
const generics.
> +    #[inline]
> +    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
> +        Ok(Self {
> +            ptr: =
Region::ptr_try_from_raw_parts_mut(core::ptr::without_provenance_mut(addr)=
, size)?,
> +        })
>     }
> +}
>=20
> +impl<T: ?Sized + KnownSize> MmioRaw<T> {
>     /// Returns the base address of the MMIO region.
>     #[inline]
>     pub fn addr(&self) -> usize {
> -        self.addr
> +        self.ptr.addr()
>     }
>=20
> -    /// Returns the maximum size of the MMIO region.
> +    /// Returns the size of the MMIO region.
>     #[inline]
> -    pub fn maxsize(&self) -> usize {
> -        self.maxsize
> +    pub fn size(&self) -> usize {
> +        KnownSize::size(self.ptr)
>     }
> }
>=20
> @@ -143,12 +173,13 @@ pub fn maxsize(&self) -> usize {
> ///         Mmio,
> ///         MmioRaw,
> ///         PhysAddr,
> +///         Region,
> ///     },
> /// };
> /// use core::ops::Deref;
> ///
> /// // See also `pci::Bar` for a real example.
> -/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
> +/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
> ///
> /// impl<const SIZE: usize> IoMem<SIZE> {
> ///     /// # Safety
> @@ -163,7 +194,7 @@ pub fn maxsize(&self) -> usize {
> ///             return Err(ENOMEM);
> ///         }
> ///
> -///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
> +///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
> ///     }
> /// }
> ///
> @@ -193,7 +224,7 @@ pub fn maxsize(&self) -> usize {
> /// # }
> /// ```
> #[repr(transparent)]
> -pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
> +pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);
>=20
> /// Checks whether an access of type `U` at the given `base` and the =
given `offset`
> /// is valid within this region.
> @@ -840,7 +871,7 @@ fn addr(self) -> usize {
>     /// Returns the maximum size of this mapping.
>     #[inline]
>     fn maxsize(self) -> usize {
> -        self.0.maxsize()
> +        self.0.size()
>     }
> }
>=20
> @@ -851,7 +882,7 @@ impl<const SIZE: usize> Mmio<SIZE> {
>     ///
>     /// Callers must ensure that `addr` is the start of a valid I/O =
mapped memory region of size
>     /// `maxsize`.
> -    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
> +    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
>         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
>         unsafe { &*core::ptr::from_ref(raw).cast() }
>     }
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index fc2a3e24f8d5..9e15bc8fde78 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
> @@ -229,7 +229,7 @@ fn deref(&self) -> &Self::Target {
> /// start of the I/O memory mapped region.
> pub struct IoMem<'a, const SIZE: usize =3D 0> {
>     dev: &'a Device<Bound>,
> -    io: MmioRaw<SIZE>,
> +    io: MmioRaw<super::Region<SIZE>>,
> }
>=20
> impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
> @@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: =
&Resource) -> Result<Self> {
>             return Err(ENOMEM);
>         }
>=20
> -        let io =3D MmioRaw::new(addr as usize, size)?;
> -
> +        let io =3D MmioRaw::new_region(addr as usize, size)?;
>         Ok(IoMem { dev, io })
>     }
>=20
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 505305cd9b86..42f840d64a6f 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -139,7 +139,7 @@ fn maxsize(self) -> usize {
> /// memory mapped PCI BAR and its size.
> pub struct Bar<'a, const SIZE: usize =3D 0> {
>     pdev: &'a Device<device::Bound>,
> -    io: MmioRaw<SIZE>,
> +    io: MmioRaw<crate::io::Region<SIZE>>,
>     num: i32,
> }
>=20
> @@ -179,7 +179,7 @@ pub(super) fn new(
>             return Err(ENOMEM);
>         }
>=20
> -        let io =3D match MmioRaw::new(ioptr, len as usize) {
> +        let io =3D match MmioRaw::new_region(ioptr, len as usize) {
>             Ok(io) =3D> io,
>             Err(err) =3D> {
>                 // SAFETY:
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

