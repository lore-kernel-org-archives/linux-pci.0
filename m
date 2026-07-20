Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE52C234E;
	Mon, 20 Jul 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561115; cv=none; b=nBKwJsvmPy4b20p3AAF8TFKY+EBpdYT3RiGAOkW9lHaQid1mL1kET043i67DX6pdPNIU5Upcu9AGUB9exeq9jMrOzbTes9OsNzLP+SoqkpjOqD3lCzkSG3hxueu0ABOYC/6BmA5qPHNY7S8063kUXg5oBgIss+o07JxAe6N+23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561115; c=relaxed/simple;
	bh=+eTqMGocPeDPgrD7AwbmmI259n9iV0Tf6uTvTwDhC0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QZX3UH3NbZuksQU6TQrQ/+6mTNivLlBuRyOGXzyT/mvEbRHS+oB9hF9ugmzSujp4BzeyT7FuLQvC9H+W7EAxO+vWJbx9bzTb0kLRPC7ePtxORNVQU+gt0XZ3BZHuJZCsICYxhoxmt2+DRVIAjyJ38h6h2fWymsOIZ3oV4b76zbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UheNLwzk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UheNLwzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4111F000E9;
	Mon, 20 Jul 2026 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561113;
	bh=oNi2kliUC3U2BTDBipp0e0zj3PKLL7u5AJ7MEuvmSr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UheNLwzkqzMDXOXTqAv7A9Dncsgib19vPYLFI5NzcvksU4CQFIkLUC/DP3+FvMeeC
	 BjPsYmc4CFzYkbtTo88/fcTTaxNkOy/OuQ4IxfzwLn/kAU6aaqqgP9ta2iXK+rDKIs
	 +Y2lCs5d9pgi+1XPUHBWuzT3/N5oAb73w0thFNIKfI3eqF8txIDFQcxfd68wGYRoL7
	 s3WCnLEAsMNVyUVkP5/s+2re9sFGuio+zmllbFN6R9I1nAguqVuW4jDvtrjat2dEKP
	 RN4EJXZZ/h85vsZB42Cg5ApBUHRF+8Pz5jAI7cP0o5eLV/uFd91K2TM5Ku4DW54kGf
	 f2280S5USYamQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/16] PCI: dwc: layerscape-ep: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, neil.armstrong@linaro.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260720150619.24733-5-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:25:12 +0000
Message-Id: <20260720152513.7D4111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Read-modify-write data race on PCIE_MISC_CONTROL_1_OFF hardware re=
gister.
--

--- Patch [4]: [PATCH v3 04/16] PCI: dwc: layerscape-ep: Use cached PCIe ca=
pability offset ---
commit 702ab6e16bc3343bb66237e6ea619ecc9e086c7f
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: layerscape-ep: Use cached PCIe capability offset

This commit replaces dw_pcie_find_capability() with dw_pcie_get_pcie_cap()
to cache and reuse the PCIe capability offset. This avoids re-searching
the capability list during probe and interrupt handling.

> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci=
/controller/dwc/pci-layerscape-ep.c
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -83,9 +82,6 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, vo=
id *dev_id)
>  		return IRQ_NONE;
> =20
>  	if (val & PEX_PF0_PME_MES_DR_LUD) {
> -
> -		offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -
>  		/*
>  		 * The values of the Maximum Link Width and Supported Link
>  		 * Speed from the Link Capabilities Register will be lost
>  		 * during link down or hot reset. Restore initial value
>  		 * that configured by the Reset Configuration Word (RCW).
>  		 */
>  		dw_pcie_dbi_ro_wr_en(pci);
> -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
> +		dw_pcie_writel_dbi(pci, pci->pcie_cap + PCI_EXP_LNKCAP,
> +				   pcie->lnkcap);
>  		dw_pcie_dbi_ro_wr_dis(pci);

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential data ra=
ce=20
on the PCIE_MISC_CONTROL_1_OFF hardware register here?

The ls_pcie_ep_event_handler() function runs in hardirq context. When it
calls dw_pcie_dbi_ro_wr_en() and dw_pcie_dbi_ro_wr_dis(), it performs an
unlocked read-modify-write on the register and then unconditionally clears
the enable bit:

drivers/pci/controller/dwc/pcie-designware.h:dw_pcie_dbi_ro_wr_dis() {
    reg =3D PCIE_MISC_CONTROL_1_OFF;
    val =3D dw_pcie_readl_dbi(pci, reg);
    val &=3D ~PCIE_DBI_RO_WR_EN;
    dw_pcie_writel_dbi(pci, reg, val);
}

If the host triggers a Link Up event while the endpoint configuration is
taking place via configfs (which runs in process context), couldn't the
interrupt preempt the configuration thread?=20

If the preempted thread had just set PCIE_DBI_RO_WR_EN to write registers,
the interrupt would unconditionally clear it. When the preempted thread
resumes, its writes to read-only hardware registers (like Vendor ID or
BAR configurations) would be silently ignored by the controller, which
could lead to enumeration failure on the host.

Should this register access be protected by a lock, or should the
enable/disable functions save and restore the previous register state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D4
