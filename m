Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D32EEE76;
	Mon, 31 Aug 2026 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216629; cv=none; b=t568W/mUB0yd9sVa9tNJWX0WWMoQzhPOb5b2o15ArW7+ebH6O42V3+9h8HmBfkD+b308EO7jk/iWqxcdoEpRI90yD365x8pJjY+Mw24rxUOmkSx5P7LPPwA9h2D6xSinbyD9P18Gtd6NjBfdSmjq5MnpqEtHs1V50R93N3nqXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216629; c=relaxed/simple;
	bh=uveMO3+C2Eu4PkKQ7BijaP721tcaey5Q6y+/NvRAbiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uJvRnzPHaHwG+YOd4h2IpXIFAQ85VSJFf+c/3ZbO0aqgKGX2m7saV5DoWCxKNb85Dkdw9B213GLcVT87qx/acxNCFvUOOEBi/D+ryjUFx9wvnpbBKYAdGXcdcczUqA9kidB1CROt7ac2FDqNY2XTqBBMsuBFAJzxiOBBvSQdqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfmRmlzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfmRmlzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C782E1F000E9;
	Mon, 31 Aug 2026 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216626;
	bh=bHzzKL8igDHzV5B8l83Vzi3U1M8j8hR6lSDXOjMgMhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UfmRmlzPY5ZUWZXTx33zP3RNnjBJQfem2Orhn2M1opAVRbP5gPvypcz0slxEe6mAl
	 ChXEd6vADt//7sDa/YjHaQoAF+Y9TF6EZo3XQ+wZv/e5e9XnFsrKhF7spDyYQKISQ2
	 6OW7PUIALYidU7S9NfH/8JglMtQHejcS50OFygTaSIs0GPjCJF6lyIAWi4tBE0D+4X
	 0oSldEfGEgEHve/iEp7Hoi2U74m5ijXD6281FlVxC+rUHGPUOC/7ata8n+/8RB7RJp
	 5A8V2oq9AiepvnZNp+eI1w9luuCTVVolqlb0OpBJpxkeBHkQruQu3S3QzjoERGxaCM
	 IWbH9BiXCwjxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/12] dmaengine: switchtec-dma: disable channels
 before freeing on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260831191403.207631-9-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:50:25 +0000
Message-Id: <20260831225025.C782E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing check for ioremap failure in switchtec_dma_create() leads =
to NULL pointer dereference.
- [High] The channel status IRQ handler dereferences uninitialized structur=
es if the IRQ fires before dma_async_device_register() completes.
- [High] Missing bounds check on untrusted `chan_cnt` read from the PCI dev=
ice allows out-of-bounds MMIO pointer arithmetic and memory writes.
--

commit 9d90eebe0f109c6aab9cf75114365b10451e1028
Author: Logan Gunthorpe <logang@deltatee.com>
Subject: dmaengine: switchtec-dma: disable channels before freeing on regis=
tration failure

When switchtec_dma_create() fails after channels have been added to
dma_dev->channels, the channel status IRQ is still live while the channels
are released and freed. Add switchtec_dma_chans_disable() to free the
channel status IRQ before releasing and freeing channels in both error path=
s.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

>  	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
>  				 pci_resource_len(pdev, 0));
> =20
>  	RCU_INIT_POINTER(swdma_dev->pdev, pdev);
> =20
>  	nr_vecs =3D pci_msix_vec_count(pdev);
>  	rc =3D pci_alloc_irq_vectors(pdev, nr_vecs, nr_vecs, PCI_IRQ_MSIX);
>  	if (rc < 0)
>  		goto err_exit;
> =20
>  	irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);

[Severity: High]
This is a pre-existing issue, but does this code cause a NULL pointer
dereference if ioremap() fails? The swdma_dev->bar pointer does not appear
to be checked before being unconditionally dereferenced by readw() during
device probe.

>  	pci_dbg(pdev, "Channel pause irq vector %d\n", irq);
> =20
>  	rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
>  			     swdma_dev, KBUILD_MODNAME);
>  	if (rc)
>  		goto err_exit;

[Severity: High]
This is a pre-existing issue, but does this request the IRQ too early? If
the hardware asserts the IRQ immediately, the ISR will run before the
channels are fully initialized.

Looking at switchtec_dma_chan_status_isr():

	list_for_each_entry(chan, &dma_dev->channels, device_node) {
		swdma_chan =3D container_of(chan, struct switchtec_dma_chan,
					  dma_chan);
		chan_dev =3D &swdma_chan->dma_chan.dev->device;
		chan_hw =3D swdma_chan->mmio_chan_hw;

Could this dereference an invalid pointer if the channels list is empty or
if chan->dev is not yet initialized by dma_async_device_register()?

>  	swdma_dev->chan_status_irq =3D irq;
> =20
>  	chan_cnt =3D readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);
>  	if (!chan_cnt) {
>  		pci_err(pdev, "No channel configured.\n");
>  		rc =3D -ENXIO;
>  		goto err_exit;
>  	}
> =20
>  	chan_cnt =3D switchtec_dma_chans_enumerate(swdma_dev, pdev, chan_cnt);

[Severity: High]
This is a pre-existing issue, but is there a missing upper bounds check on
chan_cnt? Since chan_cnt is read directly from hardware, an untrusted
device could provide a very large count.

In switchtec_dma_chan_init(), this unvalidated count is used for pointer
arithmetic:

	swdma_chan->mmio_chan_fw =3D
		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET +
		i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;
	swdma_chan->mmio_chan_hw =3D
		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET +
		i * SWITCHTEC_DMA_CHAN_HW_REGS_SIZE;

Could this allow out-of-bounds MMIO pointer arithmetic and memory writes
outside the valid bar resource window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D8
