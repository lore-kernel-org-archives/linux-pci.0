Return-Path: <SRS0=mU2/=DK=broadcom.com=james.quinlan@kernel.org>
Return-Path: <SRS0=mU2/=DK=broadcom.com=james.quinlan@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171212221642.GB95453@bhelgaas-glaptop.roam.corp.google.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-4-git-send-email-jim2101024@gmail.com> <20171212221642.GB95453@bhelgaas-glaptop.roam.corp.google.com>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 14 Dec 2017 15:30:42 -0500
Message-ID: <CA+-6iNwX+2pWK4kkbDfs=wX66UowyzY+R-gdEfFZ3AsEQywiug@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Brian Norris <computersforpeace@gmail.com>, Russell King <rmk+kernel@armlinux.org.uk>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Florian Fainelli <f.fainelli@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	linux-mips@linux-mips.org, linux-pci@vger.kernel.org,
	Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Content-Type: multipart/alternative; boundary="94eb2c1dffd8150aa8056052c206"
List-ID: <linux-pci.vger.kernel.org>

--94eb2c1dffd8150aa8056052c206
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 12, 2017 at 5:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Nov 14, 2017 at 05:12:07PM -0500, Jim Quinlan wrote:
> > This commit adds the basic Broadcom STB PCIe controller.  Missing is
> > the ability to process MSI and also handle dma-ranges for inbound
> > memory accesses.  These two functionalities are added in subsequent
> > commits.
> >
> > The PCIe block contains an MDIO interface.  This is a local interface
> > only accessible by the PCIe controller.  It cannot be used or shared
> > by any other HW.  As such, the small amount of code for this
> > controller is included in this driver as there is little upside to put
> > it elsewhere.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/host/Kconfig        |    9 +
> >  drivers/pci/host/Makefile       |    1 +
> >  drivers/pci/host/pcie-brcmstb.c | 1124 ++++++++++++++++++++++++++++++
> +++++++++
> >  3 files changed, 1134 insertions(+)
> >  create mode 100644 drivers/pci/host/pcie-brcmstb.c
> >
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index b868803..751463e 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -220,4 +220,13 @@ config VMD
> >         To compile this driver as a module, choose M here: the
> >         module will be called vmd.
> >
> > +config PCIE_BRCMSTB
> > +     tristate "Broadcom Brcmstb PCIe platform host driver"
> > +     depends on ARCH_BRCMSTB || BMIPS_GENERIC
> > +     depends on OF
> > +     depends on SOC_BRCMSTB
> > +     default ARCH_BRCMSTB || BMIPS_GENERIC
> > +     help
> > +       Adds support for Broadcom Settop Box PCIe host controller.
> > +
> >  endmenu
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > index 1238278..a8b9923 100644
> > --- a/drivers/pci/host/Makefile
> > +++ b/drivers/pci/host/Makefile
> > @@ -21,6 +21,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> >  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
> >  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> >  obj-$(CONFIG_VMD) += vmd.o
> > +obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/host/pcie-brcmstb.c b/drivers/pci/host/pcie-
> brcmstb.c
> > new file mode 100644
> > index 0000000..d8a8f7a
> > --- /dev/null
> > +++ b/drivers/pci/host/pcie-brcmstb.c
> > @@ -0,0 +1,1124 @@
> > +/*
> > + * Copyright (C) 2009 - 2017 Broadcom
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/compiler.h>
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/log2.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/pci.h>
> > +#include <linux/printk.h>
> > +#include <linux/sizes.h>
> > +#include <linux/slab.h>
> > +#include <soc/brcmstb/memory_api.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +
> > +/* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs
> */
> > +#define BRCM_PCIE_CAP_REGS                           0x00ac
>
> Add a blank line before multi-line comments.
>
> > +/*
> > + * Broadcom Settop Box PCIE Register Offsets. The names are from
> > + * the chip's RDB and we use them here so that a script can correlate
> > + * this code and the RDB to prevent discrepancies.
>
> Use "PCIe" capitalization in English text and messages.
>
> > + */
> > +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1              0x0188
> > +#define PCIE_RC_CFG_PRIV1_ID_VAL3                    0x043c
> > +#define PCIE_RC_DL_MDIO_ADDR                         0x1100
> > +#define PCIE_RC_DL_MDIO_WR_DATA                              0x1104
> > +#define PCIE_RC_DL_MDIO_RD_DATA                              0x1108
> > +#define PCIE_MISC_MISC_CTRL                          0x4008
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO             0x400c
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI             0x4010
> > +#define PCIE_MISC_RC_BAR1_CONFIG_LO                  0x402c
> > +#define PCIE_MISC_RC_BAR2_CONFIG_LO                  0x4034
> > +#define PCIE_MISC_RC_BAR2_CONFIG_HI                  0x4038
> > +#define PCIE_MISC_RC_BAR3_CONFIG_LO                  0x403c
> > +#define PCIE_MISC_PCIE_CTRL                          0x4064
> > +#define PCIE_MISC_PCIE_STATUS                                0x4068
> > +#define PCIE_MISC_REVISION                           0x406c
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT     0x4070
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI                0x4080
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI               0x4084
> > +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG                       0x4204
> > +#define PCIE_INTR2_CPU_BASE                          0x4300
> > +
> > +/*
> > + * Broadcom Settop Box PCIE Register Field shift and mask info. The
> > + * names are from the chip's RDB and we use them here so that a script
> > + * can correlate this code and the RDB to prevent discrepancies.
> > + */
> > +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK
>       0xc
> > +#define PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_SHIFT
>      0x2
> > +#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK            0xffffff
> > +#define PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_SHIFT           0x0
> > +#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK
>  0x1000
> > +#define PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_SHIFT
> 0xc
> > +#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK            0x2000
> > +#define PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_SHIFT           0xd
> > +#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK
> 0x300000
> > +#define PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_SHIFT             0x14
> > +#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK                   0xf8000000
> > +#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_SHIFT                  0x1b
> > +#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK                   0x7c00000
> > +#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_SHIFT                  0x16
> > +#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK                   0x1f
> > +#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_SHIFT                  0x0
> > +#define PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK
> 0x1f
> > +#define PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_SHIFT
>  0x0
> > +#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_MASK
> 0x1f
> > +#define PCIE_MISC_RC_BAR2_CONFIG_LO_SIZE_SHIFT
>  0x0
> > +#define PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_MASK
> 0x1f
> > +#define PCIE_MISC_RC_BAR3_CONFIG_LO_SIZE_SHIFT
>  0x0
> > +#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_MASK                 0x4
> > +#define PCIE_MISC_PCIE_CTRL_PCIE_PERSTB_SHIFT
> 0x2
> > +#define PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_MASK            0x1
> > +#define PCIE_MISC_PCIE_CTRL_PCIE_L23_REQUEST_SHIFT           0x0
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_PORT_MASK                 0x80
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_PORT_SHIFT
> 0x7
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK            0x20
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_SHIFT           0x5
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK            0x10
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_SHIFT           0x4
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_MASK          0x40
> > +#define PCIE_MISC_PCIE_STATUS_PCIE_LINK_IN_L23_SHIFT         0x6
> > +#define PCIE_MISC_REVISION_MAJMIN_MASK
>  0xffff
> > +#define PCIE_MISC_REVISION_MAJMIN_SHIFT                              0
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK  0xfff00000
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_SHIFT 0x14
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK   0xfff0
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_SHIFT  0x4
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS
>  0xc
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_MASK
> 0xff
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI_BASE_SHIFT     0x0
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_MASK    0xff
> > +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI_LIMIT_SHIFT   0x0
> > +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK
> 0x2
> > +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_SHIFT 0x1
> > +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK
> 0x08000000
> > +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_SHIFT     0x1b
> > +#define PCIE_RGR1_SW_INIT_1_PERST_MASK                               0x1
> > +#define PCIE_RGR1_SW_INIT_1_PERST_SHIFT
> 0x0
> > +
> > +#define BRCM_NUM_PCIE_OUT_WINS               0x4
> > +#define BRCM_MAX_SCB                 0x4
> > +
> > +#define BRCM_MSI_TARGET_ADDR_LT_4GB  0x0fffffffcULL
> > +#define BRCM_MSI_TARGET_ADDR_GT_4GB  0xffffffffcULL
> > +
> > +#define BURST_SIZE_128                       0
> > +#define BURST_SIZE_256                       1
> > +#define BURST_SIZE_512                       2
> > +
> > +/* Offsets from PCIE_INTR2_CPU_BASE */
> > +#define STATUS                               0x0
> > +#define SET                          0x4
> > +#define CLR                          0x8
> > +#define MASK_STATUS                  0xc
> > +#define MASK_SET                     0x10
> > +#define MASK_CLR                     0x14
> > +
> > +#define PCIE_BUSNUM_SHIFT            20
> > +#define PCIE_SLOT_SHIFT                      15
> > +#define PCIE_FUNC_SHIFT                      12
> > +
> > +#if defined(__BIG_ENDIAN)
> > +#define      DATA_ENDIAN             2       /* PCIe->DDR inbound
> accesses */
> > +#define MMIO_ENDIAN          2       /* CPU->PCIe outbound accesses */
> > +#else
> > +#define      DATA_ENDIAN             0
> > +#define MMIO_ENDIAN          0
> > +#endif
> > +
> > +#define MDIO_PORT0           0x0
> > +#define MDIO_DATA_MASK               0x7fffffff
> > +#define MDIO_DATA_SHIFT              0x0
> > +#define MDIO_PORT_MASK               0xf0000
> > +#define MDIO_PORT_SHIFT              0x16
> > +#define MDIO_REGAD_MASK              0xffff
> > +#define MDIO_REGAD_SHIFT     0x0
> > +#define MDIO_CMD_MASK                0xfff00000
> > +#define MDIO_CMD_SHIFT               0x14
> > +#define MDIO_CMD_READ                0x1
> > +#define MDIO_CMD_WRITE               0x0
> > +#define MDIO_DATA_DONE_MASK  0x80000000
> > +#define MDIO_RD_DONE(x)              (((x) & MDIO_DATA_DONE_MASK) ? 1 :
> 0)
> > +#define MDIO_WT_DONE(x)              (((x) & MDIO_DATA_DONE_MASK) ? 0 :
> 1)
> > +#define SSC_REGS_ADDR                0x1100
> > +#define SET_ADDR_OFFSET              0x1f
> > +#define SSC_CNTL_OFFSET              0x2
> > +#define SSC_CNTL_OVRD_EN_MASK        0x8000
> > +#define SSC_CNTL_OVRD_EN_SHIFT       0xf
> > +#define SSC_CNTL_OVRD_VAL_MASK       0x4000
> > +#define SSC_CNTL_OVRD_VAL_SHIFT      0xe
> > +#define SSC_STATUS_OFFSET    0x1
> > +#define SSC_STATUS_SSC_MASK  0x400
> > +#define SSC_STATUS_SSC_SHIFT 0xa
> > +#define SSC_STATUS_PLL_LOCK_MASK     0x800
> > +#define SSC_STATUS_PLL_LOCK_SHIFT    0xb
> > +
> > +#define IDX_ADDR(pcie)       \
> > +     ((pcie)->reg_offsets[EXT_CFG_INDEX])
> > +#define DATA_ADDR(pcie)      \
> > +     ((pcie)->reg_offsets[EXT_CFG_DATA])
> > +#define PCIE_RGR1_SW_INIT_1(pcie) \
> > +     ((pcie)->reg_offsets[RGR1_SW_INIT_1])
> > +
> > +enum {
> > +     RGR1_SW_INIT_1,
> > +     EXT_CFG_INDEX,
> > +     EXT_CFG_DATA,
> > +};
> > +
> > +enum {
> > +     RGR1_SW_INIT_1_INIT_MASK,
> > +     RGR1_SW_INIT_1_INIT_SHIFT,
> > +     RGR1_SW_INIT_1_PERST_MASK,
> > +     RGR1_SW_INIT_1_PERST_SHIFT,
> > +};
> > +
> > +enum pcie_type {
> > +     BCM7425,
> > +     BCM7435,
> > +     GENERIC,
> > +     BCM7278,
> > +};
> > +
> > +struct brcm_window {
> > +     dma_addr_t pcie_addr;
> > +     phys_addr_t cpu_addr;
> > +     dma_addr_t size;
> > +};
> > +
> > +/* Internal PCIe Host Controller Information.*/
> > +struct brcm_pcie {
> > +     struct list_head        list;
> > +     struct device           *dev;
> > +     void __iomem            *base;
> > +     struct list_head        resources;
> > +     int                     irq;
> > +     struct clk              *clk;
> > +     struct pci_bus          *root_bus;
> > +     struct device_node      *dn;
> > +     int                     id;
> > +     bool                    suspended;
> > +     int                     num_out_wins;
> > +     bool                    ssc;
> > +     int                     gen;
> > +     struct brcm_window      out_wins[BRCM_NUM_PCIE_OUT_WINS];
> > +     unsigned int            rev;
> > +     const int               *reg_offsets;
> > +     const int               *reg_field_info;
> > +     enum pcie_type          type;
> > +};
> > +
> > +struct pcie_cfg_data {
> > +     const int *reg_field_info;
> > +     const int *offsets;
> > +     const enum pcie_type type;
> > +};
> > +
> > +static const int pcie_reg_field_info[] = {
> > +     [RGR1_SW_INIT_1_INIT_MASK] = 0x2,
> > +     [RGR1_SW_INIT_1_INIT_SHIFT] = 0x1,
> > +};
> > +
> > +static const int pcie_reg_field_info_bcm7278[] = {
> > +     [RGR1_SW_INIT_1_INIT_MASK] = 0x1,
> > +     [RGR1_SW_INIT_1_INIT_SHIFT] = 0x0,
> > +};
> > +
> > +static const int pcie_offset_bcm7425[] = {
> > +     [RGR1_SW_INIT_1] = 0x8010,
> > +     [EXT_CFG_INDEX]  = 0x8300,
> > +     [EXT_CFG_DATA]   = 0x8304,
> > +};
> > +
> > +static const struct pcie_cfg_data bcm7425_cfg = {
> > +     .reg_field_info = pcie_reg_field_info,
> > +     .offsets        = pcie_offset_bcm7425,
> > +     .type           = BCM7425,
> > +};
> > +
> > +static const int pcie_offsets[] = {
> > +     [RGR1_SW_INIT_1] = 0x9210,
> > +     [EXT_CFG_INDEX]  = 0x9000,
> > +     [EXT_CFG_DATA]   = 0x9004,
> > +};
> > +
> > +static const struct pcie_cfg_data bcm7435_cfg = {
> > +     .reg_field_info = pcie_reg_field_info,
> > +     .offsets        = pcie_offsets,
> > +     .type           = BCM7435,
> > +};
> > +
> > +static const struct pcie_cfg_data generic_cfg = {
> > +     .reg_field_info = pcie_reg_field_info,
> > +     .offsets        = pcie_offsets,
> > +     .type           = GENERIC,
> > +};
> > +
> > +static const int pcie_offset_bcm7278[] = {
> > +     [RGR1_SW_INIT_1] = 0xc010,
> > +     [EXT_CFG_INDEX] = 0x9000,
> > +     [EXT_CFG_DATA] = 0x9004,
> > +};
> > +
> > +static const struct pcie_cfg_data bcm7278_cfg = {
> > +     .reg_field_info = pcie_reg_field_info_bcm7278,
> > +     .offsets        = pcie_offset_bcm7278,
> > +     .type           = BCM7278,
> > +};
> > +
> > +static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned
> int devfn,
> > +                                     int where);
> > +
> > +static struct pci_ops brcm_pcie_ops = {
> > +     .map_bus = brcm_pcie_map_conf,
> > +     .read = pci_generic_config_read,
> > +     .write = pci_generic_config_write,
> > +};
> > +
> > +#if defined(CONFIG_MIPS)
> > +/* Broadcom MIPs HW implicitly does the swapping if necessary */
> > +#define bcm_readl(a)         __raw_readl(a)
> > +#define bcm_writel(d, a)     __raw_writel(d, a)
> > +#define bcm_readw(a)         __raw_readw(a)
> > +#define bcm_writew(d, a)     __raw_writew(d, a)
> > +#else
> > +#define bcm_readl(a)         readl(a)
> > +#define bcm_writel(d, a)     writel(d, a)
> > +#define bcm_readw(a)         readw(a)
> > +#define bcm_writew(d, a)     writew(d, a)
> > +#endif
> > +
> > +/*
> > + * These macros are designed to sxtract/insert fields to host
> controller's
> > + * register set.
>
> s/are designed to s/ e/  (I assume they actually *do* extract/insert)
>
> > + */
> > +#define RD_FLD(base, reg, field) \
> > +     rd_fld(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT)
> > +#define WR_FLD(base, reg, field, val) \
> > +     wr_fld(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT,
> val)
> > +#define WR_FLD_RB(base, reg, field, val) \
> > +     wr_fld_rb(base + reg, reg##_##field##_MASK, reg##_##field##_SHIFT,
> val)
> > +#define WR_FLD_WITH_OFFSET(base, off, reg, field, val) \
> > +     wr_fld(base + reg + off, reg##_##field##_MASK, \
> > +            reg##_##field##_SHIFT, val)
> > +#define EXTRACT_FIELD(val, reg, field) \
> > +     ((val & reg##_##field##_MASK) >> reg##_##field##_SHIFT)
> > +#define INSERT_FIELD(val, reg, field, field_val) \
> > +     ((val & ~reg##_##field##_MASK) | \
> > +      (reg##_##field##_MASK & (field_val << reg##_##field##_SHIFT)))
> > +
> > +static struct list_head brcm_pcie = LIST_HEAD_INIT(brcm_pcie);
> > +static phys_addr_t scb_size[BRCM_MAX_SCB];
> > +static int num_memc;
> > +static DEFINE_MUTEX(brcm_pcie_lock);
> > +
> > +static u32 rd_fld(void __iomem *p, u32 mask, int shift)
> > +{
> > +     return (bcm_readl(p) & mask) >> shift;
> > +}
> > +
> > +static void wr_fld(void __iomem *p, u32 mask, int shift, u32 val)
> > +{
> > +     u32 reg = bcm_readl(p);
> > +
> > +     reg = (reg & ~mask) | ((val << shift) & mask);
> > +     bcm_writel(reg, p);
> > +}
> > +
> > +static void wr_fld_rb(void __iomem *p, u32 mask, int shift, u32 val)
> > +{
> > +     wr_fld(p, mask, shift, val);
> > +     (void)bcm_readl(p);
> > +}
> > +
> > +static const char *link_speed_to_str(int s)
> > +{
> > +     switch (s) {
> > +     case 1:
> > +             return "2.5";
> > +     case 2:
> > +             return "5.0";
> > +     case 3:
> > +             return "8.0";
> > +     default:
> > +             break;
> > +     }
> > +     return "???";
> > +}
> > +
> > +/*
> > + * The roundup_pow_of_two() from log2.h invokes
> > + * __roundup_pow_of_two(unsigned long), but we really need a
> > + * such a function to take a native u64 since unsigned long
> > + * is 32 bits on some configurations.  So we provide this helper
> > + * function below.
> > + */
> > +static u64 roundup_pow_of_two_64(u64 n)
> > +{
> > +     return 1ULL << fls64(n - 1);
> > +}
> > +
> > +/*
> > + * This is to convert the size of the inbound bar region to the
> > + * non-liniear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
>
> s/bar/BAR/  (This doesn't sound like a BAR in the PCI spec sense, but if
> that's what you call it, might as well spell it as the acronym)
>
> s/non-liniear/non-linear/
>
> > + */
> > +int encode_ibar_size(u64 size)
> > +{
> > +     int log2_in = ilog2(size);
> > +
> > +     if (log2_in >= 12 && log2_in <= 15)
> > +             /* Covers 4KB to 32KB (inclusive) */
> > +             return (log2_in - 12) + 0x1c;
> > +     else if (log2_in >= 16 && log2_in <= 37)
> > +             /* Covers 64KB to 32GB, (inclusive) */
> > +             return log2_in - 15;
> > +     /* Something is awry so disable */
> > +     return 0;
> > +}
> > +
> > +static u32 mdio_form_pkt(int port, int regad, int cmd)
> > +{
> > +     u32 pkt = 0;
> > +
> > +     pkt |= (port << MDIO_PORT_SHIFT) & MDIO_PORT_MASK;
> > +     pkt |= (regad << MDIO_REGAD_SHIFT) & MDIO_REGAD_MASK;
> > +     pkt |= (cmd << MDIO_CMD_SHIFT) & MDIO_CMD_MASK;
> > +
> > +     return pkt;
> > +}
> > +
> > +/* negative return value indicates error */
> > +static int mdio_read(void __iomem *base, u8 port, u8 regad)
> > +{
> > +     int tries;
> > +     u32 data;
> > +
> > +     bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_READ),
> > +                base + PCIE_RC_DL_MDIO_ADDR);
> > +     bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);
> > +
> > +     data = bcm_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
> > +     for (tries = 0; !MDIO_RD_DONE(data) && tries < 10; tries++) {
> > +             udelay(10);
> > +             data = bcm_readl(base + PCIE_RC_DL_MDIO_RD_DATA);
> > +     }
> > +
> > +     return MDIO_RD_DONE(data)
> > +             ? (data & MDIO_DATA_MASK) >> MDIO_DATA_SHIFT
> > +             : -EIO;
> > +}
> > +
> > +/* negative return value indicates error */
> > +static int mdio_write(void __iomem *base, u8 port, u8 regad, u16 wrdata)
> > +{
> > +     int tries;
> > +     u32 data;
> > +
> > +     bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_WRITE),
> > +                base + PCIE_RC_DL_MDIO_ADDR);
> > +     bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);
> > +     bcm_writel(MDIO_DATA_DONE_MASK | wrdata,
> > +                base + PCIE_RC_DL_MDIO_WR_DATA);
> > +
> > +     data = bcm_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
> > +     for (tries = 0; !MDIO_WT_DONE(data) && tries < 10; tries++) {
> > +             udelay(10);
> > +             data = bcm_readl(base + PCIE_RC_DL_MDIO_WR_DATA);
> > +     }
> > +
> > +     return MDIO_WT_DONE(data) ? 0 : -EIO;
> > +}
> > +
> > +/* configures device for ssc mode; negative return value indicates
> error */
>
> I guess "ssc" means Spread Spectrum Clocking?  Maybe spell out the
> first occurrence and spell as acronym in English text?
>
> > +static int set_ssc(void __iomem *base)
> > +{
> > +     int tmp;
> > +     u16 wrdata;
> > +     int pll, ssc;
> > +
> > +     tmp = mdio_write(base, MDIO_PORT0, SET_ADDR_OFFSET, SSC_REGS_ADDR);
> > +     if (tmp < 0)
> > +             return tmp;
> > +
> > +     tmp = mdio_read(base, MDIO_PORT0, SSC_CNTL_OFFSET);
> > +     if (tmp < 0)
> > +             return tmp;
> > +
> > +     wrdata = INSERT_FIELD(tmp, SSC_CNTL_OVRD, EN, 1);
> > +     wrdata = INSERT_FIELD(wrdata, SSC_CNTL_OVRD, VAL, 1);
> > +     tmp = mdio_write(base, MDIO_PORT0, SSC_CNTL_OFFSET, wrdata);
> > +     if (tmp < 0)
> > +             return tmp;
> > +
> > +     usleep_range(1000, 2000);
> > +     tmp = mdio_read(base, MDIO_PORT0, SSC_STATUS_OFFSET);
> > +     if (tmp < 0)
> > +             return tmp;
> > +
> > +     ssc = EXTRACT_FIELD(tmp, SSC_STATUS, SSC);
> > +     pll = EXTRACT_FIELD(tmp, SSC_STATUS, PLL_LOCK);
> > +
> > +     return (ssc && pll) ? 0 : -EIO;
> > +}
> > +
> > +/* limits operation to a specific generation (1, 2, or 3) */
> > +static void set_gen(void __iomem *base, int gen)
> > +{
> > +     u32 lnkcap = bcm_readl(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> > +     u16 lnkctl2 = bcm_readw(base + BRCM_PCIE_CAP_REGS +
> PCI_EXP_LNKCTL2);
> > +
> > +     lnkcap = (lnkcap & ~PCI_EXP_LNKCAP_SLS) | gen;
> > +     bcm_writel(lnkcap, base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCAP);
> > +
> > +     lnkctl2 = (lnkctl2 & ~0xf) | gen;
> > +     bcm_writew(lnkctl2, base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKCTL2);
> > +}
> > +
> > +static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
> > +                                    unsigned int win, phys_addr_t
> cpu_addr,
> > +                                    dma_addr_t  pcie_addr, dma_addr_t
> size)
> > +{
> > +     void __iomem *base = pcie->base;
> > +     phys_addr_t cpu_addr_mb, limit_addr_mb;
> > +     u32 tmp;
> > +
> > +     /* Set the base of the pcie_addr window */
> > +     bcm_writel(lower_32_bits(pcie_addr) + MMIO_ENDIAN,
> > +                base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + (win * 8));
> > +     bcm_writel(upper_32_bits(pcie_addr),
> > +                base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + (win * 8));
> > +
> > +     cpu_addr_mb = cpu_addr >> 20;
> > +     limit_addr_mb = (cpu_addr + size - 1) >> 20;
> > +
> > +     /* Write the addr base low register */
> > +     WR_FLD_WITH_OFFSET(base, (win * 4),
> > +                        PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
> > +                        BASE, cpu_addr_mb);
> > +     /* Write the addr limit low register */
> > +     WR_FLD_WITH_OFFSET(base, (win * 4),
> > +                        PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
> > +                        LIMIT, limit_addr_mb);
> > +
> > +     if (pcie->type != BCM7435 && pcie->type != BCM7425) {
> > +             /* Write the cpu addr high register */
> > +             tmp = (u32)(cpu_addr_mb >>
> > +                     PCIE_MISC_CPU_2_PCIE_MEM_WIN0_
> BASE_LIMIT_NUM_MASK_BITS);
> > +             WR_FLD_WITH_OFFSET(base, (win * 8),
> > +                                PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI,
> > +                                BASE, tmp);
> > +             /* Write the cpu limit high register */
> > +             tmp = (u32)(limit_addr_mb >>
> > +                     PCIE_MISC_CPU_2_PCIE_MEM_WIN0_
> BASE_LIMIT_NUM_MASK_BITS);
> > +             WR_FLD_WITH_OFFSET(base, (win * 8),
> > +                                PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI,
> > +                                LIMIT, tmp);
> > +     }
> > +}
> > +
> > +/* Configuration space read/write support */
> > +static int cfg_index(int busnr, int devfn, int reg)
> > +{
> > +     return ((PCI_SLOT(devfn) & 0x1f) << PCIE_SLOT_SHIFT)
> > +             | ((PCI_FUNC(devfn) & 0x07) << PCIE_FUNC_SHIFT)
> > +             | (busnr << PCIE_BUSNUM_SHIFT)
> > +             | (reg & ~3);
> > +}
> > +
> > +static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
> > +{
> > +     void __iomem *base = pcie->base;
> > +     u32 val = bcm_readl(base + PCIE_MISC_PCIE_STATUS);
> > +
> > +     return !!EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS, PCIE_PORT);
> > +}
> > +
> > +static bool brcm_pcie_link_up(struct brcm_pcie *pcie)
> > +{
> > +     void __iomem *base = pcie->base;
> > +     u32 val = bcm_readl(base + PCIE_MISC_PCIE_STATUS);
> > +     u32 dla = EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS,
> PCIE_DL_ACTIVE);
> > +     u32 plu = EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS,
> PCIE_PHYLINKUP);
> > +
> > +     return  (dla && plu) ? true : false;
> > +}
> > +
> > +static bool brcm_pcie_valid_device(struct brcm_pcie *pcie, struct
> pci_bus *bus,
> > +                                int dev)
> > +{
> > +     if (pci_is_root_bus(bus)) {
> > +             if (dev > 0)
> > +                     return false;
> > +     } else {
> > +             /* If there is no link, then there is no device */
> > +             if (!brcm_pcie_link_up(pcie))
> > +                     return false;
>
> This is racy, since the link can go down after you check but before
> you do the config access.  I assume your hardware can deal with a
> config access that targets a link that is down?
>
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned
> int devfn,
> > +                                     int where)
> > +{
> > +     struct brcm_pcie *pcie = bus->sysdata;
> > +     void __iomem *base = pcie->base;
> > +     int idx;
> > +
> > +     if (!brcm_pcie_valid_device(pcie, bus, PCI_SLOT(devfn)))
> > +             return NULL;
> > +
> > +     /* Accesses to the RC go right to the RC registers */
> > +     if (pci_is_root_bus(bus))
> > +             return base + where;
> > +
> > +     /* For devices, write to the config space index register */
> > +     idx = cfg_index(bus->number, devfn, where);
> > +     bcm_writel(idx, pcie->base + IDX_ADDR(pcie));
> > +     return base + DATA_ADDR(pcie) + (where & 0x3);
>
> I guess this is protected by a higher-level config access lock?
>

All pci config space accessor functions --
pci_bus_{read,write}_{byte,word,dword}() -- use a spinlock (pci_lock).
These routines, covered by the spinlock, call pci_generic_{read,write}(),
and those two functions call ops->map_bus(), aka our brcm_pcie_map_conf().

Unless CONFIG_PCI_LOCKLESS_CONFIG is set to "y", which it is not.


> > +}
> > +
> > +static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie,
> > +                                             unsigned int val)
> > +{
> > +     unsigned int offset;
> > +     unsigned int shift = pcie->reg_field_info[RGR1_SW_
> INIT_1_INIT_SHIFT];
> > +     u32 mask =  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MASK];
> > +
> > +     if (pcie->type != BCM7278) {
> > +             wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie), mask,
> shift,
> > +                       val);
> > +     } else if (of_machine_is_compatible("brcm,bcm7278a0")) {
> > +             /*
> > +              * The two PCIe instances on 7278a0 are not even
> consistent with
> > +              * respect to each other for internal offsets, here we
> offset
> > +              * by 0x14000 + RGR1_SW_INIT_1's relative offset to
> account for
> > +              * that.
> > +              */
> > +             offset = pcie->id ? 0x14010 : pcie->reg_offsets[RGR1_SW_
> INIT_1];
> > +             wr_fld_rb(pcie->base + offset, mask, shift, val);
> > +     } else {
> > +             wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie), mask,
> shift,
> > +                       val);
> > +     }
> > +}
> > +
> > +static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie,
> > +                                    unsigned int val)
> > +{
> > +     if (pcie->type != BCM7278)
> > +             wr_fld_rb(pcie->base + PCIE_RGR1_SW_INIT_1(pcie),
> > +                       PCIE_RGR1_SW_INIT_1_PERST_MASK,
> > +                       PCIE_RGR1_SW_INIT_1_PERST_SHIFT, val);
> > +     else
> > +             /* Assert = 0, de-assert = 1 on 7278 */
> > +             WR_FLD_RB(pcie->base, PCIE_MISC_PCIE_CTRL, PCIE_PERSTB,
> !val);
> > +}
> > +
> > +static int brcm_pcie_add_controller(struct brcm_pcie *pcie)
> > +{
> > +     mutex_lock(&brcm_pcie_lock);
> > +     list_add_tail(&pcie->list, &brcm_pcie);
> > +     mutex_unlock(&brcm_pcie_lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static void brcm_pcie_remove_controller(struct brcm_pcie *pcie)
> > +{
> > +     struct list_head *pos, *q;
> > +     struct brcm_pcie *tmp;
> > +
> > +     mutex_lock(&brcm_pcie_lock);
> > +     list_for_each_safe(pos, q, &brcm_pcie) {
> > +             tmp = list_entry(pos, struct brcm_pcie, list);
> > +             if (tmp == pcie) {
> > +                     list_del(pos);
> > +                     if (list_empty(&brcm_pcie))
> > +                             num_memc = 0;
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&brcm_pcie_lock);
>
> I'm missing something.  I don't see that num_memc is ever set to
> anything *other* than zero.
>
> This pattern of keeping a list of controllers is highly unusual and
> needs some explanation.
>
> > +}
> > +
> > +static int brcm_pcie_parse_request_of_pci_ranges(struct brcm_pcie
> *pcie)
> > +{
> > +     struct resource_entry *win;
> > +     int ret;
> > +
> > +     ret = of_pci_get_host_bridge_resources(pcie->dn, 0, 0xff,
> > +                                            &pcie->resources, NULL);
> > +     if (ret) {
> > +             dev_err(pcie->dev, "failed to get host resources\n");
> > +             return ret;
> > +     }
> > +
> > +     resource_list_for_each_entry(win, &pcie->resources) {
> > +             struct resource *parent, *res = win->res;
> > +             dma_addr_t offset = (dma_addr_t)win->offset;
> > +
> > +             if (resource_type(res) == IORESOURCE_IO) {
> > +                     parent = &ioport_resource;
> > +             } else if (resource_type(res) == IORESOURCE_MEM) {
> > +                     if (pcie->num_out_wins >= BRCM_NUM_PCIE_OUT_WINS) {
> > +                             dev_err(pcie->dev, "too many outbound
> wins\n");
> > +                             return -EINVAL;
> > +                     }
> > +                     pcie->out_wins[pcie->num_out_wins].cpu_addr
> > +                             = (phys_addr_t)res->start;
> > +                     pcie->out_wins[pcie->num_out_wins].pcie_addr
> > +                             = (dma_addr_t)(res->start
> > +                                            - (phys_addr_t)offset);
> > +                     pcie->out_wins[pcie->num_out_wins].size
> > +                             = (dma_addr_t)(res->end - res->start + 1);
> > +                     pcie->num_out_wins++;
> > +                     parent = &iomem_resource;
> > +             } else {
> > +                     continue;
> > +             }
> > +
> > +             ret = devm_request_resource(pcie->dev, parent, res);
> > +             if (ret) {
> > +                     dev_err(pcie->dev, "failed to get res %pR\n", res);
> > +                     return ret;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > +{
> > +     void __iomem *base = pcie->base;
> > +     unsigned int scb_size_val;
> > +     u64 rc_bar2_size = 0, rc_bar2_offset = 0, total_mem_size = 0;
>
> Unnecessary initializations (at least of rc_bar2_size, I didn't check
> the rest).
>
> Add
>
>   struct device *dev = pcie->dev;
>
> then use it below.
>
> > +     u32 tmp, burst;
> > +     int i, j, ret, limit;
> > +     u16 nlw, cls, lnksta;
> > +     bool ssc_good = false;
> > +
> > +     /* reset the bridge and the endpoint device */
> > +     /* field: PCIE_BRIDGE_SW_INIT = 1 */
>
> Not sure what these "field: ..." comments mean.  Are they for some
> automated tool?  To a human, it looks like they repeat what the code
> does.
>
> > +     brcm_pcie_bridge_sw_init_set(pcie, 1);
> > +
> > +     /* field: PCIE_SW_PERST = 1, on 7278, we start de-asserted already
> */
> > +     if (pcie->type != BCM7278)
> > +             brcm_pcie_perst_set(pcie, 1);
> > +
> > +     usleep_range(100, 200);
> > +
> > +     /* take the bridge out of reset */
> > +     /* field: PCIE_BRIDGE_SW_INIT = 0 */
> > +     brcm_pcie_bridge_sw_init_set(pcie, 0);
> > +
> > +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
> > +     /* wait for serdes to be stable */
> > +     usleep_range(100, 200);
> > +
> > +     /* Grab the PCIe hw revision number */
> > +     tmp = bcm_readl(base + PCIE_MISC_REVISION);
> > +     pcie->rev = EXTRACT_FIELD(tmp, PCIE_MISC_REVISION, MAJMIN);
> > +
> > +     /* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
> > +     tmp = INSERT_FIELD(0, PCIE_MISC_MISC_CTRL, SCB_ACCESS_EN, 1);
> > +     tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, CFG_READ_UR_MODE, 1);
> > +     burst = (pcie->type == GENERIC || pcie->type == BCM7278)
> > +             ? BURST_SIZE_512 : BURST_SIZE_256;
> > +     tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, MAX_BURST_SIZE,
> burst);
> > +     bcm_writel(tmp, base + PCIE_MISC_MISC_CTRL);
> > +
> > +     /*
> > +      * Set up inbound memory view for the EP (called RC_BAR2,
> > +      * not to be confused with the BARs that are advertised by
> > +      * the EP).
> > +      */
> > +     for (i = 0; i < num_memc; i++)
> > +             total_mem_size += scb_size[i];
> > +
> > +     /*
> > +      * The PCIe host controller by design must set the inbound
> > +      * viewport to be a contiguous arrangement of all of the
> > +      * system's memory.  In addition, its size mut be a power of
> > +      * two.  To further complicate matters, the viewport must
> > +      * start on a pcie-address that is aligned on a multiple of its
> > +      * size.  If a portion of the viewport does not represent
> > +      * system memory -- e.g. 3GB of memory requires a 4GB viewport
> > +      * -- we can map the outbound memory in or after 3GB and even
> > +      * though the viewport will overlap the outbound memory the
> > +      * controller will know to send outbound memory downstream and
> > +      * everything else upstream.
> > +      */
> > +     rc_bar2_size = roundup_pow_of_two_64(total_mem_size);
> > +
> > +     /*
> > +      * Set simple configuration based on memory sizes
> > +      * only.  We always start the viewport at address 0.
> > +      */
> > +     rc_bar2_offset = 0;
> > +
> > +     tmp = lower_32_bits(rc_bar2_offset);
> > +     tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
> > +                        encode_ibar_size(rc_bar2_size));
> > +     bcm_writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> > +     bcm_writel(upper_32_bits(rc_bar2_offset),
> > +                base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> > +
> > +     /* field: SCB0_SIZE, default = 0xf (1 GB) */
> > +     scb_size_val = scb_size[0]
> > +             ? ilog2(scb_size[0]) - 15 : 0xf;
> > +     WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB0_SIZE, scb_size_val);
> > +
> > +     /* field: SCB1_SIZE, default = 0xf (1 GB) */
> > +     if (num_memc > 1) {
> > +             scb_size_val = scb_size[1]
> > +                     ? ilog2(scb_size[1]) - 15 : 0xf;
> > +             WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB1_SIZE, scb_size_val);
> > +     }
> > +
> > +     /* field: SCB2_SIZE, default = 0xf (1 GB) */
> > +     if (num_memc > 2) {
> > +             scb_size_val = scb_size[2]
> > +                     ? ilog2(scb_size[2]) - 15 : 0xf;
> > +             WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB2_SIZE, scb_size_val);
> > +     }
> > +
> > +     /* disable the PCIe->GISB memory window (RC_BAR1) */
> > +     WR_FLD(base, PCIE_MISC_RC_BAR1_CONFIG_LO, SIZE, 0);
> > +
> > +     /* disable the PCIe->SCB memory window (RC_BAR3) */
> > +     WR_FLD(base, PCIE_MISC_RC_BAR3_CONFIG_LO, SIZE, 0);
> > +
> > +     if (!pcie->suspended) {
> > +             /* clear any interrupts we find on boot */
> > +             bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + CLR);
> > +             (void)bcm_readl(base + PCIE_INTR2_CPU_BASE + CLR);
> > +     }
> > +
> > +     /* Mask all interrupts since we are not handling any yet */
> > +     bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + MASK_SET);
> > +     (void)bcm_readl(base + PCIE_INTR2_CPU_BASE + MASK_SET);
> > +
> > +     if (pcie->gen)
> > +             set_gen(base, pcie->gen);
> > +
> > +     /* take the EP device out of reset */
> > +     /* field: PCIE_SW_PERST = 0 */
> > +     brcm_pcie_perst_set(pcie, 0);
>
> <raises eyebrows>  Take the *EP* out of reset?  The host controller
> driver shouldn't be touching an EP directly.  Maybe the comment
> doesn't match what the code actually does.
>
> > +
> > +     /*
> > +      * Give the RC/EP time to wake up, before trying to configure RC.
> > +      * Intermittently check status for link-up, up to a total of 100ms
> > +      * when we don't know if the device is there, and up to 1000ms if
> > +      * we do know the device is there.
> > +      */
> > +     limit = pcie->suspended ? 1000 : 100;
> > +     for (i = 1, j = 0; j < limit && !brcm_pcie_link_up(pcie);
> > +          j += i, i = i * 2)
> > +             msleep(i + j > limit ? limit - j : i);
> > +
> > +     if (!brcm_pcie_link_up(pcie)) {
> > +             dev_info(pcie->dev, "link down\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     if (!brcm_pcie_rc_mode(pcie)) {
> > +             dev_err(pcie->dev, "PCIe misconfigured; is in EP mode\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     for (i = 0; i < pcie->num_out_wins; i++)
> > +             brcm_pcie_set_outbound_win(pcie, i,
> pcie->out_wins[i].cpu_addr,
> > +                                        pcie->out_wins[i].pcie_addr,
> > +                                        pcie->out_wins[i].size);
> > +
> > +     /*
> > +      * For config space accesses on the RC, show the right class for
> > +      * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > +      */
> > +     WR_FLD_RB(base, PCIE_RC_CFG_PRIV1_ID_VAL3, CLASS_CODE, 0x060400);
> > +
> > +     if (pcie->ssc) {
> > +             ret = set_ssc(base);
> > +             if (ret == 0)
> > +                     ssc_good = true;
> > +             else
> > +                     dev_err(pcie->dev,
> > +                             "failed attempt to enter ssc mode\n");
> > +     }
> > +
> > +     lnksta = bcm_readw(base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
> > +     cls = lnksta & PCI_EXP_LNKSTA_CLS;
> > +     nlw = (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> > +     dev_info(pcie->dev, "link up, %s Gbps x%u %s\n",
> link_speed_to_str(cls),
> > +              nlw, ssc_good ? "(SSC)" : "(!SSC)");
> > +
> > +     /* PCIe->SCB endian mode for BAR */
> > +     /* field ENDIAN_MODE_BAR2 = DATA_ENDIAN */
> > +     WR_FLD_RB(base, PCIE_RC_CFG_VENDOR_VENDOR_SPECIFIC_REG1,
> > +               ENDIAN_MODE_BAR2, DATA_ENDIAN);
> > +
> > +     /*
> > +      * Refclk from RC should be gated with CLKREQ# input when ASPM
> L0s,L1
> > +      * is enabled =>  setting the CLKREQ_DEBUG_ENABLE field to 1.
> > +      */
> > +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG,
> CLKREQ_DEBUG_ENABLE, 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static void enter_l23(struct brcm_pcie *pcie)
> > +{
> > +     void __iomem *base = pcie->base;
> > +     int tries, l23;
> > +
> > +     /* assert request for L23 */
> > +     WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 1);
> > +     /* poll L23 status */
> > +     for (tries = 0, l23 = 0; tries < 1000 && !l23; tries++)
> > +             l23 = RD_FLD(base, PCIE_MISC_PCIE_STATUS,
> PCIE_LINK_IN_L23);
> > +     if (!l23)
> > +             dev_err(pcie->dev, "failed to enter L23\n");
>
> What does "L23" mean?  Some power management thing?
>
> > +}
> > +
> > +static void turn_off(struct brcm_pcie *pcie)
> > +{
> > +     void __iomem *base = pcie->base;
> > +
> > +     if (brcm_pcie_link_up(pcie))
> > +             enter_l23(pcie);
> > +     /* Reset endpoint device */
> > +     brcm_pcie_perst_set(pcie, 1);
> > +     /* deassert request for L23 in case it was asserted */
> > +     WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQUEST, 0);
> > +     /* SERDES_IDDQ = 1 */
> > +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 1);
> > +     /* Shutdown PCIe bridge */
> > +     brcm_pcie_bridge_sw_init_set(pcie, 1);
> > +}
> > +
> > +static int brcm_pcie_suspend(struct device *dev)
> > +{
> > +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +     turn_off(pcie);
> > +     clk_disable_unprepare(pcie->clk);
> > +     pcie->suspended = true;
> > +
> > +     return 0;
> > +}
> > +
> > +static int brcm_pcie_resume(struct device *dev)
> > +{
> > +     struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > +     void __iomem *base;
> > +     int ret;
> > +
> > +     base = pcie->base;
> > +     clk_prepare_enable(pcie->clk);
> > +
> > +     /* Take bridge out of reset so we can access the SERDES reg */
>
> Some comments above and below spell it "serdes"; here you spell it
> "SERDES".
>
> > +     brcm_pcie_bridge_sw_init_set(pcie, 0);
> > +
> > +     /* SERDES_IDDQ = 0 */
> > +     WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
> > +     /* wait for serdes to be stable */
> > +     usleep_range(100, 200);
> > +
> > +     ret = brcm_pcie_setup(pcie);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pcie->suspended = false;
> > +
> > +     return 0;
> > +}
> > +
> > +static void _brcm_pcie_remove(struct brcm_pcie *pcie)
> > +{
> > +     turn_off(pcie);
> > +     clk_disable_unprepare(pcie->clk);
> > +     clk_put(pcie->clk);
> > +     brcm_pcie_remove_controller(pcie);
> > +}
> > +
> > +static int brcm_pcie_remove(struct platform_device *pdev)
> > +{
> > +     struct brcm_pcie *pcie = platform_get_drvdata(pdev);
> > +
> > +     pci_stop_root_bus(pcie->root_bus);
> > +     pci_remove_root_bus(pcie->root_bus);
> > +     _brcm_pcie_remove(pcie);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id brcm_pcie_match[] = {
> > +     { .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> > +     { .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
> > +     { .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
> > +     { .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> > +
> > +static int brcm_pcie_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *dn = pdev->dev.of_node;
> > +     const struct of_device_id *of_id;
> > +     const struct pcie_cfg_data *data;
> > +     int ret;
> > +     struct brcm_pcie *pcie;
> > +     struct resource *res;
> > +     void __iomem *base;
> > +     u32 tmp;
> > +     struct pci_host_bridge *bridge;
> > +     struct pci_bus *child;
> > +
> > +     bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
> > +     if (!bridge)
> > +             return -ENOMEM;
> > +
> > +     pcie = pci_host_bridge_priv(bridge);
> > +     INIT_LIST_HEAD(&pcie->resources);
> > +
> > +     of_id = of_match_node(brcm_pcie_match, dn);
> > +     if (!of_id) {
> > +             dev_err(&pdev->dev, "failed to look up compatible
> string\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (of_property_read_u32(dn, "dma-ranges", &tmp) == 0) {
> > +             dev_err(&pdev->dev, "cannot yet handle dma-ranges\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     data = of_id->data;
> > +     pcie->reg_offsets = data->offsets;
> > +     pcie->reg_field_info = data->reg_field_info;
> > +     pcie->type = data->type;
> > +     pcie->dn = dn;
> > +     pcie->dev = &pdev->dev;
> > +
> > +     pcie->id = of_get_pci_domain_nr(dn);
>
> Why do you call of_get_pci_domain_nr() directly?  No other driver
> does.
>
> > +     if (pcie->id < 0)
> > +             return pcie->id;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -EINVAL;
> > +
> > +     base = devm_ioremap_resource(&pdev->dev, res);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     pcie->clk = of_clk_get_by_name(dn, "sw_pcie");
> > +     if (IS_ERR(pcie->clk)) {
> > +             dev_err(&pdev->dev, "could not get clock\n");
> > +             pcie->clk = NULL;
> > +     }
> > +     pcie->base = base;
> > +
> > +     ret = of_pci_get_max_link_speed(dn);
> > +     pcie->gen = (ret < 0) ? 0 : ret;
> > +
> > +     pcie->ssc = of_property_read_bool(dn, "brcm,enable-ssc");
> > +
> > +     ret = irq_of_parse_and_map(pdev->dev.of_node, 0);
> > +     if (ret == 0)
> > +             /* keep going, as we don't use this intr yet */
> > +             dev_warn(pcie->dev, "cannot get pcie interrupt\n");
> > +     else
> > +             pcie->irq = ret;
> > +
> > +     ret = brcm_pcie_parse_request_of_pci_ranges(pcie);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = clk_prepare_enable(pcie->clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "could not enable clock\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = brcm_pcie_add_controller(pcie);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = brcm_pcie_setup(pcie);
> > +     if (ret)
> > +             goto fail;
> > +
> > +     list_splice_init(&pcie->resources, &bridge->windows);
> > +     bridge->dev.parent = &pdev->dev;
> > +     bridge->busnr = 0;
> > +     bridge->ops = &brcm_pcie_ops;
> > +     bridge->sysdata = pcie;
> > +     bridge->map_irq = of_irq_parse_and_map_pci;
> > +     bridge->swizzle_irq = pci_common_swizzle;
> > +
> > +     ret = pci_scan_root_bus_bridge(bridge);
> > +     if (ret < 0) {
> > +             dev_err(pcie->dev, "Scanning root bridge failed");
> > +             goto fail;
> > +     }
> > +
> > +     pci_assign_unassigned_bus_resources(bridge->bus);
> > +     list_for_each_entry(child, &bridge->bus->children, node)
> > +             pcie_bus_configure_settings(child);
> > +     pci_bus_add_devices(bridge->bus);
> > +     platform_set_drvdata(pdev, pcie);
> > +     pcie->root_bus = bridge->bus;
> > +
> > +     return 0;
> > +
> > +fail:
> > +     _brcm_pcie_remove(pcie);
> > +     return ret;
> > +}
> > +
> > +static const struct dev_pm_ops brcm_pcie_pm_ops = {
> > +     .suspend_noirq = brcm_pcie_suspend,
> > +     .resume_noirq = brcm_pcie_resume,
> > +};
> > +
> > +static struct platform_driver __refdata brcm_pcie_driver = {
>
> Why do you need __refdata?  There's only only other occurrence in
> drivers/pci, and I'm dubious about that one as well.
>
> > +     .probe = brcm_pcie_probe,
> > +     .remove = brcm_pcie_remove,
> > +     .driver = {
> > +             .name = "brcm-pcie",
> > +             .owner = THIS_MODULE,
> > +             .of_match_table = brcm_pcie_match,
> > +             .pm = &brcm_pcie_pm_ops,
> > +     },
> > +};
> > +
> > +module_platform_driver(brcm_pcie_driver);
> > +
> > +MODULE_LICENSE("GPL");
>
> Copyright notice above says "GPL v2", which is not the same as the
> "GPL" here.
>
> > +MODULE_DESCRIPTION("Broadcom STB PCIE RC driver");
> > +MODULE_AUTHOR("Broadcom");
> > --
> > 1.9.0.138.g2de3478
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--94eb2c1dffd8150aa8056052c206
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 12, 2017 at 5:16 PM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div c=
lass=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Tue, Nov 14, 2017 at 05:12=
:07PM -0500, Jim Quinlan wrote:<br>
&gt; This commit adds the basic Broadcom STB PCIe controller.=C2=A0 Missing=
 is<br>
&gt; the ability to process MSI and also handle dma-ranges for inbound<br>
&gt; memory accesses.=C2=A0 These two functionalities are added in subseque=
nt<br>
&gt; commits.<br>
&gt;<br>
&gt; The PCIe block contains an MDIO interface.=C2=A0 This is a local inter=
face<br>
&gt; only accessible by the PCIe controller.=C2=A0 It cannot be used or sha=
red<br>
&gt; by any other HW.=C2=A0 As such, the small amount of code for this<br>
&gt; controller is included in this driver as there is little upside to put=
<br>
&gt; it elsewhere.<br>
&gt;<br>
&gt; Signed-off-by: Jim Quinlan &lt;<a href=3D"mailto:jim2101024@gmail.com"=
>jim2101024@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/pci/host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 9 +<br>
&gt;=C2=A0 drivers/pci/host/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 1 +<br>
&gt;=C2=A0 drivers/pci/host/pcie-brcmstb.<wbr>c | 1124 ++++++++++++++++++++=
++++++++++<wbr>+++++++++<br>
&gt;=C2=A0 3 files changed, 1134 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/pci/host/pcie-brcmstb.<wbr>c<br>
&gt;<br>
&gt; diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig<br>
&gt; index b868803..751463e 100644<br>
&gt; --- a/drivers/pci/host/Kconfig<br>
&gt; +++ b/drivers/pci/host/Kconfig<br>
&gt; @@ -220,4 +220,13 @@ config VMD<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0To compile this driver as a module, c=
hoose M here: the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0module will be called vmd.<br>
&gt;<br>
&gt; +config PCIE_BRCMSTB<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tristate &quot;Broadcom Brcmstb PCIe platform hos=
t driver&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_BRCMSTB || BMIPS_GENERIC<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on OF<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on SOC_BRCMSTB<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default ARCH_BRCMSTB || BMIPS_GENERIC<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Adds support for Broadcom Settop Box PCIe =
host controller.<br>
&gt; +<br>
&gt;=C2=A0 endmenu<br>
&gt; diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile<br>
&gt; index 1238278..a8b9923 100644<br>
&gt; --- a/drivers/pci/host/Makefile<br>
&gt; +++ b/drivers/pci/host/Makefile<br>
&gt; @@ -21,6 +21,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP) +=3D pcie-rockchip.o<br>
&gt;=C2=A0 obj-$(CONFIG_PCIE_MEDIATEK) +=3D pcie-mediatek.o<br>
&gt;=C2=A0 obj-$(CONFIG_PCIE_TANGO_<wbr>SMP8759) +=3D pcie-tango.o<br>
&gt;=C2=A0 obj-$(CONFIG_VMD) +=3D vmd.o<br>
&gt; +obj-$(CONFIG_PCIE_BRCMSTB) +=3D pcie-brcmstb.o<br>
&gt;<br>
&gt;=C2=A0 # The following drivers are for devices that use the generic ACP=
I<br>
&gt;=C2=A0 # pci_root.c driver but don&#39;t support standard ECAM config a=
ccess.<br>
&gt; diff --git a/drivers/pci/host/pcie-<wbr>brcmstb.c b/drivers/pci/host/p=
cie-<wbr>brcmstb.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..d8a8f7a<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/pci/host/pcie-<wbr>brcmstb.c<br>
&gt; @@ -0,0 +1,1124 @@<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2009 - 2017 Broadcom<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License version 2 as<=
br>
&gt; + * published by the Free Software Foundation.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
&gt; +#include &lt;linux/compiler.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/ioport.h&gt;<br>
&gt; +#include &lt;linux/irqdomain.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/list.h&gt;<br>
&gt; +#include &lt;linux/log2.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/of_address.h&gt;<br>
&gt; +#include &lt;linux/of_irq.h&gt;<br>
&gt; +#include &lt;linux/of_pci.h&gt;<br>
&gt; +#include &lt;linux/of_pci.h&gt;<br>
&gt; +#include &lt;linux/of_platform.h&gt;<br>
&gt; +#include &lt;linux/pci.h&gt;<br>
&gt; +#include &lt;linux/printk.h&gt;<br>
&gt; +#include &lt;linux/sizes.h&gt;<br>
&gt; +#include &lt;linux/slab.h&gt;<br>
&gt; +#include &lt;soc/brcmstb/memory_api.h&gt;<br>
&gt; +#include &lt;linux/string.h&gt;<br>
&gt; +#include &lt;linux/types.h&gt;<br>
&gt; +<br>
&gt; +/* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config re=
gs */<br>
&gt; +#define BRCM_PCIE_CAP_REGS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00ac<br>
<br>
</div></div>Add a blank line before multi-line comments.<br>
<span class=3D"gmail-"><br>
&gt; +/*<br>
&gt; + * Broadcom Settop Box PCIE Register Offsets. The names are from<br>
&gt; + * the chip&#39;s RDB and we use them here so that a script can corre=
late<br>
&gt; + * this code and the RDB to prevent discrepancies.<br>
<br>
</span>Use &quot;PCIe&quot; capitalization in English text and messages.<br=
>
<div><div class=3D"gmail-h5"><br>
&gt; + */<br>
&gt; +#define PCIE_RC_CFG_VENDOR_VENDOR_<wbr>SPECIFIC_REG1=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0188<br>
&gt; +#define PCIE_RC_CFG_PRIV1_ID_VAL3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x043c<br>
&gt; +#define PCIE_RC_DL_MDIO_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1100<br>
&gt; +#define PCIE_RC_DL_MDIO_WR_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1104<b=
r>
&gt; +#define PCIE_RC_DL_MDIO_RD_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1108<b=
r>
&gt; +#define PCIE_MISC_MISC_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4008<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>LO=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x400c<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>HI=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x4010<br>
&gt; +#define PCIE_MISC_RC_BAR1_CONFIG_LO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x402c<br>
&gt; +#define PCIE_MISC_RC_BAR2_CONFIG_LO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4034<br>
&gt; +#define PCIE_MISC_RC_BAR2_CONFIG_HI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4038<br>
&gt; +#define PCIE_MISC_RC_BAR3_CONFIG_LO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x403c<br>
&gt; +#define PCIE_MISC_PCIE_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4064<br>
&gt; +#define PCIE_MISC_PCIE_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
x4068<br>
&gt; +#define PCIE_MISC_REVISION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x406c<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT=C2=A0 =C2=A0 =
=C2=A00x4070<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_HI=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4080<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>LIMIT_HI=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4084<br>
&gt; +#define PCIE_MISC_HARD_PCIE_HARD_DEBUG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4204<br>
&gt; +#define PCIE_INTR2_CPU_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4300<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Broadcom Settop Box PCIE Register Field shift and mask info. The<b=
r>
&gt; + * names are from the chip&#39;s RDB and we use them here so that a s=
cript<br>
&gt; + * can correlate this code and the RDB to prevent discrepancies.<br>
&gt; + */<br>
&gt; +#define PCIE_RC_CFG_VENDOR_VENDOR_<wbr>SPECIFIC_REG1_ENDIAN_MODE_<wbr=
>BAR2_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc<br>
&gt; +#define PCIE_RC_CFG_VENDOR_VENDOR_<wbr>SPECIFIC_REG1_ENDIAN_MODE_<wbr=
>BAR2_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A00x2<br>
&gt; +#define PCIE_RC_CFG_PRIV1_ID_VAL3_<wbr>CLASS_CODE_MASK=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xffffff<br>
&gt; +#define PCIE_RC_CFG_PRIV1_ID_VAL3_<wbr>CLASS_CODE_SHIFT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB_<wbr>ACCESS_EN_MASK=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1000<br=
>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB_<wbr>ACCESS_EN_SHIFT=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc<br>
&gt; +#define PCIE_MISC_MISC_CTRL_CFG_READ_<wbr>UR_MODE_MASK=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2000<br>
&gt; +#define PCIE_MISC_MISC_CTRL_CFG_READ_<wbr>UR_MODE_SHIFT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00xd<br>
&gt; +#define PCIE_MISC_MISC_CTRL_MAX_BURST_<wbr>SIZE_MASK=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x300000<br>
&gt; +#define PCIE_MISC_MISC_CTRL_MAX_BURST_<wbr>SIZE_SHIFT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x14<br>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_<wbr>MASK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xf8000000<br>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB0_SIZE_<wbr>SHIFT=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1b<br>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_<wbr>MASK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x7c00000<br>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB1_SIZE_<wbr>SHIFT=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x16<br>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_<wbr>MASK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1f<br>
&gt; +#define PCIE_MISC_MISC_CTRL_SCB2_SIZE_<wbr>SHIFT=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0<br>
&gt; +#define PCIE_MISC_RC_BAR1_CONFIG_LO_<wbr>SIZE_MASK=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1f<br>
&gt; +#define PCIE_MISC_RC_BAR1_CONFIG_LO_<wbr>SIZE_SHIFT=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define PCIE_MISC_RC_BAR2_CONFIG_LO_<wbr>SIZE_MASK=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1f<br>
&gt; +#define PCIE_MISC_RC_BAR2_CONFIG_LO_<wbr>SIZE_SHIFT=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define PCIE_MISC_RC_BAR3_CONFIG_LO_<wbr>SIZE_MASK=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1f<br>
&gt; +#define PCIE_MISC_RC_BAR3_CONFIG_LO_<wbr>SIZE_SHIFT=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define PCIE_MISC_PCIE_CTRL_PCIE_<wbr>PERSTB_MASK=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br>
&gt; +#define PCIE_MISC_PCIE_CTRL_PCIE_<wbr>PERSTB_SHIFT=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2<br>
&gt; +#define PCIE_MISC_PCIE_CTRL_PCIE_L23_<wbr>REQUEST_MASK=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1<br>
&gt; +#define PCIE_MISC_PCIE_CTRL_PCIE_L23_<wbr>REQUEST_SHIFT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_<wbr>PORT_MASK=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x80<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_<wbr>PORT_SHIFT=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x7<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_DL_<wbr>ACTIVE_MASK=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_DL_<wbr>ACTIVE_SHIFT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x5<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_<wbr>PHYLINKUP_MASK=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_<wbr>PHYLINKUP_SHIFT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x4<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_<wbr>LINK_IN_L23_MASK=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 0x40<br>
&gt; +#define PCIE_MISC_PCIE_STATUS_PCIE_<wbr>LINK_IN_L23_SHIFT=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x6<br>
&gt; +#define PCIE_MISC_REVISION_MAJMIN_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00xffff<br>
&gt; +#define PCIE_MISC_REVISION_MAJMIN_<wbr>SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT_LIMIT_MASK=C2=
=A0 0xfff00000<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT_LIMIT_SHIFT 0x1=
4<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT_BASE_MASK=C2=A0=
 =C2=A00xfff0<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT_BASE_SHIFT=C2=
=A0 0x4<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT_NUM_MASK_BITS=
=C2=A0 =C2=A0 =C2=A0 =C2=A00xc<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_HI_BASE_MASK=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xff<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_HI_BASE_SHIFT=C2=A0 =
=C2=A0 =C2=A00x0<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>LIMIT_HI_LIMIT_MASK=C2=A0 =
=C2=A0 0xff<br>
&gt; +#define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>LIMIT_HI_LIMIT_SHIFT=C2=A0=
 =C2=A00x0<br>
&gt; +#define PCIE_MISC_HARD_PCIE_HARD_<wbr>DEBUG_CLKREQ_DEBUG_ENABLE_MASK=
=C2=A0 =C2=A0 =C2=A0 0x2<br>
&gt; +#define PCIE_MISC_HARD_PCIE_HARD_<wbr>DEBUG_CLKREQ_DEBUG_ENABLE_<wbr>=
SHIFT 0x1<br>
&gt; +#define PCIE_MISC_HARD_PCIE_HARD_<wbr>DEBUG_SERDES_IDDQ_MASK=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08000000<br>
&gt; +#define PCIE_MISC_HARD_PCIE_HARD_<wbr>DEBUG_SERDES_IDDQ_SHIFT=C2=A0 =
=C2=A0 =C2=A00x1b<br>
&gt; +#define PCIE_RGR1_SW_INIT_1_PERST_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x1<br>
&gt; +#define PCIE_RGR1_SW_INIT_1_PERST_<wbr>SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x0<br>
&gt; +<br>
&gt; +#define BRCM_NUM_PCIE_OUT_WINS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x4<br>
&gt; +#define BRCM_MAX_SCB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x4<br>
&gt; +<br>
&gt; +#define BRCM_MSI_TARGET_ADDR_LT_4GB=C2=A0 0x0fffffffcULL<br>
&gt; +#define BRCM_MSI_TARGET_ADDR_GT_4GB=C2=A0 0xffffffffcULL<br>
&gt; +<br>
&gt; +#define BURST_SIZE_128=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define BURST_SIZE_256=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt; +#define BURST_SIZE_512=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
&gt; +<br>
&gt; +/* Offsets from PCIE_INTR2_CPU_BASE */<br>
&gt; +#define STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4<br>
&gt; +#define CLR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8<br>
&gt; +#define MASK_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0xc<br>
&gt; +#define MASK_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
&gt; +#define MASK_CLR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x14<br>
&gt; +<br>
&gt; +#define PCIE_BUSNUM_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 20=
<br>
&gt; +#define PCIE_SLOT_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 15<br>
&gt; +#define PCIE_FUNC_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 12<br>
&gt; +<br>
&gt; +#if defined(__BIG_ENDIAN)<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 DATA_ENDIAN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02=C2=A0 =C2=A0 =C2=A0 =C2=A0/* PCIe-&gt;DDR inbound acc=
esses */<br>
&gt; +#define MMIO_ENDIAN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2=C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* CPU-&gt;PCIe outbound accesses */<br>
&gt; +#else<br>
&gt; +#define=C2=A0 =C2=A0 =C2=A0 DATA_ENDIAN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define MMIO_ENDIAN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#define MDIO_PORT0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define MDIO_DATA_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x7fffffff<br>
&gt; +#define MDIO_DATA_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0<br>
&gt; +#define MDIO_PORT_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00xf0000<br>
&gt; +#define MDIO_PORT_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x16<br>
&gt; +#define MDIO_REGAD_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0xffff<br>
&gt; +#define MDIO_REGAD_SHIFT=C2=A0 =C2=A0 =C2=A00x0<br>
&gt; +#define MDIO_CMD_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0xfff00000<br>
&gt; +#define MDIO_CMD_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x14<br>
&gt; +#define MDIO_CMD_READ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x1<br>
&gt; +#define MDIO_CMD_WRITE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x0<br>
&gt; +#define MDIO_DATA_DONE_MASK=C2=A0 0x80000000<br>
&gt; +#define MDIO_RD_DONE(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (((x) &amp; MDIO_DATA_DONE_MASK) ? 1 : 0)<br>
&gt; +#define MDIO_WT_DONE(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (((x) &amp; MDIO_DATA_DONE_MASK) ? 0 : 1)<br>
&gt; +#define SSC_REGS_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 0x1100<br>
&gt; +#define SET_ADDR_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x1f<br>
&gt; +#define SSC_CNTL_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x2<br>
&gt; +#define SSC_CNTL_OVRD_EN_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8000<br>
&gt; +#define SSC_CNTL_OVRD_EN_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A00xf<br>
&gt; +#define SSC_CNTL_OVRD_VAL_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x4000<br>
&gt; +#define SSC_CNTL_OVRD_VAL_SHIFT=C2=A0 =C2=A0 =C2=A0 0xe<br>
&gt; +#define SSC_STATUS_OFFSET=C2=A0 =C2=A0 0x1<br>
&gt; +#define SSC_STATUS_SSC_MASK=C2=A0 0x400<br>
&gt; +#define SSC_STATUS_SSC_SHIFT 0xa<br>
&gt; +#define SSC_STATUS_PLL_LOCK_MASK=C2=A0 =C2=A0 =C2=A00x800<br>
&gt; +#define SSC_STATUS_PLL_LOCK_SHIFT=C2=A0 =C2=A0 0xb<br>
&gt; +<br>
&gt; +#define IDX_ADDR(pcie)=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0((pcie)-&gt;reg_offsets[EXT_CFG_<wbr>INDEX])<br>
&gt; +#define DATA_ADDR(pcie)=C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0((pcie)-&gt;reg_offsets[EXT_CFG_<wbr>DATA])<br>
&gt; +#define PCIE_RGR1_SW_INIT_1(pcie) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0((pcie)-&gt;reg_offsets[RGR1_SW_<wbr>INIT_1])<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0RGR1_SW_INIT_1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0EXT_CFG_INDEX,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0EXT_CFG_DATA,<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0RGR1_SW_INIT_1_INIT_MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0RGR1_SW_INIT_1_INIT_SHIFT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0RGR1_SW_INIT_1_PERST_MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0RGR1_SW_INIT_1_PERST_SHIFT,<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum pcie_type {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BCM7425,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BCM7435,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0GENERIC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BCM7278,<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct brcm_window {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dma_addr_t pcie_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0phys_addr_t cpu_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dma_addr_t size;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* Internal PCIe Host Controller Information.*/<br>
&gt; +struct brcm_pcie {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 =C2=A0 =C2=A0 list;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0*dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head=C2=A0 =C2=A0 =C2=A0 =C2=A0 resou=
rces;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct clk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *clk;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct pci_bus=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
*root_bus;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device_node=C2=A0 =C2=A0 =C2=A0 *dn;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 suspended;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_out_wins;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ssc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct brcm_window=C2=A0 =C2=A0 =C2=A0 out_wins[B=
RCM_NUM_PCIE_OUT_<wbr>WINS];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 rev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*reg_offsets;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*reg_field_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0enum pcie_type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
type;<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct pcie_cfg_data {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const int *reg_field_info;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const int *offsets;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const enum pcie_type type;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const int pcie_reg_field_info[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[RGR1_SW_INIT_1_INIT_MASK] =3D 0x2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[RGR1_SW_INIT_1_INIT_SHIFT] =3D 0x1,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const int pcie_reg_field_info_bcm7278[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[RGR1_SW_INIT_1_INIT_MASK] =3D 0x1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[RGR1_SW_INIT_1_INIT_SHIFT] =3D 0x0,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const int pcie_offset_bcm7425[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[RGR1_SW_INIT_1] =3D 0x8010,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[EXT_CFG_INDEX]=C2=A0 =3D 0x8300,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[EXT_CFG_DATA]=C2=A0 =C2=A0=3D 0x8304,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct pcie_cfg_data bcm7425_cfg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.reg_field_info =3D pcie_reg_field_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.offsets=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D pcie_offs=
et_bcm7425,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 BCM7425,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const int pcie_offsets[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[RGR1_SW_INIT_1] =3D 0x9210,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[EXT_CFG_INDEX]=C2=A0 =3D 0x9000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[EXT_CFG_DATA]=C2=A0 =C2=A0=3D 0x9004,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct pcie_cfg_data bcm7435_cfg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.reg_field_info =3D pcie_reg_field_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.offsets=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D pcie_offs=
ets,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 BCM7435,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct pcie_cfg_data generic_cfg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.reg_field_info =3D pcie_reg_field_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.offsets=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D pcie_offs=
ets,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 GENERIC,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const int pcie_offset_bcm7278[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[RGR1_SW_INIT_1] =3D 0xc010,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[EXT_CFG_INDEX] =3D 0x9000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[EXT_CFG_DATA] =3D 0x9004,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct pcie_cfg_data bcm7278_cfg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.reg_field_info =3D pcie_reg_field_info_bcm7278,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0.offsets=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D pcie_offs=
et_bcm7278,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=
 BCM7278,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned=
 int devfn,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int where);<=
br>
&gt; +<br>
&gt; +static struct pci_ops brcm_pcie_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.map_bus =3D brcm_pcie_map_conf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read =3D pci_generic_config_read,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.write =3D pci_generic_config_write,<br>
&gt; +};<br>
&gt; +<br>
&gt; +#if defined(CONFIG_MIPS)<br>
&gt; +/* Broadcom MIPs HW implicitly does the swapping if necessary */<br>
&gt; +#define bcm_readl(a)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__raw_readl(a)<=
br>
&gt; +#define bcm_writel(d, a)=C2=A0 =C2=A0 =C2=A0__raw_writel(d, a)<br>
&gt; +#define bcm_readw(a)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__raw_readw(a)<=
br>
&gt; +#define bcm_writew(d, a)=C2=A0 =C2=A0 =C2=A0__raw_writew(d, a)<br>
&gt; +#else<br>
&gt; +#define bcm_readl(a)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readl(a)<br>
&gt; +#define bcm_writel(d, a)=C2=A0 =C2=A0 =C2=A0writel(d, a)<br>
&gt; +#define bcm_readw(a)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readw(a)<br>
&gt; +#define bcm_writew(d, a)=C2=A0 =C2=A0 =C2=A0writew(d, a)<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * These macros are designed to sxtract/insert fields to host control=
ler&#39;s<br>
&gt; + * register set.<br>
<br>
</div></div>s/are designed to s/ e/=C2=A0 (I assume they actually *do* extr=
act/insert)<br>
<div><div class=3D"gmail-h5"><br>
&gt; + */<br>
&gt; +#define RD_FLD(base, reg, field) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rd_fld(base + reg, reg##_##field##_MASK, reg##_##=
field##_SHIFT)<br>
&gt; +#define WR_FLD(base, reg, field, val) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wr_fld(base + reg, reg##_##field##_MASK, reg##_##=
field##_SHIFT, val)<br>
&gt; +#define WR_FLD_RB(base, reg, field, val) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wr_fld_rb(base + reg, reg##_##field##_MASK, reg##=
_##field##_SHIFT, val)<br>
&gt; +#define WR_FLD_WITH_OFFSET(base, off, reg, field, val) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wr_fld(base + reg + off, reg##_##field##_MASK, \<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg##_##field##_SHIFT, val)=
<br>
&gt; +#define EXTRACT_FIELD(val, reg, field) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0((val &amp; reg##_##field##_MASK) &gt;&gt; reg##_=
##field##_SHIFT)<br>
&gt; +#define INSERT_FIELD(val, reg, field, field_val) \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0((val &amp; ~reg##_##field##_MASK) | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 (reg##_##field##_MASK &amp; (field_val &lt;&lt; =
reg##_##field##_SHIFT)))<br>
&gt; +<br>
&gt; +static struct list_head brcm_pcie =3D LIST_HEAD_INIT(brcm_pcie);<br>
&gt; +static phys_addr_t scb_size[BRCM_MAX_SCB];<br>
&gt; +static int num_memc;<br>
&gt; +static DEFINE_MUTEX(brcm_pcie_lock);<br>
&gt; +<br>
&gt; +static u32 rd_fld(void __iomem *p, u32 mask, int shift)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return (bcm_readl(p) &amp; mask) &gt;&gt; shift;<=
br>
&gt; +}<br>
&gt; +<br>
&gt; +static void wr_fld(void __iomem *p, u32 mask, int shift, u32 val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 reg =3D bcm_readl(p);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0reg =3D (reg &amp; ~mask) | ((val &lt;&lt; shift)=
 &amp; mask);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(reg, p);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void wr_fld_rb(void __iomem *p, u32 mask, int shift, u32 val)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wr_fld(p, mask, shift, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(void)bcm_readl(p);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const char *link_speed_to_str(int s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0switch (s) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;2.5&quot=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;5.0&quot=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0case 3:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;8.0&quot=
;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return &quot;???&quot;;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * The roundup_pow_of_two() from log2.h invokes<br>
&gt; + * __roundup_pow_of_two(unsigned long), but we really need a<br>
&gt; + * such a function to take a native u64 since unsigned long<br>
&gt; + * is 32 bits on some configurations.=C2=A0 So we provide this helper=
<br>
&gt; + * function below.<br>
&gt; + */<br>
&gt; +static u64 roundup_pow_of_two_64(u64 n)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 1ULL &lt;&lt; fls64(n - 1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * This is to convert the size of the inbound bar region to the<br>
&gt; + * non-liniear values of PCIE_X_MISC_RC_BAR[123]_<wbr>CONFIG_LO.SIZE<=
br>
<br>
</div></div>s/bar/BAR/=C2=A0 (This doesn&#39;t sound like a BAR in the PCI =
spec sense, but if<br>
that&#39;s what you call it, might as well spell it as the acronym)<br>
<br>
s/non-liniear/non-linear/<br>
<div><div class=3D"gmail-h5"><br>
&gt; + */<br>
&gt; +int encode_ibar_size(u64 size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int log2_in =3D ilog2(size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (log2_in &gt;=3D 12 &amp;&amp; log2_in &lt;=3D=
 15)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Covers 4KB to 32KB=
 (inclusive) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (log2_in - 12)=
 + 0x1c;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else if (log2_in &gt;=3D 16 &amp;&amp; log2_in &l=
t;=3D 37)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Covers 64KB to 32G=
B, (inclusive) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return log2_in - 15;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Something is awry so disable */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static u32 mdio_form_pkt(int port, int regad, int cmd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 pkt =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pkt |=3D (port &lt;&lt; MDIO_PORT_SHIFT) &amp; MD=
IO_PORT_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pkt |=3D (regad &lt;&lt; MDIO_REGAD_SHIFT) &amp; =
MDIO_REGAD_MASK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pkt |=3D (cmd &lt;&lt; MDIO_CMD_SHIFT) &amp; MDIO=
_CMD_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return pkt;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* negative return value indicates error */<br>
&gt; +static int mdio_read(void __iomem *base, u8 port, u8 regad)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int tries;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_RE=
AD),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base + PCIE_R=
C_DL_MDIO_ADDR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D bcm_readl(base + PCIE_RC_DL_MDIO_RD_DATA=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (tries =3D 0; !MDIO_RD_DONE(data) &amp;&amp; =
tries &lt; 10; tries++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D bcm_readl(ba=
se + PCIE_RC_DL_MDIO_RD_DATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return MDIO_RD_DONE(data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? (data &amp; MDIO_DA=
TA_MASK) &gt;&gt; MDIO_DATA_SHIFT<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: -EIO;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* negative return value indicates error */<br>
&gt; +static int mdio_write(void __iomem *base, u8 port, u8 regad, u16 wrda=
ta)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int tries;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(mdio_form_pkt(port, regad, MDIO_CMD_WR=
ITE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base + PCIE_R=
C_DL_MDIO_ADDR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_readl(base + PCIE_RC_DL_MDIO_ADDR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(MDIO_DATA_DONE_MASK | wrdata,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base + PCIE_R=
C_DL_MDIO_WR_DATA);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D bcm_readl(base + PCIE_RC_DL_MDIO_WR_DATA=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (tries =3D 0; !MDIO_WT_DONE(data) &amp;&amp; =
tries &lt; 10; tries++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udelay(10);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D bcm_readl(ba=
se + PCIE_RC_DL_MDIO_WR_DATA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return MDIO_WT_DONE(data) ? 0 : -EIO;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* configures device for ssc mode; negative return value indicates er=
ror */<br>
<br>
</div></div>I guess &quot;ssc&quot; means Spread Spectrum Clocking?=C2=A0 M=
aybe spell out the<br>
first occurrence and spell as acronym in English text?<br>
<div><div class=3D"gmail-h5"><br>
&gt; +static int set_ssc(void __iomem *base)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int tmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 wrdata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int pll, ssc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D mdio_write(base, MDIO_PORT0, SET_ADDR_OFF=
SET, SSC_REGS_ADDR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tmp &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D mdio_read(base, MDIO_PORT0, SSC_CNTL_OFFS=
ET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tmp &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wrdata =3D INSERT_FIELD(tmp, SSC_CNTL_OVRD, EN, 1=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0wrdata =3D INSERT_FIELD(wrdata, SSC_CNTL_OVRD, VA=
L, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D mdio_write(base, MDIO_PORT0, SSC_CNTL_OFF=
SET, wrdata);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tmp &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(1000, 2000);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D mdio_read(base, MDIO_PORT0, SSC_STATUS_OF=
FSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (tmp &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ssc =3D EXTRACT_FIELD(tmp, SSC_STATUS, SSC);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pll =3D EXTRACT_FIELD(tmp, SSC_STATUS, PLL_LOCK);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return (ssc &amp;&amp; pll) ? 0 : -EIO;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* limits operation to a specific generation (1, 2, or 3) */<br>
&gt; +static void set_gen(void __iomem *base, int gen)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 lnkcap =3D bcm_readl(base + BRCM_PCIE_CAP_REG=
S + PCI_EXP_LNKCAP);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 lnkctl2 =3D bcm_readw(base + BRCM_PCIE_CAP_RE=
GS + PCI_EXP_LNKCTL2);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0lnkcap =3D (lnkcap &amp; ~PCI_EXP_LNKCAP_SLS) | g=
en;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(lnkcap, base + BRCM_PCIE_CAP_REGS + PC=
I_EXP_LNKCAP);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0lnkctl2 =3D (lnkctl2 &amp; ~0xf) | gen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writew(lnkctl2, base + BRCM_PCIE_CAP_REGS + P=
CI_EXP_LNKCTL2);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void brcm_pcie_set_outbound_win(<wbr>struct brcm_pcie *pcie,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int win, =
phys_addr_t cpu_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_addr_t=C2=A0 p=
cie_addr, dma_addr_t size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base =3D pcie-&gt;base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0phys_addr_t cpu_addr_mb, limit_addr_mb;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Set the base of the pcie_addr window */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(lower_32_bits(pcie_<wbr>addr) + MMIO_E=
NDIAN,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base + PCIE_M=
ISC_CPU_2_PCIE_MEM_WIN0_<wbr>LO + (win * 8));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(upper_32_bits(pcie_<wbr>addr),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base + PCIE_M=
ISC_CPU_2_PCIE_MEM_WIN0_<wbr>HI + (win * 8));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cpu_addr_mb =3D cpu_addr &gt;&gt; 20;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0limit_addr_mb =3D (cpu_addr + size - 1) &gt;&gt; =
20;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Write the addr base low register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_WITH_OFFSET(base, (win * 4),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 BASE, cpu_addr_mb);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Write the addr limit low register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_WITH_OFFSET(base, (win * 4),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 LIMIT, limit_addr_mb);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pcie-&gt;type !=3D BCM7435 &amp;&amp; pcie-&g=
t;type !=3D BCM7425) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Write the cpu addr=
 high register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (u32)(cpu_add=
r_mb &gt;&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT_NUM_MASK_BITS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WR_FLD_WITH_OFFSET(ba=
se, (win * 8),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<w=
br>BASE_HI,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BASE, tmp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Write the cpu limi=
t high register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D (u32)(limit_a=
ddr_mb &gt;&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<wbr>BASE_LIMIT_NUM_MASK_BITS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WR_FLD_WITH_OFFSET(ba=
se, (win * 8),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_<w=
br>LIMIT_HI,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LIMIT, tmp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Configuration space read/write support */<br>
&gt; +static int cfg_index(int busnr, int devfn, int reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ((PCI_SLOT(devfn) &amp; 0x1f) &lt;&lt; PCI=
E_SLOT_SHIFT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| ((PCI_FUNC(devfn) &=
amp; 0x07) &lt;&lt; PCIE_FUNC_SHIFT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (busnr &lt;&lt; PCI=
E_BUSNUM_SHIFT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (reg &amp; ~3);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base =3D pcie-&gt;base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val =3D bcm_readl(base + PCIE_MISC_PCIE_STATU=
S);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return !!EXTRACT_FIELD(val, PCIE_MISC_PCIE_STATUS=
, PCIE_PORT);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool brcm_pcie_link_up(struct brcm_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base =3D pcie-&gt;base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 val =3D bcm_readl(base + PCIE_MISC_PCIE_STATU=
S);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 dla =3D EXTRACT_FIELD(val, PCIE_MISC_PCIE_STA=
TUS, PCIE_DL_ACTIVE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 plu =3D EXTRACT_FIELD(val, PCIE_MISC_PCIE_STA=
TUS, PCIE_PHYLINKUP);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return=C2=A0 (dla &amp;&amp; plu) ? true : false;=
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool brcm_pcie_valid_device(struct brcm_pcie *pcie, struct pci=
_bus *bus,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pci_is_root_bus(bus)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev &gt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If there is no lin=
k, then there is no device */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!brcm_pcie_link_u=
p(pcie))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
<br>
</div></div>This is racy, since the link can go down after you check but be=
fore<br>
you do the config access.=C2=A0 I assume your hardware can deal with a<br>
config access that targets a link that is down?<br>
<span class=3D"gmail-"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned=
 int devfn,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int where)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct brcm_pcie *pcie =3D bus-&gt;sysdata;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base =3D pcie-&gt;base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int idx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!brcm_pcie_valid_device(pcie, bus, PCI_SLOT(d=
evfn)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Accesses to the RC go right to the RC register=
s */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pci_is_root_bus(bus))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return base + where;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* For devices, write to the config space index r=
egister */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0idx =3D cfg_index(bus-&gt;number, devfn, where);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(idx, pcie-&gt;base + IDX_ADDR(pcie));<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0return base + DATA_ADDR(pcie) + (where &amp; 0x3)=
;<br>
<br>
</span>I guess this is protected by a higher-level config access lock?<br><=
/blockquote><div><br></div><div>All pci config space accessor functions -- =
pci_bus_{read,write}_{byte,word,dword}() -- use a spinlock (pci_lock).=C2=
=A0 These routines, covered by the spinlock, call pci_generic_{read,write}(=
), and those two functions call ops-&gt;map_bus(), aka our brcm_pcie_map_co=
nf().</div><div><br></div><div>Unless=C2=A0CONFIG_PCI_LOCKLESS_CONFIG is se=
t to &quot;y&quot;, which it is not.</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<div><div class=3D"gmail-h5"><br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void brcm_pcie_bridge_sw_init_set(<wbr>struct brcm_pcie=
 *pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0unsigned int val)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int shift =3D pcie-&gt;reg_field_info[RG=
R1_SW_<wbr>INIT_1_INIT_SHIFT];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 mask =3D=C2=A0 pcie-&gt;reg_field_info[RGR1_S=
W_<wbr>INIT_1_INIT_MASK];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pcie-&gt;type !=3D BCM7278) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wr_fld_rb(pcie-&gt;ba=
se + PCIE_RGR1_SW_INIT_1(pcie), mask, shift,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else if (of_machine_is_compatible(&quot;<wbr>br=
cm,bcm7278a0&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The two PCIe insta=
nces on 7278a0 are not even consistent with<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * respect to each ot=
her for internal offsets, here we offset<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * by 0x14000 + RGR1_=
SW_INIT_1&#39;s relative offset to account for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * that.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D pcie-&gt;i=
d ? 0x14010 : pcie-&gt;reg_offsets[RGR1_SW_<wbr>INIT_1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wr_fld_rb(pcie-&gt;ba=
se + offset, mask, shift, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wr_fld_rb(pcie-&gt;ba=
se + PCIE_RGR1_SW_INIT_1(pcie), mask, shift,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void brcm_pcie_perst_set(struct brcm_pcie *pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int val)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pcie-&gt;type !=3D BCM7278)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wr_fld_rb(pcie-&gt;ba=
se + PCIE_RGR1_SW_INIT_1(pcie),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0PCIE_RGR1_SW_INIT_1_PERST_<wbr>MASK,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0PCIE_RGR1_SW_INIT_1_PERST_<wbr>SHIFT, val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Assert =3D 0, de-a=
ssert =3D 1 on 7278 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WR_FLD_RB(pcie-&gt;ba=
se, PCIE_MISC_PCIE_CTRL, PCIE_PERSTB, !val);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int brcm_pcie_add_controller(<wbr>struct brcm_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;brcm_pcie_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_add_tail(&amp;pcie-&gt;list, &amp;brcm_pcie)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;brcm_pcie_lock);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void brcm_pcie_remove_controller(<wbr>struct brcm_pcie *pcie)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head *pos, *q;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct brcm_pcie *tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;brcm_pcie_lock);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_safe(pos, q, &amp;brcm_pcie) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp =3D list_entry(po=
s, struct brcm_pcie, list);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp =3D=3D pcie) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0list_del(pos);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (list_empty(&amp;brcm_pcie))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_memc =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;brcm_pcie_lock);<br>
<br>
</div></div>I&#39;m missing something.=C2=A0 I don&#39;t see that num_memc =
is ever set to<br>
anything *other* than zero.<br>
<br>
This pattern of keeping a list of controllers is highly unusual and<br>
needs some explanation.<br>
<div><div class=3D"gmail-h5"><br>
&gt; +}<br>
&gt; +<br>
&gt; +static int brcm_pcie_parse_request_of_<wbr>pci_ranges(struct brcm_pci=
e *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource_entry *win;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D of_pci_get_host_bridge_<wbr>resources(pci=
e-&gt;dn, 0, 0xff,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;pcie-&gt;resources, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pcie-&gt;dev,=
 &quot;failed to get host resources\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0resource_list_for_each_entry(<wbr>win, &amp;pcie-=
&gt;resources) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *pare=
nt, *res =3D win-&gt;res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t offset =3D=
 (dma_addr_t)win-&gt;offset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (resource_type(res=
) =3D=3D IORESOURCE_IO) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0parent =3D &amp;ioport_resource;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (resource_t=
ype(res) =3D=3D IORESOURCE_MEM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (pcie-&gt;num_out_wins &gt;=3D BRCM_NUM_PCIE_OUT_WINS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pcie-&gt;dev, &quot;too many out=
bound wins\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pcie-&gt;out_wins[pcie-&gt;num_out_<wbr>wins].cpu_addr<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (phys_addr_t)res-&gt;start;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pcie-&gt;out_wins[pcie-&gt;num_out_<wbr>wins].pcie_addr<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (dma_addr_t)(res-&gt;start<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - (phys_addr_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pcie-&gt;out_wins[pcie-&gt;num_out_<wbr>wins].size<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (dma_addr_t)(res-&gt;end - res-&gt;s=
tart + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pcie-&gt;num_out_wins++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0parent =3D &amp;iomem_resource;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D devm_request_=
resource(pcie-&gt;<wbr>dev, parent, res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(pcie-&gt;dev, &quot;failed to get res %pR\n&quot;, res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int brcm_pcie_setup(struct brcm_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base =3D pcie-&gt;base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int scb_size_val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u64 rc_bar2_size =3D 0, rc_bar2_offset =3D 0, tot=
al_mem_size =3D 0;<br>
<br>
</div></div>Unnecessary initializations (at least of rc_bar2_size, I didn&#=
39;t check<br>
the rest).<br>
<br>
Add<br>
<br>
=C2=A0 struct device *dev =3D pcie-&gt;dev;<br>
<br>
then use it below.<br>
<span class=3D"gmail-"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 tmp, burst;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i, j, ret, limit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u16 nlw, cls, lnksta;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool ssc_good =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* reset the bridge and the endpoint device */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field: PCIE_BRIDGE_SW_INIT =3D 1 */<br>
<br>
</span>Not sure what these &quot;field: ...&quot; comments mean.=C2=A0 Are =
they for some<br>
automated tool?=C2=A0 To a human, it looks like they repeat what the code<b=
r>
does.<br>
<div><div class=3D"gmail-h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0brcm_pcie_bridge_sw_init_set(<wbr>pcie, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field: PCIE_SW_PERST =3D 1, on 7278, we start =
de-asserted already */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pcie-&gt;type !=3D BCM7278)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brcm_pcie_perst_set(p=
cie, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(100, 200);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* take the bridge out of reset */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field: PCIE_BRIDGE_SW_INIT =3D 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0brcm_pcie_bridge_sw_init_set(<wbr>pcie, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_<wbr>DEB=
UG, SERDES_IDDQ, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* wait for serdes to be stable */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(100, 200);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Grab the PCIe hw revision number */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D bcm_readl(base + PCIE_MISC_REVISION);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;rev =3D EXTRACT_FIELD(tmp, PCIE_MISC_REV=
ISION, MAJMIN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_=
ACCESS_EN */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D INSERT_FIELD(0, PCIE_MISC_MISC_CTRL, SCB_=
ACCESS_EN, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, CF=
G_READ_UR_MODE, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0burst =3D (pcie-&gt;type =3D=3D GENERIC || pcie-&=
gt;type =3D=3D BCM7278)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? BURST_SIZE_512 : BU=
RST_SIZE_256;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, MA=
X_BURST_SIZE, burst);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(tmp, base + PCIE_MISC_MISC_CTRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Set up inbound memory view for the EP (called =
RC_BAR2,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * not to be confused with the BARs that are adve=
rtised by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the EP).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; num_memc; i++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total_mem_size +=3D s=
cb_size[i];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The PCIe host controller by design must set th=
e inbound<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * viewport to be a contiguous arrangement of all=
 of the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * system&#39;s memory.=C2=A0 In addition, its si=
ze mut be a power of<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * two.=C2=A0 To further complicate matters, the =
viewport must<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * start on a pcie-address that is aligned on a m=
ultiple of its<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * size.=C2=A0 If a portion of the viewport does =
not represent<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * system memory -- e.g. 3GB of memory requires a=
 4GB viewport<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * -- we can map the outbound memory in or after =
3GB and even<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * though the viewport will overlap the outbound =
memory the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * controller will know to send outbound memory d=
ownstream and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * everything else upstream.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc_bar2_size =3D roundup_pow_of_two_64(total_<wbr=
>mem_size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Set simple configuration based on memory sizes=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * only.=C2=A0 We always start the viewport at ad=
dress 0.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rc_bar2_offset =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D lower_32_bits(rc_bar2_offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0tmp =3D INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFI=
G_LO, SIZE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 encode_ibar_size(rc_bar2_size)<wbr>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_L=
O);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(upper_32_bits(rc_<wbr>bar2_offset),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 base + PCIE_M=
ISC_RC_BAR2_CONFIG_HI);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field: SCB0_SIZE, default =3D 0xf (1 GB) */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0scb_size_val =3D scb_size[0]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? ilog2(scb_size[0]) =
- 15 : 0xf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB0_SIZE, scb_=
size_val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field: SCB1_SIZE, default =3D 0xf (1 GB) */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (num_memc &gt; 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scb_size_val =3D scb_=
size[1]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0? ilog2(scb_size[1]) - 15 : 0xf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WR_FLD(base, PCIE_MIS=
C_MISC_CTRL, SCB1_SIZE, scb_size_val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field: SCB2_SIZE, default =3D 0xf (1 GB) */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (num_memc &gt; 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0scb_size_val =3D scb_=
size[2]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0? ilog2(scb_size[2]) - 15 : 0xf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WR_FLD(base, PCIE_MIS=
C_MISC_CTRL, SCB2_SIZE, scb_size_val);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* disable the PCIe-&gt;GISB memory window (RC_BA=
R1) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD(base, PCIE_MISC_RC_BAR1_CONFIG_LO, SIZE, 0=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* disable the PCIe-&gt;SCB memory window (RC_BAR=
3) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD(base, PCIE_MISC_RC_BAR3_CONFIG_LO, SIZE, 0=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pcie-&gt;suspended) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear any interrup=
ts we find on boot */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcm_writel(0xffffffff=
, base + PCIE_INTR2_CPU_BASE + CLR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void)bcm_readl(base =
+ PCIE_INTR2_CPU_BASE + CLR);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Mask all interrupts since we are not handling =
any yet */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE=
 + MASK_SET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0(void)bcm_readl(base + PCIE_INTR2_CPU_BASE + MASK=
_SET);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pcie-&gt;gen)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_gen(base, pcie-&g=
t;gen);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* take the EP device out of reset */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field: PCIE_SW_PERST =3D 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0brcm_pcie_perst_set(pcie, 0);<br>
<br>
</div></div>&lt;raises eyebrows&gt;=C2=A0 Take the *EP* out of reset?=C2=A0=
 The host controller<br>
driver shouldn&#39;t be touching an EP directly.=C2=A0 Maybe the comment<br=
>
doesn&#39;t match what the code actually does.<br>
<div><div class=3D"gmail-h5"><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Give the RC/EP time to wake up, before trying =
to configure RC.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Intermittently check status for link-up, up to=
 a total of 100ms<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * when we don&#39;t know if the device is there,=
 and up to 1000ms if<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * we do know the device is there.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0limit =3D pcie-&gt;suspended ? 1000 : 100;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 1, j =3D 0; j &lt; limit &amp;&amp; !b=
rcm_pcie_link_up(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 j +=3D i, i =3D i * 2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(i + j &gt; lim=
it ? limit - j : i);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!brcm_pcie_link_up(pcie)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(pcie-&gt;dev=
, &quot;link down\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!brcm_pcie_rc_mode(pcie)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pcie-&gt;dev,=
 &quot;PCIe misconfigured; is in EP mode\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; pcie-&gt;num_out_wins; i++)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brcm_pcie_set_outboun=
d_win(<wbr>pcie, i, pcie-&gt;out_wins[i].cpu_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie=
-&gt;out_wins[i].pcie_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pcie=
-&gt;out_wins[i].size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * For config space accesses on the RC, show the =
right class for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * a PCIe-PCIe bridge (the default setting is to =
be EP mode).<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_RC_CFG_PRIV1_ID_VAL3, CLASS_=
CODE, 0x060400);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pcie-&gt;ssc) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D set_ssc(base)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ssc_good =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(pcie-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed attempt to enter ssc mode\n=
&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0lnksta =3D bcm_readw(base + BRCM_PCIE_CAP_REGS + =
PCI_EXP_LNKSTA);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cls =3D lnksta &amp; PCI_EXP_LNKSTA_CLS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0nlw =3D (lnksta &amp; PCI_EXP_LNKSTA_NLW) &gt;&gt=
; PCI_EXP_LNKSTA_NLW_SHIFT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(pcie-&gt;dev, &quot;link up, %s Gbps x%u=
 %s\n&quot;, link_speed_to_str(cls),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nlw, ssc_good ? &quo=
t;(SSC)&quot; : &quot;(!SSC)&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* PCIe-&gt;SCB endian mode for BAR */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* field ENDIAN_MODE_BAR2 =3D DATA_ENDIAN */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_RC_CFG_VENDOR_VENDOR_<wbr>SP=
ECIFIC_REG1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ENDIAN_MODE_BA=
R2, DATA_ENDIAN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Refclk from RC should be gated with CLKREQ# in=
put when ASPM L0s,L1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * is enabled =3D&gt;=C2=A0 setting the CLKREQ_DE=
BUG_ENABLE field to 1.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_<wbr>DEB=
UG, CLKREQ_DEBUG_ENABLE, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void enter_l23(struct brcm_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base =3D pcie-&gt;base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int tries, l23;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* assert request for L23 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQ=
UEST, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* poll L23 status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (tries =3D 0, l23 =3D 0; tries &lt; 1000 &amp=
;&amp; !l23; tries++)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l23 =3D RD_FLD(base, =
PCIE_MISC_PCIE_STATUS, PCIE_LINK_IN_L23);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!l23)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pcie-&gt;dev,=
 &quot;failed to enter L23\n&quot;);<br>
<br>
</div></div>What does &quot;L23&quot; mean?=C2=A0 Some power management thi=
ng?<br>
<div><div class=3D"gmail-h5"><br>
&gt; +}<br>
&gt; +<br>
&gt; +static void turn_off(struct brcm_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base =3D pcie-&gt;base;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (brcm_pcie_link_up(pcie))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enter_l23(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Reset endpoint device */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0brcm_pcie_perst_set(pcie, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* deassert request for L23 in case it was assert=
ed */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_MISC_PCIE_CTRL, PCIE_L23_REQ=
UEST, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* SERDES_IDDQ =3D 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_<wbr>DEB=
UG, SERDES_IDDQ, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Shutdown PCIe bridge */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0brcm_pcie_bridge_sw_init_set(<wbr>pcie, 1);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int brcm_pcie_suspend(struct device *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct brcm_pcie *pcie =3D dev_get_drvdata(dev);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0turn_off(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(pcie-&gt;<wbr>clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;suspended =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int brcm_pcie_resume(struct device *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct brcm_pcie *pcie =3D dev_get_drvdata(dev);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0base =3D pcie-&gt;base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_prepare_enable(pcie-&gt;clk);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Take bridge out of reset so we can access the =
SERDES reg */<br>
<br>
</div></div>Some comments above and below spell it &quot;serdes&quot;; here=
 you spell it<br>
&quot;SERDES&quot;.<br>
<div><div class=3D"gmail-h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0brcm_pcie_bridge_sw_init_set(<wbr>pcie, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* SERDES_IDDQ =3D 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_<wbr>DEB=
UG, SERDES_IDDQ, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* wait for serdes to be stable */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0usleep_range(100, 200);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D brcm_pcie_setup(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;suspended =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void _brcm_pcie_remove(struct brcm_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0turn_off(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(pcie-&gt;<wbr>clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0clk_put(pcie-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0brcm_pcie_remove_controller(<wbr>pcie);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int brcm_pcie_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct brcm_pcie *pcie =3D platform_get_drvdata(p=
dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_stop_root_bus(pcie-&gt;root_<wbr>bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_remove_root_bus(pcie-&gt;<wbr>root_bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_brcm_pcie_remove(pcie);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct of_device_id brcm_pcie_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;brcm,bcm7425-pcie&quot;, =
.data =3D &amp;bcm7425_cfg },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;brcm,bcm7435-pcie&quot;, =
.data =3D &amp;bcm7435_cfg },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;brcm,bcm7278-pcie&quot;, =
.data =3D &amp;bcm7278_cfg },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;brcm,bcm7445-pcie&quot;, =
.data =3D &amp;generic_cfg },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{},<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(of, brcm_pcie_match);<br>
&gt; +<br>
&gt; +static int brcm_pcie_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device_node *dn =3D pdev-&gt;dev.of_node;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct of_device_id *of_id;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct pcie_cfg_data *data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct brcm_pcie *pcie;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *base;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct pci_host_bridge *bridge;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct pci_bus *child;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bridge =3D devm_pci_alloc_host_bridge(&amp;<wbr>p=
dev-&gt;dev, sizeof(*pcie));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!bridge)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie =3D pci_host_bridge_priv(bridge);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&amp;pcie-&gt;<wbr>resources);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0of_id =3D of_match_node(brcm_pcie_match, dn);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!of_id) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;failed to look up compatible string\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (of_property_read_u32(dn, &quot;dma-ranges&quo=
t;, &amp;tmp) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;cannot yet handle dma-ranges\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D of_id-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;reg_offsets =3D data-&gt;offsets;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;reg_field_info =3D data-&gt;reg_field_in=
fo;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;type =3D data-&gt;type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;dn =3D dn;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;dev =3D &amp;pdev-&gt;dev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;id =3D of_get_pci_domain_nr(dn);<br>
<br>
</div></div>Why do you call of_get_pci_domain_nr() directly?=C2=A0 No other=
 driver<br>
does.<br>
<div><div class=3D"gmail-h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pcie-&gt;id &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pcie-&gt;id;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESOURCE_ME=
M, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!res)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0base =3D devm_ioremap_resource(&amp;pdev-&gt;<wbr=
>dev, res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(base))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(base);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;clk =3D of_clk_get_by_name(dn, &quot;sw_=
pcie&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pcie-&gt;clk)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;could not get clock\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;clk =3D NULL=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;base =3D base;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D of_pci_get_max_link_speed(dn);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;gen =3D (ret &lt; 0) ? 0 : ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;ssc =3D of_property_read_bool(dn, &quot;=
brcm,enable-ssc&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D irq_of_parse_and_map(pdev-&gt;<wbr>dev.of=
_node, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* keep going, as we =
don&#39;t use this intr yet */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_warn(pcie-&gt;dev=
, &quot;cannot get pcie interrupt\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;irq =3D ret;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D brcm_pcie_parse_request_of_<wbr>pci_range=
s(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(pcie-&gt;clk);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;could not enable clock\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D brcm_pcie_add_controller(pcie)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D brcm_pcie_setup(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_splice_init(&amp;pcie-&gt;<wbr>resources, &a=
mp;bridge-&gt;windows);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bridge-&gt;dev.parent =3D &amp;pdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bridge-&gt;busnr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bridge-&gt;ops =3D &amp;brcm_pcie_ops;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bridge-&gt;sysdata =3D pcie;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bridge-&gt;map_irq =3D of_irq_parse_and_map_pci;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0bridge-&gt;swizzle_irq =3D pci_common_swizzle;<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D pci_scan_root_bus_bridge(<wbr>bridge);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(pcie-&gt;dev,=
 &quot;Scanning root bridge failed&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_assign_unassigned_bus_<wbr>resources(bridge-&=
gt;bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(child, &amp;bridge-&gt;bus-&g=
t;children, node)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_bus_configure_se=
ttings(<wbr>child);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_bus_add_devices(bridge-&gt;<wbr>bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;root_bus =3D bridge-&gt;bus;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0_brcm_pcie_remove(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct dev_pm_ops brcm_pcie_pm_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.suspend_noirq =3D brcm_pcie_suspend,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.resume_noirq =3D brcm_pcie_resume,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct platform_driver __refdata brcm_pcie_driver =3D {<br>
<br>
</div></div>Why do you need __refdata?=C2=A0 There&#39;s only only other oc=
currence in<br>
drivers/pci, and I&#39;m dubious about that one as well.<br>
<span class=3D"gmail-"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe =3D brcm_pcie_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.remove =3D brcm_pcie_remove,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;brcm-=
pcie&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODUL=
E,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.of_match_table =3D b=
rcm_pcie_match,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pm =3D &amp;brcm_pci=
e_pm_ops,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +<br>
&gt; +module_platform_driver(brcm_<wbr>pcie_driver);<br>
&gt; +<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
<br>
</span>Copyright notice above says &quot;GPL v2&quot;, which is not the sam=
e as the<br>
&quot;GPL&quot; here.<br>
<span class=3D"gmail-"><br>
&gt; +MODULE_DESCRIPTION(&quot;Broadcom STB PCIE RC driver&quot;);<br>
&gt; +MODULE_AUTHOR(&quot;Broadcom&quot;);<br>
&gt; --<br>
&gt; 1.9.0.138.g2de3478<br>
&gt;<br>
&gt;<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; linux-arm-kernel mailing list<br>
&gt; <a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-kern=
el@lists.<wbr>infradead.org</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l" rel=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mai=
lman/listinfo/linux-arm-<wbr>kernel</a><br>
</blockquote></div><br></div></div>

--94eb2c1dffd8150aa8056052c206--
