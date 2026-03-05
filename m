Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB583BD646;
	Thu,  5 Mar 2026 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726566; cv=none; b=IQG4cdbbXqb54YKuzX9kZTvfoPoPG4EieNYE1XsEBpxvEjaOK2fbjSYGv7eongr9VwkEfUWv7AahQuZ8hLuJOkglZlJxQr+liWRS653PM5+3EymG+D8yQa5NCHImb2T0gLTXcu59TwRoiYQ4b4zT7mXYHCWMCofQxPSOtE8qeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726566; c=relaxed/simple;
	bh=ifhJT2dhcaWq8VzbQNc3uIqQnovXL9SVNQcZdnkFJa0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=T6yiZ7YIxMT6Ww9RMunjHgI4I4KpD+yvKoA7RcnLrIDhgG+gwvicBHrfuzSJeAM5jNnBRfSLELsaipwu1Cfo7mG3zXdS3ERpoPB/yoyAKC5RkyJcfqFcWaj3MJ5XLCcodtSiegTZlzEOOZ1KwhV2RItYSLnrdx/Kr9SVYuXTYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv+WpGtx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv+WpGtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27298C116C6;
	Thu,  5 Mar 2026 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772726565;
	bh=ifhJT2dhcaWq8VzbQNc3uIqQnovXL9SVNQcZdnkFJa0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Rv+WpGtxsEaZl8EbVmmyQg2/dskuzlRILR2ZrEyt90IstzQYHJPW8HfpKdCdacNf0
	 4fHYanC6IiYYyiSCFeEzx1Wcc2s4a1bYNEWoQGiLOmsJIIhmDGpG+Lnz0UAc0m2ejh
	 zb6W/xgvc/BbVCTbbdznHNU/0m+Ku7FnDYi4jGtqH69n6/tfBdOOo/bJLfp2J37B0D
	 Sbe6ssFP7lynIDY0pnQKKIkLAsxaj8RpNl/X3VIbJA3Gx9Qd60ltKNDSwmTKcAgeFI
	 ljFH3vNSONmjXcgpGoRgbVG6+DTiaFrSFIxhYOAitICVM8hTlUPW2a9Fo7nDFKg8tr
	 Dy5Ram7H3MXLA==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 17:02:38 +0100
Message-Id: <DGUZ4A6W87JU.36R2KDR7YGSEX@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: introduce abstractions for fwctl
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <jgg@nvidia.com>, <gary@garyguo.net>,
 <joelagnelf@nvidia.com>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217204909.211793-1-zhiw@nvidia.com>
 <20260217204909.211793-2-zhiw@nvidia.com>
In-Reply-To: <20260217204909.211793-2-zhiw@nvidia.com>

On Tue Feb 17, 2026 at 9:49 PM CET, Zhi Wang wrote:
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> index b5583b12a011..ce42c0f52d6d 100644
> --- a/drivers/fwctl/Kconfig
> +++ b/drivers/fwctl/Kconfig
> @@ -9,6 +9,18 @@ menuconfig FWCTL
>  	  fit neatly into an existing subsystem.
> =20
>  if FWCTL
> +
> +config RUST_FWCTL_ABSTRACTIONS
> +	bool "Rust fwctl abstractions"
> +	depends on RUST
> +	help
> +	  This enables the Rust abstractions for the fwctl device firmware
> +	  access framework. It provides safe wrappers around struct fwctl_devic=
e
> +	  and struct fwctl_uctx, allowing Rust drivers to register fwctl device=
s
> +	  and implement their control and RPC logic in safe Rust.
> +
> +	  If unsure, say N.

We currently have to ensure that CONFIG_FWCTL=3Dy.

I also gave this a quick shot and I see the following warnings:

	warning: `as` casting between raw pointers without changing their constnes=
s
	   --> rust/kernel/fwctl.rs:167:20
	    |
	167 |         let this =3D raw as *mut Self;
	    |                    ^^^^^^^^^^^^^^^^ help: try `pointer::cast`, a saf=
er alternative: `raw.cast::<Self>()`
	    |
	    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/rust-1.93.0/index.html#ptr_as_ptr
	    =3D note: requested on the command line with `-W clippy::ptr-as-ptr`
