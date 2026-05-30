Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888D2F12AB
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157166; cv=none; b=nHLgGGqulFW+iDga8oFb1O2BzoPaTikNlYFdwVdR3uP9MIxbLR3/VYb+wy2GLi28C5aoPNHCHPLS6GhM8gJqnQlOC3dlvsT1CTlm0jGt8xrjnhncU6jjOVTvncOx5XLQC4OLM1RlxhTzTOzlKFOeQejMoVSlViYXNg3GOO3cgRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157166; c=relaxed/simple;
	bh=NoSEsysmPuKo+2842O7y2Ja1eXh15xCM/nCllJRLzyI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UNtY/hLocLjc3PsGzDb1f64BWNN0QfWPOUQvz+7lsDa+f45/RdJbPIVgYwWn9ZRlpqaXUllQ+Bzac++q9ElqHj32IyYwGY6TCTUrIKHPaJBJxwWV1HKRcSlGoYl88iqps4eZ5irjcWkMM1RMiomZ3NOxlceUqJGYCUVV/NZJVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNF7cBJB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNF7cBJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C311F00893;
	Sat, 30 May 2026 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157165;
	bh=rELWmQF2agNh70vcoUyQEuo0p83GavllqyaSkcF0nTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNF7cBJBCSJWXhGZVp7BUqv6Q1DSlBXWx8+wglI++G2zubdtwRQfSNQMy7KbdSNMg
	 RY7Z5MdrkN/r/MZFjgjCKhsm0H+ypnAQgKXJmQ4Y1DOyXnvrFn7G+9h5sPuBQh6KOX
	 jeZV2vmA0ZKdg7pXoraoDRkiqeeaNoa4PsZTPxomCbqXapUvxKxR2X1Ihuw8FWtHdt
	 R9u9WD1V2H09Gid6m9vZvlx45frusWc7LnhDQ+oKOcR8CO/bqWnnLEOXjKlUlI88KO
	 D/Qfq/Dw4FSIuyra7plZEHZeCIaxAXJIfPRd+OwwAPUUMGu3AorrdocMqQf5MfPJ9Y
	 h2Q25NTnXxicQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/16] PCI: dwc: spear13xx: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-15-18255117159@163.com>
References: <20260530153101.695580-15-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:06:04 +0000
Message-Id: <20260530160604.E4C311F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Uninitialized variable usage leading to PCI register corruption.

Pre-existing issues:
- [High] Race condition in shared IRQ registration causing NULL pointer der=
eference.
--

commit f26cde06f20af920dcaa766788767c35c06c971e
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: spear13xx: Use cached PCIe capability offset

Inside .init we must call dw_pcie_get_pcie_cap() to obtain the offset,
because the core has not yet cached it. The hardware is already enabled
by the driver's own initialization before this point.

> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/co=
ntroller/dwc/pcie-spear13xx.c
> index 01794a9d3ad29..6e4c11b497d45 100644
> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
> @@ -122,7 +122,7 @@ static int spear13xx_pcie_host_init(struct dw_pcie_rp=
 *pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct spear13xx_pcie *spear13xx_pcie =3D to_spear13xx_pcie(pci);
> -	u32 exp_cap_off =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 exp_cap_off =3D dw_pcie_get_pcie_cap(pci);
>  	u32 val;
> =20
>  	spear13xx_pcie->app_base =3D pci->dbi_base + 0x2000;

[Severity: High]
This is a pre-existing issue, but is it possible for a shared interrupt
to fire before app_base is initialized here?

In spear13xx_add_pcie_port(), devm_request_irq() requests the shared IRQ
before dw_pcie_host_init() is called. If the shared IRQ fires early,
spear13xx_pcie_irq_handler() will execute and unconditionally read from
the uninitialized app_base:

drivers/pci/controller/dwc/pcie-spear13xx.c:spear13xx_pcie_irq_handler() {
    ...
    struct pcie_app_reg __iomem *app_reg =3D spear13xx_pcie->app_base;
    ...
    status =3D readl(&app_reg->int_sts);
    ...
}

Because app_base is still NULL, would this result in a read from physical
address 0x18 and lead to a kernel crash?


Additionally, an issue was found in another commit in this series:

commit 1d7762e21cba69c340ccc430485c442e06488028
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: qcom: Use cached PCIe capability offset

dw_pcie_host_init() caches the offset after .init, so .post_init callbacks
and later functions (.link_up, icc_opp_update) can use pci->pcie_cap
directly. For .init itself, we must call dw_pcie_get_pcie_cap() inside
qcom_pcie_host_init() to obtain the offset (hardware is already enabled).

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 11fc604898926..80783353d5398 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
[ ... ]
> @@ -360,7 +360,6 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *=
pci)
> =20
>  static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
>  {
> -	u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
> =20
>  	dw_pcie_dbi_ro_wr_en(pci);
> @@ -370,9 +369,9 @@ static void qcom_pcie_set_slot_nccs(struct dw_pcie *p=
ci)
>  	 * notifications for the Hot-Plug commands. So set the NCCS field to
>  	 * avoid waiting for the completions.
>  	 */
> -	val =3D readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +	val =3D readl(pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);
>  	val |=3D PCI_EXP_SLTCAP_NCCS;
> -	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> +	writel(val, pci->dbi_base + pci->pcie_cap + PCI_EXP_SLTCAP);

[Severity: High]
Since qcom_pcie_set_slot_nccs() is called during qcom_pcie_host_init()
via the pcie->cfg->ops->post_init(pcie) callback, is pci->pcie_cap
guaranteed to be initialized here?

The DWC core in dw_pcie_host_init() appears to cache pci->pcie_cap only
after the pp->ops->init callback returns. If pci->pcie_cap is still 0
when this executes, won't this write to offset 0x14 (PCI_BASE_ADDRESS_1)
and corrupt the configuration space instead of configuring the intended
slot capability?

[ ... ]
> @@ -935,7 +934,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pci=
e)
>  static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci =3D pcie->pci;
> -	u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;
>  	u32 val;
> =20
>  	/* Force PHY out of lowest power state */

[Severity: High]
Similarly, will pci->pcie_cap be 0 when qcom_pcie_post_init_2_3_3() is
called from the post_init callback during qcom_pcie_host_init()?

If so, this would result in a corrupted offset here as well.

[ ... ]
> @@ -1257,7 +1256,7 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *p=
cie)
>  static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci =3D pcie->pci;
> -	u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;
>  	u32 val;
>  	int i;

[Severity: High]
Does this suffer from the same uninitialized pci->pcie_cap issue as
qcom_pcie_post_init_2_3_3() when called from the post_init callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D14
