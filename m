Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3A41F7D2
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277379; cv=none; b=c27Ii6PFb4JNL5e05fWWtFijTEepiuoiNrq9NO85mjlOgkosAlTizWOouCPlxG2qPUTv1ixdRwWoS2FJks4FtTE+v2/oQrt8C/8zxxhzZdEZICmu+ckVq3KNwJJz+pdU4DRh7UCR4SBjBS72dHumZlrylDiybg82WF18Mm9aerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277379; c=relaxed/simple;
	bh=LktoWl3EXKKBugwCHiHxNRYYtMxH21gGfVSpBrm9YXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GLt96iqs5Q+LxzFtnrLpepTcDZyOL325bOq/PyTCFHCqQ7p8O/gUfliz33Kppnv6+s1VlKBHEQW9yQQ3E3YKaq+2Hq8D1IlndtRGu+ZcIFuHDCoxR0SlFemjB0GuyqGkKa1d3Se8a+uexkuvvtF0s8Vxh8fXT8/C0XDeLkfM32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlMVCSgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlMVCSgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AD41F000E9;
	Tue, 28 Jul 2026 22:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277377;
	bh=qM4EQKDsnMv1t1iPWC5x9QFp78cOccVC/jKZyAJxHjg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OlMVCSgRcXWxRA8sQTfoQMzMrT6XyDr7wxpsuvlyD2A/LV95DtC3wqqEJYiCtnq/L
	 VIXbN7YIS8/rQ8zPn587cRKu6D7Uf9u/DL+jX/abYDumJVMkBMJQsNqvrXEb/CLd1h
	 5m5BI1G/+iXx+tED3hhl3mbitUdxOgTHKVHvN8WxfTaKTSiHej0cjMA8KdrwpCj+W3
	 0sdhtE1DD1jrJNUbP1y3svlnqjRFCA81DEYBjuNji5VoiR5vZzgoD79EMhC4Hdvw2z
	 CXUeGrQLaD/Q5+vqOVVieNvT9f24xeievKeIpporia/Up8+++GysIaLerDUqSJ/7hV
	 4RVaROPpaLKIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-4-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:22:56 +0000
Message-Id: <20260728222257.56AD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional kernel panic in the incoming FLB finish path if a pr=
eserved PCI device is missing or fails setup.
- [High] `pci_flb_unpreserve()` destroys outgoing FLB memory without cleari=
ng device pointers, leading to a Use-After-Free.
- [High] Transient errors or version mismatches during FLB retrieval cause =
an immediate kernel panic on device setup.
- [Medium] Leaking preserved KHO memory for `ser->devices` on early error p=
aths in `pci_flb_retrieve()`.
--

--- Patch [3]: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved P=
CI devices ---
commit 8fdc703d6dd44076cd03589af0bcffa13c79e7f4
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track incoming preserved PCI devices

This patch allows the PCI core to track incoming preserved PCI devices
during enumeration. It fetches the serialized state from the Live Update
Orchestrator and exposes APIs for drivers to handle incoming devices.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index b003b7069cdb0..5ce5f8b369029 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> @@ -140,15 +174,91 @@ static int pci_flb_retrieve(struct liveupdate_flb_o=
p_args *args)
>  {
> +	struct pci_ser *ser =3D phys_to_virt(args->data);
> +	struct pci_flb_incoming *incoming;
> +	struct pci_dev_ser *dev_ser;
> +	struct kho_block_set_it it;
> +	int ret;
> =20
>  	pr_debug("Retrieving struct pci_ser (0x%llx)\n", args->data);
> -	args->obj =3D phys_to_virt(args->data);
> +
> +	if (ser->version !=3D PCI_LUO_FLB_VERSION) {
> +		pr_err("Incoming PCI FLB version (v%d) is incompatible with this kerne=
l (v%d)\n",
> +		       ser->version, PCI_LUO_FLB_VERSION);
> +		ret =3D -EINVAL;
> +		goto err_restore_free;
> +	}
> +
> +	incoming =3D kzalloc_obj(*incoming);
> +	if (!incoming) {
> +		ret =3D -ENOMEM;
> +		goto err_restore_free;
> +	}
[ ... ]
> +err_restore_free:
> +	kho_restore_free(ser);
> +	return ret;
> +}

