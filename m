Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650716;
	b=Sfoxe7Vdhs4Zhy984BL6ww+/X15oMLXTxAEilORCmbeYO1rjYwORTH3sYSUZgcV/09H5
	 WV5NBCotx29vD3oFFEGIUOQW82Y37ZNgyopPAvUFrMx+51xBEoy4AUxR7cTRJPQMjde50
	 iYiEYutiESEYZNpObBh7Zlct/IqWKBWoL6i6QGUmXNVWUKGDjNqO/zywHgP3houoRLs4D
	 uiusXXCDbbxeKiKYKFmACUx04CqiFu5IjoAZT/aP8eZFpTdW9AADzuj3Qdw7BVMgk6P61
	 0takyhsF7kBK8IZitUXS4uaBm4YS8B2r6JsJs/b2bid7j26zlcvJ7iEMRizKMukL8hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650716;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To;
	bh=eNHNSZn2koSUnpEENTHobyjeI7cVNI7nbjqUeJE3ris=;
	b=FxXmCCoeavX8RK+Dv+J89IleABCTj+giVervqAROC6Y0SRP1CUVfI2GLNxftD6emKQY9
	 f6d44kiWiI/owkAE4ExQ5dQlm2F3sDbxrNB2aW3NUnU2tsJoUdOE2lQlOy1pSJ0duvEK9
	 5xYQrrtTDb2W58HZ1/kE9Hv7XNT5KNRVrLXMGbuoo4OHNgDYk47vMDIX3fzDE+xd+F9gV
	 NpuCsSXAlvohLiTRLM6eE3Y40MXfGpMFwe13hZpUd44falkHsJ0d/6s6Cl5CG6/Yv0NI/
	 w5G8PRIJG9x04huEpvUJXkoI6qeQ1tNGoIJn/puALmz+NcVsNlfdtcCWHuanQgwNhSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK1dH9P1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AE606A321;
	Wed, 25 Nov 2026 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KK1dH9P1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB6B1F000C6;
	Wed, 25 Nov 2026 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795650715;
	bh=eNHNSZn2koSUnpEENTHobyjeI7cVNI7nbjqUeJE3ris=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=KK1dH9P1/U4R9al9H+bwPpOla2CUGftQFTJhl8Lgt7XFGsTPw6Pve3rRsuBwn4hAJ
	 K+MNehvQytF0K0bFEHNKPwXQTJwZGsrKgm0gxG6lgVS2vuFvKbSpkDywNLsS6fyQjj
	 8rqLK8p97vHQC2ZGDeM8IEjsrPBz3IKSOfOz/TG+dQFVxaqx3FoCxOlhIpB8tQM74Z
	 CmNppdlkvPoURS32YSw4X4Z90cXaUFp+72eatK91WTPsm5Hd6qERfIxGb/WA4ceyO5
	 nfAYpIdGiepey8shQrvKE89azGTIioy+fq5M5SWwfa87x5trYF6b9z0QY98n34Xrg7
	 ec/kmYgPTSO3w==
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
Date: Thu, 26 Nov 2026 00:51:45 +0100
Message-Id: <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
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
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 7/9] rust: vfio: add PCI variant driver abstractions
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-8-xinmengs@nvidia.com>
In-Reply-To: <20261119215046.2892839-8-xinmengs@nvidia.com>

On Thu Nov 19, 2026 at 10:50 PM CET, Simon Song wrote:
> diff --git a/rust/kernel/vfio.rs b/rust/kernel/vfio.rs
> index bc50647a2437..43e904e2c980 100644
> --- a/rust/kernel/vfio.rs
> +++ b/rust/kernel/vfio.rs
> @@ -3,7 +3,7 @@
>  //! Virtual Function I/O (VFIO) devices and callback data.
>  //!
>  //! [`DeviceBase`] combines a C VFIO device structure with the data its =
callbacks use.
> -//! [`Device`] is an alias of it for `struct vfio_device`.
> +//! [`Device`] and the bus-specific devices, such as `pci::Device`, are =
aliases of it.

NIT: I'd refer to this as vfio::pci::Device, such that this won't be confus=
ed
with the bus device, and make it an intra-doc link.

>  //!
>  //! C header: [`include/linux/vfio.h`](srctree/include/linux/vfio.h)
> =20
> @@ -26,6 +26,9 @@
>      ptr::NonNull, //
>  };
> =20
> +#[cfg(CONFIG_VFIO_PCI_CORE)]