=09
	warning: unsafe block missing a safety comment
	   --> rust/kernel/fwctl.rs:171:9
	    |
	171 |         unsafe { data.__pinned_init(data_ptr) }.inspect_err(|_| {
	    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    |
	    =3D help: consider adding a safety comment on the preceding line
	    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/rust-1.93.0/index.html#undocumented_unsafe_blocks
	    =3D note: requested on the command line with `-W clippy::undocumented-=
unsafe-blocks`
=09
	warning: `as` casting between raw pointers without changing their constnes=
s
	   --> rust/kernel/fwctl.rs:178:59
	    |
	178 |         Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(raw as *mu=
t Self)) })
	    |                                                           ^^^^^^^^^^=
^^^^^^ help: try `pointer::cast`, a safer alternative: `raw.cast::<Self>()`
	    |
	    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/rust-1.93.0/index.html#ptr_as_ptr
=09
	warning: unsafe block missing a safety comment
	   --> rust/kernel/fwctl.rs:194:9
	    |
	194 |         unsafe { &*ptr.cast() }
	    |         ^^^^^^^^^^^^^^^^^^^^^^^
	    |
	    =3D help: consider adding a safety comment on the preceding line
	    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/rust-1.93.0/index.html#undocumented_unsafe_blocks
=09
	warning: unsafe block missing a safety comment
	   --> rust/kernel/fwctl.rs:205:36
	    |
	205 |         let dev: &device::Device =3D unsafe { device::Device::from_r=
aw(parent_dev) };
	    |                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^
	    |
	    =3D help: consider adding a safety comment on the preceding line
	    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/rust-1.93.0/index.html#undocumented_unsafe_blocks
=09
	warning: unsafe block missing a safety comment
	   --> rust/kernel/fwctl.rs:300:9
	    |
	300 |         unsafe { &*container_of!(Opaque::cast_from(ptr), Self, fwctl=
_uctx) }
	    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^
	    |
	    =3D help: consider adding a safety comment on the preceding line
	    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/rust-1.93.0/index.html#undocumented_unsafe_blocks
=09
	warning: unsafe block missing a safety comment
	   --> rust/kernel/fwctl.rs:308:9
	    |
	308 |         unsafe { &mut *container_of!(Opaque::cast_from(ptr), Self, f=
wctl_uctx).cast_mut() }
	    |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^
	    |
	    =3D help: consider adding a safety comment on the preceding line
	    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/rust-1.93.0/index.html#undocumented_unsafe_blocks
=09
	warning: 7 warnings emitted

From the rustdoc build:

	warning: unresolved link to `include/linux/fwctl.h`
	 --> rust/kernel/fwctl.rs:5:17
	  |
	5 | //! C header: [`include/linux/fwctl.h`]
	  |                 ^^^^^^^^^^^^^^^^^^^^^ no item named `include/linux/fwc=
tl.h` in scope
	  |
	  =3D help: to escape `[` and `]` characters, add '\' before them like `\[=
