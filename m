Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F31ADC83
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780187810; cv=none; b=Gz9QRkQ6Pebm5K8p+nxRwoOxHV7ezm8Y9lZFR3CqfkpCursweM8AvO1zIRJ5+huLCxULyJ3XrEIA+M6kN+YA0QWooaH0cPFHdJPwpwsM4XrhOG8KEsJt5xAX5xhrJCzqPTbUCWZfAoFrz5fPMgGpMs2/vX5max5tNFVrKBKQbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780187810; c=relaxed/simple;
	bh=q2sNlLySkI3/aJ8QvlZqjqOgYn6x3Cz44lGAZePMgzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i7b7Y0Fxi3SIpTlfV08qzwrfmRoy3aB9a4FrFLWvo3NmG9xPYciRi+mIHXYQ2EnYnZtbwHU9FabZVvbwlY9sYq3AfLTk6fvpkMGURGIrty9HolFbRWRsOREsTLXKArYQWjcOa2B647431ckMjKYuRdKOZCLj07mfyM6btAUELRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Xgetje1Q; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Xgetje1Q"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B9593240027
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 02:36:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780187806; bh=kunA1OaE5cEl+xqdySdyaDJa7tmll7p4ATXisHJCPUc=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Xgetje1QwnIIr1wDWwa/6ku/Yltl37V/2+4vrtkAUuE+IsZPRUVOd0DKgqRkTV9FU
	 TzTuZfevFviiFAEdhG8MkSXZrDwVfCc4HlTE3twdeRouf8xNQaWj5KA75Ck7g2qb7p
	 8wK/4Fqm5nDzePS9GBPFDqaQi6wDY6ai0U5bY6Ipi7WyUeftAjYfhyGdjlSn5cS+mG
	 bk7GCeRXQymU32+AbMf4XjE/ZXw5ByxRWGJFiZgoiEEfrp/IlMFupBgikJpKj1phLL
	 HQIyGkBiZpnJfaTI8Nh3/e/ULKTxVH4due3LMNXQMs6GZ/O9N8A1XUb0gIBpG/DaRG
	 c//twGDiTi+Mg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSdSt281gz6trs;
	Sun, 31 May 2026 02:36:46 +0200 (CEST)
Message-ID: <33c32516a42a3e07449346bdeac831abe70101d0.camel@posteo.de>
Subject: Re: [PATCH v18 3/3] rust: leds: add multicolor classdev abstractions
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
Date: Sun, 31 May 2026 00:36:46 +0000
In-Reply-To: <20260530232546.53ED31F00893@smtp.kernel.org>
References: <20260531-rust_leds-v18-3-d07102ba5170@posteo.de>
	 <20260530232546.53ED31F00893@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-LSm84vYpP5KQNvotN5vN"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-LSm84vYpP5KQNvotN5vN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 23:25 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] Data race and Undefined Behavior due to `&[MultiColorSubLed]` ex=
posing concurrently mutated plain `u32` fields.
> - [High] Reconstructing KVec with a hardcoded capacity violates the `KVec=
::from_raw_parts` safety contract.
> - [High] FwNode reference count leak or Use-After-Free when `name` is exp=
licitly set.
> - [Low] Dead documentation link for `MultiColorSubLed::brightness`.
> - [Low] Missing `#[inline]` attribute on the `from_raw` internal helper f=
unction.
> --
>=20
> commit 06862c24665d65b7a33c6a01c9dd3881267810e1
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rust: leds: add multicolor classdev abstractions
>    =20
> Implement the abstractions needed for multicolor led class devices,
> including `led::MultiColor` and `MultiColorDevice`.
>=20
> > diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor=
.rs
> > new file mode 100644
> > index 0000000000000..18c9d36221f1e
> > --- /dev/null
> > +++ b/rust/kernel/led/multicolor.rs
>=20
> [ ... ]
>=20
> > +#[repr(C)]
> > +#[derive(Copy, Clone, Debug)]
> > +#[non_exhaustive]
> > +pub struct MultiColorSubLed {
> > +    /// the color of the sub led
> > +    pub color: Color,
> > +    /// the brightness of the sub led.
> > +    ///
> > +    /// The value will be automatically calculated.
> > +    /// See `MultiColor::pre_brightness_set`.
>=20
> [Severity: Low]
> Is the reference to MultiColor::pre_brightness_set correct?  This functio=
n
> does not appear to exist in the code, and MultiColor is a marker enum.
Thats a typo.

>=20
> > +    pub brightness: u32,
> > +    /// the intensity of the sub led.
> > +    pub intensity: u32,
> > +    /// arbitrary data for the driver to store.
> > +    pub channel: u32,
> > +}
>=20
> [Severity: High]
> Does this expose concurrently mutated fields as plain integers?
>=20
> When the C kernel LED core modifies the subled values (for instance, via
> led_mc_calc_color_components modifying brightness during sysfs writes),
> these fields are mutated without Rust-visible synchronization.
>=20
> Since MultiColorDevice::subleds() hands out a shared, immutable slice
> &[MultiColorSubLed] to the driver, does using plain u32 instead of
> interior mutability primitives like Opaque or UnsafeCell violate strict
> aliasing invariants and risk undefined behavior?
I don't think there is a way to guarantee this safety.

