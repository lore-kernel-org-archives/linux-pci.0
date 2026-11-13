Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577067;
	b=1T7i7gzShLtT/Qa98DEC5yWCuSVPZb0LUzOvOhZsi+WzLSQ4RTwUUiCN7D0W4Rr5g6D+
	 dDG4CiJ6UpFKy8SaSVB7OOx+xqe0ab5C4eAi8jeoIEaW/kdO6r6zLnLUo53JUFSEq+XIT
	 nMeNkNJqrwro+5V1f44u7/FQaciPdDA+ljHpG9xfahwkQQ2TMfLDtg7Xtto6RizwiZK17
	 apsIfNSjxNnLSOI1/J2NEVuGLS6BkDPk+ClVPUXyuuNdZZZ0hxq2KZPG8T8ZsIFVLfdeN
	 HwT5+8aTCbdtgzDGEA9cAdKeBBdm6ifwGsim0guQGNzm6yUB2fQUsh3RCAn7hJ7H0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577067;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=05nYWBcqIZQUcWX6kpp+0Xi+NqiRbZwY/owy0KTwqMw=;
	b=Dnb9kZXu4+uwXvtVe3DdAaNlY4lMoJ/LWHWw0NEF0M1VJLrF3Y6Z7oMTuP48VtmiBDWO
	 9ec6V51Zyl8KB7Y6aSFmzvYm5s/ABBBhX2h9KYZmem3t9luaqOS6nJDpdREbvT3HKLa2z
	 l+7MSPLeauCZ2VE6vUVnVvdBlSk6rdkLrrnh0YDpWbJ7JlZo7EmLzE4siJu5DzgSeJlQM
	 /ddUMaQob5oxSO3gd/OpHFhx7NO6OXRXwkz3zkkaFUEdwGvmhJsPOmgMK+xBPtlrM+Xnu
	 wx7jGocDQsmQz4U4fkhJwIGdP7QnEKKKX470w2sg4dfraoKTZNi2i30zOfUC00nLuRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=fwLVTeY2;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80E606A33F
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 13:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC80E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=fwLVTeY2
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 36CC424010A
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:37:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794577065;
	bh=05nYWBcqIZQUcWX6kpp+0Xi+NqiRbZwY/owy0KTwqMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=fwLVTeY2LTVb+dNJQFuudkUVehH2HBdg1N/rDPwdMBWBQHkHQeb5iOGKiCpyjSPAs
	 /sbtgQONGYqupbYZfMD63fnuDMGEHBqlc8njo5NrxnU+i1NzVzC1FiHTt5N47sVQVx
	 35AuFPpnBvRr0Q6JC98hbpi5aQ8iSEMj4xfkGGfedQOaQpjWn/pmY78wkUwnH+ojBe
	 vaCCQdVfjMNf3D35AwyMnPNP3HuG+GmACaeIvR3M/3rcB/lXeMDPhukK8Xns5HM0Ly
	 5Jc121Bodom/Q9/5pCFIsYxu5NFxdAih5GGu2uXCrhbVYORzyq1Jw+MNwDHkIhEW4I
	 YS9M0BjbW7ClA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQyxK3wH3z6tyH;
	Fri, 13 Nov 2026 14:37:41 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 13 Nov 2026 13:37:43 +0000
