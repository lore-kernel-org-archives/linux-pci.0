Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B77D39A054;
	Mon, 31 Aug 2026 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211245; cv=none; b=jLHp5Iz5Nmz0h8x4gNbge2KTR0rASfBHymmYA/HeC10fGYfj3lNTgiSkZlYU8ka1aTJXHeu9RAc4lNPeyAy1zQ0t6P2GsMrUXQuU9+/5Grd0wi7kqdFGVSb0uf2ZEltapYE0JrzhjELARtBZaCBxgLcoulT+EEvaJRYXjuDWqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211245; c=relaxed/simple;
	bh=E7y0YT9/VxC9tuDrjdEdgJwnBiMe4L+2FBbPSdNxtAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBN25fJH0vmTXkLTnFVTJm1AkzJfmVp4sjGc+yNywS8Rd6fnntNFdyHD1F671n9Z4WhAE+iaSXJTc59+M7TFtSfhnZ8FknfZ6qADshuOYwbJsK5IsXIrrxPaHb4uNsJ6z8EvDwUrwjjljrEmwzGu8TIhEvUy1yjzSRo0EY5/Yb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPG5P+LL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPG5P+LL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C5B1F000E9;
	Mon, 31 Aug 2026 21:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211244;
	bh=ym8AuO0ZBYV/Y8EMHCQjOZr/s2FnjSTXlW0G/OEi1Wk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPG5P+LLyFVZ1MBj7K7lOFxOb560TGsvSQ2atWkUOWprqfQV8IwRyugT/vQcXcCgM
	 Q018g9jKLJRGIeA2hOuZEOgJIlc33jfx2/WwYf06GWOxLWLfKfe0EGlccl95dpkQn0
	 oQZJYFSXJNoJaq5ZEUximBIPGh+m1sGjIDOTm+VRrtOqeQm5wiTd03sG4+q/v9rbbM
	 nl/Hc1WtB24n2s5JegvU3/s06BCLkPSKkjsGDDH3gpsYfbDyn4oqsAs2rkBy0Sskwv
	 YkLDoeFOZbrWRFOYWROb1wCfJSu0STu2C17pjQDdomale5kwhHgW9ZEG9k228GwbIc
	 g7d5rgG1PIeHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] NTB: ntb_hw_epf: Discover vNTB-embedded DMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260831182657.329614-7-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:20:43 +0000
Message-Id: <20260831212043.E1C5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Probe fails entirely if the endpoint advertises an unsupported DMA=
 type or if dw-edma host support is missing.
- [High] Strictly demanding `dma_irqs` extra MSI/MSI-X vectors breaks probe=
 on IRQ-constrained systems.

Pre-existing issues:
- [Critical] Dynamic reading of the SPAD offset without validation allows a=
 malicious endpoint to cause arbitrary host MMIO read/write.
- [High] Pre-existing race condition in `ntb_epf_mw_set_trans` where multip=
le concurrent calls can interleave writes to shared memory window configura=
tion registers.
--

commit 9b8b5f4c03fc934132c68dec22efe8a4ca1332ef
Author: Koichiro Den <den@valinux.co.jp>

NTB: ntb_hw_epf: Discover vNTB-embedded DMA

A vNTB PCI function can now expose endpoint-local DMA channels to its
host. This patch decodes the extension and registers the advertised
channels before the NTB device.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index c47607d4f8a7f..16cde97d4bde2 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c

[ ... ]

> @@ -373,15 +681,19 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *nde=
v, int msi_min, int msi_max)
>  {
>  	struct pci_dev *pdev =3D ndev->ntb.pdev;
>  	struct device *dev =3D ndev->dev;
> +	unsigned int dma_irqs =3D ndev->dma.nr_irqs;
> +	unsigned int ntb_irqs;
>  	u32 argument =3D MSIX_ENABLE;
>  	int irq;
>  	int ret;
>  	int i;
> =20
> -	irq =3D pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
> +	irq =3D pci_alloc_irq_vectors(pdev, msi_min + dma_irqs,
> +				    msi_max + dma_irqs, PCI_IRQ_MSIX);

[Severity: High]
Will strictly demanding the extra dma_irqs break probe on IRQ-constrained
host systems?

If the host platform can only supply fewer vectors than the minimum
requested here (which can inflate up to 10 if the endpoint advertises 8
DW eDMA channels), pci_alloc_irq_vectors() will return a negative error
code.

Should the driver request only the minimum required for basic NTB
operation, and selectively allocate or disable DMA channels based on the
number of vectors actually granted?

[ ... ]

> @@ -486,7 +799,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, =
int pidx, int idx,
>  	if (bar < 0)
>  		return bar;
> =20
> -	mw_size =3D pci_resource_len(ntb->pdev, bar);
> +	mw_size =3D ntb_epf_mw_size(ndev, idx, bar);
> =20
>  	if (size > mw_size) {
>  		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",

[Severity: High]
This is a pre-existing issue, but can concurrent calls to
ntb_epf_mw_set_trans() corrupt the memory window configurations?

The function writes to a shared set of registers across memory windows
right after this block:

writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);

It then calls ntb_epf_send_command(), which is where ndev->cmd_lock is
finally acquired. If multiple threads configure different memory windows
concurrently, can their writes interleave and send a corrupted mixture of
addresses and sizes?

[ ... ]

> @@ -785,6 +1114,12 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  		goto err_init_dev;
>  	}
> =20
> +	ret =3D ntb_epf_dma_init(ndev);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize endpoint DMA\n");
> +		goto err_dma_init;
> +	}

[Severity: High]
If the endpoint advertises an unsupported DMA type, or if the host kernel
is compiled without CONFIG_DW_EDMA, ntb_epf_dma_init() will fail. Does
this mean the entire NTB device initialization will completely abort here?

Since the DMA extension is optional, would it be better to log a warning
and fall back to the existing non-DMA path instead of completely rejecting
the device?


While reviewing this file, I also noticed a pre-existing issue in
ntb_epf_spad_read() and ntb_epf_spad_write() which are not modified by
this patch:

[Severity: Critical]
This isn't a bug introduced by this patch, but is it safe to use the SPAD
offset directly from hardware for an IOMEM read or write without
validation?

In ntb_epf_spad_read(), the offset is read dynamically:

offset =3D readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
offset +=3D (idx << 2);
return readl(ndev->ctrl_reg + offset);

Since the PCIe endpoint controls its configuration space, a malicious or
compromised endpoint could modify NTB_EPF_SPAD_OFFSET to an arbitrarily
large 32-bit value. Does this allow the endpoint to trigger an
unvalidated out-of-bounds MMIO read or write on the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182657.3296=
14-1-den@valinux.co.jp?part=3D6
