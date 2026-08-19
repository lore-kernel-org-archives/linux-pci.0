Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DF3D566E;
	Wed, 19 Aug 2026 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123970; cv=none; b=nKXa2MD8VCaVgq+tRL0xDunIG9T+v2OwQa1MZtNBZcdm1xJQxIfiCWzS6yhWy6EiD+zislLcS++30JREWiWDMZaLqTDBIP2zerEK8TerTMD74Azijw6Xr6Dz9auZJJIFyZtduqx30VD4HG08W+UNdSKfod4Q8Yh8V2MpjyRJG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123970; c=relaxed/simple;
	bh=fW1QtdvWSJL2ZEdp4ezKB16WG0/Ft0c5rzrwG2oTQHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FB8mNvKL/LhhZvKd0LyTW20rOl5DmD0/1j8zevN3soru21HHVqYBjCcoq7O7b/auqeyz8X8PxHxwlHXagBf7s4PjMqvw87kLM/nNLdHDpFw5zgz+hvNkLSwwqHm43bAfbMp933XvP73hWWojZEacvZnT3Ud9TdFD3vwbmYlpfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdvRgPeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdvRgPeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300A01F000E9;
	Wed, 19 Aug 2026 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123969;
	bh=V/mbR41WRCMsAfv/eJn2tJqHLaQM9+CuhHspzpXODv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WdvRgPeo8SljmVSkwb0lIur/SEx/ywDSUFz1obSyaJlC+t+w811baDIujsQ4+lzJ9
	 v47Y0M90Rygc6Bmf8ipIJysM5qDmgsW2XYFnh3vmmQfVrUO1YQJ1pI0E4L85OKoEeq
	 4Q1Nb6sp3Wi3qpyTBqHs/iYR1mig8G+uKh/Bf6DSc4Q4dxUjj4Bn+3fU0wiEiHome0
	 XNSUE7PxarYGoxcDtNIm9bR4pexAj6TBFUQpMQWIgOFCDICuNykmuLZTQN1TkIHlyj
	 DV4MaXFgjBehsEX5cW+a0RSC7+Y/ym2GOuRRY1JBjoj6FJA1cc0XuUjJgxJLLvRCli
	 jqilzg6A3Ligw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: dw-edma: Add changes to support
 Channel Separation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260819070947.4080389-3-devverma@amd.com>
References: <20260819070947.4080389-1-devverma@amd.com>
 <20260819070947.4080389-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 07:19:28 +0000
Message-Id: <20260819071929.300A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error paths in `dw_edma_pcie_probe()` return directly without free=
ing IRQ vectors allocated by `pci_alloc_irq_vectors()`, causing an IRQ reso=
urce leak.
--

--- Patch [2]: [PATCH v4 2/2] dmaengine: dw-edma: Add changes to support Ch=
annel Separation ---
commit 801adc5a7230cabb747f37d2920f39c45fa66b9a
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add changes to support Channel Separation

HDMA supports configurable DMA channel register space separation which rang=
es
from 256B to 32KB. Current implementation supports 256B as default for DMA
channel register space, while CPM6 uses 512B by default.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index f287879b2cb9e..2eb8293b87b4c 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -436,6 +439,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll =3D non_ll;
> +	chip->ch_space_sz =3D vsec_data->ch_space_sz;
> =20
>  	chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt;

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error paths
just below this addition in dw_edma_pcie_probe():

	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
	if (!chip->reg_base)
		return -ENOMEM;

Does this return directly without freeing the IRQ vectors allocated earlier
by pci_alloc_irq_vectors()? Failing to call pci_free_irq_vectors() in error
paths leaks IRQ resources, which can prevent future allocations and
potentially exhaust system IRQ capacity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819070947.4080=
389-1-devverma@amd.com?part=3D2
