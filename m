Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629470;
	b=IW68JQZt4bvVazag6iS17nsDtPaYlLdXT52mH38r1yKhymUYFvM5t8ko69kxeB2QOl8N
	 BEAgHYdm9RLD0TWb2zf9+jcv75SZILqxdwefIAZ5LeynR1adYjLszPROe0yFFeXf7jzzV
	 q2dMCm2zTsFKpgqmxBQtT/+jwnb13i/V4dWPQa95Ahxbv61Im1ncRFmOjdyrTTHS3doJC
	 7s2o3oq7Wz/FPIr9bc9Y+198AZaRyr1Sk0J/bQV7rOCLHXZ0ZPXGLJJIX3oGnkLyJf5/X
	 BziSMHbTDFSgKGzKd41VsinixBc4R61Hugp4yLB4ffA/HkxupWGfaAieqdSLQjbNMEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629470;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To;
	bh=2f9ij5G5D/y6Pj/3zdLsa4eDisdRz/W4PkKF8qTAmDs=;
	b=CAbc2z6UrLJWeotU/1h2uV1ofeb2BbuWcZvLH8SqcbhR5XEPWuaA0opWAq9IN4054V8e
	 IkC5xrPONRaJuDIH2CGF0JcEkVTt1mKHzPTw/DC62qIqBXl0BOi+TyDs1T769ix7MFp1r
	 3oPYhnccp/aIrq0IPXQGEQOIEJixnKAz5ROUBwolLCZ48ZyeL73+EZLFQQZB1J0daz10S
	 w9sHaa1GsR41c2vo94a+GT+l9YvAaIpUpncGPxflJqju+2OncQeKA3avNV9SISuWBLERM
	 pV8OZfHmKKdj1d6PTuLDYP1AtKalsYevUFu6qriHjCjgfrRBw49YKiqAki+NYaMtFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fz7TbJU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FC606A321;
	Wed, 25 Nov 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fz7TbJU/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC71C1F000C6;
	Wed, 25 Nov 2026 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629470;
	bh=2f9ij5G5D/y6Pj/3zdLsa4eDisdRz/W4PkKF8qTAmDs=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=fz7TbJU/3glP8YXf/jae8naiAwKy0x5vxOMI5AC7hWWLBflpbagoU2pKrdY18YziL
	 vu4U6UIOQcTnHcq+XV7npbS18NHnvSvBuQuY0aToG1eUsHcXobqCwKrRE4UJYhksdJ
	 KIz/xIW6QkCXRAoiiWGIVXV9gG4/KRAoH/Q79MuJVohZ3qwnA0EyNYbYpjcC2UBFRx
	 0DOOSg2fUj12hb2m5JzXU8aud7xqWtexLbwZ6+S2SjX7+GxYByCa+SI0XguEuV6TuP
	 ILrujJLjtZEmbFaV96gsOEd2C2I51S/CBcIM0Gd4shhinKiVIVvPj6g6UUIbSc1T9N
	 nRWB3kauLJn1Q==
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 18:57:40 +0100
Message-Id: <DN4HIQ5VPWEI.FFVR53SNX54Y@kernel.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 6/9] rust: vfio: add common VFIO device handling
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, "Zhi Wang" <zhiw@nvidia.com>,
 <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <boqun@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <jgg@ziepe.ca>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <peter@colberg.org>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-7-xinmengs@nvidia.com>
In-Reply-To: <20261119215046.2892839-7-xinmengs@nvidia.com>

On Thu Nov 19, 2026 at 10:50 PM CET, Simon Song wrote:
> +/// Maps a C device structure to its embedded VFIO device.
> +///
> +/// # Safety
> +///
> +/// Implementations must return the address of the `vfio_device` at the =
beginning of `Self`,

I think "at the beginning of `Self`" is not a safety requirement for this t=
rait,
it's an implementation detail of the current implementation on the C side, =
that
could be a type invariant of DeviceBase.

Besides that, I think the abstraction we currently need with DeviceBase and
RawDevice (which I proposed to deal with the current implementation) could =
be
simplified if the C code would be more flexible regarding the layout of a s=
truct
subclassing a struct vfio_device.

However, this could be a subsequent consideration and nothing that needs to=
 be
tackled now; it is mostly an implementation detail of this abstraction.

