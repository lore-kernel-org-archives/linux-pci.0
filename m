Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:58735 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752897AbaBZRTf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 12:19:35 -0500
Message-ID: <530E2223.8030407@codethink.co.uk>
Date: Wed, 26 Feb 2014 17:19:31 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Phil.Edworthy@renesas.com
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: Re: [PATCH 1/5] PCI: host: Add Renesas R-Car PCIe driver
References: <1393430893-2466-1-git-send-email-phil.edworthy@renesas.com> <1393430893-2466-2-git-send-email-phil.edworthy@renesas.com> <530E1782.3070403@codethink.co.uk> <OF7880A4AF.3F4434E3-ON80257C8B.005C92CA-80257C8B.005EA065@eu.necel.com>
In-Reply-To: <OF7880A4AF.3F4434E3-ON80257C8B.005C92CA-80257C8B.005EA065@eu.necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/02/14 17:13, Phil.Edworthy@renesas.com wrote:
> Hi Ben,
>
> Thanks for your comments.
>
> On 26/02/2014 16:33, Ben Dooks wrote:
>> On 26/02/14 16:08, Phil Edworthy wrote:
>>> This PCIe Host driver currently does not support MSI, so cards
>>> fall back to INTx interrupts.
>>>
>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
>>
>>> +   bool "Renesas R-Car PCIe controller"
>>> +   depends on ARM && (ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST)
>>> +   help
>>> +     Say Y here if you want PCIe controller support on R-Car Gen2
> SoCs.
>>> +
>>>    endmenu
>>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>>> index 13fb333..19946f9 100644
>>> --- a/drivers/pci/host/Makefile
>>> +++ b/drivers/pci/host/Makefile
>>> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>>>    obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>>>    obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
>>>    obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>>> +obj-$(CONFIG_PCI_RCAR_GEN2_PCIE) += pcie-rcar.o
>>> diff --git a/drivers/pci/host/pcie-rcar.c
> b/drivers/pci/host/pcie-rcar.c
>>> new file mode 100644
>>> index 0000000..d9a315f
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pcie-rcar.c
>>> @@ -0,0 +1,614 @@
>>> +/*
>>> + * PCIe driver for Renesas R-Car SoCs
>>> + *  Copyright (C) 2013 Renesas Electronics Europe Ltd
>>> + *
>>> + * Based on:
>>> + *  arch/sh/drivers/pci/pcie-sh7786.c
>>> + *  arch/sh/drivers/pci/ops-sh7786.c
>>> + *  Copyright (C) 2009 - 2011  Paul Mundt
>>> + *
>>> + * This file is licensed under the terms of the GNU General Public
>>> + * License version 2.  This program is licensed "as is" without any
>>> + * warranty of any kind, whether express or implied.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_irq.h>
>>> +#include <linux/of_pci.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +#include "pcie-rcar.h"
>>> +
>>> +#define DRV_NAME "rcar-pcie"
>>> +
>>> +enum chip_id {
>>> +   RCAR_GENERIC,
>>> +   RCAR_H1,
>>> +};
>>> +
>>> +#define RCONF(x)   (PCICONF(0)+(x))
>>> +#define REXPCAP(x)   (EXPCAP(0)+(x))
>>> +#define RVCCAP(x)   (VCCAP(0)+(x))
>>> +
>>> +#define  PCIE_CONF_BUS(b)   (((b) & 0xff) << 24)
>>> +#define  PCIE_CONF_DEV(d)   (((d) & 0x1f) << 19)
>>> +#define  PCIE_CONF_FUNC(f)   (((f) & 0x7) << 16)
>>> +
>>> +#define NR_PCI_RESOURCES 4
>>> +
>>> +/* Structure representing the PCIe interface */
>>> +struct rcar_pcie {
>>> +   struct device      *dev;
>>> +   void __iomem      *base;
>>> +   int         irq;
>>> +   struct clk      *clk;
>>> +   struct resource      *res[NR_PCI_RESOURCES];
>>> +   int         haslink;
>>> +   enum chip_id      chip;
>>> +   u8         root_bus_nr;
>>> +};
>>> +
>>> +static inline struct rcar_pcie *sys_to_pcie(struct pci_sys_data *sys)
>>> +{
>>> +   return sys->private_data;
>>> +}
>>> +
>>> +static void
>>> +pci_write_reg(struct rcar_pcie *pcie, unsigned long val, unsigned
> long reg)
>>> +{
>>> +   writel(val, pcie->base + reg);
>>> +}
>>
>> Do we really need wrappers like these?
> They were handy during development, but I guess not.

