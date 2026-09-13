Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FA286D4D;
	Sun, 13 Sep 2026 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316935; cv=none; b=UA0VymlAmGmzxQw1muZDENAdNlxMpOuvobBbHA2AOlpoN6wJz/Vui1F5z5lo+9IVmnFTTaVRITU4GQnzikZsu/iQCPq5AGVUMs8PP5W7JPE3CUYyjXnbQnOpj1TGkvWz1Nq3zrwKdWQ3wwlPfflCVGj0+ZZXVrGLzxroF+h6ooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316935; c=relaxed/simple;
	bh=T1YcelWT5Vv1zMQ2NDgqnBgLUx65xEQZc59KCBfz3RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUWPNBQpE3tcLbLK4NEy2+KkEXtEMQI6ek7kID2spnSdRfz3Bf5T47fAfWkua6Qqe7sj/BVz5EkJ+vHQwFqBCC8fzcQXhhJhdgDoSiEMbQO6dfitR976Qq1ld4EK/3eH3dBs9y8hmPmlC9dlWbcGAYPBaYEMEkaWzA+zSP9aexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIWCj1Ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIWCj1Ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45611F000FF;
	Sun, 13 Sep 2026 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789316932;
	bh=L1VkvFm61iXDBj06KON6ADdXlElLjmpT1YGD+Wz+0K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIWCj1KoadeGfoIeQ0drag6+qa5/q9J1JSEGBYKXL7hQy7J4tQ2U6agLf7gkoPRRF
	 Dyz8s8NcgPxEGXkph5pKZhKBO5Y48lPdOWbLSJTWSwaeszTxczRv9TYBQMhC1R4R5b
	 j8riF4npXEldRZv6551w8flAbA7oj76Se/VgKpsvhJNxrZ9b++awsUwxLA0Ee8OqZv
	 4cB+Z3kiTgZJ9H49eqjfZxgf9qHZuYoiyIECr/ORvG4YZ89WVwD8rQVIFVPEde4UHH
	 OmoZ9Wp7MorfijqJ8TXy1mvXVW+fUMGGQr1CBChWCzeWRgeWfZhko4l+KQGZhh1Wgq
	 WyOMB4YEDRajA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 1/4] rust: leds: add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: gary@garyguo.net, linux-leds@vger.kernel.org, lee@kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260913-rust_leds-v25-1-1a10371d78c3@posteo.de>
References: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
 <20260913-rust_leds-v25-1-1a10371d78c3@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 16:28:51 +0000
Message-Id: <20260913162851.D45611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] `blink_set_callback` creates exclusive `&mut usize` references fro=
m concurrently accessible pointers, causing Undefined Behavior.
- [High] Incorrect lifetime bounds and raw pointer coercion in `DeviceBuild=
er::build` allow the registered `Device` to outlive borrowed C strings, lea=
ding to a Use-After-Free.
- [High] Reconstructing `ARef<FwNode>` from the C `struct device` in `Pinne=
dDrop` is unsound and causes reference count underflows if the fwnode is as=
signed by the C subsystem.
- [High] Using unmanaged `led_classdev_register_ext` combined with `PinnedD=
rop` breaks devres cleanup ordering, leading to a race condition and use-af=
ter-free on device removal.
- [Low] Commit message description is not capitalized.
- [Low] Small forwarding functions in the abstraction lack the `#[inline]` =
attribute, violating Rust subsystem guidelines.
--

commit 7ba1dd17b1d18204d9b691fb84bcc75aeb22eaca
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions

This commit implements the core abstractions needed for LED class devices in
Rust. It introduces the LedOps trait for handling LEDs, along with a
DeviceBuilder and a safe Device wrapper around led_classdev.

> rust: leds: add basic led classdev abstractions

[Severity: Low]
This isn't a bug, but does this violate the subsystem formatting rules?
The LED subsystem guidelines state that the description after the subsystem
prefix should always be capitalized for MFD, LED, and Backlight subsystems.
Should "add" be capitalized here?

> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> index 0000000000000..deda8cc548a8c
> --- /dev/null
> +++ b/rust/kernel/led.rs

[ ... ]

