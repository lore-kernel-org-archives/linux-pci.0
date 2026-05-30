Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8672BE05F
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157470; cv=none; b=mv+Ote1p225z/1BcBrjCLkMjl7YPHnOoviys3Gzcng3HnDNN3u5cIsY3MbZpqQliij0AtCDvq32/+ReJE1dlIY6pgJkvayxAO+2EMC+7bZQEOfU3I496pFgiwR8Lyf5SWynVcdKDX+/MET7RHSZ+BkJTCd5eyaB2ievpmKqH5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157470; c=relaxed/simple;
	bh=LDIBaJwzOeZ8hx+h4CfQneJA5xXeavHkIfFenLuukAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EL9KbRNfdQjTZHdz4XCy+2bJRJKiVo4/RtB59OR8YBB/oUfLTlzR58It1RubhZQyL9OGg9x3OgsezJS8THVnwxuhClrqfwl6qE6Wh6U0CwawxFPQjNGydaMdWUBHa1FDJXTMWFPdlwyyAnSM5cT3HPcp7PfxHNfXjiRyxwxSCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beTmcuDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beTmcuDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993C21F00898;
	Sat, 30 May 2026 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157468;
	bh=ns/xAuU61sfpsARRotmyVAMGoK6jiPPOxRVhl8mPSAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=beTmcuDFH36qSEJqr8euhtE+2+/eP3DM9NyH9sQXbe5QsumhVkA7/lcRSBs2xGyV+
	 y5QrdGQR+5QzWVHq6LZPOp0rwwj3fVCuHsb6a3mIRTwAo54yMf1INMDKfHdxRy/KUp
	 nF9FRwiFDybhsMqCFFbBGhGNCYIiu1dDnLQuRQeY7uQKFOGjR4Bu1kAfaZYwv8jcQR
	 7ygsAQQiOJqORDl6XfhUwkhzOnM/UGaIWJmQh6w/y7Gdp979KPxDZhI7hAZj/X2i4R
	 Mf5w1bmees23FOGHHbfivw1HdlNL8l58yCYp7F2yVb3RtqaUuPXJvA7D5PkstSvYXe
	 wgNlZFe9UsYWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-3-18255117159@163.com>
References: <20260530153101.695580-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:11:08 +0000
Message-Id: <20260530161108.993C21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct usage of cached `pci->pcie_cap` leads to incorrect offset c=
alculation and DBI corruption in endpoint drivers with deferred hardware en=
ablement.
--

commit 02cd0d194f8ffdc28d0564602c5f35da3c6e8582
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Use cached PCIe capability offset in core

This patch modifies the DWC core functions to use the cached pcie_cap offset
instead of calling dw_pcie_find_capability() each time. The cached offset is
initialized after hardware is supposedly ready in host and endpoint modes.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index a396b58d67462..11b4fa6d129c7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

[ ... ]

> @@ -1524,6 +1524,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ep->ops->pre_init)
>  		ep->ops->pre_init(ep);
> =20
> +	dw_pcie_get_pcie_cap(pci);
> +

[Severity: High]
Does this code incorrectly attempt to read the capability offset before the
hardware is powered on in endpoint drivers with deferred enablement, like
qcom-pcie-ep?

In these drivers, hardware resources like clocks and PHY are not enabled
during initial probe, but are deferred until the host de-asserts PERST#.
Because the DBI space is unclocked and inaccessible at this time, reading it
can either trigger a synchronous external abort or return 0xFFFFFFFF.

This would cause the capability search to fail, leaving pci->pcie_cap as 0.

>  	ret =3D pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
>  			       ep->page_size);
>  	if (ret < 0) {

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 37d2715e38eb4..810e920c1d8b5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c

[ ... ]

> @@ -848,7 +847,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>  static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  {
>  	u32 cap, ctrl2, link_speed;
> -	u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;
> =20
>  	cap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);

[Severity: High]
If pci->pcie_cap is 0 due to the earlier failed capability search in
dw_pcie_ep_init(), will this read and write to offset 0 (the standard PCI
configuration space header) instead of the actual PCIe capability offset?

Since dw_pcie_setup() calls this function after the link is initialized,
operating on offset 0 could corrupt the Vendor ID and Device ID, completely
breaking link initialization.

[ ... ]

> @@ -940,10 +937,9 @@ static void dw_pcie_link_set_max_link_width(struct d=
w_pcie *pci, u32 num_lanes)
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> =20
> -	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	lnkcap =3D dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);
>  	FIELD_MODIFY(PCI_EXP_LNKCAP_MLW, &lnkcap, num_lanes);
> -	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> +	dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP, lnkcap);
>  }

[Severity: High]
Could this similarly corrupt the standard PCI configuration space header at
offset 0 if pci->pcie_cap was not properly initialized?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D2
