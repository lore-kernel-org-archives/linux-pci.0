Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752063AbdHVTBj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 15:01:39 -0400
Date: Tue, 22 Aug 2017 14:01:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] PCI: v3-semi: Add a V3 Semiconductor PCI host
 driver
Message-ID: <20170822190137.GB6948@bhelgaas-glaptop.roam.corp.google.com>
References: <20170809141455.22220-1-linus.walleij@linaro.org>
 <20170809141455.22220-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170809141455.22220-2-linus.walleij@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Nice, thanks for doing this and updating everything to the current PCI
core interfaces!

On Wed, Aug 09, 2017 at 04:14:55PM +0200, Linus Walleij wrote:
> This PCI host bridge from V3 Semiconductor needs no further
> introduction. An ancient driver for it has been sitting in
> arch/arm/mach-integrator/pci_v3.* since before v2.6.12 and the
> initial migration to git.
> 
> But we need to get the drivers out of arch/arm/* and get
> proper handling of the old drivers, rewrite and clean up so
> the PCI maintainer can control the mass of drivers without
> having to run all over the kernel. We also switch swiftly
> to all the new infrastructure found in the PCI hosts as of
> late.
> 
> Some code is preserved so I have added an extensive list of
> authors in the top comment section.
> 
> This driver probes with the following result:
> 
> OF: PCI: host bridge /pciv3@62000000 ranges:
> OF: PCI:   No bus range found for /pciv3@62000000, using [bus 00-ff]
> OF: PCI:   err 0x61000000..0x61ffffff -> 0x61000000
> OF: PCI:    IO 0x60000000..0x600fffff -> 0x00000000
> OF: PCI:   MEM 0x40000000..0x4fffffff -> 0x00000000
> OF: PCI:   MEM 0x50000000..0x5fffffff -> 0x10000000
> pci-v3-semi 62000000.pciv3: BUS 0
> pci-v3-semi 62000000.pciv3: CONFIG SPACE window
>   start 61000000, size 01000000 (offset = 00000000, bus addr = 61000000)
> pci-v3-semi 62000000.pciv3: I/O window
>   start 00000000, bus addr 00000000, size 00100000
> pci-v3-semi 62000000.pciv3: NON-PREFETCHABLE MEM window
>   start 40000000, bus addr 00000000, size 10000000
> pci-v3-semi 62000000.pciv3: PREFETCHABLE MEM window
>   start 50000000, bus addr 10000000, size 10000000
> pci-v3-semi 62000000.pciv3: FIFO_CFG: 0000  FIFO_PRIO: 0000
> pci-v3-semi 62000000.pciv3: initialized PCI V3 Integrator/AP integration
> pci-v3-semi 62000000.pciv3: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [??? 0x61000000-0x61ffffff flags 0x0]

I think this is wrong.  Looks like this might be memory-mapped config
space (e.g., MMCONFIG or ECAM-like space), which is not a window and
shouldn't be added to the root bus resources.

The driver still needs it internally, of course, and maybe could print
something similar to what we do for ECAM:

  dev_info(dev, "ECAM at %pR for %pR\n", &cfg->res, &cfg->busr)

(I don't know if this is actually identical to ECAM, so maybe there's
a better internally-used name for the region, but we could print the
memory and bus resources similarly.)

> pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
> pci_bus 0000:00: root bus resource [mem 0x40000000-0x4fffffff]
>   (bus address [0x00000000-0x0fffffff])
> pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff pref]
>   (bus address [0x10000000-0x1fffffff])

It seems a little excessive to print all the window information three
times, but that's definitely a second-order issue and not unique to
this driver.  It might be time to try to consolidate all the OF/DT
probing stuff -- there's a lot of duplicated code there.

Most of the other callers of of_pci_get_host_bridge_resources() don't
print the regions as they parse them, so that might be a start.

> pci 0000:00:09.0: [1011:0024] type 01 class 0x060400
> pci 0000:00:0b.0: [8086:1229] type 00 class 0x020000
> pci 0000:00:0b.0: reg 0x10: [mem 0x40000000-0x40000fff pref]
> pci 0000:00:0b.0: reg 0x14: [io  0x0000-0x001f]
> pci 0000:00:0b.0: reg 0x18: [mem 0x40000000-0x400fffff]
> pci 0000:00:0b.0: reg 0x30: [mem 0x40000000-0x400fffff pref]
> pci 0000:00:0b.0: supports D1 D2
> pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot
> pci 0000:00:0c.0: [5333:8811] type 00 class 0x030000
> pci 0000:00:0c.0: reg 0x10: [mem 0x40000000-0x43ffffff]
> pci 0000:00:0c.0: reg 0x30: [mem 0x40000000-0x4000ffff pref]
> pci 0000:00:0c.0: vgaarb: VGA device added: decodes=io+mem,owns=io,locks=none
> PCI: bus0: Fast back to back transfers disabled
> PCI: bus1: Fast back to back transfers enabled
> pci 0000:00:0c.0: BAR 0: assigned [mem 0x40000000-0x43ffffff]
> pci 0000:00:0b.0: BAR 2: assigned [mem 0x44000000-0x440fffff]
> pci 0000:00:0b.0: BAR 6: assigned [mem 0x50000000-0x500fffff pref]
> pci 0000:00:0c.0: BAR 6: assigned [mem 0x50100000-0x5010ffff pref]
> pci 0000:00:0b.0: BAR 0: assigned [mem 0x50110000-0x50110fff pref]
> pci 0000:00:0b.0: BAR 1: assigned [io  0x1000-0x101f]
> pci 0000:00:09.0: PCI bridge to [bus 01]
> pci 0000:00:0b.0: Firmware left e100 interrupts enabled; disabling
> (...)
> e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> e100: Copyright(c) 1999-2006 Intel Corporation
> e100 0000:00:0b.0: enabling device (0146 -> 0147)
> e100 0000:00:0b.0 eth0: addr 0x50110000, irq 31, MAC addr 00:08:c7:99:d2:57
> rtc-pl030 15000000.rtc: rtc core: registered pl030 as rtc0
> 
> > lspci
> 00:0b.0 Class 0200: 8086:1229
> 00:09.0 Class 0604: 1011:0024
> 00:0c.0 Class 0300: 5333:8811
> 
> > cat /proc/iomem
> 40000000-4fffffff : V3 PCI NON-PRE-MEM
>   40000000-43ffffff : 0000:00:0c.0
>   44000000-440fffff : 0000:00:0b.0
>     44000000-440fffff : e100
> 50000000-5fffffff : V3 PCI PRE-MEM
>   50000000-500fffff : 0000:00:0b.0
>   50100000-5010ffff : 0000:00:0c.0
>   50110000-50110fff : 0000:00:0b.0
>     50110000-50110fff : e100
> 61000000-61ffffff : V3 Config Space
> 62000000-6200ffff : /pciv3@62000000
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1 (RFC) -> v2:
> - Fixed the IRQ problem (just needed to add the right standard
>   host ops, sigh)
> - Cleaned up defines
> - Now works as good as the old driver
> - Preserve some more comments from the old driver
> - Add a few more defines in place of magic constants
> - Suppress bind attributes
> - Add entry to MAINTAINERS
> - Fix a slew of checkpatch business, leave some long lines since
>   they are debug prints
> 
> Bjorn: please merge this once you're happy with it.
> ---
>  MAINTAINERS                    |   7 +
>  drivers/pci/host/Kconfig       |   6 +
>  drivers/pci/host/Makefile      |   1 +
>  drivers/pci/host/pci-v3-semi.c | 742 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 756 insertions(+)
>  create mode 100644 drivers/pci/host/pci-v3-semi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 205d3977ac46..8205f2aa6c1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10201,6 +10201,13 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	drivers/pci/host/vmd.c
>  
> +PCI DRIVER FOR V3 SEMICONDUCTOR V360EPC
> +M:	Linus Walleij <linus.walleij@linaro.org>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/v3-v360epc-pci.txt
> +F:	drivers/pci/host/pci-v3-semi.c
> +
>  PCIE DRIVER FOR ST SPEAR13XX
>  M:	Pratyush Anand <pratyush.anand@gmail.com>
>  L:	linux-pci@vger.kernel.org
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 89d61c2cbfaa..bc7ba5a08559 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -95,6 +95,12 @@ config PCI_XGENE_MSI
>  	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
>  	  This MSI driver supports 5 PCIe ports on the APM X-Gene v1 SoC.
>  
> +config PCI_V3_SEMI
> +	bool "V3 Semiconductor PCI controller"
> +	depends on OF
> +	depends on ARM
> +	default ARCH_INTEGRATOR_AP
> +
>  config PCI_VERSATILE
>  	bool "ARM Versatile PB PCI controller"
>  	depends on ARCH_VERSATILE
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 12382785e02a..ee7cd492bb7f 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
> +obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
> diff --git a/drivers/pci/host/pci-v3-semi.c b/drivers/pci/host/pci-v3-semi.c
> new file mode 100644
> index 000000000000..ae3dc693f017
> --- /dev/null
> +++ b/drivers/pci/host/pci-v3-semi.c
> @@ -0,0 +1,742 @@
> +/*
> + * Support for V3 Semiconductor PCI Local Bus to PCI Bridge
> + * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
> + *
> + * Based on the code from arch/arm/mach-integrator/pci_v3.c
> + * Copyright (C) 1999 ARM Limited
> + * Copyright (C) 2000-2001 Deep Blue Solutions Ltd
> + *
> + * Contributors to the old driver include:
> + * Russell King <linux@armlinux.org.uk>
> + * David A. Rusling <david.rusling@linaro.org> (uHAL, ARM Firmware suite)
> + * Rob Herring <robh@kernel.org>
> + * Liviu Dudau <Liviu.Dudau@arm.com>
> + * Grant Likely <grant.likely@secretlab.ca>
> + * Arnd Bergmann <arnd@arndb.de>
> + * Bjorn Helgaas <bhelgaas@google.com>
> + */
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/irq.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/clk.h>
> +
> +#define V3_PCI_VENDOR			0x00000000
> +#define V3_PCI_DEVICE			0x00000002
> +#define V3_PCI_CMD			0x00000004
> +#define V3_PCI_STAT			0x00000006
> +#define V3_PCI_CC_REV			0x00000008
> +#define V3_PCI_HDR_CFG			0x0000000C
> +#define V3_PCI_IO_BASE			0x00000010
> +#define V3_PCI_BASE0			0x00000014
> +#define V3_PCI_BASE1			0x00000018
> +#define V3_PCI_SUB_VENDOR		0x0000002C
> +#define V3_PCI_SUB_ID			0x0000002E
> +#define V3_PCI_ROM			0x00000030
> +#define V3_PCI_BPARAM			0x0000003C
> +#define V3_PCI_MAP0			0x00000040
> +#define V3_PCI_MAP1			0x00000044
> +#define V3_PCI_INT_STAT			0x00000048
> +#define V3_PCI_INT_CFG			0x0000004C
> +#define V3_LB_BASE0			0x00000054
> +#define V3_LB_BASE1			0x00000058
> +#define V3_LB_MAP0			0x0000005E
> +#define V3_LB_MAP1			0x00000062
> +#define V3_LB_BASE2			0x00000064
> +#define V3_LB_MAP2			0x00000066
> +#define V3_LB_SIZE			0x00000068
> +#define V3_LB_IO_BASE			0x0000006E
> +#define V3_FIFO_CFG			0x00000070
> +#define V3_FIFO_PRIORITY		0x00000072
> +#define V3_FIFO_STAT			0x00000074
> +#define V3_LB_ISTAT			0x00000076
> +#define V3_LB_IMASK			0x00000077
> +#define V3_SYSTEM			0x00000078
> +#define V3_LB_CFG			0x0000007A
> +#define V3_PCI_CFG			0x0000007C
> +#define V3_DMA_PCI_ADR0			0x00000080
> +#define V3_DMA_PCI_ADR1			0x00000090
> +#define V3_DMA_LOCAL_ADR0		0x00000084
> +#define V3_DMA_LOCAL_ADR1		0x00000094
> +#define V3_DMA_LENGTH0			0x00000088
> +#define V3_DMA_LENGTH1			0x00000098
> +#define V3_DMA_CSR0			0x0000008B
> +#define V3_DMA_CSR1			0x0000009B
> +#define V3_DMA_CTLB_ADR0		0x0000008C
> +#define V3_DMA_CTLB_ADR1		0x0000009C
> +#define V3_DMA_DELAY			0x000000E0
> +#define V3_MAIL_DATA			0x000000C0
> +#define V3_PCI_MAIL_IEWR		0x000000D0
> +#define V3_PCI_MAIL_IERD		0x000000D2
> +#define V3_LB_MAIL_IEWR			0x000000D4
> +#define V3_LB_MAIL_IERD			0x000000D6
> +#define V3_MAIL_WR_STAT			0x000000D8
> +#define V3_MAIL_RD_STAT			0x000000DA
> +#define V3_QBA_MAP			0x000000DC
> +
> +/* PCI STATUS bits */
> +#define V3_PCI_STAT_PAR_ERR		BIT(15)
> +#define V3_PCI_STAT_SYS_ERR		BIT(14)
> +#define V3_PCI_STAT_M_ABORT_ERR		BIT(13)
> +#define V3_PCI_STAT_T_ABORT_ERR		BIT(12)
> +
> +/* LB ISTAT bits */
> +#define V3_LB_ISTAT_MAILBOX		BIT(7)
> +#define V3_LB_ISTAT_PCI_RD		BIT(6)
> +#define V3_LB_ISTAT_PCI_WR		BIT(5)
> +#define V3_LB_ISTAT_PCI_INT		BIT(4)
> +#define V3_LB_ISTAT_PCI_PERR		BIT(3)
> +#define V3_LB_ISTAT_I2O_QWR		BIT(2)
> +#define V3_LB_ISTAT_DMA1		BIT(1)
> +#define V3_LB_ISTAT_DMA0		BIT(0)
> +
> +/* PCI COMMAND bits */
> +#define V3_COMMAND_M_FBB_EN		BIT(9)
> +#define V3_COMMAND_M_SERR_EN		BIT(8)
> +#define V3_COMMAND_M_PAR_EN		BIT(6)
> +#define V3_COMMAND_M_MASTER_EN		BIT(2)
> +#define V3_COMMAND_M_MEM_EN		BIT(1)
> +#define V3_COMMAND_M_IO_EN		BIT(0)
> +
> +/* SYSTEM bits */
> +#define V3_SYSTEM_M_RST_OUT		BIT(15)
> +#define V3_SYSTEM_M_LOCK		BIT(14)
> +#define V3_SYSTEM_UNLOCK		0xa05f
> +
> +/* PCI CFG bits */
> +#define V3_PCI_CFG_M_I2O_EN		BIT(15)
> +#define V3_PCI_CFG_M_IO_REG_DIS		BIT(14)
> +#define V3_PCI_CFG_M_IO_DIS		BIT(13)
> +#define V3_PCI_CFG_M_EN3V		BIT(12)
> +#define V3_PCI_CFG_M_RETRY_EN		BIT(10)
> +#define V3_PCI_CFG_M_AD_LOW1		BIT(9)
> +#define V3_PCI_CFG_M_AD_LOW0		BIT(8)
> +
> +/* PCI BASE bits (PCI -> Local Bus) */
> +#define V3_PCI_BASE_M_ADR_BASE		0xFFF00000U
> +#define V3_PCI_BASE_M_ADR_BASEL		0x000FFF00U
> +#define V3_PCI_BASE_M_PREFETCH		BIT(3)
> +#define V3_PCI_BASE_M_TYPE		(3 << 1)
> +#define V3_PCI_BASE_M_IO		BIT(0)
> +
> +/* PCI MAP bits (PCI -> Local bus) */
> +#define V3_PCI_MAP_M_MAP_ADR		0xFFF00000U
> +#define V3_PCI_MAP_M_RD_POST_INH	BIT(15)
> +#define V3_PCI_MAP_M_ROM_SIZE		(3 << 10)
> +#define V3_PCI_MAP_M_SWAP		(3 << 8)
> +#define V3_PCI_MAP_M_ADR_SIZE		0x000000F0U
> +#define V3_PCI_MAP_M_REG_EN		BIT(1)
> +#define V3_PCI_MAP_M_ENABLE		BIT(0)
> +
> +/* LB_BASE0,1 bits (Local bus -> PCI) */
> +#define V3_LB_BASE_ADR_BASE		0xfff00000U
> +#define V3_LB_BASE_SWAP			(3 << 8)
> +#define V3_LB_BASE_ADR_SIZE		(15 << 4)
> +#define V3_LB_BASE_PREFETCH		BIT(3)
> +#define V3_LB_BASE_ENABLE		BIT(0)
> +
> +#define V3_LB_BASE_ADR_SIZE_1MB		(0 << 4)
> +#define V3_LB_BASE_ADR_SIZE_2MB		(1 << 4)
> +#define V3_LB_BASE_ADR_SIZE_4MB		(2 << 4)
> +#define V3_LB_BASE_ADR_SIZE_8MB		(3 << 4)
> +#define V3_LB_BASE_ADR_SIZE_16MB	(4 << 4)
> +#define V3_LB_BASE_ADR_SIZE_32MB	(5 << 4)
> +#define V3_LB_BASE_ADR_SIZE_64MB	(6 << 4)
> +#define V3_LB_BASE_ADR_SIZE_128MB	(7 << 4)
> +#define V3_LB_BASE_ADR_SIZE_256MB	(8 << 4)
> +#define V3_LB_BASE_ADR_SIZE_512MB	(9 << 4)
> +#define V3_LB_BASE_ADR_SIZE_1GB		(10 << 4)
> +#define V3_LB_BASE_ADR_SIZE_2GB		(11 << 4)
> +
> +#define v3_addr_to_lb_base(a)	((a) & V3_LB_BASE_ADR_BASE)
> +
> +/* LB_MAP0,1 bits (Local bus -> PCI) */
> +#define V3_LB_MAP_MAP_ADR		0xfff0U
> +#define V3_LB_MAP_TYPE			(7 << 1)
> +#define V3_LB_MAP_AD_LOW_EN		BIT(0)
> +
> +#define V3_LB_MAP_TYPE_IACK		(0 << 1)
> +#define V3_LB_MAP_TYPE_IO		(1 << 1)
> +#define V3_LB_MAP_TYPE_MEM		(3 << 1)
> +#define V3_LB_MAP_TYPE_CONFIG		(5 << 1)
> +#define V3_LB_MAP_TYPE_MEM_MULTIPLE	(6 << 1)
> +
> +#define v3_addr_to_lb_map(a)	(((a) >> 16) & V3_LB_MAP_MAP_ADR)
> +
> +/* LB_BASE2 bits (Local bus -> PCI IO) */
> +#define V3_LB_BASE2_ADR_BASE		0xff00U
> +#define V3_LB_BASE2_SWAP		(3 << 6)
> +#define V3_LB_BASE2_ENABLE		BIT(0)
> +
> +#define v3_addr_to_lb_base2(a)	(((a) >> 16) & V3_LB_BASE2_ADR_BASE)
> +
> +/* LB_MAP2 bits (Local bus -> PCI IO) */
> +#define V3_LB_MAP2_MAP_ADR		0xff00U
> +
> +#define v3_addr_to_lb_map2(a)	(((a) >> 16) & V3_LB_MAP2_MAP_ADR)
> +
> +/* FIFO priority bits */
> +#define V3_FIFO_PRIO_LOCAL		BIT(12)
> +#define V3_FIFO_PRIO_LB_RD1_FLUSH_EOB	BIT(10)
> +#define V3_FIFO_PRIO_LB_RD1_FLUSH_AP1	BIT(11)
> +#define V3_FIFO_PRIO_LB_RD1_FLUSH_ANY	(BIT(10)|BIT(11))
> +#define V3_FIFO_PRIO_LB_RD0_FLUSH_EOB	BIT(8)
> +#define V3_FIFO_PRIO_LB_RD0_FLUSH_AP1	BIT(9)
> +#define V3_FIFO_PRIO_LB_RD0_FLUSH_ANY	(BIT(8)|BIT(9))
> +#define V3_FIFO_PRIO_PCI		BIT(4)
> +#define V3_FIFO_PRIO_PCI_RD1_FLUSH_EOB	BIT(2)
> +#define V3_FIFO_PRIO_PCI_RD1_FLUSH_AP1	BIT(3)
> +#define V3_FIFO_PRIO_PCI_RD1_FLUSH_ANY	(BIT(2)|BIT(3))
> +#define V3_FIFO_PRIO_PCI_RD0_FLUSH_EOB	BIT(0)
> +#define V3_FIFO_PRIO_PCI_RD0_FLUSH_AP1	BIT(1)
> +#define V3_FIFO_PRIO_PCI_RD0_FLUSH_ANY	(BIT(0)|BIT(1))
> +
> +/* Local bus configuration bits */
> +#define V3_LB_CFG_LB_TO_64_CYCLES	0x0000
> +#define V3_LB_CFG_LB_TO_256_CYCLES	BIT(13)
> +#define V3_LB_CFG_LB_TO_512_CYCLES	BIT(14)
> +#define V3_LB_CFG_LB_TO_1024_CYCLES	(BIT(13)|BIT(14))
> +#define V3_LB_CFG_LB_RST		BIT(12)
> +#define V3_LB_CFG_LB_PPC_RDY		BIT(11)
> +#define V3_LB_CFG_LB_LB_INT		BIT(10)
> +#define V3_LB_CFG_LB_ERR_EN		BIT(9)
> +#define V3_LB_CFG_LB_RDY_EN		BIT(8)
> +#define V3_LB_CFG_LB_BE_IMODE		BIT(7)
> +#define V3_LB_CFG_LB_BE_OMODE		BIT(6)
> +#define V3_LB_CFG_LB_ENDIAN		BIT(5)
> +#define V3_LB_CFG_LB_PARK_EN		BIT(4)
> +#define V3_LB_CFG_LB_FBB_DIS		BIT(2)
> +
> +/* ARM Integrator-specific extended control registers */
> +#define INTEGRATOR_SC_PCIENABLE_OFFSET	0x18
> +#define INTEGRATOR_SC_LBFADDR_OFFSET	0x20
> +#define INTEGRATOR_SC_LBFCODE_OFFSET	0x24
> +
> +struct v3_pci {
> +	struct device *dev;
> +	void __iomem *base;
> +	void __iomem *config_base;
> +	struct pci_bus *bus;
> +	u32 config_mem;
> +	u32 io_mem;
> +	u32 non_pre_mem;
> +	u32 pre_mem;
> +	phys_addr_t io_bus_addr;
> +	phys_addr_t non_pre_bus_addr;
> +	phys_addr_t pre_bus_addr;
> +	struct regmap *map;
> +};
> +
> +/*
> + * The V3 PCI interface chip in Integrator provides several windows from
> + * local bus memory into the PCI memory areas. Unfortunately, there
> + * are not really enough windows for our usage, therefore we reuse
> + * one of the windows for access to PCI configuration space. On the
> + * Integrator/AP, the memory map is as follows:
> + *
> + * Local Bus Memory         Usage
> + *
> + * 40000000 - 4FFFFFFF      PCI memory.  256M non-prefetchable
> + * 50000000 - 5FFFFFFF      PCI memory.  256M prefetchable
> + * 60000000 - 60FFFFFF      PCI IO.  16M
> + * 61000000 - 61FFFFFF      PCI Configuration. 16M
> + *
> + * There are three V3 windows, each described by a pair of V3 registers.
> + * These are LB_BASE0/LB_MAP0, LB_BASE1/LB_MAP1 and LB_BASE2/LB_MAP2.
> + * Base0 and Base1 can be used for any type of PCI memory access.   Base2
> + * can be used either for PCI I/O or for I20 accesses.  By default, uHAL
> + * uses this only for PCI IO space.
> + *
> + * Normally these spaces are mapped using the following base registers:
> + *
> + * Usage Local Bus Memory         Base/Map registers used
> + *
> + * Mem   40000000 - 4FFFFFFF      LB_BASE0/LB_MAP0
> + * Mem   50000000 - 5FFFFFFF      LB_BASE1/LB_MAP1
> + * IO    60000000 - 60FFFFFF      LB_BASE2/LB_MAP2
> + * Cfg   61000000 - 61FFFFFF
> + *
> + * This means that I20 and PCI configuration space accesses will fail.
> + * When PCI configuration accesses are needed (via the uHAL PCI
> + * configuration space primitives) we must remap the spaces as follows:
> + *
> + * Usage Local Bus Memory         Base/Map registers used
> + *
> + * Mem   40000000 - 4FFFFFFF      LB_BASE0/LB_MAP0
> + * Mem   50000000 - 5FFFFFFF      LB_BASE0/LB_MAP0
> + * IO    60000000 - 60FFFFFF      LB_BASE2/LB_MAP2
> + * Cfg   61000000 - 61FFFFFF      LB_BASE1/LB_MAP1
> + *
> + * To make this work, the code depends on overlapping windows working.
> + * The V3 chip translates an address by checking its range within
> + * each of the BASE/MAP pairs in turn (in ascending register number
> + * order).  It will use the first matching pair.   So, for example,
> + * if the same address is mapped by both LB_BASE0/LB_MAP0 and
> + * LB_BASE1/LB_MAP1, the V3 will use the translation from
> + * LB_BASE0/LB_MAP0.
> + *
> + * To allow PCI Configuration space access, the code enlarges the
> + * window mapped by LB_BASE0/LB_MAP0 from 256M to 512M.  This occludes
> + * the windows currently mapped by LB_BASE1/LB_MAP1 so that it can
> + * be remapped for use by configuration cycles.
> + *
> + * At the end of the PCI Configuration space accesses,
> + * LB_BASE1/LB_MAP1 is reset to map PCI Memory.  Finally the window
> + * mapped by LB_BASE0/LB_MAP0 is reduced in size from 512M to 256M to
> + * reveal the now restored LB_BASE1/LB_MAP1 window.

Let me see if I understand this correctly.  Normally, BASE0 maps 256M
of non-prefetchable memory and BASE1 maps 256M of prefetchable memory.

When we do a config access, we temporarily expand BASE0 so it maps
512M all as non-prefetchable.  So accesses to the usual BASE1 region
still work, but they're non-prefetchable instead of prefetchable like
they would normally be.  And we use BASE1 to map config space.

This depends on the non-prefetchable and prefetchable windows being
adjacent and of the size we expect, right?  It looks like we get those
windows from DT, so we depend on them being correct there.

> + *
> + * NOTE: We do not set up I2O mapping.  I suspect that this is only
> + * for an intelligent (target) device.  Using I2O disables most of
> + * the mappings into PCI memory.
> + */
> +static void __iomem *v3_map_bus(struct pci_bus *bus,
> +				unsigned int devfn, int offset)
> +{
> +	struct v3_pci *v3 = bus->sysdata;
> +	unsigned int address, mapaddress, busnr;
> +
> +	busnr = bus->number;
> +	if (busnr == 0) {
> +		int slot = PCI_SLOT(devfn);
> +
> +		/*
> +		 * local bus segment so need a type 0 config cycle
> +		 *
> +		 * build the PCI configuration "address" with one-hot in
> +		 * A31-A11
> +		 *
> +		 * mapaddress:
> +		 *  3:1 = config cycle (101)
> +		 *  0   = PCI A1 & A0 are 0 (0)
> +		 */
> +		address = PCI_FUNC(devfn) << 8;
> +		mapaddress = V3_LB_MAP_TYPE_CONFIG;
> +
> +		if (slot > 12)
> +			/*
> +			 * high order bits are handled by the MAP register
> +			 */
> +			mapaddress |= BIT(slot - 5);
> +		else
> +			/*
> +			 * low order bits handled directly in the address
> +			 */
> +			address |= BIT(slot + 11);
> +	} else {
> +		/*
> +		 * not the local bus segment so need a type 1 config cycle
> +		 *
> +		 * address:
> +		 *  23:16 = bus number
> +		 *  15:11 = slot number (7:3 of devfn)
> +		 *  10:8  = func number (2:0 of devfn)
> +		 *
> +		 * mapaddress:
> +		 *  3:1 = config cycle (101)
> +		 *  0   = PCI A1 & A0 from host bus (1)
> +		 */
> +		mapaddress = V3_LB_MAP_TYPE_CONFIG | V3_LB_MAP_AD_LOW_EN;
> +		address = (busnr << 16) | (devfn << 8);
> +	}
> +
> +	/*
> +	 * Set up base0 to see all 512Mbytes of memory space (not
> +	 * prefetchable), this frees up base1 for re-use by
> +	 * configuration memory
> +	 */
> +	writel(v3_addr_to_lb_base(v3->non_pre_mem) |
> +	       V3_LB_BASE_ADR_SIZE_512MB | V3_LB_BASE_ENABLE,
> +	       v3->base + V3_LB_BASE0);
> +
> +	/*
> +	 * Set up base1/map1 to point into configuration space.
> +	 */
> +	writel(v3_addr_to_lb_base(v3->config_mem) |
> +	       V3_LB_BASE_ADR_SIZE_16MB | V3_LB_BASE_ENABLE,
> +	       v3->base + V3_LB_BASE1);
> +	writew(mapaddress, v3->base + V3_LB_MAP1);
> +
> +	return v3->config_base + address + offset;
> +}
> +
> +static void v3_unmap_bus(struct v3_pci *v3)
> +{
> +	/*
> +	 * Reassign base1 for use by prefetchable PCI memory
> +	 */
> +	writel(v3_addr_to_lb_base(v3->pre_mem) |
> +	       V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_PREFETCH |
> +	       V3_LB_BASE_ENABLE,
> +	       v3->base + V3_LB_BASE1);
> +	writew(v3_addr_to_lb_map(v3->pre_bus_addr) |
> +	       V3_LB_MAP_TYPE_MEM_MULTIPLE,
> +	       v3->base + V3_LB_MAP1);
> +
> +	/*
> +	 * And shrink base0 back to a 256M window (NOTE: MAP0 already correct)
> +	 */
> +	writel(v3_addr_to_lb_base(v3->non_pre_mem) |
> +	       V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_ENABLE,
> +	       v3->base + V3_LB_BASE0);
> +}
> +
> +
> +static int v3_pci_read_config(struct pci_bus *bus, unsigned int fn,
> +			      int config, int size, u32 *value)
> +{
> +	struct v3_pci *v3 = bus->sysdata;
> +	int ret;
> +
> +	dev_dbg(&bus->dev,
> +		"[read]  slt: %.2d, fnc: %d, cnf: 0x%.2X, val (%d bytes): 0x%.8X\n",
> +		PCI_SLOT(fn), PCI_FUNC(fn), config, size, *value);
> +	ret = pci_generic_config_read(bus, fn, config, size, value);
> +	v3_unmap_bus(v3);
> +	return ret;
> +}
> +
> +static int v3_pci_write_config(struct pci_bus *bus, unsigned int fn,
> +				    int config, int size, u32 value)
> +{
> +	struct v3_pci *v3 = bus->sysdata;
> +	int ret;
> +
> +	dev_dbg(&bus->dev,
> +		"[write] slt: %.2d, fnc: %d, cnf: 0x%.2X, val (%d bytes): 0x%.8X\n",
> +		PCI_SLOT(fn), PCI_FUNC(fn), config, size, value);
> +	ret = pci_generic_config_write(bus, fn, config, size, value);
> +	v3_unmap_bus(v3);
> +	return ret;
> +}
> +
> +static struct pci_ops v3_pci_ops = {
> +	.map_bus = v3_map_bus,
> +	.read = v3_pci_read_config,
> +	.write = v3_pci_write_config,
> +};
> +
> +static irqreturn_t v3_irq(int irq, void *data)
> +{
> +	struct v3_pci *v3 = data;

struct device *dev = v3->dev;

> +	u32 status;
> +
> +	status = readw(v3->base + V3_PCI_STAT);
> +	if (status & V3_PCI_STAT_PAR_ERR)
> +		dev_err(v3->dev, "parity error interrupt\n");

dev_err(dev, ...)

> +	if (status & V3_PCI_STAT_SYS_ERR)
> +		dev_err(v3->dev, "system error interrupt\n");
> +	if (status & V3_PCI_STAT_M_ABORT_ERR)
> +		dev_err(v3->dev, "master abort error interrupt\n");
> +	if (status & V3_PCI_STAT_T_ABORT_ERR)
> +		dev_err(v3->dev, "target abort error interrupt\n");
> +	writew(status, v3->base + V3_PCI_STAT);
> +
> +	status = readb(v3->base + V3_LB_ISTAT);
> +	if (status & V3_LB_ISTAT_MAILBOX)
> +		dev_info(v3->dev, "PCI mailbox interrupt\n");
> +	if (status & V3_LB_ISTAT_PCI_RD)
> +		dev_err(v3->dev, "PCI target LB->PCI READ abort interrupt\n");
> +	if (status & V3_LB_ISTAT_PCI_WR)
> +		dev_err(v3->dev, "PCI target LB->PCI WRITE abort interrupt\n");
> +	if (status &  V3_LB_ISTAT_PCI_INT)
> +		dev_info(v3->dev, "PCI pin interrupt\n");
> +	if (status & V3_LB_ISTAT_PCI_PERR)
> +		dev_err(v3->dev, "PCI parity error interrupt\n");
> +	if (status & V3_LB_ISTAT_I2O_QWR)
> +		dev_info(v3->dev, "I2O inbound post queue interrupt\n");
> +	if (status & V3_LB_ISTAT_DMA1)
> +		dev_info(v3->dev, "DMA channel 1 interrupt\n");
> +	if (status & V3_LB_ISTAT_DMA0)
> +		dev_info(v3->dev, "DMA channel 0 interrupt\n");
> +	/* Clear all possible interrupts on the local bus */
> +	writeb(0, v3->base + V3_LB_ISTAT);
> +	if (v3->map)
> +		regmap_write(v3->map, INTEGRATOR_SC_PCIENABLE_OFFSET, 3);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int v3_integrator_init(struct v3_pci *v3)
> +{
> +	v3->map =
> +		syscon_regmap_lookup_by_compatible("arm,integrator-ap-syscon");
> +	if (IS_ERR(v3->map)) {
> +		dev_err(v3->dev, "no syscon\n");
> +		return -ENODEV;
> +	}
> +	regmap_write(v3->map, INTEGRATOR_SC_PCIENABLE_OFFSET, 3);
> +	dev_info(v3->dev, "initialized PCI V3 Integrator/AP integration\n");
> +
> +	return 0;
> +}
> +
> +static int v3_pci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct resource *regs;
> +	resource_size_t io_base;
> +	struct resource_entry *win;
> +	struct v3_pci *v3;
> +	struct resource *config;
> +	struct resource *mem;
> +	struct resource *io;
> +	struct pci_host_bridge *host;
> +	struct clk *clk;
> +	unsigned int pci_cmd;
> +	u16 temp;
> +	int irq;
> +	int ret;
> +	LIST_HEAD(res);
> +
> +	host = pci_alloc_host_bridge(sizeof(*v3));
> +	if (!host)
> +		return -ENOMEM;
> +
> +	host->dev.parent = dev;
> +	host->ops = &v3_pci_ops;
> +	host->busnr = 0;
> +	host->msi = NULL;
> +	host->map_irq = of_irq_parse_and_map_pci;
> +	host->swizzle_irq = pci_common_swizzle;
> +	v3 = pci_host_bridge_priv(host);
> +	host->sysdata = v3;
> +	v3->dev = dev;
> +
> +	/* Get and enable host clock */
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "clock not found\n");