> @@ -249,6 +249,7 @@ impl TryFrom<u32> for Color {
>      type Error =3D Error;
> =20
>      fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {

[Severity: Low]
This isn't a bug, but could this small forwarding function be missing the
#[inline] attribute? According to the Rust subsystem guidelines, small
functions or those forwarding to C bindings in abstractions should be
annotated with #[inline].

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> index 0000000000000..a22c29cfd2628
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> @@ -23,6 +23,7 @@ impl<'init, S: DeviceBuilderState> DeviceBuilder<'init,=
 S> {
>      pub fn build<'bound: 'init, T: LedOps + 'bound>(
>          self,
>          parent: &'bound device::Device<Bound>,
>          ops: impl PinInit<T, Error> + 'init,
>      ) -> impl PinInit<Device<'bound, T>, Error> + 'init {

[Severity: High]
Does this inverted lifetime constraint '<'bound: 'init>' allow the returned
Device to outlive the borrowed C strings? The DeviceBuilder holds string
references tied to the 'init lifetime. This signature means 'bound can
outlive 'init.

[ ... ]

> @@ -43,6 +43,7 @@ impl<'init, S: DeviceBuilderState> DeviceBuilder<'init,=
 S> {
>                          max_brightness: T::MAX_BRIGHTNESS,
>                          brightness: self.initial_brightness,
>                          color: self.color as u32,
>                          name: self.name.map_or(core::ptr::null(), CStrEx=
t::as_char_ptr),
>                          ..bindings::led_classdev::default()

[Severity: High]
Could this raw pointer coercion lead to a use-after-free? This strips the
'init lifetime, storing a potentially short-lived pointer into the long-liv=
ed
C struct. A caller could pass a local CString, and since the returned
Device<'bound, T> lacks the 'init lifetime parameter, the C LED subsystem
might retain these raw pointers for sysfs and logging after the string is
dropped. Should the constraint be 'init: 'bound instead?

[ ... ]

> @@ -66,13 +66,9 @@ impl<'init, S: DeviceBuilderState> DeviceBuilder<'init=
, S> {
>                  // SAFETY:
>                  // - `parent.as_raw()` is guaranteed to be a pointer to =
a valid `device`.
>                  // - `ptr` is guaranteed to be a pointer to an initializ=
ed `led_classdev`.
>                  to_result(unsafe {
>                      bindings::led_classdev_register_ext(
>                          parent.as_raw(),
>                          ptr,
>                          if self.name.is_none() {
>                              &raw mut init_data
>                          } else {
>                              core::ptr::null_mut()
>                          },
>                      )
>                  })?;

[Severity: High]
Does using the unmanaged led_classdev_register_ext combined with PinnedDrop
break devres cleanup ordering? In Rust, driver data structs embedding
led::Device are allocated early in probe() using devm. Subsequent devm
allocations register their cleanup actions after the struct's drop action.

Since this unmanaged C API relies entirely on the struct's PinnedDrop to ca=
ll
led_classdev_unregister, devres will execute cleanup in reverse order on
device removal, freeing IRQs and I/O memory before PinnedDrop unregisters
the LED.

Can a concurrent write to brightness_set access already-freed I/O memory
during this window?

[ ... ]

> @@ -103,6 +103,7 @@ impl<'bound, T: LedOps + 'bound> Deref for Device<'bo=
und, T> {
>      type Target =3D T;
> =20
>      fn deref(&self) -> &Self::Target {
>          &self.ops
>      }

[Severity: Low]
This isn't a bug, but could this small forwarding function be missing the
#[inline] attribute? The Rust subsystem guidelines suggest adding it for
small functions in abstractions.

[ ... ]

> @@ -182,10 +182,10 @@ impl<T: LedOps> Adapter<T> {
>              let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> =20
>              classdev.blink_set(
>                  // SAFETY: The function's contract guarantees that `dela=
y_on` points to a `usize`
>                  // and is exclusive for the period of this function.
>                  unsafe { &mut *delay_on },
>                  // SAFETY: The function's contract guarantees that `dela=
y_off` points to a `usize`
>                  // and is exclusive for the period of this function.
>                  unsafe { &mut *delay_off },
>              )?;

[Severity: High]
Does unconditionally creating exclusive &mut usize references here trigger
Undefined Behavior?

The LED subsystem in C calls led_blink_set directly from sysfs store
handlers without holding locks. Multiple threads can concurrently write to
sysfs and invoke blink_set_callback with pointers to the shared
led_cdev->blink_delay_on and blink_delay_off fields.

Having multiple concurrent &mut references to the same memory location
violates Rust's aliasing rules.

[ ... ]

> @@ -203,9 +203,6 @@ impl<'bound, T: 'bound> PinnedDrop for Device<'bound,=
 T> {
>          let dev: &device::Device =3D unsafe { device::Device::from_raw((=
*raw).dev) };
> =20
>          let _fwnode =3D dev
>              .fwnode()
>              // SAFETY: the reference count of `fwnode` has previously be=
en
>              // incremented in `led::DeviceBuilder::build`.
>              .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Is recovering the ARef<FwNode> from the C struct device in PinnedDrop sound?

If self.fwnode in the builder was None, no reference was leaked. However,
during registration, the driver core or subsystem may automatically assign a
fwnode to the device.

In this case, dev.fwnode() would return Some, and the Rust drop logic would
blindly steal ownership of an unowned fwnode. Could this decrement its
reference count and cause an underflow and use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-rust_leds-=
v25-0-1a10371d78c3@posteo.de?part=3D1
