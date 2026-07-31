Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC814E2F2;
	Fri, 31 Jul 2026 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468106; cv=none; b=BVGwEI5Gx4eQ22E6yANpbFsAwZbPtL1jGqtrFBP0QdQYUZxgNHCsgInLPLBnWnIf750ShUQZoSPaKRZnP8sv/1V284umf9ZLoXF3VFAu+b6a8mqfzeM03B5uG1AgUOIJzD7rLW+WQRY5JXEtJW1jEyb5FrR51G1gVkoku8EwnW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468106; c=relaxed/simple;
	bh=ay7BBX7EtdHxlOQUMBykmX+3TmqRMOgOx+x1wT8ZGI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LyCVT49p9ZLpIhApjN7a/X+idf8UEYo4YbyhGSY9u3uCpdp3qjHOvTgf0YDQwrhXRBtaen6MyKPGJoYafmQofy3Y37AxNCP17Uj7MNj1lb8LXNC0HmRU7XiyrwspBEganhufxPATdX7/8CFnNl+9cXyyO8hn1FqJVQREe+PqFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1yclCnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1yclCnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325471F000E9;
	Fri, 31 Jul 2026 03:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785468104;
	bh=o1sZbulkLbE2465tSDL7GG/SWNeBTxiQm5xww4VxiIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1yclCnrEP+8SOxTxw+5pssVrCkW36Vg4JxdbGSUEk3qgJOiOEIiH87gEU1pE40j9
	 5RzmmDf6TV4vi19EsBXmxFkwi8I+g+QjqtnqYi+mh8jO+2ULKuz0q5bMsmspLxbl2K
	 cdiXLDhhweVvU6GFcgpRUk60euaNZEOl5UTr3vh3JvZaNNUPfmHlKVBP+x1M8HmC82
	 p3UahjlwW20E9HnPDyZCfOB7GLaGVwRQp7Q7YQ80WGpErfqc3WvzrxGADhb4zt1dhA
	 n9Za2c7DkyOh67btlNH4HrpIEx9gc2F6v2ND92moNY/N0YjQnbJzEIVOlVwmUW8Pt4
	 dg+3x3SRVaXnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260731030546.850457-1-hongxing.zhu@oss.nxp.com>
References: <20260731030546.850457-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 03:21:43 +0000
Message-Id: <20260731032144.325471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The indirect PHY address and enable bit are updated in two separ=
ate, non-atomic read-modify-write operations.

Pre-existing issues:
- [High] The regmap `imx_pcie->iomuxc_gpr` is accessed during the `resume_n=
oirq` phase without a raw spinlock, leading to a sleeping-in-atomic bug on =
PREEMPT_RT.
--

--- Patch [1]: [PATCH v4] PCI: imx6: Update MPLLB bandwidth to improve i.MX=
95 Gen3 PCIe stability ---
commit b27e9944369b914b92884bcfe73498504647f095
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Update MPLLB bandwidth to improve i.MX95 Gen3 PCIe stability

This patch implements a PHY register write helper function and configures
the MPLLB bandwidth override to improve i.MX95 Gen3 PCIe link stability
across voltage and temperature variations.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -269,6 +280,15 @@ static int imx95_pcie_select_ref_clk_src(struct imx_=
pcie *imx_pcie)
>  	return 0;
>  }
> =20
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u1=
6 data)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);

[Severity: Medium]
Is it safe to split the enable bit and address into two separate non-atomic
updates to the same register?

Writing the IMX95_PCIE_PHY_REG_EN bit before the actual address could
momentarily expose the EN=3D1 state with an uninitialized or old address to
the hardware. Could this trigger an unintended register access?

Would it be safer to combine both updates into a single regmap_update_bits()
call using a combined mask?

> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {

[ ... ]

> @@ -289,6 +309,18 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_=
pcie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
> =20
> +	/*
> +	 * A delay is required between the assertion of
> +	 * IMX95_PCIE_PHY_CR_PARA_SEL and subsequent PHY register write
> +	 * operation to ensure values are successfully written.
> +	 */
> +	udelay(200);
> +
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_BW_IN,
> +			     IMX95_PCIE_PHY_MPLLB_BW_VAL);
> +	imx95_pcie_phy_write(imx_pcie, IMX95_PCIE_PHY_MPLLB_OVRD_IN,
> +			     IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN);

[Severity: High]
This isn't a bug introduced by this patch, but adding more regmap operations
here extends a pre-existing sleep-in-atomic issue on PREEMPT_RT kernels.

Because imx95_pcie_init_phy() is reachable from the resume_noirq phase with
hardware interrupts disabled:

imx_pcie_resume_noirq()
  dw_pcie_resume_noirq()
    imx_pcie_host_init()
      imx95_pcie_init_phy()
        imx95_pcie_phy_write()
          regmap_write()

Can these regmap calls cause a lockdep splat or deadlock?

MMIO regmaps initialized without use_raw_spinlock =3D true use sleepable
rt_mutex locks on PREEMPT_RT. Acquiring this lock with local interrupts
disabled leads to a sleeping function called from invalid context bug.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731030546.8504=
57-1-hongxing.zhu@oss.nxp.com?part=3D1
