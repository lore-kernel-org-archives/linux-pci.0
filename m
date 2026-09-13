Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F65372662
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316134; cv=none; b=iDtyL2HmuAuSN5rQqj2CVZgO+/A7ZH/nAUiqWekqzhFbruFNqOO6+XHXne7WpZARD6y89wXLy431Dgn2iUPdq/kuNs+b1m5QktKq4E6CLAlAUlQR5lqp9WtvnHxr3+Y3TkN4fj40Bc1lObKtDaofrKEIfPQslM4hrEo96Mfp0cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316134; c=relaxed/simple;
	bh=nGlWCckWplXReJvD5In9Ul0BjlRCAccABtJ7zL4119w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAfZgvxiiRVOnBUDWjA8mIJFLo7HvGHEB2R4QPttCMaHUEM8ys5gqMw+J8RjD1yQNnNPjgpfSu8u/QjFy7bs7g0X8byp7a18JMMrr9bDIjIgvEvg/Zqfgsn9+h73rSpruuF8EqDysAFkfStMQKkjhvAdNCWcQPFq0Xbx4ITaHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ejcfgALx; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ejcfgALx"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id DADBF24002F
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 18:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789316128;
	bh=zOXLDrWTt6vMg3DAwzxE1v5PRDK5diw3tSI+eXhQHm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=ejcfgALxAOxECmeefi51Ei2SOQz+XwNCOmVVUTSWOgu03kAFH51N1TlnwMSOMb93E
	 y6qSNjp8hHWcxEUuqhc7xkO8EB6msAwhzzTMblGbFr9h2MyJRaqxgF6aHZ2afOotvK
	 wbs9OEJ60LKasxawtBKhMhu5pGQJn0HMZcZjegBM2jeANvnRkYCa7Ab+88H+cFrG9s
	 nDtHc/TK2g5duPQal7TJIrQZaJ8sCH/3Vcv/RFu4GjmuW2HYVb7H4Q5PIL22c4GVMG
	 HzEZCg2vZsvv4ZhMWWVR1gz63a6biCnXxqw6z8kFiMUbtrHJCNMHQTowocH1lZn395
	 HPveNzljNMDvg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hjYKS5CSTz9rxG;
	Sun, 13 Sep 2026 18:15:24 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 13 Sep 2026 16:15:27 +0000
Subject: [PATCH v25 2/4] rust: leds: add Mode trait
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rust_leds-v25-2-1a10371d78c3@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=nGlWCckWplXReJvD5In9Ul0BjlRCAccABtJ7zL4119w=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqpswVnPXmHQl09Kh3m0znWfjzvG1TCLN1WMJ2R
 lPIyggb8WOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaqbMFRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Ih/BAAh++grf74LOmNBBlyMsez+69a2/xzY6B
 JTV818a1WUMB7XFZW7HsTxcukERzA4ximqh/b7dXRBTzPUmuA8aPMS0XPq3ryCAFsVdLSam3pzb
 PqnHtVyW3cVmnN4h8JER15YUXoJAwr9eFdX5GKmTFTIFvL1BacEDYWGWKXMx10FLdKVrrQVvBy/
 XInTLJtKlnzWbax3Neh/SBIr9OaG3eGpw1VF0zSPSU0nKf6cAoZo4Vl4dJy5/Y1O+MPNNM8PGcg
 BTepYF0OzOKB44YF70yrkz8QV8e2bWf7mQaQHuUmPeoFR8QvZ9dPwoBdeaynN9SwKawU5FAYb4B
 XnzfBeD/4NBdFm6Lc0086zO/rCq8EAJlO7o7c0gRjhlsCRFOCxK0xDh9QEIZaFW2w96bt30FwIX
 Yp2u6J5kCbqH/3j0rsQJuExVR40bUORC0t4JhGGmI9RqN6aaMmLLqJ6fHN1l+CLcGVexee5bXMG
 Mc1v9LwlZ6O2g6Z7jaRu6PgT/Fs1wihxKYEMx5Ax3iGQ1MhCW/mqsutAoK1wMCkQEkIfX0+cJY3
 144YZii33rrZYWFWFQwHs4rKFOhfvNQhDh+pTJDkO87jys3dmbHRfSRPzwvjkTL3VhXU2F7SfTN
 ZjxzecIX3myDjayNvwr1e2t6FTrb1Is8ObaX2FN8PI+1TxdrLM2E=
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
 rust/kernel/led.rs        | 37 ++++++++++++++++++++++++++-----------
 rust/kernel/led/normal.rs | 12 ++++++++++--
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index deda8cc548a8..7cd8f0504649 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -4,11 +4,7 @@
 //!
 //! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
 
-use core::{
-    marker::PhantomData,
-    mem::transmute,
-    ptr::NonNull, //
-};
+use core::{marker::PhantomData, mem::transmute, ops::Deref, ptr::NonNull};
 
 use crate::{
     container_of,
@@ -31,7 +27,10 @@
 
 mod normal;
 
-pub use normal::Device;
+pub use normal::{
+    Device,
+    Normal, //
+};
 
 /// The name of the led is determined by the driver.
 pub enum Named {}
@@ -156,6 +155,7 @@ pub fn name(self, name: &'init CStr) -> Self {
 ///
 /// #[vtable]
 /// impl led::LedOps for MyLedOps {
+///     type Mode = led::Normal;
 ///     const BLOCKING: bool = false;
 ///     const MAX_BRIGHTNESS: u32 = 255;
 ///
@@ -176,16 +176,21 @@ pub trait LedOps: Send + Sync + Sized {
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
@@ -196,7 +201,7 @@ fn brightness_get<'bound>(self: &Device<'bound, Self>) -> Result<u32> {
     ///
     /// See also [`LedOps::BLOCKING`].
     fn blink_set<'bound>(
-        self: &Device<'bound, Self>,
+        self: &<Self::Mode as Mode>::Device<'bound, Self>,
         delay_on: &mut usize,
         delay_off: &mut usize,
     ) -> Result<()> {
@@ -260,6 +265,16 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
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

