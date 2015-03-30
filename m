Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35381 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbbC3Mlj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 08:41:39 -0400
Received: by oiag65 with SMTP id g65so127084591oia.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2015 05:41:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55080368.1070207@ti.com>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
	<1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
	<55080368.1070207@ti.com>
Date: Mon, 30 Mar 2015 14:41:38 +0200
Message-ID: <CAG374jBhuj=ooHcWvSG9yPJUa7eXxdhZJ3u4DRXinZdeXFf4dA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] PCI: st: Provide support for the sti PCIe controller
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Muralidharan Karicheri <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kernel@stlinux.com" <kernel@stlinux.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

I tested with my internal 3.10 ST Kernel but not on the 4.0.
I think i'll implement it when i'm able to test it fully.
Thanks

On 17 March 2015 at 11:35, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
>
> On Monday 16 March 2015 07:50 PM, Gabriel FERNANDEZ wrote:
>>
>> sti pcie is built around a Synopsis Designware PCIe IP.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> ---
>>   drivers/pci/host/Kconfig  |   9 +
>>   drivers/pci/host/Makefile |   1 +
>>   drivers/pci/host/pci-st.c | 617
>> ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 627 insertions(+)
>>   create mode 100644 drivers/pci/host/pci-st.c
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 7b892a9..af9f9212 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -106,4 +106,13 @@ config PCI_VERSATILE
>>         bool "ARM Versatile PB PCI controller"
>>         depends on ARCH_VERSATILE
>>
>> +config PCI_ST
>> +       bool "ST PCIe controller"
>> +       depends on ARCH_STI || (ARM && COMPILE_TEST)
>> +       select PCIE_DW
>> +       help
>> +         Enable PCIe controller support on ST Socs. This controller is
>> based
>> +         on Designware hardware and therefore the driver re-uses the
>> +         Designware core functions to implement the driver.
>> +
>>   endmenu
>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>> index e61d91c..97c6622 100644
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> @@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>>   obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>>   obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>>   obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>> +obj-$(CONFIG_PCI_ST) += pci-st.o
>> diff --git a/drivers/pci/host/pci-st.c b/drivers/pci/host/pci-st.c
>> new file mode 100644
>> index 0000000..470000d
>> --- /dev/null
>> +++ b/drivers/pci/host/pci-st.c
>> @@ -0,0 +1,617 @@
>> +/*
>> + * Copyright (C) 2014 STMicroelectronics
>> + *
>> + * STMicroelectronics PCI express Driver for sti SoCs.
>> + * ST PCIe IPs are built around a Synopsys IP Core.
>> + *
>> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +
>> +#include "pcie-designware.h"
>> +
>> +#define TRANSLATION_CONTROL            0x900
>> +/* Controls if area is inclusive or exclusive */
>> +#define RC_PASS_ADDR_RANGE             BIT(1)
>> +
>> +/* Base of area reserved for config accesses. Fixed size of 64K. */
>> +#define CFG_BASE_ADDRESS               0x92c
>> +#define CFG_REGION_SIZE                        65536
>> +#define CFG_SPACE1_OFFSET              0x1000
>> +
>> +/* First 4K of config space has this BDF (bus,device,function) */
>> +#define FUNC0_BDF_NUM                  0x930
>> +
>> +/* Mem regions */
>> +#define IN0_MEM_ADDR_START             0x964
>> +#define IN0_MEM_ADDR_LIMIT             0x968
>> +#define IN1_MEM_ADDR_START             0x974
>> +#define IN1_MEM_ADDR_LIMIT             0x978
>> +
>> +/* This actually contains the LTSSM state machine state */
>> +#define PORT_LOGIC_DEBUG_REG_0         0x728
>> +
>> +/* LTSSM state machine values  */
>> +#define DEBUG_REG_0_LTSSM_MASK         0x1f
>> +#define S_DETECT_QUIET                 0x00
>> +#define S_DETECT_ACT                   0x01
>> +#define S_POLL_ACTIVE                  0x02
>> +#define S_POLL_COMPLIANCE              0x03
>> +#define S_POLL_CONFIG                  0x04
>> +#define S_PRE_DETECT_QUIET             0x05
>> +#define S_DETECT_WAIT                  0x06
>> +#define S_CFG_LINKWD_START             0x07
>> +#define S_CFG_LINKWD_ACEPT             0x08
>> +#define S_CFG_LANENUM_WAIT             0x09
>> +#define S_CFG_LANENUM_ACEPT            0x0A
>> +#define S_CFG_COMPLETE                 0x0B
>> +#define S_CFG_IDLE                     0x0C
>> +#define S_RCVRY_LOCK                   0x0D
>> +#define S_RCVRY_SPEED                  0x0E
>> +#define S_RCVRY_RCVRCFG                        0x0F
>> +#define S_RCVRY_IDLE                   0x10
>> +#define S_L0                           0x11
>> +#define S_L0S                          0x12
>> +#define S_L123_SEND_EIDLE              0x13
>> +#define S_L1_IDLE                      0x14
>> +#define S_L2_IDLE                      0x15
>> +#define S_L2_WAKE                      0x16
>> +#define S_DISABLED_ENTRY               0x17
>> +#define S_DISABLED_IDLE                        0x18
>> +#define S_DISABLED                     0x19
>> +#define S_LPBK_ENTRY                   0x1A
>> +#define S_LPBK_ACTIVE                  0x1B
>> +#define S_LPBK_EXIT                    0x1C
>> +#define S_LPBK_EXIT_TIMEOUT            0x1D
>> +#define S_HOT_RESET_ENTRY              0x1E
>> +#define S_HOT_RESET                    0x1F
>> +
>> +/* syscfg bits */
>> +#define PCIE_SYS_INT                   BIT(5)
>> +#define PCIE_APP_REQ_RETRY_EN          BIT(3)
>> +#define PCIE_APP_LTSSM_ENABLE          BIT(2)
>> +#define PCIE_APP_INIT_RST              BIT(1)
>> +#define PCIE_DEVICE_TYPE               BIT(0)
>> +#define PCIE_DEFAULT_VAL               PCIE_DEVICE_TYPE
>> +
>> +/* Time to wait between testing the link in msecs (hardware poll
>> interval) */
>> +#define LINK_LOOP_DELAY_MS 1
>> +/* Total amount of time to wait for the link to come up in msecs */
>> +#define LINK_WAIT_MS 120
>> +#define LINK_LOOP_COUNT (LINK_WAIT_MS / LINK_LOOP_DELAY_MS)
>> +
>> +/* st,syscfg offsets */
>> +#define SYSCFG0_REG    1
>> +#define SYSCFG1_REG    2
>> +
>> +#define to_st_pcie(x)  container_of(x, struct st_pcie, pp)
>> +
>> +/**
>> + * struct st_pcie - private data of the controller
>> + * @pp: designware pcie port
>> + * @syscfg0: PCIe configuration 0 register, regmap offset
>> + * @syscfg1: PCIe configuration 1 register, regmap offset
>> + * @phy: associated pcie phy
>> + * @lmi: memory made available to the controller
>> + * @regmap: Syscfg registers bank in which PCIe port is configured
>> + * @pwr: power control
>> + * @rst: reset control
>> + * @reset_gpio: optional reset gpio
>> + * @config_window_start: start address of 64K config space area
>> + */
>> +struct st_pcie {
>> +       struct pcie_port pp;
>> +       int syscfg0;
>> +       int syscfg1;
>> +       struct phy *phy;
>> +       struct resource *lmi;
>> +       struct regmap *regmap;
>> +       struct reset_control *pwr;
>> +       struct reset_control *rst;
>> +       int reset_gpio;
>> +       phys_addr_t config_window_start;
>> +};
>> +
>> +/*
>> + * Function to test if the link is in an operational state or not. We
>> must
>> + * ensure the link is operational before we try to do a configuration
>> access.
>> + */
>> +static int st_pcie_link_up(struct pcie_port *pp)
>> +{
>> +       u32 status;
>> +       int link_up;
>> +       int count = 0;
>> +
>> +       /*
>> +        * We have to be careful here. This is used in config read/write,
>> +        * The higher levels switch off interrupts, so you cannot use
>> +        * jiffies to do a timeout, or reschedule
>> +        */
>> +       do {
>> +               /*
>> +                * What about L2? I think software intervention is
>> +                * required to get it out of L2, so in effect the link
>> +                * is down. Requires more work when/if we implement power
>> +                * management
>> +                */
>> +               status = readl_relaxed(pp->dbi_base +
>> PORT_LOGIC_DEBUG_REG_0);
>> +               status &= DEBUG_REG_0_LTSSM_MASK;
>> +
>> +               link_up = (status == S_L0) || (status == S_L0S) ||
>> +                         (status == S_L1_IDLE);
>> +
>> +               /*
>> +                * It can take some considerable time for the link to
>> actually
>> +                * come up, caused by the PLLs. Experiments indicate it
>> takes
>> +                * about 8ms to actually bring the link up, but this can
>> vary
>> +                * considerably according to the specification. This code
>> should
>> +                * allow sufficient time
>> +                */
>> +               if (!link_up)
>> +                       mdelay(LINK_LOOP_DELAY_MS);
>> +
>> +       } while (!link_up && ++count < LINK_LOOP_COUNT);
>> +
>> +       return link_up;
>> +}
>> +
>> +/*
>> + * On ARM platforms, we actually get a bus error returned when the PCIe
>> IP
>> + * returns a UR or CRS instead of an OK.
>> + */
>> +static int st_pcie_abort_handler(unsigned long addr, unsigned int fsr,
>> +                                struct pt_regs *regs)
>> +{
>> +       return 0;
>> +}
>> +
>> +/*
>> + * The PCI express core IP expects the following arrangement on it's
>> address
>> + * bus (slv_haddr) when driving config cycles.
>> + * bus_number          [31:24]
>> + * dev_number          [23:19]
>> + * func_number         [18:16]
>> + * unused              [15:12]
>> + * ext_reg_number      [11:8]
>> + * reg_number          [7:2]
>> + *
>> + * Bits [15:12] are unused.
>> + *
>> + * In the glue logic there is a 64K region of address space that can be
>> + * written/read to generate config cycles. The base address of this is
>> + * controlled by CFG_BASE_ADDRESS. There are 8 16 bit registers called
>> + * FUNC0_BDF_NUM to FUNC8_BDF_NUM. These split the bottom half of the 64K
>> + * window into 8 regions at 4K boundaries. These control the bus,device
>> and
>> + * function number you are trying to talk to.
>> + *
>> + * The decision on whether to generate a type 0 or type 1 access is
>> controlled
>> + * by bits 15:12 of the address you write to.  If they are zero, then a
>> type 0
>> + * is generated, if anything else it will be a type 1. Thus the bottom 4K
>> + * region controlled by FUNC0_BDF_NUM can only generate type 0, all the
>> others
>> + * can only generate type 1.
>> + *
>> + * We only use FUNC0_BDF_NUM and FUNC1_BDF_NUM. Which one you use is
>> selected
>> + * by bit 12 of the address you write to. The selected register is then
>> used
>> + * for the top 16 bits of the slv_haddr to form the bus/dev/func, bit
>> 15:12 are
>> + * wired to zero, and bits 11:2 form the address of the register you want
>> to
>> + * read in config space.
>> + *
>> + * We always write FUNC0_BDF_NUM as a 32 bit write. So if we want type 1
>> + * accesses we have to shift by 16 so in effect we are writing to
>> FUNC1_BDF_NUM
>> + */
>> +static inline u32 bdf_num(int bus, int devfn, int is_root_bus)
>> +{
>> +       return ((bus << 8) | devfn) << (is_root_bus ? 0 : 16);
>> +}
>> +
>> +static int st_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus
>> *bus,
>> +                                unsigned int devfn, int where, int size,
>> +                                u32 *val)
>> +{
>> +       int ret;
>> +       u32 bdf, addr;
>> +
>> +       addr = where & ~0x3;
>> +       bdf = bdf_num(bus->number, devfn, pci_is_root_bus(bus));
>> +
>> +       /* Set the config packet devfn */
>> +       writel_relaxed(bdf, pp->dbi_base + FUNC0_BDF_NUM);
>> +       readl_relaxed(pp->dbi_base + FUNC0_BDF_NUM);
>> +
>> +       if (bus->parent->number == pp->root_bus_nr)
>> +               ret = dw_pcie_cfg_read(pp->va_cfg0_base + addr, where,
>> size,
>> +                                      val);
>> +       else
>> +               ret = dw_pcie_cfg_read(pp->va_cfg1_base + addr, where,
>> size,
>> +                                      val);
>> +       return ret;
>> +}
>> +
>> +static int st_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus
>> *bus,
>> +                                unsigned int devfn, int where, int size,
>> +                                u32 val)
>> +{
>> +       int ret;
>> +       u32 bdf, addr;
>> +
>> +       addr = where & ~0x3;
>> +       bdf = bdf_num(bus->number, devfn, pci_is_root_bus(bus));
>> +
>> +       /* Set the config packet devfn */
>> +       writel_relaxed(bdf, pp->dbi_base + FUNC0_BDF_NUM);
>> +       readl_relaxed(pp->dbi_base + FUNC0_BDF_NUM);
>> +
>> +       if (bus->parent->number == pp->root_bus_nr)
>> +               ret = dw_pcie_cfg_write(pp->va_cfg0_base + addr, where,
>> size,
>> +                                       val);
>> +       else
>> +               ret = dw_pcie_cfg_write(pp->va_cfg1_base + addr, where,
>> size,
>> +                                       val);
>> +       return ret;
>> +}
>> +
>> +static void st_pcie_board_reset(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +
>> +       if (!gpio_is_valid(pcie->reset_gpio))
>> +               return;
>> +
>> +       if (gpio_direction_output(pcie->reset_gpio, 0)) {
>> +               dev_err(pp->dev, "Cannot set PERST# (gpio %u) to
>> output\n",
>> +                       pcie->reset_gpio);
>> +               return;
>> +       }
>> +
>> +       /* From PCIe spec */
>> +       msleep(2);
>> +       gpio_direction_output(pcie->reset_gpio, 1);
>> +
>> +       /*
>> +        * PCIe specification states that you should not issue any config
>> +        * requests until 100ms after asserting reset, so we enforce that
>> here
>> +        */
>> +       msleep(100);
>> +}
>> +
>> +static void st_pcie_hw_setup(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +
>> +       dw_pcie_setup_rc(pp);
>> +
>> +       /* Set up the config window to the top of the PCI address space */
>> +       writel_relaxed(pcie->config_window_start,
>> +                      pp->dbi_base + CFG_BASE_ADDRESS);
>> +
>> +       /*
>> +        * Open up memory to the PCI controller. We could do slightly
>> +        * better than this and exclude the kernel text segment and bss
>> etc.
>> +        * They are base/limit registers so can be of arbitrary alignment
>> +        * presumably
>> +        */
>> +       writel_relaxed(pcie->lmi->start, pp->dbi_base +
>> IN0_MEM_ADDR_START);
>> +       writel_relaxed(pcie->lmi->end, pp->dbi_base + IN0_MEM_ADDR_LIMIT);
>> +
>> +       /* Disable the 2nd region */
>> +       writel_relaxed(~0, pp->dbi_base + IN1_MEM_ADDR_START);
>> +       writel_relaxed(0, pp->dbi_base + IN1_MEM_ADDR_LIMIT);
>> +
>> +       writel_relaxed(RC_PASS_ADDR_RANGE, pp->dbi_base +
>> TRANSLATION_CONTROL);
>> +
>> +       /* Now assert the board level reset to the other PCIe device */
>> +       st_pcie_board_reset(pp);
>> +}
>> +
>> +static irqreturn_t st_pcie_msi_irq_handler(int irq, void *arg)
>> +{
>> +       struct pcie_port *pp = arg;
>> +
>> +       return dw_handle_msi_irq(pp);
>> +}
>> +
>> +static int st_pcie_init(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +       int ret;
>> +
>> +       ret = reset_control_deassert(pcie->pwr);
>> +       if (ret) {
>> +               dev_err(pp->dev, "unable to bring out of powerdown\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = reset_control_deassert(pcie->rst);
>> +       if (ret) {
>> +               dev_err(pp->dev, "unable to bring out of softreset\n");
>> +               return ret;
>> +       }
>> +
>> +       /* Set device type : Root Complex */
>> +       ret = regmap_write(pcie->regmap, pcie->syscfg0, PCIE_DEVICE_TYPE);
>> +       if (ret < 0) {
>> +               dev_err(pp->dev, "unable to set device type\n");
>> +               return ret;
>> +       }
>> +
>> +       usleep_range(1000, 2000);
>> +       return ret;
>> +}
>> +
>> +static int st_pcie_enable_ltssm(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +
>> +       return regmap_update_bits(pcie->regmap, pcie->syscfg1,
>> +                                 PCIE_APP_LTSSM_ENABLE,
>> PCIE_APP_LTSSM_ENABLE);
>> +}
>> +
>> +static int st_pcie_disable_ltssm(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +
>> +       return regmap_update_bits(pcie->regmap, pcie->syscfg1,
>> +                                 PCIE_APP_LTSSM_ENABLE, 0);
>> +}
>> +
>> +static void st_pcie_host_init(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +       int err;
>> +
>> +       /*
>> +        * We have to initialise the PCIe cell on some hardware before we
>> can
>> +        * talk to the phy
>> +        */
>> +       err = st_pcie_init(pp);
>> +       if (err)
>> +               return;
>> +
>> +       err = st_pcie_disable_ltssm(pp);
>> +       if (err) {
>> +               dev_err(pp->dev, "disable ltssm failed, %d\n", err);
>> +               return;
>> +       }
>> +
>> +       /* Now init the associated miphy */
>> +       err = phy_init(pcie->phy);
>> +       if (err < 0) {
>> +               dev_err(pp->dev, "Cannot init PHY: %d\n", err);
>> +               return;
>> +       }
>> +
>> +       /* Now do all the register poking */
>> +       st_pcie_hw_setup(pp);
>> +
>> +       /* Re-enable the link */
>> +       err = st_pcie_enable_ltssm(pp);
>> +       if (err)
>> +               dev_err(pp->dev, "enable ltssm failed, %d\n", err);
>> +
>> +       if (IS_ENABLED(CONFIG_PCI_MSI))
>> +               dw_pcie_msi_init(pp);
>> +}
>> +
>> +static struct pcie_host_ops st_pcie_host_ops = {
>> +       .rd_other_conf = st_pcie_rd_other_conf,
>> +       .wr_other_conf = st_pcie_wr_other_conf,
>> +       .link_up = st_pcie_link_up,
>> +       .host_init = st_pcie_host_init,
>> +};
>> +
>> +static const struct of_device_id st_pcie_of_match[] = {
>> +       { .compatible = "st,pcie", },
>> +       { },
>> +};
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int st_pcie_suspend(struct device *pcie_dev)
>> +{
>> +       struct st_pcie *pcie = dev_get_drvdata(pcie_dev);
>> +
>> +       /* To guarantee a real phy initialization on resume */
>> +       phy_exit(pcie->phy);
>> +
>> +       return 0;
>> +}
>> +
>> +static int st_pcie_resume(struct device *pcie_dev)
>> +{
>> +       struct st_pcie *pcie = dev_get_drvdata(pcie_dev);
>> +
>> +       st_pcie_host_init(&pcie->pp);
>> +
>> +       return 0;
>> +}
>
>
> Just curious to know if you tested suspend/resume with PCIe cards
> connected to the RC?
>
> Thanks
> Kishon
