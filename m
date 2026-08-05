Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BC3DCD80;
	Wed,  5 Aug 2026 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785958458; cv=none; b=NzqASeBpIajJqb+GkY9JZGdVPz0O9iGbNb2EUL9J1EI0W2xhI3T+DQSVQxH78J2ek626YJsxE3nnIVvqLRHtbIcE54hlLXoo6ZgRnbOLYPMK620VZU4r2u7Rc9vrKDV5s5m7ZpXNNnTJAaadBZF/fpt/8yjuOGMKnq9ydrSWAy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785958458; c=relaxed/simple;
	bh=zGS+pHmcvZFLDW8eeNijg5dlAWoeDvQik7KumTC5XcA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DI/M1P6vMdPRz6Hq/wIJm9+EHb2rGbpYEwUJ8xFTnJjI0+az26/zb46UuaChmHn5SCRTIPziNNPuJa9FxDFQOfaNo3AYDdGjnlmIJbejqYewv6vOD3lW6lGQO490Lfh5vwuaDjvqcsfPAKWg5j0ott5pEEQdHODlEbznNcAEsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFTLw4br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFTLw4br"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70304C19425;
	Wed,  5 Aug 2026 19:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785958458;
	bh=zGS+pHmcvZFLDW8eeNijg5dlAWoeDvQik7KumTC5XcA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gFTLw4br5EIYU09AyjhvUAj9G9WcTvZpOHZF+wIUxNZKe1cK44sTsfhd46P04egMZ
	 qQIjIfTv2csQi4gfDt4e+DJXliNicGzcFjXVWWIyEZtZAfVP4QWBOm0g0k96YRovnj
	 8GqOztLBMCDocZG3w2zCoYYJ5j4StZpSqBh6cSIruwxpHbw8MFYAxTQAIGuCqa757o
	 Ly1oEW401hEeKUL8ywlUtT2qD4H1yBpzOczVAPldeJm+BRiCo8wQUMHF40Fp+Fp138
	 p7BPGzA4Lxd+mu2rsZUky+kXeQ5KAJ+6rnz6TBGBin7x1oyRD/9TLYthfMCtaQ0WUI
	 mNTkzZ269E//A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48325C561E6;
	Wed,  5 Aug 2026 19:34:18 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Subject: [PATCH RESEND v23 0/3] rust: leds: add led classdev abstractions
Date: Wed, 05 Aug 2026 21:34:09 +0200
Message-Id: <20260805-rust_leds-v23-0-b2fea4290ee6@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6897;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=zGS+pHmcvZFLDW8eeNijg5dlAWoeDvQik7KumTC5XcA=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqc5A3BzcF00KzieQe/gRq1VmdHNS/oRlZS/X05
 uxIIa8y12OJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCanOQNxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Kw9xAAjl0Ah5Z27NwBqESI2vpiavRDP0QKBN+
 uAvT0UgWS+EaEZtf0J8gq7zp0ielbgmuPeodG9/unnqc+oZ/dSPvHv3xa37Vp/vc7tsKvGzK8hK
 5EAPM7XZNj1upYR/+F1OMG0TTykGi54MY6PCD7XkFOgBC/LcgsMw2WJDlOR5NStVsTPDqpyiLa6
 vdzaKFFDfQ8NZDgKU5spAxAxcKfYyJqewGW9RvJMLvAsSjDqmvxhiPDW7CdtSSzoJU41KS1HkPV
 CJibeRatJgo3DoRuI4xX6HixXsFG5E7vMFJkcsipf3+IlXxqe6f6LMW5lRNNFBNl5QyVQ1/4o7B
 SaX9BDM34v85op84/d7V+CdtUt3P8PUivZWLjLoGbaeDkPumcYPQ1kiHck5LIKzMF2PYH2AghmK
 gWqwjsC4SgYc3iWeJCU5aaB4v+M9c4CVs/pQWQadQEMrsF9SR2tD64GGMpCHnIno8meRj2k0LE1
 e3y74sfLyFDCjOcOCJW9ffRnY7p6UsR12EZqJaRzJdxrNvQ/lqU9aTFhLlbqnLBruF7lyq9xhMj
 qF/ZR12L6jcJwjGdUFtgkMJOLRcFaBtAyXJYiTILKyP1MFZsr4nBDWvwRRFACKv/bOLnIpgvKu1
 luuKT4DfN0gZWzLY552DO5sirXIOj3EZlg7HXQyY7u7S9GRZs3r0=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
Reply-To: markus.probst@posteo.de

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
-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpZGhcbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSIFkQAIJHfAe6S+v8u4v29fke
uLDop7Ga9Ujz38DD9iMIdnRhgDeh3eN7boFgMab3XM2JhFEuseCkDwIGdybF+zPx
EEoXxpXZp8KcTR26ryN4RuFax/q4nwZaXnZt133COFMPSiHswyn0ZjjlZQb5pK4L
ikKXcCCTWouQkdVD/WB0bTW1Bo065QpCvMP5NTWWQ109EnFTGOofbWv9FV+YzOy0
/baQI/20IRW8CU4s3FG8/LKc5F7yHCYkX89hmUtK9+xiuoNgZgCyt1kuXASRB1ol
jVP1TGauphC0WC/DqL0U4OQcJfMF4vSFblAaLiEnp+YkTj/A/e3T+Y8sLGWI876T
9juYGeGbX8Lupsa3OzFe2csfYJwrMZzL7iOkugJQlVLWxsrTFAZsdStwZDx6mV7k
g1oeux9d9P+lM3gG6HT2jobC7Y+7hD3Z9qFnxQ4vP2tSpcQb0s9emO26JE7hvh9x
oK9C3XUa7Yan3umqeqU9Iz3fJ0w2ZFDNTK5P8LtBJnlagqlRWDCDVu+nx9rsaxXf
S3wh5LktdUB8Xi+qigybTwqjV1SMocfBciVmYJrP4xjhkz8z32WCZdLHY8rpFZ1h
kcVy33DBzv8wPK+fCntQVm9rDC5qmrVpfNOYrg1ZYDCG3Yd/ilL/7VxnR0boQ/5W
qvNRlYVg/i4TsPhwgFacMPzv
=wKUV
-----END PGP SIGNATURE-----
-- 
Markus Probst <markus.probst@posteo.de>


