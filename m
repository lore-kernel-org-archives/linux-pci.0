Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8893B9D8D;
	Mon, 31 Aug 2026 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217497; cv=none; b=SAb1wzoP+ZFnVNtmJHbJPeUU0/2x762xxlGZ/Zz+e7tjxW/Zcb/g/WGKkoSd/kK7DOX4KFgHet+M4LFdWOsOuVjxFogQkmvS84MyHXNpjpidxvx9oCSJswwPhw429ArkvoeyA8LEEUJ0tzpZO3kcu8u2t6lqZHQxSQAQcRW3GiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217497; c=relaxed/simple;
	bh=zFn3sacvL994e76huu+2BmBE+SmbtkrxIUr7ZLUK3mg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EulTnf2Wv2Ofvwcxx5++zPtVOvqeaoW5U2NUJ4QM6HGf+LmrpiXLtfw8RXjCGtXk7y8+f/WveDFcqHZTMret+LFwpsREOYHuBC/yk+8FL7oqjJjvNMbnUTGqRfQAuTum7QPMOL8JsRAn+tqe03VbF9Pw84ezAnYBgwFiLVsglf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2vGEafy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2vGEafy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435CE1F000E9;
	Mon, 31 Aug 2026 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217495;
	bh=r/wA+VqYT4GnBkpCImpXsmx3+t9g2Nun1y5ThcTmVRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2vGEafyLjWrrlaCzGaa30n0OvEH99/knrFja1ae9WKY3j2D4jh1XCOtuB8cX7V8k
	 l9dR03zFpbb5i3HC7YCWOyrJP+gM7tEbjgE88prrYlV8hAbKMMMZbHFtSxTxMcvK+N
	 36E0vEz+IeUo013r9Uak5+YmHMFxFlbJH45NqtYLnTWIQsNGWnwASQUPQi8LVST6HP
	 tympJOta+C1p2wLNbI1hJdasrxfoUySl458vdarpx52VjfyIn4t+VP8wu7nmLN6Ymp
	 XNSMwZUeE3tqE5souHZpdj9EoQk+ih1+mDkmeP06O77nX8N3Q54ETjdiU3FqCJvyBj
	 cvrCA2F75ItSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/12] dmaengine: switchtec-dma: fix use-after-free
 of swdma_dev in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260831191403.207631-10-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:04:54 +0000
Message-Id: <20260831230455.435CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DMA descriptor memory and coherent allocations are permanently lea=
ked when channels are released or allocation fails after the PCI device is =
hot-removed.
- [High] Missing NULL check for ioremap return value can lead to a NULL poi=
nter dereference.
- [High] Tearing down hardware state before RCU synchronization allows conc=
urrent DMA submissions to trigger hardware faults.
- [High] Missing validation of hardware-provided chan_cnt against the mappe=
d BAR length.
--

commit 0f74dee750d8feb49b287883e72b10e222134798
Author: Logan Gunthorpe <logang@deltatee.com>
Subject: dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remov=
e()

dma_async_device_unregister() can drop the last reference on dma_dev and fr=
ee
swdma_dev synchronously. This patch caches the bar locally before unregiste=
ring
to avoid a use-after-free during iounmap().

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index c2803af6589d4..3b4ec4ad2bbe9 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1393,6 +1393,7 @@ static int switchtec_dma_probe(struct pci_dev *pdev,
>  static void switchtec_dma_remove(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev =3D pci_get_drvdata(pdev);
> +	void __iomem *bar =3D swdma_dev->bar;
> =20
>  	switchtec_dma_chans_release(pdev, swdma_dev);

[Severity: High]
This is a pre-existing issue, but does tearing down the hardware channels h=
ere
before RCU synchronization leave a window for concurrent submissions to tri=
gger
hardware faults?

If switchtec_dma_chans_release() zeroes the DMA base registers (via
switchtec_dma_chan_stop()), this happens before swdma_dev->pdev is cleared =
and
before dma_async_device_unregister() removes the channels from use.

Could a concurrent client in switchtec_dma_issue_pending() check that
pdev !=3D NULL under rcu_read_lock(), and write to the sq_tail register?

switchtec_dma_issue_pending() {
    ...
    spin_lock_bh(&swdma_chan->submit_lock);
    writew(swdma_chan->head, &swdma_chan->mmio_chan_hw->sq_tail);
    spin_unlock_bh(&swdma_chan->submit_lock);
    ...
}

Would this instruct the hardware to fetch descriptors from the now-zeroed b=
ase
address, causing DMA or IOMMU faults?

[ ... ]

> @@ -1405,7 +1406,7 @@ static void switchtec_dma_remove(struct pci_dev *pd=
ev)
> =20
>  	dma_async_device_unregister(&swdma_dev->dma_dev);
> =20
> -	iounmap(swdma_dev->bar);
> +	iounmap(bar);
>  	pci_release_mem_regions(pdev);
>  	pci_disable_device(pdev);
>  }

While reviewing this driver, I noticed a few other pre-existing issues.

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling in
switchtec_dma_free_chan_resources() and switchtec_dma_alloc_chan_resources()
permanently leak DMA descriptor memory and coherent allocations?

If the PCI device is hot-unplugged, switchtec_dma_chan_stop() can return
-ENODEV. In switchtec_dma_free_chan_resources(), the code conditionally ski=
ps
freeing the descriptors:

    if (!rc)
        switchtec_dma_free_desc(swdma_chan);

A similar early return exists in switchtec_dma_alloc_chan_resources():

    if (switchtec_dma_chan_stop(swdma_chan)) {
        disable_channel(swdma_chan);
        return rc;
    }

Do these paths leave the hardware queues (hw_sq and hw_cq) permanently leak=
ed
when allocating or releasing channels after the device is removed?

[Severity: High]
This is a pre-existing issue, but is there a missing check for ioremap()
failures in switchtec_dma_create()?

    swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
                             pci_resource_len(pdev, 0));

Shortly after, the bar pointer is unconditionally dereferenced:

    irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);

Could this cause a kernel oops during device initialization if ioremap() fa=
ils?

[Severity: High]
This isn't a bug introduced by this patch, but does the driver validate the
hardware-provided channel count against the mapped BAR size?

In switchtec_dma_create(), chan_cnt is read directly from hardware:

    chan_cnt =3D readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);

Later, in switchtec_dma_chan_init(), this untrusted count is used for point=
er
arithmetic to calculate the MMIO pointers:

    swdma_chan->mmio_chan_fw =3D
        swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET +
        i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;

Could a malicious or malfunctioning PCIe endpoint supply an arbitrarily lar=
ge
chan_cnt, leading to out-of-bounds MMIO accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D9
