Return-Path: <niklas.cassel@axis.com>
Return-Path: <niklas.cassel@axis.com>
Subject: Re: [PATCH v2 2/2] pci: host: new driver for Axis ARTPEC-6 PCIe
 controller
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1462794543-30317-1-git-send-email-niklass@axis.com>
 <20160609224125.GB19309@localhost>
CC: <bhelgaas@google.com>, <jespern@axis.com>, <akpm@linux-foundation.org>,
	<davem@davemloft.net>, <gregkh@linuxfoundation.org>,
	<mchehab@osg.samsung.com>, <linux@roeck-us.net>, <jslaby@suse.cz>,
	<robh@kernel.org>, <marc.zyngier@arm.com>, <rjui@broadcom.com>,
	<arnd@arndb.de>, <david.daney@cavium.com>, <geert+renesas@glider.be>,
	<lftan@altera.com>, <bharat.kumar.gogada@xilinx.com>, <hauke@hauke-m.de>,
	<thomas.petazzoni@free-electrons.com>, <simon.horman@netronome.com>,
	<phil.edworthy@renesas.com>, <svarbanov@mm-sol.com>, <dhdang@apm.com>,
	<wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@axis.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <575EB12D.1040206@axis.com>
Date: Mon, 13 Jun 2016 15:12:13 +0200
MIME-Version: 1.0
In-Reply-To: <20160609224125.GB19309@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>


On 06/10/2016 12:41 AM, Bjorn Helgaas wrote:
> On Mon, May 09, 2016 at 01:49:03PM +0200, Niklas Cassel wrote:
>> From: Niklas Cassel <niklas.cassel@axis.com>
>>
>> The Axis ARTPEC-6 SoC integrates a PCIe controller from Synopsys.
>> This commit adds a new driver that provides the small glue
>> needed to use the existing Designware driver to make it work on
>> the Axis ARTPEC-6 SoC.
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> Hi Niklas,
>
> I'll review this soon.  In the meantime, can you send /proc/iomem and
> /proc/ioport contents?  I'm looking to avoid problems like this:
> http://lkml.kernel.org/r/20160606230537.20936.2892.stgit@bhelgaas-glaptop2.roam.corp.google.com
>
> It looks like this is based on DesignWare, so it probably has the
> problem, and will probably be fixed by these:
>
> http://lkml.kernel.org/r/20160606230452.20936.28937.stgit@bhelgaas-glaptop2.roam.corp.google.com
> http://lkml.kernel.org/r/20160606230501.20936.71818.stgit@bhelgaas-glaptop2.roam.corp.google.com
> http://lkml.kernel.org/r/20160606230508.20936.81845.stgit@bhelgaas-glaptop2.roam.corp.google.com
>
> If you wanted to apply those and then send /proc/iomem and
> /proc/ioports, that would be even better.
>
> Bjorn
>

Output with your patches applied:

[    2.107320] PCI host bridge /pcie@f8050000 ranges:
[    2.112138]   No bus range found for /pcie@f8050000, using [bus 00-ff]
[    2.118684]    IO 0xc0010000..0xc001ffff -> 0x00010000
[    2.123835]   MEM 0xc0020000..0xdfffffff -> 0xc0020000
[    2.245559] artpec6-pcie f8050000.pcie: link up
[    2.250228] artpec6-pcie f8050000.pcie: PCI host bridge to bus 0000:00
[    2.256773] pci_bus 0000:00: root bus resource [bus 00-ff]
[    2.262273] pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x10000-0x1ffff])
[    2.271250] pci_bus 0000:00: root bus resource [mem 0xc0020000-0xdfffffff]
[    2.278407] PCI: bus0: Fast back to back transfers disabled
[    2.293358] PCI: bus1: Fast back to back transfers disabled
[    2.299018] pci 0000:00:00.0: BAR 0: assigned [mem 0xc0100000-0xc01fffff]
[    2.305825] pci 0000:00:00.0: BAR 1: assigned [mem 0xc0200000-0xc02fffff]
[    2.312627] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0300000-0xc07fffff]
[    2.319430] pci 0000:01:00.0: BAR 1: assigned [mem 0xc0400000-0xc05fffff]
[    2.326241] pci 0000:01:00.0: BAR 2: assigned [mem 0xc0600000-0xc07fffff]
[    2.333052] pci 0000:01:00.0: BAR 0: assigned [mem 0xc0300000-0xc0303fff]
[    2.339862] pci 0000:00:00.0: PCI bridge to [bus 01]
[    2.344838] pci 0000:00:00.0:   bridge window [mem 0xc0300000-0xc07fffff]

