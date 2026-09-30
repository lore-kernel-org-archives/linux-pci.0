Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333794D1797;
	Wed, 30 Sep 2026 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774332; cv=none; b=a9uOZgwjoB7zvXjbh4ORrXrqaF4lIEvvGfGiz+LS1ul0VDkF6FSBZlFIu2KSqyUMsm7x10QcC+FaW8Np+DPiuOnjb5UV/M8jeRE/OmHIf0vqOhmuxXuIlBpIiuhjSeIvu0H54ZrzLgN9Vp3jflRlcH0GLwAYKK0PVr15s+p4wnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774332; c=relaxed/simple;
	bh=a8wNrzUeHmkkSYz5VHApZi3tZfkIkaeU5V33K4ro0TY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I7/xk9adbhM0mAFRkfODkvHIC+hoY8+RTIhF0NCFS/SN4LUOLGVHpe9AKkIVj31VhQCo88G4og/IZBwB68Tuin5cts/XIlt10htWCc4WObAIZ0YT0J2g6lj7ha5jDyHD9B11v1o0b3/358gZXjkEn5XHt+4krf/sxk0ZwNFP9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUjEcz4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUjEcz4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44F71F000FF;
	Wed, 30 Sep 2026 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774321;
	bh=Y69l2mgRjLQN3PjcWhHPTedTd2ip8ar6CW5CbyJdgOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dUjEcz4ZuggnUOj3qMAQkZ+DD6baWg31D1+8sEK7djNyxvSNPZq3puiUb7yUuCIDL
	 eKNP9F8QBP2LPOF0NbQAW9yHb7GsDTqZUm9MaKbJX5rz91pS+qghvx2vSOtXW1jBL3
	 /qHBtQBMZjbN/fSHtFe+c4lRClE+aqO0VqRAUuPKbjXqpCCBZ2wJdQVdd0opgCmLEc
	 IbXzLa23fHZs/bKTnIHYafjQisRS5ask+L0h79f179ThEhAUyjVNSoI3AZimZTtImm
	 08XYfnSJ1K05BRup3ZsMF/u2J5Gchq8VmLurBWalpwKzXOj/I84JjGZcoB148sBseP
	 SmLjjzD9iA3vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v26 1/4] rust: leds: Add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: lee@kernel.org, linux-leds@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org
In-Reply-To: <20260930-rust_leds-v26-1-83837331020e@posteo.de>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
 <20260930-rust_leds-v26-1-83837331020e@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:18:40 +0000
Message-Id: <20260930131840.D44F71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] leds: mutable aliasing UB in blink_set_callback via concurrent sys=
fs
- [High] leds: lifetime inversion in DeviceBuilder allows Device to outlive=
 strings
- [High] leds: FwNode use-after-free and leak via incorrect drop logic
- [Low] leds: missing #[inline] on Deref implementations for abstractions
--

commit 29180add5d0ac2c1b691782a2890b1e8097a96b7
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: Add basic led classdev abstractions

This commit implements the core Rust abstractions for LED class devices,
including led::LedOps, led::DeviceBuilder, and led::Device.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> new file mode 100644
> index 0000000000000..a22c29cfd2628
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> +impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
> +    /// Registers a new [`Device`].
> +    pub fn build<'bound: 'init, T: LedOps + 'bound>(

[Severity: High]
Can this lifetime bound cause a use-after-free? With <'bound: 'init>, the
returned Device<'bound> outlives the temporary strings borrowed in
DeviceBuilder<'init>.

If the safe driver uses temporary strings (like name and devicename) and bu=
ilds
the device, they are written as raw pointers into the C structure. Since the
returned Device outlives them, the C subsystem could later dereference
dangling pointers if triggers access led_cdev->name.

Should this be inverted to <'init: 'bound>?

> +        self,
> +        parent: &'bound device::Device<Bound>,
> +        ops: impl PinInit<T, Error> + 'init,
> +    ) -> impl PinInit<Device<'bound, T>, Error> + 'init {

[ ... ]

> +impl<'bound, T: LedOps + 'bound> Deref for Device<'bound, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.ops
> +    }
> +}

[Severity: Low]
This isn't a bug, but this small abstraction function is missing the
recommended #[inline] attribute. The Rust subsystem coding guidelines manda=
te
that small abstraction functions, such as Deref trait implementations, must=
 be
annotated with #[inline] to ensure proper compiler optimization across crate
boundaries.

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
Are we sure these mutable references have exclusive access?

The sysfs delay_on and delay_off attributes do not use locking to serialize
writes (for example, in led_delay_on_store() in ledtrig-timer.c). Concurrent
writes from user-space can cause the C core to invoke led_blink_set()
concurrently on multiple threads, passing pointers to shared fields like
&led_cdev->blink_delay_off.

If blink_set_callback() is invoked simultaneously on multiple threads, each
thread will cast the same shared pointer into &mut usize, creating overlapp=
ing
mutable references. This violates Rust's exclusive access guarantees and ca=
uses
Undefined Behavior.

> +            Ok(0)
> +        })
> +    }
> +}
> +
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
Does this drop logic correctly match the FwNode from the builder?

The builder intentionally leaks the Rust FwNode reference using
core::mem::forget(self.fwnode). However, here we unconditionally extract
dev.fwnode() from the C struct and cast it back to ARef<FwNode> to drop it.

If the builder was called with fwnode: None, it forgets None. But if the
C subsystem later attached an fwnode to the device (or if it was modified),
this drop logic will decrement the refcount of an FwNode it never owned,
causing a use-after-free. Additionally, if the C subsystem replaced the
original FwNode, the original node is leaked.

Should the driver store Option<ARef<FwNode>> explicitly within its Rust Dev=
ice
struct instead of pulling it from the C state?

> +
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v` has previously been
> +        // successfully registered with `led_classdev_register_ext`.
> +        unsafe { bindings::led_classdev_unregister(raw) };
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rust_leds-=
v26-0-83837331020e@posteo.de?part=3D1
