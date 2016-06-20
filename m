Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35351 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbcFTTuw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2016 15:50:52 -0400
MIME-Version: 1.0
In-Reply-To: <1462794543-30317-1-git-send-email-niklass@axis.com>
References: <1462794543-30317-1-git-send-email-niklass@axis.com>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 20 Jun 2016 15:50:07 -0400
Message-ID: <CAP=VYLo00R4iv+9_=x2BjjurEfArJzY46Zc=doEtav=BwNhPzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: host: new driver for Axis ARTPEC-6 PCIe controller
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: bhelgaas@google.com, niklass@axis.com, jespern@axis.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Miller <davem@davemloft.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	mchehab@osg.samsung.com, linux@roeck-us.net, jslaby@suse.cz,
	robh@kernel.org, marc.zyngier@arm.com, rjui@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>, geert+renesas@glider.be,
	lftan@altera.com, bharat.kumar.gogada@xilinx.com, hauke@hauke-m.de,
	thomas.petazzoni@free-electrons.com, simon.horman@netronome.com,
	phil.edworthy@renesas.com, svarbanov@mm-sol.com, dhdang@apm.com,
	wangzhou1@hisilicon.com, LKML <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@axis.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 9, 2016 at 7:49 AM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
>
> The Axis ARTPEC-6 SoC integrates a PCIe controller from Synopsys.
> This commit adds a new driver that provides the small glue
> needed to use the existing Designware driver to make it work on
> the Axis ARTPEC-6 SoC.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

[...]

> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -244,4 +244,10 @@ config PCIE_ARMADA_8K
>           Designware hardware and therefore the driver re-uses the
>           Designware core functions to implement the driver.
>
> +config PCIE_ARTPEC6
> +       bool "Axis ARTPEC-6 PCIe controller"

Bjorn,

Can we please start requiring new PCI/PCI-e drivers to either:

  (a)  be merged and tested as tristate, or

  (b)  remain bool, but not gratuitously use module macros

I was told there was a preference to convert the existing ones
to tristate, but that is near impossible for me to achieve, since
I can't run-time test them and/or it requires new exports that
have explicitly been NACK'd by other maintainers.

In the meantime, each new merge window adds several
more PCI drivers with the same bool Kconfig that semi
pretend to be modular in the code they use, which just
compounds the problem space.

Thanks,
Paul.
--

