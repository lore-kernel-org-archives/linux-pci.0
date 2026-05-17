Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F401FC10C
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778977534; cv=none; b=IOGembllTtsLPFTr2qaTpHpnWwQ6ijn03bQtCBOS8b41Z5ZqnFZtJEUSeCF5lFuF+A3VlFwnEZWk2sqqeF8o8KJzzXIK47zx7bmQsTSPpnM7FmzJTktiviRvBkY1y2kq0lZ+rB8LW5mXl0554J1ZgN3ReUfcnDIbzEd5H2QTTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778977534; c=relaxed/simple;
	bh=Qkj8J/EYOsrSguYoMRhn6nmbR0F8itfIo+57PhXr/vU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ecSYgmLUky+Fqg7RblSFJQbrg1iUR70ypHM62WLeQufcotYZ/Y/5G1s+HoypL5SffVFHXe40pNzw3Z/NJFYLAT+Ig13WdSporMVYRNlLaAaQyo2EM1/whT4HVyKQg98kCT8nVJhkxNwS8ZR0BYsugIKmnukAFVzP9H+VXCYOivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOR61rfN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOR61rfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB17C19425;
	Sun, 17 May 2026 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778977533;
	bh=Qkj8J/EYOsrSguYoMRhn6nmbR0F8itfIo+57PhXr/vU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sOR61rfN9CiWE0yvYWryhwyl42JSIJhefrKQL5c45zmS5bF06rb3QPX7Mra2FGdS6
	 MTqXt3JQTtjjRvATtP0d6H+FnlCg6RRSmZo3AmMWmQ/fLrcE5fHHt8CVdOpqCbsTMv
	 XKW0QwuUpwCfU+UZXaNiS5B0KJFUodOIKdD172iJamRuH7ug6gNyodorYOlWswW7EF
	 kIbCZcpkmWXulwZmdkvnR4bBvIZjW6Cn1wJhfuMfF6cnwMuqubGZ6Az/pPZonAlRbt
	 iyfWOp7thENe19SrTt7NFZUqVpcZBUx2WCgvUg6SCCyTorsnSkjeBak6wznPcWjUq2
	 c7IVoliOjcoig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/27] rust: usb: make Driver trait
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-14-dakr@kernel.org>
References: <20260517000149.3226762-14-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 00:25:33 +0000
Message-Id: <20260517002533.ABB17C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Use-After-Free vulnerability due to incorrect `'bound` lifetim=
e on dynamic `DeviceId`.
- [High] Soundness violation and FFI lifetime bypass in driver data retriev=
al.
- [Low] Commit message incorrectly references `unbind()` instead of `discon=
nect()`.
--

commit 92ace0018c4af4c9a4ccdae5f9dd912c5a7f6ab0
Author: Danilo Krummrich <dakr@kernel.org>

rust: usb: make Driver trait lifetime-parameterized

This commit introduces a 'bound lifetime parameter to the usb::Driver::Data
associated type. This allows driver private data to store references direct=
ly
instead of relying on Devres. The probe and disconnect callbacks are updated
to use this lifetime.

> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.

This isn't a bug, but the commit message references unbind() instead of
disconnect(). The USB subsystem specifically uses disconnect(), whereas
unbind() is typically used by other bus types like platform drivers.

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 995221d327b89..ec67e4d2416f1 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs

[ ... ]

> @@ -110,7 +110,7 @@ extern "C" fn disconnect_callback(intf: *mut bindings=
::usb_interface) {
>          // SAFETY: `disconnect_callback` is only ever called after a suc=
cessful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.
> -        let data =3D unsafe { dev.drvdata_borrow::<T::Data>() };
> +        let data =3D unsafe { dev.drvdata_borrow::<T::Data<'_>>() };
> =20
>          T::disconnect(intf, data);
>      }

Does this violate the type matching contract of ForeignOwnable?

The data is originally stored in probe_callback() with a local 'probe lifet=
ime
but is retrieved here with a newly instantiated local '_ lifetime.

If a driver implements Data<'bound> such that it is invariant over 'bound
(for example, by using interior mutability like Cell<&'bound Interface>), t=
hen
T::Data<'probe> and T::Data<'_> are formally different types in Rust.

Transmuting between invariant types with different lifetimes could violate =
the
safety preconditions of ForeignOwnable and bypass the borrow checker's abil=
ity
to verify constraints across the FFI boundary.

[ ... ]

> @@ -315,16 +319,19 @@ pub trait Driver {
>      ///
>      /// Called when a new USB interface is bound to this driver.
>      /// Implementers should attempt to initialize the interface here.
> -    fn probe(
> -        interface: &Interface<device::Core>,
> -        id: &DeviceId,
> -        id_info: &Self::IdInfo,
> -    ) -> impl PinInit<Self::Data, Error>;
> +    fn probe<'bound>(
> +        interface: &'bound Interface<device::Core>,
> +        id: &'bound DeviceId,
> +        id_info: &'bound Self::IdInfo,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;

Can tying the id parameter to the 'bound lifetime result in a use-after-fre=
e?

When a device is bound using a dynamic ID (added via the new_id sysfs
attribute), the USB core passes a pointer to a dynamically allocated
struct usb_dynid to the probe function via usb_match_dynamic_id().

Userspace can remove dynamic IDs at any time using the remove_id sysfs
attribute, which unlinks and frees the usb_dynid without checking if any
currently bound devices matched against it.

If a Rust driver safely stores the id reference in its private Data<'bound>
based on this lifetime guarantee, it could hold a dangling pointer once the
dynamic ID is removed, potentially causing a use-after-free later during
the device's lifecycle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D13
