Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68CD2F361B;
	Thu, 13 Aug 2026 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603630; cv=none; b=nr4oBpfMV9Uu8Eu6oTiT4dp5aqRu5LycdLKOF9UIPzBOLNudHZS5Pb5ILgD2eUF9SdbaN+CvsE3dBH1IE23DN5rwPtEZQl+hzTDnBV6uawzyyG+Bj62NzbfaMhtfbXEBHiJPuimKX150QSeaV8SlFIqMlxugeY1u3OJNaRRRNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603630; c=relaxed/simple;
	bh=MmiG0fPidy0rcdj0+VijgMAXovLK41qQkxUNAOt25bE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XLyjp4xysJsfKWPRWKx6/EGj/9hYT9Dq8GZ6noLeyHhoCxODnCj6gddeGrxgEpq3NqGdkK++nz3hg43XAMkgLNzcPs04QTwdglddZ1EQugrJw5z4nqi/kajtjQodTmzcyKFM4roXvuFfNJWv+fllqilw6R4ahZ2M21M8h5mFerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsY7cszR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsY7cszR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E6B1F000E9;
	Thu, 13 Aug 2026 06:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603628;
	bh=x2eG15ej2ySVo+wnETSaQcaAJMqjfufoO1e93FnN1iU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KsY7cszR8PNVVJ+i8oN+qW8NGvs8phfCfX3t3O+2CzWTNjehrLv8BfECGGSYzKKJU
	 kasF9FCPUEIB2gDQhR4d4vOhnKVgbLbgYAG/WXb9FCNlNFMrPdurJuCYtBjM+y3x3P
	 CWh6oD8NJoS1vlL4PhBotIE7XGYFHZ/5EFgdfe/JsP7mesAZOjqa/HTQzGQ8ieAcNP
	 TGChAdtQz8xuh9jdqTzmJQF0GNOfLebvKx7ajhIYHjyxurN/EE7upx/oGBm6aaKokl
	 oqyUE2s5FX317SdUyDxZ4PJmI6EV6Y8SVAbmcNatrVRP1kWIiSRa7fb+fWvMU2+2M5
	 B5Vn/KamZv1/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] PCI: dwc: Implement endpoint DMA channel
 delegation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813063757.3131865-7-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:47:07 +0000
Message-Id: <20260813064708.27E6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing validation in dw_pcie_ep_reclaim_dma_chan leading to unsaf=
e downcast and bypass of VF restrictions
--

--- Patch [6]: [PATCH v7 06/10] PCI: dwc: Implement endpoint DMA channel de=
legation ---
commit ade184c0035acad80c032f5a61a7726af2557e6c
Author: Koichiro Den <den@valinux.co.jp>
PCI: dwc: Implement endpoint DMA channel delegation

Implement the EPC DMA channel delegation operations for DesignWare endpoint
controllers. Verify that the DMA engine channel reserved by the endpoint
function belongs to the integrated DesignWare eDMA instance, then hand its
interrupt routing to the host.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

[ ... ]

> +static int dw_pcie_ep_delegate_dma_chan(struct pci_epc *epc, u8 func_no,
> +					u8 vfunc_no, struct dma_chan *chan)
> +{
> +	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	struct dw_edma_chip *edma =3D &pci->edma;
> +	int ret;
> +
> +	ret =3D dw_pcie_ep_check_edma_vfunc(vfunc_no);
> +	if (ret)
> +		return ret;
> +
> +	if (!edma->dw)
> +		return -ENODEV;
> +
> +	if (!chan || chan->device->dev !=3D edma->dev)
> +		return -EINVAL;
> +
> +	return dw_edma_delegate_chan(chan);
> +}
> +
> +static void dw_pcie_ep_reclaim_dma_chan(struct pci_epc *epc, u8 func_no,
> +					u8 vfunc_no, struct dma_chan *chan,
> +					bool quiesce)
> +{
> +	dw_edma_reclaim_chan(chan, quiesce);

[Severity: High]
Should this function validate the channel owner and virtual function status=
=20
before passing it to dw_edma_reclaim_chan(), similar to the checks performe=
d=20
in dw_pcie_ep_delegate_dma_chan()?

If an endpoint function driver calls this with a generic dma_chan from a
different DMA controller (for example, during error unwinding), couldn't=20
dw_edma_reclaim_chan() perform an unsafe downcast when it unconditionally=20
processes the pointer?

Additionally, omitting dw_pcie_ep_check_edma_vfunc() appears to allow virtu=
al=20
functions to manipulate channels they are restricted from accessing during=
=20
delegation.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D6