# cat /proc/iomem
00000000-0fffffff : System RAM
  00208000-01071b2f : Kernel code
  01300000-01465347 : Kernel data
c0020000-dfffffff : MEM
  c0100000-c01fffff : 0000:00:00.0
  c0200000-c02fffff : 0000:00:00.0
  c0300000-c07fffff : PCI Bus 0000:01
    c0300000-c0303fff : 0000:01:00.0
      c0301000-c0301007 : serial
      c0301200-c0301207 : serial
    c0400000-c05fffff : 0000:01:00.0
    c0600000-c07fffff : 0000:01:00.0
f8010000-f8013fff : /amba@0/ethernet@f8010000
f8036000-f8036fff : /amba@0/serial@f8036000
  f8036000-f8036fff : /amba@0/serial@f8036000
f8037000-f8037fff : /amba@0/serial@f8037000
  f8037000-f8037fff : /amba@0/serial@f8037000
f8038000-f8038fff : /amba@0/serial@f8038000
  f8038000-f8038fff : /amba@0/serial@f8038000
f8039000-f8039fff : /amba@0/serial@f8039000
  f8039000-f8039fff : /amba@0/serial@f8039000
f8040000-f8040fff : phy
f8050000-f8051fff : dbi

# cat /proc/ioports
00000000-0000ffff : I/O


Without your patches applied:
/proc/ioports is empty.
/proc/iomem is missing the node "c0020000-dfffffff : MEM"
and all of its child nodes.

