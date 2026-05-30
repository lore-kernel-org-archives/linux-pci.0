Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2863246E8
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157293; cv=none; b=M9U368BQHIN0hrm9IKfqeFfsH/B5Hav1e7sGFOJpRh8+oVl4oD3m4xAGBDj6VYUk79yTeduBih/+FD4VeBZ2lq/vFx4hh0UHy/Vn+wLGW1cfrIBHtM9OiL/+ZR+MAdrbqNnOTjuUOl+Qds4U3YlH5cYYxmsT8JszEjZEH8HA7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157293; c=relaxed/simple;
	bh=mP+OLlEQH7pdUBBKc6nJx4agy9TnZYmNhVW7sroMPI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ky92oRF8H5T5xDKCja9DzkLkXQ0vCTdRfZS6/sfZOxbrnoBAAPbbs/ajLSjnBrjK/aGUyd9WNiNI/9I/L0QB7DRuBDLKYyWOyYiScrRF5rc4X2GszVYHaWWGzA0it3bFZuZaxLALB7oM+5DgjeS2IAWe46a4dKtMRU46DrKtvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjaUNEgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjaUNEgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CBC1F00893;
	Sat, 30 May 2026 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157292;
	bh=LOHwH1QRxbcSvA8KPZrOFO51UNxcmCq01TL04qVpXyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjaUNEgEahjEZMO6RYR8JE0CDmwRoK/+D8zHbk2Vl7w1oul8Yo4BwVlnkwU1aZpgz
	 HU8j2OpnXth9qe88+uxGOipsLw30y8rVZDY7i5w/xPimABydlYCsUlnV0lzlQFwI4+
	 M0ri3aKD9+P7H5WjNecGntPcLdIYeKKtNNajTlOQqMrlW8GHvJ83CEKHLU2RnRKqnE
	 H1PqWcWFlrDNETkbqWE+1hr/snW1E/zrBfgZ+2O6cyx+QIP7vBzk7011hv8lh2+FNm
	 IcA8kt+znhXd97b/mTJs2yRmIyScGAa7rm0nRhItaJkPrrD9vD/WHkjhQ5zLWB7Hvp
	 /bwZaILQqsbYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-11-18255117159@163.com>
References: <20260530153101.695580-11-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:08:11 +0000
Message-Id: <20260530160812.48CBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch replaces `dw_pcie_find_capability()` with a cached `pci-=
>pcie_cap`, but hardware clocks are not enabled during `dw_pcie_ep_init()` =
on `qcom-ep`, causing an unclocked MMIO access or caching an invalid 0 offs=
et that later corrupts standard PCI configuration space.

Pre-existing issues:
- [High] Concurrent execution of global and PERST threaded IRQs causes fata=
l unclocked MMIO accesses and data races.
--

commit 4d4786c3c255dd8f971ef41e85f15f1fa9ead9d4
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: qcom-ep: Use cached PCIe capability offset

dw_pcie_ep_init() calls ep->ops->pre_init() (enables hardware) and then
dw_pcie_get_pcie_cap() to cache the offset. Therefore, the IRQ handlers
run after the cache is populated, so they can safely use pci->pcie_cap
directly.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 56184e6ca6e69..0471f96d3c781 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -307,15 +307,13 @@ static void qcom_pcie_ep_icc_update(struct qcom_pci=
e_ep *pcie_ep)
>  {
>  	struct dw_pcie *pci =3D &pcie_ep->pci;
> -	u32 offset, status;
> -	int speed, width;
> -	int ret;
> +	int speed, width, ret;
> +	u32 status;
> =20
>  	if (!pcie_ep->icc_mem)
>  		return;
> =20
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	status =3D readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +	status =3D readw(pci->dbi_base + pci->pcie_cap + PCI_EXP_LNKSTA);

[Severity: High]
Does this caching work safely on qcom-ep? The commit message states that
dw_pcie_ep_init() calls pre_init() to enable hardware clocks. However, for
qcom-ep, clocks are only enabled later via qcom_pcie_enable_resources() in
the PERST deassert IRQ path.

This means clocks are disabled during dw_pcie_ep_init(), which will either
cause a synchronous external abort when reading the capability, or result in
pci->pcie_cap being populated with a cached offset of 0.

If pci->pcie_cap is 0, won't this readw() fetch from pci->dbi_base + 0x12,
which is part of BAR0, instead of the link status register? This could fetch
incorrect values and break interconnect bandwidth scaling.

[ ... ]

> @@ -492,13 +490,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie =
*pci)
>  	dw_pcie_dbi_ro_wr_en(pci);
> =20
>  	/* Set the L0s Exit Latency to 2us-4us =3D 0x6 */
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	offset =3D pci->pcie_cap;
>  	val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  	FIELD_MODIFY(PCI_EXP_LNKCAP_L0SEL, &val, 0x6);
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, val);

[Severity: High]
Similarly, if pci->pcie_cap is cached as 0 because clocks were disabled
during initialization, won't this overwrite the base PCI configuration head=
er?

Using an offset of 0 means offset + PCI_EXP_LNKCAP evaluates to 0x0c, which
would erroneously modify the cache line size, latency timer, header type,
and BIST registers instead of the link capabilities register.

[Severity: High]
This is a pre-existing issue, but is there a race condition between the
PERST IRQ thread and the global IRQ thread that can cause a panic?

The qcom_pcie_ep_perst_irq_thread() and qcom_pcie_ep_global_irq_thread()
execute concurrently without mutual exclusion. If the host asserts PERST
while the global IRQ thread is processing an event, the PERST thread will
disable clocks:

qcom_pcie_ep_perst_irq_thread()
    qcom_pcie_perst_assert()
        qcom_pcie_disable_resources()

If the global IRQ thread is simultaneously performing MMIO access:

qcom_pcie_ep_global_irq_thread()
    status =3D readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);

Could this MMIO access while clocks are asynchronously disabled cause an
immediate synchronous external abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D10
