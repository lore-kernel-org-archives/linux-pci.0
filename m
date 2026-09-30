Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3414E2F09
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773564; cv=none; b=ofYNOwJmG3xfxZKD+NRDWLt0qohey0zWs8if5yQ2gdP71BYtjGDVvYG21LOw7HjRqV9wxYlO50Y1E8rWnRqfOxAMuQ4Uqdpa3Un5LyCz8zODchffgaFRjDe/Hl7SqYtRGpFJE8heS/FlVktXF2DCsEiw7OWhD+iDodAzu5243e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773564; c=relaxed/simple;
	bh=T5jFSZhnJXyl8J1nAaebPNgFMg1/74G8qletYMXyqFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohB6vJBc3Mizl/sNikLTD0BXJhm3smib7vbiQ3bsGyxjxGSyxAxArErtYoGbmihmyKVt4MYJkPwMQB/RTpzkbx3O8yJCJHRojOgViVtMVBDx5ow7SUcZtbhHwsBLbYo2neLj4X4KNVx++jA7mXgPBdoOQF700RjpN4Yj3OhBHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=k5cXItiU; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="k5cXItiU"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4FA2A24010A
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790773531;
	bh=+3RFCoJpzpJ0WjgvNUCfn1RUD6/EzjuyTZJPxszpqlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=k5cXItiUSf9WUS0/H+mMC478lLcVWJtOpZBXfHAayrTtoWjtOXnW13eXLi7puuCZ8
	 Y3onbs3w9exIWtxIgpKZv/AZLtdZ4ZdI8YFxap1mJL37CPMr0991+jkMGigAt2KEUc
	 mJ+YJr8NTF1FnwT3vz4EK9oBqP0YTScTQKu7V9+IEL8EYhX46D1Ai50zUvO7EDnGX9
	 zTHnLa3e+0EWtmmNG0+jXdYDZVw1LEv8h3mHgXq4W25Q1rLLFS3G+iLKojEZ5F+muE
	 FNFwde+hJLgWjSbEyD8nV6KQk7Khfniwn7eM7YY+3oMoePU9qd/yxxaiWDPrWl5F2c
	 4e+ixxFTzVlEA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hvwJR3Vx4z9rxG;
	Wed, 30 Sep 2026 15:05:27 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 30 Sep 2026 13:05:29 +0000
Subject: [PATCH v26 2/4] rust: leds: Add Mode trait
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-rust_leds-v26-2-83837331020e@posteo.de>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
In-Reply-To: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=T5jFSZhnJXyl8J1nAaebPNgFMg1/74G8qletYMXyqFc=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqvQkRCTZSgspGrvVUx3W4k5s+S2PWHeTNz2S2x
 Fk6sdwPE2aJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCar0JERsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Lg+Q/+K/yMihv3WuvNOxX1SwCJcCUQO2Ig05R
 PMtdE2witBB+DiIZh+gIBmsFuIvOLimnNc5qUnfRm2AlCCrmPlEmq3aA9+Za2GKizIJMlxGsjLB
 nPdsdhdlyjPQndO9yWLSLqgucS0jhPHfvB3HmimDDL2Ya4WtfkrnPSgvwa7bOjt35Vfpjc3Jt+E
 PaN7pfGssbhfIlmqYWCh3K4qpr/j7W5AVwLIYNsEC0seCHDcgjCdEVpYmqqc2TkG8GQaap1MIt4
 tI/f233OO78pUv8YwpUE4cVnbGW2gDQBt/1L5vRYw5KPya0GyYFHQbBeApVfXHedw8mStL9m1Kc
 qdrrRdHoj/fpoV+20GQSp93bQc5nDmKQgxZRZ78uFuBpcDMuam4ocpmFAsNbZLDHNONloOOlRca
 cZC2VeR9ikXyqwdpM3Z8z1dpY4Gnkur7x12EfU5+6AGGZxKqpBEx7T1NoD/uACZDjVT5AGQ2lq2
 tmT8pJtTjtVSvws6n+3ty2N2V8JmTJDOOOVNRChnMBWh+JtsuAgPOpQgzZ4Rn51Ys8JMagFKxl7
 HReCjAUGmeFfC1Yg1FkeUPOw+4WVh2G0bl3rlkGGmmUPOtYSTjSWjK7pXKZ0UisdHb04zYV6KtX
 I9N9vhuspxkhwQUy/uNC91CPwW+7jSCRkizRs2Z8t8q1uXsXnigk=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Add the `led::Mode` trait to allow for other types of led class devices
