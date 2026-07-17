Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115143F08A;
	Fri, 17 Jul 2026 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327673; cv=none; b=QE/5nK4wRftDIF7059LDpDe5E/8cVKEZxm3dB898qfqLSuu8getg69ywLP5Qjq2hhuDTrx4tpJzBVA6kjUcfmmFVu80HIV1ij9fD+GvdNTaqQG1w9rEjwzM7Gfrl+rGe31XkHfbEBLb/G7tNQ/ty4D0/H7Bx1HvBUW30K1Azwwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327673; c=relaxed/simple;
	bh=NX/r37JAgLZ3K4kZBYoDngmqQ0wVmdbTSCNI/50Zq/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LdIOr6m6tjK+joohcwfW7qg3LtGjp8BThulidBgz+Wd+c3CA/DmpDQw/fR+HIulwYJQLNFLfV4lszu74RRWAn1cAAps7VCs06Lz73LuG1p1TP+fAx864F64d+zhbrZIrTLWSM2bxPjiBLnqlcgnILn1Q4hnJ47Pt0r9KlZ4tAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAQJricz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAQJricz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625EE1F000E9;
	Fri, 17 Jul 2026 22:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327671;
	bh=qKd7BJ3VBMACGCnq3rnM94orpiWt4QVjdVJ9yb6ZWuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jAQJricz4gpS3L41SVraoksC2gqc/QM49tlIs43fTheYcx2oJptIrW5z2LDSGvdUr
	 sPqvoM/gWTc5C4R1dGuEBheMRUuA7mNRm8Moo6OlqEpCY2c53lKIhyvw6+c9RxHPsJ
	 BfiKaVKqc42IZ06Edno7Lgv7IxF3wbGxfaWCsBmK1lmHpTCo/6c6WeEDbjAR1S6ziy
	 N15HpONAElnLYb6G5/1Jj6CzijG8X3+CpfYCqxIiJlVr0v4IGDump5FW7JTsrfrzLK
	 Bu6YRdfQ+JAAHkYGayQ/Tdsq8NM7kLmPHFOxcwQjfnGAJuaXWeRhpHemJ7TvH77CAD
	 O26+a/TGPzo4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/6] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260717221001.361421-4-logang@deltatee.com>
References: <20260717221001.361421-1-logang@deltatee.com>
 <20260717221001.361421-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:34:30 +0000
Message-Id: <20260717223431.625EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a race condition leading to a use-after-free =
because it frees channel structures without removing them from `dma_dev->ch=
annels` while a global interrupt is still active.

Pre-existing issues:
- [High] In `switchtec_dma_remove()`, `swdma_dev` is used to unmap resource=
s after it has already been freed.
- [High] Broken cleanup of `chan_status_irq` resulting in a memory leak, wr=
ong IRQ being freed, and a dangling interrupt handler leading to a use-afte=
r-free.
--

--- Patch [3]: [PATCH v1 3/6] dmaengine: switchtec-dma: fix channel leak on=
 registration failure ---
commit 26b72b89d5c52be6bb3a650d3492040c2465768c
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix channel leak on registration failure

If dma_async_device_register() fails during probe,
switchtec_dma_chans_release() only stops hardware and frees IRQs and
tasklets, but never frees the per-channel swdma_chan structures. This patch
frees the channels and the array directly in the registration-failure path.

Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.ke=
rnel.org/T/#u

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index f77da31aeb65e..5768948ef4662 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -1317,6 +1317,11 @@ static int switchtec_dma_create(struct pci_dev *pd=
ev)
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> =20
> +	for (i =3D 0; i < swdma_dev->chan_cnt; i++)
> +		kfree(swdma_dev->swdma_chans[i]);

[Severity: High]
Does this free the channel structures while they are still linked in
dma_dev->channels?

During initialization, the embedded dma_chan nodes are added to
dma->channels. When freeing them here, the nodes are not removed from the
list, and the global chan_status_irq is still registered and active until
the subsequent err_exit block.

If the hardware asserts the interrupt, or if the interrupt is already being
processed concurrently, could switchtec_dma_chan_status_isr() iterate over
dma_dev->channels through this freed memory?

> +
> +	kfree(swdma_dev->swdma_chans);
> +
>  err_exit:
>  	if (swdma_dev->chan_status_irq)
>  		free_irq(swdma_dev->chan_status_irq, swdma_dev);

[Severity: High]
This is a pre-existing issue, but does this cleanup block use a vector
index rather than the global Linux IRQ number?

During probe, swdma_dev->chan_status_irq stores the MSI-X vector index
(e.g., 0 or 1). If it is 0, the condition evaluates to false, skipping
cleanup. If it is > 0, it calls free_irq() with a small integer, which
attempts to free an unrelated system IRQ.

This leaves the actual MSI-X interrupt handler registered. If the Linux IRQ
number is later reused by another device, could the kernel invoke
switchtec_dma_chan_status_isr() with a dev_id pointing to the freed
swdma_dev structure?


[Severity: High]
This is also a pre-existing issue, but is swdma_dev used to unmap resources
after it has already been freed in switchtec_dma_remove()?

switchtec_dma_remove() calls dma_async_device_unregister(&swdma_dev->dma_de=
v).
This synchronously drops a reference to the DMA device, which can trigger t=
he
driver's switchtec_dma_release() callback and execute kfree(swdma_dev).

Once dma_async_device_unregister() returns, the swdma_dev pointer can be
invalid, but switchtec_dma_remove() immediately proceeds to call
iounmap(swdma_dev->bar). Could this result in a use-after-free on device
teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717221001.3614=
21-1-logang@deltatee.com?part=3D3
