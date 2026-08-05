Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAB3D3314;
	Wed,  5 Aug 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962035; cv=none; b=jybDFqhrqjyX5+U1cBSRtaUURTF5qO0yeSna5+4firtxTxh3lWmXO4wZ+XG4LKlKgpcAQ91rp3gjYsjGN3R9kV8y8Wbna804yhiqpGLkKaU14XaJQ91Fv+w5P1wzvT6/ypcZFQQuEE59bYF5QqkbCwsolif3qXR0CIlPi0Pg884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962035; c=relaxed/simple;
	bh=ACJO0QxoIVqWP8GzRhLL8N5oaE0HyvP69Aaro8Z9qH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8pEjrBHFN4NwuSPkUGNOvk+hWiZiR3qa0QqVT7ajMJOc9OMgS2FryiavU5EYihpdy+9pd0JIcnANIppu0iD+QjM6bYokMSOwIb8MNLv3ItEFrE5ySpL8KCpZv68DChasZQry9FS+bbsQ+SmlbtMt464JBKGy/vW6eUMt1ijUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZzvVrSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZzvVrSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89221F000E9;
	Wed,  5 Aug 2026 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785962034;
	bh=WosFNCbY/xQ/6Njon0qA/9Vy5RcT9XzgmsUV4y3jDfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZzvVrSjOXnIiWvgOOYxbQe5LFaVsRbTWIWBEcMesEXcPXyN+/hZ5lxX10+Qh0+8d
	 8kfSuhAyq8HZ5qa8f5awVtfS0XOxdlI6oL8HH/Nn+SM7bGL1s11uaZLde3D0khkZld
	 UccfN0BtaAkdEUEaEO6Ro1vodZirW1bmZAFV3QKABJay4DvYFy+D93+KE0CWsvvmxR
	 mR9+slhL8g4IPjb9V7P5TTFwAx19n6oSbdm7Zm0x334x+EAVXPzBVV/QsgcJGP3YIL
	 qEPtO/dNpwE0LLv6NGd4cCGSTY3iCMUWtjtNIepAZ+XoLxSQsy+HdRxxaH9mPtTBlV
	 ANoPu9qohLALw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v23 1/3] rust: leds: add basic led classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: lee@kernel.org, linux-leds@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-rust_leds-v23-1-b2fea4290ee6@posteo.de>
References: <20260805-rust_leds-v23-0-b2fea4290ee6@posteo.de>
 <20260805-rust_leds-v23-1-b2fea4290ee6@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:33:52 +0000
Message-Id: <20260805203353.B89221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Refcount underflow and use-after-free of `fwnode` via incorrect li=
fecycle management.
- [High] Lifetime erasure in `DeviceBuilder::build` leaves a dangling point=
er to the LED name string, causing Use-After-Free.
- [High] Mutable aliasing of shared C pointers in `blink_set_callback` trig=
gers Undefined Behavior.
--

--- Patch [1]: [PATCH RESEND v23 1/3] rust: leds: add basic led classdev ab=
stractions ---
commit 6f6f8b461cc55c0944a56c43b46dbc985385115e
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions

Implement the core abstractions needed for led class devices, including:
led::LedOps, led::DeviceBuilder, and led::Device.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> index 0000000000000..816db7c576894
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs
> @@ -11,9 +11,6 @@
>  /// This structure represents the Rust abstraction for a led class devic=
e.
>  #[pin_data(PinnedDrop)]
>  pub struct Device<'bound, T: LedOps + 'bound> {
>      #[pin]
>      ops: T,
>      #[pin]
>      classdev: Opaque<bindings::led_classdev>,

[Severity: High]
Does this struct need to carry the 'init lifetime from DeviceBuilder?

If DeviceBuilder::name takes a &'init CStr and stores it, and then=20
DeviceBuilder::build extracts this as a raw pointer:

rust/kernel/led/normal.rs:DeviceBuilder::build() {
    ...
    name: self.name.map_or(core::ptr::null(), CStrExt::as_char_ptr),
    ...
}

But the resulting Device<'bound, T> does not carry the 'init lifetime.=20
This could allow the Rust borrow checker to drop the original string while=
=20
the Device remains fully active. If a driver uses a local string for the na=
me,=20
will it be freed, leaving led_classdev.name pointing to unallocated memory=
=20
and causing a use-after-free?

[ ... ]
> @@ -180,18 +180,11 @@ impl<T: LedOps> Adapter<T> {
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
Does this code create overlapping mutable references when concurrent sysfs=
=20
writes occur?

The LED core's led_blink_set is invoked directly from sysfs writes=20
(delay_on_store and delay_off_store) without locking. When sysfs writes occ=
ur=20
concurrently, multiple threads can pass pointers to the shared=20
led_cdev->blink_delay_off or led_cdev->blink_delay_on members into=20
led_blink_set simultaneously.

Casting these raw pointers into exclusive mutable references (&mut usize)=20
without synchronization could result in two active overlapping &mut=20
references existing simultaneously on different threads, which is undefined=
=20
behavior in Rust.

>              )?;
>              Ok(0)
>          })
>      }
>  }
> =20
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
Will this lead to a reference count underflow if DeviceBuilder was created=
=20
without an fwnode (self.fwnode =3D None)?

If the kernel dynamically assigns an fwnode to the device (e.g., via ACPI o=
r=20
parent inheritance), dev.fwnode() during drop will return Some(fwnode).=20
The PinnedDrop implementation unconditionally wraps this pointer in=20
ARef::from_raw and drops it, stealing a reference count it never owned.=20

Since the C device_unregister function natively cleans up its own fwnode=20
reference, could this additional drop cause a critical underflow and=20
subsequent use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rust_leds-=
v23-0-b2fea4290ee6@posteo.de?part=3D1
