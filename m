Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FC4F85A2;
	Mon, 28 Sep 2026 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626136; cv=none; b=JEEgLS5uwpFaDFv780eNV2vqRv2TwASZQXp8/xcmW3WuL2nuJlqOBPBgZOOj1Vl//CfCY5KcPbHNp4imwgQMbjRGU10quVFJ9rsC1k+reFlYrIDu36MV9XjoEPjDZBYYmZzfXXD3z5fFoKOkPvsrhMLzp11sgtIsUQmeBvwJtpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626136; c=relaxed/simple;
	bh=OqdxOmelmC4K5tJnL5a/TX39w/j+FLW3fbn1bwC4GEw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hCd9SVmOxKvSonHYlHDxcs3pv5d06rmYYSDeJ2i2u0CBmYhlUH37BOAcGpLNNU9eq76dAFjBhuhh0EOTMJvUE9Flv8uA+w3agcxiSIi+Zv5TpLt+njzIXsDanm49WT/N4h60cMOsMyAnR7msiWEpdLXmDylKRc9Qx0JioSw9UG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGqB6jq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGqB6jq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7703A1F000FF;
	Mon, 28 Sep 2026 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790626134;
	bh=yLI0dufzkxa9fkken2NMaTtqjbQ6+/w3Rtiw+Ipzh5w=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=HGqB6jq+TYtVLrKxSgcTFqzyqudOMt85p9BS7zpQerkiErd6kpnuTOPp72Y0VGJsU
	 6yCmFarL6k7C5GSiE4PtBVlJZL0ZasQp8iUS8fvlyfQsNArIvfBCWsJQZm4eHlT63S
	 jIP6vRRuT/aP3uWSklBFnQPzaJ2c3epdGduhgKcxCZmrJpt04IdrpwSD6YrlupQdke
	 6vPxeNldJJyJQmIBImjxCbdOTxo144savIUFVoG3uS+OjruEyeMJ+pM/lTtpELqP7t
	 Q1wexVbq5lMyk9l4eZRfrB17KucDJRrKA/54aURe0vbTMHEpnLFtGWBTHHjaja1mKt
	 zfKq7p/BPIWCw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 22:08:46 +0200
Message-Id: <DLR7ZIHFTUWF.160C4AKB6W3II@kernel.org>
Subject: Re: [PATCH v2 7/8] rust: pci: add typed SR-IOV PF registration data
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <jgg@nvidia.com>, <alex@shazbot.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260924190556.1620886-1-zhiw@nvidia.com>
 <20260924190556.1620886-8-zhiw@nvidia.com>
In-Reply-To: <20260924190556.1620886-8-zhiw@nvidia.com>

