Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC373624D7
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484415; cv=none; b=HzifUp+GhDVUNzhm3rVujJoVAod1bBWZeNpqxLZ0wKx/YgONGdK9pLJIzYeU7olja8iGFEHwvqvMNVhfjna9DfgP6gkoDoSpSCRp9XffP/GEyHGI/NGd6rYe/w/7885Z0ILHBUuEhD2P7MYR4y9tb7lVmm3CIEN/7revwNxVpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484415; c=relaxed/simple;
	bh=D9rB5wBO5F/15BfNAH6dSUzTUgASExNceTSrH6tjFaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fh7q+70ui4RLJG1pX0HT99NuhMnzuA/Esa6SxdjVF3hJeQFgOh4aIkt4RDVoWAWp+M4m+N1ZHASe9SIzShIdbJoJsDs0xs8gpgoK0DHPPDubaktSfSfk6wvk9H2tfLXuxDSAKfV6yAtPpqmwGza8oxsfTRWcD24RcsE7yYlKMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6N2i9Yu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6N2i9Yu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56A21F000E9;
	Fri, 22 May 2026 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779484414;
	bh=xJe2n+VsGYd7lbAaCBnui4drGRhkK/9bDRhR7fEnvcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6N2i9YuigIds//vmuLWdAaSb5TU+DY1AM3p2SH376fCEHC7uxDaZ58VOsfGqTufQ
	 tupn2yCYgBDcX4/gWbANBJIsPDBjPLIdFN2pEf7cFmpnYbAUHTNXJxEV5miiY70Yi9
	 YXvyaGL/+9dp6F0oIJCKcBNworKAOUYYYB0WeyST9+VedBKTpmAVn516TjpG1R6oWZ
	 C4laFwShhAtajoYm/8Maor30LIyul7B/7kfdJkj9x0/afIu70OOPlQmTKECjgUsveL
	 B5hn3Lw1VmI3+IdpXC0fF7Qf0YX/2wqnoxAmvO+12Xw6WbsHkL172f+LktMTITBc3U
	 Xl+K6O5XBQDmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522202410.3104264-4-dmatlack@google.com>
References: <20260522202410.3104264-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 21:13:33 +0000
Message-Id: <20260522211333.D56A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] pci_flb_retrieve() frees the incoming preserved memory (ser) o=
n failure, causing a Use-After-Free when the core retries.
- [Medium] Leaked reference to the incoming FLB when a device's preserved r=
efcount is corrupted.
--

commit 5af02c95c00f317cc5c4fa203b8b79373f2759a5
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track incoming preserved PCI devices

During PCI enumeration, the PCI core fetches serialized state from the
Live Update Orchestrator to identify incoming preserved devices. This
patch adds tracking and lifecycle management APIs for these devices.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 065d5af822f74..96c43b84532cc 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> @@ -128,13 +157,49 @@ static void pci_flb_unpreserve(struct liveupdate_fl=
b_op_args *args)
> =20
>  static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
>  {
> -	args->obj =3D phys_to_virt(args->data);
> +	struct pci_ser *ser =3D phys_to_virt(args->data);
> +	struct pci_flb_incoming *incoming;
> +	int ret =3D -ENOMEM;
> +	u32 i;
> +
> +	incoming =3D kmalloc_obj(*incoming);
> +	if (!incoming)
> +		goto err_restore_free;
> +
> +	incoming->ser =3D ser;
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
> +		ret =3D xa_insert(&incoming->xa, key, dev_ser, GFP_KERNEL);
> +		if (ret)
> +			goto err_xa_destroy;
> +	}
> +
> +	args->obj =3D incoming;
>  	return 0;
> +
> +err_xa_destroy:
> +	xa_destroy(&incoming->xa);
> +	kfree(incoming);
> +err_restore_free:
> +	kho_restore_free(ser);

[Severity: Critical]
Does this error path create a use-after-free if the retrieval is retried?

If pci_flb_retrieve() fails here (e.g. from -ENOMEM), kho_restore_free()
frees the preserved physical memory for the incoming state. However, the
Live Update Orchestrator propagates this error without marking the FLB
as retrieved or finished.

When the next PCI device is enumerated, pci_liveupdate_setup_device()
calls pci_liveupdate_flb_get_incoming() again, which invokes
pci_flb_retrieve() a second time with the exact same data address. The
function will then attempt to read incoming->ser->max_nr_devices from
memory that was already freed.

> +	return ret;
>  }
[ ... ]
> @@ -280,7 +430,83 @@ void pci_liveupdate_cleanup_device(struct pci_dev *d=
ev)
>  		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
>  		pci_liveupdate_unpreserve(dev);
>  	}
> +
> +	if (READ_ONCE(dev->liveupdate.incoming)) {
> +		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");
> +		pci_liveupdate_finish(dev);
> +	}
> +}
> +
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

[Severity: Medium]
Can this early return leak a reference to the incoming FLB?

In pci_liveupdate_setup_device(), a reference is held to protect
dev->liveupdate.incoming. This reference is expected to be released via
pci_liveupdate_flb_put_incoming() at the end of this function.

By returning early here when the refcount is corrupted, we skip the put
call, leaking the reference. Furthermore, dev->liveupdate.incoming is left
non-NULL, which means pci_liveupdate_cleanup_device() might later try to
finish it again and hit this same leak. Should this error path drop the
reference and clear the incoming pointer?

> +	}
> +
> +	/*
> +	 * Drop the refcount so this device does not get treated as an incoming
> +	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> +	 * again because the device is hot-plugged.
> +	 */
> +	dev->liveupdate.incoming->refcount =3D 0;
> +
> +	pci_info(dev, "Device is finished participating in Live Update\n");
> +	dev->liveupdate.incoming =3D NULL;
> +	ser->nr_devices--;
> +	pci_liveupdate_flb_put_incoming();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522202410.3104=
264-1-dmatlack@google.com?part=3D3
