Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD21288D0
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110630; cv=none; b=Apb109xuwz0MdK0bZgsmFPiOiDobcXNa7t3Q0PwoIv1lNdnydXIC5oflrmci1IstQtEHTLUM+1Ah1JN4933kS1taj7C5Lg3abY+t1YMhmjVDsMYwGmrsiUsnpPD7i/NTGQv08kOrJLJbuvQ7Hoy0zEO0E5fCnMOZlxX7PKwan5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110630; c=relaxed/simple;
	bh=PstWNaS9wVwM9Xyh/sz69ieg9Bk2KHHpV5gu08rXJ3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yw4nhaqE3bQPnWrSCPJ4fjmJqEuVSXP2xT2CV8g2fHMSGMXQmjS1TCGYAoFjbyuSmbKMAi4iBRzu2dXLNAfiLyeFMjbYOoUZcfYMr0LtPAZzFyW8zT3eGvGYGSIaEBXxVQAbK9yVzondKS7awXq/xJeT2nc31f/SvDOIVPZt/44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJMnuwGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJMnuwGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA331F0089A;
	Sat, 30 May 2026 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780110615;
	bh=lQLk8yyglFEQ/F5bN9UI8o7ZMlKyFrtoLePswOir5S8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJMnuwGXuwD56H4VagW0rKQgm8zIkIMhxhLY5JrtOiGJPWOVKy74/UouDRfK33yW9
	 f1fGL2B5k4APd8Yo+KKwOewKCnTKqf3ADYTKfHGbu01WAHHF0I2CrXUyv0aFesmTgv
	 BRoEzNmNeiCfAJ9fo/BSkV6xmGZ2XDA47MckiZuneETR3J66mDwjwGw/bBaZkLmAke
	 naumjVj3HJ/89GS7rI3WsnX8S2N/Lw2ir2ey4eW8ljz2H4kS9ElWqdTUe6QBXVfDhL
	 aQG1VsrwLBbALLuI1CvnHEgJj+89g/PVrOj9CAi8m0hV8LWQqC5OonocKYFPRM7Zru
	 PGFTk12ZZEtrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 3/3] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260530-rust_leds-v17-3-c0698c4368e2@posteo.de>
References: <20260530-rust_leds-v17-3-c0698c4368e2@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 03:10:14 +0000
Message-Id: <20260530031015.7CA331F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Data race and Undefined Behavior in `MultiColorDevice::subleds()` =
due to exposing concurrently mutable fields without interior mutability.
- [High] Undefined Behavior due to mismatched capacity when reconstructing =
`KVec` during teardown and error handling.
- [High] Incorrect `fwnode` reference management when `name` is provided le=
ads to permanent memory leaks and refcount underflow (Use-After-Free).
- [Low] Missing `#[inline]` annotation on small forwarding abstraction func=
tion.
--

commit 9445e701d1ca0b8b1d07c7890ba8fe351626ede1
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

This commit implements the abstractions needed for multicolor led class
devices. It introduces the led mode implementation, a wrapper around
mc_subled, and a function to register a new multicolor led class device.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..524d6e98562aa
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs

[ ... ]

> +pub struct MultiColorSubLed {
> +    /// the color of the sub led
> +    pub color: Color,
> +    /// the brightness of the sub led.
> +    ///
> +    /// The value will be automatically calculated.
> +    /// See `MultiColor::pre_brightness_set`.
> +    pub brightness: u32,
> +    /// the intensity of the sub led.
> +    pub intensity: u32,
> +    /// arbitrary data for the driver to store.
> +    pub channel: u32,
> +}

[ ... ]