Subject: [PATCH v28 1/4] rust: leds: Add basic led classdev abstractions
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
Message-Id: <20261113-rust_leds-v28-1-b8cf2f74fa57@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18305;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=d12yUfyBwiHYEEOjOqcBZrzJGvk5LVryy5ESpfpu+qk=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9xKiUcNHkRNhkTFlhXtGk+qUJFxz3aY+Gq4NN
 5OZB3S8CGeJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavcSohsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JOWRAAmbTvQwu/gyP0icu16ex8zTU+IGQWqh1
 YJ+SMEB1G9BoOSpQlpBnBnOQVFpexsRHA8uFCMusfb9sNro4Lph7gXCNR7aXaNpnY6YLh88agEQ
 g8zMNNVEoF0A+jzG4ZEZVSxdH7eU36+08cwyR0t9OofijQHg9RqjeGvoYdM+vUGvmIEOchGhlrL
 9S/5SgNF02IEdKTKc5s9B14yhjiBkTGZqkZjoMrJH5nCEn1YnxlZUxtNPMjBr3USsVX/oEv+3Ya
 9PlRIaRpFCWwD9Zul/FxQSm/j+BhXzm0jiqerjrlJc4PJn6kDzBt11TtEi1rdthVr5fPju6+5xn
 LH0MwFMRIJsZx9lHnlPsQPirT5wUAQNmi7X7GF/Z6WDbAFo2b2LJpck+Voplx7/xU1kMn1Yzbcb
 UciRFKwHz7t+qNtU1+56c641pzdoi6UjznbuAeB01gBqf3xUMPhpHnLkSNTo0l18bA87TsrvZ/j
 7beb8Q1om53V5bVYOHC+Z8c/wpfDzuVuK0mk14nKTXHpj3VU7cViAYHPB5yzdGsKmn4yKf+eT48
 adSeCT2KdZPFcsT9zJtdbo2mXLIR9rVHNEDhenhRjARQ/uoux6cAxm8dgTP3WEDrLDWTs+Jfnob
 PRDrX70RKaqieej5YG8dPbDIPQXgyHDjVCyuQBTUMJNQ3pLW0P8Q=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=xsFNBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93qReNLkO
  WguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVAm76Ww+
  /pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt9k5JA
  RhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbmfAja
  oT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwTjRQ
  xBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1J+
  FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN6
  OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
  8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJC
  XCeMe4BO4iaxUQARAQABzRdtYXJrdXMucHJvYnN0QHBvc3Rlby5kZcLBkQQTAQgAOxYhBIJ0GMT0
  rFjncjDEczR2H/jnrUPSBQJog714AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEDR2
  H/jnrUPSgdkQAISaTk2D345ehXEkn5z2yUEjaVjHIE7ziqRaOgn/QanCgeTUinIv6L6QXUFvvIfH
  1OLPwQ1hfvEg9NnNLyFezWSy6jvoVBTIPqicD/r3FkithnQ1IDkdSjrarPMxJkvuh3l7XZHo49GV
  HQ8i5zh5w4YISrcEtE99lJisvni2Jqx7we5tey9voQFDyM8jxlSWv3pmoUTCtBkX/eKHJXosgsuS
  B4TGDCVPOjla/emI5c9MhMG7O4WEEmoSdPbmraPw66YZD6uLyhV4DPHbiDWRzXWnClHSyjB9rky9
  lausFxogvu4l9H+KDsXIadNDWdLdu1/enS/wDd9zh5S78rY2jeXaG4mnf4seEKamZ7KQ6FIHrcyP
  ezdDzssPQcTQcGRMQzCn6wP3tlGk7rsfmyHMlFqdRoNNv+ZER/OkmZFPW655zRfbMi0vtrqK2Awm
  9ggobb1oktfd9PPNXMUY+DNVlgR2G7jLnenSoQausLUm0pHoNE8TWFv851Y6SOYnvn488sP1Tki5
  F3rKwclawQFHUXTCQw+QSh9ay8xgnNZfH+u9NY7w3gPoeKBOAFcBc2BtzcgekeWS8qgEmm2/oNFV
  G0ivPQbRx8FjRKbuF7g3YhgNZZ0ac8FneuUtJ2PkSIFTZhaAiC0utvxk0ndmWFiW4acEkMZGrLaM
  L2zWNjrqwsD2zsFNBGiDvXgBEADCXQy1n7wjRxG12DOVADawjghKcG+5LtEf31WftHKLFbp/HArj
  BhkT6mj+CCI1ClqY+FYU5CK/s0ScMfLxRGLZ0Ktzawb78vOgBVFT3yB1yWBTewsAXdqNqRooaUNo
  8cG/NNJLjhccH/7PO/FWX5qftOVUJ/AIsAhKQJ18Tc8Ik73v427EDxuKb9mTAnYQFA3Ev3hAiVbO
  6Rv39amVOfJ8sqwiSUGidj2Fctg2aB5JbeMln0KCUbTD1LhEFepeKypfofAXQbGwaCjAhmkWy/q3
  IT1mUrPxOngbxdRoOx1tGUC0HCMUW1sFaJgQPMmDcR0JGPOpgsKnitsSnN7ShcCr1buel7vLnUMD
  +TAZ5opdoF6HjAvAnBQaijtK6minkrM0seNXnCg0KkV8xhMNa6zCs1rq4GgjNLJue2EmuyHooHA4
  7JMoLVHcxVeuNTp6K2+XRx0Pk4e2Lj8IVy9yEYyrywEOC5XRW37KJjsiOAsumi1rkvM7QREWgUDe
  Xs0+RpxI3QrrANh71fLMRo7LKRF3Gvw13NVCCC9ea20P4PwhgWKStkwO2NO+YJsAoS1QycMi/vKu
  0EHhknYXamaSV50oZzHKmX56vEeJHTcngrM8R1SwJCYopCx9gkz90bTVYlitJa5hloWTYeMD7FNj
  Y6jfVSzgM/K4gMgUNDW/PPGeMwARAQABwsF2BBgBCAAgFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IF
  AmiDvXgCGwwACgkQNHYf+OetQ9LHDBAAhk+ab8+WrbS/b1/gYW3q1KDiXU719nCtfkUVXKidW5Ec
  Idlr5HGt8ilLoxSWT2Zi368iHCXS0WenGgPwlv8ifvB7TOZiiTDZROZkXjEBmU4nYjJ7GymawpWv
  oQwjMsPuq6ysbzWtOZ7eILx7cI0FjQeJ/Q2baRJub0uAZNwBOxCkAS6lpk5Fntd2u8CWmDQo4SYp
  xeuQ+pwkp0yEP30RhN2BO2DXiBEGSZSYh+ioGbCHQPIV3iVj0h6lcCPOqopZqyeCfigeacBI0nvN
  jHWz/spzF3+4OS+3RJvoHtAQmProxyGib8iVsTxgZO3UUi4TSODeEt0i0kHSPY4sCciOyXfAyYoD
  DFqhRjOEwBBxhr+scU4C1T2AflozvDwq3VSONjrKJUkhd8+WsdXxMdPFgBQuiKKwUy11mz6KQfcR
  wmDehF3UaUoxa+YIhWPbKmycxuX/D8SvnqavzAeAL1OcRbEI/HsoroVlEFbBRNBZLJUlnTPs8ZcU
  4+8rq5YX1GUrJL3jf6SAfSgO7UdkEET3PdcKFYtS+ruV1Cp5V0q4kCfI5jk25iiz8grM2wOzVSsc
  l1mEkhiEPH87HP0whhb544iioSnumd3HJKL7dzhRegsMizatupp8D65A2JziW0WKopa1iw9fti3A
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement the core abstractions needed for led class devices, including:

