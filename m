Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339860;
	b=UN8eaTzEXwy7lGmlG1QpdTE0Lm2D1QA9Xg05b6RaH6oYJT3vypskWzWvDLa/TPRwA0Ti
	 UyxIVwi5imeHI92Rp+oiumHAisfGe5ncIr6cy77axFG0WHtFe+28DJfs7WQSR1X4vaEWu
	 sVmzy3FTYwpfZsAKYEZ5HrHqkoBsEmuhuumC4V1Z/gC+9C5AOVX9fL7vD5fZO1iiv2CFH
	 WADCmRrLwJQwe36b174C4ua3+TC8YxBGXQ5NikHuXGSMcdVawP1JoInsVpZfMuXoZIRM9
	 4FROVIDEKR8EiX4mmEoCpv3vIoeSLp9UktrbN0M3DK6KdS3dWUHTTjBdTsSrDOTup+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339860;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To;
	bh=fWfqbq9OHseUAlW92SLhKNSaqa3qmI+MBczXn8z6J5A=;
	b=jJAGOyLY471pdiVxA9c7f9tyXCt1n5ANPtJFQE226afZPq8Ffe5QzIn/o/LF4CTf5C2T
	 lI6X/F/S+yADsiCLHj41zlxYAn9s82CNaz1rKe7pUmWi1aZJCBXWrnJTU8RJPeyRqQ/qo
	 gxx1NbsW8pQN14pWMm0yTJ2/F2rsDQhpc/VFTPNZtHvn+fuhBmHydGcfsu2//NYz/2sji
	 outECwEuuj52pCamKOFnY+XVA3dJBZX2m9Vhex/jTbVSJQ1TQVMzoq8k31VnZzEqaKc7k
	 O16OGPNa2z6qGDI+85cyPjth3/0sG/jPronPQ51CsecQmEuWq3Pp9OYuasrQ1TW0EKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6Uit6jO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A4606A320;
	Tue, 10 Nov 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6Uit6jO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE7C1F0089F;
	Tue, 10 Nov 2026 19:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339859;
	bh=fWfqbq9OHseUAlW92SLhKNSaqa3qmI+MBczXn8z6J5A=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=O6Uit6jO3IsZoIfrOy3SW4hqltdD1ucWDADRC3HhxylC/zZnFAOdNMh7Q62k2iJNl
	 98Y2Ol65S0WRG+Dsv/Fo7Ph6FVV+dR3TbRmS1vtGkkhsLH5/hY5NWEloToTLTMoBag
	 zzgQOQqOrX+UUlJIXG4FKrP1ZqkyAhbuOtxsWlACnLrAEqwFf2U9RYYzM9W1DsZwAi
	 dIrJ39C3ygTIBdBR7TmjPzKTghgaJaYX5iZ2CHTW5vBJUF1BeKaw76TENQUS21XL+u
	 xyn3mkt8y8SEL4D9QbqvNuKdAE47PNLXd4Q4xe8DdoRvdrn8pRk/vOWngLU9PJ7WpG
	 xy4in6w8m33zQ==
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
Date: Tue, 10 Nov 2026 20:44:09 +0100
Message-Id: <DMRSE390GRTH.OZ9KS5QS8M4H@kernel.org>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 10/12] rust: vfio: separate common device handling
 from PCI
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
 <20261023154009.2246627-11-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-11-xinmengs@nvidia.com>

On Fri Oct 23, 2026 at 5:40 PM CEST, Simon Song wrote:
> +/// A VFIO device, independent of its bus-specific wrapper.
> +///
> +/// # Invariants
> +///
> +/// The underlying `vfio_device` is initialized and remains alive while =
borrowed.
> +/// Callback contexts are borrowed only for the corresponding callback a=
nd thread;
> +/// only [`Normal`] references can be reference-counted.
> +#[repr(transparent)]
> +pub struct Device<Ctx: DeviceContext =3D Normal> {
> +    raw: Opaque<bindings::vfio_device>,
> +    _context: PhantomData<(Ctx, NotThreadSafe)>,
> +}

I think this needs to be declared differently, see below.