> +                    let mut subleds_vec =3D KVec::new();
> +                    subleds_vec.extend_from_slice(subleds, GFP_KERNEL)?;
> +                    let (subled_info, num_colors, capacity) =3D subleds_=
vec.into_raw_parts();
> +                    debug_assert_eq!(num_colors, capacity);
> +
> +                    let subled_guard =3D ScopeGuard::new(|| {
> +                        // SAFETY: `subled_info` is guaranteed to be a v=
alid array pointer to
> +                        // `mc_subled` with the length and capacity of `=
num_colors`.
> +                        drop(unsafe { KVec::from_raw_parts(subled_info, =
num_colors, num_colors) });
> +                    });

[Severity: High]
Could reconstructing the vector using num_colors instead of the original
capacity cause undefined behavior during deallocation?

The extend_from_slice() call might allocate memory with a capacity strictly
greater than num_colors. By discarding the true capacity and passing
num_colors to KVec::from_raw_parts(), the safety contract is violated.

Rust requires the capacity passed to from_raw_parts() to exactly match the
original allocation capacity, otherwise it can produce an incorrect layout
during deallocation.

[ ... ]

> +                    // SAFETY:
> +                    // - `parent.as_ref().as_raw()` is guaranteed to be =
a pointer to a valid
> +                    //    `device`.
> +                    // - `ptr` is guaranteed to be a pointer to an initi=
alized `led_classdev_mc`.
> +                    to_result(unsafe {
> +                        bindings::led_classdev_multicolor_register_ext(
> +                            parent.as_ref().as_raw(),
> +                            ptr,
> +                            if self.name.is_none() {
> +                                &raw mut init_data
> +                            } else {
> +                                core::ptr::null_mut()
> +                            },
> +                        )
> +                    })?;
> +
> +                    subled_guard.dismiss();
> +
> +                    core::mem::forget(self.fwnode); // keep the referenc=
e count incremented

[Severity: High]
Does this sequence leak the fwnode reference when a name is provided?

If self.name is provided, core::ptr::null_mut() is passed instead of
init_data, meaning the C subsystem never takes ownership of the provided
fwnode. However, core::mem::forget(self.fwnode) is called unconditionally,
which would permanently leak the reference in this case.

[ ... ]

> +impl<T: LedOps<Mode =3D MultiColor>> MultiColorDevice<T> {
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::MultiColorDevice`.
> +    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a=
 Self {

[Severity: Low]
Should this small forwarding function have an #[inline] annotation?

The Rust subsystem guidelines require that functions which are small or
forwarding to a binding call should be annotated with #[inline].

[ ... ]

> +    /// Returns the subleds passed to [`Device::new_multicolor`].
> +    #[inline]
> +    pub fn subleds(&self) -> &[MultiColorSubLed] {

[Severity: High]
Does returning a shared slice of MultiColorSubLed here lead to undefined
behavior if the C subsystem mutates the fields?

When the C LED subsystem mutates the brightness fields of mc_subled
concurrently (such as in led_mc_calc_color_components()), it modifies the
underlying memory.

Since MultiColorSubLed defines these fields as plain u32 types and we return
a safe &[MultiColorSubLed] slice, Rust's strict aliasing rules are violated
because shared references guarantee memory immutability without an interior
mutability primitive.

[ ... ]

> +#[pinned_drop]
> +impl<T: LedOps<Mode =3D MultiColor>> PinnedDrop for MultiColorDevice<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let raw =3D self.classdev.get();
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `led_classdev_mc`.
> +        let dev: &device::Device =3D unsafe { device::Device::from_raw((=
*raw).led_cdev.dev) };
> +
> +        let _fwnode =3D dev
> +            .fwnode()
> +            // SAFETY: the reference count of `fwnode` has previously be=
en
> +            // incremented in `led::Device::new`.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Could this underflow the parent device's fwnode reference count?

If init_data was ignored during registration (because self.name was set), t=
he
C core typically assigns the parent device's fwnode to the new LED device
without incrementing its refcount.

During drop, the teardown logic blindly steals a reference via
ARef::from_raw() and drops it, which would underflow the parent device's
fwnode refcount and potentially cause a use-after-free.

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
Similar to the error path above, could reconstructing the vector using
num_colors instead of the original capacity cause undefined behavior during
deallocation here?

The extend_from_slice() call during initialization might allocate memory wi=
th
a capacity strictly greater than num_colors. Discarding the true capacity a=
nd
passing num_colors to KVec::from_raw_parts() violates the safety contract
and can produce an incorrect layout during deallocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530-rust_leds-=
v17-0-c0698c4368e2@posteo.de?part=3D3
