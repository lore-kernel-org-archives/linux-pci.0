Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577072;
	b=ysjqY22XR18q4U+hndOR+eNVNdxxIyVbVPiyOQTgeJDLCFPdzjRZvf0piVFbXoTM+37p
	 wVxeKLHZHMx8KuMInaitfdXUAkk/tEt2PoqjNUgH0Ql3oiJ7Nf6OQM9D5TnJz8//0P/Mk
	 GoaBVr3yL/Mbv+N+BzFBIH6GIcXX1zbkjSpsMP6SN4EXc/tt5WtsvUdBHqUXs24fugkLY
	 RVF6o0l4O0l/VVDmgw250mjHZXuzmPfwp45rJf08R342retbfPfNIz5nFsggM6WYmny5q
	 ecLYgFp27IxkzsidE1XYfAEghqtJPnnXotHRU8U23hH4MeWIGYqLQtmCcl4uM08oyZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=QzdlonqghnN4zkAmWlEVi5KKm79hEDXJqY/RU8AJW0E=;
	b=VzynPGP1qQoAP19kIabX6xg822VCLP8RA+3pyjwRc21YfCXd1UlhjY3gDYph+TT7xQo9
	 9op5xCOCw0smEawPHixu9S4cA7n8e0zsxbYEN5eG/N9F4jCBYfdzFgMzbVXKKYO8Xzk+q
	 cBNnaTmAZ11xNR7K7HzD3gzTcMBM4v5Gr4p5BjRDVEfOCDPMGkSstauuQnqSpKUKtlBbC
	 bLafW9DvxGj3+EV3GqY21UMJy66RCpbS6CMSdN37K+QBhFvwMXWXrw3zzQ+lJvG665kWb
	 HpnIkJL38LMFuyUAP98wCB4Ydox+LR83Ctcvt2S/plEnSVyU2KxsuPNFbXycivKGi+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=JFnQ5xV4;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4C606A8B5
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 13:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC4C606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=JFnQ5xV4
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1F98B240106
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:37:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794577069;
	bh=QzdlonqghnN4zkAmWlEVi5KKm79hEDXJqY/RU8AJW0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=JFnQ5xV4QmAB0+duYtqGpFrk5rjQ9mL/JfbgHZjnh5s+EAvYMHaRVjyfoHwb+81he
	 uLYyqNtyGdqpKm/3U6Ls0zVbiHBV3uykqRVzduo1lvK8IPIkI1pGqdY36bJGqWvN18
	 z1ohgd7JggE/0qLTlTs8ygdExv/2/XYeuEqZMzDmil8c3FtekvhM041UMQNJU4fFhy
	 WQl86pNRv+hqR1tA+ymkdBdaewOuqRT1LWefmZXguNxXd8CfqPwt2LwmRwGOvGQVXJ
	 fhzqzsyLYtHo6DA+XMPdWcGULNZIITDV9kDaiECa5+kEALrLpa/KpATQCLzDDco0O4
	 yDMp0eFXI+eGQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQyxP5Bzzz6txv;
	Fri, 13 Nov 2026 14:37:45 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 13 Nov 2026 13:37:47 +0000
Subject: [PATCH v28 3/4] rust: leds: Add multicolor classdev abstractions
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-rust_leds-v28-3-b8cf2f74fa57@posteo.de>
References: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>
In-Reply-To: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21734;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=HX4HRb53/kqgdH9vzqugyVs+ephQmfcyQGg8LDfe8AE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9xKizbhSJOsvMYmBSq9jE+Qe+eyyGeJALAdv2
 Jb8ke4VnF6JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavcSohsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9J3lRAApjZjsOGkom1EkUI3xjTvCL6hCOkLgeu
 F5G3hajYIGpbm4COLfODyJfcOe5CQna78KpMX9lG9w+0jJ+O00YC6rQ9ABj8kl6+ZROdQeV1e5j
 GI2PM9TzrfCUhTTTK5RL7atDaO/oA13UNh8oA9JpgQMTe1haCIyhI8s1maBO0nkReEnEecGkNXf
 PAuyJ09Udh9HAK6o0JD3mXmIC2uXRIIE4fxH9o5w1Fm3Kg/cKBgtL6beAWbpEQenw5ZNhl5cGHC
 t49QrMER1mZk3ME35AUGJ25ATXmZ7pnmJCu8VgwC0hZl12iPUsyg14/htQb39DQgwlLMx+3J3UI
 2Y7QTL8mjR6CLOPClAzB0VsqT+pJlhq52zKrg8qd7uJmeaUgjlDbAVT0luFAzYCsvGsThPepzGB
 ILMtGmIquAK8clR+41UN/nf3K+fqN/GNzmLRlnzyOeExTD7eL7LkuMFY5ncynR6rdSRu1npg4TS
 5FvK7OEOau2YW+WEogK1VZ3s+5hWjP1pXvIrMMDVHze0pekfUmWthSPMZgYlVDDGUFUWroA/fy5
 fQVH2mTXBLWDrBhxNeyE4K3cH+NmJXVcaOQK8qH/u0bGr3v9T1yJ1Kl4rSemmPrMCVranPSZ2gQ
 R07v+UvZtur3jzRNnrdFeyM+Qo+3nhFsVnTHzgkKwKBec5ih0/Es=
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
 rust/kernel/led.rs              |  34 +++-
 rust/kernel/led/multicolor.rs   | 442 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 476 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..3dba24b364ad 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -70,6 +70,7 @@
 #include <linux/iosys-map.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index c17f8ef75006..4b66fe41a80c 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -30,8 +30,16 @@
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
@@ -233,7 +241,24 @@ pub enum Color {
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
@@ -274,7 +299,14 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
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
index 000000000000..58dd1a12bc3c
--- /dev/null
+++ b/rust/kernel/led/multicolor.rs
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Led mode for the `struct led_classdev_mc`.
+//!
+//! C header: [`include/linux/led-class-multicolor.h`](srctree/include/linux/led-class-multicolor.h)
+
+use core::{
+    num::NonZero,
+    ptr, //
+};
+
+use crate::{
+    sync::atomic::{
+        Atomic,
+        Relaxed, //
+    },
+    types::ScopeGuard, //
+};
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
+    brightness: Atomic<u32>,
+    intensity: Atomic<u32>,
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
+            brightness: Atomic::new(self.brightness()),
+            intensity: Atomic::new(self.intensity()),
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
+        brightness: Atomic::new(0),
+        intensity: Atomic::new(0),
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
+    assert_same_type(&0u32, &c_zeroed.brightness);
+    assert_same_type(&0u32, &c_zeroed.intensity);
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
+            brightness: Atomic::new(0),
+            intensity: Atomic::new(0),
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
+        self.intensity = Atomic::new(intensity);
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
+    pub fn intensity(&self) -> u32 {
+        self.intensity.load(Relaxed)
+    }
+
+    /// The brightness of the sub led.
+    #[inline]
+    pub fn brightness(&self) -> u32 {
+        self.brightness.load(Relaxed)
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
+                let subleds_box = KBox::pin_slice::<_, _, Error, Error>(
+                    |index| Ok(subleds[index].clone()),
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
2.56.1

