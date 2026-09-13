Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543A1DD0EF
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316140; cv=none; b=H70Lk5MFjoTs3O7G1YtRMBitcfhUwiyjKdgVc3SEUOR7Q6XtJVzgmGo6OdM9W1WCqWRZguZDVEHp1xRA8c6kROQd4y/Ri4CtuCvJlGjnlCtyPniSOv7YLjyfu35AsM0WJPSjb1+lrXpKJN6SAJMw/phS3aJ6vAFBS5ApTSc/tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316140; c=relaxed/simple;
	bh=HxSkKW2bM+V+H68rbIkZH6yN3SqBMR4sqQTFWWuOvCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQVXs4nkk8z6OLs2dT4hLDbBJUQG7roFiMQOSwJv+J0zZg44bbcYN3EbKmpwz3xy90sewQ7p7oFTPY6yjOUxfk6BKYxEnEUS2zaS59I3/qgjWAoq99yNQMupvlp1HMreqOeD2HP4RuGi2By7GL2rYKtUGmn8TOrEUv1NrzdgZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=PVzPi8qN; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="PVzPi8qN"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 83500240109
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 18:15:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789316131;
	bh=yr1hPSR7JAgE9j+nBwDi229jABwzjGSoBuxusWr2eTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=PVzPi8qNyslXD+7M2ffg5BjM5DqM/7o0dFT6khJphYOrFoZHjOCpJTgzLHTg87UHY
	 MHkIze4Z+Gj9/kRyU6Zx0Uh+Qe1DBAEID74O1jTqXtNrUZ/hf5bclxt4fD1X27wUQJ
	 ri3CWMbfZwrXL1nuKPV1gGAbqairVFyH9p49mn/TQjt6kFRbZOG1S8FQ5NwE1j4z3o
	 25ZZnPsK6F4uwr863atbw1PvxlS7Y5/AiV/Hq9ZDUIB/wJLzOMI4XGcZTJ6ldBkQf+
	 1lt5GzYbaz3i8MYP8+p1UOiKjicN3LkvXtauBaPbr1yb9rPUIuc74zEfhHOgvoL4jV
	 mPnSodfikWKuw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hjYKW3Y5fz9rxK;
	Sun, 13 Sep 2026 18:15:27 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 13 Sep 2026 16:15:30 +0000
Subject: [PATCH v25 3/4] rust: leds: add multicolor classdev abstractions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rust_leds-v25-3-1a10371d78c3@posteo.de>
References: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
In-Reply-To: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Ira Weiny <iweiny@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=22223;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=HxSkKW2bM+V+H68rbIkZH6yN3SqBMR4sqQTFWWuOvCQ=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqpswVY47wE2wsy73vUjBGNYXpu0WXrS2Ev8P/x
 2Sws7fF/jCJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaqbMFRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9L+qw//aJz9wONjwwPGwiFm92FkEbwr7dBdkjw
 D9v7SYQTCb10jc3bvhWQHiSN9+1Yh5O2QJkSmSxFEWg8ZIxA7euHSUIvjx11EEaP4fmhjg+0foa
 oMo079q6vIcYNp3nnOfMI9kl34NF1OlZ0ALDfsdic/J390wboZb0f+b2pNKz8oA0SkoybYyN/nE
 yIUZy/1Uk5IgQyM57f6rj9ur6S5m+J04BW7tMuB3Tjh96R9Q0SR7YYBcMzKk+MQkv8JKHeIF1Hn
 9UYUDHXUrnMSDCGeBt2vn3m9nEaONsasTTYjVr20/xYJwxFxvHpZCeDXCPD8ksBy5YqDYi9LtRu
 oUyybrbj3TA0CLP4O2qiUM3TrAunjVjJui8DF0RTUpqrSFQcOLEDqJP6DERFk0JQ4MFClS9CMw1
 VJB/924x0mK5uLVb31M9WdN7aRag2XGwY7v9roHfN1qUlNAlccvj8fySVN69ZRcm31TCaC1kIgP
 04KwnFedL6HuqGkX6rlTEvzd7THpb9hbOGjCgnUB/dAEyPR/K3Q1o0VHz7KzXku11R4rhplgnt2
 7wDsT7QD8H6fhEIR36wdKw7zjaWGjvZswoB7Jrcl8MhuhuNVQE69/zFTAarCnv8G3Rqy2pIHsEP
 68uekSQa8/Ogvjp0KMHVYXWoUs1Vwc9Bd4RZZfu0WrkHibCXpbQ0=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement the abstractions needed for multicolor led class devices,
