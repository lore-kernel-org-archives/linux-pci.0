Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30B36B916;
	Wed,  2 Sep 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390946; cv=none; b=iV11AtFBUbAD6mzeaVVDnR9azSXGet3EkuWJGgVqgooEL3QFacfWb0X1pPVzlZ+sLuLge9PQVi69GmzMOqNOxUMJ38wJBPGSRWDpB7N8rfl1hN9F51equPl2/u06hpFlhYrhFM/0U6ZWD/uqpvszKtoGh/UeRj8/QMekOwmgdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390946; c=relaxed/simple;
	bh=mSIjXerd9c2NrsfzejV1Zedz2gS+NAORjH+eoOiw5r4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwRT95L9OqQjEKZlHQQkfOnyqG9KBFh1dyxxgzRikOdWmrzkxuZsKeLrrH/cihfSYldyjzJr9Y987/B97LNpxmF1iXKcd6sTp1De3LbNhPAu0GRM6WfvAM1kn8y3k04dE7imU0RpBvh+gmDj4KstgawH607TbFNeRv0FpOl8rjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl3+/iIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl3+/iIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C71F000E9;
	Wed,  2 Sep 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788390944;
	bh=oV/OhCkAwPHzYawzL6JdZ50KXObhcHZIj7w2jnDf39c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hl3+/iInjTl78IlWHZ7Fs/nmV8HYBhDKNOmWVNT1oXTUqQcMUWNHBs8+jRne1cvta
	 UGOXjYYqQtGPNnTPxrCmnWaFUTZasFaXTYO9tgPI2VpUvLVuHzlayrsdbjEUv+xL5C
	 MLZnyIIe+IXDeVt9wDPcD273DPVJNZgonS8RcOMw8sgBr73nudlNxIguJKUZ+h4LFO
	 E/7+C/m+tsQuzg4WDdxGPD5lGJMd+VlPfTIp3E6xa9SDgWK2joVxJWgJsAekZah0Rb
	 qO3cPEThT75NIPLm+ZMJkUZUO8w3fJpiG+0l83t+32EZFLQV3q8HQljgWMWBJ/Jwpr
	 rge1oSjDGhDGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 3/4] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: lee@kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260903-rust_leds-v24-3-8d9e4c04db69@posteo.de>
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
 <20260903-rust_leds-v24-3-8d9e4c04db69@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:15:44 +0000
Message-Id: <20260902231544.8B2C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Plain non-atomic reads of `intensity` and `brightness` from `Unsaf=
eCell` in `MultiColorSubLed` cause a data race and Undefined Behavior with =
concurrent C subsystem modifications.
- [High] Calling `led_mc_calc_color_components` outside of the driver's loc=
king creates a data race and TOCTOU vulnerability.
- [High] Casting concurrent pointers to `&mut usize` in `blink_set_callback=
` creates an aliasing violation (Undefined Behavior).
- [Low] The commit message description is not capitalized, violating the LE=
D subsystem guidelines.
--

commit 0c1eb1680fe4ed1aa0ee60e6b95decec69575365
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

This commit introduces the necessary Rust abstractions to support multicolor
LED class devices. It provides wrappers around the C structures mc_subled
and led_classdev_mc, alongside integration with the LED device builder.

> rust: leds: add multicolor classdev abstractions
>
> Implement the abstractions needed for multicolor led class devices,

[Severity: Low]
This isn't a bug, but the LED subsystem guidelines require capitalizing the
description after the subsystem prefix. Should the subject be capitalized as
"Add multicolor classdev abstractions", and similarly the body text?

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs
[ ... ]
> +impl MultiColorSubLed {
[ ... ]
> +    pub const fn intensity(&self) -> u32 {
> +        // SAFETY:
> +        // - self.intensity.get() is a valid pointer to u32.
> +        // - We don't have exclusive or immutable access to self.intensi=
ty,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.intensity.get() }
> +    }

[Severity: High]
Does this plain read cause Undefined Behavior under Rust's concurrency rule=
s?

If a trigger from timer or interrupt context calls intensity() concurrently
while sysfs (via multi_intensity_store) modifies the memory under the
led_access mutex, this creates a data race.

Since plain non-atomic reads of concurrently mutated memory are considered
Undefined Behavior in Rust, should this use an atomic read or read_volatile
instead?

> +
> +    /// The brightness of the sub led.
> +    #[inline]
> +    pub const fn brightness(&self) -> u32 {
> +        // SAFETY:
> +        // - self.brightness.get() is a valid pointer to u32.
> +        // - We don't have exclusive or immutable access to self.brightn=
ess,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.brightness.get() }
> +    }

[Severity: High]
Does this have the same data race and Undefined Behavior issue as the
intensity() read above?

[ ... ]
> +    unsafe extern "C" fn brightness_set_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        brightness: u32,
> +    ) {
[ ... ]
> +        // SAFETY: classdev.classdev.get() is guaranteed to be a pointer=
 to a valid
> +        // led_classdev_mc.
> +        unsafe { bindings::led_mc_calc_color_components(classdev.classde=
v.get(), brightness) };
> +
> +        let _ =3D classdev.ops.brightness_set(parent, classdev, brightne=
ss);
> +    }

[Severity: High]
Can calling bindings::led_mc_calc_color_components() before the driver=20
acquires its lock cause data corruption of the hardware state?

Concurrent calls to brightness_set_callback, for example from sysfs and a
hardware trigger, will execute bindings::led_mc_calc_color_components()
outside any locks, racing to overwrite the subled_info array.=20

The driver's lock in classdev.ops.brightness_set is acquired too late to
prevent this corruption. Should C drivers invoke
bindings::led_mc_calc_color_components() while holding their own lock
instead?

[ ... ]
> +    unsafe extern "C" fn brightness_set_blocking_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        brightness: u32,
> +    ) -> i32 {
> +        from_result(|| {
[ ... ]
> +            // SAFETY: classdev.classdev.get() is guaranteed to be a poi=
nter to a valid
> +            // led_classdev_mc.
> +            unsafe { bindings::led_mc_calc_color_components(classdev.cla=
ssdev.get(), brightness) };
> +
> +            classdev.ops.brightness_set(parent, classdev, brightness)?;
> +            Ok(0)
> +        })
> +    }

[Severity: High]
Does this have the same data race vulnerability as brightness_set_callback()
above?

[ ... ]
> +    unsafe extern "C" fn blink_set_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        delay_on: *mut usize,
> +        delay_off: *mut usize,
> +    ) -> i32 {
> +        from_result(|| {
[ ... ]
> +            classdev.ops.blink_set(
> +                parent,
> +                classdev,
> +                // SAFETY: The function's contract guarantees that delay=
_on points to a usize
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_on },
> +                // SAFETY: The function's contract guarantees that delay=
_off points to a usize
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_off },
> +            )?;
> +            Ok(0)
> +        })
> +    }

[Severity: High]
Does casting these pointers to exclusive mutable references violate Rust's
aliasing rules and cause Undefined Behavior?

The C subsystem calls blink_set with pointers to led_cdev->blink_delay_on
and blink_delay_off. Concurrently, sysfs handlers like delay_on_store write
to these fields without taking a lock.=20
   =20
Casting these shared, concurrently accessed pointers to exclusive mutable
references falsely asserts exclusive access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-rust_leds-=
v24-0-8d9e4c04db69@posteo.de?part=3D3
