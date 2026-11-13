Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578568;
	b=rpwhWST4PfQr5tvkBNgYYJTC1spiCBbHHqv6pN2IVZUb6q+LMIG53mExe5ygdKzlW5co
	 7ePZjAB3CgbcBwM4lwmXndmrkrKrDgk6SdhfeX/zG2UKvCyp0hXyPSH7g7Q9/SFwfn3id
	 eW/+dConzQvK9WIyGreDuWesm0wOfBphNpNGl1ukBlcizJL2+/pmy2O9tk19YhNvA3I+L
	 Q7NPhq/IxDW7mhrkOmiiH1iu3Tzto5fhRrRHcC45RpqieX8j9poR4SyhtfOuUbxb/Et0G
	 rNooL1S5cSRIwNz+WM64clB2eSa04iT7QO7Y7vCOXKrLkWHr4KrEkVqHmM092UICipQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ygBMBypAaCW7BHCotAnPUV6E7uoDohTvpBir1Dr82Mk=;
	b=Kr7TX43LH5DjMVF8CISPQrIXbzOcfLqpCpdDi93qsPsG2bqvD9UIFTruofZ+2p+SikmT
	 DdUvhvJgS+KqLmxkOa6UN5YbiTf3H8y1/5RFeem6gL9mborfHBxONPM9WOU/hDfHIVUb9
	 rSOLF9kmONANr1GmzsYbSC2EJnHX5/gJmAe84jAXugBbmgjqcIzhl97aH/PvJ4r+0ZdZP
	 nrPsuGgG2yD8x4jqqEUcuC2BWT236GAzlao9yGKmZlNS2bMLzoUMnAGCgKSuHXohYn2Ac
	 OhtngQl9ugqCeXPaENw9qTITveI48QU2nnQFy/JJJ+8FxoBhYlMFBYrB30O8I0bkSCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUY+Tgl6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1973606A327;
	Fri, 13 Nov 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUY+Tgl6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB421F000C6;
	Fri, 13 Nov 2026 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578567;
	bh=ygBMBypAaCW7BHCotAnPUV6E7uoDohTvpBir1Dr82Mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUY+Tgl6NQEaE+gtZpT3XzULzSAeFOqEr574IQ5kEhzEbGLQ//iNluohlfaIUXIYp
	 763zY2Me4KJfoz98joiuAnfE1h9oC/aysre0dFJl9SeijtX/uJiSRAqbTmPp62jpmh
	 wweZmOgw7mNvGKDE565wI7TkSBqmRU8h27HhOC3U8sdh2C4zdWCL/knOP7aYQpVTRk
	 Wigx9zFGHdqdgi5lOVR08uKR/mpt+QHsxR73K5pFTHtaEBGcBg3sjDdcMB7b1HtyFC
	 mHcfXKYvmacmamFRpvoAjUeHpSTODUDxixdSbNi8R32LYutuO2ft6HrOtk2DpoP/mQ
	 +9uuxPYoc+N4w==
Message-ID: <sashiko-outbox-212950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v28 3/4] rust: leds: Add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261113-rust_leds-v28-3-b8cf2f74fa57@posteo.de>
References: <20261113-rust_leds-v28-0-b8cf2f74fa57@posteo.de>
 <20261113-rust_leds-v28-3-b8cf2f74fa57@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:02:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] rust: leds: unsound shared reference to Opaque in
  MultiColorDevice::subleds()
- [Low] rust: leds: broken intra-doc links in build_multicolor() and
  subleds()
- [Low] rust: leds: missing #[inline] on MultiColorDevice::deref() and
  clone()
--

commit c1c84e805b37bfbeeb46b779f3b5faebdc6abfeb
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: Add multicolor classdev abstractions

This commit adds Rust abstractions for multicolor LED class devices,
including MultiColor, MultiColorSubLed, MultiColorDevice, and
DeviceBuilder::build_multicolor().

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..58dd1a12bc3c0
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs
[ ... ]
> +impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
> +    /// Registers a new [`MulticolorDevice`].
> +    pub fn build_multicolor<'bound: 'init, T: LedOps<Mode =3D MultiColor=
> + 'bound>(
[ ... ]
> +    /// Returns the subleds passed to [`Device::new_multicolor`].
> +    #[inline]
> +    pub fn subleds(&self) -> &[MultiColorSubLed] {

[Severity: Low]
Will these two intra-doc links break rustdoc builds when
CONFIG_LEDS_CLASS_MULTICOLOR is enabled?

The struct is named MultiColorDevice (with a capital C) rather than
MulticolorDevice, and Device::new_multicolor does not exist; subleds are
passed to DeviceBuilder::build_multicolor.

> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `led_classdev_mc`.
> +        let raw =3D unsafe { &*self.classdev.get() };
> +        // SAFETY: `raw.subled_info` is a valid pointer to `mc_subled[nu=
m_colors]`.
> +        // CAST: The safeguards in the const block ensure that `MultiCol=
orSubLed` has an identical
> +        // layout to `mc_subled`.
> +        unsafe {
> +            core::slice::from_raw_parts(
> +                raw.subled_info.cast::<MultiColorSubLed>(),
> +                // CAST: It is guaranteed that `num_colors` fits into an=
 `usize`.
> +                raw.num_colors as usize,
> +            )
> +        }
> +    }
> +}

[Severity: Medium]
Is it sound to create a shared reference &bindings::led_classdev_mc from
self.classdev.get() here?

MultiColorDevice wraps bindings::led_classdev_mc in Opaque because the
embedded struct led_classdev contains fields (such as work_flags,
blink_timer, set_brightness_work, and led_access) that the C LED core
mutates without UnsafeCell wrappers. Materializing &*self.classdev.get()
asserts that no bytes within bindings::led_classdev_mc are concurrently
mutated while the reference is live, which can race with C updates when a
driver calls subleds() on a shared &MultiColorDevice (for example from
brightness_set_callback() running in workqueue or timer context).

PinnedDrop::drop() also does let led_cdev =3D unsafe { &*raw }. Both sites
can read (*raw).subled_info and (*raw).num_colors directly through the raw
pointer instead of creating a shared struct reference.

> +
> +impl<'bound, T: LedOps + 'bound> Deref for MultiColorDevice<'bound, T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.ops
> +    }
> +}

[Severity: Low]
This isn't a bug, but small functions in kernel crate abstractions should
be marked #[inline]; both MultiColorDevice::deref() and
MultiColorSubLed::clone() are missing the attribute.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rust_leds-=
v28-0-b8cf2f74fa57@posteo.de?part=3D3
