Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C029AB02
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157217; cv=none; b=WUKEtx+O6MNpgl3zDILNM7dp20hRtl/e/pevzzNhL1qwLfEtkJaZvxMXc+7yrNJ0tChwWe/TeITYFHKfVD5415enJlReIbU0I6s0Hru4Jxi8kesYcdpzDtGrdLCfvjq9zhkNXaS4854M21O1kq0o+HBEZhAxd3py5AnLColI4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157217; c=relaxed/simple;
	bh=Q3HvCQN6djREdx5JdXf2GFNdAZ4e0Xhkg0CbGZeTzm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RA/kQkXeFGcnhxWWPi53HpIjqgTz33X6jU2L5t7ZBkJAHLBw0Xdu0HXNstLFAa075fZvJn7stGpJ7E+OFIhVNaWeKHqncBGnTyWjzZqot3UraaTkfBBCEfXX/z69sFv7mYOL7CcZIdndwkM+Py8xRiHecY32FwwN5/ZIQ/5tPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZxvmI3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZxvmI3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784951F00893;
	Sat, 30 May 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157216;
	bh=ypT9C3lzSkfdiGFEWkowSlAXYvvYnLv7GtxA7ig57ww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZxvmI3Pz2mjQZ7WsrQBohscupVhcjTy+C3Tp5HPNyE9KSL1LeGI9f+3eWAbtCjdz
	 /RR1LZibp2+Ut6IqckMsKoSnF7Xgk4QW0nhJAWI/+EHvkox1lWA2K6MmWbkZ94DhrO
	 RptAna887Ax7GOdBjlJiBK20ept3952H0J6tej2qOpV2O45NjWg5b9mNUxOYmk58Ca
	 /6ZFhiBHABCO/+splKTCDoS5SvEJMyQfmYtg9frFBpHorwGyZWW2M8kRDpV1+HQEAV
	 8hnwdS7ng91+H837ivw/y0lHnsFKAsps6KxJbpOJXzldfS81M/HsX8nUiZsytXR+1D
	 IlGecgfnFUv7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/16] PCI: dwc: qcom: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260530153101.695580-12-18255117159@163.com>
References: <20260530153101.695580-12-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:06:56 +0000
Message-Id: <20260530160656.784951F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized cached PCIe capability offset causes memory corrupti=
on in PCI configuration space.
--

commit 1d7762e21cba69c340ccc430485c442e06488028
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: qcom: Use cached PCIe capability offset

This patch replaces calls to dw_pcie_find_capability() with the cached
pcie_cap offset in the designware PCIe driver for Qualcomm. It aims to
optimize access to PCIe capabilities by reusing the offset.

>     For .init itself, we must call dw_pcie_get_pcie_cap() inside
>     qcom_pcie_host_init() to obtain the offset (hardware is already enabl=
ed).

[Severity: High]
Does the patch actually make this call? It appears this was left out of the
code changes.

Without this call, pci->pcie_cap remains uninitialized (0) when the
.post_init callbacks run.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 11fc604898926..80783353d5398 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

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
Will pci->pcie_cap be 0 here?

Since dw_pcie_get_pcie_cap() is not called prior to this, pci->pcie_cap
evaluates to 0. This causes the code to write to offset 0 + PCI_EXP_SLTCAP
(0x14, which is PCI_BASE_ADDRESS_1) instead of the actual capability,
corrupting the Root Port hardware configuration.

[ ... ]

> @@ -935,7 +934,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pci=
e)
>  static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci =3D pcie->pci;
> -	u16 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;

[Severity: High]
Does this also suffer from the uninitialized pci->pcie_cap?

Because offset becomes 0, subsequent writes using this offset (like writing
PCIE_CAP_SLOT_VAL to PCI_EXP_SLTCAP) will also corrupt BAR1 instead of upda=
ting
the PCIe capability register.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530153101.6955=
80-1-18255117159@163.com?part=3D11
