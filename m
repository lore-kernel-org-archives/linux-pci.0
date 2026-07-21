Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C672546D2CF;
	Tue, 21 Jul 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651221; cv=none; b=X3SXFEOnhpaDecuC/JYaGIfC6MnskKasiUg2l5vHWN+IS/ysNLpBbrm7PxEq0IGqACQSgen0jugV4ZwJlk21/KOijeU/06HDCdStw5fScoCGUmkIDXFNsNaGJZCeFKLZAWV8AuaXL5UB2G1547BsGHJW/1CNz9FSbWM/2Su3qCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651221; c=relaxed/simple;
	bh=Qdq34i8rFB95Fduwpfhm5M9t3NHM1ZnZNgMkzCqHZlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oJdaDa5V52TP1hOvoQcTLmFdYZaP3fWKvTTMRVOZlSCuwjSMH3U4ZAXxyh7d9C/ToykFGWyempJVZn1a/zKBwq7jm/oBdLoNIVNZptjvzlFzndwuBFqhUnU0SVax62uk/kIfeSGqntkqODAk7tjEMz9f7iD9L3Fdzhyw0JO+vyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC+R5Oi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC+R5Oi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1C1F000E9;
	Tue, 21 Jul 2026 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651220;
	bh=jFgBSKw+4SXhBUmWPByJ4XMMpoqO4Uct7xecDRJM3uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OC+R5Oi3wZy2K6cDgeKvUgCJLCZ2+fih2efKXpuGNN+mHcPEYZOrn/nZFGXhPp5Cn
	 FkyqXuWaXWFx1nxA1jVwjhz6zfq6+wuEdfdOfvYybBZIosLskcpLnxpoML9YQEq4t+
	 3HkPHR/zmq5A3U60fGSyM56EvWwsE21hDoBFRBBYbWsW78I1KqBEuFMLoEBRZAsEta
	 Tf1oaqWMNn/swosv7bp23zWyo4dcRMEg/OUQYja2YIlLxaGmUNlXw3OKBjvvwdqUot
	 3jhHRZPRGNcfdCr9x0tj4M5nMqS6eI1nIPAu2VRw8ViYUaJ2VNHeZYuMvI8ai40ZrS
	 bcLbe0s+CWCNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] dmaengine: switchtec-dma: fix chan_status_irq
 cleanup on create() error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260721155739.62120-9-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:26:59 +0000
Message-Id: <20260721162700.5FC1C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of ioremap is not checked, leading to a guarantee=
d NULL pointer dereference if the mapping fails.
- [High] The IRQ handler is registered and enabled before the DMA channels =
list head is initialized, creating a race condition that can crash the kern=
el.
--

--- Patch [8]: [PATCH v2 08/11] dmaengine: switchtec-dma: fix chan_status_i=
rq cleanup on create() error ---
commit ceb60e37fe28d72b900ae9ddab80b66c36311831
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix chan_status_irq cleanup on create() error

This commit fixes an issue where chan_status_irq was freed with plain
free_irq() instead of pci_free_irq(). It also initializes the irq to -1
to properly track its allocation state.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1257,6 +1257,8 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	if (!swdma_dev)
>  		return -ENOMEM;
> =20
> +	swdma_dev->chan_status_irq =3D -1;
> +
>  	swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
>  				 pci_resource_len(pdev, 0));

[Severity: High]
This is a pre-existing issue, but the return value of ioremap() is not
checked here.

If this allocation fails (e.g., due to exhausted vmalloc space) and returns
NULL, won't this cause a guaranteed NULL pointer dereference when the driver
later calls readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC)?

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a race
condition regarding the IRQ registration in this same function.

Further down in switchtec_dma_create(), the driver registers the IRQ
handler:

	rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
			     swdma_dev, KBUILD_MODNAME);

At this point, the dma_dev->channels list is uninitialized (zero-filled by
kzalloc_obj). The required INIT_LIST_HEAD() is not called until later inside
switchtec_dma_chans_enumerate().

If an interrupt fires immediately after registration, won't the ISR crash
when it iterates over the uninitialized list head?

drivers/dma/switchtec_dma.c:switchtec_dma_chan_status_isr() {
    ...
	list_for_each_entry(chan, &dma_dev->channels, device_node) {
		swdma_chan =3D container_of(chan, struct switchtec_dma_chan,
					  dma_chan);
		chan_dev =3D &swdma_chan->dma_chan.dev->device;
    ...
}

Could the IRQ registration be moved after switchtec_dma_chans_enumerate(),
or the list initialized earlier?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D8
