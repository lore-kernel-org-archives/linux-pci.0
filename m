Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CA39FCCC;
	Tue, 28 Jul 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260094; cv=none; b=U5QktWnzpo2RLLdf+20xlrklee0jaOoXgRlejNpX0IddTfXRUZmXXRJkbcH98g23arFS8bN7fja9SvPRYvCXebKHVl+OTkh6jiImlPQiVaJEcYSu2iRRwQ9syedOw1egMF4rUxr9dCfowDe69TD3EwjViPp3MjdcXcei3QHiAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260094; c=relaxed/simple;
	bh=/tMV9qezLKm0mewRhQ9ZP19NHtnoPIz+nKC33N/Fce8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pbUWabqpzl6a62aTa3/+hW7lxkZVVWHs6zL9y0bpy2YAuSndKAWK0YGy827ucmvnFiVeRpm5164wZyKvlea4yFy7t5HRrRSsyM8AzCylgGmg2MdqtM8ypwR0jdnak6HYXqoh0GrZvM2O5gFrzgs87WMgE9e7fGFgZTbb5VaJEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvGf94zd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvGf94zd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1966A1F00A3D;
	Tue, 28 Jul 2026 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260092;
	bh=tzYWv9GOJxYVDDh5waQYavt8nTCe59xdIFd3mMawBSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvGf94zd0jFodBb6kt7Z1J/ZJ3ynhghk6dL9ennL7XGH/6nNsVsoBOi1GrAitbdFX
	 nW2WeTRl46IjH9YYwIRgoGdC8ei22Q35/Roj1dkMeCOLlInCBmTYo7WvdG/jTqI0Hm
	 pDvk9hCY852aAX+MiFRh8xWApVsn2PbFcHK9t9KQPSIQPSRbkkZniKaQG1/R8PWAlR
	 1NeLYoyDRfTTcSTF7wiZ28OBsWYmj/l3nRT+Lg/soYgDOG+n7S7JVmeHXcj4uchrN3
	 PmarEHVKF4dvNrt7bMVNEngrqsFDdieaSM2a+tqUwI493V0iUWotYpeYYVbLggJyZo
	 BKB0RAfIzudQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/12] dmaengine: switchtec-dma: always clear DMA
 base registers on chan_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260728171523.112244-4-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:34:51 +0000
Message-Id: <20260728173452.1966A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unintentional memory leak of DMA descriptor rings during device ho=
t-unplug or driver unbind.
- [High] Zeroing DMA base registers on an unhalted channel directs ongoing =
DMA to physical address 0, causing memory corruption.
--

--- Patch [3]: [PATCH v4 03/12] dmaengine: switchtec-dma: always clear DMA =
base registers on chan_stop() ---
commit ba435d6b93a5b911f612d1880a59068a9e918427
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: always clear DMA base registers on chan_stop()

This patch modifies switchtec_dma_chan_stop() to clear DMA base registers
even if the hardware halt times out. It also updates callers to check the
halt result and skip freeing descriptor rings if the halt was unconfirmed.

Link: https://lore.kernel.org/dmaengine/20260721162531.BA01A1F01560@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index f77da31aeb65e..cbbc9ad082471 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -543,26 +543,33 @@ switchtec_dma_abort_desc(struct switchtec_dma_chan =
*swdma_chan, int force)
>  	spin_unlock_bh(&swdma_chan->complete_lock);
>  }
> =20
> -static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_cha=
n)
> +static int switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
>  {
> +	struct pci_dev *pdev;
>  	int rc;
> =20
>  	rc =3D halt_channel(swdma_chan);
> -	if (rc)
> -		return;
> =20
>  	rcu_read_lock();
> -	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +	pdev =3D rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
>  		rcu_read_unlock();
> -		return;
> +		return rc;
>  	}
> =20
> +	if (rc)
> +		pci_err(pdev,
> +			"Channel %d halt timed out, clearing DMA base registers anyway\n",
> +			swdma_chan->index);
> +
>  	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
>  	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
>  	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
>  	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
> =20
>  	rcu_read_unlock();
> +
> +	return rc;
>  }

[Severity: High]
If the channel failed to halt and is still actively processing transactions,
could writing 0 to the base address registers redirect ongoing DMA to physi=
cal=20
address 0x0?

The commit message states the descriptor rings are intentionally leaked so
the hardware can safely continue to write into them. However, by clearing
the base addresses here while the hardware is active, it appears the active
DMA is instead pointed at address 0x0, which might lead to memory corruptio=
n.

[ ... ]

> @@ -1050,6 +1057,7 @@ static void switchtec_dma_free_chan_resources(struc=
t dma_chan *chan)
>  {
>  	struct switchtec_dma_chan *swdma_chan =3D
>  		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	int rc;
> =20
>  	spin_lock_bh(&swdma_chan->submit_lock);
>  	swdma_chan->ring_active =3D false;
> @@ -1059,9 +1067,10 @@ static void switchtec_dma_free_chan_resources(stru=
ct dma_chan *chan)
>  	swdma_chan->comp_ring_active =3D false;
>  	spin_unlock_bh(&swdma_chan->complete_lock);
> =20
> -	switchtec_dma_chan_stop(swdma_chan);
> +	rc =3D switchtec_dma_chan_stop(swdma_chan);
>  	switchtec_dma_abort_desc(swdma_chan, 0);
> -	switchtec_dma_free_desc(swdma_chan);
> +	if (!rc)
> +		switchtec_dma_free_desc(swdma_chan);
> =20
>  	disable_channel(swdma_chan);
>  }

[Severity: High]
Does this logic skip freeing the descriptor rings during normal device unpl=
ug?

When a device is hot-unplugged and the driver unbinds, swdma_dev->pdev is s=
et
to NULL. This causes halt_channel() and switchtec_dma_chan_stop() to return
-ENODEV.

Because rc is -ENODEV (non-zero) on a standard unplug, the condition if (!r=
c)
evaluates to false. This seems to unintentionally bypass
switchtec_dma_free_desc() and permanently leak the descriptor rings and
coherent memory. A similar bypass happens in the error paths of
switchtec_dma_alloc_chan_resources().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D3
