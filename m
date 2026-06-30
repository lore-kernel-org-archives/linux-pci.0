Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D073FBEC1;
	Tue, 30 Jun 2026 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823221; cv=none; b=KROR7hMr+QKdH2KQ2iEeAJ27j5eRQDDOw+7hlP/TlFbmOsLkinbT0dD7gfWfUlI7McjXsLZpgy9OnzGaf1nXlwbY0omSbk1oGmnepdVnYCBCjC1Aj9EMyGnFMoKcTiWL1LA+CaYen49h6ivyxuz+7EznbThxzIC5Qg0XQfv0Kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823221; c=relaxed/simple;
	bh=8sNsw41PkD3N6zA23RSeUreJrB4fPSibzTFMlnU35YI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=krTFiFpyOZmxIX2TO2oqQg+h2kS9UWv90H5iXGkVztbPY7NUrYjVh4jaBn+DtS55OlclAjaU/xGbex+/gtoM29BueYMYHf7pnppjuXcnoK6W0Efyie2plyjdc2bCT+cacHRxinOBNNuWYEaAnNVcPedNmH3NDOdPejUTnI55nN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqPN9YGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqPN9YGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FB71F000E9;
	Tue, 30 Jun 2026 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782823220;
	bh=S1DnQyBgzb1XI1kGhjTusFOlx5+UmQmiUDOy0vN2jHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bqPN9YGR8KLS61tKar5wTD2JnP+3vZIApKgJHTSLVUZ37NDCklX8DStKxK35yOaeG
	 aqZGreDrYQTutpvIJp1iWRXRVxC1WSwysTDmZg6aJYDvucP0CooZbk6JAmYCzo1ECz
	 /7Oo2mO5XMMWqCy7DbzobMPkpSBw1acmyBkNlItfZlhP+196K4euKhKtKAVyBx4yH+
	 92nM6DctnBfbo2dSlSlaCjQTJLOI3A30BenjcTj4yJWyen4dFI/1rpoo3Mfy90gA/e
	 SDmfkmUGvbuxNDacdUKJtOgZEcREaJw4W+aXgI1YpA9qckuzAYIusJo/U/dTcEX9FP
	 LwpZlAl3NucJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] rust: driver: store pointers in `DeviceId`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, robh@kernel.org
In-Reply-To: <20260629-id_info-v2-8-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-8-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:19 +0000
Message-Id: <20260630124019.A2FB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Undefined Behavior (null reference creation) due to uninitialized =
`driver_data` in `IdArray::new_without_index`.

Pre-existing issues:
- [High] Use-After-Free in PCI and USB subsystem cores due to TOCTOU race c=
ondition when matching dynamic IDs.
--

commit 6b9468ff67342f4c1fd6f7bf72f1fef7fa35aa2e
Author: Gary Guo <gary@garyguo.net>

rust: driver: store pointers in DeviceId
   =20
The common practice in C drivers is to store pointers into driver_data
field of device IDs. The Rust code is however currently storing indices
into the fields and then carry a side table that maps the index to
pointers.

[ ... ]

> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index 022f0101871f5..50d82bfca9b8c 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs

[ ... ]

> @@ -133,7 +160,7 @@ impl<T: RawDeviceId, const N: usize> IdArray<T, (), N=
> {
>      /// If the device implements [`RawDeviceIdIndex`], consider using [`=
IdArray::new`] instead.
>      pub const fn new_without_index(ids: [T; N]) -> Self {
>          // SAFETY: `T` is layout-wise compatible with `T::RawType`, so i=
s the array of them.
> -        let raw_ids: [T::RawType; N] =3D unsafe { core::mem::transmute_c=
opy(&ids) };
> +        let raw_ids: [MaybeUninit<T::RawType>; N] =3D unsafe { core::mem=
::transmute_copy(&ids) };

[Severity: High]
If a driver uses the @none branch in macros like i2c_device_table! or
auxiliary_device_table!, it expands to IdArray::new_without_index().
Does this leave the driver_data field uninitialized (0)?

When the device probes, the framework calls info_unchecked::<()>() on the
matching ID, which unconditionally reads the 0 from driver_data and casts it
to a &() reference:

device_id.rs:info_unchecked() {
    unsafe {
        core::ptr::from_ref(self)
            .byte_add(Self::DRIVER_DATA_OFFSET)
            .cast::<&U>()
            .read()
    }
}

Will this cause Undefined Behavior by creating a null reference, even for
zero-sized types like ()?

[ ... ]

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index a3dd48f763532..925cf280dae2a 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -110,10 +110,14 @@ extern "C" fn probe_callback(
>          // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `st=
ruct pci_device_id` and
>          // does not add additional invariants, so it's safe to transmute.
>          let id =3D unsafe { &*id.cast::<DeviceId>() };
> -        let info =3D T::ID_TABLE.info(id.index());
> +
> +        // SAFETY: `id` comes from `T::ID_TABLE` which is of type `IdArr=
ay<_, T::IdInfo>` or
> +        // `pci_device_id_any` which has 0 as driver_data. It can also c=
ome from dynamic IDs, which
> +        // will ensure that `driver_data` exists in `T::ID_TABLE`.
> +        let info =3D unsafe { id.info_unchecked_opt::<T::IdInfo>() };

[Severity: High]
This is a pre-existing issue, but does this dereference a potentially freed
id pointer if there is a concurrent sysfs write to remove_id?

In the C PCI core, pci_match_device() searches the dynamic ID list under
dynids.lock. When a match is found, it drops the lock and returns a raw
pointer to the pci_device_id embedded within the dynid structure:

drivers/pci/pci-driver.c:pci_match_device() {
    spin_lock(&drv->dynids.lock);
    list_for_each_entry(dynid, &drv->dynids.list, node) {
        if (pci_match_one_device(&dynid->id, dev)) {
            found_id =3D &dynid->id;
            break;
        }
    }
    spin_unlock(&drv->dynids.lock);

    if (found_id)
        return found_id;
}

If a concurrent sysfs write to remove_id occurs, it unlinks and frees
the dynid:

drivers/pci/pci-driver.c:remove_id_store() {
    list_del(&dynid->node);
    kfree(dynid);
}

Since the lock is released before pci_match_device() returns, could this
leave the found_id pointer unprotected and lead to a Use-After-Free when
the probe callback dereferences it here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D8