> +impl<Ctx: DeviceContext> Device<Ctx> {
> +    /// # Safety
> +    ///
> +    /// `raw` must point to an initialized `vfio_device` that remains al=
ive for
> +    /// `'a`. The caller must provide the guarantees of `Ctx` throughout=
 the borrow.
> +    #[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
> +    unsafe fn from_raw<'a>(raw: *mut bindings::vfio_device) -> &'a Self =
{
> +        // SAFETY: Self is a transparent wrapper; the caller guarantees =
validity and context.
> +        unsafe { &*raw.cast() }
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::vfio_device {
> +        self.raw.get()
> +    }
> +}
> +
> +// SAFETY: VFIO uses the embedded class device's refcount to own the ful=
l allocation.
> +unsafe impl AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        // SAFETY: A shared reference keeps the initialized VFIO device =
alive.
> +        unsafe { bindings::get_device(&raw mut (*self.as_raw()).device) =
};
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller owns the VFIO reference being released.
> +        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).=
device) };
> +    }
> +}
> +
> +// SAFETY: Ordinary VFIO references expose no unsynchronized callback op=
erations.
> +unsafe impl Send for Device {}
> +// SAFETY: Shared access only changes the embedded class device's refere=
nce count.
> +unsafe impl Sync for Device {}
> +
> +/// Callback data stored after the bus-specific C device structure.
> +///
> +/// # Invariants
> +///
> +/// `reg_data` is dangling when unpublished; otherwise it borrows pinned=
 data kept
> +/// alive until callback access has ended. `open_data` is null outside a=
 successful
> +/// first open, otherwise owns a pinned allocation until the last close.
> +/// The bus-specific layer drains callbacks before releasing either allo=
cation.
> +struct CallbackData<R: CovariantForLt, O: ForLt> {
> +    reg_data: UnsafeCell<NonNull<R::Of<'static>>>,
> +    open_data: UnsafeCell<*mut O::Of<'static>>,
> +}

We don't need to arbitrarily limit registration data to require covariance,
eventually we will need invariant data.

Also, I think we don't need ForLt/CovariantForLt at all. Both types are
associated types of an ops trait, so they can just be GATs, i.e.:

	type RegistrationData<'a>: Send + Sync + 'a;
	type OpenData<'a, 'data: 'a>: Send + Sync + 'a;

