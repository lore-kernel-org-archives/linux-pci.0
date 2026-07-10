Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC53C378D
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719571; cv=none; b=IaHy09/8TQgTLT+TgmPbunQSLk3e5Nm1auurV77s4opAWcmbCXQvVraecvZ52mj26CxOnsaXxWuOM4OxVJyPI8IeVBWuAnRws2UKsIOvSfnJ1hehQZ48XQJXlEhhXqPeFZaJXVrQQJcPSSkXzV5cOlVGIDiUBOUzlmQH15fz+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719571; c=relaxed/simple;
	bh=75cmGHYnpFYMpW9irmEdEerij6PXrMiA7Hh+JLSyYj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uETfBC28tSX7Mshw+eQFIC6t9o+rr3ph0J/P8x3eAsl2sPtTqQgWhuSFn/rDcXk1oMaqyrBrrTPkDKuql3+bM+uc6wBU4Lk7C3Q8F5CyBjPuM/J4YoJ/caSRXpYJczZlLvdR4TMjCgY0mLXyy8vIAjVFY6/BbI0PBV+bAAhsxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOf8DPaZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOf8DPaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE11F0155B;
	Fri, 10 Jul 2026 21:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719569;
	bh=9Rekjd5ER0+q0cGcx5XTo1G3MLwQgAJL0FUgYgPhMZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XOf8DPaZcwkCr1dQm5wvd7VM14OnWuGjOeKkG8ml3KL2S1glIfVhR1N9Yh8bahxns
	 weXFXhsmyOXVS4KF1ebvNV6KAj6ypDlQI8uiRM0VwggRtyU7yIOrjP1XkDgc8WLROB
	 v1md22VQH1BVUxX8E8G2qP31mBbM8N6WGIkgYjEsFVD6DvQ57At81wxBwU3RPNE8+p
	 5CXrXl29Tv/PFefYhmNcVvcPFM97HKnDblD+scOQEkG3Mm2eQrrqA8OcaDamNkxIse
	 370i88G7M4Tq1WmhXWFZI0F3MuLEcrfAFvfrV3B5BHLDYCvCNy9ZXd9MuUCelCtZcA
	 bRjUAOtdRoVgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-4-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:39:28 +0000
Message-Id: <20260710213928.E7CE11F0155B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] pci_liveupdate_finish_device() incorrectly aborts if refcount !=3D=
 1, completely breaking the preservation lifecycle for parent bridges and l=
eaking their FLB references.
- [Medium] `pci_liveupdate_cleanup_device()` fails to clear `dev_ser->refco=
unt`, leading to state contamination for subsequently hot-plugged devices.
- [Medium] Memory allocated for incoming preserved PCI devices (the KHO blo=
ck set) is leaked in `pci_flb_retrieve()` if `kzalloc_obj()` fails.
--

--- Patch [3]: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved P=
CI devices ---
commit 4fcd6c9f661309adcb1a2b891b9c5a34af9e319f
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track incoming preserved PCI devices

This patch adds support to the PCI core for tracking preserved PCI devices=
=20
across Live Update. It introduces pci_liveupdate_setup_device() to fetch=20
serialized state from the Live Update Orchestrator and exposes APIs for=20
drivers to notify the PCI core when preservation is finished.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 03075ce06ac98..df6a02240aa47 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> @@ -138,13 +172,58 @@ static void pci_flb_unpreserve(struct liveupdate_fl=
b_op_args *args)
> =20
>  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
>  {
> -	args->obj =3D phys_to_virt(args->data);
> +	struct pci_ser *ser =3D phys_to_virt(args->data);
> +	struct pci_flb_incoming *incoming;
> +	struct pci_dev_ser *dev_ser;
> +	struct kho_block_set_it it;
> +	int ret =3D -ENOMEM;
> +
> +	incoming =3D kzalloc_obj(*incoming);
> +	if (!incoming)
> +		goto err_restore_free;

[ ... ]

> +err_block_set_destroy:
> +	kho_block_set_destroy(&incoming->block_set);
> +err_free_incoming:
> +	xa_destroy(&incoming->xa);
> +	kfree(incoming);
> +err_restore_free:
> +	kho_restore_free(ser);
> +	return ret;
>  }

[Severity: Medium]
If kzalloc_obj() fails, the code jumps to err_restore_free and calls
kho_restore_free(ser).

Because the underlying memory pages backing ser->devices (the KHO block set)
have not been restored or explicitly freed, does this error path permanently
leak the memory reserved for the block set?

[ ... ]

> @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)

[ ... ]

> +void pci_liveupdate_setup_device(struct pci_dev *dev)
> +{

[ ... ]

> +	dev_ser =3D xa_load(&incoming->xa, key);
> +
> +	/*
> +	 * This device was not preserved across Live Update, or it was preserved
> +	 * but has already been probed and gone through pci_liveupdate_finish(),
> +	 * e.g. due to removing and re-adding the device. Either way, it's not
> +	 * treated as incoming-preserved.
> +	 */
> +	if (!dev_ser || !dev_ser->refcount) {
> +		pci_liveupdate_flb_put_incoming();
> +		return;
> +	}

[ ... ]

>  void pci_liveupdate_cleanup_device(struct pci_dev *dev)
>  {
>  	/*
> @@ -309,7 +469,83 @@ void pci_liveupdate_cleanup_device(struct pci_dev *d=
ev)
>  	 */
>  	if (READ_ONCE(dev->liveupdate.outgoing))
>  		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> +
> +	if (READ_ONCE(dev->liveupdate.incoming)) {
> +		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
> +		pci_liveupdate_flb_put_incoming();
> +	}
>  }

[Severity: Medium]
In pci_liveupdate_cleanup_device(), the FLB reference is dropped but=20
dev_ser->refcount is left unmodified.

If a preserved device is removed or destroyed before its driver calls=20
pci_liveupdate_finish() (for instance, if probe fails), and a new device
is subsequently hot-plugged at the same BDF, won't pci_liveupdate_setup_dev=
ice()
see the stale dev_ser with a non-zero refcount and incorrectly associate th=
e=20
new device with the stale preserved state?

> +static void pci_liveupdate_finish_device(struct pci_ser *ser, struct pci=
_dev *dev)
> +{
> +	if (!dev->liveupdate.incoming) {
> +		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> +		return;
> +	}
> +
> +	if (dev->liveupdate.incoming->refcount !=3D 1) {
> +		pci_WARN(dev, 1, "Preserved device has a corrupted refcount!\n");
> +		return;
> +	}

[Severity: High]
Is this strict refcount !=3D 1 check correct for PCI bridges?

Looking at the outgoing path in pci_liveupdate_preserve_device_again(), a=20
bridge legitimately has its refcount incremented for each preserved downstr=
eam=20
device, making it greater than 1.

When the bridge driver calls pci_liveupdate_finish() on the incoming side,=
=20
won't this check fail, abort the finish process, and permanently leak the=20
FLB reference for the bridge?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D3
