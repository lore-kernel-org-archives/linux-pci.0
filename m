Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEED30C606;
	Mon, 20 Jul 2026 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561220; cv=none; b=nijz16wgWhQTfDgTNTqzR18EIATtI3z8xn039QSNhc8jEdnpuPI1Jh+HpcNjk1obJBPlHICLk5um9omVOR7wnSvDrY0Xse/TFVD8MzGs+bFmKm1ArlnxI7fBHbVEvpTsjIvQIcmI4+/Qh6ytL1ZIHAIC8N6iK/3e4g+gN6ggyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561220; c=relaxed/simple;
	bh=OgaxjBhEa6Ca5r56R7HzvVcZBs0Y1Q787/QCUpRvqsk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tk4dzCuquikh9+JBPMEW5gqS3CIN+GSksU/nH5NwzY+szMxMzTelGRq0W4r9yup7makC6DO9LiblMaf5S3kv3niF4G6B2EltzjtAXIH7SUD55/YWeLebORHnl8gjpB7jD7Xpimxc1eCV+XyS9iVQ+4323au8tRkY+KtTzzDYngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2/H/MXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2/H/MXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6101F00A3A;
	Mon, 20 Jul 2026 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561218;
	bh=NKMMf/o3lV9WryRPgZshT1tMeaccZ8lfExMbz1lt68g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2/H/MXrKQFzMc+xl/qWN4r6E64csL6kzRTtp8tILKFtk8egLUGbtnE4PJHp6QHLL
	 9ZI28KrRIsXdO6RO0XyraZBrsRNarI0T4OFisjl6wJUhjqZsMT7xOmOlKGfOUL6NMT
	 KLsPZHDyRJMR+mNnzXQwbecDJT8iyxi3iKtofScLT0KQvza18DNaioFW6B7UZSBUz8
	 hasdDKQyP+QHQsXmjsFaDrlHl6XUi/aBAGUCUm3Mtv/WhkeAvg++XTUaJK/Q0P4RyH
	 pTuaRtiyOwly/DWFjj4eCoaDs6fNXMtVHYS231GM9mqh6Yxu6po4er16fvEUFRWR9l
	 kFn2O4HIJKJ/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/16] PCI: dwc: fu740: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260720150619.24733-9-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-9-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:26:58 +0000
Message-Id: <20260720152658.7F6101F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] DWC endpoint core uses uninitialized `pci->pcie_cap` during se=
tup, leading to severe PCI configuration space corruption.
- [Low] Unused variable `cap` in `dw_pcie_link_get_max_link_width()`, leadi=
ng to redundant MMIO reads.
--

--- Patch [8]: [PATCH v3 08/16] PCI: dwc: fu740: Use cached PCIe capability=
 offset ---
commit 184aa9285c97c29f412656a3e7f63a515288813c
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: fu740: Use cached PCIe capability offset

This patch series updates the DesignWare PCIe core and several controller
drivers to cache the PCIe capability offset. By storing the offset in
pci->pcie_cap, it eliminates the need to repeatedly search for the
capability during link setup and initialization.

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

[Severity: Critical]
Since the generic endpoint initialization path never caches the capability
offset (unlike the Root Complex initialization path), doesn't this mean
pci->pcie_cap remains 0?

If it remains 0, this direct assignment will corrupt offset 0x0C when
reading and writing the capability.

Furthermore, earlier in this function:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_init_non_sticky_=
registers() {
    ...
    dw_pcie_setup(pci);
    ...
}

Calling dw_pcie_setup() unconditionally invokes dw_pcie_link_set_max_speed()
and dw_pcie_link_set_max_link_width(). These functions now use pci->pcie_cap
which evaluates to 0, causing severe corruption of standard PCI header
registers (such as Header Type and Cache Line Size at offset 0x0C).

>  		func0_lnkcap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
>  		func0_lnkcap =3D FIELD_GET(PCI_EXP_LNKCAP_MLW |
>  					 PCI_EXP_LNKCAP_SLS, func0_lnkcap);

[ ... ]

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index ec4722ed93032..810729b918928 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c

[ ... ]

> @@ -843,7 +842,7 @@ EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>  static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  {
>  	u32 cap, ctrl2, link_speed;
> -	u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u8 offset =3D pci->pcie_cap;

[Severity: Critical]
When called from the endpoint initialization path via dw_pcie_setup(),
doesn't pci->pcie_cap evaluate to 0?

If so, this base offset resolves to standard PCI header bytes instead of
the PCIe capability registers, corrupting configuration space when
writing back the updated speed values.

> =20
>  	cap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> =20

[ ... ]

> @@ -890,7 +889,7 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie=
 *pci)
>  int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
>  {
>  	u8 cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	u32 lnkcap =3D dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);

[Severity: Low]
Is the cap variable still needed here?=20

It seems this performs a redundant MMIO search via dw_pcie_find_capability()
but the result is completely ignored since the next line directly accesses
pci->pcie_cap.

> =20
>  	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
>  }

[ ... ]

> @@ -935,10 +933,9 @@ static void dw_pcie_link_set_max_link_width(struct d=
w_pcie *pci, u32 num_lanes)
>  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
>  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> =20
> -	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	lnkcap =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	lnkcap =3D dw_pcie_readl_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP);

[Severity: Critical]
Similar to dw_pcie_link_set_max_speed(), if this is called from the endpoint
setup path where pci->pcie_cap remains uninitialized, doesn't this result in
writes to standard PCI header registers instead of the PCIe capability?

>  	FIELD_MODIFY(PCI_EXP_LNKCAP_MLW, &lnkcap, num_lanes);
> -	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> +	dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP, lnkcap);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D8
