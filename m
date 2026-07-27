Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E03D301F;
	Mon, 27 Jul 2026 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181943; cv=none; b=LMcxZA/7lCvicvqJJWxpcBo/Qky02Qk4TL48WgnKeWORkAbWLOmf1ZIXpq79FhG5tEN6nM5oO8APpICd51R+iqQrkOn/HBH2POvfQkc1mQ+jZpnIe4XBwMH8Qn34AvWU/sg/NJapG9ooG/DD6tPZzv3ciXUx4GEBH3/y6RpiVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181943; c=relaxed/simple;
	bh=mdgvFA3F0fkGRGRfkPOi/WGcSY7PnBWSaaFb08FOU88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hJ2ZpGsKpRi/opHlokk0Pw/JffNtS59V0BHHgIR9KdZ3ADVOZw3vBC46jWGhuMmjECFSELOM1W2PpvTZk6fzjA2UQ+AEGJSY/4bc7eiH4XzgKPhZTedEfVXSIN4cZK7sgfxSyGOQcoUIQ1jhn7BJAVgWYEofRAZpEmipoi3Fcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUG5yc7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUG5yc7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64181F000E9;
	Mon, 27 Jul 2026 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181942;
	bh=pA/Hm5el/ygEdVb3CVc9MntJJauvaEDr67lQlX0i+iY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OUG5yc7MuqqTDLGA2zjruLOITgeWCW1fcgICdkNDNHoeBOBtGMedRaNeWtA8eHkO5
	 g/NqBy+IKHp6tXqf9dOCXgs8SgXte6aTYBA3Dolxwx1DcuDLWh3gYYH2HgPVyFCexy
	 EAu9JvBbrVo1F4jV34d7UjjJeZjZywTqZ3436mnT3t3ZPJe3DCiHAu59MyjXjVtRld
	 TZViOdrS+FMS0Tsc0/VfuEjitCwot+6ICm/ttDLgE+TJA3WCL7QSdDKpMJDSxoshRB
	 KYy6iUWTe8QLRtCZhDqJK/9T1Oy+bDg8He1iHkjdCW8ZkSN/uauXG9DPcdB9vV96lZ
	 eQU6NewxcwG5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/11] dmaengine: switchtec-dma: fix use-after-free
 of swdma_dev in remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260727181526.9672-9-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:52:21 +0000
Message-Id: <20260727195221.C64181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing check for ioremap() failure in switchtec_dma_create() can =
cause a null pointer dereference.
- [High] Client callbacks are invoked while holding the channel's `complete=
_lock`, leading to a self-deadlock if the callback calls DMA engine APIs.
- [High] The channel status IRQ is requested before the `dma_dev->channels`=
 list is initialized, which will cause a NULL pointer dereference if an int=
errupt fires early.
--

--- Patch [8]: [PATCH v3 08/11] dmaengine: switchtec-dma: fix use-after-fre=
e of swdma_dev in remove() ---
commit 29e71ea6cf1f57028cf682c7cc5c705361a852e2
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix use-after-free of swdma_dev in remove()

This commit fixes a use-after-free of swdma_dev in switchtec_dma_remove().
It caches the bar variable locally before calling
dma_async_device_unregister(), which can synchronously free swdma_dev.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 800d8ecd07171..d73506b5cabc1 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does switchtec_dma_create()
check if ioremap() fails?

If ioremap() fails due to resource exhaustion, it returns NULL. The code
appears to immediately dereference this pointer:

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
    swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0),
                             pci_resource_len(pdev, 0));
    ...
    irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
    ...
}

Can this lead to a NULL pointer dereference during device probe?

[Severity: High]
This is a pre-existing issue, but does the driver hold complete_lock while
invoking client callbacks?

In switchtec_dma_cleanup_completed(), the lock is acquired:

drivers/dma/switchtec_dma.c:switchtec_dma_cleanup_completed() {
    spin_lock_bh(&swdma_chan->complete_lock);
    ...
    dmaengine_desc_get_callback_invoke(&desc->txd, &res);
    ...
}

The same pattern appears in switchtec_dma_abort_desc().

If the client callback calls back into the DMA engine API (such as=20
dmaengine_terminate_all()), could this cause a self-deadlock when the=20
driver attempts to acquire complete_lock again?

[Severity: High]
This is a pre-existing issue, but is it safe to request the channel status
IRQ before the channels list is initialized?

In switchtec_dma_create(), pci_request_irq() is called before the channel
list is populated:

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
    rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
                         swdma_dev, KBUILD_MODNAME);
    ...
    chan_cnt =3D switchtec_dma_chans_enumerate(swdma_dev, pdev, chan_cnt);
    ...
}

If an interrupt fires early, switchtec_dma_chan_status_isr() will iterate
over the uninitialized dma_dev->channels list:

drivers/dma/switchtec_dma.c:switchtec_dma_chan_status_isr() {
    ...
    list_for_each_entry(chan, &dma_dev->channels, device_node) {
    ...
}

Could this loop dereference a NULL pointer and crash if the list head is
completely zeroed before initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D8
