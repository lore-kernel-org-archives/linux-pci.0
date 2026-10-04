Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303B3B71A3
	for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2026 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116463; cv=none; b=hmfepmPHfTrOj2VSxzKXNQ16jQwsl++28y0yNH6lCFlV0qP9iQbI6xNsFPELsMnpIdUsr8eWfql4+TtOLA5T18sMo/81EY9Nn+cwwSfDVgZKmwSa62XG9qNU7vMm2FBbto2vEo4q63ZOTKj71yHT/IbF5m95xf8BdfKbg1tW42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116463; c=relaxed/simple;
	bh=UkjvYYjmmbHgKRr+vWt4M9yPNtWR22hkKxwdWenel+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qFsEc9IbsifVb16VfyNKXaqdhYp9219B2ydj+oqzvidj5Su3czW/2iz+ftYA31oy76OviHi/mjdP8CoS6Y+PfwdQNPW8mjl9VhdLXLfARLHEd8kbsrnHG045hZYVHTW835hrjFnUn2R9qhFIKRLLE+qZdvaXdtFqI0zRw+usjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdLEaMM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdLEaMM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847191F000FF;
	Sun,  4 Oct 2026 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791116457;
	bh=Ii5DqFPIyrYKvMEzaeK2WzB3de1YErnZ34F3KtRGjgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdLEaMM8ouR+tXuFuxrp5oT1cT1Cc+kivBVAGuwS9rfNF7GeopRDQEhb9OpAlbYXR
	 6rrufOGTID2KPOGbWo4ZLkyqwOpCOBo0i+2TE8oQXlfqvuTH5Z9vFaVkTutYand2uQ
	 wccn6S7O5mF6pU7xXZm5IHQNgLnyxr/5S/YZ0DOoj6wTHQ5opRUBrGmfI2MF21c5Jo
	 37m3uKPoieEGfZbo7P0yRe8A5Pn0R/JCrafUW1qHT0L/hyMtiYbosJ/W+EMNU0jPX9
	 v81SotyDEsYzMPI8LGoH23SVxrCc19M5nZWCYqx/JvyWdm2YAVKQFWszrBebzdJkeg
	 FjCwyWWWprRuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] rust: pci: add typed SR-IOV PF registration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261004120732.1045629-7-zhiw@nvidia.com>
References: <20261004120732.1045629-1-zhiw@nvidia.com>
 <20261004120732.1045629-7-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:20:57 +0000
Message-Id: <20261004122057.847191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] rust: pci: UB in VfRegistration::drop due to mutable aliasing
- [Low] rust: pci: missing #[inline] on small abstraction functions
--

commit b691159fa250909baaaa09e4f8331c57968a80d1
Author: Zhi Wang <zhiw@nvidia.com>

rust: pci: add typed SR-IOV PF registration data

Rust PF and VF drivers bind to separate PCI devices and may reside
in different modules. A VF driver that calls PF operations needs
typed access to the data exposed by the PF driver. This data must
remain valid until VF driver removal completes.

Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>

> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index 4ed6ba658e818..c61462595141f 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs

[ ... ]

> +impl<'a, F: ForLt + 'static> VfRegistrationData<'a, F> {
> +    /// Pin-initializer for the registration data.
> +    fn new<E>(data: impl PinInit<F::Of<'a>, E>) -> impl PinInit<Self, E>=
 {

[Severity: Low]
Does this small helper method need the #[inline] attribute?

The Rust subsystem guidelines explicitly state that small abstraction
functions forwarding to C bindings or performing minimal work should be
annotated with #[inline]. Missing this attribute can prevent the compiler
from properly inlining cross-crate calls, leading to a minor performance
penalty.

> +        try_pin_init!(Self {
> +            type_id: TypeId::of::<F>(),
> +            data <- data,
> +        }? E)
> +    }
> +}

[ ... ]

