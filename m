Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62E36D50D;
	Wed,  2 Sep 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331083; cv=none; b=azSlPa6Xg0l7tEtsYPKkMZ3Y7geRgFVlM+0aNOqIV9ZcsqzrK96IkQyU4IzsJt6I7/I+Zjlt8FkfIPxHNFobGXQJO5DVjOHWP2g0RLnuF7eso5oGb9c1UUIzb9YGAtJe4OGwcFFihND0en2spQqvBak7bKtwfUlu6SzGCeAgSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331083; c=relaxed/simple;
	bh=QrVN678zwUy/SDYKdgr+oVvWqDpwe+WR0zF9r1d62lY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaWjIIyPl594QLiEs/xcz1y1mQT+xhptXtlZ8mqX6Zt+X1nlelEjShEijICFQEKWG28C9IcpYyPbyMscLUf28pDU5Z8juvK03TSrYB4JmaJVvaShRkMns74kTpazKXptgflgoluLS5F078APTv+8vGZB8a/TJuo4igXAexqE9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+lxAK/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+lxAK/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F281F000E9;
	Wed,  2 Sep 2026 06:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331082;
	bh=Plvfal94dEfxtcFlElrj0uj6Ul9EyOF6kv5iDE+D54o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G+lxAK/G0Hw5tIbjLf6BpxTQ4dRDVp9SzWZmFZeVFrCP7a9MBWcozbsbR71RsByv+
	 5estYMV3/bmpsmrF659j6oupPjgrDBuBa1ZdnSMwZ6CY89hnSNyLkLF5+EtuiAbbsK
	 LyXWmUlWywnP+yQiEBNn6q9H4Kb8+YG0hkS6b8woaHyMyt5G9vA55MEmdp5MymBmLa
	 +rHAInZnXQBgiFViOtBJMTnKRdWzU5qYbRpcL9CB8vQPQn5QKmfN9Gp3h7RNomZJQe
	 RQTmqjf1zJrGgD1eHSHoSLHn18invAbuSpyNhz+40YyalgQSM2aoq0h1s9hhbVdegs
	 6LbXPQYLSdchg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] dmaengine: switchtec-dma: disable channels
 before freeing on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260902062153.31048-7-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:38:01 +0000
Message-Id: <20260902063801.D8F281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature registration of chan_status_irq allows the ISR to execut=
e before channels are initialized, causing NULL pointer dereferences.
- [High] Missing ioremap() return value check in switchtec_dma_create() can=
 lead to a NULL pointer dereference.
--

commit 5a07655c2107e09316788ad5789b3b1db4682eda
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: disable channels before freeing on registration f=
ailure

This commit addresses an issue in switchtec_dma_create() where an error dur=
ing
or after channel enumeration could leave the channel status IRQ active. It
introduces switchtec_dma_chans_disable() to free the IRQ before channels are
released and freed, preventing the IRQ from firing mid-teardown.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 430b09fa5102e..63f80e2a5b6f4 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
[ ... ]
> @@ -1321,6 +1331,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	return 0;
> =20
>  err_chans_release_exit:

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential NULL
pointer dereference earlier in switchtec_dma_create() in
drivers/dma/switchtec_dma.c.

Can switchtec_dma_create() crash if ioremap() fails? The code maps the PCI =
BAR
but does not check the return value:

	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
				 pci_resource_len(pdev, 0));

If ioremap() returns NULL due to memory exhaustion or an invalid resource, =
the
subsequent readw() will cause a page fault:

	irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);


[Severity: High]
This is a pre-existing issue, but I noticed another problem with the IRQ
registration in switchtec_dma_create() in drivers/dma/switchtec_dma.c.

Could the interrupt fire before the channel list is initialized? The IRQ is
requested and enabled before dma_dev->channels is initialized:

	rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
			     swdma_dev, KBUILD_MODNAME);

If the hardware asserts the interrupt immediately after it is requested,
switchtec_dma_chan_status_isr() will execute and locklessly iterate over the
zero-initialized dma_dev->channels list:

	list_for_each_entry(chan, &dma_dev->channels, device_node) {

This leads to iterating over a negative offset pointer, and reading
swdma_chan->dma_chan.dev will fault. Furthermore, even if the list was
initialized, dma_chan.dev is only allocated later in
dma_async_device_register(), so an early interrupt would still dereference a
NULL dev pointer.

> +	switchtec_dma_chans_disable(pdev, swdma_dev);
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>  	switchtec_dma_chans_free(swdma_dev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D6
