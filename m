Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2594442134
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224282; cv=none; b=px9VnI26Jh023JyhYzw6BrKIUj8MuSWnebL7o7CQr2XnAm3PKul2aeWE3Iu/ABxhuAlwpyxmECQp8AZ//WzZW2YXwKPySqWo61VvwSXRmFIjJgKZBOgicS3FjshAs352L1dSEIcmvr31tfosM4YJB09UpOgpU/043edHk9heFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224282; c=relaxed/simple;
	bh=8M3TbNCR+i1VoBYEWkITtCC5kGLxCXdEZokKzbMaDLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EHs/FsXvAc9wSB2hwTisVbCDgAy3CGJYFJQnhtqNH8LVeag4v4Q92CpF+GQtp/QStwLT4ZZm4x5CmiGJa/TNUhu/uTwNf424I74coaY4ryDd4cEUk04/oG81O5t1iN+i+CWOlm4XhkxvrL1icnuHBYMxijniY3e+Zz5cPr2RmOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Ly8JuCz3; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Ly8JuCz3"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D098024002B
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 19:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784224272;
	bh=Z+CWnxdhL3U1Ka0XrsoYynFaL0H63/6bcMSLAouRuKg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=Ly8JuCz3AM/nEFTV+WIXTcTXQqNAgWO1q33WfNs7JkG+kj7Opi3QQhxJxn7o4KyPA
	 9dS65o0Xq1zwIjnhO5RzSjKmrI31TlZkHI3XH4Q+mFXYzHDozZ40wGpCHnKkbRtnCB
	 GoInFmuTdfdwJsKpaUFhPYBTCk2GDVwHW8xVFQMSVDAjIpnWYiu0gVzdru5zRCE5K/
	 2Bd2bNvpcfnGtMbCrWYXPv8QgmIMUuFKKM9LGwwcYMDBotPd5PTLhyxd4oyjEVzpka
	 4vlQ8zyk5uIzbU4EgYjiV/cQ1J80i6T79zKRpqb2riY1uGBuBtYMYwZljicH7PKSxs
	 NNqmDs5j79eOQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h1LF8593Fz6trs;
	Thu, 16 Jul 2026 19:51:08 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v23 0/3] rust: leds: add led classdev abstractions
Date: Thu, 16 Jul 2026 17:51:11 +0000
Message-Id: <20260716-rust_leds-v23-0-e91f5b608b56@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XT3U7mIBAG4Fv50uOtYYABxiPvw2w2/K5NVqttb
 XZjvHennzEFyZ40oeEZYHh5G9a8THkdbi9vw5L3aZ3mJx5I9eMyxAf/9DuPU+IfgxQSAUCPy+u
 6/fqT0zp6Qio2ymILDTz/ecll+nstdv+Txw/Tus3Lv2vt3R1/v6pgVWV3oxgTeQ1FIaJyd8/zu
 uX5JuXhqLJTLamWxNKZCJg8kDDquwTxRY0AYWoKgm0WHtBo53ShzsJp+dNYYIsOE0QXshSxs7K
 2trGSbUkBwWmwwWJn1WmVbI4Liq0Ej0QRg0zQWX1aLdt1NVtddACbMSGYzmJt23WRLdlMNkibQ
 +j3bE6LAhprDlv4JCXlFFPfZ1tZJRpr2UZhyEWtjMuys6627brXVAkLQgaPYEVn6bTc6cYeuZK
 eLd9x9rnLlaxyZdpeySNXRZPygbcUdOks/N/C9Y5EAUJLqe+zrHJlocmkPHIlEIPQSF7Yps/vn
 49zyS+v/MC3zxc6BL/mMc6Pj9N2e9ntDdeLiie/fwBQIvizFQQAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5964;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=8M3TbNCR+i1VoBYEWkITtCC5kGLxCXdEZokKzbMaDLU=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqWRoLCC/6KrtEYADXpx2hGgI537h0tPGQtuGhK
 aVuE3YVigCJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalkaCxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KqPhAAt6V06OPguyz1RHnRtMUuOX8Ug3uIvzd
 3DaMzoyjpxB4vl3//NnY5L/FSLM/NOmR+gPxFQemuhYgTIbmEOydxadozwZwxnR+nmWZuBeI6QH
 tt57WkWG0lysU+pUO8CMnr8d5q0GNRAtxfipF6vuPZ5TfGHEYqKchlkfzDY1dz9Oj7EjOwWjGLJ
 p5VRx7DSv8BddmB5XeSVlqJVOSy/gKBFAgce6hJEO/pOoDky4oMniu41la9IJ0O/ydG7k8j/1fi
 AWdw5gtjOLJ/3kBL480DWi3o4QrvFbPZYI4zeYP4QuCU36xHr8qFFREapvpcBHlj307POgVRaR3
 Pe5grf4iTYtgIudrnTbVLvCZZy5s/ZqmpLbQP0YJZ33YwCTBBs+VMMwNyXufX8Q20ke6eTJwMRC
 r0rOPK5boi++1TDaP2nfm0BG2TZGMehVxUexTEPF0xjCI9z7YeY+AzkiHlzxAuoQoWYd3cOqxSd
 9LAK5L6FlyoepMQur5q0TSPc3oRjaTVt+esBXxm4W8Ez2lYBVxklPyKZZtvjXg1av+HjrZBnTuu
 vvi8hZOnockyd1o+PO3ZXa5Ke8BFadIxhb7wKGbG3PVR7ScitxZ3e48HpAwo+qOm1H94A+/PXg5
 iUoz6AVBcRAI6fvcvlLH5e0FloklCGwOLG1dGAwTVie8kPSIJFUk=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

This patch series has previously been contained in
https://lore.kernel.org/rust-for-linux/20251008181027.662616-1-markus.probst@posteo.de/T/#t
which added a rust written led driver for a microcontroller via i2c.

As the reading and writing to the i2c client via the register!
macro has not been implemented yet [1], the patch series will only
contain the additional abstractions required.

This series depends on [1].

[1] https://lore.kernel.org/rust-for-linux/20260525202921.124698-1-dakr@kernel.org/

The following changes were made:
* add basic led classdev abstractions to register and unregister leds

* add basic led classdev abstractions to register and unregister
  multicolor leds

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
Markus Probst (3):
      rust: leds: add basic led classdev abstractions
      rust: leds: add Mode trait
      rust: leds: add multicolor classdev abstractions

 MAINTAINERS                     |   8 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/led.rs              | 339 +++++++++++++++++++++++++++++
 rust/kernel/led/multicolor.rs   | 460 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/led/normal.rs       | 238 +++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 1047 insertions(+)
---
base-commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
change-id: 20251114-rust_leds-a959f7c2f7f9

