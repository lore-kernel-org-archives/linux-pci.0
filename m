Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6430C17D;
	Mon, 20 Jul 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561273; cv=none; b=bXreD49zmaL+Ra1nIaE1oq4ihx12JVBbBBkVVPt5ccyWt1iYsY8dmxDqeP6ZxKKY8/8hLYfG8a66YVc1RjRAb80DYFhbUCi1q36OHGq7ZfJ96U/wmzAmynDQddPiiOKdkjUBdeYUagbTFYltmXp/PwChBKr5Mu2VSlb1F5MgXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561273; c=relaxed/simple;
	bh=DKdiVPSpjb1VbfNrHPCDg6po1oYPd6Y798uYG5fR92U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzgg01RyfjGSnW2oKEIMiIbpd0S4lnxsbh21llLWK9ybIz/pUL5g6e1WjG3MkPEYn7f7eWXnxUZ3rpeMgiyLIr0D6ia5ebDX3Dx8hB41TfoVKk6e7W+DUY0yq1NOMU+24Ptu32+0czE8atqgm/sKfuIljeyI5Ug5W4S2w223vVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNQCV1mw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNQCV1mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88AC1F00A3A;
	Mon, 20 Jul 2026 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561272;
	bh=JjQaLdF/6J1Cr39wdv1yjoSfvOqAtBuzbF59nsWBkD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNQCV1mwPps170gjMiiDw2R1riBhwYGMfuAKL7TBoXn+1OFfehyMQPYydWpVmiRKu
	 2dUy5LDZ3v/7zEOhQ+IHaqFyxBnCs2UbnkkKFSuanB00SvoCw4E8Yrg/srhlQ55Djr
	 7Pr2BA/naCutWgJdL6wXDXnr0nl1Bp38sGt8aS5RFZJlwqWOTnsbG+adGms4usgeq8
	 LzNjQ1Fm99HgFDXb0GoH7II33i9TkKeR+4S+5r7Lo4n7bP1+qWUoX5vjkBsMsKcH7L
	 LwrOsDH+8E7427Zok2baacMSy2S2aJ0xfzJ+P+XoJNQLbXXFCUuFbtvsW+MNwNQHke
	 L8pFdYizLPwDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/16] PCI: dwc: spear13xx: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260720150619.24733-15-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-15-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:27:51 +0000
Message-Id: <20260720152751.A88AC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mandatory API contract violation: ignored return value of `phy_ini=
t()`.
- [High] Unconditional `IRQ_HANDLED` in a shared IRQ handler.
- [High] Shared IRQ is requested before the hardware base address is initia=
lized, leading to a potential NULL pointer dereference.
--

--- Patch [14]: [PATCH v3 14/16] PCI: dwc: spear13xx: Use cached PCIe capab=
ility offset ---
commit c41d49bf9e94ac238049768122148b7abb564665
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
This isn't a bug introduced by this patch, but I noticed a potential
NULL pointer dereference involving app_base here.

In spear13xx_add_pcie_port(), devm_request_irq() is called with IRQF_SHARED
before dw_pcie_host_init() sets spear13xx_pcie->app_base:

spear13xx_add_pcie_port() {
    ...
    ret =3D devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
                           IRQF_SHARED | IRQF_NO_THREAD,
                           "spear1340-pcie", spear13xx_pcie);
    ...
    ret =3D dw_pcie_host_init(pp);
    ...
}

If another device on the shared IRQ line triggers an interrupt before
spear13xx_pcie_host_init() is called, spear13xx_pcie_irq_handler() will run
and dereference the still-NULL app_base:

spear13xx_pcie_irq_handler() {
    ...
    struct pcie_app_reg __iomem *app_reg =3D spear13xx_pcie->app_base;
    ...
    status =3D readl(&app_reg->int_sts);
    ...
}

Could the IRQ request be moved until after the base address is initialized?

[ ... ]

I also noticed a few other pre-existing issues in this file.

[Severity: High]
This is a pre-existing issue, but the integer return value of
phy_init() is completely ignored in spear13xx_pcie_probe():

spear13xx_pcie_probe() {
    ...
    phy_init(spear13xx_pcie->phy);

    spear13xx_pcie->clk =3D devm_clk_get(dev, NULL);
    ...
}

If phy_init() fails, the driver blindly proceeds to configure clocks and
initialize the PCIe host controller. Accessing an uninitialized or
unpowered PHY can lead to hardware lockups or synchronous external aborts.
Should the return value of phy_init() be checked here?

[Severity: High]
This is a pre-existing issue, but the shared IRQ handler unconditionally
returns IRQ_HANDLED:

spear13xx_pcie_irq_handler() {
    ...
    status =3D readl(&app_reg->int_sts);

    if (status & MSI_CTRL_INT) {
        BUG_ON(!IS_ENABLED(CONFIG_PCI_MSI));
        dw_handle_msi_irq(pp);
    }

    writel(status, &app_reg->int_clr);

    return IRQ_HANDLED;
}

Returning IRQ_HANDLED unconditionally in a shared IRQ handler breaks the
kernel's spurious interrupt detection and can swallow interrupts. If the
shared IRQ line screams, the kernel will not disable the line because it
thinks this driver is successfully handling the interrupts, which can lead
to CPU stalls. Should this return IRQ_NONE when status is 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D14
