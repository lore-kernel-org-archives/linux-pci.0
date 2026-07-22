Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02B338595;
	Wed, 22 Jul 2026 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704638; cv=none; b=U2VV2tYnZFRBhHTU8CdUt4O9Dr3Twy2tY7V7e/aDRtpLB7kh4G2nx2oTU4saT4PiKcUWP1vBv5aK5hdNpjDR8rVQtiOPpsT0qjRUybIlCayrb4ZLirk0tZ+DEnvJarH4bbWDHDC50nTWXm3woKfSp6UY1tbxnxUpv5cMzSMAqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704638; c=relaxed/simple;
	bh=0hfNCEf2G6/s7uZa9vpsL7QRR+QPZWgx0bgnOlsCClc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nsIhaEMaHsqL/2YcZGAEQVvwwhfiy+mBIFiKeFS21r3KrWlhkQRb2LzCO941ePvhk1s8+/JYZ8nw9XHIX1mrfKYsxZHlOmYI3AEv9sPaMD2sm+d97jzvjzjwRv9NvDSjaJD7nul7BjYb1b8No97c6KCmRxqMrOZjSu3XuP62Skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdUF7p2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdUF7p2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAE11F000E9;
	Wed, 22 Jul 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784704636;
	bh=ix1YWR89BoWirkzBwDzjoNDoHc/y1c7sNydBMgP5/eI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdUF7p2bTiqcuPSXVQI4O5GGtP4ukhv3vLeL9n1TidqDpjTB1bLUVT0qbQw1Xmij5
	 MX9swTAcweAxvvauJLl+tk/QlydH3lheu4eJLmvohONSkHuqt4tyMVk6bI5E9Ah33d
	 7jtL9LgRa7MIvLeQ8dEBl59Q46KkI/tUIW2w1xfBzz/74k0CG1iTfnhTUG5RFiRklt
	 GLSaK2JLzQN1oswrvEktoYMF0qzh7NzqYnaTHgX1J6JWQrEIDMUrqloK6nHX9hfG8d
	 bDIc8a4p8vdoJaE/5l0DNNH76l6U/FFehnViYcIOkJ/Jgh6KOLQLggCl67I+Znr1x/
	 PSAdmi2EWTkFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: imx6: Fix i.MX6Q/DL boot hang caused by
 improper PHY power sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260722071030.2504711-1-hongxing.zhu@oss.nxp.com>
References: <20260722071030.2504711-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:17:16 +0000
Message-Id: <20260722071716.6AAE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Ignored return value and missing cleanup in endpoint initializatio=
n (`imx_add_pcie_ep`).
- [High] Calling a sleeping function (`usleep_range`) in a `noirq` system s=
uspend/resume phase where local interrupts are disabled.
--

--- Patch [1]: [PATCH v4] PCI: imx6: Fix i.MX6Q/DL boot hang caused by impr=
oper PHY power sequencing ---
commit cdeb44e5cad8e8dc7dee3f092df4048d6cca6e75
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing

This commit fixes a boot hang on i.MX6Q/DL variants by reordering the PHY
initialization sequence. It moves TEST_PD control into the reset functions
and adds an explicit delay for the PHY power-up sequence.

Closes: https://lore.kernel.org/lkml/20260629143439.361560-1-leoreis.costa@=
gmail.com/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..da9d4d6d7d46a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -835,11 +832,15 @@ static int imx6qp_pcie_core_reset(struct imx_pcie *=
imx_pcie, bool assert)
> =20
>  static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
>  {
> -	if (!assert)
> -		return 0;
> +	if (assert)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				IMX6Q_GPR1_PCIE_TEST_PD);
> +	else
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				  IMX6Q_GPR1_PCIE_TEST_PD);
> =20
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST=
_PD);
> -	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_=
CLK_EN);
> +	if (!assert)
> +		usleep_range(200, 500);

[Severity: High]
This is a pre-existing issue, but does calling usleep_range() here cause
a scheduling while atomic bug during system resume?

During system resume, the noirq phase calls imx_pcie_resume_noirq() with
local interrupts disabled across all CPUs. This eventually calls down to
this function:

imx_pcie_resume_noirq()
   imx_pcie_deassert_core_reset()
      imx6q_pcie_core_reset(assert=3Dfalse)
         usleep_range(200, 500);

Since usleep_range() sets the task state to TASK_UNINTERRUPTIBLE and calls
schedule(), will this hard-lock or trigger a bug when timer interrupts
cannot fire to wake the task?

[ ... ]

> @@ -1445,6 +1446,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
> =20
>  err_phy_off:
> +	imx_pcie_assert_core_reset(imx_pcie);
>  	phy_power_off(imx_pcie->phy);
>  err_phy_exit:
>  	phy_exit(imx_pcie->phy);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe for
imx_add_pcie_ep() to ignore the return value of imx_pcie_host_init()?

If imx_pcie_host_init() fails, for example when enabling clocks or
regulators, it seems imx_add_pcie_ep() will continue execution:

imx_add_pcie_ep() {
    ...
    imx_pcie_host_init(pp);
    ...
    dw_pcie_ep_init(&imx_pcie->pci->ep);
}

Could this cause an external abort when dw_pcie_ep_init_registers()
attempts to access unclocked or unpowered PCIe registers?

Also, if dw_pcie_ep_init() subsequently fails, it looks like
imx_pcie_host_exit() is never called to clean up resources.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722071030.2504=
711-1-hongxing.zhu@oss.nxp.com?part=3D1
