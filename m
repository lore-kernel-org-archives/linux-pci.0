Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7613D9695
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504783; cv=none; b=hpTy5HWri+mUKJlhR2s5uBS1jw3z1OK2VQD6B1qsPFWejhKYYyccTDDk8Jx7OVj4Sa9I9WGUQ/kYrjFejoFYRvrMl2m41ZlG5nC+tn93Qv+faCAvoJ5XTiGBFSPO2+FcFtzGkxLps8jaOAmPhI/nDrxM6zKaD/yEQJXxkia3kHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504783; c=relaxed/simple;
	bh=vneAbs4Rw8ed5dFG2IXnldwZPBJlSxDvcQHIFnAk7gI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFpCXWfeTlm+myiG80pvB+DGOHXK0LBKZe45Hh5BNcf4WivAcQeeH7ea/6/HfEisayEcpJacO2cPCBIsaFMDcM4cTSVuFnEAEaDo9Saf2Xd6syN0WBJhZbqPsINjraK3ZFZcxVQIsLOdyYp5tyCQg3eD9AxDhXtoxTZt8BGHr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrBgib/M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrBgib/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECB51F00893;
	Wed,  3 Jun 2026 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504781;
	bh=z6Y0UxaNkYg1xfMBWaKJK5uGxcvYBdd56ek4y1YNLy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MrBgib/MuxlX5lnBa8LU824bnMeANC7hcrzMJV3J6g/Qmu7sAd6Xe7Kk8IdACa6t0
	 tR79TV13bPGuywehsH5FSVy8Yjl63NiI4g67Xf2U7HZtxVqk1B86Ycx6d6DyApuWfo
	 YHVafWgoqFueu76/aBnU26q8EWTc//NcXuSs6tM1gbfuwhMk/HlsDbpdHaun5Q+Yy4
	 KCsedLQyc34Qkk/z9avD5W3dmDjg2Fy0C5IaB4GN/gLQjv15T+gqQQeeYC/OsJJQBZ
	 7H4+uuyBVBUmvhkBerSd7xkDSx1zv/Yu2SOnVg+C13PyWVNmDZIDvezETd767FqTcN
	 9ptk2pIBfE5mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/3] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260603-rust_leds-v19-3-2a71085deae3@posteo.de>
References: <20260603-rust_leds-v19-3-2a71085deae3@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:39:40 +0000
Message-Id: <20260603163941.5ECB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Reconstructing `KVec` with `num_colors` as capacity leads to Undef=
ined Behavior due to a capacity and type mismatch.
- [High] Exposing `brightness` and `intensity` as plain `u32` fields in a s=
hared reference `&[MultiColorSubLed]` violates Rust's aliasing rules and in=
troduces data races.
- [High] The `MultiColorDevice` API has a soundness hole that fails to capt=
ure the `'a` lifetime of the `name` string, leading to a Use-After-Free of =
`led_cdev->name`.
--

commit a904c5bd0f7e2718f470d76c33437063136b14c4
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

Implement the abstractions needed for multicolor led class devices,
including MultiColor, MultiColorSubLed, MultiColorDevice, and build_multico=
lor.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..973c18c5566d1
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs

[ ... ]

> +#[repr(C)]
> +#[derive(Copy, Clone, Debug)]
> +#[non_exhaustive]
> +pub struct MultiColorSubLed {
> +    /// the color of the sub led
> +    pub color: Color,
> +    /// the brightness of the sub led.
> +    ///
> +    /// The value will be automatically calculated.
> +    pub brightness: u32,
> +    /// the intensity of the sub led.
> +    pub intensity: u32,

[Severity: High]
Will exposing brightness and intensity as plain u32 fields violate Rust's
aliasing rules?

When a driver calls subleds() to get a &[MultiColorSubLed], it receives an
immutable reference which guarantees the underlying memory won't be modified
concurrently. However, the C LED subsystem can mutate these fields
concurrently (for instance, via multi_intensity_store() or
led_mc_calc_color_components()). Should these fields be wrapped in Opaque<u=
32>
or UnsafeCell<u32> to allow safe concurrent modifications?

> +    /// arbitrary data for the driver to store.
> +    pub channel: u32,
> +}

[ ... ]

