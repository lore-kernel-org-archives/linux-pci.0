Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310F2F8EBC;
	Tue, 28 Jul 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231094; cv=none; b=OCFrKQvzA4b9Hifq95tiHrCZC8ewfwh7r1YeRt01UICb1CV+9m06aelxAShPs0Zf7hhg/acnfC8WzMpkQN8LjtqcZyWCgl6GMZwNaISqXWhdAHCUeLDZci4p3kmfERro7AmM+Ve541RD3WlXm2F5bqWuvlOFpgNiRzQAtC538X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231094; c=relaxed/simple;
	bh=+kbkKjYyPZsTWr3fvyID4xqUrFPqHRKYQ8U5ftuS1fY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+sHEDYA8SNkOyBnL0VRJm8kBdP/zxI7V3sWgCl5z+jWTCQMCnx+WG/g3vL63FIfFhKP1tWpXqUGwknLZamIwaAc0GL3OurqhncZoqZJVWtgIhFLBc77fNX289LGkIdunnmrbVm6rrgQLEkasYiT+HS9MVInQfO9pZxuXrdFlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkXW7j6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkXW7j6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6669C1F000E9;
	Tue, 28 Jul 2026 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785231092;
	bh=+96Gprrk0k0/sGKNZ6fry0aMLLmE4L/pk3hYFq0miyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FkXW7j6mJ8HcGbA7wnjO84P5fjEx2gDw5OistUuP/xl2NUuiYqke3cyFeJPTKEfK4
	 01n+7y5KyQuv3iOud6D/k4dPE9MSUS7wT1/ITJx81tZ+PqLJi5snQ1HZHihozqEESO
	 PvRGBc6ITtQVMSvlHKx/3q8FZdKYQfpKUd5NKSy9s+J8o3hUXwfYXlMyt0U/RM8mXL
	 SbAqx53Y28/v249c2JaaNueUHi6bBhU3kknyqOHrGZv/fT2vwtX3s+SbbNRd+o4Ob4
	 H9a5NqEIgQNV1OYUbkt2KUd8M5o0XZ/Jqjul2WQnFFhnGtJoXQbGNnZJDt+zlU6hCg
	 0k5TIGuUj07IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260728091744.1086942-3-devverma@amd.com>
References: <20260728091744.1086942-1-devverma@amd.com>
 <20260728091744.1086942-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:31:31 +0000
Message-Id: <20260728093132.6669C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The claimed 'Channel Separation' feature is completely unused and =
dead code, failing to pass the parsed separation size to the core DMA drive=
r and causing hardware register offset mismatches on non-default configurat=
ions.
- [Medium] The `ch_sep_sz` field defaults to 0 for non-XILINX_B00F devices,=
 violating the 256B default size specification.

Pre-existing issues:
- [High] Double free risk of IRQ vectors due to mixing managed `pcim_enable=
_device()` with manual `pci_free_irq_vectors()`.
--

--- Patch [2]: [PATCH v2 2/3] dmaengine: dw-edma: Enable Chan Separation vi=
a VSEC ---
commit c9662ac63af55f746e4aad35cf3b04bea4688738
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Enable Chan Separation via VSEC

As per, 'Designware Cores PCI Express DM Controller - Reference
Manual', section 3.2.34.3, VSEC for DEVICE INFORMATION supports
the channel separation mechanisms. Basically, the HDMA IP allows
the user to configure the separation between DMA channel
registers and retrieve it via the VSEC capability mentioned
above.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index ec5e057a0f11b..d0f209082878d 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -73,6 +76,7 @@ struct dw_edma_pcie_data {
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
>  	u64				devmem_phys_off;
> +	u32				ch_sep_sz;

[Severity: Medium]
Does this new field need to be initialized in the existing static
configuration structures?

For example, snps_edda_data and xilinx_mdb_data are not updated in this
patch to set ch_sep_sz. Because they are static structs, ch_sep_sz will
default to 0 for non-XILINX_B00F devices.

If ch_sep_sz is passed to the core driver, would a 0-byte separation cause
all channels to overlap in memory, violating the 256B default size
specification?

>  };
> =20
>  static const struct dw_edma_pcie_data snps_edda_data =3D {

[ ... ]

> @@ -279,6 +290,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct =
pci_dev *pdev,
>  	pdata->mf =3D map;
>  	pdata->rg.bar =3D FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
> =20
> +	if (pdev->device =3D=3D PCI_DEVICE_ID_XILINX_B00F)
> +		pdata->ch_sep_sz =3D dw_edma_get_ch_sep_sz(FIELD_GET(DW_PCIE_XILINX_CP=
M6_VSEC_CH_SEP,
> +								   val));
> +

[Severity: High]
Is the parsed channel separation size actually used by the core driver?

It looks like ch_sep_sz is populated in vsec_data here, but is never
passed to the core DMA driver in dw_edma_pcie_probe():

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
    ...
    chip->mf =3D vsec_data->mf;
    chip->nr_irqs =3D nr_irqs;
    chip->ops =3D &dw_edma_pcie_plat_ops;
    chip->cfg_non_ll =3D non_ll;
    chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
    ...
}

Additionally, does the core driver support this dynamic separation? Looking=
 at
__dw_ch_regs() in dw-hdma-v0-core.c, the channel register offsets appear to=
 be
calculated using fixed C structure array indexing:

    if (dir =3D=3D EDMA_DIR_WRITE)
        return &(__dw_regs(dw)->ch[ch].wr);
    else
        return &(__dw_regs(dw)->ch[ch].rd);

If a 32KB separation is configured, wouldn't the core driver still calculate
MMIO offsets assuming the hardcoded structure layout, potentially reading or
writing incorrect PCI memory on non-default configurations?

>  	pci_read_config_dword(pdev, vsec + 0xc, &val);

[ ... ]

> @@ -324,9 +339,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_pcie_data *pdata =3D (void *)pid->driver_data;
>  	struct device *dev =3D &pdev->dev;
>  	struct dw_edma_chip *chip;
> +	bool non_ll =3D false;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll =3D false;
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential double free of the
IRQ vectors related to the device probing.

When pcim_enable_device() is used, IRQ allocations via
pci_alloc_irq_vectors() are managed by devres and automatically freed.

However, looking at the remove path in dw_edma_pcie_remove():

    /* Freeing IRQs */
    pci_free_irq_vectors(pdev);

Does calling pci_free_irq_vectors() manually conflict with the devres clean=
up
registered automatically by pcim_enable_device(), leading to a double free
when the driver is unbound or fails to probe?

>  	if (!pdata)
>  		return -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728091744.1086=
942-1-devverma@amd.com?part=3D2
