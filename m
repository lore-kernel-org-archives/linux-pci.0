Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578578;
	b=B3HeAu/INZXs8w8UH2/pwnaZh7COpspaxdDmfvepRv4epj+F0rPeJviMNvSTDmmdmxja
	 spB2oMEOhw6+uaxAkghjfJ1Tma1eRfzyNOUwRRtNOnX2gRWWJdBbZAI4c2RzvCK4vNGOU
	 U9ZsAvOLUnE/EGDOqQnxGXTPy4cHfyp5a7lM5F5auSDqtzhpIKvKjj6uNK7qKWJa483Nc
	 syAxXvmU79UNishBqU8F+mnBuYwFRumEqiXT2XzJCk8WRkHXKHmvsBMrHVta7D2hIYCEn
	 uTU7+KH/VeNfs7fwELAOC3PzC79JCV0UTHCA9vbGvCjMo6xlHYwEUXBBZigye0kYyWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578578;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/fbjR0FB4BAWUr2HeOsNbueQrcbGaG3Lu+OG+3A37GI=;
	b=s8/n1pb4J4et3ncEjcjINglTdM35nnIK9XfFOm3Ufq4afpKgSFWMXX34K4DrqaaUeH84
	 bA+bNrn+5Jm/QLvp36s1DUqOvj5K5FqA/IIIRvB/RbKaeZvwvTVH/ISE1aJQiUZQ6CYST
	 g5cRWcROy3EAzArkuXSeBiaCQHEUuoEi0F2ysXnZsEjo22zurY8/HB0fZWa3WTe3zYART
	 WQ4K5bydhx+Cg/hA4epPcogNGe4JVp3YNUvYWS9Rg0v0CgMKH8dPT87H60SpsW2Mer81M
	 p7/Oj14ap07kZma/tNe7AmmgCKHaRu2gNSxuTHITKuPD9ZvWmPnGvN/MyosA9Y7pT8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4uiZ9D+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8EE606A32E;
	Fri, 13 Nov 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4uiZ9D+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0759B1F000C4;
	Fri, 13 Nov 2026 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578578;
	bh=/fbjR0FB4BAWUr2HeOsNbueQrcbGaG3Lu+OG+3A37GI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U4uiZ9D+3gThqMX0+8rSKzxCoEYftI/XyTvYV0Y4kX67ggtlKpmajr/l+23dDJTDs
	 xS/XMdUP02DffkEWjtmkrBQZ7SdcNu9ggNBed0pVtghD3sI59IFPP31zPIbFfwc5Ta
	 s1BiDbzxbRlrKLpbMK5U58WMo9lYa4nPWg3+VYPmxa2uXjanfNMfC/j/6w29IcFWhR
	 XOZ/owujo1dX7HBmxNBg9TOeZiqumBU15ZaeIJQRSLst9jmRW7tMafcHCEfX8CFCyc
	 nro/b2SC9X+AjK7Z3hK3VSDEFYE+GBllRiBQH57j/6SSmfEv79oqTzacxvEv5EeB6d
	 0j0EQhOFtb0RQ==
Message-ID: <sashiko-outbox-212951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 1/4] rust: leds: Add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261113-rust_leds-v28-1-b8cf2f74fa57@posteo.de>
References: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>
 <20261113-rust_leds-v28-1-b8cf2f74fa57@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:02:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] rust: leds: kCFI failure in Adapter callbacks due to u32
  brightness type
- [Medium] rust: leds: unsound safe DeviceBuilder::build() allows
  forgetting Device
- [Medium] rust: leds: missing Kconfig guard on led module and missing
  linux/leds.h include
- [Medium] rust: leds: aliased mutable references in
  Adapter::blink_set_callback()
- [Low] rust: leds: missing #[inline] on Color::try_from() and
  Device::deref()
--

commit 3ca798e46e685904b91dd1d2cbeeeb11efdd4ebe
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: Add basic led classdev abstractions

This commit adds core Rust abstractions for LED class devices, including
the LedOps trait, DeviceBuilder, and the Device wrapper around struct
led_classdev.

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
> +        if value < bindings::LED_COLOR_ID_MAX {
> +            // SAFETY:
> +            // - `Color` is represented as `u32`
> +            // - the static_assert above guarantees that no additional c=
olor has been added
> +            // - `value` is guaranteed to be in the color id range
> +            Ok(unsafe { transmute::<u32, Color>(value) })
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +}

[Severity: Low]
Could Color::try_from() and Device::deref() in rust/kernel/led/normal.rs
be marked #[inline], matching other small functions in the kernel crate?

[ ... ]

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> new file mode 100644
> index 0000000000000..a22c29cfd2628
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Led mode for the `struct led_classdev`.
> +//!
> +//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
> +
> +use core::ops::Deref;
> +
> +use super::*;
> +
> +/// The led class device representation.
> +///
> +/// This structure represents the Rust abstraction for a led class devic=
e.
> +#[pin_data(PinnedDrop)]
> +pub struct Device<'bound, T: 'bound =3D ()> {
> +    #[pin]
> +    ops: T,
> +    #[pin]
> +    classdev: Opaque<bindings::led_classdev>,
> +    _p: PhantomData<&'bound ()>,
> +}
> +
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
> +
> +                Ok::<_, Error>(())
> +            }),
> +            _p: PhantomData,
> +        })
> +    }
> +}

