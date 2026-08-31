Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0F3B531A;
	Mon, 31 Aug 2026 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214734; cv=none; b=NlH0ZZ+tURRGOHZOwgkze4uDYXVyTv1lHICfaPvI1cugSPdVK/X+y/cq+Tdw9ddlTyeh5wn3MVnqR49deA+tDVBug+nxLTwv7zZHTe8yA21lMHnxi7dPTqVgSYXCit475dHOM7iwuPzAkv6PR7N408Yo1FobE//N8S/arD/GKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214734; c=relaxed/simple;
	bh=08yItknhCfu1Zmtp2WmcrwsPk2AMRFQZQ9saOGK1E2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qgE28kGE8meo/2i5A0nZAI8i5UqDpyEZ3Haf7Dw7PFMUDv+1Hxxv24/xUvKs8diChO6JHizJ4uYOVicQmId5zsJCIZHgt4NnMbmFaovlLXumSW0EoECNwIqsGIlaWGPnLOfqpwokSdMPNwNbh6tXCtHJsJTS+Twjvxrg6P/J+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geaT8Tgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geaT8Tgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F331F000E9;
	Mon, 31 Aug 2026 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214732;
	bh=9zDzN/8K7TSRvci9UFUO7/ABM7AVNO3NaCultq+XFo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=geaT8TgimexVLnkEnIkWjVk3LBZyeAc/IL6gos3kIHeSB+AehK355MdCrcbF7ZkxS
	 bP0H6IM03zZ/E5HYgwhHnJOVlcuYPhOmsmw6QsM0jVywq9OPJ/27j+RZDR6g/ZZkLL
	 WNtkY9z0Fk+pmqmI+g2oroyXS1u66sr0HM5abPpI9WGs13gE50WJiq6MI4zSvxja6H
	 VBLC0XfR+yhflCjNLyy/TIoGRyzh47qzTppAvYqW6REP1XXg62JoedRHZvNkohALK1
	 RdgI3xTmQAvJ1PuZAXRgTNW5nsUW9SZKwOpegCrS7IgR/fXf2GPQ+VGRD6WogLx9Nt
	 jKXewjUEhky2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/12] dmaengine: switchtec-dma: fix channel leak on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260831191403.207631-6-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:18:52 +0000
Message-Id: <20260831221852.83F331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized list head iteration in ISR causing NULL pointer dere=
ference.
--

commit bbb6888bb23afe2e2ce4a0388779ab6fa86e4ce3
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: fix channel leak on registration failure

This patch introduces a helper function to free DMA channel memory and ensu=
res
it is called correctly during registration failures and cleanup. It also up=
dates
the channel count on initialization failure to allow safe cleanup of partia=
lly
allocated channels.

Link: https://lore.kernel.org/dmaengine/20260717223024.9BB8A1F000E9@smtp.ke=
rnel.org
Link: https://lore.kernel.org/dmaengine/20260727190604.397DB1F000E9@smtp.ke=
rnel.org

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 2d5ba194c99a1..f71c64c137e83 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
[ ... ]
> @@ -1329,6 +1335,7 @@ static int switchtec_dma_create(struct pci_dev *pde=
v)
> =20
>  err_chans_release_exit:
>  	switchtec_dma_chans_release(pdev, swdma_dev);
> +	switchtec_dma_chans_free(swdma_dev);
> =20
>  err_exit:
>  	if (swdma_dev->chan_status_irq)

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition
during device initialization earlier in switchtec_dma_create().

The IRQ is requested and enabled before the channels list head is
initialized:

drivers/dma/switchtec_dma.c:switchtec_dma_create() {
	...
	rc =3D pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
			     swdma_dev, KBUILD_MODNAME);
	...
	chan_cnt =3D switchtec_dma_chans_enumerate(swdma_dev, pdev, chan_cnt);
	...
}

If a pending device interrupt or a spurious interrupt fires immediately
after pci_request_irq() is called, switchtec_dma_chan_status_isr() will
execute.

In the ISR, list_for_each_entry() iterates over dma_dev->channels:

drivers/dma/switchtec_dma.c:switchtec_dma_chan_status_isr() {
	...
	list_for_each_entry(chan, &dma_dev->channels, device_node) {
	...
}

Since switchtec_dma_chans_enumerate() hasn't called INIT_LIST_HEAD()
on dma_dev->channels yet, the list head remains zero-initialized by
the earlier kzalloc().

Could this cause a NULL pointer dereference when the ISR attempts to
iterate over the uninitialized list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D5
