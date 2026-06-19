Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D6F3B440F;
	Fri, 19 Jun 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888710; cv=none; b=cvBKjVbnV+GCY+OeIr+nJixZsVRTAVPHVOZnnNbxuhp26zwHiiDC5fZAux0GAWlEi0TuXx1IpOH+lWsrLgZxopkF/QHConGC4jiid2Au6T7Vm66DHSjaXqtr+DKlHmLIXSCEzydzdx/CqjzOtF+yJ2UN9rfAqfFXmjKNDC9yJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888710; c=relaxed/simple;
	bh=tM7JJJXHP4aFce2tXYpu9AKGtsJ7dPkshXzERn6WaG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQ9Pl7qEhE2wk46VRdHcYDofaPowjRDXevgG8yqR/HJYSMzs37uoS/Xdl6iQ6FqvRxf4IA5vwOsb+xJhfH5iu+e92kfmwQjYNoGvnDe+4GFVcOTfBr0Mk/ktNAFN5xocYWo9CElnGNL2Pp9/ckFHutlx7d9CIsv+RpX4uqLpj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX3L3/sY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX3L3/sY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9351F00A3E;
	Fri, 19 Jun 2026 17:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888709;
	bh=Tub/KdowtvIU5OvLOVVwUz8th6S3b9gChhlruCvYmm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NX3L3/sYN5F3sEqaulTvrIrRG4sFh1UjJrAU5XqOvWxIhm1iecAwSa1wQa3jS/ld1
	 eh0YBNzqN2SiHBuDQz+krmYq2obl8He2xJH+BWL8HoPNUV2G9yLds3E43MyBqNfdQj
	 Yu6e5A2dLTEbuSjmVBFvvcd97wca6qJ8LV9C//OW/rKjjfek0rQwp0Q0vk0qZ94jNF
	 2CZOpij6ytk9yL2ldsFF1GTTNK3gzWR4ZynpIN23y2DnsIWN2AKIxLkSpNiLkM7D1n
	 RVp/G8GRJvcSrmcBVAH43oyWjpfSWxrEuzXwam702IFGYh4d/IQZIsxyEzEhhRMRF1
	 pvHl0HR4AXGlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] rust: driver: store pointers in `DeviceId`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260618-id_info-v1-7-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-7-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:08 +0000
Message-Id: <20260619170508.8E9351F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Arbitrary Memory Dereference / Privilege Escalation via PCI dy=
namic IDs (`new_id`)
- [High] Undefined Behavior via unconditional null reference creation when =
`driver_data` is 0
--

commit 01871465d12a97f7be006ca329ebda24f458cf1e
Author: Gary Guo <gary@garyguo.net>

rust: driver: store pointers in `DeviceId`

This commit changes Rust device IDs to store pointers directly in the
driver_data field, matching the behavior of C drivers. It works around
the limitation of missing provenance during const evaluation by wrapping
raw IDs in MaybeUninit.

> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index 84852a2d9ad78..59453588df0e7 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
[ ... ]
> @@ -47,15 +50,48 @@ pub unsafe trait RawDeviceIdIndex: RawDeviceId {
>      /// The offset (in bytes) to the context/data field in the raw devic=
e ID.
>      const DRIVER_DATA_OFFSET: usize;
> =20
> -    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor of t=
he [`RawDeviceIdIndex`]
> -    /// trait.
> -    fn index(&self) -> usize;
> +    /// Obtain the data pointer stored inside the device ID.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `&Self` must be stored inside a `IdArray<Self, U>`.
> +    unsafe fn info_unchecked<U>(&self) -> &'static U {
> +        // SAFETY: By safety requirement of the trait, this is `self.dri=
ver_data as *const U` and by
> +        // the safety requirement of the function, this is stored in `Id=
Array<Self, U>` so is
> +        // convertible to `&'static U`.
> +        unsafe {
> +            core::ptr::from_ref(self)
> +                .byte_add(Self::DRIVER_DATA_OFFSET)
> +                .cast::<&U>()
> +                .read()
> +        }
> +    }

[Severity: High]
Does this code create an unconditional null reference in Rust if the
driver_data or driver_info field is 0?

Creating a null reference is immediate undefined behavior in Rust, even for
zero-sized types. This 0 value can occur in paths like:

1. IdArray::new_without_index() leaving driver_data fields as 0.

2. When userspace adds a dynamic USB ID via the sysfs new_id interface using
fewer than 5 fields (omitting refVendor), USB core initializes driver_info
to 0.

[ ... ]
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index a3dd48f763532..a630c7fc6a853 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
[ ... ]
> @@ -110,10 +110,13 @@ extern "C" fn probe_callback(
>          // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `st=
ruct pci_device_id` and
>          // does not add additional invariants, so it's safe to transmute.
>          let id =3D unsafe { &*id.cast::<DeviceId>() };
> -        let info =3D T::ID_TABLE.info(id.index());
> +
> +        // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArr=
ay<_, T::IdInfo>` or
> +        // `pci_device_id_any` which has 0 as driver_data.
> +        let info =3D unsafe { id.info_unchecked_opt::<T::IdInfo>() };

[Severity: Critical]
Can this allow an arbitrary memory dereference or bypass kernel lockdown?

The PCI subsystem supports dynamic IDs via the sysfs new_id interface
(drivers/pci/pci-driver.c), which parses up to 7 arguments, the last being
driver_data (%lx).

This allows a privileged user (root) to supply an arbitrary pointer value.
The code here will blindly cast this integer to an Option<&'static U> via
info_unchecked_opt() and dereference it if non-zero, allowing arbitrary
kernel memory access.

[ ... ]
> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 500b5e0ba4ea9..8aeff50117552 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
[ ... ]
> @@ -89,7 +89,8 @@ extern "C" fn probe_callback(
>              // does not add additional invariants, so it's safe to trans=
mute.
>              let id =3D unsafe { &*id.cast::<DeviceId>() };
> =20
> -            let info =3D T::ID_TABLE.info(id.index());
> +            // SAFETY: `id` comes from `T::ID_TABLE` which is of type `I=
dArray<_, T::IdInfo>`.
> +            let info =3D unsafe { id.info_unchecked::<T::IdInfo>() };
>              let data =3D T::probe(intf, id, info);

[Severity: High]
Does this code trigger undefined behavior when the underlying USB device ID
driver_info field is 0?

When the id is constructed using IdArray::new_without_index() or when
dynamically added via sysfs new_id with fewer fields, the driver_info is 0.

This probe unconditionally expects a valid non-null reference and creates
one even for 0-initialized IDs via info_unchecked().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D7
