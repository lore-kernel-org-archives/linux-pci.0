Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EE45199C;
	Wed,  2 Sep 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391047; cv=none; b=J0czt3JyGXdnLnAgslKaspmGQ/6tKnL4hdvoJEeHDb2pZS5e26fYPfJv9V+Nxk1kfFKsiCz9qutmEybU3c5DFXjnC015/M/t8RrI7AqRVmsU9gC8ngtKvmXSXTE2jRrYvduY5pz5q9GKRmvmpm5rR0EMavPVfEN3ZHolgsqFsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391047; c=relaxed/simple;
	bh=C8IFSHaeEiwb99q4VaxWMsYu0rW9H6kgU1+aTjgRO6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RmB+iIb8fI5YDp72410jSEGps+U0gdDqzVyg5YMpskHsb/nvItBYK5WqoX2d1onMiu62s35wlQGI7RNRbW8NNBU10hcmd8gQow6njt4MUqymmnaH+zQ2JqReJ9UvydBDK9stwXnGfTL9KA1HZJAKEIzORtLN6lF2vOauNa/gwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMutBnGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMutBnGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6201F000E9;
	Wed,  2 Sep 2026 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788391045;
	bh=WfsCoEB3BbsEnLPXomwZlUQTva61Ouwx/wGI0esFwU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cMutBnGxu7O3SS5ROhPWmgu373u/4Hc7dgN6SZ0iI/dh+k1EMy5yeUTvVOhGXabbD
	 eyf7KBoj7/o5RbTYp0THASIalTqsOFVaX85o+hq9ttntPk57UdeX7u5NUpzu6M9zAH
	 DjHU7yCim2h8rXg0d8fhARNRFg1bubhbl8oCkASZ86RGRmytA2ybCayaJCEzMbBsJf
	 HflVnb5YNd1XbpV78BIg+YwezvYEqfjRm3LmyPKhrX5bhpBooocPcincFpbMNPwOtN
	 GT5hAcOuVgSB4nPj20rRlbGMXX9CjfVGMFMvU6PAp2gZT4YhoKD8+4sLgJlTRguoBY
	 vb0AyJabXGbLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 1/4] rust: leds: add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, lee@kernel.org, linux-pci@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260903-rust_leds-v24-1-8d9e4c04db69@posteo.de>
References: <20260903-rust_leds-v24-0-8d9e4c04db69@posteo.de>
 <20260903-rust_leds-v24-1-8d9e4c04db69@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 23:17:25 +0000
Message-Id: <20260902231725.AF6201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The LED abstraction uses the unmanaged `led_classdev_register_ext`=
 API, violating subsystem guidelines and introducing memory safety vulnerab=
ilities.
- [High] DeviceBuilder unsafely recovers the `FwNode` reference count from =
the mutable C structure `dev->fwnode`, leading to use-after-free or memory =
leaks.
- [High] Concurrent calls to `blink_set_callback` create aliased mutable re=
ferences to shared `delay_on` and `delay_off` variables, causing Undefined =
Behavior.
- [Medium] Eager evaluation of `.then_some()` forces instantiation of optio=
nal vtable callbacks, causing linker errors if methods are omitted.
--

commit 729f3d81e7ef8cb49db95c3c7c2412eca5d86a36
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions

