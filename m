Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27483B585D
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502169; cv=none; b=Z15Z3mMASYQuYbBfIV9b36uF4U3oY3uiAVx994MJxyb0DSzu3PIHZ5bfNcJIe01qYkPrGen70SmbQfcgsX7qUSYR/hnPrtmNmY4B0CXBcN1eZWo5CfecAthNe+nVOs7LVBNALEg7xfVollV016LnmSyJOcVnwGBXLsFGmsWWfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502169; c=relaxed/simple;
	bh=wyEuXHXVO7k5NWhoWK5n0CUwIJ0gQVKLj9pZoWhDVBE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jfA5xwTYSpn35yrP70vxpvJ9fL0g6zSG46zAAXx+5ugFJ8riI+EF4Oc/Y0mbegaS0lSW25kQ8vztcaD5w/bLw5NtSeD27uJnUsfkUmePWSfbpQEn/1Jo4t9tGhxYAB5KYZfTziz6RENLlZCsP064WEF5RRysgOC67kbJHHMYlJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=VZWKwrEj; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="VZWKwrEj"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4DAC6240101
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 17:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780502158; bh=lLuYQL3kTkjfxf7uUmh26OIqMcQ5nNDLTP6It9pNWRA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=VZWKwrEj1zO7R6V+v5wAYTqwYF6mnNnll6CfnJc5KHpUnLCyu+ZI4Z6i1I67ySHyl
	 VTz4cgq4b/T9S/ET6ESxdwN3LjGGtzq/wXy7Jf/D5JoL+IKcIaZyo5x8kSCJmH8a9n
	 /J68ig8Ljm3l+1S7R0ROYyTuuIhEpho0nnT/UUu9dt3Fic4pq5vsWuSlPsEsUAw88N
	 hZqTielKL00aZWtTLj2TIk5vpeloVoO1zByHmIOndZOhGoSXOfe7e6i6qxzbCvkIoX
	 oqRXofVlszDxzBBpj1g9GQkGOySnxNjJ73g+i/hNUiU1xneE70u3NbXBnfxkER+Zbd
	 nUHtbbU9pjCtQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gVsk25HGsz9rxK;
	Wed,  3 Jun 2026 17:55:54 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v19 0/3] rust: leds: add led classdev abstractions
Date: Wed, 03 Jun 2026 15:55:57 +0000
Message-Id: <20260603-rust_leds-v19-0-2a71085deae3@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH1OIGoC/23S207cMBAG4FdZ5bqJPLbHh73iPaoK+TCGCHYDc
 YioEO/e2aVok7o3iWzlm0P0f3SV5pFqdzx8dDOtYx2nMx/A/zh06TGcH6gfM190UkgEAN3Pb3W
 5f6Zc++DRF5tkscV3/P3LTGV8vxb7+YvPj2Ndpvn3tfbqLrffVXBTZXW96LMPGopCROXuXqa60
 DRk6i5VVr+Vfis9S2cSYA7ghVH/ShDf1AgQZktBsCURAI12ThffWLhZfuwssEWHGZKLJEVqrNx
 au7OSbckRwWmw0WJj1c0quVsXFFsJAb1PGGWGxuqb1XLfV7PVRUewhBnBNBa3dt8X2XpL3kZpK
 cZ2ZnOzKGBnzcUW3qRkyim3/9lurBI7a9kmYbxLWhlHsrFua/d9r6kSFoSMAcGKrf38CutMr28
 c+OUrsd2Jag3XvB8Pf1dBQKmFGJTngzc99Dk8zXdPNJ/peZjmh0vsWyeR317CAFLz9P9nMVTq0
 3Q6jcvxsNqBx0+GZ/v8A9OsSNuUAwAA
