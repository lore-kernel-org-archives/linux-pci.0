Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B22D0606;
	Thu, 16 Jul 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227217; cv=none; b=aSG49sV+5hbMg7rUd9UJf7bEgIla7bR1qDHL+SQhONbigXBcgYGmYXIZGM3Mw6tBx0XtmAG3hHH0IwxmTQii9JpKLXrowXwOYNh6+x7KL15BVAlptjWk7icoAtSMmib3eo7fg1ViG1KlOn81mIwPVOwC9WgebMocSiqWyPTWdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227217; c=relaxed/simple;
	bh=nNajq5Uz/R7hdFpuRja9k4T86FzE0trcFMQlGcJUFMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q31nKwldCwRGMCGb/7hBfNgoKMjydwJMOwvw4sxAMke+mw3AEtee+vdnajee/zD56B8eV4uesne5xQBitV8LNikE2exc/rDHqoRF0r5Zl83cs1SH2lwHgClNoZdW4x9CyyD3UIDGx4/kJiyUPVytXcVblQ1nlKsaecjwYA8x6VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S10jf+6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S10jf+6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB0C1F000E9;
	Thu, 16 Jul 2026 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784227216;
	bh=eFaZ00LK8u59YWFyd/Z/PmLBIlOS84pfDO+bupcq6qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S10jf+6MKQjT8kcKOojuPwsB35nDZnw2TZI9GRam/pvXkTNwi2lZh1yeJ2C9TYZSU
	 dSvSgQSY8Ga5/zWPalSR+oCI0kivGE4jcywN0iS35pqkqqfGegOekuWyMeXkQyxYv0
	 IoStQL+wxVtZ+ph63LNXqsP0xBh3ZVaN7PxycLmWHvKwD9wE2QePsUnwuj1AJ9i5aq
	 97kSkzQ/pVFFmI/w4t/2obrIjqfU6gHYVfSQjuOq0pdswaiBSBoEDBV+B/i6qVJsTN
	 dqFXD9m/oAV3q7AI+wb9GMzKVwBrvtOC3Xgz3wLq5nY+QLtVPzK/OYuCKI5OAWXDH8
	 1tVEMGZGaUgvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 1/3] rust: leds: add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org, ojeda@kernel.org
In-Reply-To: <20260716-rust_leds-v23-1-e91f5b608b56@posteo.de>
References: <20260716-rust_leds-v23-0-e91f5b608b56@posteo.de>
 <20260716-rust_leds-v23-1-e91f5b608b56@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:40:15 +0000
Message-Id: <20260716184015.CAB0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect lifecycle management of the `FwNode` reference count in =
`Device::drop` leads to reference count underflow and Use-After-Free.
- [Medium] Lifetime erasure in `DeviceBuilder::build` allows a short-lived =
`CStr` to be used for the LED device name, resulting in a dangling pointer.
- [Low] Commit message format and naming convention violation for the LED s=
ubsystem.
--

--- Patch [1]: [PATCH v23 1/3] rust: leds: add basic led classdev abstracti=
ons ---
commit e26d9a00db56264a527df58257bc8e40409dcdca
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions
   =20
Implement the core abstractions needed for led class devices, including
LedOps, DeviceBuilder, and Device.

> rust: leds: add basic led classdev abstractions

[Severity: Low]
This isn't a bug, but the commit message violates the mandated subsystem
format. Should it be capitalized after the subsystem prefix and ordered
as "leds: rust: Add basic led classdev abstractions"?

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> new file mode 100644
> index 0000000000000..816db7c576894
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> @@ -33,26 +33,26 @@ impl<'init, S: DeviceBuilderState> DeviceBuilder<'ini=
t, S> {
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
>                          blink_set: T::HAS_BLINK_SET.then_some(Adapter::<=
T>::blink_set_callback),
>                          max_brightness: T::MAX_BRIGHTNESS,
>                          brightness: self.initial_brightness,
>                          color: self.color as u32,
>                          name: self.name.map_or(core::ptr::null(), CStrEx=
t::as_char_ptr),

[Severity: Medium]
Does this code introduce a dangling pointer by erasing the lifetime of the
name field?

The short-lived 'init lifetime on CStr is converted to a raw pointer and
permanently stored in the led_classdev structure. The returned
Device<'bound, T> entirely erases the 'init lifetime constraint.

This permits safe Rust code to pass a temporary CString, build the device,
and drop the CString while the Device remains registered, leaving a
dangling pointer in led_classdev.name.

>                          ..bindings::led_classdev::default()
>                      })
>                  };

[ ... ]

> @@ -211,20 +211,20 @@ impl<T: LedOps> Adapter<T> {
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
Does this lifecycle management of the FwNode reference count lead to an
underflow and use-after-free?

If an LED device is built without explicitly providing a firmware node,
self.fwnode is None. The device is then registered, and the kernel driver
core invokes platform notifiers which can dynamically discover and bind a
firmware node to the device.

Later, when the Rust Device is dropped, it unconditionally fetches the node
via dev.fwnode(), converts it to an ARef, and drops it. Because Rust never
incremented the refcount for this dynamically attached node, dropping the
ARef performs an unbalanced decrement.

Would it be safer for the Device struct to explicitly store its own
Option<ARef<FwNode>> instead of blindly trusting dev.fwnode()?

> =20
>          // SAFETY: The existence of `self` guarantees that `self.classde=
v` has previously been
>          // successfully registered with `led_classdev_register_ext`.
>          unsafe { bindings::led_classdev_unregister(raw) };
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-rust_leds-=
v23-0-e91f5b608b56@posteo.de?part=3D1
