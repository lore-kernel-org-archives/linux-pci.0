Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577065;
	b=ubOKQpZl7il2jnTEGoT1xFwqkCIGt5pSswh/4z4MiSzAiWtFhsi+KglyIIDA1ihNITMS
	 fzCmoqwdqFSQP6nMs7JjB/CkEbfhJEKt1kD+dlaO2mdOW9nKU3/16+smaQl08POtqxjso
	 zjPqOEPZLXrBxiPJLFGht57tlcbdcHO9Myo+KfhXI/heldudPbzoDAu7BlE+KJn2M+zKq
	 fF0ZJkLTTlp8d6Au+Dx/Cta6DP39fTyCcWGGhlBa2gDqnE4NP9thxxOcL7FZZJz/S+Z3d
	 BDhGlX191NFWtfd+bpr+VFOEOiamkk2djlfjTLOdblxJ/sgZAKTiumsMNhSQIFjHrOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577065;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=rmNlezMqD6pQuxX1PgwHMgUdHR5PyYixRlH4XSvYqPY=;
	b=n32rthOCjp6IAfwkbqSwQKqQQpthrVwETnqN9xloPQAP4QYDu6X4B3cDzDnNSgHfOImT
	 nJ8Dvo5aSNIHJxbE7oCm5XKF0xBmgkcfrl5HybcxzmXulS5raCwhDGJmrdm6qOHHUabcD
	 r+mqnfwzSKXkz5uqFIWp2+81t0npgZhd5FpjwSI/W91PAdJflUbfekjv8R4ArinXccdtD
	 wGEANoH/x7Q6/5VWA4p4EOsCXIGPxPeyDizVxmXGFSiP9jfuNWLG4wtmXVAapAde4DzIS
	 nwYeHeTMJ5CmiL8uwya+ZfkCuM+9MU5C3dDxHead+DEC+hD+iuWoa8osUYnpTsQgUvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=SP6cC2yA;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CD606A32E
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 13:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 774CD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=SP6cC2yA
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id BBCCD240105
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 14:37:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794577062;
	bh=rmNlezMqD6pQuxX1PgwHMgUdHR5PyYixRlH4XSvYqPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=SP6cC2yAhsBKk0mYNKmGkFuInUMDyHhYsoTmZYzxjtZtTeBmrj1qKyhvWycv9q07Z
	 Gc8kqlXb0Zs8iRXKswyeBhLFz/NqQtltsejJNuQdqwnDSunI9F3HnAcBQDMykU9sjK
	 lk1Hn4IMdy+8k/QicaE1SpPPufCZAh7Do33JFiaAkIb+WxwBNCoHDBJmzYR2Jxew7O
	 7ztehEziimO04UtBf4w0qgsroKqXmMgFZ0ojFbVwJrOKIRnM3UY3Be6Xn8WLVD3jKH
	 weMect7v0799b70EYtHqD3Cv4llxE2Gd1joWqsNL6HWJJ7Oh+RD6zxlYJNFGd7QTcb
	 HBWJ2kUQRjVaw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQyxG69d3z6twP;
	Fri, 13 Nov 2026 14:37:38 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v28 0/4] rust: leds: Add led classdev abstractions
Date: Fri, 13 Nov 2026 13:37:41 +0000
Message-Id: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XU227cIBAG4FdZ+bqOZgYGmFz1Paqq4thYarKpv
 Vm1ivLuxRtFhqDeWAL5G8zwm9dpy+uSt+n+9Dqt+bpsy/mpDsh9OU3xwT/9zPOS6sREQIyIel5
 ftsuPXzltsxeWYiMVW2Sq7z+vuSx/bsW+fa/jh2W7nNe/t9pXt89+VOGmytXNMCfxGotiZuW+P
 p+3Sz7fpTztVa7SSmmlVOlMRE4eBYz6LBE+qAEE01KEajN4ZKOd00UGi4etj85itew4YXQhE8T
 BUmttZ6nakgKj02iD5cGqwyrqtouqWkLPIpEDJRysPqymfl1drS46oM2cGM1gubX9ulyt2Cw2k
 M0hjN9sDsuAnTW7LXUnJeUU09hn21gFnbXVRjDiolbGZRqsa22/7i1VYBEoeEYLg5XD1k53ds8
 V+WrrGWefh1xRkyvT94r2XBUtyof6SUGXweL/Ld7OCAoKW0ljn6nJlcUuk7TnCpgDaBYPdugzq
 dZ2/wLtucqChYMBF3jIBjW5kr5XtOfKJck6gk7BjOs2uRLs7Z4r9AjKYrIujn1uciV9NmjPlVN
 OWaXqGUMe7JErhE/73XNFkcQk513m0Nq394tszb9f6mV4eb/NpuC3PMfz4+NyuT9d7V29BiPVl
 9/+AdJpGg5BBQAA
