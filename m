Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF524FC8E6;
	Wed, 30 Sep 2026 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776789; cv=none; b=iIEmTn5KAS8+0XBxfFdsq6oku4fc6WY5APafus4os5GplyGkRIwNHnMaWx6bCOaCO39U+5MRguVjLdPK0EThE9u7B5X6/n8kyeITleZXsiKzdTcF1hC8seJgRXVG6TVVNX3xYjyyp3X6ZCe0EqEsekxcALktjyGg9/lsEb3Qdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776789; c=relaxed/simple;
	bh=RJJG1MDLRtLrTAhBQu9I+x8/q6zkn5apQJNq2hJ6Z+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Txof2Ku16lLR4RMWG6yG34fAtwTVl8Jb2MRHNBXfO6VVV0OeC39+KdaMEJfo/V65PzpDuambm8Qvq1kz3TXwve5katG1wLGnSZfZFvcxb8EiZLeT/t8DmOHFPm1oEjrBnmtMIXcsh19D4YR0tBO+IvFK+K7xQvz0mpwP8aONC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/UTz7d+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/UTz7d+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2B11F0089C;
	Wed, 30 Sep 2026 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790776775;
	bh=ic0NruPW4ZZ/mbZ34nWmv/AinN1K4vtgdaosNDxW8zI=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=c/UTz7d+9tH/dqqsBsDAcrS4sccvCSEkmeNZvYLT5dXrDTxYkNyPEHtmQxlcx46G0
	 ojQlI+v6TCQ96ROyZxE4NQ9FoxPC5emKpktrqTrZNLRAW+mOOYglWifHOkLL6JfMND
	 tUudW/wiZpGxTPQBX995J8IP0dxvTetUIuq83KCMDAN454f3a3QUufGdvvhbJ6To6P
	 Lt7X6Rg+BJMFq6bi5WO+WLbB0D/zwfzznt1SpSxJMzJqqG5ld5FPmdiBExFz/7zYJe
	 MxTWmE8gzzorS1IagYK6B8GtgF2FA4gt5HtF+v52ASpEi8NxgG7i2d5S9n2/kVquJ8
	 aMt/z66quqe0A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 15:59:27 +0200
Message-Id: <DLSPDU29TZ0B.1O7PTVMMYQSHS@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 07/10] rust: pci: add typed SR-IOV PF registration
 data
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <jgg@nvidia.com>, <alex@shazbot.org>, "Peter Colberg" <peter@colberg.org>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <cover.1790705494.git.zhiw@nvidia.com>
 <9fa15232fb869a562973454d9d21a5287b3da080.1790759932.git.zhiw@nvidia.com>
In-Reply-To: <9fa15232fb869a562973454d9d21a5287b3da080.1790759932.git.zhiw@nvidia.com>

On Wed Sep 30, 2026 at 12:18 PM CEST, Zhi Wang wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 1599b3a613d7..8782e9b06e64 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -51,6 +51,8 @@
>      Extended,
>      Normal, //
>  };
> +#[cfg(CONFIG_PCI_IOV)]
> +pub use self::iov::VfRegistration;
>  pub use self::irq::{
>      IrqType,
>      IrqTypes,
> @@ -331,6 +333,9 @@ fn probe<'bound>(
>      /// operations to gracefully tear down the device.
>      ///
>      /// Otherwise, release operations for driver resources should be per=
formed in `Drop`.
> +    ///
> +    /// For a PF with enabled VFs, `VfRegistration` disables SR-IOV when=
 it is dropped. This
> +    /// callback must leave resources accessed by VF drivers available u=
ntil then.

I don't think we need this comment, neither this callback (which I plan to
remove anyway) nor T::Data::drop() can remove resources that can still be
accessed by VF drivers in the first place.

You could have something like Mutex<Option<_>> of course, but that would be
intentional then.

> +impl<'a, F: ForLt + 'static> VfRegistrationData<'a, F> {
> +    /// Pin-initializer for the registration data.
> +    fn new(data: impl PinInit<F::Of<'a>, Error>) -> impl PinInit<Self, E=
rror> {

I think we can accept any error type E?

> +        try_pin_init!(Self {
> +            type_id: TypeId::of::<F>(),
> +            data <- data,
> +        })
> +    }
> +}

<snip>