Until we have the new build system this needs to be
#[cfg(CONFIG_VFIO_PCI_CORE =3D "y")]. The same goes for

	#[cfg(CONFIG_VFIO =3D "y")] pub mod vfio;

in rust/kernel/lib.rs for the preceding patch.

> +pub mod pci;
> +
>  /// Reset the VFIO device.
>  pub const DEVICE_RESET: u32 =3D bindings::VFIO_DEVICE_RESET;
> =20
> @@ -89,7 +92,7 @@ impl IoContext for GetRegionInfo {}
> =20
>  /// The data the driver of a [`Device`] shares with its callbacks.
>  ///
> -/// Bus-specific devices take the data types from their own trait.
> +/// Bus-specific devices take the data types from their own trait, such =
as `pci::Operations`.
>  pub trait Operations: Sized + Send + Sync + 'static {
>      /// Data owned by the registration and passed to VFIO callbacks.
>      ///
> @@ -148,8 +151,8 @@ struct CallbackData<R, O> {
>  /// beginning of `Self`, as `vfio_alloc_device()` requires.
>  ///
>  /// `R` and `O` are the types of the registration data and the open data=
 of `T`, written with
> -/// the placeholder lifetime `'static`. Use the alias [`Device`], which =
takes both from the
> -/// operations trait of `T`.
> +/// the placeholder lifetime `'static`. Use the aliases [`Device`] and `=
pci::Device`, which

Same here.

> +/// The trait for VFIO PCI variant driver implementations.
> +///
> +/// Unoverridden callbacks delegate to the corresponding PCI core operat=
ion.
> +///
> +/// # Lifetime of the callback data
> +///
> +/// [`Registration`] owns the [`RegistrationData`](Operations::Registrat=
ionData), which
> +/// borrows from the PCI binding scope, and each callback borrows it. Ca=
llbacks are generic over
> +/// the lifetime of the registration data, so they cannot store callback=
-local references in it.
> +pub trait Operations: Sized + Send + Sync + 'static {

As mentioned in the previous patch, this should extend vfio::Operations.

> +    /// The name of the VFIO driver.
> +    const NAME: &'static CStr;
> +
> +    /// Data owned by the [`Registration`] and passed to VFIO callbacks.
> +    ///
> +    /// It can borrow resources of the driver's binding for `'a`. Per-de=
vice state lives here.
> +    type RegistrationData<'a>: Send + Sync + 'a;
> +
> +    /// Data shared by callbacks from the first successful open until th=
e last close.
> +    ///
> +    /// It can borrow the registration data, of lifetime `'data`, for `'=
a`.
> +    type OpenData<'a, 'data: 'a>: Send + Sync + 'a;

For the previous patch - as I think it used the same definition - what abou=
t

	type RegistrationData<'reg>: Send + Sync + 'reg;
	type OpenData<'open, 'reg: 'open>: Send + Sync + 'open;

to make it even clearer.

Similar for the callbacks below; I think 'data can be a bit ambiguous in so=
me
cases.

> +
> +    /// Called when the first file descriptor is opened for this device.
> +    ///
> +    /// `vfio_pci_core_enable()` has already succeeded; if this returns =
an
> +    /// error, `vfio_pci_core_disable()` is called automatically. The re=
turned
> +    /// open data is dropped before PCI core close on the last close.
> +    fn open_device<'a, 'data: 'a>(
> +        dev: &'a Device<Self, Open>,
> +        reg_data: &'a Self::RegistrationData<'data>,
> +    ) -> impl PinInit<Self::OpenData<'a, 'data>, Error> + 'a;

Here I'd probably keep 'a as is, but use 'reg instead of 'data.

> +    /// Handle a VFIO ioctl.
> +    ///
> +    /// The default `vfio_pci_core_ioctl()` is available via
> +    /// [`Device::core_ioctl()`] for delegation.
> +    fn ioctl<'data>(
> +        dev: &Device<Self, Ioctl>,
> +        reg_data: &Self::RegistrationData<'data>,
> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        cmd: u32,
> +        arg: usize,
> +    ) -> Result<isize>;
> +
> +    /// Read from the device.
> +    ///
> +    /// `buf` is a user-space buffer provided by the VFIO core. Use
> +    /// [`Device::core_read()`] to delegate the default read, and
> +    /// [`UserBuf::write_overlapping()`] to override specific bytes afte=
rwards.
> +    fn read<'data>(
> +        dev: &Device<Self, Read>,
> +        reg_data: &Self::RegistrationData<'data>,
> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        buf: &mut UserBuf,
> +        ppos: &mut Position<'_>,
> +    ) -> Result<isize>;
> +
> +    /// Write to the device, delegating to [`Device::core_write()`] if a=
ppropriate.
> +    fn write<'data>(
> +        dev: &Device<Self, Write>,
> +        _reg_data: &Self::RegistrationData<'data>,
> +        _open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        buf: &mut UserBuf,
> +        ppos: &mut Position<'_>,
> +    ) -> Result<isize> {
> +        dev.core_write(buf, ppos)
> +    }
> +
> +    /// Map a device region, delegating to [`Device::core_mmap()`] if ap=
propriate.
> +    fn mmap<'data>(
> +        dev: &Device<Self, Mmap>,
> +        _reg_data: &Self::RegistrationData<'data>,
> +        _open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        mapping: &mut Mapping<'_>,
> +    ) -> Result {
> +        dev.core_mmap(mapping)
> +    }
> +
> +    /// Prepare for PCI reset, including resets initiated during enable =
or close.
> +    fn reset_prepare(_reg_data: &Self::RegistrationData<'_>) {}
> +
> +    /// Finish PCI reset; errors are reported through the VFIO error int=
errupt.
> +    fn reset_done(_reg_data: &Self::RegistrationData<'_>) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Fill in region info capabilities.
> +    ///
> +    /// The default `vfio_pci_ioctl_get_region_info()` is available via
> +    /// [`Device::core_get_region_info()`] for delegation.
> +    fn get_region_info<'data>(
> +        dev: &Device<Self, GetRegionInfo>,
> +        reg_data: &Self::RegistrationData<'data>,
> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
> +        info: &mut bindings::vfio_region_info,
> +        caps: &mut InfoCap<'_>,
> +    ) -> Result;
> +}

I think the default behavior of the I/O callbacks (ioctl, read, write, mmap=
, and
get_region_info) probably needs to be revisited and aligned with the C API.

For instance, if write() is omitted we shouldn't call core_write(), but not
install the callback at all.

I suggest to use #[vtable] and #[optional] for this and use the correspondi=
ng
generated flags when constructing the vfio_device_ops.

> +
> +/// A VFIO PCI file position, encoding a region index and an offset with=
in that region.
> +pub struct Position<'a> {
> +    raw: &'a mut i64,

Shouldn't this be just file::Offset?

I don't remember if file::Offset is still an alias of a primitive or a new =
type.

I remember I sent a patch to convert it to a new type in the past, but I do=
n't
remember if I ever followed up on it and if it was merged.

If not, I should probably resend, or please also feel free to pick it up if=
 you
want. In any case, this can happen subsequently and doesn't need to be part=
 of
this series.

> +}
> +
> +impl Position<'_> {
> +    /// Commit a temporary position only after the operation succeeds.
> +    ///
> +    /// This preserves the original position if a read succeeds but a su=
bsequent
> +    /// user copy fails.
> +    pub fn with_temporary<R>(
> +        &mut self,
> +        operation: impl FnOnce(&mut Position<'_>) -> Result<R>,
> +    ) -> Result<R> {
> +        let mut next =3D *self.raw;
> +        let result =3D operation(&mut Position { raw: &mut next })?;
> +        *self.raw =3D next;
> +        Ok(result)
> +    }
> +
> +    /// Returns the PCI region index.
> +    pub fn region_index(&self) -> u32 {
> +        ((*self.raw as u64) >> bindings::VFIO_PCI_OFFSET_SHIFT) as u32
> +    }
> +
> +    /// Returns the byte offset within the current region.
> +    pub fn region_offset(&self) -> u64 {
> +        (*self.raw as u64) & ((1u64 << bindings::VFIO_PCI_OFFSET_SHIFT) =
- 1)
> +    }
> +}
> +
> +/// Mapping metadata supplied by VFIO while the current thread holds the=
 mmap lock.
> +///
> +/// The underlying VMA can only be passed back to the core mmap operatio=
n.
> +pub struct Mapping<'a> {
> +    vma: &'a VmaRef,
> +    _not_thread_safe: NotThreadSafe,
> +}
> +
> +impl Mapping<'_> {
> +    fn page_offset(&self) -> u64 {
> +        // SAFETY: The mmap callback holds the mmap lock for this VMA.

Should probably be:

	// SAFETY: By `VmaRef`'s invariants, the VMA is valid and the
	// mmap/VMA read lock prevents concurrent modification.
=09
> +        unsafe { (*self.vma.as_ptr()).vm_pgoff as u64 }
> +    }

Also, this belongs into VmaRef, so we have to split this out as a separate =
patch
in the next respin.

> +
> +    /// Returns the PCI region index encoded in the mapping offset.
> +    pub fn region_index(&self) -> u32 {
> +        (self.page_offset() >> (bindings::VFIO_PCI_OFFSET_SHIFT as usize=
 - crate::page::PAGE_SHIFT))
> +            as u32
> +    }
> +
> +    /// Returns the byte offset within the PCI region.
> +    fn region_offset(&self) -> u64 {
> +        let mask =3D ((1u64 << bindings::VFIO_PCI_OFFSET_SHIFT) - 1) >> =
crate::page::PAGE_SHIFT;
> +        (self.page_offset() & mask) << crate::page::PAGE_SHIFT
> +    }
> +
> +    /// Returns the requested mapping length in bytes.
> +    fn size(&self) -> Result<u64> {
> +        self.vma
> +            .end()
> +            .checked_sub(self.vma.start())
> +            .map(|size| size as u64)
> +            .ok_or(EOVERFLOW)

I don't think this needs to be fallible, a valid VMA shouldn't be able to
produce an overflow this way.

> +    }

This should probably also be a helper of VmaRef, and hence also a separate
patch.

> +
> +    /// Returns the exclusive end of the requested mapping within the PC=
I region.
> +    pub fn region_end(&self) -> Result<u64> {
> +        self.region_offset()
> +            .checked_add(self.size()?)
> +            .ok_or(EOVERFLOW)
> +    }
> +}

<snip>

> +impl<T: Operations> Device<T> {
> +    /// Allocate a VFIO PCI device for subsequent registration.
> +    pub fn new(pdev: &pci::Device<device::Core<'_>>) -> Result<ARef<Self=
>> {
> +        Self::allocate(pdev, false)
> +    }
> +
> +    /// Allocate a device whose physical BARs may also be exported as DM=
A buffers.
> +    pub fn new_passthrough(pdev: &pci::Device<device::Core<'_>>) -> Resu=
lt<ARef<Self>> {
> +        Self::allocate(pdev, true)
> +    }
> +
> +    fn allocate(pdev: &pci::Device<device::Core<'_>>, passthrough: bool)=
 -> Result<ARef<Self>> {

I usually prefer an enum as it is more descriptive than a bool, but since t=
he
scope is very limited it's probably fine.

> +        let size =3D Kmalloc::aligned_layout(Layout::new::<Self>()).size=
();
> +
> +        // SAFETY: The bound PCI device and static ops are valid. The al=
location
> +        // includes the full Rust wrapper with kmalloc-compatible size a=
nd alignment.
> +        let raw =3D from_err_ptr(unsafe {
> +            bindings::_vfio_alloc_device(size, pdev.as_ref().as_raw(), &=
Self::OPS)
> +        })?;
> +        let this =3D NonNull::new(raw.cast::<Self>()).ok_or(ENOMEM)?;
> +
> +        // SAFETY: `vfio_pci_core_init_dev()` initialized the C device i=
n this new allocation,
> +        // which nothing else can access yet.
> +        unsafe { Self::init(this.as_ptr()) };
> +
> +        if passthrough {
> +            // SAFETY: No registration or callbacks can observe this all=
ocation yet.
> +            unsafe { (*this.as_ref().as_raw()).pci_ops =3D &Self::PASSTH=
ROUGH_OPS };
> +        }
> +
> +        // SAFETY: `this` owns the initial VFIO device reference.
> +        Ok(unsafe { ARef::from_raw(this) })
> +    }
> +}
> +/// # Safety
> +///
> +/// `vdev` must belong to a registered `Device<T>` in VFIO's first-open =
context.
> +/// VFIO must exclude other opens, closes and I/O callbacks for this cal=
l.
> +unsafe extern "C" fn open_device_cb<T: Operations>(vdev: *mut bindings::=
vfio_device) -> c_int {
> +    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the f=
irst-open context.
> +    let dev =3D unsafe { Device::<T, Open>::from_raw_vfio(vdev) };
> +
> +    // SAFETY: Enable the PCI-core side first.
> +    let ret =3D unsafe { bindings::vfio_pci_core_enable(dev.as_raw()) };
> +    if ret !=3D 0 {
> +        return ret;
> +    }
> +
> +    // SAFETY: The previous last close destroyed any earlier open data. =
The open data type
> +    // passed is `T::OpenData`, which only differs in lifetimes from the=
 one of `Device<T>`.
> +    // `T::open_device()` is generic over the lifetimes of its arguments=
, and the closure
> +    // captures nothing but `dev`, which it passes on with the same life=
time as the
> +    // registration data. `close_device_cb()` destroys the open data at =
the last close.
> +    let result =3D unsafe {
> +        dev.open::<T::OpenData<'_, 'static>, _>(|reg_data| T::open_devic=
e(dev, reg_data))
> +    };
> +    match result {
> +        Ok(()) =3D> {
> +            // SAFETY: open succeeded.
> +            unsafe { bindings::vfio_pci_core_finish_enable(dev.as_raw())=
 };
> +            0
> +        }
> +        Err(e) =3D> {
> +            // SAFETY: Undo the enable on failure.
> +            unsafe { bindings::vfio_pci_core_disable(dev.as_raw()) };
> +            e.to_errno()
> +        }
> +    }
> +}

We could wrap everything in a closure and use from_result(), then this beco=
mes:

	unsafe extern "C" fn open_device_cb<T: Operations>(
	    vdev: *mut bindings::vfio_device,
	) -> c_int {
	    from_result(|| {
	        let dev =3D unsafe { Device::<T, Open>::from_raw_vfio(vdev) };
=09
	        to_result(unsafe { bindings::vfio_pci_core_enable(dev.as_raw()) })=
?;
=09
	        unsafe { dev.open(|reg_data| T::open_device(dev, reg_data)) }
	            .inspect_err(|_| {
	                unsafe { bindings::vfio_pci_core_disable(dev.as_raw()) };
	            })?;
=09
	        unsafe { bindings::vfio_pci_core_finish_enable(dev.as_raw()) };
=09
	        Ok(0)
	    })
	}

Which I find a bit cleaner.

> +
> +/// # Safety
> +///
> +/// `vdev` must belong to a registered `Device<T>` whose first open succ=
eeded.
> +/// Call exactly once for the last close, after draining I/O callbacks a=
nd while
> +/// excluding the next first open.
> +unsafe extern "C" fn close_device_cb<T: Operations>(vdev: *mut bindings:=
:vfio_device) {
> +    // SAFETY: `vdev` belongs to a live `Device<T>`.
> +    let dev =3D unsafe { Device::<T>::from_raw_vfio(vdev) };
> +    // SAFETY: Last close drains I/O callbacks and excludes the next fir=
st open.
> +    // Registration data and PCI resources remain valid while open data =
is destroyed.
> +    unsafe { dev.close() };
> +    // SAFETY: Matches the enable in open_device_cb.
> +    unsafe { bindings::vfio_pci_core_close_device(vdev) };
> +}
> +
> +/// # Safety
> +///
> +/// `vdev` must belong to a registered, open `Device<T>` in VFIO's ioctl=
 callback
> +/// context. Registration and open data must remain alive until the call=
 returns.
> +unsafe extern "C" fn ioctl_cb<T: Operations>(
> +    vdev: *mut bindings::vfio_device,
> +    cmd: core::ffi::c_uint,
> +    arg: usize,
> +) -> isize {
> +    // SAFETY: `vdev` belongs to a live `Device<T>`; VFIO provides the i=
octl context.
> +    let dev =3D unsafe { Device::<T, Ioctl>::from_raw_vfio(vdev) };
> +    match dev.callback_data_with(|rd, od| T::ioctl(dev, rd, od, cmd, arg=
)) {
> +        Ok(v) =3D> v,
> +        Err(e) =3D> e.to_errno() as isize,
> +    }

Here and in a couple of other places, this can just be:

	from_result(|| dev.callback_data_with(|rd, od| T::ioctl(dev, rd, od, cmd, =
arg)))

> +/// Keeps the PCI device of a registered VFIO device runtime active.
> +///
> +/// The VFIO PCI core allows runtime suspend of the PCI device while its=
 VFIO device is
> +/// registered, and expects the PCI driver's runtime PM callbacks to cal=
l into the VFIO PCI
> +/// core. These abstractions do not provide such callbacks yet, so the d=
evice must not be
> +/// runtime suspended.
> +///
> +/// # Invariants
> +///
> +/// This type owns a runtime PM usage reference on the device.
> +// TODO: Do not hold this reference for drivers that provide runtime PM =
callbacks, once these
> +// abstractions support them.
> +struct RuntimeActive(#[cfg_attr(not(CONFIG_PM), expect(dead_code))] ARef=
<device::Device>);

This should be &'a Device<Bound>, and hence RuntimeActive<'a>.

> +impl RuntimeActive {
> +    fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
> +        // SAFETY: `dev` is a valid device. This is `pm_runtime_get_sync=
()`, which takes a usage
> +        // reference even if it fails.
> +        #[cfg(CONFIG_PM)]
> +        let ret =3D
> +            unsafe { bindings::__pm_runtime_resume(dev.as_raw(), binding=
s::RPM_GET_PUT as c_int) };
> +        #[cfg(not(CONFIG_PM))]
> +        let ret =3D 0;
> +        // INVARIANT: `this` owns the usage reference, and drops it if t=
he resume failed.
> +        let this =3D Self(dev.into());
> +        to_result(ret)?;
> +        Ok(this)
> +    }
> +}
> +
> +impl Drop for RuntimeActive {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.0` is a valid device, and `new()` took the usag=
e reference dropped
> +        // here. This is `pm_runtime_put()`.
> +        #[cfg(CONFIG_PM)]
> +        unsafe {
> +            bindings::__pm_runtime_idle(
> +                self.0.as_raw(),
> +                (bindings::RPM_GET_PUT | bindings::RPM_ASYNC) as c_int,
> +            )
> +        };
> +    }
> +}