Actually, not that big of a deal, ignore me on this.

>>> +static unsigned long
>>> +pci_read_reg(struct rcar_pcie *pcie, unsigned long reg)
>>> +{
>>> +   return readl(pcie->base + reg);
>>> +}
>>> +
>>> +enum {
>>> +   PCI_ACCESS_READ,
>>> +   PCI_ACCESS_WRITE,
>>> +};
>>
>>> +static int rcar_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8
> pin)
>>> +{
>>> +   struct rcar_pcie *pcie = sys_to_pcie(dev->bus->sysdata);
>>> +   return pcie->irq;
>>> +}
>>> +
>>> +static void __init rcar_pcie_enable(struct rcar_pcie *pcie)
>>> +{
>>> +   struct hw_pci hw;
>>> +
>>> +   memset(&hw, 0, sizeof(hw));
>>> +
>>> +   hw.nr_controllers = 1;
>>> +   hw.private_data   = (void **)&pcie;
>>> +   hw.setup          = rcar_pcie_setup,
>>> +   hw.map_irq        = rcar_pcie_map_irq,
>>> +   hw.ops        = &rcar_pcie_ops,
>>> +
>>> +   pci_common_init(&hw);
>>> +}
>>> +
>>> +static int __init phy_wait_for_ack(struct rcar_pcie *pcie)
>>> +{
>>> +   unsigned int timeout = 100;
>>> +
>>> +   while (timeout--) {
>>> +      if (pci_read_reg(pcie, H1_PCIEPHYADRR) & PHY_ACK)
>>> +         return 0;
>>> +
>>> +      udelay(100);
>>> +   }
>>> +
>>> +   dev_err(pcie->dev, "Access to PCIe phy timed out\n");
>>> +
>>> +   return -ETIMEDOUT;
>>> +}
>>
>> Could this be done with some sort of sleep, instead of having
>> to keep delaying? How long is the average wait for pci to finish
>> a write?
> I haven't measured how long, but yes, I can use mdelay instead.

How about something that sleeps?
Does the host have a completion IRQ you could sleep on?

