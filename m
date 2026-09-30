Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4D4CE663
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773540; cv=none; b=INKbH1rZra8sSY86rn5r9iPwFUx2rTKZwaaGPeC9+HosdLlCO35Jr09xWOgDAczrdn3Egn5wC0r+myLxcDqRgR+tF0JbjAmG0oJJXvHG+Zj1ytSQy9GjZD6QoYZOqLHNtK7Dv0cVaLN3/WtnvZQtC5n5KmEXPja35TEp4VL0e6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773540; c=relaxed/simple;
	bh=5/dSgJIN06fJXwEpkDKWKACZadsjzrdEv51F34/4pVw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PUQBrcB8C4r7QHkNeprK2WejCwgqpFqAWJzPVoIS/KYADnQYfSwQCvOP8HetNU570wG4MAPm2mixSSNy2OrNyLoYRyJXtAjRk4YJtH/4F2TZSfkl8EUMvXjPXjFD6Fc7nsqin2IL41/FKkF8qvEZmfNB8NDTfRU8bXqOqEPp7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=YLevYyMr; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="YLevYyMr"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B8B54240109
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 15:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1790773525;
	bh=sP+ek8du+ngUTIKuAUr/EPUyHaRfz1WiHojok3iQuJ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=YLevYyMraoQaNC1/DyHYeZzy6X2+DWZAUHQ5KSjEi5fmrcKRVTE7JOFyKDT62Hqwx
	 F8ZOwkTPxUyLv7BaxI9bKpq8X5y0zwY034NgY0JKWBIDoH6GhfmuzKeokL2ZhWcLyM
	 xmiLaadBVjhOjh7QUJfVrTosHG3ztBfOqJMwZr/eUX1497n9D7rcFA2SEK9k/iXTQQ
	 ijO2RrM3KIC5+aCkWhO+HmF7daNdF4CDhFm4X8PvKYBszZqye7AFYVDyR/wbc1abr6
	 /TA09k8jHebhfn72HNGHSWqEZaVqaRVhOGRbzsqC1TZBvRvagX24VcpkRcYA1OTNek
	 rFwJ+8Y2NUSxg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hvwJL02k1z9rxF;
	Wed, 30 Sep 2026 15:05:21 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v26 0/4] rust: leds: Add led classdev abstractions
Date: Wed, 30 Sep 2026 13:05:24 +0000
Message-Id: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XU22rcMBAG4FdZfF2HmZFG0uSq71FK0bExNHFib
 5aWkHevvCGsVNEbg42/GWn8W2/Tnrcl79P96W3a8mXZl/Wp3pD5cprig3/6mecl1QcTATEi6nl
 73c8/fuW0z15Yio1UbJGpvv+85bL8vhb79r3ePyz7ed3+XGtf3PH0swo3VS5uhjmJ11gUMyv39
 Xndz3m9S3k6qlykldJKqdKZiJw8Chj1r0T4pAYQTEsRqs3gkY12ThcZLN5svXQWq2XHCaMLmSA
 OllprO0vVlhQYnUYbLA9W3ayibruoqiX0LBI5UMLB6pvV1PfV1eqiA9rMidEMllvb9+VqxWaxg
 WwOYVyzuVkG7Kw5bKk7KSmnmMY528Yq6KytNoIRF7UyLtNgXWv7vtdUgUWg4BktDFZutk66s0e
 uyFdbv3H2ecgVNbky/azoyFXRonyoSwq6DBb/b/H6jaCgsJU0zpmaXFnsMklHroA5gGbxYIc5k
 2pt9y/QkassWDgYcIGHbFCTK+lnRUeuXJKsI+gUzNi3yZVgb49coUdQFpN1sZvz+8eBsuWX13o
 onT9OlSn4Pc9xfXxczveni72r9SLXl9//AhxJD/PJBAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6169;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=5/dSgJIN06fJXwEpkDKWKACZadsjzrdEv51F34/4pVw=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqvQkRCghV0cTKCHqqhg8+KrOX7rRsdO705Dukg
 YX5HERKNKuJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCar0JERsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Jvzw//XT0E06gGzK65Xq75Qg5zSoqH1N7XEW5
 00SFHnA+FPGL27X6wDdFCeEE0NsvS0WJSdU4u/4ZjquPsyDAn7Mf+7VCE/ngSyINZsMfbEgqNEg
 JYnoxDNffkBNu+wiwGpofy2zBGl37MfNyvsBnzcDmXS5j1dnB1Ol3uc2jA4Xfv70a3CN+8/B+xJ
 iMDSG5lHo0Lrzvt2dJUJmT2MBIgxHkmvyr4avTlcwe8pc8b2yqMl568EKws/Z46pWXvHLxkltrZ
 bYOlwEqd0+w9YvEVavvy8u3au6LR91Z2LcjvpFlEPVgCtkdxj7d43VMaGRlcUy8cBjJcpkzymOQ
 ch4Ng2wXOVRMbSmiLiEERfrYhAamb7clwAh8TuwlhtSIM68lPds8wpjOxe4yIyjNSIVW0/WThBw
 ZTR/iHup0XHFuSZ5J/yhKChvhrRLI0uIABfz2fXCVPmJVPpBkVzX6FicoRTUzFtHXj37qk5ccG1
 GvI7igdecxIyJ3qJ/atEU3QdXqg8fnpL7zeCvWg6sZ0R6GYIc61HGfhm5ANxqWMqHS242hd3cpq
 h+1zGZ+IIQaEivUzynYWiH61cGYwnf2R+/KG4AFnaevQx07mACE1VMoZVyzurrdTxqkVJYd8nOn
 vqu53Zf8AUfm7hYTIRh4Yjdb/+L6+sCfbzX+M10lTEUciT9sNFcM=
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
 rust/kernel/led/multicolor.rs   | 445 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/led/normal.rs       | 230 +++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 1003 insertions(+)
---
base-commit: 5a956dde5526a634dca7ccad27c051ebcc306089
change-id: 20251114-rust_leds-a959f7c2f7f9