X-Change-ID: 20251114-rust_leds-a959f7c2f7f9
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6259;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=rMr+dOE26m7zQsJ7lZCIAQymN0uCefIhx6nHyuBVe4Q=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9xKhxozWWjPqj91FvszEiHYOgrnIHc1raoNab
 aNerukitYaJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavcSoRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IiXhAAo1bChXABAL3q56FlBf404eK5jzaCEdz
 u7EbeE+7jihjlTNjg+NWzf52fvuBalIenY1cUXuYWDamyUtjdJqX7Rqoc55Ww6hoZp/z98vceZI
 2A1YJgpGmPZ9qow0wPkWF5fI6XGJQbCfyG3+x8pLulM7+wghYxxQQAM3CPMj6XLWumw5GccAXZm
 EQd7CRERGJyG67CNS48NgSHbM9N2iwtcAmKLu5yInlJL0MGwHVrwce2yBFmETG1+2LstQkd4hwa
 3Z17SvQhGEoXNormxZyqfLUd4OgSjDrSNDRiaBtKdsycooJNVlT/ujZHHpoccI2SBPFJDaiiioC
 dbpLVKiNoRTHX3AzHimlZyzRs+Xql2Pc4M47h+/h49617LH436I9yHE1XjqPK5Pe3ItXLCJ/mzV
 fL007g+EfyJJDpSl3Je/gto5anvwQxYC7oNHopSKYDoQdh5uMcbXxPTYs4ZKmgPbHlOxBP0Mw02
 g3pATNGp4TvMenBiILyGLqdbibbb4BKbzRcStJP24yormsZ/6fIoG5uJAeiobcsxOdMUxHDGRvo
 EqPdFzpH2SswteIoiDOZS58MP29m6WB4l2nHR1jMrA2z0VeivNgXwR5JlbbUT6KJPV3BlH0bxqy
 eyYjD4aY9AlEa28H04gfLvUpmcrNYfD4QmVd3sdIwlKDpkBraDkw=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The abstraction is used by
https://lore.kernel.org/rust-for-linux/20260724-synology_microp_initial-v18-0-fb2f49f10e77@posteo.de/
.

The following changes were made:
* add basic led classdev abstractions to register and unregister leds

* add basic led classdev abstractions to register and unregister
  multicolor leds

Changes since v27:
* rebase onto v7.4-rc2

Changes since v26:
* use Atomic (Boqun)

Changes since v25:
* fix issues reported by Sashiko:
  * fix vertical import