>>> +
>>> +static void __init phy_write_reg(struct rcar_pcie *pcie,
>>> +             unsigned int rate, unsigned int addr,
>>> +             unsigned int lane, unsigned int data)
>>> +{
>>> +   unsigned long phyaddr;
>>> +
>>> +   phyaddr = WRITE_CMD |
>>> +      ((rate & 1) << RATE_POS) |
>>> +      ((lane & 0xf) << LANE_POS) |
>>> +      ((addr & 0xff) << ADR_POS);
>>> +
>>> +   /* Set write data */
>>> +   pci_write_reg(pcie, data, H1_PCIEPHYDOUTR);
>>> +   pci_write_reg(pcie, phyaddr, H1_PCIEPHYADRR);
>>> +
>>> +   /* Ignore errors as they will be dealt with if the data link is
> down */
>>> +   phy_wait_for_ack(pcie);
>>> +
>>> +   /* Clear command */
>>> +   pci_write_reg(pcie, 0, H1_PCIEPHYDOUTR);
>>> +   pci_write_reg(pcie, 0, H1_PCIEPHYADRR);
>>> +
>>> +   /* Ignore errors as they will be dealt with if the data link is
> down */
>>> +   phy_wait_for_ack(pcie);
>>> +}
>>> +
>>>
>>
>>> +static int __init rcar_pcie_wait_for_dl(struct rcar_pcie *pcie)
>>> +{
>>> +   unsigned int timeout = 100;
>>> +
>>> +   while (timeout--) {
>>> +      if ((pci_read_reg(pcie, PCIETSTR) & DATA_LINK_ACTIVE))
>>> +         return 0;
>>> +
>>> +      udelay(100);
>>> +   }
>>> +
>>> +   return -ETIMEDOUT;
>>> +}
>>
>> Same comments as for previous delay loop
>>
>>
>>> +static void __init rcar_pcie_hw_init(struct rcar_pcie *pcie)
>>> +{
>>> +   /* Initialise R-Car H1 PHY & wait for it to be ready */
>>> +   if (pcie->chip == RCAR_H1)
>>> +      if (rcar_pcie_phy_init_rcar_h1(pcie))
>>> +         return;
>>> +
>>> +   /* Begin initialization */
>>> +   pci_write_reg(pcie, 0, PCIETCTLR);
>>> +
>>> +   /* Set mode */
>>> +   pci_write_reg(pcie, 1, PCIEMSR);
>>> +
>>> +   /*
>>> +    * For target transfers, setup a single 64-bit 4GB mapping at
> address
>>> +    * 0. The hardware can only map memory that starts on a power of
> two
>>> +    * boundary, and size is power of 2, so best to ignore it.
>>> +    */
>>> +   pci_write_reg(pcie, 0, PCIEPRAR(0));
>>> +   pci_write_reg(pcie, 0, PCIELAR(0));
>>> +   pci_write_reg(pcie, 0xfffffff0UL | LAM_PREFETCH |
>>> +      LAM_64BIT | LAR_ENABLE, PCIELAMR(0));
>>> +   pci_write_reg(pcie, 0, PCIELAR(1));
>>> +   pci_write_reg(pcie, 0, PCIEPRAR(1));
>>> +   pci_write_reg(pcie, 0, PCIELAMR(1));
>>> +
>>> +   /*
>>> +    * Initial header for port config space is type 1, set the device
>>> +    * class to match. Hardware takes care of propagating the IDSETR
>>> +    * settings, so there is no need to bother with a quirk.
>>> +    */
>>> +   pci_write_reg(pcie, PCI_CLASS_BRIDGE_PCI << 16, IDSETR1);
>>> +
>>> +   /*
>>> +    * Setup Secondary Bus Number & Subordinate Bus Number, even
> though
>>> +    * they aren't used, to avoid bridge being detected as broken.
>>> +    */
>>> +   rcar_rmw32(pcie, RCONF(PCI_SECONDARY_BUS), 0xff, 1);
>>> +   rcar_rmw32(pcie, RCONF(PCI_SUBORDINATE_BUS), 0xff, 1);
>>> +
>>> +   /* Initialize default capabilities. */
>>> +   rcar_rmw32(pcie, REXPCAP(0), 0, PCI_CAP_ID_EXP);
>>> +   rcar_rmw32(pcie, REXPCAP(PCI_EXP_FLAGS),
>>> +      PCI_EXP_FLAGS_TYPE, PCI_EXP_TYPE_ROOT_PORT << 4);
>>> +   rcar_rmw32(pcie, RCONF(PCI_HEADER_TYPE), 0x7f,
>>> +      PCI_HEADER_TYPE_BRIDGE);
>>> +
>>> +   /* Enable data link layer active state reporting */
>>> +   rcar_rmw32(pcie, REXPCAP(PCI_EXP_LNKCAP), 0,
> PCI_EXP_LNKCAP_DLLLARC);
>>> +
>>> +   /* Write out the physical slot number = 0 */
>>> +   rcar_rmw32(pcie, REXPCAP(PCI_EXP_SLTCAP), PCI_EXP_SLTCAP_PSN, 0);
>>> +
>>> +   /* Set the completion timer timeout to the maximum 50ms. */
>>> +   rcar_rmw32(pcie, TLCTLR+1, 0x3f, 50);
>>> +
>>> +   /* Terminate list of capabilities (Next Capability Offset=0) */
>>> +   rcar_rmw32(pcie, RVCCAP(0), 0xfff0, 0);
>>> +
>>> +   /* Enable MAC data scrambling. */
>>> +   rcar_rmw32(pcie, MACCTLR, SCRAMBLE_DISABLE, 0);
>>> +
>>> +   /* Finish initialization - establish a PCI Express link */
>>> +   pci_write_reg(pcie, CFINIT, PCIETCTLR);
>>> +
>>> +   /* This will timeout if we don't have a link. */
>>> +   pcie->haslink = !rcar_pcie_wait_for_dl(pcie);
>>> +
>>> +   /* Enable INTx interrupts */
>>> +   rcar_rmw32(pcie, RCONF(PCI_INTERRUPT_LINE), 0xff, 0);
>>> +   rcar_rmw32(pcie, RCONF(PCI_INTERRUPT_PIN), 0xff, 1);
>>> +   rcar_rmw32(pcie, PCIEINTXR, 0, 0xF << 8);
>>> +
>>> +   /* Enable slave Bus Mastering */
>>> +   rcar_rmw32(pcie, RCONF(PCI_STATUS), PCI_STATUS_DEVSEL_MASK,
>>> +      PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
>>> +      PCI_STATUS_CAP_LIST | PCI_STATUS_DEVSEL_FAST);
>>> +
>>> +   wmb();
>>> +}
>>> +
>>> +static int rcar_pcie_clocks_get(struct rcar_pcie *pcie)
>>> +{
>>> +   int err = 0;
>>> +
>>> +   pcie->clk = clk_get(pcie->dev, NULL);
>>> +   if (IS_ERR(pcie->clk))
>>> +      err = PTR_ERR(pcie->clk);
>>> +   else
>>> +      clk_enable(pcie->clk);
>>> +
>>> +   return err;
>>> +}
>>
>> Shouldn't you be using pm_runtime for this?
> Yes, I'll fix this