` or `\]`
	  =3D note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
=09
	warning: 1 warning emitted

Please make sure to test with CLIPPY=3D1 and make sure to also built the ru=
stdoc
target.

> +/// Trait implemented by each Rust driver that integrates with the fwctl=
 subsystem.
> +///
> +/// The implementing type **is** the per-FD user context: one instance i=
s
> +/// created for each `open()` call and dropped when the FD is closed.
> +///
> +/// Each implementation corresponds to a specific device type and provid=
es the
> +/// vtable used by the core `fwctl` layer to manage per-FD user contexts=
 and
> +/// handle RPC requests.
> +pub trait Operations: Sized {

I think this needs Send.

Besides that, are all those callbacks strictly serialized, i.e. can we real=
ly
give out a mutable reference?

> +    /// Driver data embedded alongside the `fwctl_device` allocation.
> +    type DeviceData;
> +
> +    /// fwctl device type identifier.
> +    const DEVICE_TYPE: DeviceType;
> +
> +    /// Called when a new user context is opened.
> +    ///
> +    /// Returns a [`PinInit`] initializer for `Self`. The instance is dr=
opped
> +    /// automatically when the FD is closed (after [`close`](Self::close=
)).
> +    fn open(device: &Device<Self>) -> Result<impl PinInit<Self, Error>, =
Error>;

This should just return impl PinInit<Self, Error>, the outer result is
redundant.

> +    /// Called when the user context is closed.
> +    ///
> +    /// The driver may perform additional cleanup here that requires acc=
ess
> +    /// to the owning [`Device`]. `Self` is dropped automatically after =
this
> +    /// returns.
> +    fn close(_this: Pin<&mut Self>, _device: &Device<Self>) {}

This can just be self: Pin<&mut Self>.

> +
> +    /// Return device information to userspace.
> +    ///
> +    /// The default implementation returns no device-specific data.
> +    fn info(_this: &Self, _device: &Device<Self>) -> Result<KVec<u8>, Er=
ror> {

self: Pin<&Self>, Result<KVec<u8>>

> +        Ok(KVec::new())
> +    }
> +
> +    /// Handle a userspace RPC request.
> +    fn fw_rpc(
> +        this: &Self,

Same here.

> +        device: &Device<Self>,
> +        scope: RpcScope,
> +        rpc_in: &mut [u8],
> +    ) -> Result<FwRpcResponse, Error>;
> +}
> +
> +/// A fwctl device with embedded driver data.
> +///
> +/// `#[repr(C)]` with the `fwctl_device` at offset 0, matching the C
> +/// `fwctl_alloc_device()` layout convention.
> +///
> +/// # Invariants
> +///
> +/// The `fwctl_device` portion is initialised by the C subsystem during
> +/// [`Device::new()`]. The `data` field is initialised in-place via
> +/// [`PinInit`] before the struct is exposed.

Where is this invariant used, do we actually need it?

