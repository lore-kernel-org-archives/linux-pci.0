Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96794078F8;
	Wed, 19 Aug 2026 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166867; cv=none; b=c2X2CkfbZEp6rNn0qlXMSi/Cy5r5ZdB3KZYCG++BDvCNsa+oOqsD8+fT+PfJWTIvzpIhQjUYaG0qG4tWGMXwxChk6rxICa9R8tdpufKr/Dxj6GDUQVCWRdfVpXBzLz0IMW/8KWBawk8V6pGkPkwpUAxTt1x8EEk2PUm2fa5Y07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166867; c=relaxed/simple;
	bh=1MbQ22t+b2xuNb9q0+iLkSsnZ3HbfixrT4sCHmeuV/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KCih/mMBTEh9BAIAHmPnycQH0ks48zExYHL9xp3TmQtiICjTpXy2b8GMRWNyKT0XKje6SCkDxRJcLt8ZgHAi0JJsEiPCKlUzEQovH8yhdBxRcC7UOXhDvdTaDMurfsNFYQyAbQsni0R9dwEvp+5eA1jKHC0VIVrqlF0vq7PihVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlWaNnX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlWaNnX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4931F00A3A;
	Wed, 19 Aug 2026 19:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166863;
	bh=m+CLP2BQgat6/UsQVDtqyLYCW3m+XKIezPsilsPcyh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlWaNnX25GV4njA+OBGoWw2ITR9Ndmwk3ebdPGIfmrZQHYO+qEdFnl3WFWE2h1+2S
	 AG5Fo5C7MaqIBWBNcSfOEZfvMDIGyBX+OOyjM8+0YSzmD7qpcbypPkAlRGh0c/lliH
	 kq/cUb8kM+sPppGOXGIQjuCXHkCQhBq1mm2Z2FXO3RZ7FarCoLYeuyEAt+Fgt+aSax
	 4Yuu2Ctxi2Z2Hei1eA0IfvB/tpB6CfYLym69rMA4OkEIJn7mSYfjoPkIcHATi4iAtb
	 11M5wiH+dVnfXG1TBo3doP9IVXUuoG3rFQqXOzpJXB34kMk9zDDhdPa11ROBzx/l/s
	 PmPPvpU9dZxVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v23 1/3] rust: leds: add basic led classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, linux-pci@vger.kernel.org, lee@kernel.org, ojeda@kernel.org
In-Reply-To: <20260819-rust_leds-v23-1-2716a4ef89a4@posteo.de>
References: <20260819-rust_leds-v23-0-2716a4ef89a4@posteo.de>
 <20260819-rust_leds-v23-1-2716a4ef89a4@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:14:23 +0000
Message-Id: <20260819191423.9B4931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `blink_set_callback` creates aliased mutable references if `de=
lay_on` and `delay_off` point to the same memory location.
- [High] The lifetime bound `'bound: 'init` on `DeviceBuilder::build` is in=
verted, allowing the Device to outlive its borrowed C strings.
- [Medium] The commit message description is not capitalized after the subs=
ystem prefix.
- [Low] Small functions in abstractions must be annotated with `#[inline]`.
--

--- Patch [1]: [PATCH RESEND v23 1/3] rust: leds: add basic led classdev ab=
stractions ---
commit 0bee73d85d7c6052f28b0588d95b4632e4bdc662
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions

Implement the core abstractions needed for led class devices, including
the Device builder and LedOps trait.

> rust: leds: add basic led classdev abstractions

[Severity: Medium]
This isn't a bug, but the subsystem guidelines request capitalizing the=20
description after the subsystem prefix. Should this be "rust: leds: Add=20
basic led classdev abstractions" instead?

> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> index 596975e103b8b.....
> --- /dev/null
> +++ b/rust/kernel/led.rs

[ ... ]

> +impl TryFrom<u32> for Color {
> +    type Error =3D Error;
> +
> +    fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {

[Severity: Low]
This isn't a bug, but the Rust subsystem guidelines specify that small=20
functions in abstractions should be annotated with #[inline]. Could we add=
=20
that attribute to this try_from() implementation?

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> index 816db7c576894.....
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> +impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
> +    /// Registers a new [`Device`].
> +    pub fn build<'bound: 'init, T: LedOps + 'bound>(
> +        self,
> +        parent: &'bound T::Bus,
> +        ops: impl PinInit<T, Error> + 'init,
> +    ) -> impl PinInit<Device<'bound, T>, Error> + 'init {

[Severity: High]
Is the lifetime bound 'bound: 'init inverted here?

DeviceBuilder captures string references with the 'init lifetime. If the=20
returned Device has a 'bound lifetime that outlives 'init, a caller could=20
create a Device that escapes the scope of the borrowed strings.

Since the underlying C led_classdev stores raw pointers to these strings,=20
could this lead to a use-after-free when accessed via sysfs if the strings
are dropped?

[ ... ]

> +    unsafe extern "C" fn blink_set_callback(
> +        led_cdev: *mut bindings::led_classdev,
> +        delay_on: *mut usize,
> +        delay_off: *mut usize,
> +    ) -> i32 {

[ ... ]

> +            classdev.ops.blink_set(
> +                parent,
> +                classdev,
> +                // SAFETY: The function's contract guarantees that `dela=
y_on` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_on },
> +                // SAFETY: The function's contract guarantees that `dela=
y_off` points to a `usize`
> +                // and is exclusive for the period of this function.
> +                unsafe { &mut *delay_off },
> +            )?;

[Severity: High]
Does this create aliased mutable references if the C subsystem passes the=20
same pointer for delay_on and delay_off?

The C LED subsystem explicitly permits and frequently passes the exact same=
=20
pointer for both arguments. For example, led_blink_set_oneshot() in=20
ledtrig-netdev.c passes identical pointers.

If both pointers are identical, converting them concurrently into two=20
&mut usize references triggers undefined behavior in Rust. Could we handle=
=20
this aliasing safely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-rust_leds-=
v23-0-2716a4ef89a4@posteo.de?part=3D1