This seems reasonable, but doesn't belong into VFIO core code. This should =
e.g.
go under rust/kernel/device/pm.rs.

However, it would become dead code once we land the runtime PM stuff and en=
able
it for PCI, right? I think an alternative could be to just make nova-vgpu d=
epend
on !PM.

> +impl<T: Operations> Device<T> {
> +    const OPS: bindings::vfio_device_ops =3D build_ops!(T);
> +
> +    const PASSTHROUGH_OPS: bindings::vfio_pci_device_ops =3D bindings::v=
fio_pci_device_ops {
> +        #[cfg(CONFIG_VFIO_PCI_DMABUF)]
> +        get_dmabuf_phys: Some(bindings::vfio_pci_core_get_dmabuf_phys),
> +        #[cfg(not(CONFIG_VFIO_PCI_DMABUF))]
> +        get_dmabuf_phys: None,
> +    };
> +}
> +
> +impl<'a, T: Operations> Registration<'a, T> {
> +    /// Register a previously allocated VFIO PCI device with its callbac=
k data.
> +    ///
> +    /// `dev` must have been allocated for `pdev`, and can be registered=
 only once. `D` is the
> +    /// PCI driver bound to `pdev`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The returned `Registration` must be stored in the bus device pri=
vate data of `D`, the
> +    /// driver bound to `pdev`, and must not be leaked: it has to be dro=
pped while that driver
> +    /// is being unbound from `pdev`, or when its probe fails.
> +    pub unsafe fn new<D: pci::Driver>(
> +        pdev: &'a pci::Device<device::Core<'_>>,
> +        dev: &Device<T>,
> +        reg_data: impl PinInit<T::RegistrationData<'a>, Error>,
> +    ) -> Result<Self> {
> +        build_assert!(
> +            D::DRIVER_MANAGED_DMA.is_some(),
> +            "VFIO drivers must manage DMA ownership"
> +        );
> +        build_assert!(
> +            !D::HAS_SRIOV_ENABLE && !D::HAS_SRIOV_DISABLE,
> +            "VFIO PCI variant drivers do not support SR-IOV configuratio=
n"
> +        );

I think those can be const_assert!().
