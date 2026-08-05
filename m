Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356B3E168C;
	Wed,  5 Aug 2026 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963134; cv=none; b=PDayWBXKPVDDtugisDZhPIAAZxTv8zOBnhEq8eVonekcK4TLveR+G3XCJTIaGb0WYeN2z97zJTQFBqQ7MO+m5EHqM6OzP+AjAK2wjHgI4Grs1E3jfkIdyu3sJhYiDBO1n7BNaf2EuSfflVCZx7aoLRnFhQ/EvVCHeuxQw4L873E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963134; c=relaxed/simple;
	bh=eUWmDWh+EdwYBtn1c1CdwlP3Sfvcd31n8+3RkyMlpAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jqo17Z5U1lehjONUdAwc/jErbD65LSjcSmW9FGKkkc+DobRj+3dGzTpDwyoeVRuiaBDprXyxtgKjo5PiBGyoGG6I+GMgA6rdy9JZSSJpVOvAPK4kH4cFOzIwM9IQlgofUy4HoBfDPLZecx2pIEpYTnZyM+ShNL0TrZ8+Zr+ZbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5+y5HnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5+y5HnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2952D1F000E9;
	Wed,  5 Aug 2026 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963133;
	bh=NXCrOACSOXiXiE9ATqXZMGBN2ma0wmXvk8BGWXMvyuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5+y5HnGGVde5Nks8RGTTIL4UHoxr2bliPy3YsyWCvRfLk8jWppd/wwzvWxAt/xJC
	 WoMiqnSwN+QR9RqUahGgFnyywDqs/q8KhAMQMXMQno3jjuTAuzO5XzXG4ukoqBgFXX
	 7ULjf+kEPtV7Tzze31p0BCMvEuUjeMMA/y85jclMI74kojEBp40lcsjYsV3+HKIQUX
	 3WfIWsPnjDOjtqwxicQogZuvdbrZj5xnjqRXFkVYb65+mHvms153vTaWU9GsV8+3rY
	 FW5o7IueZk1waQPBEKZ6N6Nor/+dAayDU/CbHaU8tsugSBXdwm6y3KfRvgoB58dsAW
	 DvuhnkAtQ7jUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v23 3/3] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260805-rust_leds-v23-3-b2fea4290ee6@posteo.de>
References: <20260805-rust_leds-v23-0-b2fea4290ee6@posteo.de>
 <20260805-rust_leds-v23-3-b2fea4290ee6@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:52:12 +0000
Message-Id: <20260805205213.2952D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unsound fwnode reference counting and recovery logic leads to a me=
mory leak or use-after-free.
- [High] Unsynchronized concurrent reads of `brightness` and `intensity` cr=
eate a data race, resulting in Undefined Behavior.
- [Low] Commit message description is not capitalized, violating the LED su=
bsystem guidelines.
--

--- Patch [3]: [PATCH RESEND v23 3/3] rust: leds: add multicolor classdev a=
bstractions ---
commit 31ed8e2758580675a7a667a24dbbce311465d001
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

Implement the abstractions needed for multicolor led class devices,
including led::MultiColor, MultiColorSubLed, and led::MultiColorDevice.

> rust: leds: add multicolor classdev abstractions

[Severity: Low]
This isn't a bug, but the commit message description is not capitalized,
violating the LED subsystem guidelines. Should this be "Add multicolor
classdev abstractions"?

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..82fe96fd5273b
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs
[ ... ]
> +    /// The intensity of the sub led.
> +    #[inline]
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
Does this code introduce undefined behavior due to unsynchronized concurrent
reads?

The C subsystem updates these fields concurrently when user-space writes to
sysfs. In Rust's memory model, plain pointer dereferences on non-atomic
variables that can be concurrently mutated constitute a data race and strict
undefined behavior.

Should this use core::ptr::read_volatile or atomics instead?

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
> +            }),

[Severity: High]
Can this code leak the fwnode reference?

If self.name is present, null_mut() is passed for init_data, meaning
the fwnode is never passed to the C subsystem. However, core::mem::forget()
is called unconditionally, leaking the reference since the device will not
have the fwnode for recovery during drop.

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
Can this cause a use-after-free?

If self.fwnode was originally None, but the C subsystem matches and
assigns an fwnode from elsewhere (e.g. the parent device), this drop logic
will wrongly assume ownership of it and drop an unowned ARef.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rust_leds-=
v23-0-b2fea4290ee6@posteo.de?part=3D3
