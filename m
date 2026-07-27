Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96C3CB561;
	Mon, 27 Jul 2026 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785181154; cv=none; b=Atgs3rmYTXwDECtzR/SRLdpSmbywmzajvgOlBJNRbsts78sXhpii8O14ys1z0EeNI8T6/VxHMgrj8x+uuRo4Q7/npmNWYC7oe5KfmeSqt1G4hD8r5EEGg6PjhOWmUTjqluNDrT3nNuEh9kElGs2oBpY7iRn78t9mwfCSWI6m9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785181154; c=relaxed/simple;
	bh=7O+aEQLqEV+gX/mtpoLOi/an81kEAh2hZB+vwCH/2ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mEyqYMoIIGCwANOHVshScXURVk5w5TPfxNsl1AbubDdRFaJLoTUGKLlthydIQGJ4QrLetbBcFxwkTng0MdNrRAGLU3CwcKhB9PWS34udubU9/pnsJFmj8iCucJLIS5RKhHf5D+nke/KPqQGjFbqi/1AAPL0H5HVASg59rle5xKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDduvTcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDduvTcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEF31F000E9;
	Mon, 27 Jul 2026 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785181153;
	bh=SZMI7p2nXhAEg1Iq17RqGoOyuw1AsGJfpmlKqz5i9PA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDduvTcRK7rwQ495yGm7vlvbO+TB92WIldMgru3N/eD+bHqqIbH5GeUJMTNd0Isz3
	 YR9LiqMr3ByNuSimGZFft1w9jGXLcMOq6RymiNioV44hwg85FnF2pEUIVNu+AxWYaP
	 SBA+S0hNYxlit10qfxB6a6iTz2/d8POR0QmKHf2qLd1ad2hvxVJGvQGy+A1ch5Eorp
	 JD+rtctCrWuXdUKiDSWL3cOpXtEex8Wdd/FbCk/SAnPEGtbHCg590gG6fm6SnnA0KY
	 Emb9CHslpFsVHXNNXseF8Y2vpxwNjrmoKVHiDlqOw5I3Jugo55/51vWRjheBnViPQp
	 oq1daSC9wSxGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/11] dmaengine: switchtec-dma: disable channels
 before freeing on registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260727181526.9672-8-logang@deltatee.com>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:39:12 +0000
Message-Id: <20260727193912.AFEF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Accessing `swdma_dev->bar` in `iounmap()` after the structure has =
been kfreed.
- [High] The `chan_status_irq` interrupt is requested before channel initia=
lization is complete, leading to a NULL pointer dereference in the ISR.
- [High] The driver invokes the client's DMA completion callback while hold=
ing the internal `complete_lock` spinlock, creating a self-deadlock risk.
- [High] Missing check on the return value of `ioremap()` leads to a NULL p=
ointer dereference.
--

--- Patch [7]: [PATCH v3 07/11] dmaengine: switchtec-dma: disable channels =
before freeing on registration failure ---
commit eb5cc523afcf50094dfae39f87e70f0557894b90
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: disable channels before freeing on registration f=
ailure

When switchtec_dma_create() fails after channels have been added to
dma_dev->channels (either from switchtec_dma_chans_enumerate()'s own
error path, or from dma_async_device_register() failing), the channels
are released and freed but never removed from dma_dev->channels.

Add switchtec_dma_chans_disable() which disables interrupts and
removes the channels from the list.. Call it before releasing and
freeing channels in both error paths.

Link: https://lore.kernel.org/dmaengine/20260717223431.625EE1F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260721162822.05CDD1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 31feb2816e79b..800d8ecd07171 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -1217,6 +1231,7 @@ static int switchtec_dma_chans_enumerate(struct swi=
tchtec_dma_dev *swdma_dev,
>  	return chan_cnt;
> =20
>  err_exit:
> +	switchtec_dma_chans_disable(pdev, swdma_dev);
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>  	switchtec_dma_chans_free(swdma_dev);
> =20

[Severity: High]
This is a pre-existing issue, but could an early interrupt cause a NULL
pointer dereference here?

In switchtec_dma_create(), pci_request_irq() is called to enable
switchtec_dma_chan_status_isr() before switchtec_dma_chans_enumerate()
is called.

The enumerate function is what initializes the list head:

    INIT_LIST_HEAD(&dma->channels);

If an interrupt fires before the list is initialized, the ISR will execute
list_for_each_entry() over a NULL channels.next pointer.=20

Should the interrupt request be deferred until after the channel enumeration
is complete?

[ ... ]

> @@ -1320,6 +1335,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
>  	return 0;
> =20
>  err_chans_release_exit:
> +	switchtec_dma_chans_disable(pdev, swdma_dev);
>  	switchtec_dma_chans_release(pdev, swdma_dev);
>  	switchtec_dma_chans_free(swdma_dev);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the ioremap call in
switchtec_dma_create() need a return value check?

In switchtec_dma_create(), the BAR is mapped and then immediately used:

switchtec_dma_create() {
    ...
    swdma_dev->bar =3D ioremap(pci_resource_start(pdev, 0), ...);
    ...
    irq =3D readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
}

If ioremap() fails and returns NULL, readw() will dereference it.=20

Should this include an error check before accessing swdma_dev->bar?

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk during
driver unbind?

When switchtec_dma_remove() unregisters the device, it can drop the final
reference:

switchtec_dma_remove()
    dma_async_device_unregister()
        switchtec_dma_release()
            kfree(swdma_dev);

Immediately after dma_async_device_unregister() returns, the remove function
calls iounmap(swdma_dev->bar), dereferencing the freed pointer.=20

Can this cause a kernel panic when the module is removed?

[Severity: High]
This is also a pre-existing issue, but does this locking pattern introduce a
CPU deadlock risk?

In switchtec_dma_cleanup_completed(), a spinlock is held while invoking an
opaque client callback:

switchtec_dma_cleanup_completed()
    spin_lock_bh(&swdma_chan->complete_lock);
    ...
    dmaengine_desc_get_callback_invoke(&desc->txd, &res);

If the client's callback invokes dmaengine_terminate_all(), the core will
call switchtec_dma_terminate_all(), which unconditionally attempts to acqui=
re
the exact same complete_lock.=20

Could this cause the CPU to deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727181526.9672=
-1-logang@deltatee.com?part=3D7