> +impl<'a, F: ForLt + 'static> VfRegistration<'a, F>
> +where
> +    for<'b> F::Of<'b>: Send + Sync,
> +{
> +    /// Create a new VF registration.
> +    ///
> +    /// Returns a pin-initializer so the registration can be embedded di=
rectly
> +    /// in the PF driver's bus device private data.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned registration must be embedded in the driver's bus d=
evice private data.

I think this is the only requirement we need.

> +    /// The initializer must run as part of the PF driver's probe.
> +    /// The driver's `unbind` callback and the enclosing data's destruct=
or must keep resources
> +    /// accessed by VF drivers available until this registration has dis=
abled SR-IOV.

This is not a safety requirement; it would require unsafe code to do this.

> +    pub unsafe fn new(
> +        pdev: &'a Device<device::Core<'_>>,
> +        data: impl PinInit<F::Of<'a>, Error> + 'a,
> +    ) -> impl PinInit<Self, Error> + 'a {
> +        let pdev: &'a Device<device::Bound> =3D pdev;
> +        try_pin_init!(Self {
> +            _: {
> +                if pdev.is_virtfn() {
> +                    return Err(ENODEV);
> +                }
> +            },
> +            pdev,
> +            inner <- VfRegistrationData::new(data),
> +            _pin: PhantomPinned,
> +            _: {
> +                // Check after initialization in case it registered anot=
her object for this PF.
> +                // SAFETY: The caller runs this initializer during PF pr=
obing, before VF
> +                // configuration callbacks can run.
> +                if unsafe { bindings::pci_num_vf(pdev.as_raw()) } !=3D 0=
 {

Don't we have a safe pci::Device::num_vf() method already?

> +                    return Err(EBUSY);
> +                }
> +
> +                // SAFETY: This initializer runs during PF probing, and =
no VFs are enabled.
> +                if !unsafe { (*pdev.as_raw()).vf_registration_data_rust =
}.is_null() {
> +                    return Err(EBUSY);
> +                }

Those two checks can go into the first _: block, no?

> +
> +                // SAFETY: The data is initialized and pinned, the slot =
is unoccupied, and
> +                // no VF can access it yet. No fallible work follows pub=
lication.
> +                unsafe {
> +                    (*pdev.as_raw()).vf_registration_data_rust =3D
> +                        core::ptr::from_ref(inner.as_ref().get_ref()).ca=
st_mut().cast();
> +                }
> +            },
> +        })
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
> +
> +        // SAFETY: The device is valid and all VF remove callbacks have =
completed, so no VF
> +        // can access the registration pointer. The data remains alive u=
ntil this returns.
> +        unsafe { (*self.pdev.as_raw()).vf_registration_data_rust =3D cor=
e::ptr::null_mut() };
> +    }
> +}
> +
> +// SAFETY: The inner data is `Send` (enforced by the bound), and `&Devic=
e` is `Send + Sync`.
> +unsafe impl<F: ForLt> Send for VfRegistration<'_, F> where for<'a> F::Of=
<'a>: Send {}
> +
> +// SAFETY: The inner data is `Send + Sync`. `VfRegistration` doesn't exp=
ose mutable access;
> +// VF drivers only read the data through an immutable pinned reference.
> +unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> where for<'a> F::Of=
<'a>: Send + Sync {}
> +
> +impl Device<device::Bound> {
> +    /// Internal helper: reads the `vf_registration_data_rust` pointer f=
rom the
> +    /// PF, checks the `TypeId`, and returns a pinned reference.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The data lifetime must be hidden behind a higher-ranked closure =
independently of the
> +    /// reference lifetime, or `F` must be covariant in its encoded life=
time.
> +    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> =
Result<Pin<&F::Of<'_>>> {
> +        if !self.is_virtfn() {
> +            return Err(ENODEV);
> +        }

We don't want to exclude PF drivers to access this. Have a look at
drivers/gpu/nova-core/api.rs, it makes sense for the PF driver to provide a
helper API around this.

> +        // SAFETY: This bound VF uses the `physfn` union field. PCI reta=
ins its PF until
> +        // VF removal completes, and the PF keeps the registration insta=
lled until then.
> +        let ptr =3D unsafe {
> +            let pf =3D (*self.as_raw()).__bindgen_anon_1.physfn;
> +            (*pf).vf_registration_data_rust
> +        };
> +
> +        if ptr.is_null() {
> +            return Err(ENOENT);

Maybe ENODEV?

> +        }
> +
> +        // SAFETY: The registration keeps its data installed until VF re=
moval completes,
> +        // including when probe initialization rolls back.
> +        // `ptr` points to a `VfRegistrationData` whose first field is a=
 `TypeId`.
> +        let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
> +        if type_id !=3D TypeId::of::<F>() {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: TypeId check confirms the stored type matches `F`. Th=
e data
> +        // is pinned inside the PF's driver data struct. Lifetime shorte=
ning
> +        // from the PF's binding scope to `'_` is layout-compatible.
> +        let data_ptr =3D unsafe {
> +            let vfrd =3D ptr.cast::<VfRegistrationData<'_, F>>();
> +            &raw const (*vfrd).data
> +        };
> +
> +        // SAFETY: `data` is structurally pinned inside `VfRegistrationD=
ata`.
> +        Ok(unsafe { Pin::new_unchecked(&*data_ptr) })
> +    }
> +
> +    /// Access the VF registration data through a closure with an HRTB l=
ifetime.
> +    ///
> +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. Ret=
urns
> +    /// [`ENODEV`] if this is not a VF, [`ENOENT`] if no data was regist=
ered,
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
> +    /// It returns the same errors as [`Self::vf_registration_data_with(=
)`].
> +    pub fn vf_registration_data<F: CovariantForLt + 'static>(&self) -> R=
esult<Pin<&F::Of<'_>>> {
> +        // SAFETY: `CovariantForLt` permits shortening the encoded lifet=
ime to this borrow.
> +        unsafe { self.vf_registration_data_pinned::<F>() }
> +    }
> +}
> --=20
> 2.53.0