> +#[repr(C)]
> +pub struct Device<T: Operations> {
> +    dev: Opaque<bindings::fwctl_device>,
> +    data: T::DeviceData,
> +}
> +
> +impl<T: Operations> Device<T> {
> +    /// Allocate a new fwctl device with embedded driver data.
> +    ///
> +    /// Returns an [`ARef`] that can be passed to [`Registration::new()`=
]
> +    /// to make the device visible to userspace. The caller may inspect =
or
> +    /// configure the device between allocation and registration.
> +    pub fn new(
> +        parent: &device::Device<device::Bound>,
> +        data: impl PinInit<T::DeviceData, Error>,
> +    ) -> Result<ARef<Self>> {
> +        let ops =3D core::ptr::from_ref::<bindings::fwctl_ops>(&VTable::=
<T>::VTABLE).cast_mut();

The turbofish shouldn't be needed.

> +
> +        // SAFETY: `_fwctl_alloc_device` allocates `size` bytes via kzal=
loc and
> +        // initialises the embedded fwctl_device. `ops` points to a stat=
ic vtable
> +        // that outlives the device. `parent` is bound.
> +        let raw =3D unsafe {
> +            bindings::_fwctl_alloc_device(parent.as_raw(), ops, core::me=
m::size_of::<Self>())
> +        };

I suggest to use Kmalloc::aligned_layout() in such a case, please also see =
[1].

[1] https://lore.kernel.org/r/20250731154919.4132-3-dakr@kernel.org

> +        if raw.is_null() {
> +            return Err(ENOMEM);
> +        }

If you replace this with NonNull::new().ok_or(ENOMEM)? you already have the
NonNull instance for the subsequent call to ARef::from_raw() below.

> +        // CAST: Device<T> is repr(C) with fwctl_device at offset 0.
> +        let this =3D raw as *mut Self;
> +
> +        // SAFETY: `data` field is within the kzalloc'd allocation, unin=
itialised.
> +        let data_ptr =3D unsafe { core::ptr::addr_of_mut!((*this).data) =
};

Prefer &raw mut.

> +        unsafe { data.__pinned_init(data_ptr) }.inspect_err(|_| {
> +            // SAFETY: Init failed; release the allocation.
> +            unsafe { bindings::fwctl_put(raw) };
> +        })?;
> +
> +        // SAFETY: `_fwctl_alloc_device` returned a valid pointer with r=
efcount 1
> +        // and DeviceData is fully initialised.
> +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(raw as *mut Se=
lf)) })
> +    }
> +
> +    /// Returns a reference to the embedded driver data.
> +    pub fn data(&self) -> &T::DeviceData {
> +        &self.data
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::fwctl_device {
> +        self.dev.get()
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a valid `fwctl_device` embedded in a `Device=
<T>`.
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_device) -> &'a Self=
 {
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Returns the parent device.
> +    ///
> +    /// The parent is guaranteed to be bound while any fwctl callback is
> +    /// running (ensured by the `registration_lock` read lock on the ioc=
tl
> +    /// path and by `Devres` on the teardown path).
> +    pub fn parent(&self) -> &device::Device<device::Bound> {
> +        // SAFETY: fwctl_device always has a valid parent.
> +        let parent_dev =3D unsafe { (*self.as_raw()).dev.parent };
> +        let dev: &device::Device =3D unsafe { device::Device::from_raw(p=
arent_dev) };
> +        // SAFETY: The parent is guaranteed to be bound while fwctl ops =
are active.
> +        unsafe { dev.as_bound() }
> +    }
> +}
> +
> +impl<T: Operations> AsRef<device::Device> for Device<T> {
> +    fn as_ref(&self) -> &device::Device {
> +        // SAFETY: self.as_raw() is a valid fwctl_device.
> +        let dev =3D unsafe { core::ptr::addr_of_mut!((*self.as_raw()).de=
v) };

NIT: &raw mut

> +        // SAFETY: dev points to a valid struct device.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +// SAFETY: `fwctl_get` increments the refcount of a valid fwctl_device.
> +// `fwctl_put` decrements it and frees the device when it reaches zero.
> +unsafe impl<T: Operations> AlwaysRefCounted for Device<T> {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> +        unsafe { bindings::fwctl_get(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::fwctl_put(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +/// A registered fwctl device.
> +///
> +/// Must live inside a [`Devres`] to guarantee that [`fwctl_unregister`]=
 runs
> +/// before the parent driver unbinds. `Devres` prevents the `Registratio=
n`
> +/// from being moved to a context that could outlive the parent device.
> +///
> +/// On drop the device is unregistered (all user contexts are closed and
> +/// `ops` is set to `NULL`) and the [`ARef`] is released.
> +///
> +/// [`fwctl_unregister`]: srctree/drivers/fwctl/main.c
> +pub struct Registration<T: Operations> {
> +    dev: ARef<Device<T>>,
> +}
> +
> +impl<T: Operations> Registration<T> {
> +    /// Register a previously allocated fwctl device.
> +    pub fn new<'a>(
> +        parent: &'a device::Device<device::Bound>,
> +        dev: &'a Device<T>,
> +    ) -> impl PinInit<Devres<Self>, Error> + 'a {

This doesn't need PinInit anymore.

> +        pin_init::pin_init_scope(move || {
> +            // SAFETY: `dev` is a valid fwctl_device backed by an ARef.
> +            let ret =3D unsafe { bindings::fwctl_register(dev.as_raw()) =
};
> +            if ret !=3D 0 {
> +                return Err(Error::from_errno(ret));
> +            }
> +
> +            Ok(Devres::new(parent, Self { dev: dev.into() }))
> +        })
> +    }
> +}
> +
> +impl<T: Operations> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `Registration` lives inside a `Devres`, which guarant=
ees
> +        // that drop runs while the parent device is still bound.
> +        unsafe { bindings::fwctl_unregister(self.dev.as_raw()) };
> +        // ARef<Device<T>> is dropped after this, calling fwctl_put.

It doesn't really hurt, but I don't think this comment is needed.

> +    }
> +}
> +
> +// SAFETY: `Registration` can be sent between threads; the underlying
> +// fwctl_device uses internal locking.
> +unsafe impl<T: Operations> Send for Registration<T> {}
> +
> +// SAFETY: `Registration` provides no mutable access; the underlying
> +// fwctl_device is protected by internal locking.
> +unsafe impl<T: Operations> Sync for Registration<T> {}
> +
> +/// Internal per-FD user context wrapping `struct fwctl_uctx` and `T`.
> +///
> +/// Not exposed to drivers =E2=80=94 they work with `&T` / `Pin<&mut T>`=
 directly.
> +#[repr(C)]
> +#[pin_data]
> +struct UserCtx<T: Operations> {
> +    #[pin]
> +    fwctl_uctx: Opaque<bindings::fwctl_uctx>,
> +    #[pin]
> +    uctx: T,

I'd probably just name this data.

> +}
> +
> +impl<T: Operations> UserCtx<T> {
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a `fwctl_uctx` embedded in a live `UserCtx<T=
>`.
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a Self {
> +        unsafe { &*container_of!(Opaque::cast_from(ptr), Self, fwctl_uct=
x) }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a `fwctl_uctx` embedded in a live `UserCtx<T=
>`.
> +    /// The caller must ensure exclusive access to the `UserCtx<T>`.
> +    unsafe fn from_raw_mut<'a>(ptr: *mut bindings::fwctl_uctx) -> &'a mu=
t Self {
> +        unsafe { &mut *container_of!(Opaque::cast_from(ptr), Self, fwctl=
_uctx).cast_mut() }
> +    }
> +
> +    /// Returns a reference to the fwctl [`Device`] that owns this conte=
xt.
> +    fn device(&self) -> &Device<T> {
> +        // SAFETY: fwctl_uctx.fwctl is set by the subsystem and always v=
alid.
> +        let raw_fwctl =3D unsafe { (*self.fwctl_uctx.get()).fwctl };
> +        // SAFETY: The fwctl_device is embedded in a Device<T>.
> +        unsafe { Device::from_raw(raw_fwctl) }
> +    }
> +}
> +
> +/// Static vtable mapping Rust trait methods to C callbacks.
> +pub struct VTable<T: Operations>(PhantomData<T>);
> +
> +impl<T: Operations> VTable<T> {
> +    /// The fwctl operations vtable for this driver type.
> +    pub const VTABLE: bindings::fwctl_ops =3D bindings::fwctl_ops {
> +        device_type: T::DEVICE_TYPE as u32,
> +        uctx_size: core::mem::size_of::<UserCtx<T>>(),

We may want to use Kmalloc::aligned_layout() here as well. It should be pos=
sible
to make this a const function.

> +        open_uctx: Some(Self::open_uctx_callback),
> +        close_uctx: Some(Self::close_uctx_callback),
> +        info: Some(Self::info_callback),
> +        fw_rpc: Some(Self::fw_rpc_callback),
> +    };
> +
> +    /// # Safety
> +    ///
> +    /// `uctx` must be a valid `fwctl_uctx` embedded in a `UserCtx<T>` w=
ith
> +    /// sufficient allocated space for the uctx field.
> +    unsafe extern "C" fn open_uctx_callback(uctx: *mut bindings::fwctl_u=
ctx) -> ffi::c_int {
> +        // SAFETY: `fwctl_uctx.fwctl` is set by the subsystem before cal=
ling open.
> +        let raw_fwctl =3D unsafe { (*uctx).fwctl };
> +        // SAFETY: `raw_fwctl` points to a valid fwctl_device embedded i=
n a Device<T>.
> +        let device =3D unsafe { Device::<T>::from_raw(raw_fwctl) };
> +
> +        let initializer =3D match T::open(device) {
> +            Ok(init) =3D> init,
> +            Err(e) =3D> return e.to_errno(),
> +        };
> +
> +        let uctx_offset =3D core::mem::offset_of!(UserCtx<T>, uctx);
> +        // SAFETY: The C side allocated space for the entire UserCtx<T>.
> +        let uctx_ptr: *mut T =3D unsafe { uctx.cast::<u8>().add(uctx_off=
set).cast() };

I think the following is a bit cleaner:

	let user_ctx =3D container_of!(fw, UserCtx<T>, fwctl_uctx);
	let data =3D unsafe { &raw mut (*user_ctx).uctx };

> +
> +        // SAFETY: uctx_ptr points to uninitialised, properly aligned me=
mory.
> +        match unsafe { initializer.__pinned_init(uctx_ptr.cast()) } {
> +            Ok(()) =3D> 0,
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `uctx` must point to a fully initialised `UserCtx<T>`.
> +    unsafe extern "C" fn close_uctx_callback(uctx: *mut bindings::fwctl_=
uctx) {
> +        // SAFETY: `fwctl_uctx.fwctl` is set by the subsystem and always=
 valid.
> +        let device =3D unsafe { Device::<T>::from_raw((*uctx).fwctl) };
> +
> +        // SAFETY: uctx is a valid pointer promised by C side.

You have to justify exclusive access as well.

> +        let ctx =3D unsafe { UserCtx::<T>::from_raw_mut(uctx) };
> +
> +        {
> +            // SAFETY: driver uctx is pinned in place by the C allocatio=
n.
> +            let pinned =3D unsafe { Pin::new_unchecked(&mut ctx.uctx) };
> +            T::close(pinned, device);
> +        }
> +
> +        // SAFETY: After close returns, no further callbacks will access=
 UserCtx.
> +        // Drop T before the C side kfree's the allocation.
> +        unsafe { core::ptr::drop_in_place(&mut ctx.uctx) };
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `uctx` must point to a fully initialised `UserCtx<T>`.
> +    /// `length` must be a valid pointer.
> +    unsafe extern "C" fn info_callback(
> +        uctx: *mut bindings::fwctl_uctx,
> +        length: *mut usize,
> +    ) -> *mut ffi::c_void {
> +        // SAFETY: uctx is a valid pointer promised by C side.
> +        let ctx =3D unsafe { UserCtx::<T>::from_raw(uctx) };
> +        let device =3D ctx.device();
> +
> +        match T::info(&ctx.uctx, device) {
> +            Ok(kvec) if kvec.is_empty() =3D> {
> +                // SAFETY: `length` is a valid out-parameter.
> +                unsafe { *length =3D 0 };
> +                // Return NULL for empty data; kfree(NULL) is safe.
> +                core::ptr::null_mut()
> +            }
> +            Ok(kvec) =3D> {
> +                let (ptr, len, _cap) =3D kvec.into_raw_parts();
> +                // SAFETY: `length` is a valid out-parameter.
> +                unsafe { *length =3D len };
> +                ptr.cast::<ffi::c_void>()
> +            }
> +            Err(e) =3D> Error::to_ptr(e),
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `uctx` must point to a fully initialised `UserCtx<T>`.
> +    /// `rpc_in` must be valid for `in_len` bytes. `out_len` must be val=
id.
> +    unsafe extern "C" fn fw_rpc_callback(
> +        uctx: *mut bindings::fwctl_uctx,
> +        scope: u32,
> +        rpc_in: *mut ffi::c_void,
> +        in_len: usize,
> +        out_len: *mut usize,
> +    ) -> *mut ffi::c_void {
> +        let scope =3D match RpcScope::try_from(scope) {
> +            Ok(s) =3D> s,
> +            Err(e) =3D> return Error::to_ptr(e),
> +        };
> +
> +        // SAFETY: `uctx` is fully initialised; shared access is suffici=
ent.
> +        let ctx =3D unsafe { UserCtx::<T>::from_raw(uctx) };
> +        let device =3D ctx.device();
> +
> +        // SAFETY: `rpc_in` / `in_len` are guaranteed valid by the fwctl=
 subsystem.

There are more safety requirements for a mutable slice, please justify them=
 as
well.

> +        let rpc_in_slice: &mut [u8] =3D
> +            unsafe { slice::from_raw_parts_mut(rpc_in.cast::<u8>(), in_l=
en) };
> +
> +        match T::fw_rpc(&ctx.uctx, device, scope, rpc_in_slice) {
> +            Ok(FwRpcResponse::InPlace(len)) =3D> {
> +                // SAFETY: `out_len` is valid.
> +                unsafe { *out_len =3D len };
> +                rpc_in
> +            }
> +            Ok(FwRpcResponse::NewBuffer(kvec)) =3D> {
> +                let (ptr, len, _cap) =3D kvec.into_raw_parts();
> +                // SAFETY: `out_len` is valid.
> +                unsafe { *out_len =3D len };
> +                ptr.cast::<ffi::c_void>()
> +            }
> +            Err(e) =3D> Error::to_ptr(e),
> +        }
> +    }
> +}