This commit implements the core Rust abstractions for the LED subsystem. It
introduces traits and structures such as LedOps, DeviceBuilder, and Device
to safely wrap and manage led_classdev registration and operations.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> index 0000000000000..816db7c576894
> --- a/rust/kernel/led/normal.rs
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> @@ -25,58 +25,58 @@ impl<'init, S: DeviceBuilderState> DeviceBuilder<'ini=
t, S> {
>          self,
>          parent: &'bound T::Bus,
>          ops: impl PinInit<T, Error> + 'init,
>      ) -> impl PinInit<Device<'bound, T>, Error> + 'init {
>          const_assert!(T::MAX_BRIGHTNESS <=3D i32::MAX.unsigned_abs() || =
!T::HAS_BRIGHTNESS_GET);
> =20
>          try_pin_init!(Device {
>              ops <- ops,
>              classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_cl=
assdev| {
>                  // SAFETY: `try_ffi_init` guarantees that `ptr` is valid=
 for write.
>                  // `led_classdev` gets fully initialized in-place by
>                  // `led_classdev_register_ext` including `mutex` and `li=
st_head`.
>                  unsafe {
>                      ptr.write(bindings::led_classdev {
>                          brightness_set: (!T::BLOCKING)
>                              .then_some(Adapter::<T>::brightness_set_call=
back),
>                          brightness_set_blocking: T::BLOCKING
>                              .then_some(Adapter::<T>::brightness_set_bloc=
king_callback),
>                          brightness_get: T::HAS_BRIGHTNESS_GET
>                              .then_some(Adapter::<T>::brightness_get_call=
back),

[Severity: Medium]
Since .then_some() is a method call, doesn't it evaluate its argument eager=
ly?

Passing Adapter::<T>::brightness_get_callback forces the compiler to
instantiate the function body, which in turn evaluates T::brightness_get.
If the trait method is omitted by the driver, it defaults to invoking
build_error!().

Will this forced instantiation create a reference to the external symbol
rust_build_error that resists dead-code elimination and results in a
linker error?

Would a standard if T::HAS_BRIGHTNESS_GET { Some(...) } else { None } block
prevent this eager evaluation?

>                          blink_set: T::HAS_BLINK_SET.then_some(Adapter::<=
T>::blink_set_callback),
>                          max_brightness: T::MAX_BRIGHTNESS,
>                          brightness: self.initial_brightness,
>                          color: self.color as u32,
>                          name: self.name.map_or(core::ptr::null(), CStrEx=
t::as_char_ptr),
>                          ..bindings::led_classdev::default()
>                      })
>                  };
> =20
>                  let mut init_data =3D bindings::led_init_data {
>                      fwnode: self
>                          .fwnode
>                          .as_ref()
>                          .map_or(core::ptr::null_mut(), |fwnode| fwnode.a=
s_raw()),
>                      default_label: core::ptr::null(),
>                      devicename: self
>                          .devicename
>                          .map_or(core::ptr::null(), CStrExt::as_char_ptr),
>                      devname_mandatory: self.devname_mandatory,
>                  };
> =20
>                  // SAFETY:
>                  // - `parent.as_ref().as_raw()` is guaranteed to be a po=
inter to a valid
>                  //    `device`.
>                  // - `ptr` is guaranteed to be a pointer to an initializ=
ed `led_classdev`.
>                  to_result(unsafe {
>                      bindings::led_classdev_register_ext(
>                          parent.as_ref().as_raw(),
>                          ptr,

[Severity: High]
Does using the unmanaged led_classdev_register_ext() API here violate the L=
ED
subsystem guidelines?

The guidelines mandate managed registration (devm_led_classdev_register_ext)
to prevent resource leaks and use-after-free bugs. If the Rust device is
safely leaked (e.g., via Box::leak or a cyclic Arc), the PinnedDrop
destructor is never called.

Won't this leave the unmanaged LED registered after the driver module
unloads, potentially causing an exploitable use-after-free kernel panic on
subsequent userspace sysfs accesses?

>                          if self.name.is_none() {
>                              &raw mut init_data
>                          } else {
>                              core::ptr::null_mut()
>                          },
>                      )
>                  })?;
> =20
>                  core::mem::forget(self.fwnode); // keep the reference co=
unt incremented

[Severity: High]
Is it safe to unconditionally forget self.fwnode here?

If self.name is Some, init_data is passed as NULL to the C subsystem, so
the FwNode is ignored. Doesn't this permanently leak the ARef?

[ ... ]

> @@ -174,27 +174,27 @@ impl<T: LedOps> Adapter<T> {
>      /// # Safety
>      /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
>      /// `led::Device`.
>      /// `delay_on` and `delay_off` must be valid pointers to `usize` and=
 have
>      /// exclusive access for the period of this function.
>      /// This function is called on enabling hardware accelerated blinkin=
g.
>      unsafe extern "C" fn blink_set_callback(
>          led_cdev: *mut bindings::led_classdev,
>          delay_on: *mut usize,
>          delay_off: *mut usize,
>      ) -> i32 {
>          from_result(|| {
>              // SAFETY: The function's contract guarantees that `led_cdev=
` is a valid pointer to a
>              // `led_classdev` embedded within a `led::Device`.
>              let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
>              // SAFETY: `classdev.parent()` is guaranteed to be contained=
 in `T::Bus`.
>              let parent =3D unsafe { T::Bus::from_device(classdev.parent(=
)) };
> =20
>              classdev.ops.blink_set(
>                  parent,
>                  classdev,
>                  // SAFETY: The function's contract guarantees that `dela=
y_on` points to a `usize`
>                  // and is exclusive for the period of this function.
>                  unsafe { &mut *delay_on },
>                  // SAFETY: The function's contract guarantees that `dela=
y_off` points to a `usize`
>                  // and is exclusive for the period of this function.
>                  unsafe { &mut *delay_off },

[Severity: High]
Can this create aliased mutable references to shared variables?

The C LED subsystem allows lockless concurrent calls to led_blink_set() from
sysfs handlers like led_delay_on_store(). When multiple threads write to the
sysfs attributes concurrently, they pass pointers to the exact same shared
variables.

If the Rust abstraction unconditionally casts these raw pointers into
exclusive mutable references (&mut *delay_on and &mut *delay_off), doesn't
this violate Rust's aliasing rules and result in Undefined Behavior?

[ ... ]

> @@ -208,12 +208,12 @@ impl<T: LedOps> Adapter<T> {
>  #[pinned_drop]
>  impl<'bound, T: LedOps + 'bound> PinnedDrop for Device<'bound, T> {
>      fn drop(self: Pin<&mut Self>) {
>          let raw =3D self.classdev.get();
>          // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
>          // valid `led_classdev`.
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
Could this reconstruct an ARef from a globally-mutable C pointer and cause a
Use-After-Free?

If self.fwnode was None during DeviceBuilder::build, forget() does nothing.
But if the kernel later dynamically assigns an fwnode to the class device
(e.g., via device links or driver core), this drop handler unconditionally
reconstructs an ARef and drops it, decrementing a reference count it never
incremented.

Should the Rust abstraction store its own Option<ARef> internally to
securely track ownership instead of relying on the C structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-rust_leds-=
v24-0-8d9e4c04db69@posteo.de?part=3D1