dev_err(dev, ...) (and others below).

> +		return PTR_ERR(clk);
> +	}
> +	ret = clk_prepare_enable(clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to enable clock\n");
> +		return ret;
> +	}
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	v3->base = devm_ioremap_resource(dev, regs);
> +	if (IS_ERR(v3->base))
> +		return PTR_ERR(v3->base);
> +
> +	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &io_base);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_pci_bus_resources(dev, &res);
> +	if (ret)
> +		return ret;
> +
> +	/* Get and request error IRQ resource */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0) {
> +		dev_err(&pdev->dev, "unable to obtain PCIv3 error IRQ\n");
> +		return -ENODEV;
> +	}
> +	ret = devm_request_irq(&pdev->dev, irq, v3_irq, 0,
> +			"PCIv3 error", v3);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"unable to request PCIv3 error IRQ %d (%d)\n",
> +			irq, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Unlock V3 registers, but only if they were previously locked.
> +	 */
> +	if (readw(v3->base + V3_SYSTEM) & V3_SYSTEM_M_LOCK)
> +		writew(V3_SYSTEM_UNLOCK, v3->base + V3_SYSTEM);
> +
> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry(win, &res) {
> +		switch (resource_type(win->res)) {
> +		case 0:
> +			/*
> +			 * The device trees use resource 0x0 for the config
> +			 * space range
> +			 */
> +			config = win->res;
> +			config->name = "V3 Config Space";
> +			v3->config_mem = config->start;
> +			dev_info(dev,
> +				 "CONFIG SPACE window start %08x, size %08x "
> +				 "(offset = %08x, bus addr = %08x)\n",
> +				 v3->config_mem, resource_size(config),
> +				 win->offset, config->start - win->offset);
> +			if (!devm_request_mem_region(dev, config->start,
> +						     resource_size(config),
> +						     "V3 Config Space"))
> +				dev_err(dev, "can't request config region\n");
> +			v3->config_base = devm_ioremap(dev, config->start,
> +						       resource_size(config));
> +			if (!v3->config_base)
> +				dev_err(dev, "failed to remap config space\n");
> +			break;
> +		case IORESOURCE_IO:
> +			io = win->res;
> +			io->name = "V3 PCI I/O";
> +			v3->io_mem = io->start;
> +			v3->io_bus_addr = io->start - win->offset;
> +			dev_info(dev,
> +				 "I/O window start %08x, bus addr %08x, size %08x\n",
> +				 v3->io_mem, v3->io_bus_addr,
> +				 resource_size(io));
> +			ret = pci_remap_iospace(io, io_base);
> +			if (ret) {
> +				dev_warn(dev,
> +					 "error %d: failed to map resource %pR\n",
> +					 ret, io);
> +				continue;
> +			}
> +			/*
> +			 * Setup window 2 - PCI IO
> +			 */
> +			writel(v3_addr_to_lb_base2(v3->io_mem) | V3_LB_BASE_ENABLE,
> +			       v3->base + V3_LB_BASE2);
> +			writew(v3_addr_to_lb_map2(v3->io_bus_addr),
> +			       v3->base + V3_LB_MAP2);
> +			break;
> +		case IORESOURCE_MEM:
> +			mem = win->res;
> +			if (mem->flags & IORESOURCE_PREFETCH) {
> +				mem->name = "V3 PCI PRE-MEM";
> +				v3->pre_mem = mem->start;
> +				v3->pre_bus_addr = mem->start - win->offset;
> +				dev_info(dev, "PREFETCHABLE MEM window start %08x, bus addr %08x, size %08x\n",
> +					 v3->pre_mem, v3->pre_bus_addr,
> +					 resource_size(mem));
> +				/*
> +				 * Setup window 1 - PCI prefetchable memory
> +				 * Local: 0x50000000 Bus: 0x10000000 Size: 256MB
> +				 * FIXME: get size from resource_size()
> +				 */
> +				writel(v3_addr_to_lb_base(v3->pre_mem) |
> +				       V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_PREFETCH |
> +				       V3_LB_BASE_ENABLE,
> +				       v3->base + V3_LB_BASE1);
> +				writew(v3_addr_to_lb_map(v3->pre_bus_addr) |
> +				       V3_LB_MAP_TYPE_MEM_MULTIPLE,
> +				       v3->base + V3_LB_MAP1);
> +			} else {
> +				mem->name = "V3 PCI NON-PRE-MEM";
> +				v3->non_pre_mem = mem->start;
> +				v3->non_pre_bus_addr = mem->start - win->offset;
> +				dev_info(dev,
> +					 "NON-PREFETCHABLE MEM window start %08x, bus addr %08x, size %08x\n",
> +					 v3->non_pre_mem, v3->non_pre_bus_addr,
> +					 resource_size(mem));
> +				/*
> +				 * Setup window 0 - PCI non-prefetchable memory
> +				 * Local: 0x40000000 Bus: 0x00000000 Size: 256MB
> +				 * FIXME: get size from resource_size()
> +				 */
> +				writel(v3_addr_to_lb_base(v3->non_pre_mem) |
> +				       V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_ENABLE,
> +				       v3->base + V3_LB_BASE0);
> +				writew(v3_addr_to_lb_map(v3->non_pre_bus_addr) |
> +				       V3_LB_MAP_TYPE_MEM,
> +				       v3->base + V3_LB_MAP0);
> +
> +			}
> +			break;
> +		case IORESOURCE_BUS:
> +			dev_info(dev, "BUS %d\n", win->res->start);

Can we use this item, i.e., to set host->busnr, instead of printing it
and ignoring it?

> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * Disable PCI to host IO cycles
> +	 */
> +	temp = readw(v3->base + V3_PCI_CFG) & ~V3_PCI_CFG_M_I2O_EN;
> +	temp |= V3_PCI_CFG_M_IO_REG_DIS | V3_PCI_CFG_M_IO_DIS;
> +	writew(temp, v3->base + V3_PCI_CFG);
> +
> +	/*
> +	 * Set the V3 FIFO such that writes have higher priority than
> +	 * reads, and local bus write causes local bus read fifo flush
> +	 * on aperture 1. Same for PCI.
> +	 */
> +	writew(V3_FIFO_PRIO_LB_RD1_FLUSH_AP1 |
> +	       V3_FIFO_PRIO_LB_RD0_FLUSH_AP1 |
> +	       V3_FIFO_PRIO_PCI_RD1_FLUSH_AP1 |
> +	       V3_FIFO_PRIO_PCI_RD0_FLUSH_AP1,
> +	       v3->base + V3_FIFO_PRIORITY);
> +
> +	/*
> +	 * Re-lock the system register.
> +	 */
> +	temp = readw(v3->base + V3_SYSTEM) | V3_SYSTEM_M_LOCK;
> +	writew(temp, v3->base + V3_SYSTEM);
> +
> +	/*
> +	 * Clear any error conditions, and enable write errors.
> +	 */
> +	writeb(0, v3->base + V3_LB_ISTAT);
> +	writew(readw(v3->base + V3_LB_CFG) | V3_LB_CFG_LB_LB_INT,
> +	       v3->base + V3_LB_CFG);
> +	writeb(V3_LB_ISTAT_PCI_WR | V3_LB_ISTAT_PCI_PERR,
> +	       v3->base + V3_LB_IMASK);
> +
> +	/* Special Integrator initialization */
> +	if (of_device_is_compatible(np, "arm,integrator-ap-pci")) {
> +		ret = v3_integrator_init(v3);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Post-init */
> +	pci_cmd = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> +		PCI_COMMAND_INVALIDATE;
> +	writew(pci_cmd, v3->base + V3_PCI_CMD);
> +	writeb(0, v3->base + V3_LB_ISTAT);
> +	/* Read or write errors and parity errors cause interrupts */
> +	writeb(V3_LB_ISTAT_PCI_RD | V3_LB_ISTAT_PCI_WR | V3_LB_ISTAT_PCI_PERR,
> +	       v3->base + V3_LB_IMASK);
> +
> +	list_splice_init(&res, &host->windows);
> +	ret = pci_scan_root_bus_bridge(host);
> +	if (ret) {
> +		dev_err(dev, "failed to register host: %d\n", ret);
> +		return ret;
> +	}
> +	v3->bus = host->bus;
> +
> +	pci_bus_assign_resources(v3->bus);
> +	pci_bus_add_devices(v3->bus);
> +	pci_free_resource_list(&res);

I think pci_free_resource_list() should be called only if an error
occurs, shouldn't it?

> +	return 0;
> +}
> +
> +static const struct of_device_id v3_pci_of_match[] = {
> +	{
> +		.compatible = "v3,v360epc-pci",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver v3_pci_driver = {
> +	.driver = {
> +		.name = "pci-v3-semi",
> +		.of_match_table = of_match_ptr(v3_pci_of_match),
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe  = v3_pci_probe,
> +};
> +builtin_platform_driver(v3_pci_driver);
> -- 
> 2.9.4
> 
