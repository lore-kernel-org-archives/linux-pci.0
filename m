Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31B2F8EBC;
	Tue, 28 Jul 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231083; cv=none; b=OHH3w4vvs3S//7xR9jn+D71WZ9hILgqZGhwt00GJBD+wcdeEJj8Q55HIISpsKRWK4GrUZtEtoKttjy6dQLGrTQyRkycPzZW2lVYiF8esI0wApMK4jlzlfTOw39LH/JJQZvx876O99sQlppSI6k+eMWs9hlFsOTEkavED7yy3yT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231083; c=relaxed/simple;
	bh=gMT/dhLggaNwPKFAIHQ+FpYp1uy7yxY+rwh5IgBbXvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k32yLumE5FVXi+4v2J8LvdqWvxpvFTzIg3HXDMEvA9ieXiiAmrRgDnRq7G8dWtnyWjbqTG0s68Z5iQLpwHGgTgRNP59dMZTaUNSD06GWhKklJ71vetR38HjL5SvJ3QlRMJSVsBWVu0lpebOgGMSeYhVdPZvEx/Sc7x3eoaCn9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTVceMuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTVceMuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865D81F000E9;
	Tue, 28 Jul 2026 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785231081;
	bh=AyBkM5qiC6Ns/Mw1VstLbXSZxY903xB57Cvie5xw4wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTVceMuzWFfKx9MuchSf8FtTMKC5X546aunK4m9jQGxAwCYhE8wA3S4Z3MUEkqlKh
	 HOI9xop9jO8vU69yLwvts9b/NFHy7+XUOGLDBL5GlvnGQy6mfQE8xY4T+LhnjWqH1s
	 JRlEWsuOfKVLHRK7H+qQKP3GQIISA82MdPpnGgdhxdEqaids7y83Vq04OynfI/ZYy6
	 aF1YOjrMsmiwMidhk2fErvddTi5/33igBJtz/qps7Loc5TxQ+qJ6aagun+NpPDV5A5
	 aUM3KNI9SYLLx4QG6wadF2usITrTEEmHisbcRmIy/iiLhVrwPLvqeTVGOHWeThyH2K
	 vokQ/1gFeTSCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] dmaengine: dw-edma: Add changes to support
 Channel Separation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260728091744.1086942-4-devverma@amd.com>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-4-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:31:21 +0000
Message-Id: <20260728093121.865D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] eDMA/HDMA register base address missing capability offset
--

--- Patch [3]: [PATCH v2 3/3] dmaengine: dw-edma: Add changes to support Ch=
annel Separation ---
commit d8b9ebd109653d1219284d3ab6408816a9dc7745
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add changes to support Channel Separation

This commit updates the driver to support configurable DMA channel register
space separation. It modifies channel register base address calculations to
use a dynamic separation size instead of a fixed layout, and removes unused
legacy register layout structures.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index d0f209082878d..f2a9ae8d0f3c4 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -437,6 +440,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll =3D non_ll;
> +	chip->ch_sep_sz =3D vsec_data->ch_sep_sz;
> =20
>  	chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt;

[Severity: High]
This is a pre-existing issue, but does dw_edma_pcie_probe() assign the wrong
MMIO base offset to chip->reg_base?

Just below this hunk in dw_edma_pcie_probe(), the code assigns:

    chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
    if (!chip->reg_base)
        return -ENOMEM;

It appears the vsec_data->rg.off capability offset is never added to this b=
ase
address. Without adding the offset, won't all subsequent eDMA/HDMA register
accesses target the wrong MMIO locations (offset 0 of the BAR instead of the
specified offset like 4KB), potentially triggering bus faults or preventing
the DMA hardware from initializing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728091744.1086=
942-1-devverma@amd.com?part=3D3
