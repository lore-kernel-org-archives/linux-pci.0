Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3531AF2D;
	Tue, 21 Jul 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651721; cv=none; b=V2qMdHN4r3HKSPeZfUYTOJtNiavkcJX/qru0T4OkVtyCGImySroJreH9FR5ffzwlrr4iJxCtWQ0DgOaOwHWNh3v5Cx3aYnM33edGmZU3jGEPornbNHbss2qTSVcu5asHQwhzGcwSKgkTLDQI2hnWOUCOnIL/bTu6KJf6CEwcvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651721; c=relaxed/simple;
	bh=+KZSjNPt/1kWi094Mh+9hEuSBOE5JfIOMbc/56OP3gY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lF1IwrpvRFB0ePpAmj+Vq4Qxat9O6Qf0mJ0ZebdgkyzciCBp19LbK8sE1FyC7DmCj7bEWbYjPSZTnoYpijT00H7vFG5FTfKNSUX/ay6YDaAeLAVYwemxzl65r5dbDPso0+pyXYVWABcIkvWsFnC8uZvppQ22hVo1U+U0eNnD4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrLwnM8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrLwnM8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F151F00A3A;
	Tue, 21 Jul 2026 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651720;
	bh=J7ISZrXmh9xdNQ57F4vycXxEdHSoP2KSWwUq7fQh+Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OrLwnM8xA6VNALfVIGXqCDI+dWDm7ZKBjik66mDfgV9fodrlQSnkWaDKKOnh01A4z
	 2Yf2xGyzTyDr9Y/8IyhISkYU6PkWNnCNBjKNagNPcZlqnA/C46bIpKZxD3WYmFtvcg
	 ByAXCrShop+qkqKrdcYvk1LEBp0C83mPqx13msh1IjsviiKdb6VLDkW/jFrcbIf3Mc
	 g7syA658TAZ3iquH7KvWUCVSFsnlYZhPzS70mXDF5SmmSasb3tileA9tLXhKNcpwvd
	 kq/psVurj0hBSvCPtioSxqvbqYndTSWQhgqCI9dU1auFm8R5htGS1FUrvt7qouM2Hw
	 ljcyd0p/5XQew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] dmaengine: ioat: disable relaxed ordering
 before registering the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260721155739.62120-10-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:35:19 +0000
Message-Id: <20260721163519.D1F151F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in interrupt handler due to devres and manual memor=
y management mismatch on probe error path.
- [High] PCI MSI/MSI-X vectors are leaked on probe failure and device remov=
al.
- [High] IDA allocation nodes are permanently leaked in the dmaengine core =
when `dma_async_device_register` partially fails.
--

--- Patch [9]: [PATCH v2 09/11] dmaengine: ioat: disable relaxed ordering b=
efore registering the device ---
commit 0ad76783c9aa39fb6b36953c767e2a29d68490df
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: ioat: disable relaxed ordering before registering the device

ioat3_dma_probe() disabled PCIe relaxed ordering after calling
dma_async_device_register(), so if an error occurs and the code jumps
to err_disable_interrupts, the function returns with the device still
registered. Move the capability read/write ahead of
dma_async_device_register() instead.

Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 737496391109e..a57024c4b066e 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -1170,15 +1170,6 @@ static int ioat3_dma_probe(struct ioatdma_device *=
ioat_dma, int dca)
[ ... ]
>  	/* disable relaxed ordering */
>  	err =3D pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
>  	if (err) {
> @@ -1194,6 +1185,15 @@ static int ioat3_dma_probe(struct ioatdma_device *=
ioat_dma, int dca)
>  		goto err_disable_interrupts;
>  	}

[Severity: High]
This is a pre-existing issue, but can we hit a use-after-free if this error
path is taken?

If ioat3_dma_probe() fails here and jumps to err_disable_interrupts, the
driver returns an error to ioat_pci_probe(). ioat_pci_probe() then manually
frees the device and its channels:

drivers/dma/ioat/init.c:ioat_pci_probe() {
    ...
		for (i =3D 0; i < IOAT_MAX_CHANS; i++)
			kfree(device->idx[i]);
		kfree(device);
    ...
}

However, the interrupt handler was registered with devm_request_irq()
earlier in ioat_dma_setup_interrupts():

    err =3D devm_request_irq(dev, pdev->irq, ioat_dma_do_interrupt,
			   IRQF_SHARED, "ioat-intx", ioat_dma);

Since devres callbacks only execute after ioat_pci_probe() completes, the
shared IRQ remains active while the memory is freed.

If another device triggers a shared interrupt during this window, wouldn't
ioat_dma_do_interrupt() dereference the freed device pointer?

drivers/dma/ioat/dma.c:ioat_dma_do_interrupt() {
    struct ioatdma_device *instance =3D data;
    ...
    intrctrl =3D readb(instance->reg_base + IOAT_INTRCTRL_OFFSET);
    ...
}

[Severity: High]
This is another pre-existing issue, but does this probe error path leak
PCI MSI/MSI-X vectors?

The driver allocates vectors using pci_enable_msix_exact() or
pci_enable_msi() in ioat_dma_setup_interrupts(), but it doesn't appear
that either err_disable_interrupts or the device unbind function
ioat_dma_remove() ever calls pci_disable_msi() or pci_disable_msix() to
release them:

drivers/dma/ioat/init.c:ioat_dma_remove() {
	struct dma_device *dma =3D &ioat_dma->dma_dev;

	ioat_disable_interrupts(ioat_dma);
	ioat_kobject_del(ioat_dma);
	dma_async_device_unregister(dma);
}

Could this lead to resource exhaustion if the device is repeatedly unbound
or fails probe?

> +	err =3D dma_async_device_register(&ioat_dma->dma_dev);
> +	if (err)
> +		goto err_disable_interrupts;

[Severity: High]
This isn't a bug introduced by this patch, but does the dmaengine core leak
IDA allocation nodes when dma_async_device_register() partially fails?

If channel registration succeeds for at least one channel but fails later,
the code jumps to the err_out label. Because device->chancnt is non-zero,
it skips freeing the global dma_ida:

drivers/dma/dmaengine.c:dma_async_device_register() {
    ...
err_out:
	/* if we never registered a channel just release the idr */
	if (!device->chancnt) {
		ida_free(&dma_ida, device->dev_id);
		return rc;
	}
    ...
}

It then loops over the channels to unregister them, but fails to call
ida_free() to release the individual channel IDs allocated from
device->chan_ida:

	list_for_each_entry(chan, &device->channels, device_node) {
		if (chan->local =3D=3D NULL)
			continue;
		mutex_lock(&dma_list_mutex);
		chan->dev->chan =3D NULL;
		mutex_unlock(&dma_list_mutex);
		device_unregister(&chan->dev->device);
		free_percpu(chan->local);
	}

Would this permanently leak IDA structures and IDs for any DMA driver
failing partially during registration?

> +
> +	ioat_kobject_add(ioat_dma, &ioat_ktype);
> +
> +	if (dca)
> +		ioat_dma->dca =3D ioat_dca_init(pdev, ioat_dma->reg_base);
> +
>  	if (ioat_dma->cap & IOAT_CAP_DPS)
>  		writeb(ioat_pending_level + 1,
>  		       ioat_dma->reg_base + IOAT_PREFETCH_LIMIT_OFFSET);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D9