in `led::LedOps`.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/led.rs        | 32 ++++++++++++++++++++++++++------
 rust/kernel/led/normal.rs | 12 ++++++++++--
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index deda8cc548a8..c17f8ef75006 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -7,6 +7,7 @@
 use core::{
     marker::PhantomData,
     mem::transmute,
+    ops::Deref,
     ptr::NonNull, //
 };
 
@@ -31,7 +32,10 @@
 
 mod normal;
 
-pub use normal::Device;
+pub use normal::{
+    Device,
+    Normal, //
+};
 
 /// The name of the led is determined by the driver.
 pub enum Named {}
@@ -156,6 +160,7 @@ pub fn name(self, name: &'init CStr) -> Self {
 ///
 /// #[vtable]
 /// impl led::LedOps for MyLedOps {
+///     type Mode = led::Normal;
 ///     const BLOCKING: bool = false;
 ///     const MAX_BRIGHTNESS: u32 = 255;
 ///
@@ -176,16 +181,21 @@ pub trait LedOps: Send + Sync + Sized {
     const BLOCKING: bool;
     /// The max brightness level.
     const MAX_BRIGHTNESS: u32;
-
     /// Sets the brightness level.
     ///
     /// See also [`LedOps::BLOCKING`].
-    fn brightness_set<'bound>(self: &Device<'bound, Self>, brightness: u32) -> Result<()>;
-
+    fn brightness_set<'bound>(
+        self: &<Self::Mode as Mode>::Device<'bound, Self>,
+        brightness: u32,
+    ) -> Result<()>;
     /// Gets the current brightness level.
-    fn brightness_get<'bound>(self: &Device<'bound, Self>) -> Result<u32> {
+    fn brightness_get<'bound>(self: &<Self::Mode as Mode>::Device<'bound, Self>) -> Result<u32> {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
+    /// The led mode to use.
+    ///
+    /// See [`Mode`].
+    type Mode: Mode;
 
     /// Activates hardware accelerated blinking.
     ///
@@ -196,7 +206,7 @@ fn brightness_get<'bound>(self: &Device<'bound, Self>) -> Result<u32> {
     ///
     /// See also [`LedOps::BLOCKING`].
     fn blink_set<'bound>(
-        self: &Device<'bound, Self>,
+        self: &<Self::Mode as Mode>::Device<'bound, Self>,
         delay_on: &mut usize,
         delay_off: &mut usize,
     ) -> Result<()> {
@@ -260,6 +270,16 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
     }
 }
 
+/// The led mode.
+///
+/// Each led mode has its own led class device type with different capabilities.
+///
+/// See [`Normal`].
+pub trait Mode: private::Sealed {
+    /// The class device for the led mode.
+    type Device<'bound, T: LedOps<Mode = Self> + 'bound>: Deref<Target = T>;
+}
+
 mod private {
     pub trait Sealed {}
 }
diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
index a22c29cfd262..992353319522 100644
--- a/rust/kernel/led/normal.rs
+++ b/rust/kernel/led/normal.rs
@@ -8,6 +8,14 @@
 
 use super::*;
 
+/// The led mode for the `struct led_classdev`. Leds with this mode can only have a fixed color.
+pub enum Normal {}
+
+impl Mode for Normal {
+    type Device<'bound, T: LedOps<Mode = Self> + 'bound> = Device<'bound, T>;
+}
+impl private::Sealed for Normal {}
+
 /// The led class device representation.
 ///
 /// This structure represents the Rust abstraction for a led class device.
@@ -22,7 +30,7 @@ pub struct Device<'bound, T: 'bound = ()> {
 
 impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
     /// Registers a new [`Device`].
-    pub fn build<'bound: 'init, T: LedOps + 'bound>(
+    pub fn build<'bound: 'init, T: LedOps<Mode = Normal> + 'bound>(
         self,
         parent: &'bound device::Device<Bound>,
         ops: impl PinInit<T, Error> + 'init,
@@ -120,7 +128,7 @@ struct Adapter<T: LedOps> {
     _p: PhantomData<T>,
 }
 
-impl<T: LedOps> Adapter<T> {
+impl<T: LedOps<Mode = Normal>> Adapter<T> {
     /// # Safety
     /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
     /// `led::Device`.

-- 
2.55.0