* add drivers/leds/*.rs to MAINTAINERS file (Kari)
* s/add/Add/ in commit message

Changes since v24:
* remove `LedOps::Bus` (Gary)
* support type-erased `Device` and `MultiColorDevice` types (Gary)
* use `Device` and `MultiColorDevice` as arbitrary self types in
  callbacks. Remove separate `classdev` argument (Gary)
* remove unnecessary imports in doc example

Changes since v23:
* add separate patch for MAINTAINERS file update

Changes since v22:
* readded CStrExt import, because it is imported with `as _` in prelude.
  A `# CONFIG_RUST is not set` sneaked into my .config while
  development, so the compile error was unnoticed.

Changes since v21:
* use 'init for lifetime that is only alive during initialization
* remove unnecessary CStrExt import

Changes since v20:
* resolve Sashiko regressions:
  * fix typo
  * fix fwnode refcount decremented too early

Changes since v19:
* rebase on v7.2-rc1:
  * Add `max_intensity` to `MultiColorSubLed`
* use safer `KBox::pin_slice` instead of `KVec`
  (len might not equal capacity)
* explicitly call `FwNode::dec_ref` instead of dropping a reconstructed
  `ARef<FwNode>`.
* remove direct access to `intensity` and `brightness` fields,
  which may get mutated concurrently by the C side
* fix safety comments pointing to functions from previous revisions

Changes since v18:
* add inlines
* fix invalid documentation
* improve led color duplicate checking

Changes since v17:
* use lifetimes instead of Devres

Changes since v16:
* use for loops for duplicate checking

Changes since v15:
* fix issues reported by Sashiko bot:
  * fix returning error not possible on `brightness_get` callback

Changes since v14:
* fix issues reported by Sashiko bot:
  * add missing inlines
  * add missing Sync trait bound
  * fix vertical import layout for public export of private types
  * fix potential memory leak, if a multicolor led device with over
    `u32::MAX` subleds is registered
* remove default_trigger option
* fix missing CAST doc

Changes since v13:
* rebased onto v7.1-rc1

Changes since v12:
* add `led::DeviceBuilder::name()` and `DeviceBuilderState'
* add `led::Color::as_c_str`

Changes since v11:
* use `led::DeviceBuilder` instead of `led::InitData`
* use static_assert instead of const { assert!(...) }
* restructured patches to avoid moving `led::Device` from
  rust/kernel/led.rs to rust/kernel/led/normal.rs in the 2. patch

Changes since v10:
* allow in-place initialization of `LedOps`
* run rustfmt for code inside `try_pin_init!`

Changes since v9:
* add missing periods in documentation
* duplicate `led::Device` and `led::Adapter` instead of using a complex
  trait
* fix imports not using prelude
* adapt to CStr change
* documented `led::Color::Multi` and `led::Color::Rgb`

Changes since v8:
* accept `Option<ARef<Fwnode>>` in `led::InitData::fwnode()`
* make functions in `MultiColorSubLed` const
* drop the "rust: Add trait to convert a device reference to a bus
  device reference" patch, as it has been picked into driver-core

Changes since v7:
* adjusted import style
* added classdev parameter to callback functions in `LedOps`
* implement `led::Color`
* extend `led::InitData` with
  - initial_brightness
  - default_trigger
  - default_color
* split generic and normal led classdev abstractions up (see patch 3/4)
* add multicolor led class device abstractions (see patch 4/4)
* added MAINTAINERS entry

Changes since v6:
* fixed typos
* improved documentation

Changes since v5:
* rename `IntoBusDevice` trait into `AsBusDevice`
* fix documentation about `LedOps::BLOCKING`
* removed dependency on i2c bindings
* added `AsBusDevice` implementation for `platform::Device`
* removed `device::Device` fallback implementation
* document that `AsBusDevice` must not be used by drivers and is
  intended for bus and class device abstractions only.

Changes since v4:
* add abstraction to convert a device reference to a bus device
  reference
* require the bus device as parent device and provide it in class device
  callbacks
* remove Pin<Vec<_>> abstraction (as not relevant for the led
  abstractions)
* fixed formatting in `led::Device::new`
* fixed `LedOps::BLOCKING` did the inverse effect

Changes since v3:
* fixed kunit tests failing because of example in documentation

Changes since v2:
* return `Devres` on `led::Device` creation
* replace KBox<T> with T in struct definition
* increment and decrement reference-count of fwnode
* make a device parent mandatory for led classdev creation
* rename `led::Handler` to `led::LedOps`
* add optional `brightness_get` function to `led::LedOps`
* use `#[vtable]` instead of `const BLINK: bool`
* use `Opaque::cast_from` instead of casting a pointer
* improve documentation
* improve support for older rust versions
* use `&Device<Bound>` for parent

Changes since v1:
* fixed typos noticed by Onur Özkan

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Markus Probst (4):
      rust: leds: Add basic led classdev abstractions
      rust: leds: Add Mode trait
      rust: leds: Add multicolor classdev abstractions
      MAINTAINERS: rust: leds: Add rust abstraction entry

 MAINTAINERS                     |   9 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/led.rs              | 317 ++++++++++++++++++++++++++++
 rust/kernel/led/multicolor.rs   | 442 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/led/normal.rs       | 230 +++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 1000 insertions(+)
---
base-commit: fd9230005e85472b81c1c7c16afe93dd878996b1
change-id: 20251114-rust_leds-a959f7c2f7f9

