Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB530DD11;
	Mon, 20 Jul 2026 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561342; cv=none; b=S2cn+SrPyjpuH95xE1J/EWc9wzAM0Inh6EB011HsbIQfSTK/Pj9kBlxtI0ZATadHOTgH/KHlwFjxA6yWNi9ZU8MM8IQnp4s1BvcgDYQyOA8KmKN/KhqyEYmrudZABgRC18eCW7aCrcVAiP+XBOe47lOcG/uREJcg7KqQ+sLMd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561342; c=relaxed/simple;
	bh=bS59bsexk7Y1qcyfUhrTvgTV4NITiDxL0etcJ7UUTj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtYK4d0Yi8pinZsvnSIx00WbS3KvuzVRXKduI8s31TVmQ62WOg2eRc/x6XpJoCdg5fxP1Vijyzg7VAHXoERXr0Gqd6x8wiXT2v8sr/7e/wimWFtOD8EIDvQIAvF8JCCRLYBRQerP4ufVLloJ4vM0tplTzawGCJ1xxVVCSQbbxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxhpIzmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxhpIzmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B149B1F000E9;
	Mon, 20 Jul 2026 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561339;
	bh=k4tfXZpVPdc5h7uRxAV7A3+7LziVLeKXHPXqV3dcWDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CxhpIzmxHWNPVzq0yogacdMFXSQH+EfpAfV0yeIuofIORk94cDmfgImC0MTUlN3mN
	 jaTE7MXxCbOC2jUV+Qxw0eFZhBLtAMRRkD5h+V76PeZdrp5x23LVZysyMseASGlWU8
	 6cQOqx5oBT6zJapgP9HNUCFKjc09YJjPACid1JlrpPLcTKyQDdJJbaxq6r7hfkEpM7
	 GGcDT69tPYPZo8B81Cx1S19vAeDIS0jEOwXLDLqeurDQ9D8hapMTgaZ0oUcLkmlne5
	 WkgzrYNHLxXMiHBejCvfxrqiYoKGVau1vN+FBJomWzDgKgpS3CpxbcAQbuxWvytS/J
	 vLT8hy2/OiV0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, neil.armstrong@linaro.org, Frank.Li@kernel.org
In-Reply-To: <20260720150619.24733-3-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:28:59 +0000
Message-Id: <20260720152859.B149B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized `pci->pcie_cap` used in Endpoint mode causes severe =
PCIe configuration space corruption.
- [Low] Unnecessary PCIe capability search and unused variable left intact.
--

--- Patch [2]: [PATCH v3 02/16] PCI: dwc: Use cached PCIe capability offset=
 in core ---
commit 1e2ce6ece477d5f9c179f2ac4c13cd06cf764f59
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Use cached PCIe capability offset in core
   =20
Modify the DWC core functions to use the cached pcie_cap offset instead
of calling dw_pcie_find_capability() each time.

[ ... ]

> dw_pcie_ep_init_non_sticky_registers() now assumes pci->pcie_cap is
> valid. if not, it prints a warning and skips the operation. The other
> functions run after probe, so pci->pcie_cap is already valid and can
> be used directly.

[Severity: High]
The commit message mentions adding a warning and skipping the operation if
pci->pcie_cap is not valid, but this check appears to be missing in the
code below.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 7d2794945704e..14228be8bbce7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1246,7 +1246,7 @@ static void dw_pcie_ep_init_non_sticky_registers(st=
ruct dw_pcie *pci)
>  	 * to all other functions as well.
>  	 */
>  	if (funcs > 1) {
> -		offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +		offset =3D pci->pcie_cap;

[Severity: High]
Without the validation check mentioned in the commit message, if
pci->pcie_cap is uninitialized (0), will this lead to corrupting the
standard PCI configuration space header registers instead of the intended
capability registers?

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index ec4722ed93032..810729b918928 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -806,8 +806,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> =20
>  	pci_host_common_link_train_delay(pci->max_link_speed);
> =20
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	val =3D dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +	val =3D dw_pcie_readw_dbi(pci, pci->pcie_cap + PCI_EXP_LNKSTA);

[Severity: High]
If pci->pcie_cap is 0, this will read from 0 + PCI_EXP_LNKSTA (0x12) instead
of the actual capability offset. Could this lead to failed link status
checks?

[ ... ]

> @@ -890,7 +889,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie=
 *pci)
>  int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
>  {
>  	u8 cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	u32 lnkcap =3D dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);

[Severity: Low]
Is the cap variable still needed here? It looks like it is now unused, which
might cause an unnecessary MMIO read during the capability search and trigg=
er
a compiler warning.

>  	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
>  }
> @@ -898,7 +897,6 @@ int dw_pcie_link_get_max_link_width(struct dw_pcie *p=
ci)
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num=
_lanes)
>  {
>  	u32 lnkcap, lwsc, plc;
> -	u8 cap;
> =20
>  	if (!num_lanes)
>  		return;
> @@ -935,10 +933,9 @@ static void dw_pcie_link_set_max_link_width(struct d=
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
If pci->pcie_cap happens to be 0 here, this will perform a read-modify-write
at offset 0 + PCI_EXP_LNKCAP (0x0C). Could this destroy the standard
PCI Header Type and BIST registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D2
