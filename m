Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD937BE93;
	Wed, 19 Aug 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166634; cv=none; b=HHHY5X6ilCUbkxK9cGwWC5aR+XT7oKjlI0ptX3eN2ut0fmSAJUNc1nFWhIvVSedvCVMqgw1xl52xTbUvABGkXjWtf2gxxT0U5WrqthYejG7ErfdlHbutf4QevS9zMmdaW5u8+tkgfmGJQTKjjTOtyBcsLaPnW5AyFe4DJKl0B2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166634; c=relaxed/simple;
	bh=ITCF96FeL/eLtCcKYhm2RfXfl4M1xjv6ZiexoCnKmoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o5vaKm8gk4ykDA7w5TEyfwdwTbHmAREgSdVwTJSygTGk46v7/aA/NsiE3YpmUb4gnZbVeN/1rlYnqASybxZJProp0g4+8/pAFR1rYqLQht0np31khgC+/TiKFLEJhCw7YiId9EgwFjOyS4HV+LXKO5IZb85X8wfmHzL9jc3VtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW/FvsxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW/FvsxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF95B1F000E9;
	Wed, 19 Aug 2026 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166633;
	bh=AyyvoKodqYqpU80lwF+NSxmd9IxsbiQ4WNMYubock7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iW/FvsxVe0QYETz6TU1a7amqawv030lgT/JrRqOYgOtncDHBUTK3gE3i1/bZIDNHm
	 ocHxpAqUGPwIzoJiO0OG1+kU5RzxIAfdKgPAbsotZ6LSGBKSYFDmiOoM7KoHOL6cgk
	 MOnUOuCYX+6QEgBuft+xtwpx2yIatN3sc8WMU/iq4UrzwEsIcQ1HN4YFv27SqNuo3Y
	 Sl8w8ph7LPy9xHDpGlpOKGHfIuSV8bytYF0rZYf95LH2P1WsBOM/N/ienO3zTkqSda
	 C45XkA0fJbA76qp+arJZ2p5ZoWy0I1PpfrJE7GiiqSCKvYAMPLiQfAjddbCL2V6kpv
	 nuumnkxsRd3Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v23 3/3] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: lee@kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260819-rust_leds-v23-3-2716a4ef89a4@posteo.de>
References: <20260819-rust_leds-v23-0-2716a4ef89a4@posteo.de>
 <20260819-rust_leds-v23-3-2716a4ef89a4@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:10:32 +0000
Message-Id: <20260819191032.DF95B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect manual reference count management for `fwnode` causes me=
mory leaks and potential Use-After-Free (UAF).
- [High] Plain, unsynchronized reads of `intensity` and `brightness` from `=
UnsafeCell` cause data races and Undefined Behavior.
- [Low] The commit message violates formatting conventions (capitalization)=
 and contains a typo.
--

--- Patch [3]: [PATCH RESEND v23 3/3] rust: leds: add multicolor classdev a=
bstractions ---
commit 2486b1ac4294e9421b47197f76e5b346cbfb370a
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

This patch implements the abstractions needed for multicolor led class devi=
ces.
It introduces the MultiColor mode, MultiColorSubLed wrapper, MultiColorDevi=
ce
wrapper, and device builder functions.

> rust: leds: add multicolor classdev abstractions

[Severity: Low]
This isn't a bug, but the commit message subject violates the subsystem
capitalization convention. Could this be capitalized as "Add multicolor..."?

> * `MultiColorSubLed` - a safe wrapper arround `mc_subled`

[Severity: Low]
This isn't a bug, but there is a typo (arround) in the commit message.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs

[ ... ]

> +    pub const fn intensity(&self) -> u32 {
> +        // SAFETY:
> +        // - `self.intensity.get()` is a valid pointer to `u32`.
> +        // - We don't have exclusive or immutable access to `self.intens=
ity`,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.intensity.get() }
> +    }
> +
> +    /// The brightness of the sub led.
> +    #[inline]
> +    pub const fn brightness(&self) -> u32 {
> +        // SAFETY:
> +        // - `self.brightness.get()` is a valid pointer to `u32`.
> +        // - We don't have exclusive or immutable access to `self.bright=
ness`,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.brightness.get() }
> +    }

[Severity: High]
Can these plain reads cause data races and undefined behavior?

Since MultiColorDevice implements Sync, references can be safely shared acr=
oss
threads. At the same time, the C LED subsystem can concurrently mutate these
fields asynchronously, for example via sysfs writes handled by
multi_intensity_store() or background state calculations in
led_mc_calc_color_components().

Concurrent unsynchronized read/write accesses to the same memory location,
where at least one is a write, are formal data races in Rust. Could these be
wrapped with proper atomic accesses or synchronization?

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
> +
> +                Ok::<_, Error>(())

[Severity: High]
Can this sequence cause a reference leak or a use-after-free for the fwnode?

If a device name is provided, led_classdev_multicolor_register_ext() is cal=
led
with a null pointer for init_data to force the use of the provided name.
Consequently, the C LED subsystem does not copy the fwnode from init_data i=
nto
the device.

However, this code unconditionally calls core::mem::forget(self.fwnode).

If self.fwnode was Some, its reference count is leaked because
MultiColorDevice::drop() will later attempt to recover it using dev.fwnode(=
),
which will return None.

[ ... ]

> +#[pinned_drop]
> +impl<'bound, T: LedOps<Mode =3D MultiColor> + 'bound> PinnedDrop for Mul=
tiColorDevice<'bound, T> {
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
> +            // incremented in `led::DeviceBuilder::build_multicolor`.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Following up on the previous observation, if self.fwnode was initially None,
but the C driver core later sets dev->fwnode (for example, via device_set_n=
ode
from an ACPI table or parent), could this code wrap that unowned pointer in
ARef::from_raw and improperly decrement its refcount upon destruction, caus=
ing
a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-rust_leds-=
v23-0-2716a4ef89a4@posteo.de?part=3D3