X-Change-ID: 20251114-rust_leds-a959f7c2f7f9
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7037;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=wyEuXHXVO7k5NWhoWK5n0CUwIJ0gQVKLj9pZoWhDVBE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqIE6JE2/eua8sdMmeFBeg+x7As0Wb5I0uLJ1UD
 Qe1fCIhmiCJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaiBOiRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JNaRAAuWel91rJsJZ92TRLB9t+/wwoFxhCCSR
 FK9pCptt4uaHZlxzB+oRzdg4TSv2PrbbbPqdGhytCdxlBU5cRCLcpLkCDhehru7AYPL1A+NwM5X
 lk7ZoGag4DFkPlUrkii47y92SpL8xiGkJvOH+8NMzrA8fehRb7oqef5P3k6qRX0e86KWfdGLbhH
 TgReWnsHX+4D/nDy+EBFxowambBQyf60P61qGmHjKj2+5cDHzw7Oh7cFBB2dBxeZm3CsKagTgLS
 WpRlxdfXQvqdV7C9Y87oK5muDjR7mzFDkEEY+VEBeDNV4dUHeLf2AUItl9m1ntmIvSxc5IanaCG
 sdtqmnIWoCwa4myEn8kHmPdNgM89dvV+O+Ae1wGwfGT6/uPWCK+YJzp7jVN6JIuTIFapc75yxiw
 enWh0uhfC6bHOJ3+xZW1S4tGhZJxmLdM6DvQXaflvR+OJUqJIuL3GObjfLmUb6PD5wyfZJNQUJ5
 HORbfeaiksscF+sr1NEysHc8qEXX0u/QsfiSfodZJSsapN3HSOJYM2WcfvB+uf+MTwmFGxh3Jt9
 7oZigiDGdkOneHUnlDE1xwHK56jbu8fh8ofoe8UUPJgkVO4OmE3dRkLGtde4aQQeJjMv+76+Sih
 +TIr4cK+2sAdKmTra2l7epMh8yAz/apmk42W68NB30i76waRbIQ4=
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

This series depends on [2].

[1] https://lore.kernel.org/rust-for-linux/DDDS2V0V2NVJ.16ZKXCKUA1HUV@kernel.org/
[2] https://lore.kernel.org/rust-for-linux/20260525202921.124698-1-dakr@kernel.org/

The following changes were made:
* add basic led classdev abstractions to register and unregister leds

* add basic led classdev abstractions to register and unregister
  multicolor leds

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
 rust/kernel/led.rs              | 339 +++++++++++++++++++++++++++++++++
 rust/kernel/led/multicolor.rs   | 405 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/led/normal.rs       | 238 +++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 6 files changed, 992 insertions(+)
---
base-commit: 3bc831df9ee16fceee851872315161377ca1417d
change-id: 20251114-rust_leds-a959f7c2f7f9
prerequisite-message-id: 20260505152400.3905096-1-dakr@kernel.org
prerequisite-patch-id: d2aebf69b153c039bbed1d0ed26906708fd22534
prerequisite-patch-id: 84b28da2f5de20fc1785095c647b2ffc35d969a5
prerequisite-patch-id: 67318671a5eed5fb4ad23a450f1cf0e442bf8ca2
prerequisite-message-id: 20260525202921.124698-1-dakr@kernel.org
prerequisite-patch-id: b84db329d4372a175cb8d49e4e88c3eecf7eb228
prerequisite-patch-id: 2c30303f409cc8288cc87e241920219f5ddd8390
prerequisite-patch-id: 4e4f0ad370d763ad00b0f75b91fa216f2cc95953
prerequisite-patch-id: 5bcd6b37f3498feebda275dfef78136eba34004e
prerequisite-patch-id: 872b0982f3e5e7d1698d9df3b325e4cd27b27789
prerequisite-patch-id: 3a3c7749e017d9335f58497404d1350e96caf471
prerequisite-patch-id: 3526c9154f581497a11465b936d83ef61a875454
prerequisite-patch-id: 65d8c757b52475c2acc7d22ddc92cd3f0152b55d
prerequisite-patch-id: 4bd31f1414d5248dc080884caadf5f21684a8427
prerequisite-patch-id: 7beadbb0da3e589ed86d12f512d1c83427dd82b4
prerequisite-patch-id: 12cd0f67ffd27347f90c065db491945908206b7f
prerequisite-patch-id: 4642e31f66331f6c3b579377111ea733dbb3a11c
prerequisite-patch-id: 52d67b40b4396c741e2222d6a5bc7927abcb77aa
prerequisite-patch-id: 74ca82ff26cf9c7a993757c87db8be62006e820f
prerequisite-patch-id: 466fb9fa7febbffd8ef51b311c7d9893c11fc0f0
prerequisite-patch-id: e515cd98b06e26721cbbe6a4fbacd251d0073b63
prerequisite-patch-id: 8dc8e75d9f6499a554ef7e474bbacdbf3660a9f2
prerequisite-patch-id: 5fdb9f71dca2f44dd293760a60db125b770f1f55
prerequisite-patch-id: c766a24c2d5064f5ec09daada0b8e8fba862d3aa
prerequisite-patch-id: b768f6456d35fa7a80c015e34bbdba6082dbd593
prerequisite-patch-id: 6a8b17234f12f7084e6e2ce843a7031b0a891ce4
prerequisite-patch-id: 98b2deb9e60c1f28f90c5ee34fd608aaa9fd9420
prerequisite-patch-id: 774b29be66e641ee50cedb4704cf49d8b9fabf50
prerequisite-patch-id: cf95dc936cfc4b3a7a363435a51a48d9009645b3