Ta. I'm still trying to fix pm_runtime issues with devicetree.

>>> +static void rcar_pcie_clocks_put(struct rcar_pcie *pcie)
>>> +{
>>> +   clk_put(pcie->clk);
>>> +}
>>> +
>>> +struct rcar_pcie_errs {
>>> +   int bit;
>>> +   const char *description;
>>> +};
>>> +
>>> +static int __init rcar_pcie_get_resources(struct platform_device
> *pdev,
>>> +   struct rcar_pcie *pcie)
>>> +{
>>> +   struct resource *res;
>>> +   int i;
>>> +   int err;
>>> +
>>> +   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +
>>> +   i = platform_get_irq(pdev, 0);
>>> +   if (!res || i < 0) {
>>> +      dev_err(pcie->dev, "cannot get platform resources\n");
>>> +      return -ENOENT;
>>> +   }
>>> +   pcie->irq = i;
>>> +
>>> +   err = rcar_pcie_clocks_get(pcie);
>>> +   if (err) {
>>> +      dev_err(&pdev->dev, "failed to get clocks: %d\n", err);
>>> +      return err;
>>> +   }
>>> +
>>> +   pcie->base = devm_request_and_ioremap(&pdev->dev, res);
>>> +   if (!pcie->base) {
>>> +      dev_err(&pdev->dev, "failed to map PCIe registers: %d\n", err);
>>> +      err = -ENOMEM;
>>> +      goto err_map_reg;
>>> +   }
>>> +
>>> +   return 0;
>>> +
>>> +err_map_reg:
>>> +   rcar_pcie_clocks_put(pcie);
>>> +
>>> +   return err;
>>> +}
>>> +
>>> +static struct platform_device_id rcar_pcie_id_table[] = {
>>> +   { "r8a7779-pcie", RCAR_H1 },
>>> +   { "r8a7790-pcie", RCAR_GENERIC },
>>> +   { "r8a7791-pcie", RCAR_GENERIC },
>>> +   {},
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, rcar_pcie_id_table);
>>
>> Really, are you still going to submit drivers without OF bindings?
>>
>> NAK!
> I totally agree, hence my comment in the cover email:
> "This is RFC as there is some work required for DT support."
> Perhaps I should have marked each patch as RFC.

