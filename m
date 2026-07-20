Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863B2BE7B6;
	Mon, 20 Jul 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560815; cv=none; b=SwGY85Ajl/JXRTuhB/Rimyk2fenTLtoB/k9GACOQsoCzQ6aaHf2LuiL4DMTfVErN3dYGQrLc4Xn2RN8xu2HsFHKFAMA6vTbxEGRoRA4RPOYB+lLrJW5JQ/DA1V73mzy8e1mJN81igrrky1N6F5iMLgpnGiNaJkFz9gqO0MY11Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560815; c=relaxed/simple;
	bh=mtpZkPly4do1/oEOk5Z427UFpCunKnrEdUlu7UwyVuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rybOiOj6Y2TZJHIkbiRbZ1G8uTVTnIFBW7++T31eY6UIZxoyfq/YtgLf+4WQbhvXIz4M2XPAn+1Xj/CZ53aDOGhh1/qJClSCD+Mb1Vn1CnKH3IPVfp/Puo24b1W1hSOZM6b4A6CyPTL7LmGu6Q3ONToh0s4X09abkyWNthPloL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1IxprBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1IxprBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56B41F000E9;
	Mon, 20 Jul 2026 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560814;
	bh=SwfpXQPoaTcvlBYIYTlkGGyq666sRXZI2K4qaGD2QME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1IxprBiKXixwIXV5CEchwkIUFEWibywh+d4ePFGmlpUGuUC6CWYymRQz6aLdwY21
	 NZdVXj3uE4b3jbHesxXKwg2hq4q/aEsPxFInCtTB3+1OGYC13SHUu8biilKnhVYDrb
	 TyLJtRg553RG/mD+Z9YazdWtbcmGjrMn3snqDVGKzKWUeN6h6hm9NlS6JnqXYVYJ7U
	 hJlTma59UzoWSOX+8v4a8T9LfED07Apb/Kh+sIkQ1ThzVRNFCifIBs8GLTPdJ0ncYW
	 rtG7PFdtdp0WQhGiHQ8Gbg4zRGJWEALJBf3Cwfwy24nE+SP89KJBaC0PulkUsPka0c
	 bda9pY+to0FUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/16] PCI: dwc: sophgo: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, linux-amlogic@lists.infradead.org, Frank.Li@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260720150619.24733-13-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-13-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:20:13 +0000
Message-Id: <20260720152013.E56B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the INTx IRQ dom=
ain and chained handler are leaked on probe failure, which leaves a danglin=
g pointer in the active IRQ handler and leads to a use-after-free if the in=
terrupt fires.
--

--- Patch [12]: [PATCH v3 12/16] PCI: dwc: sophgo: Use cached PCIe capabili=
ty offset ---
commit 2e86ab7dbd69d3bcfaa3d7b4f601df27c48317f3
Author: Hans Zhang <18255117159@163.com>
PCI: dwc: sophgo: Use cached PCIe capability offset

This commit modifies sophgo_pcie_disable_l0s_l1() to use the cached PCIe
capability offset rather than searching for it again. The offset is fetched
via dw_pcie_get_pcie_cap() inside the .init callback.

> diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/contr=
oller/dwc/pcie-sophgo.c
> index 044088898819e..39703d2b7b5f2 100644
> --- a/drivers/pci/controller/dwc/pcie-sophgo.c
> +++ b/drivers/pci/controller/dwc/pcie-sophgo.c
> @@ -164,9 +164,10 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp=
 *pp)
>  static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> -	u32 offset, val;
> +	u8 offset;
> +	u32 val;
> =20
> -	offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	offset =3D dw_pcie_get_pcie_cap(pci);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the call
chain from sophgo_pcie_host_init() to sophgo_pcie_disable_l0s_l1(), I
noticed a potential issue with how the INTx IRQ domain is handled during
probe failures.

In sophgo_pcie_host_init(), the IRQ domain and chained handler are set up:

        irq =3D sophgo_pcie_init_irq_domain(pp);
        if (irq < 0)
                return irq;

        irq_set_chained_handler_and_data(irq, sophgo_pcie_intx_handler, pp);

If dw_pcie_host_init() subsequently fails during sophgo_pcie_probe(), devres
will free the struct sophgo_pcie structure, including the pp pointer.

However, there is no .deinit callback in sophgo_pcie_host_ops to call
irq_domain_remove() and irq_set_chained_handler_and_data(irq, NULL, NULL).

Could this leave a dangling pointer in the active IRQ handler, leading to
a use-after-free if the interrupt fires?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D12
