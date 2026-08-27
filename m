Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2C4A1387;
	Thu, 27 Aug 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856069; cv=none; b=B7NRKUfogtneFiQwja4aLHsDMirAxerrINagIQaroX7R+M0gCMQ3o38Aduw8MEJ0KLfDk1AITYv7dVdLbj1+VSUojNszeiBD7RCHTba5sDU4G66hFIjalAPmVp8giPlTnEUgCpJIQJe8GRGcfXGTj0sv0p6cWso5TF5uxm01XtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856069; c=relaxed/simple;
	bh=IdMBYrM2CP87YOVoOj8MOjQWnzjTq0pW0sEar8iydR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/JAu/Jkthc2dU7Yz/D7iUW8GwLuRYWm5zCyOdOUOQ9OStufF76sBFFJMb61swESxsgatW0sxlAbsLRAZgprurgd/+d9mC6EstDNCFKpJSWht3KQ2/13FzKh/diYDPOOAe+ZZHie9QG0vZLXQR/0DMRHsAPJkffz7REWPfYPEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmSmIZwk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmSmIZwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F6F1F000E9;
	Thu, 27 Aug 2026 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787856068;
	bh=0EzF0oBb9t/oMO4p5S20/UBH4diMe7oWJJlkWxj5amM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DmSmIZwkvrMJsEhCRQZA4p9K//v+v2j1fM6AfgqQeI1CGhGYK9hAJqSW/8vRsKRXR
	 /C0n3p9aVaTTAoPOJMM6StATSZS+WaTVcpJxwZvO+cjep23fLYMvHEG2VADkBD13/6
	 64A6PFkB3OZTKrYTlv8UhPpGJLswh55keEwf1pkj50+2wp9/Ss3W8MlGsf8xOTQEuk
	 Gp+7MCVsokuo9ZGLmuZRpTeBcGaAaa+HvRhhpEC74DhrhMPjjhFaupL5WWfTfZLhxZ
	 OnL/XpZQgGLb5qUfpWbBER6D4GGXhS/VNDWHEMRLXRi+u/+yl58E0kir4+SBEUzVJO
	 RiX/EqCnSQghw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: dw-rockchip: Support fixed MSI-X table and PBA
 on RK3588
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260827182012.1984960-3-den@valinux.co.jp>
References: <20260827182012.1984960-1-den@valinux.co.jp>
 <20260827182012.1984960-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:41:07 +0000
Message-Id: <20260827184108.00F6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unmapped epf_bar[bir] access in dw_pcie_ep_raise_msix_irq() caus=
es kernel panic when msix_hw_owned is true
--

commit d51d0db24756ed54917db6dbe19e86f2adfdc77f
Author: Koichiro Den <den@valinux.co.jp>

PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588

This commit adds support for fixed MSI-X tables and PBA on the RK3588
controller by marking BAR4 as a reserved region. It introduces the
msix_hw_owned flag to track when a hardware-owned layout is selected. The
RK3588 then overrides the MSI-X raise behavior to use the controller
doorbell when this flag is set.

> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 147b043589f02..bc2b63814dea1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
[ ... ]
> @@ -764,6 +784,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u=
8 func_no, u8 vfunc_no,
>  	reg =3D ep_func->msix_cap + PCI_MSIX_PBA;
>  	val =3D layout->pba_offset | layout->pba_bar;
>  	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
> +	ep_func->msix_hw_owned =3D dw_pcie_ep_msix_layout_is_hw_owned(ep, layou=
t);

[Severity: Medium]
Does introducing the msix_hw_owned state here create a potential NULL point=
er
dereference in the generic dw_pcie_ep_raise_msix_irq() handler?

When msix_hw_owned is true, the MSI-X table is backed by a hardware-reserved
BAR, meaning the EPF driver does not map epf_bar[bir].

While the RK3588 controller correctly intercepts this state to avoid calling
the generic dw_pcie_ep_raise_msix_irq(), the generic function itself (which
is exported and serves as the default MSI-X handler for DesignWare) is not
updated.

If any other DW controller adds a hardware-owned layout and falls back to
this default handler, it will unconditionally dereference the NULL
ep_func->epf_bar[bir]:

drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msix_irq()=
 {
	...
	tbl_offset &=3D PCI_MSIX_TABLE_OFFSET;

	msix_tbl =3D ep_func->epf_bar[bir]->addr + tbl_offset;
	...
}

Should dw_pcie_ep_raise_msix_irq() be updated to check msix_hw_owned and
return an error, or otherwise avoid accessing the unmapped array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827182012.1984=
960-1-den@valinux.co.jp?part=3D2