> +       depends on MACH_ARTPEC6
> +       select PCIE_DW
> +       select PCIEPORTBUS
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 9c8698e..5bc0af2 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> +obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
> new file mode 100644
> index 0000000..d53dbaf
> --- /dev/null
> +++ b/drivers/pci/host/pcie-artpec6.c
> @@ -0,0 +1,293 @@
> +/*
> + * PCIe host controller driver for Axis ARTPEC-6 SoC
> + *
> + * Based on work done by Phil Edworthy <phil@edworthys.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/signal.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_artpec6_pcie(x)     container_of(x, struct artpec6_pcie, pp)
> +
> +struct artpec6_pcie {
> +       struct pcie_port        pp;
> +       struct regmap           *regmap;
> +       void __iomem            *phy_base;
> +};
> +
> +/* PCIe Port Logic registers (memory-mapped) */
> +#define PL_OFFSET                      0x700
> +#define PCIE_PHY_DEBUG_R0              (PL_OFFSET + 0x28)
> +#define PCIE_PHY_DEBUG_R1              (PL_OFFSET + 0x2c)
> +
> +#define MISC_CONTROL_1_OFF             (PL_OFFSET + 0x1bc)
> +#define  DBI_RO_WR_EN                  1
> +
> +/* ARTPEC-6 specific registers */
> +#define PCIECFG                                0x18
> +#define  PCIECFG_DBG_OEN               (1 << 24)
> +#define  PCIECFG_CORE_RESET_REQ                (1 << 21)
> +#define  PCIECFG_LTSSM_ENABLE          (1 << 20)
> +#define  PCIECFG_CLKREQ_B              (1 << 11)
> +#define  PCIECFG_REFCLK_ENABLE         (1 << 10)
> +#define  PCIECFG_PLL_ENABLE            (1 << 9)
> +#define  PCIECFG_PCLK_ENABLE           (1 << 8)
> +#define  PCIECFG_RISRCREN              (1 << 4)
> +#define  PCIECFG_MODE_TX_DRV_EN                (1 << 3)
> +#define  PCIECFG_CISRREN               (1 << 2)
> +#define  PCIECFG_MACRO_ENABLE          (1 << 0)
> +
> +#define NOCCFG                         0x40
> +#define NOCCFG_ENABLE_CLK_PCIE         (1 << 4)
> +#define NOCCFG_POWER_PCIE_IDLEACK      (1 << 3)
> +#define NOCCFG_POWER_PCIE_IDLE         (1 << 2)
> +#define NOCCFG_POWER_PCIE_IDLEREQ      (1 << 1)
> +
> +#define PHY_STATUS                     0x118
> +#define PHY_COSPLLLOCK                 (1 << 0)
> +
> +#define ARTPEC6_CPU_TO_BUS_ADDR                0x0FFFFFFF
> +
> +static int artpec6_pcie_establish_link(struct pcie_port *pp)
> +{
> +       struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
> +       u32 val;
> +       unsigned int retries;
> +
> +       /* Hold DW core in reset */
> +       regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
> +       val |= PCIECFG_CORE_RESET_REQ;
> +       regmap_write(artpec6_pcie->regmap, PCIECFG, val);
> +
> +       regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
> +       val |=  PCIECFG_RISRCREN |      /* Receiver term. 50 Ohm */
> +               PCIECFG_MODE_TX_DRV_EN |
> +               PCIECFG_CISRREN |       /* Reference clock term. 100 Ohm */
> +               PCIECFG_MACRO_ENABLE;
> +       val |= PCIECFG_REFCLK_ENABLE;
> +       val &= ~PCIECFG_DBG_OEN;
> +       val &= ~PCIECFG_CLKREQ_B;
> +       regmap_write(artpec6_pcie->regmap, PCIECFG, val);
> +       usleep_range(5000, 6000);
> +
> +       regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
> +       val |= NOCCFG_ENABLE_CLK_PCIE;
> +       regmap_write(artpec6_pcie->regmap, NOCCFG, val);
> +       usleep_range(20, 30);
> +
> +       regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
> +       val |= PCIECFG_PCLK_ENABLE | PCIECFG_PLL_ENABLE;
> +       regmap_write(artpec6_pcie->regmap, PCIECFG, val);
> +       usleep_range(6000, 7000);
> +
> +       regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
> +       val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
> +       regmap_write(artpec6_pcie->regmap, NOCCFG, val);
> +
> +       retries = 50;
> +       do {
> +               usleep_range(1000, 2000);
> +               regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
> +               retries--;
> +       } while (retries &&
> +               (val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
> +
> +       retries = 50;
> +       do {
> +               usleep_range(1000, 2000);
> +               val = readl(artpec6_pcie->phy_base + PHY_STATUS);
> +               retries--;
> +       } while (retries && !(val & PHY_COSPLLLOCK));
> +
> +       /* Take DW core out of reset */
> +       regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
> +       val &= ~PCIECFG_CORE_RESET_REQ;
> +       regmap_write(artpec6_pcie->regmap, PCIECFG, val);
> +       usleep_range(100, 200);
> +
> +       /*
> +        * Enable writing to config regs. This is required as the Synopsys
> +        * driver changes the class code. That register needs DBI write enable.
> +        */
> +       writel(DBI_RO_WR_EN, pp->dbi_base + MISC_CONTROL_1_OFF);
> +
> +       pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +       pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +       pp->cfg0_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +       pp->cfg1_base &= ARTPEC6_CPU_TO_BUS_ADDR;
> +
> +       /* setup root complex */
> +       dw_pcie_setup_rc(pp);
> +
> +       /* assert LTSSM enable */
> +       regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
> +       val |= PCIECFG_LTSSM_ENABLE;
> +       regmap_write(artpec6_pcie->regmap, PCIECFG, val);
> +
> +       /* check if the link is up or not */
> +       if (!dw_pcie_wait_for_link(pp))
> +               return 0;
> +
> +       dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
> +               readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
> +               readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static void artpec6_pcie_enable_interrupts(struct pcie_port *pp)
> +{
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               dw_pcie_msi_init(pp);
> +}
> +
> +static void artpec6_pcie_host_init(struct pcie_port *pp)
> +{
> +       artpec6_pcie_establish_link(pp);
> +       artpec6_pcie_enable_interrupts(pp);
> +}
> +
> +static int artpec6_pcie_link_up(struct pcie_port *pp)
> +{
> +       u32 rc;
> +
> +       /*
> +        * Get status from Synopsys IP
> +        * link is debug bit 36, debug register 1 starts at bit 32
> +        */
> +       rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << (36 - 32));
> +       if (rc)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static struct pcie_host_ops artpec6_pcie_host_ops = {
> +       .link_up = artpec6_pcie_link_up,
> +       .host_init = artpec6_pcie_host_init,
> +};
> +
> +static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
> +{
> +       struct pcie_port *pp = arg;
> +
> +       return dw_handle_msi_irq(pp);
> +}
> +
> +static int __init artpec6_add_pcie_port(struct pcie_port *pp,
> +                                       struct platform_device *pdev)
> +{
> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +               if (pp->msi_irq <= 0) {
> +                       dev_err(&pdev->dev, "failed to get MSI irq\n");
> +                       return -ENODEV;
> +               }
> +
> +               ret = devm_request_irq(&pdev->dev, pp->msi_irq,
> +                                      artpec6_pcie_msi_handler,
> +                                      IRQF_SHARED | IRQF_NO_THREAD,
> +                                      "artpec6-pcie-msi", pp);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to request MSI irq\n");
> +                       return ret;
> +               }
> +       }
> +
> +       pp->root_bus_nr = -1;
> +       pp->ops = &artpec6_pcie_host_ops;
> +
> +       ret = dw_pcie_host_init(pp);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to initialize host\n");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int __init artpec6_pcie_probe(struct platform_device *pdev)
> +{
> +       struct artpec6_pcie *artpec6_pcie;
> +       struct pcie_port *pp;
> +       struct resource *dbi_base;
> +       struct resource *phy_base;
> +       int ret;
> +
> +       artpec6_pcie = devm_kzalloc(&pdev->dev, sizeof(*artpec6_pcie),
> +                                   GFP_KERNEL);
> +       if (!artpec6_pcie)
> +               return -ENOMEM;
> +
> +       pp = &artpec6_pcie->pp;
> +       pp->dev = &pdev->dev;
> +
> +       dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +       pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
> +       if (IS_ERR(pp->dbi_base)) {
> +               ret = PTR_ERR(pp->dbi_base);
> +               goto fail;
> +       }
> +
> +       phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> +       artpec6_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
> +       if (IS_ERR(artpec6_pcie->phy_base)) {
> +               ret = PTR_ERR(artpec6_pcie->phy_base);
> +               goto fail;
> +       }
> +
> +       artpec6_pcie->regmap =
> +               syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                                               "axis,syscon-pcie");
> +       if (IS_ERR(artpec6_pcie->regmap)) {
> +               ret = PTR_ERR(artpec6_pcie->regmap);
> +               goto fail;
> +       }
> +
> +       ret = artpec6_add_pcie_port(pp, pdev);
> +       if (ret < 0)
> +               goto fail;
> +
> +       platform_set_drvdata(pdev, artpec6_pcie);
> +       return 0;
> +
> +fail:
> +       return ret;
> +}
> +
> +static const struct of_device_id artpec6_pcie_of_match[] = {
> +       { .compatible = "axis,artpec6-pcie", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, artpec6_pcie_of_match);
> +
> +static struct platform_driver artpec6_pcie_driver = {
> +       .probe = artpec6_pcie_probe,
> +       .driver = {
> +               .name   = "artpec6-pcie",
> +               .of_match_table = artpec6_pcie_of_match,
> +       },
> +};
> +
> +module_platform_driver(artpec6_pcie_driver);
> +
> +MODULE_AUTHOR("Niklas Cassel <niklas.cassel@axis.com>");
> +MODULE_DESCRIPTION("Axis ARTPEC-6 PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.1.4
>
