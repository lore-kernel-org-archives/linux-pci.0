Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAB323417;
	Sun, 13 Sep 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317115; cv=none; b=cHYGVPWrF7m5Ko19HYEfP5LCsdDLKr7YCm127JdhKWv+XxUPjySBZY+0Uoc4jnrI7gBRJH0xhl6Siirs9YbthxWJyVcRjZbgJ0cnVxnWGGWpOTuu4G7tv4fKt7Iw8iyS1a1NydhyLAB6Wbf2BUagh7KXTuXEq0+pGGdSchRJYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317115; c=relaxed/simple;
	bh=JOIAdIH+KnEzpU316WsJdjxcEcmXPxFAPmEGIUdvyVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eEGK00j3nle0Mhniopf0jrwgttUK5Sqz0SqC//zTDPp5S8tM2Jieq9436jV+kiIWqaqks8Ey35MfUsdmDZ3Vy7X6s0oAwIazqTJ5oTlnsQUAtQG6APZduQQZ9axDnFiaNP0Sj3ZN8CwE39N2P7dlM09vwIBF0z1zf+OeMh+B8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHSaGVNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHSaGVNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358B71F000FF;
	Sun, 13 Sep 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789317113;
	bh=4Wy5WyPUrFpqKP8uzx+t/K7bR9qrcM8abhdN+JHbVNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHSaGVNyZ7iPEOQTDAKPA/1/pJrhsJAKZNbgjwmdqjNzd3vT271767BsPVhdUgsal
	 O3cxYBId8jgOWXE43LaYx0S7xE2az4vnnk/pBCBeuPJzkXpNpdHJwozO4LlIJc1CLo
	 IC7bQi0jDv3wYbqRrOqZHPJeNbCHIf/wt/WQp1dfRCgxM+K3OonZZWhd9QgiwqA/OU
	 jnXFcbuv2okDmxNvcf2PjWZjhigQyTSBeplo65PMXcrDGb+FhyIgVVbeNfMGsRbqTO
	 nyaqK5UZsVXSZGreoatjozb2gKV7aWhxfEgdb0Io78XV973NEall8Ny0dKFv4E5pUF
	 keCV0uFnaPfkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 3/4] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: lee@kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net, linux-leds@vger.kernel.org
In-Reply-To: <20260913-rust_leds-v25-3-1a10371d78c3@posteo.de>
References: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
 <20260913-rust_leds-v25-3-1a10371d78c3@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 16:31:52 +0000
Message-Id: <20260913163153.358B71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Safe methods `brightness()` and `intensity()` in `MultiColorSubLed=
` perform non-atomic plain reads that race with C subsystem writes, causing=
 Undefined Behavior.
- [High] The `MultiColorDevice` struct fails to capture the `'init` lifetim=
e constraint from `DeviceBuilder`, allowing the device name `CStr` to be dr=
opped prematurely and leaving a dangling pointer in the C framework.
- [Medium] Logic in `build_multicolor` permanently leaks `fwnode` refcounts=
 when a custom device name is provided.
--

commit 7485bc19e8ccc2afa9099cb7107096ea73b39fe0
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

This commit implements the abstractions needed for multicolor led class dev=
ices.
It introduces MultiColor, MultiColorSubLed, and MultiColorDevice, along with
a DeviceBuilder function to register a new multicolor led class device.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..309487bdf38aa
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
Does this plain read trigger undefined behavior due to a data race?

Since MultiColorSubLed implements Sync, references can be shared safely
across threads. The underlying C subsystem mutates these exact fields
concurrently. For example, multi_intensity_store() in led-class-multicolor.c
modifies intensity from sysfs, and led_mc_calc_color_components() modifies
brightness in softirq context.

In the Rust memory model, a data race on a non-atomic memory access is stri=
ct
undefined behavior, regardless of architecture-level load tearing.

[ ... ]
> +#[pin_data(PinnedDrop)]
> +pub struct MultiColorDevice<'bound, T: 'bound =3D ()> {
> +    #[pin]
> +    ops: T,
> +    #[pin]
> +    classdev: Opaque<bindings::led_classdev_mc>,
> +    _p: PhantomData<&'bound ()>,
> +}
> +
> +impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
> +    /// Registers a new [`MulticolorDevice`].
> +    pub fn build_multicolor<'bound: 'init, T: LedOps<Mode =3D MultiColor=
> + 'bound>(
> +        self,
> +        parent: &'bound device::Device<Bound>,
> +        ops: impl PinInit<T, Error> + 'init,
> +        subleds: &'init [MultiColorSubLed],
> +    ) -> impl PinInit<MultiColorDevice<'bound, T>, Error> + 'init {
[ ... ]
> +                unsafe {
> +                    ptr.write(bindings::led_classdev_mc {
> +                        led_cdev: bindings::led_classdev {
[ ... ]
> +                            name: self.name.map_or(core::ptr::null(), CS=
trExt::as_char_ptr),

[Severity: High]
Could this result in a dangling pointer in the C framework?

DeviceBuilder accepts an &'init CStr for the device name. In build_multicol=
or,
this bounded reference is converted to a raw pointer and written into the n=
ame
field of the C struct bindings::led_classdev_mc.

Because the instantiated MultiColorDevice type does not include the 'init
lifetime parameter, the lifetime is erased. Can this allow safe Rust code to
dynamically allocate a CString, pass a reference to name(), initialize the
device, and then safely drop the CString while the device remains alive and
the C struct still holds the name pointer?

[ ... ]
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

[Severity: Medium]
Does this logic permanently leak the fwnode reference count when a custom
device name is provided?

When self.name is Some, core::ptr::null_mut() is passed instead of init_dat=
a.
This bypasses init_data, meaning the LED subsystem never associates the fwn=
ode
with the created device (dev->fwnode remains unset).

Despite this, core::mem::forget(self.fwnode) is called unconditionally.
During teardown in PinnedDrop, dev.fwnode() will correctly return None since
the C core never set it. As a result, the ARef is never reconstructed and t=
he
reference count is permanently leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-rust_leds-=
v25-0-1a10371d78c3@posteo.de?part=3D3
