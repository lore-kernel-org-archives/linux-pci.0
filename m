Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDE46C835;
	Mon,  7 Sep 2026 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776663; cv=none; b=tUa9SCvwX+O9a7nqW5xbQfmDP249EcrfmV1bfv5awgNj8WfTlgv0FLLGQpWNu6JHpZeXbIhBcGPUUuz570NiJQ9X/XTHNj6/PMy02wd0EB2YBaLnUV0d8ugehlKpSTuGJqurfGGBdygZVVOMEppC6BSAt15BiqTLa3VsOPim1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776663; c=relaxed/simple;
	bh=+RQoIVdu2oHdYmH3oWd1fcFGtLoMCXvpL1HcddH98qE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cwBN+tvzV9pOKcmr3SoyYd/Pg8sJCSnCQIwc8DU0bIYwzu00naqfhH/BaI8Rrb5MQWnKl8ZgKsZ4Rhk+QzrELZb8rN1GAC09Hqj4pY/gBSjUAVoIK+jxgplm9pSAjPxsqsYAmbB8cZaEO5JmrQ4xbWGjNI163HfQ483c58+XToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1T7ug7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1T7ug7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5641E1F00A3A;
	Mon,  7 Sep 2026 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776661;
	bh=mVFPTr3DZYIpDEd9YBWLkIRVdhWakOSN057jJjtfMbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1T7ug7yq4ZbfKxqqm1RKJEGavcQ9OAUN9tuB6V3igR0IFBJKiwRSba6Emd/e1w8A
	 3zEz8SANa2ipaCV6NaqOXLs1NGYFwDZ61CdvfneZO2mxD8jDpGtftthR83GffMgrfv
	 s6/lH7cRpnrSLwa6SgVX3NT7rLv9EyZuqgNeu2aDcKfuBJBsjavletRR4cL1GalId5
	 c8jQKl8Wmixvda597gtlt+cl0UVr+zrjVGvTnbDYLxYzFTXuAOgCqpUTVfkKi6oHbu
	 IFy/JCHz7uCIdLZJTzOYp2iFYigh1AUngCFwSP2KHQuL1nmdaIUYDur0uk5vPLErPu
	 8ezJqYlSV+iAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v5 2/2] dmaengine: dw-edma: Add changes to
 support Channel Separation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260907101213.1917064-3-devverma@amd.com>
References: <20260907101213.1917064-1-devverma@amd.com>
 <20260907101213.1917064-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:24:20 +0000
Message-Id: <20260907102421.5641E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] IRQ vectors allocated by pci_alloc_irq_vectors() are leaked on mul=
tiple error paths and during device removal.
--

commit ba0a3a6c27ea5625a5bca375aac32fcdc517816e
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add changes to support Channel Separation

This commit updates the DMA channel register base address calculation to
support a configurable channel register space separation. It modifies the
probe functions to pass the channel space size to the chip structure.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 07931b1817856..fab4faf68b774 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -491,6 +494,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D match->plat_ops;
>  	chip->cfg_non_ll =3D dma_data->cfg_non_ll;
> +	chip->ch_space_sz =3D dma_data->ch_space_sz;
> =20
>  	chip->ll_wr_cnt =3D dma_data->wr_ch_cnt;
>  	chip->ll_rd_cnt =3D dma_data->rd_ch_cnt;

[Severity: High]
This is a pre-existing issue, but I noticed a potential resource leak in=20
dw_edma_pcie_probe() regarding IRQ vector cleanup.

Does dw_edma_pcie_probe() leak IRQ vectors on error paths and during device
removal?

Earlier in dw_edma_pcie_probe(), vectors are allocated using
pci_alloc_irq_vectors(). However, multiple error paths after this point
return directly without calling pci_free_irq_vectors(). For example, if
pcim_iomap_table() fails:

    chip->reg_base =3D pcim_iomap_table(pdev)[dma_data->rg.bar];
    if (!chip->reg_base)
        return -ENOMEM;

Similar leaks appear to happen if allocating the logical link blocks fails,
or if dw_edma_probe() fails near the end of the function.

Furthermore, dw_edma_pcie_remove() does not appear to call
pci_free_irq_vectors(), which means these IRQ vectors are leaked when the
device is unbound or the module is unloaded.=20

According to PCI subsystem guidelines, every error path after a successful
allocation must clean up the vectors to prevent IRQ resource exhaustion.
Could we add proper error labels to clean up these vectors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907101213.1917=
064-1-devverma@amd.com?part=3D2
