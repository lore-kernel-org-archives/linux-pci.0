Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F81A281530;
	Mon, 10 Aug 2026 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358459; cv=none; b=RNm8FnY8OFEitkpo3c63GA1TPygV7KecaX1T+GkvUF9xmqk1q2KzxRJLl70FaBiCsGuo6pm3x7AirtCMKXK9NZOTOF/z6+fF/ww0CcCpZz75c0PA3chUTkMOZILtl4539dvbuqyoX9Vj+KcbeAAXeuQUqh+knnw4tuJwGoyH/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358459; c=relaxed/simple;
	bh=OvB+96VHo6NkRcclQTNqmlkOFj7UVZq2Y1w2SmArG/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kYD+a5TQCnOpJwXAOWvRDfOBaP/eugOM1/MFG7n2JTUEsilH5koJw0v++KbaUe53xur8tBfbrgnkMkcPGf3FZrzJzPD7TdkA+p2inR/DTiRptXRXimo68i/VrtoaEnoVBWLUlDOf+whAumeo8JP1SAWTXHKsRlUkM/l2bpym8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQseEX5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQseEX5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743571F000E9;
	Mon, 10 Aug 2026 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358457;
	bh=VmAxI49ERr18idSpR0Ocx9AT09AZkF5ASmft2nkElVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQseEX5Ozyd1W5Fng9hirvKiNrwK9t3rlEcIMwJtSFwK3ceo4HatbJWfwaHmoDr5u
	 UMIp/AZCAUto8vhCqmbPXzGW+73cRoXO9HFr3cpWQywyTFl51b2lrnVYctcVOaKgAX
	 2z6k2XtxTPSeukNA2ZpNvI9rJjpdjLOQpPU84PiP1v3fLNvryL27cIQDWzAR7WBvp0
	 HY5XJzRasavzM2WCqkGgLd8BW/KMwwiYNudyDKbvS63bYrDMMyR8325rCCSC1Nxjds
	 Yqa4MgEsQDAuF83dZOspuzOPqkdWE+iM64kUJndfqhTj+Jfe8rjNl6eICjBn33fdbl
	 48OmjPJNtrwyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: dw-edma: Add changes to support
 Channel Separation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260810101002.1726131-3-devverma@amd.com>
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:40:57 +0000
Message-Id: <20260810104057.743571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Out-of-Bounds MMIO Access via Untrusted `ch_space_sz`

Pre-existing issues:
- [High] Resource Leak (Missing IRQ Vector Cleanup)
- [High] Logic Error / Argument Swap in GET_CH_32
--

--- Patch [2]: [PATCH v3 2/2] dmaengine: dw-edma: Add changes to support Ch=
annel Separation ---
commit 612eb6bce9ca000b699c0fa4968d63e211dd64db
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add changes to support Channel Separation

This commit adds configurable DMA channel register space separation=20
ranging from 256B to 32KB. It updates functions to calculate base addresses=
=20
based on the selected channel separation value available in the PCIe VSEC=20
configuration space.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 5d7507a640565..81401620988c9 100644
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
This is a pre-existing issue, but does this function leak IRQ vectors on er=
ror
paths?

If initialization fails after pci_alloc_irq_vectors() succeeds earlier in t=
he=20
function, it returns directly without cleaning up the IRQs:

dw_edma_pcie_probe()
{
    ...
    chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
    if (!chip->reg_base)
        return -ENOMEM;
    ...
    err =3D dw_edma_probe(chip);
    if (err) {
        pci_err(pdev, "eDMA probe failed\n");
        return err;
    }
    ...
}

Should these error paths call pci_free_irq_vectors(pdev) to ensure we don't=
=20
exhaust system IRQ capacity?

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..f8b2383b294ac 100644
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
>  }

[Severity: High]
Is it possible for this pointer arithmetic to access memory out of bounds?

The ch_space_sz value is derived dynamically from the untrusted PCIe VSEC=20
configuration space (scaling up to 32KB per channel). If a malicious or bug=
gy=20
hardware endpoint presents a small BAR (e.g., 4KB) but provides a large VSE=
C=20
channel separation value, multiplying ch_base by dw->chip->ch_space_sz coul=
d=20
yield an offset well beyond the memory mapped in chip->reg_base.

Should ch_space_sz be validated against the mapped BAR size using=20
pci_resource_len() before using it to index into the MMIO space?

[Severity: High]
This is a pre-existing issue, but does dw_hdma_v0_core_ch_status() pass=20
arguments to the GET_CH_32 macro in the wrong order?

In dw_hdma_v0_core_ch_status(), the code does:

    tmp =3D FIELD_GET(HDMA_V0_CH_STATUS_MASK,
                    GET_CH_32(dw, chan->id, chan->dir, ch_stat));

The GET_CH_32 macro expects arguments in the order (dw, dir, ch, name),=20
but chan->id and chan->dir appear to be swapped. Can this cause the driver=
=20
to calculate an incorrect register base offset and read from the wrong=20
hardware channel registers?

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-ed=
ma/dw-hdma-v0-debugfs.c
> index dcdc57fe976c1..3fa16e045a584 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
[ ... ]
>  #define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
>  	({								       \
> -		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;                  \
> +		off_t __off =3D (dw)->chip->ch_space_sz;			       \
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
>  		(void __iomem *)&__ch_regs->name;			       \
>  	})

[Severity: High]
Can this result in an out-of-bounds MMIO read when userspace accesses debug=
fs=20
attributes?

Similar to the calculation in __dw_ch_regs(), __off scales by the unvalidat=
ed=20
ch_space_sz value. If the value isn't checked against the BAR size, could a=
=20
userspace read/write to debugfs trigger an out-of-bounds access beyond the=
=20
mapped memory space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810101002.1726=
131-1-devverma@amd.com?part=3D2
