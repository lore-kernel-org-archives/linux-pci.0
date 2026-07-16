Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73493A0E8A
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224280; cv=none; b=Igd7K5mXRupJ0NaeDIyS0c2MO6n0PT7XYpbPpXs3TMG32zjuMOdJ80+khuwUt9NQR2T/r2CuaBbdc+bFljNpGXBp6U2hm9QERhVKrji/f5GdXGRlrvpmSKk0l1QtDUNexilwJmlLNtZClvcSzMOpJsggXocnvPH+iYTCtPx81Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224280; c=relaxed/simple;
	bh=nc2dY/Fz8fnYk1jCgiVliPMUCfhD5G60Nz9Ipye79EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5a2l3g3AKMupLQXvyIgrVnxAioI8HsWG9lTNMN0GrOrf7F3SULEDpp+eTULJmH3UqinUofcFI3vc8bzzdgh9dDYE/P2QBWmk9hqJNU2Td5XB30RzDdSqtYh0XzniOCyCfiIw2joPGoWy1geME1tmaNm/jrVYldJCCj2GmpJUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=V06O6F71; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="V06O6F71"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 316DE240105
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 19:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784224277;
	bh=dliiXrxPdZaqEWSPrjnqzj5G7PTnfa8DoW08sOCl2Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=V06O6F71Ho4j+fAeje2v1td9W/kC0cnl6D1t24zkzLahg1jc13aQ6ZjsX9qA2ywEg
	 YUolk1J+6hsuwtPAbMD96gKWTl0UIBSB3kgDAymKQCgchUQptROGCT9RWgXR3U6ZQQ
	 r+8KmZmcB/FE2gLgPpk2AUO6aKmEYYqeSCgxUXhp4wuPKjmW1ILsee+qE0ZJcVJZQv
	 nL256+FUgbqgJH1q+qEkSyyDbEXqcTZbrET47fS7Hzyt/FhrIw6IDtUEknHg/0I56T
	 el7huGwyH0Yi681u7vJXgpPHPS+esllggLihnrdIyG6BYIOYX6nGv7+sdDwfHdDY9c
	 pD8uGNCTmgA7w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h1LFF6VrDz6tyL;
	Thu, 16 Jul 2026 19:51:13 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Thu, 16 Jul 2026 17:51:16 +0000
Subject: [PATCH v23 2/3] rust: leds: add Mode trait
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-rust_leds-v23-2-e91f5b608b56@posteo.de>
References: <20260716-rust_leds-v23-0-e91f5b608b56@posteo.de>
In-Reply-To: <20260716-rust_leds-v23-0-e91f5b608b56@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5626;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=nc2dY/Fz8fnYk1jCgiVliPMUCfhD5G60Nz9Ipye79EA=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqWRoMt7hSc2u20pqC6Tq5oIyY8e/+VzFF3/hq8
 hL63+i34hGJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalkaDBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9I1Hw/+MXBJZkB7cLQXdfeDsLRv35X41d2/7rr
 E0td6bll1nO8Td0lXSilr6rBamgLNTBlWUz5GIbAREUILKVBDldN7x+OPUM15M2wKJ54pKJzpcg
 dh1aQ/baPP3xwjANatAF5CnOl5h5psPQPef6GrvJw6LXWar3o4qZzJe8hxQ+mTc9fXUmBD3uRW3
 Be/8AddEASrcQ1TCk/eLkxiuKfIW/3zKcddUWZkJrwP1sos9nKI7eYt0O63N/EEQY2jlfue3A56
 NiyZca0Agk/59I1HeqI/IXH/gf1Ck0ypxSVLJGNPf86Se6ymeQIoduEM0OhYFhAf7IBbbiW9GD+
 yGNFdo7HSE+V/uQMcrL59gah0uENaUUgMCazJTSJD57n9UoIMq9kda89AyjfCsbjR52qgUpv2n5
 loqCb/W7LMt3K22hwle5lnDSrtRlJYxVJYC7wuStHxOeMlU9e2BcXQzsWqjVz6z8+YsGB6A5f+3
 CusssoU0qwTrn+Vqw1aLEsPy6uncPdNXoC2qo5q8KKvCaAqIMk4JMg0/UHlNOybSnBQmOtTs06K
 KecBmQ+/YqWCEf+bJttek1Ck/6KwfVqg191L0P32oeTLqCGuuT1SaO04AOBsSKhMT7TZDg3Wn3w
 YkbwXehOfsg+bOtipcroplw52GOdV6uC9DxOQZcPRtixFzKdEQUM=
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
 rust/kernel/led.rs        | 27 +++++++++++++++++++++++----
 rust/kernel/led/normal.rs | 22 +++++++++++++++-------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index 596975e103b8..5d7e6d08ad2a 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -32,7 +32,10 @@
 
 mod normal;
 
-pub use normal::Device;
+pub use normal::{
+    Device,
+    Normal, //
+};
 
 /// The name of the led is determined by the driver.
 pub enum Named {}