> +
> +#[cfg_attr(not(CONFIG_VFIO_PCI_CORE), expect(dead_code))]
> +impl<R: CovariantForLt, O: ForLt> CallbackData<R, O> {
> +    fn new() -> Self {
> +        Self {
> +            reg_data: UnsafeCell::new(NonNull::dangling()),
> +            open_data: UnsafeCell::new(core::ptr::null_mut()),
> +        }
> +    }
> +
> +    /// Access registration data without allowing its erased lifetime to=
 escape.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Registration data must be published and remain valid through thi=
s call.
> +    /// The caller must exclude concurrent changes to `reg_data`.
> +    unsafe fn registration_data_with<V>(&self, f: impl for<'a> FnOnce(&'=
a R::Of<'a>) -> V) -> V {
> +        // SAFETY: The caller keeps registration data alive and excludes=
 mutation.
> +        // Covariance permits shortening its erased lifetime to this bor=
row.
> +        let reg_data =3D unsafe { (*self.reg_data.get()).cast::<R::Of<'_=
>>().as_ref() };
> +        f(reg_data)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// The caller must be an I/O callback while VFIO keeps the device o=
pen.
> +    /// Registration and open data must remain valid, with their pointer=
 slots
> +    /// unchanged throughout the call.
> +    unsafe fn callback_data_with<V>(
> +        &self,
> +        f: impl for<'borrow, 'data> FnOnce(&'borrow R::Of<'data>, Pin<&'=
borrow O::Of<'data>>) -> V,
> +    ) -> V {
> +        // SAFETY: The caller excludes open/close and unregister while b=
orrowing the data.
> +        unsafe {
> +            self.registration_data_with(|reg_data| {
> +                let ptr =3D (*self.open_data.get()).cast::<O::Of<'_>>();
> +                // The data lifetime stays independent of the callback b=
orrow,
> +                // so borrowed OpenData fields cannot be stored back int=
o OpenData.
> +                f(reg_data, Pin::new_unchecked(&*ptr))
> +            })
> +        }
> +    }

I don't think we necessarily need the extra closure, we only ever pass this=
 to
callbacks of the ops trait, but it would allow us to make the accessor safe=
:

If we move them onto Device directly, we can leverage the type states. E.g.=
 we
can group them with traits and only implement e.g. callback_data_with() for=
 type
states that allow for this.

> +
> +    /// # Safety
> +    ///
> +    /// Call only during exclusive first open, with no existing open dat=
a.
> +    /// All resources borrowed for `'a` must remain valid until `close()=
` returns.
> +    unsafe fn open<'a, I: PinInit<O::Of<'a>, Error>>(&self, init: impl F=
nOnce() -> I) -> Result {
> +        // Allocate before calling the driver so allocation failure cann=
ot follow open.
> +        let data =3D KBox::<O::Of<'a>>::new_uninit(GFP_KERNEL)?;
> +        let data =3D data.write_pin_init(init())?;
> +
> +        // SAFETY: Only the owning pointer moves; close drops the alloca=
tion in place.
> +        let raw =3D KBox::into_raw(unsafe { Pin::into_inner_unchecked(da=
ta) });
> +        // SAFETY: First open is exclusive; the caller keeps borrowed re=
sources alive
> +        // through close. Lifetimes do not affect the allocation's layou=
t.
> +        unsafe { *self.open_data.get() =3D raw.cast::<O::Of<'static>>() =
};
> +        Ok(())
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Call once after a successful open, with all callbacks drained an=
d the next
> +    /// open excluded. Registration data and borrowed resources must rem=
ain alive.
> +    unsafe fn close(&self) {
> +        // SAFETY: Last close exclusively takes the allocation published=
 by open.
> +        let raw =3D unsafe { core::mem::replace(&mut *self.open_data.get=
(), core::ptr::null_mut()) };
> +        // SAFETY: The allocation came from KBox::into_raw and is destro=
yed without moving it.
> +        unsafe { drop(KBox::from_raw(raw)) };
> +    }

This seems like a bit of a back and forth because logically we want those
methods on vfio::Device so you can take advantage of the type system
information.

But in this implementation CallbackData lives in the vfio::pci::Device, lik=
ely
for memory layout reasons.

But we can also do something like this:

	#[repr(C)]
	pub struct DeviceBase<Raw, R, O, T, Ctx =3D Normal> {
	    raw: Opaque<Raw>,
	    data: CallbackData<R, O>,
	    _context: PhantomData<(T, Ctx, NotThreadSafe)>,
	}

	// vfio.rs
	pub type Device<T, Ctx =3D Normal> =3D DeviceBase<
	    bindings::vfio_device,
	    T,
	    <T as Operations>::RegistrationData<'static>,
	    <T as Operations>::OpenData<'static, 'static>,
	    Ctx,
	>;
=09
	// vfio/pci.rs
	pub type Device<T, Ctx =3D Normal> =3D super::DeviceBase<
	    bindings::vfio_pci_core_device,
	    T,
	    <T as Operations>::RegistrationData<'static>,
	    <T as Operations>::OpenData<'static, 'static>,
	    Ctx,
	>;
=09
Of course we can't have AsRef<vfio::Device> with this, but we don't need it=
.

For instance, there's only one AlwaysRefCounted impl needed:

  unsafe impl<Raw: RawDevice, R, O, T> AlwaysRefCounted
      for DeviceBase<Raw, R, O, Normal>
  {
      fn inc_ref(&self) {
          let vdev =3D unsafe { Raw::raw_vfio_device(self.as_raw()) };

          unsafe { bindings::get_device(&raw mut (*vdev).device) };
      }

      unsafe fn dec_ref(obj: NonNull<Self>) {
          let raw =3D unsafe {
              Opaque::cast_into(&raw const (*obj.as_ptr()).raw)
          };

          let vdev =3D unsafe { Raw::raw_vfio_device(raw) };

          unsafe { bindings::put_device(&raw mut (*vdev).device) };
      }
  }

We can either rely on the fact that vfio_pci_core_device's first member is =
the
vfio_device, or make it explicit with something like:

	/// Maps a C device structure to its embedded VFIO device.
	///
	/// # Safety
	///
	/// Implementations must return the address of the `vfio_device` at the
	/// beginning of `Self`, preserving the input pointer's provenance.
	unsafe trait RawDevice {
	    /// # Safety
	    ///
	    /// `raw` must point to an initialized, live `Self`.
	    unsafe fn raw_vfio_device(
	        raw: *mut Self,
	    ) -> *mut bindings::vfio_device;
	}

Not that this isn't only to make use of some type system information (there=
's
other ways to achieve that too) but also to make vfio::Device useful for no=
n-PCI
implementations, as they need CallbackData too.
