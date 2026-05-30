Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B56377575
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780182339; cv=none; b=O3078czXs4Ea+EkAzFtW6aWVfewGtnUMjlJHJZfO9RV6i543Xl9XY8OuSXyZKFVFD76+tozgKdvK5dNfNYy0iJJC2ws6AuNDwaZCupn7ow0mjUgZZKFbF54geycyPs0cvLH518eOcUb/sELilr8vw2RbNIJe5dSBpk8S04MiidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780182339; c=relaxed/simple;
	bh=38DwpSMrVS/zl93N9XZCj5mT36ypeeLJkhLy9YwTOq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sd8I+H1hYUUo5lAKV3XxUsjCO86ESt+rlXUaj3elHyLvijdzHDM4xQ1k8oUoJxqJ43g/8O3qQTeuIlLvlcJbJnR3XWrF9E9BrMQDw1S8nluA7npwJBxvMrrSgwnZT2HbRFYYfQYUf66579EKgafOqN7OFa1JxF4cvnxT+NIczlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qeuue3gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qeuue3gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893561F00893;
	Sat, 30 May 2026 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780182337;
	bh=eJqaSxN3XDwovLOMGBmEQxz0naac6evgpq+dSqeMTUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qeuue3ghJ5kB5ATFy59r9LJizxSkLxpTKuXRWgs8+FTEiz0EYk/IcXlXZ8vRX0p9G
	 LxMFjt5flYXsN2vC2FoFOw8E/7R4puylbOy8ObJ5oeeOO0Isvs8tjg41POxZ0PUIwa
	 UXhQGaZ9o2Oa1JlYZmQaRNIUSphKbT6JViph8uiWgF7NPc7/48BqrE32//Ec4qHBR+
	 8jqbKOdeIFL+rdk5+g+ft6DK1n6AVFfSF9UadG4gyURRO8XKO/+pMMGBbLXHY0vgmL
	 lqsulHfqWTOEG5wDUYM0MqcNASP05wB9fZa13GnD75x8tBkpq3EJIp2FqH7f7MwV5h
	 eCGlsFeqV7uuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 1/3] rust: leds: add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260531-rust_leds-v18-1-d07102ba5170@posteo.de>
References: <20260531-rust_leds-v18-1-d07102ba5170@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 23:05:37 +0000
Message-Id: <20260530230537.893561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `Device` abstraction drops the `'a` lifetime of the `name` ref=
erence, leading to a potential use-after-free of the LED name.
--

commit bc77118736b867c88c1854d7a5c4eb57818535fd
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions

Implement the core abstractions needed for led class devices, including
LedOps, DeviceBuilder, and Device.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> new file mode 100644
> index 0000000000000..09244133f14c8
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> +impl<'a, S: DeviceBuilderState> DeviceBuilder<'a, S> {
> +    /// Registers a new [`Device`].
> +    pub fn build<'bound: 'a, T: LedOps + 'bound>(
> +        self,
> +        parent: &'bound T::Bus,
> +        ops: impl PinInit<T, Error> + 'a,
> +    ) -> impl PinInit<Device<'bound, T>, Error> + 'a {
> +        const_assert!(T::MAX_BRIGHTNESS <=3D i32::MAX.unsigned_abs() || =
!T::HAS_BRIGHTNESS_GET);
> +
> +        try_pin_init!(Device {
> +            ops <- ops,
> +            classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_cl=
assdev| {
> +                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid=
 for write.
> +                // `led_classdev` gets fully initialized in-place by
> +                // `led_classdev_register_ext` including `mutex` and `li=
st_head`.
> +                unsafe {
> +                    ptr.write(bindings::led_classdev {
> +                        brightness_set: (!T::BLOCKING)
> +                            .then_some(Adapter::<T>::brightness_set_call=
back),
> +                        brightness_set_blocking: T::BLOCKING
> +                            .then_some(Adapter::<T>::brightness_set_bloc=
king_callback),
> +                        brightness_get: T::HAS_BRIGHTNESS_GET
> +                            .then_some(Adapter::<T>::brightness_get_call=
back),
> +                        blink_set: T::HAS_BLINK_SET.then_some(Adapter::<=
T>::blink_set_callback),
> +                        max_brightness: T::MAX_BRIGHTNESS,
> +                        brightness: self.initial_brightness,
> +                        color: self.color as u32,
> +                        name: self.name.map_or(core::ptr::null(), CStrEx=
t::as_char_ptr),

[Severity: High]
Does this erase the lifetime of the name string and risk a use-after-free?

In DeviceBuilder::build, the builder takes a string reference tied to the 'a
lifetime, but the returned Device struct does not capture this lifetime. The
raw pointer from the name is then written directly into the long-lived
led_classdev struct.

If the name string is dropped immediately after the Device is initialized
(for example, if a dynamically allocated CString was used in the driver pro=
be
function), the led_classdev struct registered with the C subsystem will
contain a dangling pointer.

Could this lead to memory corruption if C code inspects the global leds_list
and dereferences the dangling name pointer?

> +                        ..bindings::led_classdev::default()
> +                    })
> +                };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531-rust_leds-=
v18-0-d07102ba5170@posteo.de?part=3D1
