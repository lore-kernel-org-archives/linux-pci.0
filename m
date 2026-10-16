Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529B48DB2E;
	Fri, 16 Oct 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175074; cv=none; b=pgtSC2tYwdhYz53YSGI7DyygGOrQHUbTYpAXFzGcICAfY4vIcYImvY8c/ykHqhzAz0NAYYtLNn8L604W0/NKgxu7j9BKJiYYz7IucXZLkalvlQceuo0LbowVLe6CviQFoHAVlrVKwZER57PW5SP0pRJRwj9+Dhh1ZnKmxkCUHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175074; c=relaxed/simple;
	bh=6Ul+E+iMLpwmqwmjz1cwsEU97N1y7DqlAWZrhKY0Z0U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u2ZKuMfkhQnqKKQoNlrPjwX4obqHg3ACRrvcSOP/YaFa78Fbc8CX9C4jErooFWjjYTGRV/tuG9sFtBq8VuGaKPV3jq7WL0y4npX4mVW9WUh5LGoGo/QuCXgYBWeWbfuNT5ZP1B52AUqUldaLwzF33eJ+R/aeu+VALXRqeqyx6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anclpPyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anclpPyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84B51F000C4;
	Fri, 16 Oct 2026 18:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792175073;
	bh=T2HxYlh8wV1UNl4g/+yAM/m+TcTSYRCpeaQ6swTKqEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anclpPybBeLdtkbTs0tfT2gyTlAzNx8IYcyNM5Jo3fJHQm9i0Ool29JVbbdGBiJIR
	 1zT4V5e+zNFUbUddzqoKfHoHpjcrggzFeAC6yyRfqLTBWeEMfqVIqTw2m2bAMfpZKY
	 V/+uRiDCAf3AnsM1lxtjwurpU1K5FtR6Q6kkZt9ei9i5mIyoaRwnnYnRu1t0IWIIKJ
	 f+qQBUaLvgRqaHSzKP7A0h57JXRGuSVcAnKxujy3SXKes6FkvEuOef1chjmcR4xXtY
	 mwdkfgbpkmAVloZPm4LSozvPujjDrUYb/v4t2HbFNMZnXeIb7h7w3g65TObby/kFD+
	 ldLWcSCqrFFxA==
Message-ID: <sashiko-outbox-174766@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 1/4] rust: leds: Add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261016-rust_leds-v27-1-2c296d8a8e5b@posteo.de>
References: <20261016-rust_leds-v27-0-2c296d8a8e5b@posteo.de>
 <20261016-rust_leds-v27-1-2c296d8a8e5b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:24:32 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rust: leds: UB from concurrent &mut usize to shared blink delays
- [High] rust: leds: UAF due to unbalanced fwnode reference decrement in De=
vice::drop
- [Low] rust: missing #[inline] on small abstraction methods Deref::deref a=
nd TryFrom::try_from
--

commit fdbf61398aae03c902e4cb268e9551172f6901a1
Author: Markus Probst <markus.probst@posteo.de>

    rust: leds: Add basic led classdev abstractions
   =20
    Implement the core abstractions needed for led class devices, including:
   =20
    * `led::LedOps` - the trait for handling leds, including
      `brightness_set`, `brightness_get` and `blink_set`
   =20
    * `led::DeviceBuilder` - the builder for the led class device
   =20
    * `led::Device` - a safe wrapper around `led_classdev`
   =20
    Signed-off-by: Markus Probst <markus.probst@posteo.de>

> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> new file mode 100644
> index 0000000000000..deda8cc548a8c
> --- /dev/null
> +++ b/rust/kernel/led.rs

[ ... ]

