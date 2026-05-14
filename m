Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3A4C92
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720719; cv=none; b=bvffcfRPZDG5415VQ+qZkVrI4w/jtmUnGQWAsi8WqSmVj8PimuiK8ig9GBcbewtOQogHhKCyY+BBK/uyR7c9Z4AlptYGG47On0zbAppFdQ8Lnl/zSR17hGflfLCHe0h4rbNBBd8BXVeZaOHl02Ls0nogv7wHkzFg2+kT+QDsPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720719; c=relaxed/simple;
	bh=AaTJu0h4iMP9Wu+mIfUq1thBcoVtjiVeyAfWO/GDy0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xm0sIJhjd/I+B31Chs8IiD2ndob9LOEOgBiRj8Ne39mUHyvhriqHgq4lAqSIHSHISMx2WcUVktLefmWOdhI5Zjd2mfzI7W1xOgL/CfD+eU73wsMCTRyqG7pQK2CPjE2FaGGpHwh8/OCFXmqMevsbujzrsQvFyyey5qbas63HAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn5CoVnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn5CoVnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B41C19425;
	Thu, 14 May 2026 01:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720718;
	bh=AaTJu0h4iMP9Wu+mIfUq1thBcoVtjiVeyAfWO/GDy0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Dn5CoVnx0+kinw8zHBALH0rA8hH7hYlkyoCip1wRIGPh8QAutQSb74W/J3pwR5Ll9
	 6TRrV6AxMRb1WULx6w811JOSvoXqwbSA3jMyENURBY7Q7aIW5lymT8tdM3RpBsk6LW
	 QGER8MQ1JYrD1LtTuSgRpb+1Up1FMIyJs+iLPAMycOA1kV1FXYkoYYEx+Gpmawdu+a
	 P3+7yPxoGtaKe56uyMAu+BIPYUxiXuyUES3qWNmUC/oGA3l3P3eh3PSO41M13rQIqh
	 MhlBs/1iA5Rrh08+JQ8UJVmpt+c7WSQpb6ZwrHsCspW7ijULoBPO2yrc8Js3M8q8N4
	 JRWdAlHxamD7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/11] PCI: liveupdate: Track incoming preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184846.119396-4-dmatlack@google.com>
References: <20260512184846.119396-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:05:18 +0000
Message-Id: <20260514010518.B0B41C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Integer truncation in `pci_ser_xa_key()` drops the upper 16 bits o=
f the PCI domain.
- [High] Memory leak of KHO-preserved physical pages in the error path of `=
pci_flb_retrieve()`.
- [High] Subsystem guide violation: `pci_flb_preserve()` calls a KHO serial=
ization API without checking `kho_is_enabled()`.
- [High] Data corruption in `pci_liveupdate_unpreserve()` due to decrementi=
ng `ser->nr_devices` without compacting the array.
- [High] Use-after-free risk because `pci_flb_unpreserve()` leaves dangling=
 pointers in `dev->liveupdate.outgoing`.
- [High] `pci_liveupdate_finish()` calls `pci_liveupdate_flb_put_incoming()=
` under a write lock, risking a sleep-in-atomic bug.
--

commit 46fdddc110c525ef02301643989348b7f03a10c0
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track incoming preserved PCI devices

This commit adds support for tracking pci devices preserved across a kexec
via live update. It introduces setup and cleanup hooks for the pci core to
manage the incoming live update state of these devices.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 9c4582ecd55cc..f14396dd14773 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -85,6 +101,21 @@ struct pci_flb_outgoing {
>  	struct mutex lock;
>  };
> =20
> +/**
> + * struct pci_flb_incoming - Incoming PCI FLB object
> + * @ser: The incoming struct pci_ser from the previous kernel.
> + * @xa: Xarray used to quickly lookup devices in @ser.
> + */
> +struct pci_flb_incoming {
> +	struct pci_ser *ser;
> +	struct xarray xa;
> +};
> +
> +static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
> +{
> +	return domain << 16 | bdf;
> +}

Can this integer shift truncate the upper 16 bits of the pci domain?

Because domain is a u32, the shift expression evaluates as a 32-bit integer.
This discards the upper 16 bits before the result is promoted to the 64-bit
unsigned long return type.

If devices are in domains >=3D 0x10000, this will produce colliding keys,
causing them to overwrite each other in the xarray.