> +/// preserving the input pointer's provenance.
> +pub unsafe trait RawDevice {
> +    /// Returns the `vfio_device` embedded in `raw`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `raw` must point to an initialized, live `Self`.
> +    unsafe fn raw_vfio_device(raw: *mut Self) -> *mut bindings::vfio_dev=
ice;

I think this could be safe by taking &Opaque<Self>.

> +}
> +
> +// SAFETY: A `vfio_device` is its own VFIO device.
> +unsafe impl RawDevice for bindings::vfio_device {
> +    unsafe fn raw_vfio_device(raw: *mut Self) -> *mut bindings::vfio_dev=
ice {
> +        raw
> +    }
> +}
> +
> +/// Callback data stored after the C device structure.
> +///
> +/// `R` is the type of the registration data and `O` the type of the ope=
n data, both written
> +/// with the placeholder lifetime `'static`, because the device has no l=
ifetime to name.
> +///
> +/// # Invariants
> +///
> +/// `reg_data` is `None` until a registration publishes its data, and is=
 not changed again. The
> +/// data is pinned and remains valid while the device is registered. Aft=
er unregistration or a
> +/// failed registration attempt, the pointer may dangle; its pointee mus=
t never again be
> +/// accessed through this device.
> +/// `open_data` is null outside a successful first open, otherwise it ow=
ns a pinned allocation
> +/// until the last close. The bus-specific layer drains callbacks before=
 either is released.
> +struct CallbackData<R, O> {
> +    reg_data: UnsafeCell<Option<NonNull<R>>>,
> +    open_data: UnsafeCell<*mut O>,

I think this should be Option<NonNull<O>> as well.

> +}
> +
> +/// A C VFIO device structure `Raw`, followed by the callback data of th=
e driver `T`.
> +///
> +/// `raw` is the first field, so the `vfio_device` at the beginning of `=
Raw` is also at the
> +/// beginning of `Self`, as `vfio_alloc_device()` requires.
> +///
> +/// `R` and `O` are the types of the registration data and the open data=
 of `T`, written with
> +/// the placeholder lifetime `'static`. Use the alias [`Device`], which =
takes both from the
> +/// operations trait of `T`.
> +///
> +/// # Invariants
> +///
> +/// - `R` and `O` are the registration data and open data types of `T` w=
ith all lifetimes
> +///   replaced by `'static`. The data stored is only valid as described =
for `CallbackData`.
> +/// - `raw` is initialized and remains alive while borrowed. The referen=
ce count of its embedded
> +///   `vfio_device` owns the allocation.
> +/// - The device is registered with VFIO only after its registration dat=
a has been published.

That's more of a description of the registration protocal than a type invar=
iant.

Maybe something like:

"For [`Open`] and [`IoContext`] references, registration data is published =
and
remains valid for the reference's lifetime."

Also note that type invariants should be justified with an // INVARIANT com=
ment
when the type is constructed, or re-created from a raw pointer.

> +/// - Callback contexts are borrowed only for the corresponding callback=
 and thread; only
> +///   [`Normal`] references can be reference-counted.

I'd remove this one.

I'd also keep the documentation private with #[doc(hidden)] as the type is =
not
supposed to be used outside of the Rust core code.

> +#[repr(C)]
> +pub struct DeviceBase<Raw, R, O, T, Ctx: DeviceContext =3D Normal> {
> +    raw: Opaque<Raw>,
> +    data: CallbackData<R, O>,
> +    _context: PhantomData<(T, Ctx, NotThreadSafe)>,
> +}

If we declare CallbackData as

	struct CallbackData<T: Operations> {
	    reg_data: UnsafeCell<Option<NonNull<T::RegistrationData<'static>>>>,
	    open_data: UnsafeCell<Option<NonNull<T::OpenData<'static, 'static>>>>,
	}

we can get rid of R, O, right? Then DeviceBase could be simplified to:

	pub struct DeviceBase<Raw, T: Operations, Ctx: DeviceContext =3D Normal> {
	    raw: Opaque<Raw>,
	    data: CallbackData<T>,
	    _context: PhantomData<(T, Ctx, NotThreadSafe)>,
	}

I think this also needs a change in the subsequent patch, so
vfio::pci::Operations extend vfio::Operations.

	pub trait Operations: super::Operations

> +/// A VFIO device, wrapping `struct vfio_device`.
> +pub type Device<T, Ctx =3D Normal> =3D DeviceBase<
> +    bindings::vfio_device,
> +    <T as Operations>::RegistrationData<'static>,
> +    <T as Operations>::OpenData<'static, 'static>,
> +    T,
> +    Ctx,
> +>;