> +impl<'a, F: ForLt> VfRegistration<'a, F> {
> +    /// Borrows the registered data for use by the PF driver.
> +    ///
> +    /// The returned reference is tied to this registration, rather than=
 the PF device: the
> +    /// registration may be destroyed before the rest of the PF's privat=
e data is dropped.
> +    pub fn data(self: Pin<&Self>) -> Pin<&F::Of<'a>> {

[Severity: Low]
Should this small forwarding abstraction function also be marked #[inline]?

> +        // SAFETY: Both `inner` and its `data` field are structurally pi=
nned.
> +        unsafe { self.map_unchecked(|registration| &registration.inner.d=
ata) }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<F: ForLt + 'static> PinnedDrop for VfRegistration<'_, F> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: `pci_disable_sriov()` is safe to call on any `pci_dev=
`; it
> +        // is a no-op if the device has no VFs enabled. When VFs are ena=
bled,
> +        // this blocks until all VF `remove()` callbacks complete.
> +        unsafe { bindings::pci_disable_sriov(self.pdev.as_raw()) };

[Severity: High]
Can creating Pin<&mut Self> for this drop method cause undefined behavior
due to mutable aliasing?

When a PF driver is unbound, its VfRegistration is dropped, invoking this
drop method. This creates a mutable reference, asserting exclusive access to
the memory.

However, the code subsequently calls bindings::pci_disable_sriov(), which
blocks until all active VF drivers' remove callbacks finish. During this
blocked time, VFs are still executing and holding shared references
(Pin<&F::Of<'a>>) to the inner registration data.

Creating a unique mutable reference while shared references still exist
invalidates the shared references and violates Rust's aliasing rules.

> +
> +        // SAFETY: The device is valid and all VF remove callbacks have =
completed, so no VF
> +        // can access the registration pointer. The data remains alive u=
ntil this returns.
> +        unsafe { (*self.pdev.as_raw()).vf_registration_data_rust =3D cor=
e::ptr::null_mut() };
> +    }
> +}

[ ... ]

> +    /// Access the VF registration data through a closure with an HRTB l=
ifetime.
> +    ///
> +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. Ret=
urns
> +    /// [`ENODEV`] if this is not a VF or no data was registered,
> +    /// or [`EINVAL`] if `F` does not match the type registered by the P=
F.
> +    ///
> +    /// The reference is borrowed from this VF, while the registration d=
ata's lifetime remains
> +    /// abstract so the closure cannot store shorter-lived references in=
 invariant data.
> +    pub fn vf_registration_data_with<'this, F: ForLt + 'static, R>(
> +        &'this self,
> +        f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
> +    ) -> Result<R> {

[Severity: Low]
Does this small abstraction function need the #[inline] attribute?

> +        // SAFETY: The closure is higher-ranked over the data lifetime, =
independently of `'this`.
> +        // It cannot insert shorter-lived references, and the outer borr=
ow cannot outlive this VF.
> +        let pinned =3D unsafe { self.vf_registration_data_pinned::<F>()?=
 };
> +        Ok(f(pinned))
> +    }
> +
> +    /// Returns a pinned reference to the VF registration data.
> +    ///
> +    /// Available only when `F` implements [`CovariantForLt`](trait@crat=
e::types::CovariantForLt),
> +    /// guaranteeing that shortening the PF data lifetime is sound.
> +    ///
> +    /// For non-covariant types, use [`Self::vf_registration_data_with()=
`].
> +    ///
> +    /// PF drivers access their own data through [`VfRegistration::data(=
)`].
> +    ///
> +    /// It returns the same errors as [`Self::vf_registration_data_with(=
)`].
> +    pub fn vf_registration_data<F: CovariantForLt + 'static>(&self) -> R=
esult<Pin<&F::Of<'_>>> {

[Severity: Low]
Should this small forwarding abstraction function also be marked #[inline]?

> +        // SAFETY: `CovariantForLt` permits shortening the encoded lifet=
ime to this borrow.
> +        unsafe { self.vf_registration_data_pinned::<F>() }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004120732.1045=
629-1-zhiw@nvidia.com?part=3D6
