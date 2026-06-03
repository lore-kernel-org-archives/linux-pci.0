Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48D39DBD4
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503460; cv=none; b=ejX0n2DDi6FSIF1G4GLKJfETiYk86Phz8PZ6yeYTjegETfhgXR1qc4i0uct9nk2NbXpeAwP+cZ9w89UNCCZuHN6RVNFYgHLp7VXgs0uyuI0ZTi2a1tTKxjCZFG/daLSOisIdWYy03dcqllSF89mBUjxJn23yFUsNsXTqk2Nf3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503460; c=relaxed/simple;
	bh=j1ZaQ6Oaf9TZDkqTHLnw/gupqEiSZr6gdtDy/CnFPGo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgPeAHSlkVU7ttM8uCGihV2LjY0VDSJjfWnpyWc8A3Z5R1JGvkoRRF3ys0hWW9RkN3ciSKDBKDSoHHBlcN3Qp4G17iIDU0JEbOwzR773DcDXbQwRW4QKAyaTeSfkckvmZpvq8raSl4COXBtsig1eBbFzP46EuJErbzjoMKqYu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3XmC1yB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3XmC1yB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB3C1F00893;
	Wed,  3 Jun 2026 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503458;
	bh=GzudljbGTE2WjuFGvVt9hS/3ilrbz8r/FMjdp5gPowM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P3XmC1yBr4GHnzboZb8JxFcKcsfGxHuNrZcLGsyK5tOiomeV+HG9gYXk8R/DgVZM2
	 Da5Zd2WcJeDLSqlHTED4rzuMsUMsDlmcsaTIqOSwlC0EZcbaSQi1LgpFAj7PxUQPeD
	 E98x1LHM6hOfaZsJCyCgijMs3Q+CoTV2UUYHwDZ+k22UKKhcFUQ4a1fDlWeiXj6F3m
	 bdoEs8zc/tbF3l7pAYaMRz0A1SkN6WtlwRNSxsFEkoEly5PrZijvmsr16BV/nYN3HY
	 SMiKZ1ts/kgQUc6ftdA9GukYpBE2wQnY3kC1ZXlSIiieaKAqgzni8Hcrq5pQ4F63PE
	 z4ch4WLWV1TUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/3] rust: leds: add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260603-rust_leds-v19-1-2a71085deae3@posteo.de>
References: <20260603-rust_leds-v19-1-2a71085deae3@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:17:38 +0000
Message-Id: <20260603161738.9FB3C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `PinnedDrop` implementation for `Device` unconditionally retri=
eves the `FwNode` from the C device and constructs an `ARef<FwNode>` to dec=
rement its refcount, which can lead to refcount underflow and use-after-fre=
e.
- [High] `DeviceBuilder::name` accepts a temporary string reference that is=
 embedded into the C `led_classdev` struct, but the resulting `Device` does=
 not capture this lifetime, allowing the string to be freed while the kerne=
l retains a dangling pointer.
- [High] The `blink_set_callback` concurrently creates exclusive mutable re=
ferences (`&mut usize`) from shared memory pointers without locks, triggeri=
ng Undefined Behavior.
--

commit 98d2c51d584ea9d4d3617e05e091d1f8a6a9b7c2
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions

This commit introduces the core abstractions needed for LED class devices in
Rust. It implements traits for handling LEDs, a builder for the LED class
device, and a safe wrapper around led_classdev.

> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/led.rs

[ ... ]

> +impl<'a> DeviceBuilder<'a, Named> {
> +    /// Sets the name of the led.
> +    ///
> +    /// Setting this will prevent the fwnode from being used and prevent=
s automatic name
> +    /// composition.
> +    #[inline]
> +    pub fn name(self, name: &'a CStr) -> Self {

[Severity: High]
Does this builder API allow the C string to be freed while the kernel retai=
ns
a dangling pointer?

The name method accepts a string reference bounded by a lifetime, but the
resulting Device struct does not capture this lifetime. The raw string poin=
ter
is written into the long-lived led_classdev C struct in DeviceBuilder::buil=
d.

If the caller dynamically allocates a CString and drops it immediately after
pin-initialization, the C LED subsystem could later access a dangling point=
er
when sysfs triggers or error messages run.

> +        Self {
> +            name: Some(name),
> +            ..self
> +        }
> +    }
> +}

[ ... ]

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs

[ ... ]

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
> +            // SAFETY: `classdev.parent()` is guaranteed to be contained=
 in `T::Bus`.
> +            let parent =3D unsafe { T::Bus::from_device(classdev.parent(=
)) };
> +
> +            classdev.ops.blink_set(
> +                parent,
> +                classdev,
> +                // SAFETY: The function's contract guarantees that `dela=
y_on` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_on },
> +                // SAFETY: The function's contract guarantees that `dela=
y_off` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_off },

[Severity: High]
Can this lead to concurrent aliasing mutable references and undefined
behavior?

The C LED subsystem can invoke the blink callback without locks. For exampl=
e,
when users write to the sysfs delay_on file, led_delay_on_store() calls
led_blink_set() and passes pointers to shared struct fields like
&led_cdev->blink_delay_off.

If multiple CPUs write to the sysfs file concurrently, they could invoke th=
is
callback simultaneously with the exact same pointer. Creating exclusive mut=
able
references from these shared pointers concurrently violates Rust's mutable
aliasing rules.

> +            )?;
> +            Ok(0)
> +        })
> +    }
> +}

[ ... ]

> +#[pinned_drop]
> +impl<'bound, T: LedOps + 'bound> PinnedDrop for Device<'bound, T> {
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
> +            // incremented in `led::Device::new`.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Can this lead to a refcount underflow and use-after-free of the firmware no=
de?

DeviceBuilder::build transfers ownership and leaks the self.fwnode refcount
only if it was provided. However, this drop implementation unconditionally
retrieves the FwNode from the C device and constructs an ARef to decrement =
its
refcount.

The C driver core can independently populate dev->fwnode, such as via ACPI
bindings during device_add. If the C code populates the node while
self.fwnode was not set, this code will blindly construct an ARef and drop =
it,
underflowing the refcount of an active firmware node.

> +
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v` has previously been
> +        // successfully registered with `led_classdev_register_ext`.
> +        unsafe { bindings::led_classdev_unregister(raw) };
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rust_leds-=
v19-0-2a71085deae3@posteo.de?part=3D1