...and this simplifies to:

	pub type Device<T, Ctx =3D Normal> =3D DeviceBase<bindings::vfio_device, T=
, Ctx>;

> +#[expect(dead_code)]
> +impl<Raw: RawDevice, R, O, T, Ctx: DeviceContext> DeviceBase<Raw, R, O, =
T, Ctx> {
> +    /// Initializes the Rust fields of a newly allocated device.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must point to an allocation with the size and alignment o=
f `Self`, whose `raw`
> +    /// has been initialized. Nothing else may access the allocation dur=
ing this call.
> +    unsafe fn init(this: *mut Self) {
> +        // SAFETY: The caller provides exclusive access to a suitable al=
location.
> +        unsafe {
> +            (&raw mut (*this).data).write(CallbackData {
> +                reg_data: UnsafeCell::new(None),
> +                open_data: UnsafeCell::new(core::ptr::null_mut()),
> +            });
> +            (&raw mut (*this)._context).write(PhantomData);
> +        }
> +    }
> +
> +    /// Recovers `&Self` from the `vfio_device` VFIO passes to a callbac=
k.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `vdev` must point to the `vfio_device` at the beginning of a `Se=
lf` that remains alive
> +    /// for `'a`. The caller must provide the guarantees of `Ctx` throug=
hout the borrow.
> +    unsafe fn from_raw_vfio<'a>(vdev: *mut bindings::vfio_device) -> &'a=
 Self {
> +        // SAFETY: `Raw` begins with its `vfio_device` and is the first =
field of `Self`. The
> +        // caller guarantees validity and the context.
> +        unsafe { &*vdev.cast() }

If we rely on this layout guarantee here, there's no point to have the RawD=
evice
trait dealing with the layout.

Either we add from_raw_vfio() to RawDevice, or we just remove RawDevice and=
 make
the layout guarantee a type invariant.

Either is fine with me, but maybe the RawDevice trait is a bit overengineer=
ed
and a type invaraint is sufficient.

> +    }
> +
> +    fn as_raw(&self) -> *mut Raw {
> +        self.raw.get()
> +    }
> +
> +    fn as_raw_vfio(&self) -> *mut bindings::vfio_device {
> +        // SAFETY: By the type invariants, `raw` is initialized and aliv=
e.
> +        unsafe { Raw::raw_vfio_device(self.as_raw()) }
> +    }
> +}
> +
> +#[expect(dead_code)]
> +impl<Raw: RawDevice, R, O, T> DeviceBase<Raw, R, O, T> {
> +    /// Publishes the registration data passed to callbacks.
> +    ///
> +    /// Returns [`EBUSY`] if registration data has been published before=
, so that a device can
> +    /// be registered at most once.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must serialize calls for this device. `data` must poi=
nt to pinned data that
> +    /// remains valid until the device has been unregistered or, if regi=
stration fails, is not
> +    /// accessed through this device.
> +    unsafe fn publish_registration_data(&self, data: NonNull<R>) -> Resu=
lt {

I'd use:

	data: NonNull<T::RegistrationData<'a>>,

and erase the lifetime internally.

> +        // SAFETY: The caller serializes publication, and callbacks only=
 read the slot.
> +        if unsafe { (*self.data.reg_data.get()).is_some() } {
> +            return Err(EBUSY);
> +        }
> +        // SAFETY: The slot is unpublished, so the device has not been r=
egistered and no
> +        // callback can read the slot.
> +        // INVARIANT: The slot is written once; the caller keeps `data` =
valid.
> +        unsafe { *self.data.reg_data.get() =3D Some(data) };
> +        Ok(())
> +    }
> +
> +    /// Destroys the open data.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Call once after a successful [`DeviceBase::open`], with all I/O =
callbacks drained and
> +    /// the next first open excluded. Registration data and the resource=
s the open data borrows
> +    /// must remain alive.
> +    unsafe fn close(&self) {
> +        // SAFETY: The last close exclusively takes the allocation publi=
shed by `open()`.
> +        let raw =3D
> +            unsafe { core::mem::replace(&mut *self.data.open_data.get(),=
 core::ptr::null_mut()) };

With the type changed to Option<NonNull>> this becomes:

	let raw =3D unsafe { &mut *self.data.open_data.get() }
	    .take()
	    .expect("VFIO OpenData is expected to be populated.");

> +        // SAFETY: The allocation came from `KBox::into_raw()` and is de=
stroyed without moving
> +        // it. Lifetimes do not affect its layout.
> +        unsafe { drop(KBox::from_raw(raw)) };
> +    }
> +}
> +
> +#[expect(dead_code)]
> +impl<Raw: RawDevice, R, O, T> DeviceBase<Raw, R, O, T, Open> {
> +    /// Creates the open data from the registration data.
> +    ///
> +    /// The [`Open`] context guarantees an exclusive first open of a reg=
istered device, whose
> +    /// registration data remains valid until the last close.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - No open data may exist.
> +    /// - `OD` must be `O`, except for lifetimes.
> +    /// - `R` names the registration data with the placeholder lifetime =
`'static`, and the
> +    ///   caller chooses the lifetimes of `OD`; this function cannot tie=
 either to the time the
> +    ///   data is valid. `init` must therefore use the registration data=
 parametrically, as a
> +    ///   function generic over its lifetimes does: nothing borrowed fro=
m it may escape, other
> +    ///   than into the returned open data.
> +    /// - `init` must not capture references that are only valid for the=
 callback and store
> +    ///   them in the open data, which outlives the callback.
> +    /// - The open data must be destroyed with [`DeviceBase::close`] at =
the last close.
> +    unsafe fn open<'a, OD, I>(&'a self, init: impl FnOnce(&'a R) -> I) -=
> Result
> +    where
> +        I: PinInit<OD, Error>,
> +    {

I think this can just use the associated types of T:

	unsafe fn open<'a, 'data: 'a, I>(
	    &'a self,
	    init: impl FnOnce(&'a T::RegistrationData<'data>) -> I,
	) -> Result
	where
	    I: PinInit<T::OpenData<'a, 'data>, Error>,
	{

> +        // SAFETY: By the type invariants, an `Open` reference only exis=
ts for a registered
> +        // device, which has published registration data that nothing ch=
anges anymore. The
> +        // data remains valid until the last close.
> +        let reg_data =3D unsafe { (*self.data.reg_data.get()).unwrap_unc=
hecked().as_ref() };
> +
> +        // Allocate before calling the driver so allocation failure cann=
ot follow open.
> +        let data =3D KBox::<OD>::new_uninit(GFP_KERNEL)?;
> +        let data =3D data.write_pin_init(init(reg_data))?;
> +
> +        // SAFETY: Only the owning pointer moves; `close()` drops the al=
location in place.
> +        let raw =3D KBox::into_raw(unsafe { Pin::into_inner_unchecked(da=
ta) });

I think this can just be

	let data =3D KBox::pin_init(init(reg_data), GFP_KERNEL)?;
	let raw =3D data.into_foreign().cast::<T::OpenData<'static, 'static>>();

> +        // SAFETY: The first open is exclusive, and no I/O callback runs=
 before it returns.
> +        // The caller guarantees that `OD` and `O` only differ in lifeti=
mes, which do not
> +        // affect the layout.
> +        // INVARIANT: The allocation is pinned and owned by the slot unt=
il `close()`.
> +        unsafe { *self.data.open_data.get() =3D raw.cast::<O>() };
> +        Ok(())
> +    }
> +}
> +
> +#[expect(dead_code)]
> +impl<Raw: RawDevice, R, O, T, Ctx: IoContext> DeviceBase<Raw, R, O, T, C=
tx> {
> +    /// Returns the registration data and the open data, for an I/O call=
back.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `R` and `O` name the data with the placeholder lifetime `'static=
`, which is not the time
> +    /// the data is valid. The caller must use both parametrically, as a=
 function generic over
> +    /// their lifetimes does: nothing borrowed from them may outlive the=
 callback, and nothing
> +    /// borrowed for the callback may be stored in them.
> +    unsafe fn callback_data(&self) -> (&R, Pin<&O>) {

Same here, can we use the associated types of T?

> +        // SAFETY: By the type invariants, an `IoContext` reference only=
 exists during an I/O
> +        // callback on an open, registered device. VFIO excludes the las=
t close and
> +        // unregistration for its duration, so by the type invariants of=
 `CallbackData` both
> +        // slots hold valid data that nothing changes, and the open data=
 is pinned.
> +        unsafe {
> +            let reg_data =3D (*self.data.reg_data.get()).unwrap_unchecke=
d();

I'd use expect() instead.

> +            let open_data =3D *self.data.open_data.get();
> +            (reg_data.as_ref(), Pin::new_unchecked(&*open_data))
> +        }

Multiple unsafe operations should have their own unsafe block and justifica=
tion.