@@ -161,6 +164,7 @@ pub fn name(self, name: &'init CStr) -> Self {
 /// #[vtable]
 /// impl led::LedOps for MyLedOps {
 ///     type Bus = platform::Device<device::Bound>;
+///     type Mode = led::Normal;
 ///     const BLOCKING: bool = false;
 ///     const MAX_BRIGHTNESS: u32 = 255;
 ///
@@ -182,6 +186,11 @@ pub trait LedOps: Send + Sync + Sized {
     #[allow(private_bounds)]
     type Bus: AsBusDevice<Bound>;
 
+    /// The led mode to use.
+    ///
+    /// See [`Mode`].
+    type Mode: Mode;
+
     /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`] must perform the
     /// operation immediately. If set false, they must not sleep.
     const BLOCKING: bool;
@@ -194,7 +203,7 @@ pub trait LedOps: Send + Sync + Sized {
     fn brightness_set<'bound>(
         &self,
         dev: &'bound Self::Bus,
-        classdev: &Device<'bound, Self>,
+        classdev: &<Self::Mode as Mode>::Device<'bound, Self>,
         brightness: u32,
     ) -> Result<()>;
 
@@ -202,7 +211,7 @@ fn brightness_set<'bound>(
     fn brightness_get<'bound>(
         &self,
         dev: &'bound Self::Bus,
-        classdev: &Device<'bound, Self>,
+        classdev: &<Self::Mode as Mode>::Device<'bound, Self>,
     ) -> Result<u32> {
         let _ = (dev, classdev);
         build_error!(VTABLE_DEFAULT_ERROR)
@@ -219,7 +228,7 @@ fn brightness_get<'bound>(
     fn blink_set<'bound>(
         &self,
         dev: &'bound Self::Bus,
-        classdev: &Device<'bound, Self>,
+        classdev: &<Self::Mode as Mode>::Device<'bound, Self>,
         delay_on: &mut usize,
         delay_off: &mut usize,
     ) -> Result<()> {
@@ -283,6 +292,16 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
     }
 }
 
+/// The led mode.
+///
+/// Each led mode has its own led class device type with different capabilities.
+///
+/// See [`Normal`].
+pub trait Mode: private::Sealed {
+    /// The class device for the led mode.
+    type Device<'bound, T: LedOps<Mode = Self> + 'bound>;
+}
+
 mod private {
     pub trait Sealed {}
 }
diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
index 816db7c57689..25190486a62d 100644
--- a/rust/kernel/led/normal.rs
+++ b/rust/kernel/led/normal.rs
@@ -6,11 +6,19 @@
 
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
 #[pin_data(PinnedDrop)]
-pub struct Device<'bound, T: LedOps + 'bound> {
+pub struct Device<'bound, T: LedOps<Mode = Normal> + 'bound> {
     #[pin]
     ops: T,
     #[pin]
@@ -20,7 +28,7 @@ pub struct Device<'bound, T: LedOps + 'bound> {
 
 impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
     /// Registers a new [`Device`].
-    pub fn build<'bound: 'init, T: LedOps + 'bound>(
+    pub fn build<'bound: 'init, T: LedOps<Mode = Normal> + 'bound>(
         self,
         parent: &'bound T::Bus,
         ops: impl PinInit<T, Error> + 'init,
@@ -87,7 +95,7 @@ pub fn build<'bound: 'init, T: LedOps + 'bound>(
     }
 }
 
-impl<'bound, T: LedOps + 'bound> Device<'bound, T> {
+impl<'bound, T: LedOps<Mode = Normal> + 'bound> Device<'bound, T> {
     /// # Safety
     /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
     /// `led::Device`.
@@ -107,17 +115,17 @@ fn parent(&self) -> &'bound device::Device<Bound> {
 }
 
 // SAFETY: A `led::Device` can be unregistered from any thread.
-unsafe impl<'bound, T: LedOps + 'bound + Send> Send for Device<'bound, T> {}
+unsafe impl<'bound, T: LedOps<Mode = Normal> + 'bound + Send> Send for Device<'bound, T> {}
 
 // SAFETY: `led::Device` can be shared among threads because all methods of `led::Device`
 // are thread safe.
-unsafe impl<'bound, T: LedOps + 'bound + Sync> Sync for Device<'bound, T> {}
+unsafe impl<'bound, T: LedOps<Mode = Normal> + 'bound + Sync> Sync for Device<'bound, T> {}
 
 struct Adapter<T: LedOps> {
     _p: PhantomData<T>,
 }
 
-impl<T: LedOps> Adapter<T> {
+impl<T: LedOps<Mode = Normal>> Adapter<T> {
     /// # Safety
     /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
     /// `led::Device`.
@@ -210,7 +218,7 @@ impl<T: LedOps> Adapter<T> {
 }
 
 #[pinned_drop]
-impl<'bound, T: LedOps + 'bound> PinnedDrop for Device<'bound, T> {
+impl<'bound, T: LedOps<Mode = Normal> + 'bound> PinnedDrop for Device<'bound, T> {
     fn drop(self: Pin<&mut Self>) {
         let raw = self.classdev.get();
         // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a

-- 
2.54.0

