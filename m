Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342D305693;
	Wed,  2 Sep 2026 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331170; cv=none; b=PSyzKLFJzoDGqK2dDveo4PymETF0LrhQPb8PClUqBrZTbT0AN6MwsW0Vxp8pjBNWKS1eLkXbXFQIwsJQtMN2Gtq1XTmBE5wtkcHPYU9yBQdDhKY2zSh0YX+SF5a9473HspkDM4W4KgXIZ4R0ZHKGUFRZCgMRQl6gyUzWmveW5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331170; c=relaxed/simple;
	bh=QBJ3WYaewgZV08AYDHVDVdOrnKuq1wFbqh1uFv4JLZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VF/N7Jwr3TXpksvLdweVM53Jkt4DMjSzPj39rDlH5ehwpMvpswmvnp/wbZfn/m45ahMn66Ete2Uj160RIE3aojMAXCSg2B0Lc5YQtUpJ76zZIVXtftPCpkvEKO4p2Xu5qT5qIkURqF/Z1s6wNusFsjsBLnw3oO2qmCol3Yu5JE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn4/ZgXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn4/ZgXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7864D1F00A3E;
	Wed,  2 Sep 2026 06:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788331168;
	bh=vtLUvVh9oFjXzBzPDr43N4QypQVPHRUYQ8d5xtPDhug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qn4/ZgXNpzVmdSmeM0kzbmHte521LZSy9jvZc6OjKOpmJ9hpwKIWxptCWS+5GRUAH
	 fc2Qsi29KKUPdtYAwKL5n+RW1RBzGKgZzEfZnoq4DIV5t4Xo+KJmwVb8srvz0i5etP
	 rFRaG/sxKbfvVOdAvFQws9SXkMjUu7S/uXHpvZxlZTjAeajKe4EEa6WXQfal85wUeI
	 hMbqxx6ZVfxUkhWjILxhVERSPeM+B3UwO76h7ZE6d6rXALvsEGc5/+vfb/ILYrWn4F
	 BJ5/Cf2LE24tTiDcARCivoFp3QwWSAMKhsbFkNlINyQo0XjiWW0P2s7V5yyB1400Dw
	 pxaBiv6J9WWbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260902062153.31048-4-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:39:27 +0000
Message-Id: <20260902063928.7864D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The channel status ISR iterates over `dma_dev->channels` before th=
e list head is initialized, causing a NULL pointer dereference if the inter=
rupt fires early.
--

commit b0c8d064063987d7e3518dbe0fb57de31b776bde
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Wed Sep 2 06:21:45 2026 +0000

dmaengine: switchtec-dma: fix channel leak on registration failure

This patch addresses a memory leak during initialization failure by
introducing a switchtec_dma_chans_free() helper. It ensures channel
memory is cleanly freed and removes channels from the DMA device list to
prevent the ISR from dereferencing freed memory.

Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260727190604.397DB1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index e55fe9ff7e2c5..02d7c38363d68 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c

[ ... ]

> @@ -1316,6 +1322,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
> =20
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> +	switchtec_dma_chans_free(swdma_dev);
> =20
>  err_exit:
>  	if (swdma_dev->chan_status_irq)

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
cleanup and setup paths here, could this code be vulnerable to a race=20
condition with the interrupt handler?

In switchtec_dma_create(), we request and unmask the interrupt before the
channels are enumerated:

	rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
			     swdma_dev, KBUILD_MODNAME);

However, the dma->channels list head isn't initialized until later when=20
switchtec_dma_chans_enumerate() is called:

	INIT_LIST_HEAD(&dma->channels);

If a pending interrupt triggers immediately upon registration, the ISR will
execute and iterate over the uninitialized list:

	list_for_each_entry(chan, &dma_dev->channels, device_node) {

Because swdma_dev was allocated with kzalloc_obj(), dma->channels.next is
NULL at this point. Will this result in a NULL pointer dereference in the
ISR during device probe? Should INIT_LIST_HEAD(&dma->channels) be called
before the interrupt is requested?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D3
