Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E743304A;
	Mon, 27 Jul 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176860; cv=none; b=s3KLGvOIdZx5/fza0hqxnzT7MvPbz2g4TME4FdN2vk+1IURAJHGzOgxso7f7F6NxJWjYwfIvTLkCKnfWJ4DSmj0MDiQfKVG6QCD890s4g/cDj94ayyGbiJm1FxUtBpi1/D9YfaHbQJsQ8ab+Q0s3benufwHNRTaSlJG/BEjQix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176860; c=relaxed/simple;
	bh=hXjplXvVBYj7dQNhI7tpFJA6kJ90fuqMxZ9YlSJH7pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/XMq5oXtjKcMSJVfOjs+U6B9/U+wNxD5JLq3Ls/Bb74QbFL5IrHzkuLsMQNGuZqM5LtrLzilyURVDJxyTk0vhusOrPpgJicceps3fd+efRI+6J/JzsPq+iPJI7Uk+toY/a3mNdo2MNl5/TODoL6kRRpm83RIyepUjd3Zh1D9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx1sw0/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx1sw0/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BAF1F000E9;
	Mon, 27 Jul 2026 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176859;
	bh=+1thKsWL94V66UI62EgvWNyo53hfFdqxuXNOzRHwrbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xx1sw0/B1kSIi4p63TuJdI+gm+W/MGeLRhlqz9HwbMwGDyGMsK1oSxz1+hwBzyrmg
	 NKcPnn/MM18PaE2IvcmkEbPt6rNTBVrY0gnrgIPlBuxd8MLsLumIkaA8NZQePXJHhc
	 AQvLP9l6J4iTaH36TaACQ+qNvj8kqZQUyQ7WC1g19cxNH/zYncBIx8y7cIpHK5H8eH
	 s9mlJtPbh6eysi8VuL8rZLz7X3zu9ThF+ItlimEcnCBNpjGY/xnYWOgXTFP72m2Mhw
	 cbBsXgIQMjo0eQm7q6/LMuOmt4cMQ9rxqvPiLSW0oasT2LtGC7ydvU7smCNSX4Xkp1
	 5OEtjqybwA1AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/6] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260727174837.6645-4-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
 <20260727174837.6645-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:27:38 +0000
Message-Id: <20260727182738.D7BAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a Use-After-Free in the error path by freeing=
 swdma_chan structures while the global chan_status_irq is still registered=
 and active.

Pre-existing issues:
- [High] Use-after-free on swdma_dev during device removal.
- [High] Preexisting Use-After-Free on dma_async_device_register() failure =
due to chan->dev being freed while the IRQ is active.
- [High] Failure of ioremap() is not checked, leading to an immediate null =
pointer dereference.
- [Medium] Leaked channel structures during partial enumeration failure in =
switchtec_dma_chans_enumerate().
- [Medium] Missing put_device() for the DMA parent device on dma_async_devi=
ce_register() failure.
--

--- Patch [3]: [PATCH v1 3/6] dmaengine: switchtec-dma: fix channel leak on=
 registration failure ---
commit 7464b8c763dc5bb4e72b11ab5698233a70070171
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix channel leak on registration failure

If dma_async_device_register() fails during probe,
switchtec_dma_chans_release() only stops hardware and frees IRQs and
tasklets; it never frees the per-channel swdma_chan structures or the
swdma_chans array itself.

[ ... ]

Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.ke=
rnel.org/T/#u

> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -1317,6 +1317,11 @@ static int switchtec_dma_create(struct pci_dev *pd=
ev)
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> =20
> +	for (i =3D 0; i < swdma_dev->chan_cnt; i++)
> +		kfree(swdma_dev->swdma_chans[i]);
> +

[Severity: High]
Could this newly introduced kfree() loop cause a use-after-free?

Since chan_status_irq is registered earlier and remains active until
free_irq() is called in the err_exit block below, an interrupt could fire
while this error path is executing.

If the status interrupt fires after these structures are freed,
switchtec_dma_chan_status_isr() will iterate over dma_dev->channels and
dereference the freed swdma_chan structures.

Should the IRQ be freed, or the channels removed from the list, before we
free this memory?

> +	kfree(swdma_dev->swdma_chans);
> +
>  err_exit:
>  	if (swdma_dev->chan_status_irq)
>  		free_irq(swdma_dev->chan_status_irq, swdma_dev);


While reviewing this patch, I also noticed a few pre-existing issues in
this driver:

[Severity: Medium]
This is a pre-existing issue, but does switchtec_dma_chans_enumerate()
leak memory on its error path?

If switchtec_dma_chan_init() fails, the error handling cleans up the array
but does not appear to free the individual swdma_chan elements:

drivers/dma/switchtec_dma.c:switchtec_dma_chans_enumerate() {
    ...
	for (i =3D 0; i < chan_cnt; i++)
		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);

	kfree(swdma_dev->swdma_chans);
    ...
}

Since switchtec_dma_chan_free() only disables hardware and frees IRQs,
the memory allocated for the channel structures via kzalloc_obj() seems
to be permanently leaked here.


[Severity: Medium]
This isn't a bug introduced by this patch, but is there a reference leak if
dma_async_device_register() fails in switchtec_dma_create()?

The driver acquires a reference to the parent PCI device:

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
	dma->dev =3D get_device(&pdev->dev);
    ...
}

If registration fails and the code jumps to err_chans_release_exit,
swdma_dev is eventually freed without calling put_device(dma->dev).
Because the device failed registration, its release callback isn't
invoked, which appears to leave the parent PCI device reference leaked.


[Severity: High]
This is a pre-existing issue, but can switchtec_dma_remove() trigger a
use-after-free when unmapping the bar?

When unregistering the DMA device, if there are no outstanding channel
references, the core synchronously invokes the release callback
(switchtec_dma_release) which frees swdma_dev.

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
    ...
	dma_async_device_unregister(&swdma_dev->dma_dev);

	iounmap(swdma_dev->bar);
    ...
}

Since iounmap() dereferences swdma_dev->bar immediately after the
unregister call may have freed swdma_dev, could this lead to a crash
during device removal?


[Severity: High]
This isn't a bug introduced by this patch, but is there another
use-after-free risk during dma_async_device_register() failure?

If registration fails after partially registering channels, the DMA core
automatically frees the chan->dev structures via device_unregister().

Because chan_status_irq remains active at this point, a spurious or
concurrent interrupt can fire:

drivers/dma/switchtec_dma.c:switchtec_dma_chan_status_isr() {
    ...
	chan_dev =3D &swdma_chan->dma_chan.dev->device;
    ...
}

This unconditionally dereferences the core-freed chan->dev structure.
Could this cause a crash if the interrupt fires before free_irq() is
reached in the error path?


[Severity: High]
This is a pre-existing issue, but does switchtec_dma_create() safely
handle ioremap() failures?

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
				 pci_resource_len(pdev, 0));
    ...
	irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
    ...
}

Since ioremap() can return null, skipping a validation check here
seems to guarantee a null pointer dereference on the very next readw()
if the mapping fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727174837.6645=
-1-logang@deltatee.com?part=3D3