including:

* `led::MultiColor` - the led mode implementation

* `MultiColorSubLed` - a safe wrapper arround `mc_subled`

* `led::MultiColorDevice` - a safe wrapper around `led_classdev_mc`

* `led::DeviceBuilder::build_multicolor` - a function to register a new
  multicolor led class device

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/led.rs              |  34 ++-
 rust/kernel/led/multicolor.rs   | 445 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 479 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4b31aa7f432f..81a03985322a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -69,6 +69,7 @@
 #include <linux/iosys-map.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index 7cd8f0504649..b25a6f992a62 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -25,8 +25,16 @@
     types::Opaque, //
 };
 
+#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
+mod multicolor;
 mod normal;
 
+#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
+pub use multicolor::{
+    MultiColor,
+    MultiColorDevice,
+    MultiColorSubLed, //
+};
 pub use normal::{
     Device,
     Normal, //
@@ -228,7 +236,24 @@ pub enum Color {
     Violet = bindings::LED_COLOR_ID_VIOLET,
     Yellow = bindings::LED_COLOR_ID_YELLOW,
     Ir = bindings::LED_COLOR_ID_IR,
+    #[cfg_attr(
+        CONFIG_LEDS_CLASS_MULTICOLOR,
+        doc = "Use this color for a [`MultiColor`] led."
+    )]
+    #[cfg_attr(
+        not(CONFIG_LEDS_CLASS_MULTICOLOR),
+        doc = "Use this color for a `MultiColor` led."
+    )]
+    /// If the led supports RGB, use [`Color::Rgb`] instead.
     Multi = bindings::LED_COLOR_ID_MULTI,
+    #[cfg_attr(
+        CONFIG_LEDS_CLASS_MULTICOLOR,
+        doc = "Use this color for a [`MultiColor`] led with rgb support."
+    )]
+    #[cfg_attr(
+        not(CONFIG_LEDS_CLASS_MULTICOLOR),
+        doc = "Use this color for a `MultiColor` led with rgb support."
+    )]
     Rgb = bindings::LED_COLOR_ID_RGB,
     Purple = bindings::LED_COLOR_ID_PURPLE,
     Orange = bindings::LED_COLOR_ID_ORANGE,
@@ -269,7 +294,14 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
 ///
 /// Each led mode has its own led class device type with different capabilities.
 ///
