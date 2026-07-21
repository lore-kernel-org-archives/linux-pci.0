Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015646D2BC;
	Tue, 21 Jul 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651303; cv=none; b=W8RvCOmkJ7KxEXbvTslkIffhBpjQazDv4kd6Z3OFPiI7Nx5uq8R2XfKmagG5yFvjSfe3df6Rj0Lsk6UUM/Sw4Thq2nN0ogSB5Fm2HVini7AGNjjzhlDgdLpVHRFFagm0tk12vsTIvQNbI3xzAORsI5s4UVgOk+ESA6L3IOj2ZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651303; c=relaxed/simple;
	bh=DOdFlPvpvG/wl5i9jSC9cPQm5wCPAL1kcwhxH8OjDMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SR7TAWfbpY6H0o3Ow7hRzvjfFXiYxV0LKX/qu7tT966CJL7fz6z7jZkcBLmfiObEdHYxaLi4hc/3mpTB02mWlgt3BJCFGFuS8VPG9GHZBjXeogFxs6UKBxdJzAJEebFbT9lwE7ele3V9Co/sSWxXMMIixaNVR+YfYgrP5A7YuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZEy5MkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZEy5MkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CDD1F000E9;
	Tue, 21 Jul 2026 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651302;
	bh=MA2cEAJJP2EkL3EzgISTR5qCnpYJe1zrbDHDxYvAjYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZEy5MkHHsouT8FvTXyO4BbhBu1t3dSIjtmUqvXT+YCwcY4FEKXzewjqkJMyX1ZhF
	 8p/pgAEdQ9PN3Ji4ViqaOySbBDUreBTdScY/Ydm6hS3eOccZqjWsj+ocOp45wTaTnj
	 nFdm156Ghphr+ZXWkebSPeD+TvvkOVIlYkr8ybNHqPc7krWOyN58MSie7tLeAju8f1
	 7Go0emMYSbAD7hrsj1XjQ5e2SlVNYVk0vv3vcYD4m0a+KiGJiU3OmtbZg6FvNvQtQW
	 NqjPjWkOnpN4sDmwE1DFrXWYVNobRE0vuvymu4ui8wdMd5gIyODG56114MXM+qa+o+
	 OGGfYuUpQAixA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] dmaengine: switchtec-dma: unlink channels
 before freeing on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260721155739.62120-7-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:28:21 +0000
Message-Id: <20260721162822.05CDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a data race by calling `list_del()` concurren=
tly with the active interrupt handler, resulting in a poisoned list pointer=
 dereference.

Pre-existing issues:
- [High] The channel status IRQ is requested prematurely before the `dma->c=
hannels` list and `chan->dev` are fully initialized, causing NULL pointer d=
ereferences in the ISR.
- [High] The error path in `switchtec_dma_create()` incorrectly uses `free_=
irq()` with an MSI-X vector index instead of `pci_free_irq()`, and fails to=
 free vector index 0.
- [High] The number of DMA channels is read directly from an untrusted hard=
ware register and used without bounds validation, leading to out-of-bounds =
MMIO accesses.
--

--- Patch [6]: [PATCH v2 06/11] dmaengine: switchtec-dma: unlink channels b=
efore freeing on registration failure ---
commit 304c38996e78423c61828786ab626c7f864c96fd
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: unlink channels before freeing on registration fa=
ilure

When switchtec_dma_create() fails after channels have been added to
dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
error path, or from dma_async_device_register() failing), the channels
are released and freed but never removed from dma_dev->channels.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index c752a1b05871d..2a1ae27bd1a69 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1184,6 +1184,14 @@ static void switchtec_dma_chans_free(struct switch=
tec_dma_dev *swdma_dev)
>  	kfree(swdma_dev->swdma_chans);
>  }
> =20
> +static void switchtec_dma_chans_unlist(struct switchtec_dma_dev *swdma_d=
ev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < swdma_dev->chan_cnt; i++)
> +		list_del(&swdma_dev->swdma_chans[i]->dma_chan.device_node);
> +}
> +

[Severity: High]
Could this regression introduce a data race?

In switchtec_dma_create(), the error paths call switchtec_dma_chans_unlist()
while the channel status irq is still active. If an interrupt fires
concurrently, switchtec_dma_chan_status_isr() will traverse the
dma_dev->channels list locklessly using list_for_each_entry().

Can the isr traverse into the poisoned pointer from list_del() and crash
the system if it runs during or after this call? Should the irq be freed
or disabled before cleaning up the channels?

>  static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma=
_dev,
>  					 struct pci_dev *pdev, int chan_cnt)

[ ... ]

> @@ -1318,6 +1327,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	return 0;
> =20
>  err_chans_release_exit:
> +	switchtec_dma_chans_unlist(swdma_dev);
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>  	switchtec_dma_chans_free(swdma_dev);
> =20

[Severity: High]
This is a pre-existing issue, but is the channel status irq requested
prematurely in switchtec_dma_create()?

The irq is requested via pci_request_irq() before
switchtec_dma_chans_enumerate() is called and before the dma->channels list
is fully initialized.

If an interrupt fires immediately, switchtec_dma_chan_status_isr() will ite=
rate
over an uninitialized list. Furthermore, the isr accesses chan->dev, which
is not set until dma_async_device_register() runs much later. Could this
cause a null pointer dereference?

[Severity: High]
This is a pre-existing issue, but does the error path in switchtec_dma_crea=
te()
fail to cleanly release the irq?

The code checks if swdma_dev->chan_status_irq is valid and calls free_irq().
If the vector index is 0, the check skips freeing, leaking the irq.
Additionally, if it is greater than 0, it passes the msi-x vector index
to free_irq() instead of the global linux irq number, which fails to free i=
t.

If switchtec_dma_create() fails and swdma_dev is freed via kfree(), could a
subsequent interrupt execute the active isr and access the freed swdma_dev,
causing a use-after-free?

[Severity: High]
This is a pre-existing issue, but does switchtec_dma_create() read the chan=
nel
count without upper bounds validation?

The chan_cnt is read directly from the hardware register.
During enumeration in switchtec_dma_chan_init(), pointer arithmetic is
performed based on this count:

swdma_chan->mmio_chan_fw =3D swdma_dev->bar + offset + i * size;

If chan_cnt is excessively large due to untrusted or malfunctioning hardware
input, could this pointer extend beyond the bounds of the mapped pci bar
and cause an out-of-bounds mmio access when dereferenced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D6
