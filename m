Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB0318BB5;
	Thu, 20 Aug 2026 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217644; cv=none; b=AxCfOIHQf+1POCmkJGV3EQZN9Bv5lRBBI933aeDa/dT7zI2nKAXcjyhLtESBHMvA2x2FcsmVL82dI9bHgTemQKU8hE85KB88hQvcAGYZYLj42nu55DQW27sCEO7ILw6faUWTcFnZX2In9aVMP8YP7kZZ0Zl5pftsQXQqzorNUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217644; c=relaxed/simple;
	bh=LUbXVeE4NYhTgidf0TRCT8zEH+TYHcdH5HJBOBBvOc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TKRrphOq/ucZLE1M6QN08jSivfQL+pdAMgC8s46DE7l2cfw4sm6nBonj6m+/WErfQuyxadDVKE2TV/XrNijVBBOP503ZrxMCDZ1R3ykt0zsSq8Y5LyxnA+IBcK6X67+tnZvh7wSBZOccHulTkfvdxVSeAFgEJ+3/bfv4ZpSpwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFH1eZzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFH1eZzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537121F000E9;
	Thu, 20 Aug 2026 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787217642;
	bh=WTNlO/EaXrU7s7Azs3duxBhbk1aUQ0k4javUXb1f3h0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFH1eZzjjHcNh15yr9+nr5mX43e1xkxRc1NVOIRAUdvrAEMB4hDbCjsn3zb0Zgn0f
	 XhjISpuQTez1PvJBfdsnW5UCFSZ1Mt5uZu7WMgsKWHC4jf3AKGDauCLRwOUkO7yZoG
	 uKRt0WnedGPdJukWh7mBobV/fU57g1hAQs1VFdfebRUvNm77X7pGnKO7SIvLVpObfh
	 ukqqBWnELk4SLaZw0UxyRK/vF8Ctq5OC1P5AlYlxUd3Pz4nBNxV0oTBegISKnqiK3E
	 9hY7l9oN1fdMr04j08frGy2KHmvs+//VHoQhrrWptIvFUswwVxeNn2PiANpVbMNlS7
	 a7wQfnbpSoXrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] dmaengine: dw-edma: Add changes to support
 Channel Separation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260820091025.683506-3-devverma@amd.com>
References: <20260820091025.683506-1-devverma@amd.com>
 <20260820091025.683506-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 09:20:41 +0000
Message-Id: <20260820092042.537121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Untrusted channel separation size from VSEC can cause out-of-bound=
s MMIO accesses beyond the mapped PCI BAR.

Pre-existing issues:
- [High] Allocated PCI IRQ vectors are leaked on multiple error paths in dw=
_edma_pcie_probe() due to missing cleanup.
--

--- Patch [2]: [PATCH v5 2/2] dmaengine: dw-edma: Add changes to support Ch=
annel Separation ---
commit a5388dc7284225085ff4d5827150b9b1002f1690
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add changes to support Channel Separation

This patch implements configurable DMA channel register space separation,
ranging from 256B to 32KB, for HDMA. It updates offset calculations using
ch_space_sz based on the VSEC capability for CPM6 and removes unused V0
structs.

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

[Severity: High]
This is a pre-existing issue, but does dw_edma_pcie_probe() leak IRQ resour=
ces
on error paths?

The function successfully allocates IRQ vectors using pci_alloc_irq_vectors=
()
earlier in the probe. However, if any subsequent initialization step fails,
such as pcim_iomap_table() returning NULL:

	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
	if (!chip->reg_base)
		return -ENOMEM;

the function returns directly without calling pci_free_irq_vectors(). Could
this lead to exhausting system IRQ capacity after repeated probe failures?

> =20
>  	chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt;

[ ... ]

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..f8b2383b294ac 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c

[ ... ]

>  static inline struct dw_hdma_v0_ch_regs __iomem *
>  __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
>  {
> -	if (dir =3D=3D EDMA_DIR_WRITE)
> -		return &(__dw_regs(dw)->ch[ch].wr);
> -	else
> -		return &(__dw_regs(dw)->ch[ch].rd);
> +	u32 ch_base;
> +
> +	/*
> +	 * For Write, the channel register index starts at
> +	 * wr_base(ch_idx) =3D (2 * ch_idx) * ch_space_sz
> +	 *
> +	 * For Read channel,
> +	 * rd_base(ch_idx) =3D (2 * ch_idx + 1) * ch_space_sz
> +	 */
> +	ch_base =3D 2 * ch;
> +	if (dir =3D=3D EDMA_DIR_READ)
> +		ch_base +=3D 1;
> +
> +	return dw->chip->reg_base + (ch_base * dw->chip->ch_space_sz);

[Severity: High]
Can an untrusted channel separation size from VSEC cause out-of-bounds MMIO
accesses beyond the mapped PCI BAR?

If a maliciously crafted PCIe endpoint device reports a small BAR size but
provides a large channel separation value via the VSEC capability,
dw_edma_pcie_get_xilinx_dma_data() will extract this untrusted value to set
ch_space_sz.

Since the calculated offset (ch_base * dw->chip->ch_space_sz) is not explic=
itly
bounds-checked against the actual mapped size of the BAR (such as by verify=
ing
against pci_resource_len()), could this allow the subsequent SET_CH_32() ma=
cro
to dereference memory outside the mapped bounds and potentially cause a host
kernel panic?

>  }
> =20
>  #define SET_CH_32(dw, dir, ch, name, value) \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820091025.6835=
06-1-devverma@amd.com?part=3D2
