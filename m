Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FE440636;
	Wed, 19 Aug 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166681; cv=none; b=cViCkVZ626gyV/PSAbfwgCQ3sMLSO1mbb+W0r/rn5hHVEBrm93IWT4VtN3ghXU0EvzB3S8t+Cf7F+ZaLfB1RtmMiD7B3uF77xhFt9EIt+KiCSQWTko4BhmXpwzndIW0qlLKJI9lPJlKJy1xhy1Vn7fce1r8ylLjTF1a/rCWL0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166681; c=relaxed/simple;
	bh=NGhSgP98xLSj+Fwal/dvS1d2qE8VHaL9ADtsckXPRpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cWnBgDDsP3onllHmdG1ax0zrJOr6aAaqDlIBit+tf9XrCSOu5p10zrDH6DKFeJZLCVsczwP9KCUTYOHMazJdCe32TstDIjAPi+j6gMlz132oAEeJyNdE5t+ZNl5rIj1DeP0r5fGxwGYRQy+uTFwzvbFBHlIy+yTiywZzGN27QB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLe2uvYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLe2uvYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19A51F000E9;
	Wed, 19 Aug 2026 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166680;
	bh=wulOe58Ms5+HkjKT2MkwlEA700PyFJKFLo0Cnq/7iVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLe2uvYRG3kWgqjNxUyPuXvkY+NGAK4Nz4y/ismt2YwR+sTFqax2Imy+82lvb7uqy
	 y+MRRhIjCDX9gk9WSxfYXULyKrOLFflSf9hIRvJHdsf8ZWoyKnUaHyUx+BfHKMeDcN
	 o2SS28f+iMpAIhXMfCHyn2alNxnAsRZbgr3C1B2DieRpU71YQ3w4eb9mSgcX+iudj5
	 bq6Cz3iSRPVO2d7vUqF6nmNr4hgyosctrCIj7eJmAhiAGXg0myWI4GNisAS33Gdqhs
	 c2mnJiGmwYaQVMBusarLm8XhjCAs4gHMrVi7+ex/3OXX1iEy01Q8qOQxwJXqdJIwcL
	 Vfe59Q2GBFfag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v23 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, lee@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260819-rust_leds-v23-2-2716a4ef89a4@posteo.de>
References: <20260819-rust_leds-v23-0-2716a4ef89a4@posteo.de>
 <20260819-rust_leds-v23-2-2716a4ef89a4@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 19:11:19 +0000
Message-Id: <20260819191119.F19A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unsound conversion of potentially aliased C pointers to `&mut usiz=
e` in `blink_set_callback`.
- [High] Relying on PinnedDrop and unmanaged led_classdev_unregister introd=
uces a Use-After-Free (UAF) vulnerability on driver unbind if the Device in=
stance outlives the parent device.
- [Low] The commit message description starts with a lowercase letter, viol=
ating LED subsystem conventions.
--

--- Patch [2]: [PATCH RESEND v23 2/3] rust: leds: add Mode trait ---
commit 8b1c998241db82c99cdf6f28eac6bffb4a27cef4
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait

Add the led::Mode trait to allow for other types of led class devices
in led::LedOps.

> rust: leds: add Mode trait

[Severity: Low]
Is this commit subject formatted correctly? The LED subsystem guidelines
require capitalizing the description after the subsystem prefix.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> index 816db7c576894..25190486a62d0 100644
> --- a/rust/kernel/led/normal.rs
> +++ b/rust/kernel/led/normal.rs
[ ... ]
> @@ -20,7 +28,7 @@ pub struct Device<'bound, T: LedOps + 'bound> {
> =20
>  impl<'init, S: DeviceBuilderState> DeviceBuilder<'init, S> {
>      /// Registers a new [`Device`].
> -    pub fn build<'bound: 'init, T: LedOps + 'bound>(
> +    pub fn build<'bound: 'init, T: LedOps<Mode =3D Normal> + 'bound>(
>          self,
>          parent: &'bound T::Bus,
>          ops: impl PinInit<T, Error> + 'init,

[Severity: High]
Can relying on PinnedDrop to unregister the LED device result in a
use-after-free regression?

In this build function, the code calls bindings::led_classdev_register_ext()
and later relies on bindings::led_classdev_unregister() in PinnedDrop:

rust/kernel/led/normal.rs:DeviceBuilder::build() {
                to_result(unsafe {
                    bindings::led_classdev_register_ext( ... )
                })?;
...

rust/kernel/led/normal.rs:PinnedDrop for Device {
    fn drop(self: Pin<&mut Self>) {
...
        unsafe { bindings::led_classdev_unregister(raw) };
    }

If the Device instance outlives the parent device (for example, if it is
wrapped in an Arc and kept alive by another thread), the Drop
implementation will not execute at driver unbind time.

Because led_classdev_unregister is not called during unbind, the LED sysfs
attributes would remain active. Subsequent sysfs accesses could then invoke
callbacks that dereference the freed parent device pointer.

Should devm_led_classdev_register_ext() be used to explicitly tie the
teardown to the unbind lifecycle?

[ ... ]
> @@ -107,17 +115,17 @@ fn parent(&self) -> &'bound device::Device<Bound> {
>  }
> =20
[ ... ]
>  struct Adapter<T: LedOps> {
>      _p: PhantomData<T>,
>  }
> =20
> -impl<T: LedOps> Adapter<T> {
> +impl<T: LedOps<Mode =3D Normal>> Adapter<T> {
>      /// # Safety
>      /// `led_cdev` must be a valid pointer to a `led_classdev` embedded =
within a
>      /// `led::Device`.

[Severity: High]
Does this Adapter contain an unsound conversion of potentially aliased
C pointers?

In blink_set_callback(), the function unconditionally converts delay_on and
delay_off pointers into mutable references:

rust/kernel/led/normal.rs:blink_set_callback()
                unsafe { &mut *delay_on },
                ...
                unsafe { &mut *delay_off },

The C function led_blink_set() and its callback signature accept these
pointers without the restrict keyword. This means C callers are legally
permitted to pass the same pointer for both arguments.

Could a C caller aliasing these pointers create overlapping mutable
references and trigger undefined behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-rust_leds-=
v23-0-2716a4ef89a4@posteo.de?part=3D2
