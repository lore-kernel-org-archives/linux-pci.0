Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6E343885;
	Tue, 28 Jul 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260407; cv=none; b=hh4y77MvltHLSEejG0j75peseyVXod6bSvdpNVCiGkLyYMTeOGVz0vuwIbnZbX6z55HYdoi5ucrJKA0mUv1beyIJV9LvdMSixzr6YJIUCseHiLLTcnMRfBDIECr/yt1Ew0c5TXPrwEAj34gEO5vaiv7vPcDXng8fDM7ldS6aOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260407; c=relaxed/simple;
	bh=2ob2OwiD5VILyDH2zuDbDBzjxCa2iywbYX0Uum0wM04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=daQvBECkzsrgPZAShjUPZL6MyunlBaOfXGZuSx3feh2oPDT1tpvUkjbhrHszmilrxj5vLnpSDTCVT7G9mHbBMgyvPjpjCbOUCqby3baAaPVOUEJD1JDCLQ7ndjGQfMANlFUH8YpP6gbcinMgxw1DOl9QJHa1COr+P1PfVia5NHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1Gi+Zn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1Gi+Zn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36E41F000E9;
	Tue, 28 Jul 2026 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260406;
	bh=TLq+YGW5bx01J91Wexs3V94q3tC0TtMZd0Qnmd1t2cY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l1Gi+Zn61dCs5VX/WWFuXZMW0mnQvX7yv/KnWdW8xVWwDAmo/RHA39bkAnRON05YM
	 RvZueGCy0DKpa7Q1/yqsp2TSo0YJ2ZdEeUljAE0PbmsBwFKHMxGJBBCxhd2hNzq897
	 PkQAban7HhII7bQnwlgLEr3lFuTmfb1I2tHKP9TiuvWxz+jVKI6UU1VF2kp5ywWqOL
	 JRv+pn++SmA1zS8BZAYeIoEtsOM5Mm2qJPNj6nc0qRqTHUx6WsUrYah/IlqtxVk3AW
	 Azt+tsF8QpjTerZf7l3UYYNYW4imjTkuw6K+Vd7ftlKlS2EPhVNNwKFlehttvZglBm
	 ac+N8arO1AWLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/12] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260728171523.112244-3-logang@deltatee.com>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:40:05 +0000
Message-Id: <20260728174005.D36E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper teardown order in `switchtec_dma_remove` enables race con=
ditions and use-after-free with dmaengine clients.
- [High] The driver holds a spinlock across dmaengine API boundaries, causi=
ng guaranteed deadlocks if multiple descriptors are batched.
--

--- Patch [2]: [PATCH v4 02/12] dmaengine: switchtec-dma: fix resource leak=
 in alloc_chan_resources ---
commit c17dbf5966e1848ec7a26210950a24038c80d7e5
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix resource leak in alloc_chan_resources

This commit fixes a resource leak in switchtec_dma_alloc_chan_resources()
where descriptor rings and coherent memory weren't freed on failure. It adds
an error-unwind path to properly disable the channel and clean up active
flags.

Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index a4a7d66d042de..f77da31aeb65e 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does this teardown order
allow active dmaengine clients to access destroyed hardware state or wait
on freed IRQs?

drivers/dma/switchtec_dma.c:switchtec_dma_remove() {
...
	switchtec_dma_chans_release(pdev, swdma_dev);

	rcu_assign_pointer(swdma_dev->pdev, NULL);
	synchronize_rcu();

	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);

	pci_free_irq_vectors(pdev);

	dma_async_device_unregister(&swdma_dev->dma_dev);
...
}

Because switchtec_dma_remove() disables channels and frees IRQs before
calling dma_async_device_unregister(), a concurrent client could attempt
to allocate or submit jobs to the exposed device before unregistration
completes.

[Severity: High]
This is also a pre-existing issue, but does returning to a generic API
client with a spinlock held cause deadlocks?

drivers/dma/switchtec_dma.c:switchtec_dma_prep_desc() {
...
	/* return with the lock held, it will be released in tx_submit */

	return &desc->txd;
}

If a client batches multiple descriptors (e.g., calling
dmaengine_prep_dma_memcpy() twice for the same channel before submit),
wouldn't the second call attempt to recursively acquire the same
non-recursive submit_lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728171523.1122=
44-1-logang@deltatee.com?part=3D2
