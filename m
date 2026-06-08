Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E1377EC5
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949642; cv=none; b=MO0kPdFYNJRrNk9FblPMnutIx4ItJnOhXfyVXXpn6j2DMWWhgD54SU7hKdysgymucZw8kadDeaziiqS0kvl5WVJ3puKj+yd7rRkCFdTBPiLdCTCiVM9+KNNVFyNAVaBt7GLBawZrOjI0Bfyq0UmEGmWakINqxiXgN/LYzKP6Vcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949642; c=relaxed/simple;
	bh=pOy7kZ0vOClrRQanPVE1/w9f9DcFrgO8FdqyvQrz+qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dL/GhOfFqXkm1DSWfZwJfDqFpp3OTPK1ra4hY42SCwdwQu/2DRri8cl4FyIrRcwbH+ejjeGp7In4cu3Zk3ezicFk8ogm63YidNk6j/0XtDgtUp7sQCvhGbWQ6axtq+ZOMibxzmGcSXwQyErCINWmV45kwIoU6NpgReBDcpPhXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAFTumQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAFTumQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7147A1F00893;
	Mon,  8 Jun 2026 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949640;
	bh=8orBKRM4MAXgqBpW0aJAW+AhXYKRSn96Pqp90lBMjPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAFTumQbFMg1UbQeAB48dRU2RpivMu+c/ccKi4CkBlFowdeOCya4G5ztdP5l/P4L6
	 HBvhv4hZWYm3q6M0zGYu/x+s2J5z706IRvzsviy0sZ7OoOFP5/NDNv71EUdKkkgHYF
	 H2srw+tRGvj+nwJxzKhecI38c2wSsf1vJoLOjRjLB3aKESg+MSfD7vTpKrj9bTk+YT
	 UA3rIG6SMhJvc77eixUTq+JDchydgPdfpDzO1xgLbGQ7UwVectWselDNBCkBLx2xOr
	 nZ/VXxjn9y2bAr1qH16VwgxOtbFfiX0kRetYJ15MqpCaLIITDYVbBxH/gbE98y32im
	 /lY4PuGMyI/+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/19] rust: io: add projection macro and methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-12-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-12-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:13:59 +0000
Message-Id: <20260608201400.7147A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unsound `AsBytes` implementation for `Region<SIZE>` leading to und=
efined behavior due to alignment padding.
- [Low] Incorrect use of `#[inline(always)]` on `ProjectHelper` methods, vi=
olating subsystem coding guidelines.
--

commit ab6f2e99706c5568aaec1a417178b7f6d1435b90
Author: Gary Guo <gary@garyguo.net>

rust: io: add projection macro and methods

Add a io_project!() macro allows projection from Io to a subview of it,
using the pointer projection mechanism to perform compile-time checks.
For cases where type-casting is required, the try_cast() function may be
used where the size and alignment checks are performed at runtime.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 9c2ea17ca87b5..173f8c0ba2d6c 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
[ ... ]
> @@ -92,6 +96,11 @@ fn size(p: *const Self) -> usize {
>      }
>  }
> =20
> +// SAFETY: I/O regions can compose of arbitrary bytes.
> +unsafe impl<const SIZE: usize> kernel::transmute::FromBytes for Region<S=
IZE> {}
> +// SAFETY: Values read from I/O are always treated as initialized.
> +unsafe impl<const SIZE: usize> kernel::transmute::AsBytes for Region<SIZ=
E> {}

[Severity: High]
Does this implementation of AsBytes for Region<SIZE> introduce undefined
behavior due to alignment padding?

Region<SIZE> is defined with an alignment constraint and contains an
unsized [u8] field. Because core::mem::size_of_val for dynamically sized
types rounds the size up to a multiple of the alignment, a Region created
with a size that is not a multiple of 8 (on 64-bit systems) will include
trailing padding bytes.

Since AsBytes::as_bytes() relies on size_of_val(self) to slice the memory,
calling it on &Region<SIZE> could produce a &[u8] that extends past the
actual allocated length into out-of-bounds or uninitialized memory.

> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
[ ... ]
> @@ -983,3 +1039,78 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
>  // MMIO regions on 64-bit systems also support 64-bit accesses.
>  #[cfg(CONFIG_64BIT)]
>  impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_rel=
axed);
> +
> +// This helper turns associated functions to methods so it can be invoke=
d in macro.
> +// Used by `io_project!()` only.
> +#[doc(hidden)]
> +#[derive(Clone, Copy)]
> +pub struct ProjectHelper<T>(pub T);
> +
> +impl<'a, T> ProjectHelper<T>
> +where
> +    T: Io<'a, Backend: IoBackend<View<'a, T::Target> =3D T>>,
> +{
> +    // These helper methods must not have symbols present in binary to a=
void confusion.
> +    #[inline(always)]
> +    pub fn as_ptr(self) -> *mut T::Target {

[Severity: Low]
This isn't a bug, but should this use #[inline] instead of #[inline(always)=
]?

According to the rust subsystem guidelines, functions that are small or
forwarding to a binding call in abstractions should be annotated with
#[inline].

The #[inline(always)] annotation should be reserved for functions using
build_assert!() that depend on function parameters.

> +        T::Backend::as_ptr(self.0)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Same as `IoBackend::project_view`
> +    #[inline(always)]
> +    pub unsafe fn project_view<U: ?Sized + KnownSize>(

[Severity: Low]
This isn't a bug, but should this use #[inline] instead of #[inline(always)=
]?

According to the rust subsystem guidelines, functions that are small or
forwarding to a binding call in abstractions should be annotated with
#[inline].

The #[inline(always)] annotation should be reserved for functions using
build_assert!() that depend on function parameters.

> +        self,
> +        ptr: *mut U,
> +    ) -> <T::Backend as IoBackend>::View<'a, U> {
> +        // SAFETY: Per safety requirement.
> +        unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D12
