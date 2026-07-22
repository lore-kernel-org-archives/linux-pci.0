Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BD492525;
	Wed, 22 Jul 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719938; cv=none; b=kO0GR6IbT9BMjx7xDPBC3mbCM6g7uxQKvT2PnPBDwJKtQciF5iDd8ISp5OkesPIZSupGm24XFtcDMQZ8WssgzselPnc2zLe429CWUzFW2Y8bsKN7XpYUDiZOCEBaHG43HXo5BSW53YkDXpBvT+XHRjXRORPtJfGRkPl6nrJFUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719938; c=relaxed/simple;
	bh=vKgumWp9yAjtd5tcvc9DpeM8gSByhObF3Pedm7wv7yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MnEbWAzJtoMt9VS5ZHfCld9nO4RajAFdKQVz2GNUJ0Ldd6L88Dw4ItQDZ9ZbhPY9EUWPkwea0+O4QQ2rZJ0Ov23Wf7fQr3DhsPebTqZoHcnlyWjSDA8J6fFT/+4TNHzMYJY64UK2DmtROFYLoiglLnkShQ1bOHBlns8JtWP3FEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V52KTmgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V52KTmgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E351F000E9;
	Wed, 22 Jul 2026 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784719937;
	bh=e3zvPEI26DcFxpNCD8KtIqReW3f+8xDc2fjUSMcpxs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V52KTmgl+GOxksDlaXm9QYv6tMwQxZ/mMeiMdRfnw3sSpcZd8bqgkbrnDaBT8y8sn
	 798/irvPdmNwZw0KNOSdbGW0mlY5yU1hgS/csLsPaohq3xlDGRmUZPuvk76JuR417w
	 t4N2blhBwhlYh21ef5f/4WiPt9sG5fDoaNag/4jsVdOyIlJF8gZU0/QN2TkKXE6Rgq
	 Cm8gfnD1l1TBCm2vQZFw5aBwqNw3cZeSW2v9Gt8GTLFZfn3o4h1qg8XkU04s8P5Dfw
	 7XEOmVBowmOKGxiOIrlDi6+KV/rR4HDojBSqR+zgt9qOncjRcjsRFK0eh69Ejk+9IY
	 3vkF5qGAUW0Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] dmaengine: dw-edma: Add changes to support
 Channel Separation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260722111640.1146212-4-devverma@amd.com>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-4-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:32:16 +0000
Message-Id: <20260722113216.C1E351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced `ch_sep_sz` field in `struct dw_edma_chip` is=
 uninitialized (defaults to 0) for platform drivers outside of `dw-edma-pci=
e` that use HDMA natively, causing all channel register accesses to map to =
identical offset 0.
- [High] The driver trusts the device-provided VSEC configuration to calcul=
ate DMA channel register offsets but never verifies if these offsets remain=
 within the mapped PCI BAR region.

Pre-existing issues:
- [High] Pre-existing double free of IRQ vectors in `dw_edma_pcie_remove()`=
 due to devres interference.
--

--- Patch [3]: [PATCH v1 3/3] dmaengine: dw-edma: Add changes to support Ch=
annel Separation ---
commit 2ad7c860cd4c4a1bef961b814db689f718e1407c
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add changes to support Channel Separation

This patch modifies the dw-edma driver to support configurable channel
separation sizes. It updates the register offset calculations to use a
dynamic size provided by the hardware IP instead of assuming a default
256-byte separation.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 6295d01ba2f71..ca2a4be2f3a50 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -443,6 +446,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll =3D non_ll;
> +	chip->ch_sep_sz =3D vsec_data->ch_sep_sz;
> =20
>  	chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt;

[Severity: High]
This is a pre-existing issue, but does dw_edma_pcie_remove() explicitly call
pci_free_irq_vectors(pdev)?

