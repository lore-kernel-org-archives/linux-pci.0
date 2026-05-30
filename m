Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3D312836
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780107152; cv=none; b=dNZSpdu0SypMNuci2VdVfpvcLcpNLiN8dgRPb7do1wBbDo7sptTiSRDzpSvw0ZlPobb3mbfRNfLp5T7+apBOR9s6BXpD46EVdfewhPqwjDCVEyCTwGrfswj3d4p2Yvjxi14jlgBaCbI8AL2aZq1OdvrGKOeGtvvKFmHGN+E+4hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780107152; c=relaxed/simple;
	bh=NbDuEZTa+IJAfPy68xTCTTrLwN7ylOuD2YzNNHvm4+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kkbFGsO4z/1TCWn8rIU6aJRmznFbATj/BZXFhpRY6Fuf8h20/8FxGZn1f/um37Vry7kQaqMMk2sMJSDjV+WuNJ6gRu924+amavoWpJo3hxhmnK5Lx1cgfemW2ueiangNOFNFkfmXwg0FEafi1ERigFz9pTKUib7hzLWGQ6JknRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owYISFR/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owYISFR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C265B1F00893;
	Sat, 30 May 2026 02:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780107151;
	bh=DjpL5PeHz3Cc+DIH3Xk/3acC8jhBsOi4kOCE+yAkgIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owYISFR/H1DSEtqyBtiP7kUQkUd8NFcbiUdn+KOWlNCAyqvPcUvrAaxHa3iwNdXe0
	 D9kZcEfwgexenW/fDsLiV6aub5tCvbRWXznxQmrIXuADQAAxB8jFne3UOVniXZecoE
	 OwNSi6p0JXoTOjjlXNAYeHLziUG4bmPQUEmGVoqIbXsQOsunvES0BiH5osKeqKF/mp
	 bfOK5FOlNV++zyw2kLJcELx+5TGSLvtukjaoz1+KWoZAg/O0v7fWfdGQ/H+9vt0x5X
	 2F5zwaFidr6vCK1Sj/S2jawpDRF5pQAXSrHA1/DtT3sko0TxwiaMZEkWw2LIctQ5jV
	 x2l6SKN7Tnjrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 1/3] rust: leds: add basic led classdev abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260530-rust_leds-v17-1-c0698c4368e2@posteo.de>
References: <20260530-rust_leds-v17-1-c0698c4368e2@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 02:12:28 +0000
Message-Id: <20260530021230.C265B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lifetime erasure in `DeviceBuilder::build` allows `led_classdev.na=
me` to hold a dangling pointer, leading to a use-after-free.
- [High] `Device::drop` unconditionally constructs an `ARef<FwNode>` from t=
he underlying C device's `fwnode`, which can drop unowned references and ca=
use a refcount underflow/use-after-free.
--

commit 3bf2be04b997951443702ccedf215841f12a00f7
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add basic led classdev abstractions

This commit implements the core abstractions needed for led class devices,
including LedOps, DeviceBuilder, and Device wrappers around led_classdev.

> diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> new file mode 100644
> --- /dev/null
> +++ b/rust/kernel/led/normal.rs
[ ... ]
> +impl<'a, S: DeviceBuilderState> DeviceBuilder<'a, S> {
> +    /// Registers a new [`Device`].
> +    pub fn build<T: LedOps>(
> +        self,
> +        parent: &'a T::Bus,
> +        ops: impl PinInit<T, Error> + 'a,
> +    ) -> impl PinInit<Devres<Device<T>>, Error> + 'a {
[ ... ]
> +                    unsafe {
> +                        ptr.write(bindings::led_classdev {
[ ... ]
> +                            name: self.name.map_or(core::ptr::null(), CS=
trExt::as_char_ptr),
> +                            ..bindings::led_classdev::default()
> +                        })
> +                    };

[Severity: High]
Does this erase the lifetime bounds of the name string and risk a
use-after-free?

In the DeviceBuilder definition, the name field has a bounded lifetime 'a:

    name: Option<&'a CStr>

However, the returned impl PinInit builds a Device<T> which does not capture
the 'a lifetime parameter, meaning the resulting device can outlive the
provided string. If a caller uses a short-lived string (like a dynamically
allocated CString) for the name, the string will be dropped after device
initialization.

Since this raw pointer is written directly into led_classdev.name without
requiring a 'static lifetime or taking internal ownership, could the kernel
access freed memory when reading the name later, such as via sysfs or debug
logs?

[ ... ]
> +#[pinned_drop]
> +impl<T: LedOps> PinnedDrop for Device<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let raw =3D self.classdev.get();
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `led_classdev`.
> +        let dev: &device::Device =3D unsafe { device::Device::from_raw((=
*raw).dev) };
> +
> +        let _fwnode =3D dev
> +            .fwnode()
> +            // SAFETY: the reference count of `fwnode` has previously be=
en
> +            // incremented in `led::Device::new`.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Can this unconditionally drop unowned fwnode references and cause a
refcount underflow?

In DeviceBuilder::build(), the fwnode reference count is only leaked via
core::mem::forget(self.fwnode) if self.fwnode was explicitly provided.

However, here in Device::drop(), the fwnode is read back from the underlying
C device structure using dev.fwnode(), and unconditionally wrapped in an
ARef to decrement its reference count.

If the device was initialized without an explicitly provided fwnode, but the
kernel's driver core later automatically assigns one to the child device fr=
om
its parent (e.g., during device_add), dev.fwnode() will return a valid
pointer.

Would this cause Device::drop() to decrement the reference count of an fwno=
de
it never actually owned, leading to a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530-rust_leds-=
v17-0-c0698c4368e2@posteo.de?part=3D1