[Severity: Medium]
What prevents safe code from initializing Device<'bound, T> in a KBox and
passing it to core::mem::forget()?

Because led_classdev_unregister() is only called in PinnedDrop::drop(),
forgetting the Device leaves the C led_classdev registered after parent
unbinds and 'bound expires.  Subsequent sysfs accesses or trigger events
then invoke Adapter::<T> callbacks on dangling 'bound references in T, and
led_module_get() or led_put() dereferences led_cdev->dev->parent->driver
after parent->driver becomes NULL.  Other lifetime-bound in-place
registrations Either mark construction unsafe or register cleanup via
devres.

[ ... ]

> +impl<T: LedOps> Adapter<T> {
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// This function is called on setting the brightness of a led.
> +    unsafe extern "C" fn brightness_set_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        brightness: u32,
> +    ) {
> +        // SAFETY: The function's contract guarantees that `led_cdev` is=
 a valid pointer to a
> +        // `led_classdev` embedded within a `led::Device`.
> +        let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> +
> +        let _ =3D classdev.brightness_set(brightness);
> +    }
> +
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// This function is called on setting the brightness of a led immed=
iately.
> +    unsafe extern "C" fn brightness_set_blocking_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        brightness: u32,
> +    ) -> i32 {
> +        from_result(|| {
> +            // SAFETY: The function's contract guarantees that `led_cdev=
` is a valid pointer to a
> +            // `led_classdev` embedded within a `led::Device`.
> +            let classdev =3D unsafe { Device::<T>::from_raw(led_cdev) };
> +
> +            classdev.brightness_set(brightness)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    /// # Safety
> +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
> +    /// `led::Device`.
> +    /// This function is called on getting the brightness of a led.
> +    unsafe extern "C" fn brightness_get_callback(led_cdev: *mut bindings=
::led_classdev) -> u32 {

[Severity: High]
Will brightness_set_callback(), brightness_set_blocking_callback(), and
brightness_get_callback() trip a kCFI failure under CONFIG_CFI_CLANG?

In include/linux/leds.h, struct led_classdev declares these callbacks
with enum led_brightness rather than u32:

include/linux/leds.h:
	void		(*brightness_set)(struct led_classdev *led_cdev,
					  enum led_brightness brightness);
	int		(*brightness_set_blocking)(struct led_classdev *led_cdev,
						   enum led_brightness brightness);
	enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);

Clang kCFI encodes enum led_brightness by its enum type name
(14led_brightness) rather than as a plain integer.  Because these Rust
callbacks use u32 and enum led_brightness is not listed as a
--newtype-enum in rust/bindgen_parameters, indirect calls from
led_update_brightness() or __led_set_brightness() will fail the kCFI type
check and panic.

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
> +            Ok(0)
> +        })
> +    }
> +}

[Severity: Medium]
Can blink_set_callback() create aliased &mut usize references to
led_cdev->blink_delay_on and led_cdev->blink_delay_off?

In drivers/leds/trigger/ledtrig-timer.c, led_delay_on_store() passes
&led_cdev->blink_delay_off directly to led_blink_set() without holding a
lock:

drivers/leds/trigger/ledtrig-timer.c:led_delay_on_store() {
    ...
	led_blink_set(led_cdev, &state, &led_cdev->blink_delay_off);
	led_cdev->blink_delay_on =3D state;
    ...
}

CPU0                                  CPU1
led_delay_on_store()                  led_delay_on_store()
  led_blink_set()                       led_blink_set()
    ...                                   ...
      blink_set_callback()                  blink_set_callback()
        &mut *delay_off                       &mut *delay_off  <-- aliased =
&mut

Concurrent writes to delay_on or delay_off, unlocked sysfs reads in
led_delay_on_show() and led_delay_off_show(), or
led_stop_software_blink() zeroing both fields from set_brightness_delayed()
all access those fields without synchronization while &mut usize is live,
causing undefined behavior.

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 1ab41129d557a..3b831cb6488d7 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -98,6 +98,7 @@
>  pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
> +pub mod led;
>  pub mod list;
>  pub mod maple_tree;
>  pub mod mem;

[Severity: Medium]
Does unconditionally compiling pub mod led break the build when
CONFIG_NEW_LEDS is disabled or CONFIG_LEDS_CLASS is not built-in?

Color::as_c_str() calls led_get_color_name() (built under CONFIG_NEW_LEDS)
and DeviceBuilder::build() and PinnedDrop::drop() call
led_classdev_register_ext() and led_classdev_unregister() (built under
tristate CONFIG_LEDS_CLASS), none of which have inline stubs in
include/linux/leds.h.  In addition, rust/bindings/bindings_helper.h does
not explicitly include linux/leds.h, relying on a transitive include.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rust_leds-=
v28-0-b8cf2f74fa57@posteo.de?part=3D1