Actually, it could be applied as-is, but I would prefer DT.

I didn't notice, I only reviewed this bet, so yes marking the
lot as RFC would have been better.

>>> +static int __init rcar_pcie_probe(struct platform_device *pdev)
>>> +{
>>> +   struct rcar_pcie *pcie;
>>> +   struct resource *res;
>>> +   unsigned int data;
>>> +   int i, err;
>>> +
>>> +   pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
>>> +   if (!pcie)
>>> +      return -ENOMEM;
>>> +
>>> +   pcie->dev = &pdev->dev;
>>> +   pcie->chip = pdev->id_entry->driver_data;
>>> +
>>> +   /* Get resources */
>>> +   err = rcar_pcie_get_resources(pdev, pcie);
>>> +   if (err < 0) {
>>> +      dev_err(&pdev->dev, "failed to request resources: %d\n", err);
>>> +      return err;
>>> +   }
>>> +
>>> +   /* Get the I/O and memory ranges */
>>> +   for (i = 0; i < NR_PCI_RESOURCES; i++) {
>>> +      res = platform_get_resource(pdev, IORESOURCE_MEM, i+1);
>>> +      if (!res) {
>>> +         dev_err(&pdev->dev, "cannot get MEM%d resources\n", i);
>>> +         return -ENOENT;
>>> +      }
>>> +      pcie->res[i] = res;
>>> +   }
>>> +
>>> +   rcar_pcie_hw_init(pcie);
>>> +
>>> +   if (!pcie->haslink) {
>>> +      dev_info(&pdev->dev, "PCI: PCIe link down\n");
>>> +      return 0;
>>> +   }
>>> +
>>> +   data = pci_read_reg(pcie, MACSR);
>>> +   dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
>>> +
>>> +   rcar_pcie_enable(pcie);
>>> +
>>> +   platform_set_drvdata(pdev, pcie);
>>> +   return 0;
>>> +}
>>> +
>>> +static struct platform_driver rcar_pcie_driver = {
>>> +   .probe      = rcar_pcie_probe,
>>> +   .driver = {
>>> +      .name = DRV_NAME,
>>> +      .owner = THIS_MODULE,
>>> +   },
>>> +   .id_table   = rcar_pcie_id_table,
>>> +};
>>> +
>>> +module_platform_driver(rcar_pcie_driver);
>>> +
>>> +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
>>> +MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
>>> +MODULE_LICENSE("GPLv2");
>>> diff --git a/drivers/pci/host/pcie-rcar.h
> b/drivers/pci/host/pcie-rcar.h
>>> new file mode 100644
>>> index 0000000..a6b407f
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pcie-rcar.h
>>> @@ -0,0 +1,84 @@
>>> +/*
>>> + * PCI Express definitions for Renesas R-Car SoCs
>>> + */
>>> +#ifndef __PCI_RCAR_H
>>> +#define __PCI_RCAR_H
>>> +
>>> +#define PCI_DEVICE_ID_RENESAS_RCAR   0x0018
>>
>> should this go into pci ids header?
> This is not used so I'll remove it.
>
>>> +#define PCIECAR         0x000010
>>> +#define PCIECCTLR      0x000018
>>> +#define  CONFIG_SEND_ENABLE   (1 << 31)
>>> +#define  TYPE0         (0 << 8)
>>> +#define  TYPE1         (1 << 8)
>>> +#define PCIECDR         0x000020
>>> +#define PCIEMSR         0x000028
>>> +#define PCIEINTXR      0x000400
>>> +#define PCIEPHYSR      0x0007f0
>>> +
>>> +/* Transfer control */
>>> +#define PCIETCTLR      0x02000
>>> +#define  CFINIT         1
>>> +#define PCIETSTR      0x02004
>>> +#define  DATA_LINK_ACTIVE   1
>>> +#define PCIEINTR      0x02008
>>> +#define PCIEINTER      0x0200c
>>> +#define PCIEERRFR      0x02020
>>> +#define  UNSUPPORTED_REQUEST   (1 << 4)
>>> +#define PCIEERRFER      0x02024
>>> +#define PCIEERRFR2      0x02028
>>> +#define PCIEPMSR      0x02034
>>> +#define PCIEPMSCIER      0x02038
>>> +#define PCIEMSIFR      0x02044
>>> +
>>> +/* root port address */
>>> +#define PCIEPRAR(x)      (0x02080 + ((x) * 0x4))
>>> +
>>> +/* local address reg & mask */
>>> +#define PCIELAR(x)      (0x02200 + ((x) * 0x20))
>>> +#define PCIELAMR(x)      (0x02208 + ((x) * 0x20))
>>> +#define  LAM_PMIOLAMnB3      (1 << 3)
>>> +#define  LAM_PMIOLAMnB2      (1 << 2)
>>> +#define  LAM_PREFETCH      (1 << 3)
>>> +#define  LAM_64BIT      (1 << 2)
>>> +#define  LAR_ENABLE      (1 << 1)
>>> +
>>> +/* PCIe address reg & mask */
>>> +#define PCIEPARL(x)      (0x03400 + ((x) * 0x20))
>>> +#define PCIEPARH(x)      (0x03404 + ((x) * 0x20))
>>> +#define PCIEPAMR(x)      (0x03408 + ((x) * 0x20))
>>> +#define PCIEPTCTLR(x)      (0x0340c + ((x) * 0x20))
>>> +#define  PAR_ENABLE      (1 << 31)
>>> +#define  IO_SPACE      (1 << 8)
>>> +
>>> +/* Configuration */
>>> +#define PCICONF(x)      (0x010000 + ((x) * 0x4))
>>> +#define PMCAP(x)      (0x010040 + ((x) * 0x4))
>>> +#define MSICAP(x)      (0x010050 + ((x) * 0x4))
>>> +#define EXPCAP(x)      (0x010070 + ((x) * 0x4))
>>> +#define VCCAP(x)      (0x010100 + ((x) * 0x4))
>>> +#define SERNUMCAP(x)      (0x0101b0 + ((x) * 0x4))
>>> +
>>> +/* link layer */
>>> +#define IDSETR0         0x011000
>>> +#define IDSETR1         0x011004
>>> +#define SUBIDSETR      0x011024
>>> +#define DSERSETR0      0x01102c
>>> +#define DSERSETR1      0x011030
>>> +#define TLCTLR         0x011048
>>> +#define MACSR         0x011054
>>> +#define MACCTLR         0x011058
>>> +#define  SCRAMBLE_DISABLE   (1 << 27)
>>> +
>>> +/* R-Car H1 PHY */
>>> +#define H1_PCIEPHYCTLR      0x040008
>>> +#define H1_PCIEPHYADRR      0x04000c
>>> +#define  WRITE_CMD      (1 << 16)
>>> +#define  PHY_ACK      (1 << 24)
>>> +#define  RATE_POS      12
>>> +#define  LANE_POS      8
>>> +#define  ADR_POS      0
>>> +#define H1_PCIEPHYDOUTR      0x040014
>>> +#define H1_PCIEPHYSR      0x040018
>>> +
>>> +#endif /* __PCI_RCAR_H */
>>>
>>
>>
>> --
>> Ben Dooks            http://www.codethink.co.uk/
>> Senior Engineer            Codethink - Providing Genius
>
> Thanks
> Phil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
