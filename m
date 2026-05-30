Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB992DC79A
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780183548; cv=none; b=lBVDSnT6eDlzVncARQDPy1wO6s04vhEdHaEUbfNjYO2bAVwzJZZ+gRIaq5DIUnEB5V3tAy1Z95dvuO+aq1SP2//ERS2Sh2nlxht87yIAZWg3VGMlHd/YJbxnD22ITT4u2I1z1w69h+bQdTbcBbCf/WY4W7fV2UNgCjOQCJMjPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780183548; c=relaxed/simple;
	bh=/W9nCTuaPY9uDogELvAtUdr9mPSaU4qk1ES25adKVvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CQSHXqWPiolX9IgeEJ1qp2jfh/oG7ejDanyNFanmq/qr4UbqRLFNQpOApoXLUcWj8YhESXx7YmEIhn/tSKNRwxN/U8Gq2BDQx866v8NojuzFiqA8yk8112J/C6Yq83N6EhNMVL9uAiM5lotRg352TiZEVbVLQsA33Acumbfe2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZTLYlfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZTLYlfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED31F00893;
	Sat, 30 May 2026 23:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780183546;
	bh=FVqovpiHXQwz4JsagTZnyLvJClvxcOif6x/SCu4lLeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZTLYlfB06y/c+IliqKWL+0T9txF7Vs5sBFNBFw7Sfqum7I9R3UtIM2SrqJbT9kCp
	 6y/mAaQTt12GHcjNK+ksMpZEKeMA5A6eL+xXgL2nytLbC/FfsWlXDhymlHS8Sxh8o5
	 RP3kEIGdEvazYJhAt/EDov2AJKW2ZFG+/o7oyYzikxejk029jvtYL/LILIAtiYMjkd
	 pMXwcgbB2oT0R05a1GrnoNgyfivxdNBIubIm4Fxe3UVImcVwqQ8XRENMZnp7Ef/oTw
	 FOyN3aMxprQUeGheltGY4uEOIV2+/teKO/c96iO9dzBrLQ7LagsB0fWJyVk2lc48BU
	 NAQvVSh31YI9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 3/3] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260531-rust_leds-v18-3-d07102ba5170@posteo.de>
References: <20260531-rust_leds-v18-3-d07102ba5170@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 23:25:45 +0000
Message-Id: <20260530232546.53ED31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Data race and Undefined Behavior due to `&[MultiColorSubLed]` expo=
sing concurrently mutated plain `u32` fields.
- [High] Reconstructing KVec with a hardcoded capacity violates the `KVec::=
from_raw_parts` safety contract.
- [High] FwNode reference count leak or Use-After-Free when `name` is expli=
citly set.
- [Low] Dead documentation link for `MultiColorSubLed::brightness`.
- [Low] Missing `#[inline]` attribute on the `from_raw` internal helper fun=
ction.
--

commit 06862c24665d65b7a33c6a01c9dd3881267810e1
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions
   =20
Implement the abstractions needed for multicolor led class devices,
including `led::MultiColor` and `MultiColorDevice`.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..18c9d36221f1e
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
> +    /// See `MultiColor::pre_brightness_set`.

[Severity: Low]
Is the reference to MultiColor::pre_brightness_set correct?  This function
does not appear to exist in the code, and MultiColor is a marker enum.

> +    pub brightness: u32,
> +    /// the intensity of the sub led.
> +    pub intensity: u32,
> +    /// arbitrary data for the driver to store.
> +    pub channel: u32,
> +}

[Severity: High]
Does this expose concurrently mutated fields as plain integers?

When the C kernel LED core modifies the subled values (for instance, via
led_mc_calc_color_components modifying brightness during sysfs writes),
these fields are mutated without Rust-visible synchronization.

Since MultiColorDevice::subleds() hands out a shared, immutable slice
&[MultiColorSubLed] to the driver, does using plain u32 instead of
interior mutability primitives like Opaque or UnsafeCell violate strict
aliasing invariants and risk undefined behavior?

[ ... ]

> +                let subled_guard =3D ScopeGuard::new(|| {
> +                    // SAFETY: `subled_info` is guaranteed to be a valid=
 array pointer to
> +                    // `mc_subled` with the length and capacity of `num_=
colors`.
> +                    drop(unsafe { KVec::from_raw_parts(subled_info, num_=
colors, num_colors) });
> +                });

[Severity: High]
Is it safe to hardcode the capacity to num_colors when reconstructing
this KVec?

The original KVec was dynamically allocated using extend_from_slice(subleds)
which could potentially over-allocate.  Since the exact allocated capacity=
=20
is verified but then discarded, reconstructing the KVec here (and during=20
PinnedDrop) with num_colors as the capacity might violate=20
KVec::from_raw_parts safety contract.

Should the exact capacity be stored, or perhaps a boxed slice (KBox<[T]>)
used instead to ensure the allocator frees the correct size?

[ ... ]

> +                // SAFETY:
> +                // - `parent.as_ref().as_raw()` is guaranteed to be a po=
inter to a valid
> +                //    `device`.
> +                // - `ptr` is guaranteed to be a pointer to an initializ=
ed `led_classdev_mc`.
> +                to_result(unsafe {
> +                    bindings::led_classdev_multicolor_register_ext(
> +                        parent.as_ref().as_raw(),
> +                        ptr,
> +                        if self.name.is_none() {
> +                            &raw mut init_data
> +                        } else {
> +                            core::ptr::null_mut()
> +                        },
> +                    )
> +                })?;
> +
> +                subled_guard.dismiss();
> +
> +                core::mem::forget(self.fwnode); // keep the reference co=
unt incremented

[Severity: High]
Could this lead to a fwnode reference count leak or a use-after-free if
self.name is configured?

If self.name is set, a null pointer is passed to register the device instead
of &mut init_data, meaning the C device does not inherit the provided fwnod=
e.
However, self.fwnode is unconditionally forgotten, which leaves its referen=
ce
count incremented.

Later, during device drop, dev.fwnode() is queried to decrement the refcoun=
t.
If the device has no fwnode, it returns None, permanently leaking the origi=
nal
fwnode. If the device inherited a fwnode from its parent, dev.fwnode() would
return the parent's fwnode, incorrectly decrementing it and potentially cau=
sing
a use-after-free of the parent's fwnode.

[ ... ]

> +impl<'bound, T: LedOps<Mode =3D MultiColor> + 'bound> MultiColorDevice<'=
bound, T> {
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::MultiColorDevice`.
> +    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a=
 Self {

[Severity: Low]
this isn't a bug, but should this internal helper function have an #[inline]
attribute?

According to the Rust subsystem guidelines, small internal helper functions
within abstractions should be annotated with #[inline]. Since this method
consists exclusively of unsafe pointer arithmetic (container_of!), it seems
it should be inlined.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531-rust_leds-=
v18-0-d07102ba5170@posteo.de?part=3D3