>=20
> [ ... ]
>=20
> > +                let subled_guard =3D ScopeGuard::new(|| {
> > +                    // SAFETY: `subled_info` is guaranteed to be a val=
id array pointer to
> > +                    // `mc_subled` with the length and capacity of `nu=
m_colors`.
> > +                    drop(unsafe { KVec::from_raw_parts(subled_info, nu=
m_colors, num_colors) });
> > +                });
>=20
> [Severity: High]
> Is it safe to hardcode the capacity to num_colors when reconstructing
> this KVec?
>=20
> The original KVec was dynamically allocated using extend_from_slice(suble=
ds)
> which could potentially over-allocate.  Since the exact allocated capacit=
y=20
> is verified but then discarded, reconstructing the KVec here (and during=
=20
> PinnedDrop) with num_colors as the capacity might violate=20
> KVec::from_raw_parts safety contract.
>=20
> Should the exact capacity be stored, or perhaps a boxed slice (KBox<[T]>)
> used instead to ensure the allocator frees the correct size?
I am not aware that its possible to convert it into an KBox<[T]>, if so
I would prefer this solution. But currently it is safe, as the capacity
is defined by max(new_len, current_capacity * 2) on allication. This
will always result in new_len on the first allocation.

>=20
> [ ... ]
>=20
> > +                // SAFETY:
> > +                // - `parent.as_ref().as_raw()` is guaranteed to be a =
pointer to a valid
> > +                //    `device`.
> > +                // - `ptr` is guaranteed to be a pointer to an initial=
ized `led_classdev_mc`.
> > +                to_result(unsafe {
> > +                    bindings::led_classdev_multicolor_register_ext(
> > +                        parent.as_ref().as_raw(),
> > +                        ptr,
> > +                        if self.name.is_none() {
> > +                            &raw mut init_data
> > +                        } else {
> > +                            core::ptr::null_mut()
> > +                        },
> > +                    )
> > +                })?;
> > +
> > +                subled_guard.dismiss();
> > +
> > +                core::mem::forget(self.fwnode); // keep the reference =
count incremented
>=20
> [Severity: High]
> Could this lead to a fwnode reference count leak or a use-after-free if
> self.name is configured?
>=20
> If self.name is set, a null pointer is passed to register the device inst=
ead
> of &mut init_data, meaning the C device does not inherit the provided fwn=
ode.
> However, self.fwnode is unconditionally forgotten, which leaves its refer=
ence
> count incremented.
>=20
> Later, during device drop, dev.fwnode() is queried to decrement the refco=
unt.
> If the device has no fwnode, it returns None, permanently leaking the ori=
ginal
> fwnode. If the device inherited a fwnode from its parent, dev.fwnode() wo=
uld
> return the parent's fwnode, incorrectly decrementing it and potentially c=
ausing
> a use-after-free of the parent's fwnode.
It only needs to outlive the registration, as its copied there.
>=20
> [ ... ]
>=20
> > +impl<'bound, T: LedOps<Mode =3D MultiColor> + 'bound> MultiColorDevice=
<'bound, T> {
> > +    /// # Safety
> > +    /// `led_cdev` must be a valid pointer to a `led_classdev` embedde=
d within a
> > +    /// `led::MultiColorDevice`.
> > +    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &=
'a Self {
>=20
> [Severity: Low]
> this isn't a bug, but should this internal helper function have an #[inli=
ne]
> attribute?
>=20
> According to the Rust subsystem guidelines, small internal helper functio=
ns
> within abstractions should be annotated with #[inline]. Since this method
> consists exclusively of unsafe pointer arithmetic (container_of!), it see=
ms
> it should be inlined.
I will add a #[inline] there.

>=20
> [ ... ]

--=-LSm84vYpP5KQNvotN5vN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmobgpYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS9H8P/jFKrUKfTTHzx8h1jMuU
0+sht9cJrGLLaR2UkKlDdDicuI+uCqnMECQZ8WdZKNQqwmoipPUP8Q12zx4HQdni
RABs4XBBJ8PySeUUy/rAmOmCL2Avu95oqfcrYPVuRB3FlMtrhRPv8PbAfh55/Vo7
zf1Y863Mxzq5CAqbbA6RBf0LZULPZ1aFSGWOnFZ3bGocEVNhptJhW9qWBrMSB24U
Jslk5Z2+01uISQGW29lEDP2NKAR3sHxvFcNW+1697vRzTjz90ZNlaHOWBwLRnYRf
IT2MooN8ww91r2i+HzA6Yjv3N970mxEpixoHLwuRvvtPGwW3KdATRBr9NsaJwxet
W7QwB+Jag0SKC3rO2gZP4srBpbFZV7JBnZ7+0zjkjJBzABMzGK6OYY4/ycfGoaAf
c4VzWB6qVQUZANe6nOO2xuWSmPL6OoUbawDKmjqIUXvfs0+GaqqJWARwYSa5MhsP
yPg0Au7HDV5RESpMuL38Ge/xGb+IDFWXPx5t0a7OnQSnMAD5frPR4xTsiNzZKPrF
uPdYwkIvPtHWbLxrCizhH1Y4y2jw+YRCJicw0bwCMTRMiJT9ah7zKs2f2gXpG2bE
1yAkNqtAcEzg5PjFCm/f1l5TkYrSiI+OTpG2HhAMrjirYuJuvpeuzZRywMYhOuoy
GY9KzKqjfVeGiyO7Q+HpgnNB
=DE2J
-----END PGP SIGNATURE-----

--=-LSm84vYpP5KQNvotN5vN--
