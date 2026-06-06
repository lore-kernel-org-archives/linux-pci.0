Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360EA4071C4;
	Sat,  6 Jun 2026 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705912; cv=none; b=Bc2L29XGX63hC8qCrc5FsUWe97oIaMmof34EyZGkCrrnxUVCd6qfFniQNVNblsWNFwiLR6ANmvC7llIrXkfbGWFv61BW1GxxEbmk8Znirk/RykR+FnHaZcCgfn/BPB88pEuz4oFjzbQM4+9AFOMjIRB6xiDXPK4uEJoou5izu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705912; c=relaxed/simple;
	bh=j1rkB5jUKY7kvX0rKcAFSs14WPSWA2GBs4AXyeKTjnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHIg/vodARmV0E9MPzayzBri5EbU43xhr4IvdlUgfsZGTBbx6iSyZgOrXQwWAqgimRyXu3HPTOLE0wZ6YBIzj/3snnLWhs+AWgh01tPvYuGy1phV6WGKK12HMZymN3pAOqRhUN6E5L7m2jHntMS1K++Jh4wQCGwLbtOYk6tJUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccG6mr6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccG6mr6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A0B1F00893;
	Sat,  6 Jun 2026 00:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705910;
	bh=ueenNJZ32KCUP/AO5ooFoWLtBF6mK8ELU52O9XLT22A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccG6mr6ZnLwP3iO9UnMGWYbe4YV8pIkkV1TxgjjY9USfU8/CydW9E8ISvyp0RIhn0
	 u9mnj5eWGHGdZZgBeNc/P/x4BGvwwpi+3brFlTdinsh1ROA1YR3DJRjYPRwY355U3D
	 HNaFv+33uRJ+Ib+d2nuGqCNfwpUTHDujjwG83hqiqnn8EnPRwQhrE4mDM2d0rEoWR9
	 5GJsDqNc/Z6Zzpd6QND9PW7bJnKzVJrENSWVVrPJvlPIHcWEVnNz5Q5Hvh1VJrK71r
	 k7iZB96ksYKzNdffPFoKJdgS6Pdwtmnb6fur5yc9ED8DDcNtFlxhKGj5MkSkT/TIaM
	 AKAgNSUGqwebg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/23] dmaengine: sdxi: MSI/MSI-X vector allocation
 and mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-22-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-22-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:31:50 +0000
Message-Id: <20260606003150.92A0B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Failure to check the return value of dma_set_mask_and_coherent().

Pre-existing issues:
- [Critical] Teardown ordering risks Use-After-Free: Software tracking stru=
ctures and DMA memory are destroyed before the hardware is stopped.
--

commit 31c552b5f89a074f21648e62e100ec4d29388cf3
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: MSI/MSI-X vector allocation and mapping

During PCI probe, allocate a vector per context supported by the
function as reported by the capability register, plus one for the
error log interrupt. Introduce wrapper functions for vector
allocation, freeing, and translation to IRQ numbers.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
[ ... ]
> @@ -355,6 +357,8 @@ void sdxi_unregister(struct device *dev)
>  		sdxi_cxt_exit(cxt);
>  	xa_destroy(&sdxi->client_cxts);
> =20
> +	ida_destroy(&sdxi->vectors);
> +
>  	sdxi_dev_stop(sdxi);
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but does this teardown ordering
risk a use-after-free?

In sdxi_unregister(), the driver destroys all client contexts and their
DMA descriptor rings before sdxi_dev_stop() is called to quiesce the
hardware.

Because the hardware is still active, could it write to the freed status
rings or generate interrupts, causing sdxi_dma_cxt_irq() to dereference
freed memory?

Additionally, since the DMA engine framework is unregistered after
sdxi_unregister() completes during devres cleanup, could a client freeing
a channel in that phase cause sdxi_dma_free_chan_resources() to double-free
the already destroyed context?

> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c
> @@ -29,7 +31,8 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
>  {
>  	struct pci_dev *pdev =3D sdxi_to_pci_dev(sdxi);
>  	struct device *dev =3D &pdev->dev;
> -	int ret;
> +	unsigned int cap1_max_cxt;
> +	int vecs, ret;
> =20
>  	ret =3D pcim_enable_device(pdev);
>  	if (ret)

[Severity: High]
Does this function need to check the return value of
dma_set_mask_and_coherent()?

Looking at sdxi_pci_init(), it unconditionally configures a 64-bit DMA mask:

    dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

If the platform or bus rejects the 64-bit mask, could the driver proceed
to allocate and map DMA buffers under the false assumption that 64-bit
addressing is supported, resulting in silently truncated physical addresses
or IOMMU faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D22