[Severity: Medium]
Does this error path leak the KHO memory for ser->devices?

When jumping to err_restore_free (e.g. due to a version mismatch or kzalloc
failure), kho_restore_free(ser) is called, but it doesn't appear to restore
or free the memory pointed to by ser->devices.=20

Since KHO pages are reserved across kexec, will this permanently leak the=20
memory for the uptime of the successor kernel?

[ ... ]
> +static void pci_check_all_devices_finished(struct pci_flb_incoming *inco=
ming)
> +{
> +	struct pci_dev *dev =3D NULL;
> +
> +	if (READ_ONCE(incoming->ser->nr_devices) =3D=3D 0)
> +		return;
> +
> +	for_each_pci_dev(dev) {
> +		if (READ_ONCE(dev->liveupdate.incoming))
> +			pci_emerg(dev, "Preserved device was never finished!\n");
> +	}
> +
> +	/*
> +	 * This should only happen if a driver violated the contract to call
> +	 * pci_liveupdate_finish() (something is extremely broken).
> +	 */
> +	panic("Some preserved devices were never finished!\n");
> +}

[Severity: High]
Is an unconditional panic here safe if a preserved device is missing or
fails to probe?

If a PCI device that was preserved by the previous kernel fails to probe in
the new kernel (e.g. the driver module is missing, or it encounters a
transient error), pci_liveupdate_finish() will never be called and
incoming->ser->nr_devices will not be decremented.

When the Live Update orchestrator concludes the update and calls
pci_flb_finish(), pci_check_all_devices_finished() is invoked and sees
that nr_devices is still > 0. Does this mean normal system conditions like
a missing driver will trigger a kernel panic?

[ ... ]
> @@ -325,6 +435,75 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> =20
> +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> +{
> +	struct pci_flb_incoming *incoming =3D NULL;
> +	int ret;
[ ... ]
> +	/*
> +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> +	 * but retrieve failed (pci_flb_retrieve() returned an error or LUO
> +	 * failed to acquire a reference to pci_liveupdate_flb_ops.owner).
> +	 */
> +	if (ret)
> +		panic("Failed to retrieve incoming FLB data (%d)\n", ret);
> +
> +	return incoming;
> +}

[Severity: High]
Does this panic prevent the new kernel from booting if there's a simple
FLB version mismatch?

During PCI enumeration in the new kernel, pci_setup_device() calls
pci_liveupdate_setup_device(), which invokes
pci_liveupdate_flb_get_incoming().

If pci_flb_retrieve() encounters an error like a version mismatch (-EINVAL)
or an allocation failure (-ENOMEM), it returns that error code. This branch
then catches the error and unconditionally panics. Will this reliably crash
the new kernel during early boot and break the kexec handover fallback
mechanism?

[ ... ]

I also have a question about the unpreserve path in pci_flb_unpreserve()
which might lead to a regression:

drivers/pci/liveupdate.c:pci_flb_unpreserve() {
    ...
    WARN_ON(outgoing->ser->nr_devices);
    kho_block_set_destroy(&outgoing->block_set);
    kho_unpreserve_free(outgoing->ser);
    kfree(outgoing);
}

[Severity: High]
Does pci_flb_unpreserve() destroy outgoing FLB memory without clearing the
device pointers?

If a driver fails to unpreserve its devices before the orchestrator aborts a
Live Update, pci_flb_unpreserve() will issue a WARN_ON but proceed to
destroy the block set and free the outgoing FLB object.

The dev->liveupdate.outgoing pointers on the pci_dev structs are left
dangling. If a new Live Update is subsequently initiated and the driver
attempts to preserve the device again, pci_liveupdate_preserve_device()
will access dev->liveupdate.outgoing->refcount via the dangling pointer:

drivers/pci/liveupdate.c:pci_liveupdate_preserve_device() {
    ...
    if (dev->liveupdate.outgoing) {
        if (!dev->liveupdate.outgoing->refcount) {
    ...
}

Can this lead to a use-after-free of the KHO block set memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D3