>> ---
>> Changes since v1:
>>  - Rename syscon DT node to be more descriptive
>>  - Use module_platform_driver macro
>>
>>  MAINTAINERS                     |   9 ++
>>  drivers/pci/host/Kconfig        |   6 +
>>  drivers/pci/host/Makefile       |   1 +
>>  drivers/pci/host/pcie-artpec6.c | 293 ++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 309 insertions(+)
>>  create mode 100644 drivers/pci/host/pcie-artpec6.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c18feb5..88d5443 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8772,6 +8772,15 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
>>  F:	drivers/pci/host/pci-xgene-msi.c
>>  
>> +PCIE DRIVER FOR AXIS ARTPEC
>> +M:	Niklas Cassel <niklas.cassel@axis.com>
>> +M:	Jesper Nilsson <jesper.nilsson@axis.com>
>> +L:	linux-arm-kernel@axis.com
>> +L:	linux-pci@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/pci/axis,artpec*
>> +F:	drivers/pci/host/*artpec*
>> +
>>  PCIE DRIVER FOR HISILICON
>>  M:	Zhou Wang <wangzhou1@hisilicon.com>
>>  M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 5855f85..29e159a 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -244,4 +244,10 @@ config PCIE_ARMADA_8K
>>  	  Designware hardware and therefore the driver re-uses the
>>  	  Designware core functions to implement the driver.
>>  
>> +config PCIE_ARTPEC6
>> +	bool "Axis ARTPEC-6 PCIe controller"
>> +	depends on MACH_ARTPEC6
>> +	select PCIE_DW
>> +	select PCIEPORTBUS
>> +
>>  endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index 9c8698e..5bc0af2 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -29,3 +29,4 @@ obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>> +obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>> diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
>> new file mode 100644
>> index 0000000..d53dbaf
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-artpec6.c
>> @@ -0,0 +1,293 @@
>> +/*
>> + * PCIe host controller driver for Axis ARTPEC-6 SoC
>> + *
>> + * Based on work done by Phil Edworthy <phil@edworthys.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/resource.h>
>> +#include <linux/signal.h>
>> +#include <linux/types.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +#define to_artpec6_pcie(x)	container_of(x, struct artpec6_pcie, pp)
>> +
>> +struct artpec6_pcie {
>> +	struct pcie_port	pp;
>> +	struct regmap		*regmap;
>> +	void __iomem		*phy_base;
>> +};
>> +
>> +/* PCIe Port Logic registers (memory-mapped) */
>> +#define PL_OFFSET			0x700
>> +#define PCIE_PHY_DEBUG_R0		(PL_OFFSET + 0x28)
>> +#define PCIE_PHY_DEBUG_R1		(PL_OFFSET + 0x2c)
>> +
>> +#define MISC_CONTROL_1_OFF		(PL_OFFSET + 0x1bc)
>> +#define  DBI_RO_WR_EN			1
>> +
>> +/* ARTPEC-6 specific registers */
>> +#define PCIECFG				0x18
>> +#define  PCIECFG_DBG_OEN		(1 << 24)
>> +#define  PCIECFG_CORE_RESET_REQ		(1 << 21)
>> +#define  PCIECFG_LTSSM_ENABLE		(1 << 20)
>> +#define  PCIECFG_CLKREQ_B		(1 << 11)
>> +#define  PCIECFG_REFCLK_ENABLE		(1 << 10)
>> +#define  PCIECFG_PLL_ENABLE		(1 << 9)
>> +#define  PCIECFG_PCLK_ENABLE		(1 << 8)
>> +#define  PCIECFG_RISRCREN		(1 << 4)
>> +#define  PCIECFG_MODE_TX_DRV_EN		(1 << 3)
>> +#define  PCIECFG_CISRREN		(1 << 2)
>> +#define  PCIECFG_MACRO_ENABLE		(1 << 0)
>> +
>> +#define NOCCFG				0x40
>> +#define NOCCFG_ENABLE_CLK_PCIE		(1 << 4)
>> +#define NOCCFG_POWER_PCIE_IDLEACK	(1 << 3)
>> +#define NOCCFG_POWER_PCIE_IDLE		(1 << 2)
>> +#define NOCCFG_POWER_PCIE_IDLEREQ	(1 << 1)
>> +
>> +#define PHY_STATUS			0x118
>> +#define PHY_COSPLLLOCK			(1 << 0)
>> +
>> +#define ARTPEC6_CPU_TO_BUS_ADDR		0x0FFFFFFF
>> +
>> +static int artpec6_pcie_establish_link(struct pcie_port *pp)
>> +{
>> +	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pp);
>> +	u32 val;
>> +	unsigned int retries;
>> +
>> +	/* Hold DW core in reset */
>> +	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
>> +	val |= PCIECFG_CORE_RESET_REQ;
>> +	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
>> +
>> +	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
>> +	val |=  PCIECFG_RISRCREN |	/* Receiver term. 50 Ohm */
>> +		PCIECFG_MODE_TX_DRV_EN |
>> +		PCIECFG_CISRREN |	/* Reference clock term. 100 Ohm */
>> +		PCIECFG_MACRO_ENABLE;
>> +	val |= PCIECFG_REFCLK_ENABLE;
>> +	val &= ~PCIECFG_DBG_OEN;
>> +	val &= ~PCIECFG_CLKREQ_B;
>> +	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
>> +	usleep_range(5000, 6000);
>> +
>> +	regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
>> +	val |= NOCCFG_ENABLE_CLK_PCIE;
>> +	regmap_write(artpec6_pcie->regmap, NOCCFG, val);
>> +	usleep_range(20, 30);
>> +
>> +	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
>> +	val |= PCIECFG_PCLK_ENABLE | PCIECFG_PLL_ENABLE;
>> +	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
>> +	usleep_range(6000, 7000);
>> +
>> +	regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
>> +	val &= ~NOCCFG_POWER_PCIE_IDLEREQ;
>> +	regmap_write(artpec6_pcie->regmap, NOCCFG, val);
>> +
>> +	retries = 50;
>> +	do {
>> +		usleep_range(1000, 2000);
>> +		regmap_read(artpec6_pcie->regmap, NOCCFG, &val);
>> +		retries--;
>> +	} while (retries &&
>> +		(val & (NOCCFG_POWER_PCIE_IDLEACK | NOCCFG_POWER_PCIE_IDLE)));
>> +
>> +	retries = 50;
>> +	do {
>> +		usleep_range(1000, 2000);
>> +		val = readl(artpec6_pcie->phy_base + PHY_STATUS);
>> +		retries--;
>> +	} while (retries && !(val & PHY_COSPLLLOCK));
>> +
>> +	/* Take DW core out of reset */
>> +	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
>> +	val &= ~PCIECFG_CORE_RESET_REQ;
>> +	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
>> +	usleep_range(100, 200);
>> +
>> +	/*
>> +	 * Enable writing to config regs. This is required as the Synopsys
>> +	 * driver changes the class code. That register needs DBI write enable.
>> +	 */
>> +	writel(DBI_RO_WR_EN, pp->dbi_base + MISC_CONTROL_1_OFF);
>> +
>> +	pp->io_base &= ARTPEC6_CPU_TO_BUS_ADDR;
>> +	pp->mem_base &= ARTPEC6_CPU_TO_BUS_ADDR;
>> +	pp->cfg0_base &= ARTPEC6_CPU_TO_BUS_ADDR;
>> +	pp->cfg1_base &= ARTPEC6_CPU_TO_BUS_ADDR;
>> +
>> +	/* setup root complex */
>> +	dw_pcie_setup_rc(pp);
>> +
>> +	/* assert LTSSM enable */
>> +	regmap_read(artpec6_pcie->regmap, PCIECFG, &val);
>> +	val |= PCIECFG_LTSSM_ENABLE;
>> +	regmap_write(artpec6_pcie->regmap, PCIECFG, val);
>> +
>> +	/* check if the link is up or not */
>> +	if (!dw_pcie_wait_for_link(pp))
>> +		return 0;
>> +
>> +	dev_dbg(pp->dev, "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
>> +		readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
>> +		readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static void artpec6_pcie_enable_interrupts(struct pcie_port *pp)
>> +{
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		dw_pcie_msi_init(pp);
>> +}
>> +
>> +static void artpec6_pcie_host_init(struct pcie_port *pp)
>> +{
>> +	artpec6_pcie_establish_link(pp);
>> +	artpec6_pcie_enable_interrupts(pp);
>> +}
>> +
>> +static int artpec6_pcie_link_up(struct pcie_port *pp)
>> +{
>> +	u32 rc;
>> +
>> +	/*
>> +	 * Get status from Synopsys IP
>> +	 * link is debug bit 36, debug register 1 starts at bit 32
>> +	 */
>> +	rc = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1) & (0x1 << (36 - 32));
>> +	if (rc)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct pcie_host_ops artpec6_pcie_host_ops = {
>> +	.link_up = artpec6_pcie_link_up,
>> +	.host_init = artpec6_pcie_host_init,
>> +};
>> +
>> +static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
>> +{
>> +	struct pcie_port *pp = arg;
>> +
>> +	return dw_handle_msi_irq(pp);
>> +}
>> +
>> +static int __init artpec6_add_pcie_port(struct pcie_port *pp,
>> +					struct platform_device *pdev)
>> +{
>> +	int ret;
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
>> +		if (pp->msi_irq <= 0) {
>> +			dev_err(&pdev->dev, "failed to get MSI irq\n");
>> +			return -ENODEV;
>> +		}
>> +
>> +		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
>> +				       artpec6_pcie_msi_handler,
>> +				       IRQF_SHARED | IRQF_NO_THREAD,
>> +				       "artpec6-pcie-msi", pp);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "failed to request MSI irq\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	pp->root_bus_nr = -1;
>> +	pp->ops = &artpec6_pcie_host_ops;
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "failed to initialize host\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init artpec6_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct artpec6_pcie *artpec6_pcie;
>> +	struct pcie_port *pp;
>> +	struct resource *dbi_base;
>> +	struct resource *phy_base;
>> +	int ret;
>> +
>> +	artpec6_pcie = devm_kzalloc(&pdev->dev, sizeof(*artpec6_pcie),
>> +				    GFP_KERNEL);
>> +	if (!artpec6_pcie)
>> +		return -ENOMEM;
>> +
>> +	pp = &artpec6_pcie->pp;
>> +	pp->dev = &pdev->dev;
>> +
>> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>> +	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
>> +	if (IS_ERR(pp->dbi_base)) {
>> +		ret = PTR_ERR(pp->dbi_base);
>> +		goto fail;
>> +	}
>> +
>> +	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
>> +	artpec6_pcie->phy_base = devm_ioremap_resource(&pdev->dev, phy_base);
>> +	if (IS_ERR(artpec6_pcie->phy_base)) {
>> +		ret = PTR_ERR(artpec6_pcie->phy_base);
>> +		goto fail;
>> +	}
>> +
>> +	artpec6_pcie->regmap =
>> +		syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>> +						"axis,syscon-pcie");
>> +	if (IS_ERR(artpec6_pcie->regmap)) {
>> +		ret = PTR_ERR(artpec6_pcie->regmap);
>> +		goto fail;
>> +	}
>> +
>> +	ret = artpec6_add_pcie_port(pp, pdev);
>> +	if (ret < 0)
>> +		goto fail;
>> +
>> +	platform_set_drvdata(pdev, artpec6_pcie);
>> +	return 0;
>> +
>> +fail:
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id artpec6_pcie_of_match[] = {
>> +	{ .compatible = "axis,artpec6-pcie", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, artpec6_pcie_of_match);
>> +
>> +static struct platform_driver artpec6_pcie_driver = {
>> +	.probe = artpec6_pcie_probe,
>> +	.driver = {
>> +		.name	= "artpec6-pcie",
>> +		.of_match_table = artpec6_pcie_of_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(artpec6_pcie_driver);
>> +
>> +MODULE_AUTHOR("Niklas Cassel <niklas.cassel@axis.com>");
>> +MODULE_DESCRIPTION("Axis ARTPEC-6 PCIe host controller driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