* `led::LedOps` - the trait for handling leds, including
  `brightness_set`, `brightness_get` and `blink_set`

* `led::DeviceBuilder` - the builder for the led class device

* `led::Device` - a safe wrapper around `led_classdev`

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/led.rs        | 265 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/led/normal.rs | 222 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |   1 +
 3 files changed, 488 insertions(+)

diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
new file mode 100644
index 000000000000..deda8cc548a8
--- /dev/null
+++ b/rust/kernel/led.rs
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the leds driver model.
+//!
+//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
+
+use core::{
+    marker::PhantomData,
+    mem::transmute,
+    ptr::NonNull, //
+};
+
+use crate::{
+    container_of,
+    device::{
+        self,
+        property::FwNode,
+        Bound, //
+    },
+    error::{
+        from_result,
+        to_result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    macros::vtable,
+    prelude::*,
+    str::CStrExt,
+    sync::aref::ARef,
+    types::Opaque, //
+};
+
+mod normal;
+
+pub use normal::Device;
+
+/// The name of the led is determined by the driver.
+pub enum Named {}
+/// The name of the led is determined by its fwnode.
+pub enum Unnamed {}
+
+/// How the name of the led should be determined.
+pub trait DeviceBuilderState: private::Sealed {}
+
+impl DeviceBuilderState for Named {}
+impl private::Sealed for Named {}
+impl DeviceBuilderState for Unnamed {}
+impl private::Sealed for Unnamed {}
+
+/// The builder to register a led class device.
+///
+/// See [`LedOps`].
+pub struct DeviceBuilder<'init, S> {
+    fwnode: Option<ARef<FwNode>>,
+    name: Option<&'init CStr>,
+    devicename: Option<&'init CStr>,
+    devname_mandatory: bool,
+    initial_brightness: u32,
+    color: Color,
+    _p: PhantomData<S>,
+}
+
+impl<S: DeviceBuilderState> DeviceBuilder<'static, S> {
+    /// Creates a new [`DeviceBuilder`].
+    #[inline]
+    #[expect(
+        clippy::new_without_default,
+        reason = "no need and derive is prevented by S"
+    )]
+    pub fn new() -> Self {
+        Self {
+            fwnode: None,
+            name: None,
+            devicename: None,
+            devname_mandatory: false,
+            initial_brightness: 0,
+            color: Color::default(),
+            _p: PhantomData,
+        }
+    }
+}
+
+impl<'init> DeviceBuilder<'init, Unnamed> {
+    /// Sets the firmware node.
+    #[inline]
+    pub fn fwnode(self, fwnode: Option<ARef<FwNode>>) -> Self {
+        Self { fwnode, ..self }
+    }
+
+    /// Sets the device name.
+    #[inline]
+    pub fn devicename(self, devicename: &'init CStr) -> Self {
+        Self {
+            devicename: Some(devicename),
+            ..self
+        }
+    }
+
+    /// Sets if a device name is mandatory.
+    #[inline]
+    pub fn devicename_mandatory(self, mandatory: bool) -> Self {
+        Self {
+            devname_mandatory: mandatory,
+            ..self
+        }
+    }
+}
+
+impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
+    /// Sets the initial brightness value for the led.
+    ///
+    /// The default brightness is 0.
+    /// If [`LedOps::brightness_get`] is implemented, this value will be ignored.
+    #[inline]
+    pub fn initial_brightness(self, brightness: u32) -> Self {
+        Self {
+            initial_brightness: brightness,
+            ..self
+        }
+    }
+
+    /// Sets the color of the led.
+    ///
+    /// This value can be overwritten by the "color" fwnode property.
+    #[inline]
+    pub fn color(self, color: Color) -> Self {
+        Self { color, ..self }
+    }
+}
+
+impl<'init> DeviceBuilder<'init, Named> {
+    /// Sets the name of the led.
+    ///
+    /// Setting this will prevent the fwnode from being used and prevents automatic name
+    /// composition.
+    #[inline]
+    pub fn name(self, name: &'init CStr) -> Self {
+        Self {
+            name: Some(name),
+            ..self
+        }
+    }
+}
+
+/// Trait defining the operations for a LED driver.
+///
+/// # Examples
+/// ```
+/// use kernel::{
+///      led,
+///      macros::vtable,
+///      prelude::*, //
+///  };
+///
+/// struct MyLedOps;
+///
+///
+/// #[vtable]
+/// impl led::LedOps for MyLedOps {
+///     const BLOCKING: bool = false;
+///     const MAX_BRIGHTNESS: u32 = 255;
+///
+///     fn brightness_set<'bound>(
+///         self: &led::Device<'bound, Self>,
+///         _brightness: u32
+///     ) -> Result<()> {
+///         // Set the brightness for the led here
+///         Ok(())
+///     }
+/// }
+/// ```
+/// Led drivers must implement this trait in order to register and handle a [`Device`].
+#[vtable]
+pub trait LedOps: Send + Sync + Sized {
+    /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`] must perform the
+    /// operation immediately. If set false, they must not sleep.
+    const BLOCKING: bool;
+    /// The max brightness level.
+    const MAX_BRIGHTNESS: u32;
+
+    /// Sets the brightness level.
+    ///
+    /// See also [`LedOps::BLOCKING`].
+    fn brightness_set<'bound>(self: &Device<'bound, Self>, brightness: u32) -> Result<()>;
+
+    /// Gets the current brightness level.
+    fn brightness_get<'bound>(self: &Device<'bound, Self>) -> Result<u32> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Activates hardware accelerated blinking.
+    ///
+    /// delays are in milliseconds. If both are zero, a sensible default should be chosen.
+    /// The caller should adjust the timings in that case and if it can't match the values
+    /// specified exactly. Setting the brightness to 0 will disable the hardware accelerated
+    /// blinking.
+    ///
+    /// See also [`LedOps::BLOCKING`].
+    fn blink_set<'bound>(
+        self: &Device<'bound, Self>,
+        delay_on: &mut usize,
+        delay_off: &mut usize,
+    ) -> Result<()> {
+        let _ = (delay_on, delay_off);
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Led colors.
+#[derive(Copy, Clone, Debug, Default, PartialEq, Eq)]
+#[repr(u32)]
+#[non_exhaustive]
+#[expect(
+    missing_docs,
+    reason = "it shouldn't be necessary to document each color"
+)]
+pub enum Color {
+    #[default]
+    White = bindings::LED_COLOR_ID_WHITE,
+    Red = bindings::LED_COLOR_ID_RED,
+    Green = bindings::LED_COLOR_ID_GREEN,
+    Blue = bindings::LED_COLOR_ID_BLUE,
+    Amber = bindings::LED_COLOR_ID_AMBER,
+    Violet = bindings::LED_COLOR_ID_VIOLET,
+    Yellow = bindings::LED_COLOR_ID_YELLOW,
+    Ir = bindings::LED_COLOR_ID_IR,
+    Multi = bindings::LED_COLOR_ID_MULTI,
+    Rgb = bindings::LED_COLOR_ID_RGB,
+    Purple = bindings::LED_COLOR_ID_PURPLE,
+    Orange = bindings::LED_COLOR_ID_ORANGE,
+    Pink = bindings::LED_COLOR_ID_PINK,
+    Cyan = bindings::LED_COLOR_ID_CYAN,
+    Lime = bindings::LED_COLOR_ID_LIME,
+}
+static_assert!(bindings::LED_COLOR_ID_MAX == 15);
+
+impl Color {
+    /// Name of the color
+    #[inline]
+    pub fn as_c_str(self) -> &'static CStr {
+        // SAFETY:
+        // - `self as u8` is a valid led color id.
+        // - `led_get_color_name` always returns a valid C string pointer.
+        unsafe { CStr::from_char_ptr(bindings::led_get_color_name(self as u8)) }
+    }
+}
+
+impl TryFrom<u32> for Color {
+    type Error = Error;
+
+    fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
+        if value < bindings::LED_COLOR_ID_MAX {
+            // SAFETY:
+            // - `Color` is represented as `u32`
+            // - the static_assert above guarantees that no additional color has been added
+            // - `value` is guaranteed to be in the color id range
+            Ok(unsafe { transmute::<u32, Color>(value) })
+        } else {
+            Err(EINVAL)
+        }
+    }
+}
+
+mod private {
+    pub trait Sealed {}
+}
diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
new file mode 100644
index 000000000000..a22c29cfd262
--- /dev/null
+++ b/rust/kernel/led/normal.rs
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Led mode for the `struct led_classdev`.
+//!
+//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
+
+use core::ops::Deref;
+
+use super::*;
+
+/// The led class device representation.
+///
+/// This structure represents the Rust abstraction for a led class device.
+#[pin_data(PinnedDrop)]
+pub struct Device<'bound, T: 'bound = ()> {
+    #[pin]
+    ops: T,
+    #[pin]
+    classdev: Opaque<bindings::led_classdev>,
+    _p: PhantomData<&'bound ()>,
+}
+
+impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
+    /// Registers a new [`Device`].
+    pub fn build<'bound: 'init, T: LedOps + 'bound>(
+        self,
+        parent: &'bound device::Device<Bound>,
+        ops: impl PinInit<T, Error> + 'init,
+    ) -> impl PinInit<Device<'bound, T>, Error> + 'init {
+        const_assert!(T::MAX_BRIGHTNESS <= i32::MAX.unsigned_abs() || !T::HAS_BRIGHTNESS_GET);
+
+        try_pin_init!(Device {
+            ops <- ops,
+            classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_classdev| {
+                // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
+                // `led_classdev` gets fully initialized in-place by
+                // `led_classdev_register_ext` including `mutex` and `list_head`.
+                unsafe {
+                    ptr.write(bindings::led_classdev {
+                        brightness_set: (!T::BLOCKING)
+                            .then_some(Adapter::<T>::brightness_set_callback),
+                        brightness_set_blocking: T::BLOCKING
+                            .then_some(Adapter::<T>::brightness_set_blocking_callback),
+                        brightness_get: T::HAS_BRIGHTNESS_GET
+                            .then_some(Adapter::<T>::brightness_get_callback),
+                        blink_set: T::HAS_BLINK_SET.then_some(Adapter::<T>::blink_set_callback),
+                        max_brightness: T::MAX_BRIGHTNESS,
+                        brightness: self.initial_brightness,
+                        color: self.color as u32,
+                        name: self.name.map_or(core::ptr::null(), CStrExt::as_char_ptr),
+                        ..bindings::led_classdev::default()
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
+                // - `parent.as_raw()` is guaranteed to be a pointer to a valid `device`.
+                // - `ptr` is guaranteed to be a pointer to an initialized `led_classdev`.
+                to_result(unsafe {
+                    bindings::led_classdev_register_ext(
+                        parent.as_raw(),
+                        ptr,
+                        if self.name.is_none() {
+                            &raw mut init_data
+                        } else {
+                            core::ptr::null_mut()
+                        },
+                    )
+                })?;
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
+impl<'bound, T: 'bound> Device<'bound, T> {
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    #[inline]
+    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a Self {
+        // SAFETY: The function's contract guarantees that `led_cdev` points to a `led_classdev`
+        // field embedded within a valid `led::Device`. `container_of!` can therefore
+        // safely calculate the address of the containing struct.
+        unsafe { &*container_of!(Opaque::cast_from(led_cdev), Self, classdev) }
+    }
+}
+
+impl<'bound, T: LedOps + 'bound> Deref for Device<'bound, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.ops
+    }
+}
+
+// SAFETY: A `led::Device` can be unregistered from any thread.
+unsafe impl<'bound, T: 'bound + Send> Send for Device<'bound, T> {}
+
+// SAFETY: `led::Device` can be shared among threads because all methods of `led::Device`
+// are thread safe.
+unsafe impl<'bound, T: 'bound + Sync> Sync for Device<'bound, T> {}
+
+struct Adapter<T: LedOps> {
+    _p: PhantomData<T>,
+}
+
+impl<T: LedOps> Adapter<T> {
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    /// This function is called on setting the brightness of a led.
+    unsafe extern "C" fn brightness_set_callback(
+        led_cdev: *mut bindings::led_classdev,
+        brightness: u32,
+    ) {
+        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+        // `led_classdev` embedded within a `led::Device`.
+        let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
+
+        let _ = classdev.brightness_set(brightness);
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    /// This function is called on setting the brightness of a led immediately.
+    unsafe extern "C" fn brightness_set_blocking_callback(
+        led_cdev: *mut bindings::led_classdev,
+        brightness: u32,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+            // `led_classdev` embedded within a `led::Device`.
+            let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
+
+            classdev.brightness_set(brightness)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    /// This function is called on getting the brightness of a led.
+    unsafe extern "C" fn brightness_get_callback(led_cdev: *mut bindings::led_classdev) -> u32 {
+        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+        // `led_classdev` embedded within a `led::Device`.
+        let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
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
+    /// `led::Device`.
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
+            // `led_classdev` embedded within a `led::Device`.
+            let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
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
+impl<'bound, T: 'bound> PinnedDrop for Device<'bound, T> {
+    fn drop(self: Pin<&mut Self>) {
+        let raw = self.classdev.get();
+        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
+        // valid `led_classdev`.
+        let dev: &device::Device = unsafe { device::Device::from_raw((*raw).dev) };
+
+        let _fwnode = dev
+            .fwnode()
+            // SAFETY: the reference count of `fwnode` has previously been
+            // incremented in `led::DeviceBuilder::build`.
+            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode)) });
+
+        // SAFETY: The existence of `self` guarantees that `self.classdev` has previously been
+        // successfully registered with `led_classdev_register_ext`.
+        unsafe { bindings::led_classdev_unregister(raw) };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1ab41129d557..3b831cb6488d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -98,6 +98,7 @@
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod led;
 pub mod list;
 pub mod maple_tree;
 pub mod mem;

-- 
2.56.1

