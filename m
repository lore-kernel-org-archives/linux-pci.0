Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BB36F8F3
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350104; cv=none; b=DvRTyJxFWLeJdjfiI4cMnnVJNZ5PcrDT6cwTqifhzyKSIim1v+CRLfV1090t9btM3xEBkZEsO/cpZOnhUIxSjkU60AmyvUfMojMBSJVlGtTIboJlVo7vajxPfur1qmijogtryniXx0Ucov5WdSpcB1DwZqrMfJS6FjRdL/5tqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350104; c=relaxed/simple;
	bh=62tPl4Ux6apd6OagiUD8fLfJ0sL+/tGkI1ZQKyBh0W8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IohFdRaBS/C+r+iWVA0C6HXttsklpaqbpBTEShxckfL2Tv7v7jOPI3no0vY8uJ3WfX4nKGG2Ae3n+uqQ1tfDY3jYnnfUwAwIBNcXuoNzx4MeN0PBFht0g7LylTRMFWjvX9GKJFpbAZ5kt6lNPv45NJo6D6lfencF5c6qU4CUEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g42VqN4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g42VqN4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1541F000E9;
	Thu, 21 May 2026 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779350102;
	bh=ikHBYtVMOkqaK0KNQfTcAkIk1uWhSmWImBbxqG8Cnb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g42VqN4uFjA9e+1MvElPtqLnHAMmyb6vHzzmEmIo/lmFygqhrXKee0Lq+F2CDHaCy
	 4R24oTqLIWuyl5kUTOaU23tL+jdioqbDfVdMQ/Zf7lf+WRu+D+f7vf//adjuPYE7IW
	 iDJAgSpZvpCDKd52/6wCLCh12caCwtovo6IMFlU5J5lqBfJPQRDwlxLz8CumjlCSfu
	 +u4rMVbOUc2b2URAsc57WpT4f25zif0tiv90Jh4HW6EontrtXJhd+CKMI77fo+lqHZ
	 yXoLAb4X0Jh6vv88+VPSquVDvetsXomtmffO/iyGRqSr0VlSN89M5E+n9aSRMg5Z2L
	 A2d/itlhuvfQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521063405.2842644-4-den@valinux.co.jp>
References: <20260521063405.2842644-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 07:55:01 +0000
Message-Id: <20260521075502.1A1541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch calls an undeclared and undefined function `dw_edma_find_=
channel()`, which will cause a compiler and/or linker error.
--

commit 6e9a36a5dc50b6bc919bd1b6f0c48ad7a48f16d3
Author: Koichiro Den <den@valinux.co.jp>

PCI: dwc: Expose endpoint DMA resources

Expose the DesignWare endpoint-integrated eDMA register window and linked-l=
ist
descriptor memories through the EPC auxiliary resource API. This allows end=
point
functions to decide which channels to publish to the host.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index a396b58d67462..6612d5981edb4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
[ ... ]
> @@ -909,6 +922,62 @@ dw_pcie_ep_get_aux_resources(struct pci_epc *epc, u8=
 func_no, u8 vfunc_no,
[ ... ]
> +	for (i =3D 0; i < edma->ll_wr_cnt; i++) {
> +		struct dw_edma_region *ll =3D &edma->ll_region_wr[i];
> +
> +		if (!ll->sz)
> +			continue;
> +
> +		resources[count++] =3D (struct pci_epc_aux_resource) {
> +			.type =3D PCI_EPC_AUX_DMA_DESC_MEM,
> +			.phys_addr =3D ll->paddr,
> +			.size =3D ll->sz,
> +			.bar =3D NO_BAR,
> +			.u.dma_desc =3D {
> +				.dir =3D PCI_EPC_AUX_DMA_EP_TO_RC,
> +				.hw_ch =3D i,
> +				.dma_chan =3D dw_edma_find_channel(edma, true, i),

[Severity: Low]
Does this code build? I couldn't find a declaration or definition for
dw_edma_find_channel() in include/linux/dma/edma.h or anywhere else in the
tree. Will this cause an implicit function declaration error and break the
build?

> +			},
> +		};
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063405.2842=
644-1-den@valinux.co.jp?part=3D3
