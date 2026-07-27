Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118B42B75D;
	Mon, 27 Jul 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177628; cv=none; b=AuqNTT/Uc5L+uvDCFJRtYYXbr1yKo/+hdT/KdoNagWED2LHyzc3Ta1Qzzxc8BjSy+dxkkMIxh76s5tn0E0Z5uvtv7Pmt9IB2R1Swj2lxtLiMZpj4bIPgpkcRgnmXBSIRJ6NPUtZ7X4M49YaKRDDcEQQYLlr6W0/mWz85aqBz+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177628; c=relaxed/simple;
	bh=SWZ0wBRYO5KL6drp6UnZ0JHniIjYp8h47MyPCkKKBes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TvlNtD6GBoZLl5nsfY/OF36m2LCT1/tqYfBPVTW3urO5H3y9+DDIDTJMpJYpDwQXOZMCFLVX21sPg3meUJm1foMlqiwqZ9OA1plPNVlR8X/Xcm9RGf+tPoVjbJh11aUat3cIsNvcE8IeYxPtcFwOrotrL/9btvU3N0IeQY4c+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHMn66MZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHMn66MZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B021F000E9;
	Mon, 27 Jul 2026 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177624;
	bh=ulZstPb4tCmDbOc8de37xNuClYx3rOb+IYMaL3mPFGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHMn66MZYxLWbqxajH4xiF87oq/DJABl+yfyLduCJvGNubugYl4YKYy6L3iYLsBE5
	 iWGqITn5nERlPt+xReNekMxVbxKE9Q9aRIWaTOaNCvABZ3ueFtbtEn0PXtTsAZ4iAV
	 MaVnnCMkZy8M9wFK1WtoT7rBamwKZxQiBd/uyJR9xPPWl+Hne5OaKUC74fpr/Wkatq
	 /8i4T/k77nUqodup44F1rBqLYpYR+tYgtzWMlM+lpoAPdJdbo/u5tCpv3cy+DvuzSP
	 6HlDAMo0gZ4Og/1h6uAQ1g/UQnGTbePs4vbISK/tcXgZAsUWmx24jLsxTqG05xxSuf
	 BfBT8oO5hT+6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/11] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260727181526.9672-3-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:40:23 +0000
Message-Id: <20260727184023.B9B021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] DMA use-after-free due to missing channel halt in the allocation e=
rror path.

Pre-existing issues:
- [High] Race condition in driver teardown leading to MMIO use-after-free a=
nd kernel oops.
--

--- Patch [2]: [PATCH v3 02/11] dmaengine: switchtec-dma: fix resource leak=
 in alloc_chan_resources ---
commit d5306db114dcdc27e3a80dfb2bb3a42a91ab9a3a
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources

This commit fixes a resource leak in switchtec_dma_alloc_chan_resources
by adding an error-unwind path. The new path disables the channel, clears
the active flags, and frees the descriptor rings if an allocation fails.

Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.ke=
rnel.org
Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initiali=
zation and cleanup")

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index a4a7d66d042de..f77da31aeb65e 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -1029,6 +1030,20 @@ static int switchtec_dma_alloc_chan_resources(stru=
ct dma_chan *chan)
>  		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
> =20
>  	return SWITCHTEC_DMA_SQ_SIZE;
> +
> +err_ring_inactive:
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->ring_active =3D false;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active =3D false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +err_disable_channel:
> +	disable_channel(swdma_chan);
> +err_free_desc:
> +	switchtec_dma_free_desc(swdma_chan);

[Severity: High]
If an error occurs in switchtec_dma_alloc_chan_resources() after
unhalt_channel() succeeds (for example, if the RCU pointer check fails),
the unwind path jumps to err_ring_inactive and falls through to
err_disable_channel.

Since disable_channel() only clears a software configuration bit and does
not explicitly issue a hardware halt command or wait for the hardware to
stop processing, could the hardware channel continue performing DMA accesse=
s?

If so, does calling switchtec_dma_free_desc() immediately after
disable_channel() create a window for a DMA use-after-free, where the device
can still read or write into the newly freed coherent memory pages?

> +	return rc;
>  }

[Severity: High]
This is a pre-existing issue, but looking at the driver teardown sequence
in switchtec_dma_remove():

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
    ...
    switchtec_dma_chans_release(pdev, swdma_dev);
    rcu_assign_pointer(swdma_dev->pdev, NULL);
    synchronize_rcu();
    pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
    pci_free_irq_vectors(pdev);
    dma_async_device_unregister(&swdma_dev->dma_dev);
    iounmap(swdma_dev->bar);
    ...
}

Because the resources and MMIO regions are dismantled before the device is
unregistered from the dmaengine core, is it possible for a concurrent
client to call dma_request_chan() and allocate a channel during this window?

If a concurrent allocation finishes right after the channel was freed,
could the client attempt to submit a DMA operation and trigger a kernel
oops when accessing the unmapped MMIO registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D2