Since pcim_enable_device(pdev) is called during dw_edma_pcie_probe(), it
automatically manages subsequent IRQ vectors via devres. When the driver is
unbound, the devres cleanup routine will attempt to free the already-freed
vectors, which could cause a double-free kernel panic on the device unbind
or module unload path.

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..3f27a93c4d8c8 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
[ ... ]
> @@ -23,18 +23,23 @@ enum dw_hdma_control {
>  	DW_HDMA_V0_LLE					=3D BIT(9),
>  };
> =20
> -static inline struct dw_hdma_v0_regs __iomem *__dw_regs(struct dw_edma *=
dw)
> -{
> -	return dw->chip->reg_base;
> -}
> -
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
> +	 * wr_base(ch_idx) =3D (2 * ch_idx) * ch_sep_sz
> +	 *
> +	 * For Read channel,
> +	 * rd_base(ch_idx) =3D (2 * ch_idx + 1) * ch_sep_sz
> +	 */
> +	ch_base =3D 2 * ch;
> +	if (dir =3D=3D EDMA_DIR_READ)
> +		ch_base +=3D 1;
> +
> +	return dw->chip->reg_base + (ch_base * dw->chip->ch_sep_sz);

[Severity: High]
Does this code verify that the computed channel register offset remains wit=
hin
the mapped PCI BAR region?

If a malicious or misconfigured PCIe endpoint provides a large channel
separation size, could this calculation result in out-of-bounds MMIO access=
es?

[Severity: High]
If platform drivers outside of dw-edma-pcie use HDMA natively and allocate
struct dw_edma_chip via devm_kzalloc without explicitly initializing
ch_sep_sz, does ch_sep_sz default to 0?

Could this cause all channel register accesses to map to offset 0, leading =
to
data corruption by incorrectly targeting Write Channel 0's registers?

>  }
> =20
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-ed=
ma/dw-hdma-v0-debugfs.c
> index dcdc57fe976c1..33128685bbd90 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
[ ... ]
> @@ -13,22 +13,17 @@
>  #include "dw-hdma-v0-regs.h"
>  #include "dw-edma-core.h"
> =20
> -#define REGS_ADDR(dw, name)						       \
> -	({								       \
> -		struct dw_hdma_v0_regs __iomem *__regs =3D (dw)->chip->reg_base; \
> -									       \
> -		(void __iomem *)&__regs->name;				       \
> -	})
> -
>  #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
>  	({								       \
> -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
> +		off_t __off =3D (dw)->chip->ch_sep_sz;			       \
>  									       \
> -		if (_dir =3D=3D EDMA_DIR_READ)				       \
> -			__ch_regs =3D REGS_ADDR(dw, ch[_ch].rd);		       \
> +		if ((_dir) =3D=3D EDMA_DIR_READ)				       \
> +			__off *=3D (2 * (_ch) + 1);			       \
>  		else							       \
> -			__ch_regs =3D REGS_ADDR(dw, ch[_ch].wr);		       \
> +			__off *=3D (2 * (_ch));				       \
>  									       \
> +		__ch_regs =3D ((dw)->chip->reg_base + __off);		       \

[Severity: High]
Could this also lead to out-of-bounds MMIO accesses during debugfs reads?

If the untrusted channel separation size is used to compute the offset, and
userspace triggers a debugfs read, it seems this could be exploited if not
validated against the BAR size.

>  		(void __iomem *)&__ch_regs->name;			       \
>  	})
> =20
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 1fafd5b0e3153..a6c5728f03d38 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -104,6 +104,7 @@ struct dw_edma_chip {
> =20
>  	struct dw_edma		*dw;
>  	bool			cfg_non_ll;
> +	u32			ch_sep_sz;

[Severity: High]
Does this new field need a fallback default for non-PCIe drivers?

Other core drivers that instantiate struct dw_edma_chip for HDMA might not
explicitly set this, leaving it uninitialized.

>  };
> =20
>  /* Export to the platform drivers */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722111640.1146=
212-1-devverma@amd.com?part=3D3