Could this be cast before the shift, such as
((unsigned long)domain << 16) | bdf?

> +
>  static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
>  {
>  	struct pci_flb_outgoing *outgoing;

Does this function need to check kho_is_enabled() before proceeding?

According to the kho subsystem guidelines, all callers of serialization-side
kho APIs (like kho_alloc_preserve() used later in this function) must
gate their usage on kho_is_enabled().

Failing to check the enabled state can cause null pointer dereferences or
silently add useless tracking state that will never be used.

[ ... ]

> @@ -140,13 +171,44 @@ static void pci_flb_unpreserve(struct liveupdate_fl=
b_op_args *args)

Can pci_flb_unpreserve() cause a use-after-free risk by leaving dangling
pointers?

When an outgoing live update is aborted, this function frees the outgoing->=
ser
memory via kho_unpreserve_free(). However, it does not clear the
dev->liveupdate.outgoing pointers in the pci devices that were already
preserved.

If a new live update is initiated and pci_liveupdate_unpreserve() is called
on those devices, it will execute memset(dev_ser, 0, ...) on the dangling
dev->liveupdate.outgoing pointer, corrupting memory.

> =20
>  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
>  {
> -	args->obj =3D phys_to_virt(args->data);
> +	struct pci_flb_incoming *incoming;
> +	int i, ret;
> +
> +	incoming =3D kmalloc_obj(*incoming);
> +	if (!incoming)
> +		return -ENOMEM;
> +
> +	incoming->ser =3D phys_to_virt(args->data);
> +
> +	xa_init(&incoming->xa);
> +
> +	for (i =3D 0; i < incoming->ser->max_nr_devices; i++) {
> +		struct pci_dev_ser *dev_ser =3D &incoming->ser->devices[i];
> +		unsigned long key;
> +
> +		if (!dev_ser->refcount)
> +			continue;
> +
> +		key =3D pci_ser_xa_key(dev_ser->domain, dev_ser->bdf);
> +		ret =3D xa_err(xa_store(&incoming->xa, key, dev_ser, GFP_KERNEL));
> +		if (ret) {
> +			xa_destroy(&incoming->xa);
> +			kfree(incoming);
> +			return ret;
> +		}

Does this error path leak the preserved physical pages?

If xa_store() fails, this returns an error code without calling
kho_restore_free(incoming->ser). Because the function returns an error and
does not populate args->obj, the live update core will not call the .finish
callback to clean up the memory.

[ ... ]

> @@ -268,6 +330,163 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);

Can pci_liveupdate_unpreserve() corrupt the live update tracking state by
leaving holes in the array?

Looking at the body of pci_liveupdate_unpreserve():

drivers/pci/liveupdate.c:pci_liveupdate_unpreserve() {
    ...
    ser->nr_devices--;
    memset(dev_ser, 0, sizeof(*dev_ser));
    ...
}

If a device other than the most recently preserved one is unpreserved, this
leaves a hole in the array and moves the allocation cursor backward.
Subsequent device preservations will overwrite currently preserved, valid
devices at that index.

[ ... ]

> +void pci_liveupdate_finish(struct pci_dev *dev)
> +{
> +	guard(write_lock)(&dev->liveupdate.lock);
> +
> +	if (!dev->liveupdate.incoming) {
> +		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> +		return;
> +	}
> +
> +	pci_info(dev, "Device is finished participating in Live Update\n");
> +
> +	/*
> +	 * Drop the refcount so this device does not get treated as an incoming
> +	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> +	 * again because the device is hot-plugged.
> +	 */
> +	dev->liveupdate.incoming->refcount =3D 0;
> +	dev->liveupdate.incoming =3D NULL;
> +
> +	/* Drop this device's reference on the incoming FLB. */
> +	pci_liveupdate_flb_put_incoming();
> +}

Can calling pci_liveupdate_flb_put_incoming() under a write lock cause a
sleep-in-atomic bug?

This function calls pci_liveupdate_flb_put_incoming() while holding
dev->liveupdate.lock (an rwlock) for writing. If the put function acquires a
sleepable lock internally, calling it from atomic context will trigger a bu=
g.

This contrasts with pci_liveupdate_cleanup_device() which drops the lock
first using scoped_guard().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184846.1193=
96-1-dmatlack@google.com?part=3D3