On Thu Sep 24, 2026 at 9:05 PM CEST, Zhi Wang wrote:
> @@ -166,7 +170,16 @@ extern "C" fn sriov_configure_callback(
>          // INVARIANT: `pdev` is valid for the duration of `sriov_configu=
re_callback()`.
>          let pdev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> =20
> -        from_result(|| T::sriov_configure(pdev, nr_virtfn))
> +        // SAFETY: `sriov_configure` is called only after a successful p=
robe and before unbind, so
> +        // the stored pointer has type `T::Data<'_>` and remains valid t=
hroughout this callback.
> +        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> +
> +        from_result(|| {
> +            if !pdev.is_physfn() {
> +                return Err(ENODEV);
> +            }
> +            T::sriov_configure(pdev, data, nr_virtfn)

Yes, we want to pass the driver's bus device private data, but this belongs=
 into
patch 6, but please also see my reply in patch 1 about the sriov_configure(=
)
callback.

> @@ -496,24 +518,24 @@ pub fn resource_start(&self, bar: u32) -> Result<bi=
ndings::resource_size_t> {
>      }
> =20
>      /// Returns `true` if this device is a Physical Function (PF).
> +    #[cfg(CONFIG_PCI_IOV)]

Belongs into the patch that introduces the function, but I think it would b=
e
easier to move everything that is behind this config into rust/kernel/pci/i=
ov.rs
and guard the whole module.

>      #[inline]
> -    #[expect(dead_code)]
>      pub(crate) fn is_physfn(&self) -> bool {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          unsafe { (*self.as_raw()).is_physfn() !=3D 0 }
>      }
> =20
>      /// Returns `true` if this device is a Virtual Function (VF).
> +    #[cfg(CONFIG_PCI_IOV)]
>      #[inline]
> -    #[expect(dead_code)]
> -    pub(crate) fn is_virtfn(&self) -> bool {
> +    pub fn is_virtfn(&self) -> bool {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          unsafe { (*self.as_raw()).is_virtfn() !=3D 0 }
>      }
> =20
>      /// Returns the number of Virtual Functions (VF) enabled for a Physi=
cal Function (PF).
>      #[cfg(CONFIG_PCI_IOV)]
> -    pub(crate) fn num_vf(&self) -> i32 {
> +    pub fn num_vf(&self) -> i32 {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          unsafe { bindings::pci_num_vf(self.as_raw()) }
>      }
> diff --git a/rust/kernel/pci/sriov.rs b/rust/kernel/pci/sriov.rs
> new file mode 100644
> index 000000000000..90abe878f67c
> --- /dev/null
> +++ b/rust/kernel/pci/sriov.rs
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers=
.
> +
> +use super::Device as PciDevice;

Not needed, just refer to it as Device please.

> +use crate::{
> +    bindings,
> +    device, //
> +    prelude::*,
> +    types::{
> +        CovariantForLt,
> +        ForLt, //
> +    },
> +};
> +use core::{
> +    any::TypeId,
> +    marker::PhantomPinned, //
> +};
> +
> +/// Wrapper for VF registration data stored inside a [`VfRegistration`].
> +///
> +/// Stores a [`TypeId`] header (derived from `F`) followed by the pinned=
 data,
> +/// so that [`PciDevice::vf_registration_data_with()`] can verify the ty=
pe at
> +/// runtime.
> +#[repr(C)]
> +#[pin_data]
> +struct VfRegistrationData<'a, F: ForLt + 'static> {
> +    type_id: TypeId,
> +    #[pin]
> +    data: F::Of<'a>,
> +}
> +
> +static_assert!(
> +    core::mem::offset_of!(VfRegistrationData<'static, CovariantForLt!(()=
)>, type_id) =3D=3D 0
> +);
> +
> +impl<'a, F: ForLt + 'static> VfRegistrationData<'a, F> {
> +    /// Pin-initializer for the registration data.
> +    fn new<D>(data: D) -> impl PinInit<Self, Error> + use<'a, D, F>
> +    where
> +        D: PinInit<F::Of<'a>, Error> + 'a,

NIT: I prefer to have this in the signature as impl PinInit<F::Of<'a>, E>.

> +    {
> +        try_pin_init!(Self {
> +            type_id: TypeId::of::<F>(),
> +            data <- data,
> +        })
> +    }
> +}
> +
> +/// SR-IOV VF registration on a PF device.
> +///
> +/// Owns the registration data that VF drivers access via
> +/// [`PciDevice::vf_registration_data_with()`] and [`PciDevice::vf_regis=
tration_data()`].
> +///
> +/// The Rust PCI adapter removes all VFs before invoking the PF driver's=
 unbind callback or
> +/// dropping its data. Drop of a published registration calls `pci_disab=
le_sriov()` before
> +/// clearing the pointer and letting the data fields drop.
> +#[pin_data(PinnedDrop)]
> +pub struct VfRegistration<'a, F: ForLt + 'static> {
> +    pdev: &'a PciDevice<device::Bound>,
> +    #[pin]
> +    inner: VfRegistrationData<'a, F>,
> +    published: bool,

I don't think we need this bool.

> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
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
> +    /// The caller must ensure that the containing struct's field orderi=
ng drops
> +    /// this `VfRegistration` before any resources that the registration=
 data
> +    /// borrows.

This is not needed.

> +    ///
> +    /// The caller must invoke this during the PCI driver's probe and em=
bed the result in the driver
> +    /// data. On an SR-IOV PF, no VF may be enabled before probe success=
fully installs the complete
> +    /// driver data.

Saying that it must go into the driver's bus device private data should be
enough. (We can probably improve this once we have the bus setup tokens.)

> +    pub unsafe fn new<'core, D>(
> +        pdev: &'a PciDevice<device::Core<'core>>,
> +        data: D,

As above, I prefer to inline impl PinInit<F::Of<'a>, E>.

> +    ) -> impl PinInit<Self, Error> + use<'a, 'core, D, F>
> +    where
> +        D: PinInit<F::Of<'a>, Error> + 'a,
> +    {
> +        pin_init::pin_init_scope(move || {

Let's avoid pin_init_scope() and just make everything part of the initializ=
er.

> +            if pdev.is_virtfn() {
> +                return Err(ENODEV);
> +            }
> +
> +            let published =3D pdev.is_physfn();
> +            if published {

The published thing seems unnecessary, am I missing something?

> +                if pdev.num_vf() !=3D 0 {
> +                    return Err(EBUSY);
> +                }
> +
> +                if !pdev.vf_registration_data_rust().is_null() {
> +                    return Err(EBUSY);
> +                }
> +            }
> +
> +            Ok(try_pin_init!(Self {
> +                pdev,
> +                inner <- VfRegistrationData::new(data),
> +                published,
> +                _pin: PhantomPinned,
> +                _: {
> +                    if *published {
> +                        // Store the pointer to the pinned `VfRegistrati=
onData`
> +                        // on the PCI device so VF drivers can find it.
> +                        pdev.set_vf_registration_data_rust(
> +                            core::ptr::from_ref(inner.as_ref().get_ref()=
).cast_mut().cast(),
> +                        );
> +                    }
> +                },
> +            }))
> +        })
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<F: ForLt + 'static> PinnedDrop for VfRegistration<'_, F> {
> +    fn drop(self: Pin<&mut Self>) {
> +        if !self.published {
> +            return;
> +        }

How can this ever happen?

> +
> +        // SAFETY: `pci_disable_sriov()` is safe to call on any `pci_dev=
`; it
> +        // is a no-op if the device has no VFs enabled. When VFs are ena=
bled,
> +        // this blocks until all VF `remove()` callbacks complete.
> +        unsafe { bindings::pci_disable_sriov(self.pdev.as_raw()) };
> +
> +        // After `pci_disable_sriov()` all VFs are gone, so no one can r=
ead
> +        // the pointer anymore.
> +        self.pdev
> +            .set_vf_registration_data_rust(core::ptr::null_mut());
> +
> +        // The pinned `inner` field is dropped automatically after this =
returns.
> +    }
> +}
> +
> +// SAFETY: The inner data is `Send` (enforced by the bound), and `&PciDe=
vice` is `Send + Sync`.
> +unsafe impl<F: ForLt> Send for VfRegistration<'_, F> where for<'a> F::Of=
<'a>: Send {}
> +
> +// SAFETY: The inner data is `Send + Sync`. `VfRegistration` doesn't exp=
ose mutable access;
> +// VF drivers only read the data through an immutable pinned reference.
> +unsafe impl<F: ForLt> Sync for VfRegistration<'_, F> where for<'a> F::Of=
<'a>: Send + Sync {}
> +
> +impl<Ctx: device::DeviceContext> PciDevice<Ctx> {
> +    /// Returns the raw `vf_registration_data_rust` pointer from this de=
vice.
> +    fn vf_registration_data_rust(&self) -> *mut core::ffi::c_void {
> +        // SAFETY: `self.as_raw()` is valid.
> +        unsafe { (*self.as_raw()).vf_registration_data_rust }
> +    }
> +
> +    /// Sets the `vf_registration_data_rust` pointer on this device.
> +    fn set_vf_registration_data_rust(&self, ptr: *mut core::ffi::c_void)=
 {
> +        // SAFETY: `self.as_raw()` is valid. PCI probe publishes the dat=
a before enabling VFs;
> +        // teardown removes all VFs before withdrawing it.
> +        unsafe { (*self.as_raw()).vf_registration_data_rust =3D ptr };
> +    }
> +}

Those can't be safe functions, but I'd just drop those helpers anyway and j=
ust
inline the accesses. It should only be three places after all.

> +
> +impl PciDevice<device::Bound> {
> +    /// Returns the PF for this VF, or [`ENODEV`] if this is not a VF.
> +    fn physfn(&self) -> Result<&PciDevice> {
> +        if !self.is_virtfn() {
> +            return Err(ENODEV);
> +        }
> +
> +        // SAFETY: `self.as_raw()` is valid and this VF uses the `physfn=
` union field.
> +        let pf =3D unsafe { (*self.as_raw()).__bindgen_anon_1.physfn };
> +        if pf.is_null() {
> +            return Err(ENODEV);
> +        }
> +
> +        // SAFETY: PCI holds a PF reference until VF removal completes. =
The returned borrow
> +        // cannot outlive this bound VF, and `PciDevice` is a transparen=
t wrapper of `pci_dev`.
> +        Ok(unsafe { &*pf.cast() })
> +    }

I don't think we need this, the PF's pci::Device<Bound> can be part of the =
data
stored in the VfRegistrationData if needed.

> +
> +    /// Internal helper: reads the `vf_registration_data_rust` pointer f=
rom the
> +    /// PF, checks the `TypeId`, and returns a pinned reference.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned borrow must be confined by a closure higher-ranked =
independently over its
> +    /// borrow and data lifetimes, or `F` must be covariant in its encod=
ed lifetime.
> +    unsafe fn vf_registration_data_pinned<F: ForLt + 'static>(&self) -> =
Result<Pin<&F::Of<'_>>> {
> +        let pf =3D self.physfn()?;
> +
> +        let ptr =3D pf.vf_registration_data_rust();
> +        if ptr.is_null() {
> +            return Err(ENOENT);
> +        }
> +
> +        // SAFETY: The Rust PCI adapter keeps the PF data installed unti=
l VF removal completes.
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
> +    /// The closure's borrow and the registration data's lifetime are in=
dependent, so a borrow of
> +    /// the context cannot be stored in invariant registration data.
> +    pub fn vf_registration_data_with<F: ForLt + 'static, R>(
> +        &self,
> +        f: impl for<'borrow, 'data> FnOnce(Pin<&'borrow F::Of<'data>>) -=
> R,
> +    ) -> Result<R> {
> +        // SAFETY: The higher-ranked closure prevents the borrow from es=
caping or being stored in
> +        // invariant data by keeping its lifetime independent of the era=
sed data lifetime.
> +        let pinned =3D unsafe { self.vf_registration_data_pinned::<F>()?=
 };
> +        Ok(f(pinned))
> +    }

Just like in auxiliary, the signature should be:

	pub fn registration_data_with<'this, F: ForLt + 'static, R>(
	    &'this self,
	    f: impl for<'a> FnOnce(Pin<&'this F::Of<'a>>) -> R,
	) -> Result<R> {

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