-/// See [`Normal`].
+#[cfg_attr(
+    CONFIG_LEDS_CLASS_MULTICOLOR,
+    doc = "See [`Normal`] and [`MultiColor`]."
+)]
+#[cfg_attr(
+    not(CONFIG_LEDS_CLASS_MULTICOLOR),
+    doc = "See [`Normal`] and `MultiColor`."
+)]
 pub trait Mode: private::Sealed {
     /// The class device for the led mode.
     type Device<'bound, T: LedOps<Mode = Self> + 'bound>: Deref<Target = T>;
diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
new file mode 100644
index 000000000000..309487bdf38a
--- /dev/null
+++ b/rust/kernel/led/multicolor.rs
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Led mode for the `struct led_classdev_mc`.
+//!
+//! C header: [`include/linux/led-class-multicolor.h`](srctree/include/linux/led-class-multicolor.h)
+
+use core::{
+    cell::UnsafeCell,
+    num::NonZero,
+    ptr, //
+};
+
+use crate::types::ScopeGuard;
+
+use super::*;
+
+/// The led mode for the `struct led_classdev_mc`. Leds with this mode can have multiple colors.
+pub enum MultiColor {}
+impl Mode for MultiColor {
+    type Device<'bound, T: LedOps<Mode = Self> + 'bound> = MultiColorDevice<'bound, T>;
+}
+impl private::Sealed for MultiColor {}
+
+/// The multicolor sub led info representation.
+///
+/// This structure represents the Rust abstraction for a C `struct mc_subled`.
+#[repr(C)]
+#[derive(Debug)]
+#[non_exhaustive]
+pub struct MultiColorSubLed {
+    /// The color of the sub led
+    pub color: Color,
+    brightness: UnsafeCell<u32>,
+    intensity: UnsafeCell<u32>,
+    /// The maximum supported intensity value.
+    ///
+    /// If None the maximum intensity equals to [`LedOps::MAX_BRIGHTNESS`].
+    pub max_intensity: Option<NonZero<u32>>,
+    /// Arbitrary data for the driver to store.
+    pub channel: u32,
+}
+
+// SAFETY: `MultiColorSubLed` can be shared among threads.
+unsafe impl Sync for MultiColorSubLed {}
+
+impl Clone for MultiColorSubLed {
+    fn clone(&self) -> Self {
+        Self {
+            color: self.color,
+            brightness: self.brightness().into(),
+            intensity: self.intensity().into(),
+            max_intensity: self.max_intensity,
+            channel: self.channel,
+        }
+    }
+}
+
+// We directly pass a reference to the `subled_info` field in `led_classdev_mc` to the driver via
+// `Device::subleds()`.
+// We need safeguards to ensure `MultiColorSubLed` and `mc_subled` stay identical.
+const _: () = {
+    use core::mem::offset_of;
+
+    const fn assert_same_type<T>(_: &T, _: &T) {}
+
+    let rust_zeroed = MultiColorSubLed {
+        color: Color::White,
+        brightness: UnsafeCell::new(0),
+        intensity: UnsafeCell::new(0),
+        max_intensity: None,
+        channel: 0,
+    };
+    let c_zeroed = bindings::mc_subled {
+        color_index: 0,
+        brightness: 0,
+        intensity: 0,
+        max_intensity: 0,
+        channel: 0,
+    };
+
+    assert!(offset_of!(MultiColorSubLed, color) == offset_of!(bindings::mc_subled, color_index));
+    assert!(
+        offset_of!(MultiColorSubLed, brightness) == offset_of!(bindings::mc_subled, brightness)
+    );
+    assert!(offset_of!(MultiColorSubLed, intensity) == offset_of!(bindings::mc_subled, intensity));
+    assert!(
+        offset_of!(MultiColorSubLed, max_intensity)
+            == offset_of!(bindings::mc_subled, max_intensity)
+    );
+    assert!(offset_of!(MultiColorSubLed, channel) == offset_of!(bindings::mc_subled, channel));
+
+    assert_same_type(&0u32, &c_zeroed.color_index);
+    assert_same_type(&rust_zeroed.brightness.into_inner(), &c_zeroed.brightness);
+    assert_same_type(&rust_zeroed.intensity.into_inner(), &c_zeroed.intensity);
+    assert!(size_of_val(&rust_zeroed.max_intensity) == size_of_val(&c_zeroed.max_intensity));
+    assert_same_type(&rust_zeroed.channel, &c_zeroed.channel);
+
+    assert!(size_of::<MultiColorSubLed>() == size_of::<bindings::mc_subled>());
+};
+
+impl MultiColorSubLed {
+    /// Create a new multicolor sub led info.
+    #[inline]
+    pub const fn new(color: Color) -> Self {
+        Self {
+            color,
+            brightness: UnsafeCell::new(0),
+            intensity: UnsafeCell::new(0),
+            max_intensity: None,
+            channel: 0,
+        }
+    }
+
+    /// Set arbitrary data for the driver.
+    #[inline]
+    pub const fn channel(mut self, channel: u32) -> Self {
+        self.channel = channel;
+        self
+    }
+
+    /// Set the initial intensity of the subled.
+    #[inline]
+    pub const fn initial_intensity(mut self, intensity: u32) -> Self {
+        self.intensity = UnsafeCell::new(intensity);
+        self
+    }
+
+    /// Set the maximum supported intensity of the subled.
+    #[inline]
+    pub const fn max_intensity(mut self, max_intensity: NonZero<u32>) -> Self {
+        self.max_intensity = Some(max_intensity);
+        self
+    }
+
+    /// The intensity of the sub led.
+    #[inline]
+    pub const fn intensity(&self) -> u32 {
+        // SAFETY:
+        // - `self.intensity.get()` is a valid pointer to `u32`.
+        // - We don't have exclusive or immutable access to `self.intensity`,
+        //   but the alignment should prevent "load tearing".
+        unsafe { *self.intensity.get() }
+    }
+
+    /// The brightness of the sub led.
+    #[inline]
+    pub const fn brightness(&self) -> u32 {
+        // SAFETY:
+        // - `self.brightness.get()` is a valid pointer to `u32`.
+        // - We don't have exclusive or immutable access to `self.brightness`,
+        //   but the alignment should prevent "load tearing".
+        unsafe { *self.brightness.get() }
+    }
+}
+
+/// The multicolor led class device representation.
+///
+/// This structure represents the Rust abstraction for a multicolor led class device.
+#[pin_data(PinnedDrop)]
+pub struct MultiColorDevice<'bound, T: 'bound = ()> {
+    #[pin]
+    ops: T,
+    #[pin]
+    classdev: Opaque<bindings::led_classdev_mc>,
+    _p: PhantomData<&'bound ()>,
+}
+
+impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
+    /// Registers a new [`MulticolorDevice`].
+    pub fn build_multicolor<'bound: 'init, T: LedOps<Mode = MultiColor> + 'bound>(
+        self,
+        parent: &'bound device::Device<Bound>,
+        ops: impl PinInit<T, Error> + 'init,
+        subleds: &'init [MultiColorSubLed],
+    ) -> impl PinInit<MultiColorDevice<'bound, T>, Error> + 'init {
+        const_assert!(T::MAX_BRIGHTNESS <= i32::MAX.unsigned_abs() || !T::HAS_BRIGHTNESS_GET);
+
+        try_pin_init!(MultiColorDevice {
+            ops <- ops,
+            classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_classdev_mc| {
+                let mut colors = [false; bindings::LED_COLOR_ID_MAX as usize];
+                for subled in subleds {
+                    if colors[subled.color as usize] {
+                        dev_err!(parent.as_ref(), "duplicate color in multicolor led\n");
+                        return Err(EINVAL);
+                    }
+                    colors[subled.color as usize] = true;
+                }
+                let subleds_box = KBox::pin_slice(
+                    |index| Ok::<_, Error>(subleds[index].clone()),
+                    subleds.len(),
+                    GFP_KERNEL,
+                )?;
+                let subleds_box_raw = KBox::into_raw(Pin::into_inner(subleds_box));
+
+                let subled_guard = ScopeGuard::new(|| {
+                    // SAFETY: `subleds_box_raw` is guaranteed to be a valid pointer to
+                    // `[MultiColorSubLed]`.
+                    drop(unsafe { <KBox<[MultiColorSubLed]>>::from_raw(subleds_box_raw) });
+                });
+
+                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
+                // `led_classdev_mc` gets fully initialized in-place by
+                // `led_classdev_multicolor_register_ext` including `mutex` and `list_head`.
+                unsafe {
+                    ptr.write(bindings::led_classdev_mc {
+                        led_cdev: bindings::led_classdev {
+                            brightness_set: (!T::BLOCKING)
+                                .then_some(Adapter::<T>::brightness_set_callback),
+                            brightness_set_blocking: T::BLOCKING
+                                .then_some(Adapter::<T>::brightness_set_blocking_callback),
+                            brightness_get: T::HAS_BRIGHTNESS_GET
+                                .then_some(Adapter::<T>::brightness_get_callback),
+                            blink_set: T::HAS_BLINK_SET.then_some(Adapter::<T>::blink_set_callback),
+                            max_brightness: T::MAX_BRIGHTNESS,
+                            brightness: self.initial_brightness,
+                            color: self.color as u32,
+                            name: self.name.map_or(core::ptr::null(), CStrExt::as_char_ptr),
+                            ..bindings::led_classdev::default()
+                        },
+                        num_colors: u32::try_from(subleds_box_raw.len())?,
+                        // CAST: The safeguards in the const block ensure that
+                        // `MultiColorSubLed` has an identical layout to `mc_subled`.
+                        subled_info: subleds_box_raw.cast::<bindings::mc_subled>(),
+                    })
+                };
+
+                let mut init_data = bindings::led_init_data {
+                    fwnode: self
+                        .fwnode
+                        .as_ref()
+                        .map_or(core::ptr::null_mut(), |fwnode| fwnode.as_raw()),
+                    default_label: core::ptr::null(),
+                    devicename: self
+                        .devicename
+                        .map_or(core::ptr::null(), CStrExt::as_char_ptr),
+                    devname_mandatory: self.devname_mandatory,
+                };
+
+                // SAFETY:
+                // - `parent.as_ref().as_raw()` is guaranteed to be a pointer to a valid
+                //    `device`.
+                // - `ptr` is guaranteed to be a pointer to an initialized `led_classdev_mc`.
+                to_result(unsafe {
+                    bindings::led_classdev_multicolor_register_ext(
+                        parent.as_ref().as_raw(),
+                        ptr,
+                        if self.name.is_none() {
+                            &raw mut init_data
+                        } else {
+                            core::ptr::null_mut()
+                        },
+                    )
+                })?;
+
+                subled_guard.dismiss();
+
+                core::mem::forget(self.fwnode); // keep the reference count incremented
+
+                Ok::<_, Error>(())
+            }),
+            _p: PhantomData,
+        })
+    }
+}
+
+impl<'bound, T: 'bound> MultiColorDevice<'bound, T> {
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::MultiColorDevice`.
+    #[inline]
+    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a Self {
+        // SAFETY: The function's contract guarantees that `led_cdev` points to a `led_classdev`
+        // field embedded within a valid `led::MultiColorDevice`. `container_of!` can therefore
+        // safely calculate the address of the containing struct.
+        let led_mc_cdev = unsafe { container_of!(led_cdev, bindings::led_classdev_mc, led_cdev) };
+
+        // SAFETY: It is guaranteed that `led_mc_cdev` points to a `led_classdev_mc`
+        // field embedded within a valid `led::MultiColorDevice`. `container_of!` can therefore
+        // safely calculate the address of the containing struct.
+        unsafe { &*container_of!(Opaque::cast_from(led_mc_cdev), Self, classdev) }
+    }
+
+    /// Returns the subleds passed to [`Device::new_multicolor`].
+    #[inline]
+    pub fn subleds(&self) -> &[MultiColorSubLed] {
+        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
+        // valid `led_classdev_mc`.
+        let raw = unsafe { &*self.classdev.get() };
+        // SAFETY: `raw.subled_info` is a valid pointer to `mc_subled[num_colors]`.
+        // CAST: The safeguards in the const block ensure that `MultiColorSubLed` has an identical
+        // layout to `mc_subled`.
+        unsafe {
+            core::slice::from_raw_parts(
+                raw.subled_info.cast::<MultiColorSubLed>(),
+                // CAST: It is guaranteed that `num_colors` fits into an `usize`.
+                raw.num_colors as usize,
+            )
+        }
+    }
+}
+
+impl<'bound, T: LedOps + 'bound> Deref for MultiColorDevice<'bound, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.ops
+    }
+}
+
+// SAFETY: A `led::MultiColorDevice` can be unregistered from any thread.
+unsafe impl<'bound, T: 'bound + Send> Send for MultiColorDevice<'bound, T> {}
+
+// SAFETY: `led::MultiColorDevice` can be shared among threads because all methods of `led::Device`
+// are thread safe.
+unsafe impl<'bound, T: 'bound + Sync> Sync for MultiColorDevice<'bound, T> {}
+
+struct Adapter<T: LedOps<Mode = MultiColor>> {
+    _p: PhantomData<T>,
+}
+
+impl<T: LedOps<Mode = MultiColor>> Adapter<T> {
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::MultiColorDevice`.
+    /// This function is called on setting the brightness of a led.
+    unsafe extern "C" fn brightness_set_callback(
+        led_cdev: *mut bindings::led_classdev,
+        brightness: u32,
+    ) {
+        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+        // `led_classdev` embedded within a `led::MultiColorDevice`.
+        let classdev = unsafe { MultiColorDevice::<T>::from_raw(led_cdev) };
+
+        // SAFETY: `classdev.classdev.get()` is guaranteed to be a pointer to a valid
+        // `led_classdev_mc`.
+        unsafe { bindings::led_mc_calc_color_components(classdev.classdev.get(), brightness) };
+
+        let _ = classdev.brightness_set(brightness);
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::MultiColorDevice`.
+    /// This function is called on setting the brightness of a led immediately.
+    unsafe extern "C" fn brightness_set_blocking_callback(
+        led_cdev: *mut bindings::led_classdev,
+        brightness: u32,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+            // `led_classdev` embedded within a `led::MultiColorDevice`.
+            let classdev = unsafe { MultiColorDevice::<T>::from_raw(led_cdev) };
+
+            // SAFETY: `classdev.classdev.get()` is guaranteed to be a pointer to a valid
+            // `led_classdev_mc`.
+            unsafe { bindings::led_mc_calc_color_components(classdev.classdev.get(), brightness) };
+
+            classdev.brightness_set(brightness)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::MultiColorDevice`.
+    /// This function is called on getting the brightness of a led.
+    unsafe extern "C" fn brightness_get_callback(led_cdev: *mut bindings::led_classdev) -> u32 {
+        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+        // `led_classdev` embedded within a `led::MultiColorDevice`.
+        let classdev = unsafe { MultiColorDevice::<T>::from_raw(led_cdev) };
+
+        // CAST: Resulting value will be casted back to i32 in the led subsystem.
+        from_result(|| {
+            classdev
+                .brightness_get()
+                .inspect(|val| debug_assert!(*val <= T::MAX_BRIGHTNESS))
+                .and_then(|val| Ok(i32::try_from(val)?))
+        }) as u32
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::MultiColorDevice`.
+    /// `delay_on` and `delay_off` must be valid pointers to `usize` and have
+    /// exclusive access for the period of this function.
+    /// This function is called on enabling hardware accelerated blinking.
+    unsafe extern "C" fn blink_set_callback(
+        led_cdev: *mut bindings::led_classdev,
+        delay_on: *mut usize,
+        delay_off: *mut usize,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+            // `led_classdev` embedded within a `led::MultiColorDevice`.
+            let classdev = unsafe { MultiColorDevice::<T>::from_raw(led_cdev) };
+
+            classdev.blink_set(
+                // SAFETY: The function's contract guarantees that `delay_on` points to a `usize`
+                // and is exclusive for the period of this function.
+                unsafe { &mut *delay_on },
+                // SAFETY: The function's contract guarantees that `delay_off` points to a `usize`
+                // and is exclusive for the period of this function.
+                unsafe { &mut *delay_off },
+            )?;
+            Ok(0)
+        })
+    }
+}
+
+#[pinned_drop]
+impl<'bound, T: 'bound> PinnedDrop for MultiColorDevice<'bound, T> {
+    fn drop(self: Pin<&mut Self>) {
+        let raw = self.classdev.get();
+        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
+        // valid `led_classdev_mc`.
+        let dev: &device::Device = unsafe { device::Device::from_raw((*raw).led_cdev.dev) };
+
+        let _fwnode = dev
+            .fwnode()
+            // SAFETY: the reference count of `fwnode` has previously been
+            // incremented in `led::DeviceBuilder::build_multicolor`.
+            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode)) });
+
+        // SAFETY: The existence of `self` guarantees that `self.classdev` has previously been
+        // successfully registered with `led_classdev_multicolor_register_ext`.
+        unsafe { bindings::led_classdev_multicolor_unregister(raw) };
+
+        // SAFETY: `raw` is guaranteed to be a valid pointer to `led_classdev_mc`.
+        let led_cdev = unsafe { &*raw };
+
+        // SAFETY: `led_cdev.subled_info` is guaranteed to be a valid pointer to
+        // `[MultiColorSubLed]` with length of `led_cdev.num_colors`.
+        // See `led::DeviceBuilder::build_multicolor`.
+        drop(unsafe {
+            KBox::from_raw(ptr::slice_from_raw_parts_mut(
+                led_cdev.subled_info.cast::<MultiColorSubLed>(),
+                // CAST: `num_colors` was originally converted from a `usize` in
+                // `DeviceBuilder::build_multicolor`. Thus it is guaranteed that
+                // `num_colors` fits into an usize.
+                led_cdev.num_colors as usize,
+            ))
+        });
+    }
+}

-- 
2.55.0

