Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241C4334D0;
	Mon, 27 Jul 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176797; cv=none; b=rZdmcWkcl8D5njdKOUNGcqf1wQDr+8imbm+FR19k3yirI4PhEqo7SUDHM2KKJiIwhM7uPYaldkJvTCTJC+vQlIjvQLecQe9quqW59NOzR508XK5113y9T4ZAwgLI+OLkiildNxFaICWtkJi6X6ngjJufgewObnch0L3hJWy+zKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176797; c=relaxed/simple;
	bh=alZwmxGpQnVwun0v5cbnCSMz3BnX59YNkg4SUg0rgh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U57te0M+nKXnHkvcnfEuRtPol2QO+R5wKf8cYzjxxjI1Rf0UiHVYE6XGXI7KkIvUjJsao5EXeaRlVhGpzP271cA0Sk2Nw3bFpRASiBApciRQoGD3UA+bYEg0ZDVuJ1FVbrssJ0/68FVPhgHfy9RW2s3MuspLSN8i8dGjHX2s5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dqiq1TS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dqiq1TS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C864A1F000E9;
	Mon, 27 Jul 2026 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785176796;
	bh=c8YHdX7PSjhp4VfsyxXYj+3VjykJqVmHNrDwMq3aMzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dqiq1TS5t7Si37W1m0nNmtqQ2ySFz3GgkEZAS55dei+HwGNvisRpgGuQqTXRMeIAA
	 3TcZ5fVPnZCRcnDDvN61ECX7+SBS0/OuIhn1VCWgWyhwQzZzUtOyaeYdXHdXqj01gZ
	 JMDj321deQJUUxNN7LhyM13kjl/NuN1p/J14PBYP4JAPKlntwCSiZg7jUwlRdB/9xA
	 r253uAVjzSUkEVYvFRDpap/An4BYpIFgIzkO8wBheJyJB7i8JDLJVxJJ8NTHk+NQfW
	 QNzoiPUzsGn6WWLCqIjq15oNIxamPAhyzs8QSiHXRw0q3CUUwER0/rGNasqVFPr7ar
	 bv98NAwEK8f3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/6] dmaengine: switchtec-dma: fix double-free in
 switchtec_dma_free_desc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260727174837.6645-2-logang@deltatee.com>
References: <20260727174837.6645-1-logang@deltatee.com>
 <20260727174837.6645-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:26:35 +0000
Message-Id: <20260727182635.C864A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing cleanup in the error paths of switchtec_dma_alloc_chan_r=
esources() leads to memory leaks and overwritten DMA allocations.
- [Medium] Leaked switchtec_dma_chan objects and swdma_chans array when dev=
ice enumeration or registration fails.
--

--- Patch [1]: [PATCH v1 1/6] dmaengine: switchtec-dma: fix double-free in =
switchtec_dma_free_desc() ---
commit c1fc554811fc177ea9480bb2fbbc31e95646cd59
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix double-free in switchtec_dma_free_desc()

This commit nulls out each pointer as it is freed in switchtec_dma_free_des=
c()
so a subsequent call is a no-op for anything already released. This prevents
a double-free if the function is called twice.

> switchtec_dma_free_desc() frees swdma_chan->hw_sq, hw_cq, and every
> desc_ring[] entry without clearing the pointers afterward. If
> switchtec_dma_alloc_chan_resources() fails partway through and calls
> it during unwind, then a later retry of alloc_chan_resources() fails

[Severity: Medium]
This is a pre-existing issue, but does switchtec_dma_alloc_chan_resources()
actually call switchtec_dma_free_desc() during unwind?

Looking at switchtec_dma_alloc_chan_resources():

drivers/dma/switchtec_dma.c:switchtec_dma_alloc_chan_resources() {
	rc =3D switchtec_dma_alloc_desc(swdma_chan);
	if (rc)
		return rc;

	rc =3D enable_channel(swdma_chan);
	if (rc)
		return rc;

	rc =3D reset_channel(swdma_chan);
	if (rc)
		return rc;
    ...
}

If enable_channel(), reset_channel(), unhalt_channel(), or rcu_dereference()
fail, the function returns an error directly without freeing the DMA cohere=
nt
memory and descriptor rings that were just allocated by
switchtec_dma_alloc_desc().

Because the dmaengine framework does not automatically call
device_free_chan_resources() when device_alloc_chan_resources() fails,
the driver must handle its own cleanup.

Furthermore, if a client or the driver core retries the channel allocation,
switchtec_dma_alloc_desc() will blindly overwrite the dangling pointers with
new allocations, permanently orphaning the previously allocated memory.

Does this need an explicit cleanup path on error?

> in switchtec_dma_alloc_desc() before reallocating one of those
> pointers, its own failure path calls switchtec_dma_free_desc() again
> and frees the same, already-freed pointers a second time.

[ ... ]

While reviewing this code, I noticed another pre-existing issue.

[Severity: Medium]
Does the driver leak the switchtec_dma_chan objects during probe errors?

Looking at switchtec_dma_chans_enumerate():

drivers/dma/switchtec_dma.c:switchtec_dma_chans_enumerate() {
	for (i =3D 0; i < chan_cnt; i++) {
		rc =3D switchtec_dma_chan_init(swdma_dev, pdev, i);
		if (rc) {
			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
				i);
			chan_cnt =3D i;
			goto err_exit;
		}
	}

	return chan_cnt;

err_exit:
	for (i =3D 0; i < chan_cnt; i++)
		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);

	kfree(swdma_dev->swdma_chans);

	return rc;
}

The err_exit loop calls switchtec_dma_chan_free() which stops the hardware
but fails to free the actual swdma_chan memory before freeing the array.
switchtec_dma_chan_free() does not call kfree(swdma_chan).

Additionally, in switchtec_dma_create(), if dma_async_device_register()
fails:

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
    ...
err_chans_release_exit:
	switchtec_dma_chans_release(pdev, swdma_dev);

err_exit:
	if (swdma_dev->chan_status_irq)
		free_irq(swdma_dev->chan_status_irq, swdma_dev);

	iounmap(swdma_dev->bar);
	kfree(swdma_dev);
	return rc;
}

It frees swdma_dev but leaks both the swdma_dev->swdma_chans array itself
and the individual channel structures within it, because
switchtec_dma_chans_release() also just calls switchtec_dma_chan_free().

Could these error paths result in a memory leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727174837.6645=
-1-logang@deltatee.com?part=3D1