> +impl TryFrom<u32> for Color {
> +    type Error =3D Error;
> +
> +    fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {

[Severity: Low]
This is a small conversion function that should be inlined. The Rust subsys=
tem
guidelines mandate that small functions and methods in abstractions be anno=
tated
with `#[inline]` to allow the compiler to optimize them effectively across
crate boundaries. Should we add `#[inline]` here?

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> new file mode 100644
> index 0000000000000..a22c29cfd2628
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> +impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
> +    /// Registers a new [`Device`].
> +    pub fn build<'bound: 'init, T: LedOps + 'bound>(
> +        self,
> +        parent: &'bound device::Device<Bound>,
> +        ops: impl PinInit<T, Error> + 'init,
> +    ) -> impl PinInit<Device<'bound, T>, Error> + 'init {

[ ... ]

> +                // SAFETY:
> +                // - `parent.as_raw()` is guaranteed to be a pointer to =
a valid `device`.
> +                // - `ptr` is guaranteed to be a pointer to an initializ=
ed `led_classdev`.
> +                to_result(unsafe {
> +                    bindings::led_classdev_register_ext(
> +                        parent.as_raw(),
> +                        ptr,
> +                        if self.name.is_none() {
> +                            &raw mut init_data
> +                        } else {
> +                            core::ptr::null_mut()
> +                        },
> +                    )
> +                })?;
> +
> +                core::mem::forget(self.fwnode); // keep the reference co=
unt incremented

[Severity: High]
If `self.fwnode` is `None`, `core::mem::forget` does nothing and no referen=
ce
count is incremented. Could this lead to a reference count underflow later
during `Device::drop` if `dev->fwnode` is automatically populated during
`led_classdev_register_ext` by subsystems like ACPI?

[ ... ]

> +impl<'bound, T: LedOps + 'bound> Deref for Device<'bound, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {

[Severity: Low]
This is a small trait implementation method missing the `#[inline]` annotat=
ion.
Since the Rust subsystem guidelines mandate that small methods in abstracti=
ons
be annotated with `#[inline]`, should we add it here?

[ ... ]

> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// `delay_on` and `delay_off` must be valid pointers to `usize` and=
 have
> +    /// exclusive access for the period of this function.
> +    /// This function is called on enabling hardware accelerated blinkin=
g.
> +    unsafe extern "C" fn blink_set_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        delay_on: *mut usize,
> +        delay_off: *mut usize,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: The function's contract guarantees that `led_cdev=
` is a valid pointer to a
> +            // `led_classdev` embedded within a `led::Device`.
> +            let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> +
> +            classdev.blink_set(
> +                // SAFETY: The function's contract guarantees that `dela=
y_on` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_on },
> +                // SAFETY: The function's contract guarantees that `dela=
y_off` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_off },
> +            )?;

[Severity: High]
Can this cause undefined behavior from strict aliasing violations?

A user can write to the LED `delay_on` or `delay_off` sysfs attributes
concurrently. The sysfs store callbacks pass pointers to shared `led_classd=
ev`
fields (such as `&led_cdev->blink_delay_off` or `&led_cdev->blink_delay_on`)
to `led_blink_set()`.

These fields can be concurrently read by the asynchronous
`led_timer_function()`, or passed concurrently as identically-aliased point=
ers
if multiple threads write to the sysfs attributes simultaneously, since the=
re is
no concurrency serialization in the sysfs store paths.

This callback unconditionally casts these pointers to exclusive mutable
references (`&mut usize`), violating Rust's strict aliasing rules because t=
he
underlying memory is accessed and aliased concurrently without exclusivity.

[ ... ]

> +#[pinned_drop]
> +impl<'bound, T: 'bound> PinnedDrop for Device<'bound, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let raw =3D self.classdev.get();
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `led_classdev`.
> +        let dev: &device::Device =3D unsafe { device::Device::from_raw((=
*raw).dev) };
> +
> +        let _fwnode =3D dev
> +            .fwnode()
> +            // SAFETY: the reference count of `fwnode` has previously be=
en
> +            // incremented in `led::DeviceBuilder::build`.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Does this safely balance the fwnode reference count?

If `self.fwnode` was `None` during `build()`, no reference count was
incremented by the Rust abstraction. However, during registration, subsyste=
ms
like ACPI can automatically bind a `fwnode` to `dev->fwnode`.

When unregistering, this blindly retrieves `dev.fwnode()`, assumes it was t=
he
one leaked by the builder, converts it to an `ARef<FwNode>` using
`ARef::from_raw()`, and drops it. This decrements the reference count of a
`fwnode` that the Rust abstraction never incremented, leading to a
use-after-free.

Would it be better to store the `Option<ARef<FwNode>>` safely inside the
`Device` struct instead of re-reading the mutable C field?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-rust_leds-=
v27-0-2c296d8a8e5b@posteo.de?part=3D1
