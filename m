Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4393D0C1C
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693662; cv=none; b=WV3huuKJQmPb7KM1VNGdjnIRuMSZm1Y8oWzl2J7dyds/FL6Myo8KemzdX9RbxykeCS8mIEhBiu1fqh39BXa8fk2tub9MbqIlkT6jgplqweySu3+iZrwFcZvGg3A53H3PTAMecG6VWPQv4fTZhwm48tH2jvQLIW2hASgL9xDwVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693662; c=relaxed/simple;
	bh=NY42teFn0Gm4EI9hPiXa85HZFayEANbf/aUDxiBfJPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=daH0SIzTShBc6kxiv4AgbMcZSsB2A1s+Hafxq4eniE9BSynSRW8OJVG37Rollf/KpInMSo3sK6K1uUhqf11DEhZtHMOR6iRY4ti04zZa61k9o4Wi3esILWDfUTwxJkXTTu8z/YzY6Xnvx74trD5i12HPb9HLYLxnJ7XVoCreAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G021kx6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G021kx6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE6B1F000E9;
	Mon, 25 May 2026 07:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779693661;
	bh=mU1ym/ThA40FzXscbvp5btpBdaJ23gk2buexBAnwRsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G021kx6ZuSVSvB3o5FlrZLpvSaezWgZAz1qApGYaz2QK5hU4B39meYch+49QPPEa3
	 AvfnPYZIwCBMnKWyP1b0RthbmOwvnv1Yb/9xI/fpVorJapt3DOOMresIr7/j2All5I
	 i+A3bu5xZEcZR1NuVONqB9R5K0aIVa4PpcP1I4zJ5DV3ZqfSjtqG8PHkJQ975o58Xu
	 rMeK9px8g00EylY92vNEOWQwxqCoZAkOuqtyTlcBEKoTtlaausudaN+rxpMngDUP/C
	 OXYRQOX3WlQwHdvNyBEWReq13OKL5sIDeI+3mZRAFrM1SuY2v+aHFtcNitSxNynngn
	 11nVLn64maIBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260525063129.3316894-4-den@valinux.co.jp>
References: <20260525063129.3316894-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 07:21:00 +0000
Message-Id: <20260525072101.5BE6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces usage of an undefined structure `struct dw_edm=
a_hw_chan_filter` and an undefined function `dw_edma_filter_hw_chan()`, res=
ulting in a build failure.
--

commit 589f8b781fa00c9df917830bfed25275efe738de
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

This commit exposes the DesignWare endpoint-integrated eDMA register window
and linked-list descriptor memories through the EPC auxiliary resource API.
This lets endpoint functions decide which channels to publish to the host.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index a396b58d67462..fab132b26cc42 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

[ ... ]

> +static bool dw_pcie_ep_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	const struct pci_epc_aux_resource *res =3D param;
> +	struct dw_edma_hw_chan_filter filter =3D {
> +		.dma_dev =3D res->u.dma_desc.dma_dev,
> +		.write =3D res->u.dma_desc.dir =3D=3D PCI_EPC_AUX_DMA_EP_TO_RC,
> +		.id =3D res->u.dma_desc.hw_ch,
> +	};
> =20
> -	return 1;
> +	return dw_edma_filter_hw_chan(chan, &filter);

[Severity: Low]
Does this code build successfully? Looking at the included headers, it appe=
ars
struct dw_edma_hw_chan_filter and the dw_edma_filter_hw_chan() function are
not defined in include/linux/dma/edma.h or elsewhere in the tree, which mig=
ht
result in a build failure due to an incomplete type and implicit function
declaration.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525063129.3316=
894-1-den@valinux.co.jp?part=3D3
