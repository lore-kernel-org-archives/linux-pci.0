Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5641717DFFA;
	Thu, 20 Aug 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217506; cv=none; b=Nn+BnHVZVTVrFdn14hck4Kz2IaCd4iOSnbXClWuvYKp7Gyr8ba9lL/jkoZDVHKre3us3FQYy+32UjYLawBPSdIsaz2ZoHb0UfKhFHr1RgxZ5rLaa8dPOZ+hwVlEDwoiVNT/uFElN03Y+h5JW1h82GOpblcLm1ynoeLLVaUJSTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217506; c=relaxed/simple;
	bh=mhWUMmah2sTWF4vE3AcaHJL8obe3HFdqWZ8Po3v4HxE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tZMNkysnynnjiYSWj2dmpDupKII0vIv5T457eFw+pv5xhtL6vzHshngGCeUsku7l0VWjsXH0CYxK7jXyNUE6XxBOoELZu1AgoS1VgjmqoHyYKKdLJiTobjDkuZNBDVO1qdZDFiqKD0l4hEsIgrn/BDcMs3Qf8LHNpNLapWyA9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7wD78oP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7wD78oP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9A41F000E9;
	Thu, 20 Aug 2026 09:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787217505;
	bh=4tRF01WHIHzucAxOL1wW7Dxi82aRsQlJShLINQbM+Y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7wD78oPHC5BOPH8TmAgt6y9+0Jt85xyj2NdYdal8DK9kDahqu8r7GNsh8ze8GctE
	 SHI/YNruUdLwF+HCQcqJw5/Mol9DKbnpqnir1Klf4hWJc7D/O7xEuRazYzh9oD57cm
	 vHFzSdfNPUEKWGBO5rWO18U/oJwvVpBItW2kMxa0tvsv6L+YlXkRS1lFxxMa2GlWDa
	 aju1c/OQZO4Oin8j7Qeo84wnhLV3SEHxc2LWR2DuegmCSG3xM/3LQAwb8YjufeV564
	 Jv2PKL3sAoN6rFDnsZRrFGLc8rbRutvQwYzBzatlUCmlwjZBNCpF/+JWtOcLAQMqRv
	 C1iA4UVUfRUvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dmaengine: dw-edma: Enable Chan Separation via
 VSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260820091025.683506-2-devverma@amd.com>
References: <20260820091025.683506-1-devverma@amd.com>
 <20260820091025.683506-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 09:18:24 +0000
Message-Id: <20260820091824.AC9A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failing to call pci_free_irq_vectors() in error paths after succes=
sful pci_alloc_irq_vectors() leaks IRQ resources.
--

--- Patch [1]: [PATCH v5 1/2] dmaengine: dw-edma: Enable Chan Separation vi=
a VSEC ---
commit 53282250df52af0d427cd82b37ad2ac609096030
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Enable Chan Separation via VSEC

This commit enables channel separation mechanisms for the HDMA IP by
retrieving the configuration via the DEVICE INFORMATION VSEC capability.
It adds support for channel register space separation sizing.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 791c46e8ae4c4..f287879b2cb9e 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

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
>  	pci_read_config_dword(pdev, vsec + 0xc, &val);
>  	pdata->wr_ch_cnt =3D min(pdata->wr_ch_cnt,
>  			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));

[Severity: High]
This is a pre-existing issue, but does dw_edma_pcie_probe() leak system
IRQ capacity in its error handling paths?

Looking at dw_edma_pcie_probe() in the same file, if pci_alloc_irq_vectors()
succeeds, several subsequent error paths appear to return directly without
cleaning up the allocated vectors:

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
    ...
    /* IRQs allocation */
    nr_irqs =3D pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
                                    PCI_IRQ_MSI | PCI_IRQ_MSIX);
    ...
    chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
    if (!chip->reg_base)
            return -ENOMEM;
    ...
    /* Starting eDMA driver */
    err =3D dw_edma_probe(chip);
    if (err) {
            pci_err(pdev, "eDMA probe failed\n");
            return err;
    }
    ...
}

Should these failure paths explicitly call pci_free_irq_vectors() before
returning to avoid leaking the IRQ resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820091025.6835=
06-1-devverma@amd.com?part=3D1
