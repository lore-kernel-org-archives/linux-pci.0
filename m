Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B292DA775
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780183030; cv=none; b=UhoeCc45zPGA15fUXxy84Am3Jii6iQg+56SaoVFC3/TpIafjPbnULwjP8ueQFSngyb0HJPCDLD7nlgcqznpvaiPlTam5wdvEf5wkQituJhg+KWT9YuLxBQ4xLtqPALs1GeDi+OJbeCIGMAmRVI4o3wQl9i8jCfTnNn+kOaWuxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780183030; c=relaxed/simple;
	bh=GrqM23v+MnWgyzd21fC7uIedSS+dA3U87DVhRjbfhrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oMfadQap61mdb5nseDxqqord8znEQ4vFLmCdNVJqFiGTBgdlTHDeh+rqKWFNxo/w+ljI/JvZv+z4wNJN+fqXJLax/eTxxmF45ozJj2FeZbAbaRW8dabcHPxSCQypcRg6JFFLIGeMjDbJnBeozIlwHJ4GcTlqrEd52zpQMtj5DPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTeTZfFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTeTZfFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DBE1F00893;
	Sat, 30 May 2026 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780183028;
	bh=6I+I+D0wtkv+SdcWQw6EI3ORLU7kmr9UB7wqj906TjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTeTZfFdbkLDVz4/0Np2DfQbaEUuxEv8GTXBb0+5oDqSx0kNWXbJ0cWo0VDztnj/E
	 B5YaW78KtQZVD1V2ljTxrgBFo8eT1JcyKWBAYBKeS9TpPJf4JbUSN5B++QNujxVoJz
	 rPPSS/zKeM6FStQo3eyvHmjO2C4ex5cnQQ80PCxyopCtC5EqHTZlcr3vBeN0ivLlI5
	 ar5vscgwrlo1R4LMXU+WcaD7FoC/dGQhwJH2ncaPAgz1JRO4mK14EHUvzWzYEBMF5j
	 iRKcr47jZDIOISquIM2uc3r6/8PbjkeV/RU3SQTmWS31X02khAUfyaFUGklL5bFyRy
	 lEILKd+IERxmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 2/3] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260531-rust_leds-v18-2-d07102ba5170@posteo.de>
References: <20260531-rust_leds-v18-2-d07102ba5170@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 23:17:08 +0000
Message-Id: <20260530231708.98DBE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Flawed fwnode reference count management in `led::Device` leads to=
 refcount underflow or memory leaks.
- [High] Inverted lifetime bound `'bound: 'a` in `DeviceBuilder::build` all=
ows the `Device` to outlive its name string, causing a Use-After-Free.
--

commit 79f921a7fb31b3f89538463530e40a222e664817
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait
   =20
Add the led::Mode trait to allow for other types of led class devices
in led::LedOps.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> index 09244133f14c8..2ffe65bb9dc2c 100644
> --- a/rust/kernel/led/normal.rs
> +++ b/rust/kernel/led/normal.rs

[ ... ]

> @@ -20,7 +28,7 @@ pub struct Device<'bound, T: LedOps + 'bound> {
> =20
>  impl<'a, S: DeviceBuilderState> DeviceBuilder<'a, S> {
>      /// Registers a new [`Device`].
> -    pub fn build<'bound: 'a, T: LedOps + 'bound>(
> +    pub fn build<'bound: 'a, T: LedOps<Mode =3D Normal> + 'bound>(

[Severity: High]
Does this inverted lifetime bound ('bound: 'a) allow the device to outlive =
its
name string?

It appears that a caller can safely initialize a long-lived device (e.g.
'static) using a short-lived local string, because the returned PinInit does
not capture 'a.

Since the short-lived name pointer is assigned to the persistent C struct:

    name: self.name.map_or(core::ptr::null(), CStrExt::as_char_ptr),

Does dropping the local string leave a dangling pointer in the C struct,
causing a use-after-free when the LED subsystem accesses led_cdev->name?

[Severity: High]
Can the fwnode reference count management here lead to underflows or memory
leaks?

In DeviceBuilder::build(), if self.fwnode is Some, its ARef is leaked:

    core::mem::forget(self.fwnode); // keep the reference count incremented

But if it was None, no reference is leaked.

>          self,
>          parent: &'bound T::Bus,
>          ops: impl PinInit<T, Error> + 'a,

[ ... ]

> @@ -209,7 +217,7 @@ impl<T: LedOps> Adapter<T> {
>  }
> =20
>  #[pinned_drop]
> -impl<'bound, T: LedOps + 'bound> PinnedDrop for Device<'bound, T> {
> +impl<'bound, T: LedOps<Mode =3D Normal> + 'bound> PinnedDrop for Device<=
'bound, T> {

[Severity: High]
When <Device as PinnedDrop>::drop attempts to recover the fwnode reference =
from
the mutable C field dev->fwnode:

    let _fwnode =3D dev
        .fwnode()
        .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode)) });

If self.fwnode was None, but the C core populates dev->fwnode (e.g. device_=
add
sets it to parent->fwnode), will PinnedDrop steal and drop a reference it d=
oes
not own, causing a refcount underflow?

Conversely, if self.fwnode was Some, but dev->fwnode is later cleared or
overwritten by C code, will the ARef never be dropped, causing a memory lea=
k?

>      fn drop(self: Pin<&mut Self>) {
>          let raw =3D self.classdev.get();
>          // SAFETY: The existence of self guarantees that self.classdev.g=
et() is a pointer to a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531-rust_leds-=
v18-0-d07102ba5170@posteo.de?part=3D2
