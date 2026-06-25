Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C933CE084
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383092; cv=none; b=RomZiNiFQiCZmq8GGu0mn3803r5wpWYXEVF3XNiiJCO/AiiN85Mh+nIn8g6FQr/Ok6gMSsR7tVv0kgQy676NEyz7H6mQeKQnKQWFefHdFxSJwMgtutSwrVTnQ10ZFbnyKBlHuIkmOM4+h1O0kVAlLSMfmg6Rau63vb/PHWotrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383092; c=relaxed/simple;
	bh=QpqfnuwPSXiP8bCod1M0ff+F9XULf05Yt/u/kKE/tB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jmrqAczkfRfCCibRQMROSsEuFNrPGZBCfc+VMZjw8MD6Stpj5UJxn4+bTLjGCAW0juEgNwLYgv3UQB3GgdncIFeQNFZtDB0gUOXWJTmLbn0vnVUs+hiTF63iPM0KBQnjOjeS0Eb04rV5VEJyF7RX1+h8UEdAwju5S/TIFoQyMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtEkDdSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtEkDdSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7611D1F000E9;
	Thu, 25 Jun 2026 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782383090;
	bh=XgcLaOYSJXOSoKIgK+5szZRo7Z+bf+uz3aO2rvxCZhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AtEkDdSJ26lb5k/yO8CdxVH0/4icpnta9lVhUGyysB3Gl/HHCiH1DiJP3Ul3m7CP7
	 3v0F8hnS9BAi7ou7RdqZr89WLTCvryN8apCa3C0/iDnuY76BDlbjLKgump9cN0Sxp0
	 Ft5j05YiyzSaU0pwkjFT7RJkxdmN/5vBmgYWGUCqYbI9k5jHUdU36AJxijzaIEEKsO
	 Zri8eF9GQZZj8yuvRdgF7rQvjOY3sC9R54Mt6Qx2HT7lU4EXxembKJ440tDVdTKLnN
	 LogFs2FsT0fSChssmrS4uuDwj+93vwa3nwN19v9QIFYgZiJrwFKnAUD36fVzU5h04q
	 7CdY6w/9CceJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 2/8] rust: types: Add Ownable/Owned types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260625-unique-ref-v18-2-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-2-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:24:49 +0000
Message-Id: <20260625102450.7611D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `Owned<T>` unconditionally structurally pins `T` by exposing `Pin<=
&mut T>`, but its API lacks the necessary documentation and safety bounds t=
o enforce the pinning invariants. Specifically, `Owned::from_raw(ptr)` take=
s ownership without requiring the caller to promise the memory is or can be=
 pinned; `Owned::into_raw(me)` safely extracts the pointer without document=
ing that the returned pointer's referent is still pinned; and `Ownable::rel=
ease(this)` doesn't forbid the implementer from moving the pinned `Self` be=
fore dropping it. This omission allows an `Ownable` implementer or a user c=
orrectly following the explicit safety contracts to accidentally move a pin=
ned `!Unpin` type, resulting in undefined behavior.
--

commit b7329ea2c0525ffa6a63171ede0921ad2e6a23e5
Author: Asahi Lina <lina+kernel@asahilina.net>

rust: types: Add Ownable/Owned types

This commit introduces Ownable and Owned types for unique owned pointers
with custom drop logic. These types allow C-allocated objects owned by Rust
to be freed through the C API. It also updates documentation and adds usage
examples.

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asah=
ilina.net/

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> new file mode 100644
> index 0000000000000..7fe9ec3e55126
> --- /dev/null
> +++ b/rust/kernel/owned.rs
[ ... ]
> +pub trait Ownable {
> +    /// Tear down this `Ownable`.
> +    ///
> +    /// Implementers of `Ownable` can use this function to clean up the =
use of `Self`. This can
> +    /// include freeing the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that they have exclusive ownership of the `S=
elf` pointed to by `this`,
> +    /// and that this ownership is transferred to the `release` method. =
`this` must not be used
> +    /// after calling this method, as the underlying object may have bee=
n freed.
> +    unsafe fn release(this: NonNull<Self>);

[Severity: High]
Since Owned<T> treats T as pinned (exposing Pin<&mut T> via as_pin_mut()),
should the safety contract here also require that implementers treat `this`
as pointing to pinned memory?

If an implementer moves the value during cleanup (for example, by reading it
onto the stack), it could violate the pinning guarantees for !Unpin types a=
nd
cause memory corruption due to self-reference invalidation.

> +}
[ ... ]
> +impl<T: Ownable> Owned<T> {
> +    /// Creates a new instance of [`Owned`].
> +    ///
> +    /// This function takes over ownership of the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    /// - `ptr` points to a valid instance of `T`.
> +    /// - Until `T::release` is called, the returned `Owned<T>` exclusiv=
ely owns the underlying `T`.
> +    #[inline]
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {

[Severity: High]
Does this safety contract need to require that the pointer is permanently
pinned?

Because Owned<T> can expose a pinned mutable reference, callers should be
aware that they cannot assume the memory remains unpinned after calling this
function.

> +        // INVARIANT: By function safety requirement we satisfy the firs=
t invariant of `Self`.
> +        // We treat `T` as pinned from now on.
> +        Self { ptr }
> +    }
> +
> +    /// Consumes the [`Owned`], returning a raw pointer.
> +    ///
> +    /// This function does not drop the underlying `T`. When this functi=
on returns, ownership of the
> +    /// underlying `T` is with the caller.
> +    #[inline]
> +    pub fn into_raw(me: Self) -> NonNull<T> {

[Severity: High]
Since into_raw() safely strips the Owned wrapper, should there be
documentation stating that the caller remains bound by the pin invariant
established by Owned?

Without this, a caller might extract the pointer and safely move the
previously pinned object, resulting in undefined behavior.

> +        ManuallyDrop::new(me).ptr
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D2
