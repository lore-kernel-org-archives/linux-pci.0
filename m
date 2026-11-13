Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577068;
	b=Vp5/UIgDNWsklyS4GBd1sViZOmw73mwa0+zISRbw/1HbVEu/79Zq3swtzKcApKsWHSh7
	 JAwY5U9O/xFplX3lYJqS6+HUBMOMVi/uCLVjJTLmR7/r38aRGuITGdsF1JkQVeHK/b0p2
	 OgBpPQ/YliKUaW2NA0lzIiuzu8hk5fhrXzdeodiqfLdfVyMy4f4tRhqrkJ59d9roZKwkb
	 HRDqdKH7won5pMEgM/oiMJkzYkCoolJA0b3A9rEdFOa1jBXB43H2sP+48OT0uibl6sgET
	 cG86HWjZyus7mDSoolhw47SilPkZ2ap2HpKgsS4Y4vGhQ+QVi2gfcoKgU6Vg6TthLqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=AQhO4t6IshX2EjLlYJ/abj8dRXiVupVwuZDYUut6ED4=;
	b=pYN5VqkseadbXRwuLTvaOTf9K6aOqpEWCLHGyjRTN4maMvsQXSrzcg1jaU7GIIBvLDeR
	 NrHrtX0u5g6x5RR8NLuvA1f6f3SPsGgKgghFVz5aWDRXLz6gTpl/IATWvAw7JYYiHIvsw
	 cT3gR+XNw9vq2dQDNppqArs/7kAUU0GogJLIjHyzlZYP/FmlvWwaoxkqj9vTG8X/wpZ9L
	 lzQzeRoG7V49Jaj5VU+uNg0+/YhQLFxg9XKJW49FqQ70ymX/7i0lFNz+oiB8KQGp1HhVP
	 lAiLBfuLRnxhr0KYlMxpnWTVQ8Bzznbijf4mgwl0Y4LlIfOdoh/UeQcd+CPTxThqokA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=XvjCgwmb;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379C606A334
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 13:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4379C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=XvjCgwmb
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B134E240032
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794577066;
	bh=AQhO4t6IshX2EjLlYJ/abj8dRXiVupVwuZDYUut6ED4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=XvjCgwmbgi/+8jZaznqNdURfcZ9Irn0XKAtJeEHaKvWhHJ+tvb1cQJbL4My5udlJJ
	 XrS+74n9P+h3A8Fr3NYvxyFUKLfrfoRHiPpWqt1AOckCVYKTaFVW7r/fNDJ5CUHPQR
	 XJMe8sYClmtzE67OK2ryZ72Sk77aAs7oamp8XUm7EOOfQqfyY52oeEy6MHaUXarrTN
	 BO+JMpJkSUEHbOLzUpxELBeJa6FB38dmpfkWbsx31jCAQjwjj5WQnJ78T+hvo7Xzh6
	 CoES5hyibOByR67a7lqSyR1VfnBb3cHdOddNtPd7B0Mnqlo+BGXZb9v1ZpvpFlA1s4
	 Pa8C+U1KpX1Zg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQyxM55bmz6v12;
	Fri, 13 Nov 2026 14:37:43 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 13 Nov 2026 13:37:45 +0000
Subject: [PATCH v28 2/4] rust: leds: Add Mode trait
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
Message-Id: <20261113-rust_leds-v28-2-b8cf2f74fa57@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=F2SZAVj++qO6M17yqoRRpw77iquvkpy2UzcZXzVH7Q8=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9xKi4TwjxSDBRbHedmbVXKzIClbf7ktDdpR4o
 4n+BRveqa6JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavcSohsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JZGw//W3vjAAzbrReHyvIcq0pckciGvwnQNuW
 M8kUxHUndg3uqg7aIAfc6PteiFIc2uQswcVBWI5ghfyGFw4UsSmFEE8BgcJ5u1I9a0KWubbKHxK
 tDKTgUuI/CTenSDx7XAPu3XAIhY9GpRJHsaDak1O6Q60EyQpissoUHu7WID2Tw0DQt8bkqnunV1
 82RARVP6J1B4ye06RTfeHHITGnKZBLbbyW7HYv1K6RpaYwp+7dm3AxlikSqC+hQtTexkqo/VxHp
 qLH5yQR7fq3s1Bh7quRAOA0BdWvTw9RnHRlzdHSztwvGNbEBm6moSuJozYXUxuGc3rXCiLKSz4a
 tHUVjWeCnPQWbPaa0m5CPvgEYt/79X+qehVKGIczDKiqna+Z0nmUyUJlHT0UUMmz9N+eDxqW++z
 /V80H0vXM/DpdnI2RWFuBMxMD5c3yXJcWja3SY46tqGtmTcER26tCjUzAUALbHWMRWFTYWx54ix
 2aP//M9/7xwQGjNZiGkVayrYXY2+kKSI1hbMGiHJiuQ4lFz7U3+QHqeZpluZZEDkpJ1XYjxHAX9
 eqDh2Ffn2p7XxbS1uCgJ6I8VZ086rxnTdpimAPBHof5BOBA1gDxKit7u7AUhxOzo7kVQyiIjUca
 cWsGYb6pNiHtnObrb4wiE68h9amhvzo8/NXeez/3TrqdI/O+M9KQ=
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
2.56.1

