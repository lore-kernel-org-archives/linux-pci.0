Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51268 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaJJOzJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Oct 2014 10:55:09 -0400
Received: by mail-lb0-f174.google.com with SMTP id p9so3244113lbv.19
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2014 07:55:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412919676-25344-5-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
	<1412919676-25344-5-git-send-email-richard.zhu@freescale.com>
Date: Fri, 10 Oct 2014 11:55:08 -0300
Message-ID: <CAOMZO5D+hpmNMQ05QtnKwQ_jLwngtTOY0p8BaLpYiZgRM57ATA@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] PCI: imx6: add imx6sx pcie support
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Tim Harvey <tharvey@gateworks.com>,
	Richard Zhu <r65037@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 10, 2014 at 2:41 AM, Richard Zhu <richard.zhu@freescale.com> wrote:

>  static void imx6_pcie_init_phy(struct pcie_port *pp)
>  {
>         struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> +       int ret;
> +
> +       /* Power up the separate domain available on i.MX6SX */
> +       if (is_imx6sx_pcie(imx6_pcie)) {
> +               /* Force PCIe PHY reset */
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR5,
> +                               IMX6SX_GPR5_PCIE_BTNRST,
> +                               IMX6SX_GPR5_PCIE_BTNRST);
> +
> +               regmap_update_bits(imx6_pcie->gpc_ips_reg, GPC_CNTR,
> +                               GPC_CNTR_PCIE_PHY_PUP_REQ,
> +                               GPC_CNTR_PCIE_PHY_PUP_REQ);
> +               regulator_set_voltage(imx6_pcie->pcie_phy_regulator,
> +                               1100000, 1100000);
> +               ret = regulator_enable(imx6_pcie->pcie_phy_regulator);
> +               if (ret)
> +                       dev_info(pp->dev, "failed to enable pcie regulator.\n");

You should 'return ret' in the case of error.
