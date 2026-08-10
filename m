Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C02D26ED40;
	Mon, 10 Aug 2026 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358169; cv=none; b=Z7LT+Vyz8KkfYbhxGg6zGNxKlleUdF7IduO0Q69KsNmXtx126mywt++RA5somtKZGdwh67bksZFeZiCxdUm98kARRrYrb8D9GBuY4zXyQhoMxkpeTUQbLTrAXwyB76JOuiuUL0yMZSxGkF38lRWUYgnjUhgUAmBEy2jO7Ro+mNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358169; c=relaxed/simple;
	bh=Pv8hNBVIQtI6JvpIQULDlW07gH83ZU0lcjCHj5MyM+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JnjxW8QApFGuxisMl8ryZF71QXRAG9phS49gRCKu0f53wMPWT+ofg+zhq/O9cL+gbfvc1BBQzZgKQZSiKT4EWupLffHAevabTf1n+gh5ZcFdXBnyXkdvtuBUbJnxZRCYN+f54ebH/tJc9K2SILIdHDcJHYdysvU/1klzG0qUXSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+nf3S6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+nf3S6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAF61F000E9;
	Mon, 10 Aug 2026 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786358167;
	bh=y+XkZjf2O9NW8/ePKow005Lcy5Nm5pXWSxqrdo+XWEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a+nf3S6rAmr1C7vOOMCiuaKjlNt2iNHqqgCMUOs2yQvhW2aD9PIiq7x5ba8tnheTK
	 XK/5KQODu6a3YywrbSd6R2KsLsVpeNTHs8b8562amL9LEXi6HLaEW7NzwVT4O3xxqN
	 cDmlk+HHzv8PPFOvQ0d25/yyWcF2Tic6mu3AWDQA+10CBJ5WZK+mhUIfVT0b89yErp
	 oS/CJXrJRUNdUx32AP8KZ1LUAX0nWjSzHNZax//iU77f2duDRSm9gIccXmsSRplrKU
	 4MeIfmTqNlKfrOB17brJtJjrtiuMeE0scLsNbk13X0IrH1Asxe2E6RBpcsnIO5U3su
	 Oc6NPVZcmg9/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260810101002.1726131-2-devverma@amd.com>
References: <20260810101002.1726131-1-devverma@amd.com>
 <20260810101002.1726131-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:36:06 +0000
Message-Id: <20260810103607.5CAF61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The parsed channel separation size (`ch_space_sz`) is never prop=
agated to the core driver, rendering the commit functionally dead.
- [Medium] The newly added `ch_space_sz` field implicitly defaults to 0 ins=
tead of the documented 256 bytes for all non-B00F devices.
--

--- Patch [1]: [PATCH v3 1/2] dmaengine: dw-edma: Enable Chan Separation vi=
a VSEC ---
commit 49b6417fbdbe084d5839664db3abac6f79f818d2
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Enable Chan Separation via VSEC

This commit adds support for parsing the channel separation size from the
DEVICE INFORMATION VSEC capability on the Xilinx B00F device. It aims to
allow the user to configure the separation between DMA channel registers.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 791c46e8ae4c4..5d7507a640565 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -73,6 +75,7 @@ struct dw_edma_pcie_data {
>  	u16				wr_ch_cnt;
>  	u16				rd_ch_cnt;
>  	u64				devmem_phys_off;
> +	u32				ch_space_sz;
>  };

[Severity: Medium]
Does this new field implicitly default to 0 for non-B00F devices?

The commit message states "Default supported size is 256B", but static
structs like snps_edda_data and xilinx_mdb_data lack explicit
initialization for ch_space_sz, meaning they will be zero-initialized.

If this value is later used for channel offset calculations, could a 0-byte
separation cause all DMA channels to map to the exact same memory address?

[ ... ]

> @@ -279,6 +289,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct =
pci_dev *pdev,
>  	pdata->mf =3D map;
>  	pdata->rg.bar =3D FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
> =20
> +	if (pdev->device =3D=3D PCI_DEVICE_ID_XILINX_B00F)
> +		pdata->ch_space_sz =3D dw_edma_get_ch_space_sz
> +					(FIELD_GET(DW_PCIE_XILINX_CPM6_VSEC_CH_SEP, val));
> +

[Severity: Medium]
Is this parsed value supposed to be propagated to the core driver?

It appears pdata->ch_space_sz is populated here, but looking at
dw_edma_pcie_probe(), it doesn't seem to be passed along to
struct dw_edma_chip before the VSEC data goes out of scope:

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
	...
	chip->mf =3D vsec_data->mf;
	chip->nr_irqs =3D nr_irqs;
	chip->ops =3D &dw_edma_pcie_plat_ops;
	chip->cfg_non_ll =3D non_ll;
	/* missing chip->ch_space_sz =3D vsec_data->ch_space_sz ? */
	...
}

Without this propagation, does the channel separation configuration
actually take effect?

>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt =3D min(pdata->wr_ch_cnt,
>  			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810101002.1726=
131-1-devverma@amd.com?part=3D1
