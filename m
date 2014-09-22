Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58010 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbaIVO1K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 10:27:10 -0400
MIME-Version: 1.0
In-Reply-To: <1411382705-15301-5-git-send-email-r65037@freescale.com>
References: <1411382705-15301-1-git-send-email-r65037@freescale.com>
	<1411382705-15301-5-git-send-email-r65037@freescale.com>
Date: Mon, 22 Sep 2014 11:27:08 -0300
Message-ID: <CAOMZO5D_s7ST_J0FV+NbrHpw2jVBDSpHprHnwJfPbQ=tqy7PWQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] PCI: imx6: add imx6sx pcie support
From: Fabio Estevam <festevam@gmail.com>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawn.guo@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Mon, Sep 22, 2014 at 7:45 AM, Richard Zhu <r65037@freescale.com> wrote:

> +#ifdef CONFIG_PM_SLEEP
> +static int pci_imx_suspend(void)
> +{
> +       int rc = 0;
> +
> +       if (is_imx6sx_pcie(imx6_pcie)) {
> +               /* PM_TURN_OFF */
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +                               BIT(16), 1 << 16);
> +               udelay(10);
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +                               BIT(16), 0 << 16);
> +       }
> +
> +       return rc;

You could get rid of this 'rc' variable and just return 0.

> +}
> +
> +static void pci_imx_resume(void)
> +{
> +       struct pcie_port *pp = &imx6_pcie->pp;
> +
> +       if (is_imx6sx_pcie(imx6_pcie)) {
> +               /* reset iMX6SX PCIe */
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IOMUXC_GPR5, BIT(18), 1 << 18);
> +
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IOMUXC_GPR5, BIT(18), 0 << 18);
> +
> +               /*
> +                * controller maybe turn off, re-configure again
> +                * Set the CLASS_REV of RC CFG header to
> +                * PCI_CLASS_BRIDGE_PCI
> +                */
> +               writel(readl(pp->dbi_base + PCI_CLASS_REVISION)
> +                       | (PCI_CLASS_BRIDGE_PCI << 16),
> +                       pp->dbi_base + PCI_CLASS_REVISION);
> +
> +               dw_pcie_setup_rc(pp);
> +       }
> +}

Not related to this patch, but on mx6q/dl  we still get kernel hang
after doing suspend/resume when a PCI card is inserted.

Is this fixed on mx6solox?

Any idea as to how to fix it for mx6q?