> +impl<'a, S: DeviceBuilderState> DeviceBuilder<'a, S> {
> +    /// Registers a new [`MulticolorDevice`].
> +    pub fn build_multicolor<'bound: 'a, T: LedOps<Mode =3D MultiColor> +=
 'bound>(
> +        self,
> +        parent: &'bound T::Bus,
> +        ops: impl PinInit<T, Error> + 'a,
> +        subleds: &'a [MultiColorSubLed],
> +    ) -> impl PinInit<MultiColorDevice<'bound, T>, Error> + 'a {

[Severity: High]
Could the returned initialization type fail to capture the 'a lifetime of
the name string in DeviceBuilder?

Because MultiColorDevice<'bound, T> does not capture 'a, safe code might
pass a short-lived stack-allocated CString to the builder and drop it after
registration, while the registered MultiColorDevice remains alive.

> +        const_assert!(T::MAX_BRIGHTNESS <=3D i32::MAX.unsigned_abs() || =
!T::HAS_BRIGHTNESS_GET);
> +
> +        try_pin_init!(MultiColorDevice {
> +            ops <- ops,
> +            classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_cl=
assdev_mc| {

[ ... ]

> +                let mut subleds_vec =3D KVec::new();
> +                subleds_vec.extend_from_slice(subleds, GFP_KERNEL)?;
> +                let (subled_info, num_colors, capacity) =3D subleds_vec.=
into_raw_parts();
> +                debug_assert_eq!(num_colors, capacity);

[Severity: High]
Can discarding the true capacity from into_raw_parts() lead to undefined
behavior during deallocation?

When extend_from_slice() allocates the underlying buffer, the allocator may
reserve a larger capacity than exactly num_colors. If the true capacity is
discarded, later reconstructing the vector with capacity set to num_colors
violates the from_raw_parts() safety contract and could pass the wrong
layout to the deallocator.

> +
> +                let subled_guard =3D ScopeGuard::new(|| {
> +                    // SAFETY: `subled_info` is guaranteed to be a valid=
 array pointer to
> +                    // `mc_subled` with the length and capacity of `num_=
colors`.
> +                    drop(unsafe { KVec::from_raw_parts(subled_info, num_=
colors, num_colors) });
> +                });

[ ... ]

> +                unsafe {
> +                    ptr.write(bindings::led_classdev_mc {
> +                        led_cdev: bindings::led_classdev {
> +                            brightness_set: (!T::BLOCKING)
> +                                .then_some(Adapter::<T>::brightness_set_=
callback),
> +                            brightness_set_blocking: T::BLOCKING
> +                                .then_some(Adapter::<T>::brightness_set_=
blocking_callback),
> +                            brightness_get: T::HAS_BRIGHTNESS_GET
> +                                .then_some(Adapter::<T>::brightness_get_=
callback),
> +                            blink_set: T::HAS_BLINK_SET
> +                                .then_some(Adapter::<T>::blink_set_callb=
ack),
> +                            max_brightness: T::MAX_BRIGHTNESS,
> +                            brightness: self.initial_brightness,
> +                            color: self.color as u32,
> +                            name: self.name.map_or(core::ptr::null(), CS=
trExt::as_char_ptr),

[Severity: High]
Might assigning self.name directly to the C struct without copying result in
a use-after-free?

If the DeviceBuilder was provided a short-lived string, this pointer will
become dangling once the string is dropped, as mentioned above. Should the =
API
require &'static CStr or duplicate the string to avoid a use-after-free?

> +                            ..bindings::led_classdev::default()
> +                        },

[ ... ]

> +    /// Returns the subleds passed to [`Device::new_multicolor`].
> +    #[inline]
> +    pub fn subleds(&self) -> &[MultiColorSubLed] {

[Severity: High]
Is it safe to return a shared reference &[MultiColorSubLed] when C code may
concurrently mutate fields?

Because MultiColorDevice is Sync, drivers might retain this slice and
concurrently read the brightness and intensity fields. Since they are plain
u32 fields, this could introduce data races.

> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `led_classdev_mc`.
> +        let raw =3D unsafe { &*self.classdev.get() };

[ ... ]

> +#[pinned_drop]
> +impl<'bound, T: LedOps<Mode =3D MultiColor> + 'bound> PinnedDrop for Mul=
tiColorDevice<'bound, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let raw =3D self.classdev.get();

[ ... ]

> +        // SAFETY: `subled_info` is guaranteed to be a valid array point=
er to `mc_subled` with the
> +        // length and capacity of `led_cdev.num_colors`. See `led::Multi=
colorDevice::new`.
> +        drop(unsafe {
> +            KVec::from_raw_parts(
> +                led_cdev.subled_info,
> +                led_cdev.num_colors as usize,
> +                led_cdev.num_colors as usize,
> +            )
> +        });
> +    }
> +}

[Severity: High]
Does this KVec reconstruction cause undefined behavior upon deallocation?

Similar to the ScopeGuard above, passing num_colors as the capacity
instead of the original capacity violates the from_raw_parts() contract.
Additionally, reconstructing using KVec::from_raw_parts with
bindings::mc_subled instead of the original MultiColorSubLed type might
violate allocator provenance rules.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rust_leds-=
v19-0-2a71085deae3@posteo.de?part=3D3
