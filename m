Return-Path: <SRS0=ilPo=CT=mobiveil.co.in=l.subrahmanya@kernel.org>
Return-Path: <SRS0=ilPo=CT=mobiveil.co.in=l.subrahmanya@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171120205812.GB16362@bhelgaas-glaptop.roam.corp.google.com>
References: <e330e812-a6a1-1f72-393a-9610f334dba6@mobiveil.co.in> <20171120205812.GB16362@bhelgaas-glaptop.roam.corp.google.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Tue, 21 Nov 2017 10:55:02 +0530
Message-ID: <CAFZiPx0A7AzK=E4EJo+FvsTV_y7g01Sn9OibjFtgN=sTUnWpew@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mingkai Hu <mingkai.hu@nxp.com>, Peter W Newton <peter.newton@nxp.com>,
	"M.h. Lian" <minghuan.lian@nxp.com>, Raj Raina <rajesh.raina@nxp.com>,
	Rajan Kapoor <rajan.kapoor@nxp.com>, Prabhjot Singh <prabhjot.singh@nxp.com>
Content-Type: multipart/alternative; boundary="f403045f5352ca4050055e776c3a"
List-ID: <linux-pci.vger.kernel.org>

--f403045f5352ca4050055e776c3a
Content-Type: text/plain; charset="UTF-8"

Bjorn,
My apologies.
I will fix them and re submit.

thanks,

On Tue, Nov 21, 2017 at 2:28 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> This patch doesn't apply cleanly:
>
>   $ stg branch --create pci/host-mobiveil pci-v4.15-changes
>   $ stg import -M m/subrahmanya
>   Importing patch "pci-mobiveil-add-mobiveil-pcie" ... error: corrupt
> patch at line 108
>   stg import: Diff does not apply cleanly
>
> I think it's line wrapped.  Please fix your mailer so it doesn't
> insert extra newlines in the patch.
>
> On Fri, Nov 17, 2017 at 06:21:25PM +0530, subrahmanya_lingappa wrote:
> > From 6a514d9da7e58a2b9e98fa60a97d4b1bcbaeef02 Mon Sep 17 00:00:00 2001
> > From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > Date: Thu, 16 Nov 2017 23:56:10 -0500
> > Subject: [PATCH v3] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP
> driver
>
> s/PCI: Mobiveil/PCI: mobiveil/  (Driver names are all lower-case by
> convention)
>
> > This is the driver for Mobiveil  AXI PCIe Host Bridge Soft IP
>
> s/  / /  (Remove extra space)
>
> >
> > Cc: bhelgaas@google.com
> >
> > v3 patch fixes:
> > - spell checks
> > - removed superfluous comments and headers
> > - added COMPILE_TEST to Kconfig
> > - removed spurious blank lines
> > - removed unused functions
> > - removed unused macro definitions
> > - comments alignment
> > - multi-line comment styles
> > - removed bogus code from isr
> > - made public functions static
> > - made small functions inline
> > - removed unnecessary functions replaced them inline
> > - added irq_dispose_mapping() while  MSI tearing down
> > - used upper_32_bits/lower_32_bits for bits extraction
> > - removed mobiveil_pcie_remove and the children
> > - removed superfluous printks
> > - replaced printk with dev_info
> > - replaced mobiveil_pcie_powerup_slot with mobiveil_pcie_establish_link
> >   like other similar drivers
> > - pci_scan_root_bus_bridge was not used to replace as testing branch is
> >   4.9 version.
> > - MODULE_LICENSE is fixed to "GPL v2" to align with file header
> > - removed hard-coded inbound and out bound window parameters,
> >   now read from device tree.
> >
> > Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > ---
> >  .../devicetree/bindings/pci/mobiveil-pcie.txt      |  68 ++
> >  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >  MAINTAINERS                                        |   7 +
> >  drivers/pci/host/Kconfig                           |   9 +
> >  drivers/pci/host/Makefile                          |   1 +
> >  drivers/pci/host/pcie-mobiveil.c                   | 899
> > +++++++++++++++++++++
> >  6 files changed, 985 insertions(+)
> >  create mode 100644 Documentation/devicetree/
> bindings/pci/mobiveil-pcie.txt
> >  create mode 100644 drivers/pci/host/pcie-mobiveil.c
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > new file mode 100644
> > index 0000000..c9e9818
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > @@ -0,0 +1,68 @@
> > +* Mobiveil AXI PCIe Root Port Bridge DT description
> > +
> > +Required properties:
> > +- #address-cells: Address representation for root ports, set to <3>
> > +- #size-cells: Size representation for root ports, set to <2>
> > +- #interrupt-cells: specifies the number of cells needed to encode an
> > +     interrupt source. The value must be 1.
> > +- compatible: Should contain "mbvl,axi-pcie-host-1.00"
> > +- reg: Should contain AXI PCIe registers location and length
> > +- device_type: must be "pci"
> > +- apio-wins : number of configured apio outbound windows
> > +- ppio-wins : number of configured ppio inbound windows
> > +- interrupts: Should contain AXI PCIe interrupt
> > +- interrupt-map-mask,
> > +     interrupt-map: standard PCI properties to define the mapping of the
> > +     PCI interface to interrupt numbers.
> > +- ranges: ranges for the PCI memory regions (I/O space region is not
> > +     supported by hardware)
> > +     Please refer to the standard PCI bus binding document for a more
> > +     detailed explanation
> > +
> > +- bus-range: PCI bus numbers covered
> > +
> > +Interrupt controller child node
> > ++++++++++++++++++++++++++++++++
> > +Required properties:
> > +- interrupt-controller: identifies the node as an interrupt controller
> > +- #address-cells: specifies the number of cells needed to encode an
> > +     address. The value must be 0.
> > +- #interrupt-cells: specifies the number of cells needed to encode an
> > +     interrupt source. The value must be 1.
> > +
> > +NOTE:
> > +The core provides a single interrupt for both INTx/MSI messages. So,
> > +created a interrupt controller node to support 'interrupt-map' DT
> > +functionality.  The driver will create an IRQ domain for this map,
> decode
> > +the four INTx interrupts in ISR and route them to this domain.
> > +
> > +Example:
> > +++++++++
> > +     pci_express: axi-pcie@a0000000 {
> > +             #address-cells = <3>;
> > +             #size-cells = <2>;
> > +             #interrupt-cells = <1>;
> > +             compatible = "mbvl,axi-pcie-host-1.00";
> > +             reg =   < 0xa0000000 0x00001000 >,
> > +                     < 0xb0000000 0x00010000 >,
> > +                     < 0xFF000000 0x00200000 >,
> > +                     < 0xb0010000 0x00001000 >;
>
> You lined things up in a table, which is good.  Also remove the extra
> spaces inside the "< ... >", as in interrupt-map below.  And use
> lower-case consistently in your hex constants instead of mixing upper-
> and lower-case.
>
> > +             reg-names =     "config_axi_slave",
> > +                             "csr_axi_slave",
> > +                             "gpio_slave",
> > +                             "apb_csr";
> > +
> > +             device_type = "pci";
> > +             apio-wins = <3>;
> > +             ppio-wins = <3>;
> > +             interrupt-parent = <&gic>;
> > +             interrupts = < 0 89 4 >;
> > +             interrupt-controller;
> > +             interrupt-map-mask = <0 0 0 7>;
> > +             interrupt-map = <0 0 0 1 &pci_express 1>,
> > +                             <0 0 0 2 &pci_express 2>,
> > +                             <0 0 0 3 &pci_express 3>,
> > +                             <0 0 0 4 &pci_express 4>;
> > +             ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
> > +
> > +     };
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index f0a48ea..be61439 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -179,6 +179,7 @@ msi       Micro-Star International Co. Ltd.
> >  mti  Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
> >  mundoreader  Mundo Reader S.L.
> >  murata       Murata Manufacturing Co., Ltd.
> > +mbvl Mobiveil Inc.
>
> Use a tab (not a space) after "mbvl", like the other entries.
>
> >  mxicy        Macronix International Co., Ltd.
> >  national     National Semiconductor
> >  nec  NEC LCD Technologies, Ltd.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 63cefa6..d7dc6c3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9336,6 +9336,13 @@ F:
> > Documentation/devicetree/bindings/pci/host-generic-pci.txt
> >  F:   drivers/pci/host/pci-host-common.c
> >  F:   drivers/pci/host/pci-host-generic.c
> >
> > +PCI DRIVER FOR MOBIVEIL PCIE IP
> > +M:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > +L:   linux-pci@vger.kernel.org
> > +S:   Supported
> > +F:   Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> > +F:   drivers/pci/host/pcie-mobiveil.c
> > +
> >  PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
> >  M:   Keith Busch <keith.busch@intel.com>
> >  L:   linux-pci@vger.kernel.org
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> > index 6f1de4f..d8fb02d 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -37,6 +37,14 @@ config PCIE_XILINX_NWL
> >        or End Point. The current option selection will only
> >        support root port enabling.
> >
> > +config PCIE_MOBIVEIL
> > +     bool "Mobiveil AXI PCIe host bridge support"
> > +     depends on ARCH_ZYNQMP || COMPILE_TEST
> > +     depends on PCI_MSI_IRQ_DOMAIN
> > +     help
> > +       Say 'Y' here if you want kernel to support the Mobiveil AXI PCIe
> > +       Host Bridge driver.
> > +
> >  config PCIE_DW_PLAT
> >       bool "Platform bus based DesignWare PCIe Controller"
> >       depends on PCI_MSI_IRQ_DOMAIN
> > @@ -103,6 +111,7 @@ config PCI_HOST_GENERIC
> >         Say Y here if you want to support a simple generic PCI host
> >         controller, such as the one emulated by kvmtool.
> >
> > +
>
> Remove this spurious diff.
>
> Darn it, I mentioned most of these things the first time around.
>
> >  config PCIE_SPEAR13XX
> >       bool "STMicroelectronics SPEAr PCIe controller"
> >       depends on ARCH_SPEAR13XX
> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > index 9b113c2..d851978 100644
> > --- a/drivers/pci/host/Makefile
> > +++ b/drivers/pci/host/Makefile
> > @@ -34,3 +34,4 @@ obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> >  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> >  obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
> >  obj-$(CONFIG_VMD) += vmd.o
> > +obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
> > diff --git a/drivers/pci/host/pcie-mobiveil.c
> > b/drivers/pci/host/pcie-mobiveil.c
> > new file mode 100644
> > index 0000000..abc6adf
> > --- /dev/null
> > +++ b/drivers/pci/host/pcie-mobiveil.c
> > @@ -0,0 +1,899 @@
> > +/*
> > + * PCIe host controller driver for Mobiveil PCIe Host controller
> > + *
> > + * Copyright Mobiveil Corporation (C) 2013-2017. All rights reserved
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for
>
> Line wrapped; I pointed this out the first time, too.
>
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public
> > License along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irqchip/chained_irq.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/irq.h>
> > +#include <linux/msi.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/kernel.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/init.h>
> > +#include <linux/of_platform.h>
> > +
> > +/* Register Offsets and Bit Positions*/
>
> Add space before "*/" (also mentioned first time).
>
> > +#define WIN_NUM_0            0
> > +#define WIN_NUM_1            1
> > +
> > +#define CFG_WINDOW_TYPE      0
> > +#define IO_WINDOW_TYPE               1
> > +#define MEM_WINDOW_TYPE      2
> > +#define MAX_PIO_WINDOWS      8
> > +
> > +#define PAB_INTA_POS         5
> > +#define OP_READ              0
> > +#define OP_WRITE             1
> > +
> > +#define IB_WIN_SIZE_KB               (256*1024*1024)
> > +
> > +#define LTSSM_STATE_STATUS   0x0404
> > +#define LTSSM_STATUS_CODE_MASK  0x3F
> > +#define LTSSM_STATUS_CODE    0x2D    /* LTSSM Status Code L0 */
>
> You ignored this comment from the first time:
>
>   This name (LTSSM_STATUS_CODE) is not very descriptive.  Presumably
>   there are *other* status codes, too, so this should be something like
>   LTSSM_STATUS_L0.
>
> > +#define PAB_CTRL             0x0808
> > +#define  AMBA_PIO_ENABLE_SHIFT 0
> > +#define  PEX_PIO_ENABLE_SHIFT        1
> > +#define  PAGE_SEL_SHIFT      13
> > +#define  PAGE_SEL_MASK               0x3f
>
> Some of your hex constants use lower-case, others upper-case.  Pick
> one and use it consistently.
>
> > +#define  PAGE_SEL_OFFSET_SHIFT       10
> > +
> > +#define PAB_AXI_PIO_CTRL     0x0840
> > +#define  APIO_EN_MASK                0xf
> > +
> > +#define PAB_PEX_PIO_CTRL     0x08C0
> > +#define  PIO_ENABLE_SHIFT    0
> > +#define PAB_INTP_AMBA_MISC_ENB 0x0B0C
> > +#define PAB_INTP_AMBA_MISC_STAT 0x0B1C
> > +#define  PAB_INTP_INTX_MASK    0x1E0 /* INTx(A-D) */
> > +#define  PAB_INTP_MSI_MASK   0x8
> > +
> > +#define PAB_AXI_AMAP_CTRL(win_num)   (0x0BA0 + (0x10*win_num))
> > +#define  WIN_ENABLE_SHIFT            0
> > +#define  WIN_TYPE_SHIFT              1
> > +#define  WIN_SIZE_SHIFT              10
> > +#define PAB_EXT_AXI_AMAP_SIZE(win_num)  (0xBAF0 + (0x4*win_num))
> > +
> > +#define PAB_AXI_AMAP_AXI_WIN(win_num)        (0x0BA4 + (0x10*win_num))
> > +#define  AXI_WINDOW_BASE_SHIFT    2
> > +
> > +#define PAB_AXI_AMAP_PEX_WIN_L(win_num)     (0x0BA8 + (0x10*win_num))
> > +#define  PAB_BUS_SHIFT               24
> > +#define  PAB_DEVICE_SHIFT    19
> > +#define  PAB_FUNCTION_SHIFT  16
> > +
> > +#define PAB_AXI_AMAP_PEX_WIN_H(win_num) (0x0BAC + (0x10*win_num))
> > +#define PAB_INTP_AXI_PIO_CLASS       0x474
> > +
> > +#define PAB_PEX_AMAP_CTRL(win_num)   (0x4BA0 + (0x10*win_num))
> > +#define AMAP_CTRL_EN_SHIFT           0
> > +#define AMAP_CTRL_TYPE_SHIFT         1       /* 0: interrupt, 2: memory
> */
> > +
> > +#define PAB_EXT_PEX_AMAP_SIZEN(win_num) (0xBEF0 + (0x4*win_num))
> > +#define PAB_PEX_AMAP_AXI_WIN(win_num)   (0x4BA4 + (0x10*win_num))
> > +#define PAB_PEX_AMAP_PEX_WIN_L(win_num) (0x4BA8 + (0x10*win_num))
> > +#define PAB_PEX_AMAP_PEX_WIN_H(win_num) (0x4BAC + (0x10*win_num))
> > +
> > +#define PCI_NUM_INTX         4
> > +#define PCI_NUM_MSI          16
> > +
> > +#define MSI_BASE_LO_OFFSET   0x04
> > +#define MSI_BASE_HI_OFFSET   0x08
> > +#define MSI_SIZE_OFFSET      0x0c
> > +#define MSI_ENABLE_OFFSET    0x14
> > +#define MSI_ENABLE_SHIFT     0
> > +#define MSI_STATUS_OFFSET    0x18
> > +#define MSI_STATUS_SHIFT     0
> > +#define MSI_OCCUPANCY_OFFSET    0x1c
> > +#define MSI_DATA_OFFSET      0x20
> > +#define MSI_ADDR_L_OFFSET    0x24
> > +#define MSI_ADDR_H_OFFSET    0x28
> > +#define ilog2_u32(num) (__ffs(num)-1)
> > +
> > +/*
> > + * PCIe port information
> > + */
> > +struct mobiveil_pcie {
> > +     struct platform_device *pdev;
> > +     void __iomem *config_axi_slave_base;    /* endpoint config base */
> > +     void __iomem *csr_axi_slave_base;       /* root port config base */
> > +     void __iomem *gpio_slave_base;  /* GPIO register base */
> > +     void __iomem *apb_csr_base;     /* MSI register base */
> > +     struct irq_domain *irq_domain;
> > +     struct resource bus_range;
> > +     struct list_head resources;
> > +     int *msi_pages;
> > +     int *msi_pages_phys;
> > +     char root_bus_nr;
> > +     int irq;
> > +     int apio_wins;
> > +     int ppio_wins;
> > +     int ob_wins_configured; /*  configured outbound windows */
> > +     int ib_wins_configured; /*  configured inbound windows */
> > +     struct resource *ob_io_res;
> > +     struct resource *ob_mem_res[3];
> > +};
> > +
> > +static DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
> > +
> > +static inline void csr_writel(struct mobiveil_pcie *pcie,
> > +                     const unsigned int value, const unsigned int reg)
> > +{
> > +     writel_relaxed(value, pcie->csr_axi_slave_base + reg);
> > +}
> > +
> > +static inline unsigned int csr_readl(struct mobiveil_pcie *pcie,
> > +                     const unsigned int reg)
> > +{
> > +     return readl_relaxed(pcie->csr_axi_slave_base + reg);
> > +}
> > +
> > +static inline int gpio_read(struct mobiveil_pcie *pcie, int addr)
> > +{
> > +     return ioread32(pcie->gpio_slave_base + addr);
> > +}
> > +
> > +static inline void gpio_write(struct mobiveil_pcie *pcie, int val,
> > int addr)
> > +{
> > +     iowrite32(val, pcie->gpio_slave_base + addr);
> > +     if (val != gpio_read(pcie, addr)) {
> > +             dev_info(&pcie->pdev->dev,
> > +                      "WARNING:gpio_write: expected : %x at: %x, found:
> %x\n ",
> > +                      val, addr, gpio_read(pcie, addr));
> > +     }
> > +}
> > +
> > +static bool mobiveil_pcie_link_is_up(struct mobiveil_pcie *pcie)
>
> I already pointed this out:
>
>   Rename to mobiveil_pcie_link_up().  The altera and xilinx drivers are
>   the oddballs here and should be renamed.  All the others use
>   .*_pcie_link_up().
>
> I'm going to stop here because while you did fix a few things, there
> was a lot of other feedback that you haven't addressed yet.  It's a
> waste of your reviewers' time if you don't pay attention to what they
> write.
>
> > +{
> > +     return (csr_readl(pcie, LTSSM_STATE_STATUS) &
> > +             LTSSM_STATUS_CODE_MASK) == LTSSM_STATUS_CODE;
> > +}
> > +
> > +static bool mobiveil_pcie_valid_device(struct pci_bus *bus,
> > unsigned int devfn)
> > +{
> > +     struct mobiveil_pcie *pcie = bus->sysdata;
> > +
> > +     /* Check if link is up when trying to access downstream ports */
> > +     if (bus->number != pcie->root_bus_nr)
> > +             if (!mobiveil_pcie_link_is_up(pcie))
> > +                     return false;
> > +
> > +     /* Only one device down on each root port */
> > +     if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
> > +             return false;
> > +
> > +     /*
> > +      * Do not read more than one device on the bus directly
> > +      * attached to RC
> > +      */
> > +     if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * mobiveil_pcie_map_bus - routine to get the configuration base of
> either
> > + * root port or endpoint
> > + *
> > + * Relies on pci_lock serialization
> > + */
> > +static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
> > +                                        unsigned int devfn, int where)
> > +{
> > +     struct mobiveil_pcie *pcie = bus->sysdata;
> > +     unsigned int value;
> > +
> > +     if (!mobiveil_pcie_valid_device(bus, devfn))
> > +             return NULL;
> > +
> > +     if (bus->number == pcie->root_bus_nr) {
> > +             /* RC config access (in CSR space) */
> > +             return pcie->csr_axi_slave_base + where;
> > +     } else {
> > +             /*
> > +              * EP config access (in Config/APIO space)
> > +              * Program PEX Address base (31..16 bits) with appropriate
> value
> > +              * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register.
> > +              */
> > +
> > +             /* Relies on pci_lock serialization */
> > +             value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_L(0));
> > +             csr_writel(pcie,
> > +                     bus->number << PAB_BUS_SHIFT |
> > +                     (devfn >> 3) << PAB_DEVICE_SHIFT |
> > +                     (devfn & 7) << PAB_FUNCTION_SHIFT,
> > +                     PAB_AXI_AMAP_PEX_WIN_L(0));
> > +             return pcie->config_axi_slave_base + where;
> > +     }
> > +}
> > +
> > +static struct pci_ops mobiveil_pcie_ops = {
> > +     .map_bus = mobiveil_pcie_map_bus,
> > +     .read = pci_generic_config_read,
> > +     .write = pci_generic_config_write,
> > +};
> > +
> > +static irqreturn_t mobiveil_pcie_isr(int irq, void *data)
> > +{
> > +     struct mobiveil_pcie *pcie = (struct mobiveil_pcie *)data;
> > +     unsigned int fifo_occ;
> > +     unsigned int msi_addr_l, msi_addr_h, msi_data;
> > +     unsigned int status, status2;
> > +     unsigned long shifted_status;
> > +     unsigned int bit1 = 0, virq;
> > +     unsigned int val, mask;
> > +
> > +     /*
> > +      * The core provides a single interrupt for both INTx/MSI messages.
> > +      * So we'll read both INTx and MSI statuses
> > +      */
> > +
> > +     /* read INTx status */
> > +     val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> > +     mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
> > +     status = val & mask;
> > +
> > +     /* Handle INTx */
> > +     if (status & PAB_INTP_INTX_MASK) {
> > +             while ((shifted_status =
> > +                     (csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
> > +                      PAB_INTA_POS)) != 0) {
> > +                     for_each_set_bit(bit1, &shifted_status,
> PCI_NUM_INTX) {
> > +                             /* clear interrupts */
> > +                             csr_writel(pcie, shifted_status <<
> PAB_INTA_POS,
> > +                                        PAB_INTP_AMBA_MISC_STAT);
> > +
> > +                             virq =
> > +                                 irq_find_mapping(pcie->irq_domain,
> > +                                                  bit1 + 1);
> > +                             if (virq)
> > +                                     generic_handle_irq(virq);
> > +                             else
> > +                                     dev_err(&pcie->pdev->dev,
> > +                                             "unexpected IRQ, INT%d\n",
> > +                                             bit1);
> > +
> > +                     }
> > +                     shifted_status = 0;
> > +             }
> > +     }
> > +
> > +     /* read MSI status */
> > +     status2 = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);
> > +
> > +     /* handle MSI interrupts */
> > +     if ((status & PAB_INTP_MSI_MASK)
> > +         || (status2 & (1 << MSI_STATUS_SHIFT))) {
> > +             do {
> > +                     fifo_occ = readl(pcie->apb_csr_base
> > +                                      + MSI_OCCUPANCY_OFFSET);
> > +                     msi_data = readl(pcie->apb_csr_base +
> MSI_DATA_OFFSET);
> > +                     msi_addr_l = readl(pcie->apb_csr_base
> > +                                        + MSI_ADDR_L_OFFSET);
> > +                     msi_addr_h = readl(pcie->apb_csr_base
> > +                                        + MSI_ADDR_H_OFFSET);
> > +                     /* Handle MSI */
> > +                     if (msi_data)
> > +                             generic_handle_irq(msi_data);
> > +                     else
> > +                             dev_err(&pcie->pdev->dev, "MSI data
> null\n");
> > +
> > +                     status2 = readl(pcie->apb_csr_base +
> MSI_STATUS_OFFSET);
> > +             } while ((status2 & (1 << MSI_STATUS_SHIFT)));
> > +     }
> > +
> > +     csr_writel(pcie, status, PAB_INTP_AMBA_MISC_STAT);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/* routine to parse device tree */
> > +static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
> > +{
> > +     struct device *dev = &pcie->pdev->dev;
> > +     struct platform_device *pdev = pcie->pdev;
> > +     struct device_node *node = dev->of_node;
> > +     resource_size_t iobase;
> > +     struct resource *res;
> > +     const char *type;
> > +     int err;
> > +
> > +     type = of_get_property(node, "device_type", NULL);
> > +     if (!type || strcmp(type, "pci")) {
> > +             dev_err(dev, "invalid \"device_type\" %s\n", type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* map config resource */
> > +     res =
> > +         platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +                                      "config_axi_slave");
> > +     pcie->config_axi_slave_base = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(pcie->config_axi_slave_base))
> > +             return PTR_ERR(pcie->config_axi_slave_base);
> > +     pcie->ob_io_res = res;
> > +
> > +     /* map csr resource */
> > +     res =
> > +         platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "csr_axi_slave");
> > +     pcie->csr_axi_slave_base = devm_ioremap_resource(dev, res);
> > +     if (IS_ERR(pcie->csr_axi_slave_base))
> > +             return PTR_ERR(pcie->csr_axi_slave_base);
> > +
> > +     /* map gpio resource */
> > +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "gpio_slave");
> > +     pcie->gpio_slave_base =
> > +         devm_ioremap_nocache(dev, res->start, resource_size(res));
> > +     if (IS_ERR(pcie->gpio_slave_base))
> > +             return PTR_ERR(pcie->gpio_slave_base);
> > +
> > +     /* map gpio resource */
> > +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "apb_csr");
> > +     pcie->apb_csr_base =
> > +         devm_ioremap_nocache(dev, res->start, resource_size(res));
> > +     if (IS_ERR(pcie->apb_csr_base))
> > +             return PTR_ERR(pcie->apb_csr_base);
> > +
> > +     /* read the number of windows requested */
> > +     if (!pcie->apio_wins &&
> > +             of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
> {
> > +             pcie->apio_wins = MAX_PIO_WINDOWS;
> > +     }
> > +
> > +     if (!pcie->ppio_wins &&
> > +             of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
> {
> > +             pcie->ppio_wins = MAX_PIO_WINDOWS;
> > +     }
> > +
> > +     /* map IRQ resource */
> > +     pcie->irq = irq_of_parse_and_map(node, 0);
> > +     err = devm_request_irq(&pdev->dev, pcie->irq, mobiveil_pcie_isr,
> > +                             IRQF_SHARED | IRQF_NO_THREAD,
> > +                             "mobiveil-pcie", pcie);
> > +     if (err) {
> > +             dev_err(&pdev->dev, "unable to request IRQ %d\n",
> pcie->irq);
> > +             return err;
> > +     }
> > +
> > +     INIT_LIST_HEAD(&pcie->resources);
> > +     /* parse the host bridge base addresses from the device tree file
> */
> > +     err = of_pci_get_host_bridge_resources(node,
> > +                     0, 0xff, &pcie->resources, &iobase);
> > +     if (err) {
> > +             dev_err(dev, "Getting bridge resources failed\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * access_paged_register - routine to access paged register of root
> complex
> > + *
> > + * registers of RC are paged, with pg_sel field of the PAB_CTRL
> > + * register needs to be updated with page of the register, before
> > + * accessing least significant 10 bits offset
> > + *
> > + * This routine does the PAB_CTRL updation and split access of the
> > + * offset
> > + *
> > + */
> > +static unsigned int access_paged_register(struct mobiveil_pcie *pcie,
> > +                                     unsigned int write,
> > +                                     unsigned int val,
> > +                                     unsigned int offset)
> > +{
> > +     int pab_ctrl_dw, pg_sel;
> > +     unsigned int off = (offset & 0x3FF) + 0xC00;
> > +
> > +     pab_ctrl_dw = csr_readl(pcie, PAB_CTRL);
> > +     pg_sel = (offset >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK;
> > +
> > +     /* clear pg_sel field */
> > +     pab_ctrl_dw = (pab_ctrl_dw & ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT));
> > +
> > +     /* set pg_sel field */
> > +     pab_ctrl_dw |= ((pg_sel << PAGE_SEL_SHIFT));
> > +     csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);
> > +
> > +     if (write == OP_WRITE)
> > +             csr_writel(pcie, val, off);
> > +     else
> > +             return csr_readl(pcie, off);
> > +     return 0;
> > +
> > +}
> > +
> > +/*
> > + * routine to program the inbound windows
> > + */
> > +static void program_ib_windows(struct mobiveil_pcie *pcie,
> > +                             int win_num,
> > +                             int pci_addr,
> > +                             int type,
> > +                             int size_kb)
> > +{
> > +     int pio_ctrl_val;
> > +     int amap_ctrl_dw;
> > +     u64 size64 = (-1 << (WIN_SIZE_SHIFT + ilog2_u32(size_kb)));
> > +
> > +     if ((pcie->ib_wins_configured + 1) > pcie->ppio_wins) {
> > +             dev_err(&pcie->pdev->dev,
> > +                     "ERROR: trying for more than max inbound windows
> in device tree !\n");
> > +             return;
> > +     }
> > +
> > +     pio_ctrl_val = csr_readl(pcie, PAB_PEX_PIO_CTRL);
> > +     csr_writel(pcie,
> > +             pio_ctrl_val | (1 << PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);
> > +     amap_ctrl_dw =  access_paged_register(pcie,
> > +                             OP_READ, 0, PAB_PEX_AMAP_CTRL(win_num));
> > +     amap_ctrl_dw = (amap_ctrl_dw | (type << AMAP_CTRL_TYPE_SHIFT));
> > +     amap_ctrl_dw = (amap_ctrl_dw | (1 << AMAP_CTRL_EN_SHIFT));
> > +
> > +     access_paged_register(pcie, OP_WRITE,
> > +                             amap_ctrl_dw | (size64 & 0xFFFFFFFF),
> > +                             PAB_PEX_AMAP_CTRL(win_num));
> > +
> > +     access_paged_register(pcie, OP_WRITE, upper_32_bits(size64),
> > +                             PAB_EXT_PEX_AMAP_SIZEN(win_num));
> > +
> > +     access_paged_register(pcie, OP_WRITE, pci_addr,
> > +                             PAB_PEX_AMAP_AXI_WIN(win_num));
> > +
> > +     access_paged_register(pcie, OP_WRITE, pci_addr,
> > +                             PAB_PEX_AMAP_PEX_WIN_L(win_num));
> > +
> > +     access_paged_register(pcie, OP_WRITE, 0,
> > +                             PAB_PEX_AMAP_PEX_WIN_H(win_num));
> > +}
> > +
> > +/*
> > + * routine to program the outbound windows
> > + */
> > +static void program_ob_windows(struct mobiveil_pcie *pcie,
> > +                             int win_num,
> > +                             u64 cpu_addr,
> > +                             u64 pci_addr,
> > +                             int config_io_bit,
> > +                             int size_kb)
> > +{
> > +
> > +     unsigned int value, type;
> > +     u64 size64 = (-1 << (WIN_SIZE_SHIFT + ilog2_u32(size_kb)));
> > +
> > +     if ((pcie->ob_wins_configured + 1) > pcie->apio_wins) {
> > +             dev_err(&pcie->pdev->dev,
> > +                     "ERROR: trying for more than max outbound windows
> in device tree !\n");
> > +             return;
> > +     }
> > +
> > +
> > +     /*
> > +      * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window
> Size Bit
> > +      * to 4 KB in PAB_AXI_AMAP_CTRL register
> > +      */
> > +     type = config_io_bit;
> > +     value = csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> > +     csr_writel(pcie,
> > +                     1 << WIN_ENABLE_SHIFT  |
> > +                     type << WIN_TYPE_SHIFT |
> > +                     lower_32_bits(size64),
> > +                     PAB_AXI_AMAP_CTRL(win_num));
> > +
> > +     access_paged_register(pcie, OP_WRITE, upper_32_bits(size64),
> > +                             PAB_EXT_AXI_AMAP_SIZE(win_num));
> > +
> > +     /*
> > +      * program AXI window base with appropriate value in
> > +      * PAB_AXI_AMAP_AXI_WIN0 register
> > +      */
> > +     value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(win_num));
> > +     csr_writel(pcie,
> > +                     cpu_addr >> AXI_WINDOW_BASE_SHIFT <<
> > +                     AXI_WINDOW_BASE_SHIFT,
> PAB_AXI_AMAP_AXI_WIN(win_num));
> > +
> > +     value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(win_num));
> > +
> > +     csr_writel(pcie, lower_32_bits(pci_addr),
> > +                     PAB_AXI_AMAP_PEX_WIN_L(win_num));
> > +     csr_writel(pcie, upper_32_bits(pci_addr),
> > +                     PAB_AXI_AMAP_PEX_WIN_H(win_num));
> > +
> > +     pcie->ob_wins_configured++;
> > +}
> > +
> > +/*
> > + * routine to prepare the PCIe slot for power up
> > + */
> > +static void mobiveil_pcie_establish_link(struct mobiveil_pcie *pcie)
> > +{
> > +
> > +     int secs = 4;
> > +
> > +     /* send PRESET to the slot */
> > +     gpio_write(pcie, 0x80000000, 0xa0344);
> > +     gpio_write(pcie, 0x80000000, 0xa0348);
> > +     gpio_write(pcie, 0x00000000, 0xa0054);
> > +     gpio_write(pcie, 0x80000000, 0xa0054);
> > +     dev_info(&pcie->pdev->dev,
> > +              "mobiveil_pcie_establish_link: waiting for %d seconds\n",
> > +              secs);
> > +     mdelay(secs * 1000);
> > +}
> > +
> > +static void mobiveil_bringup_link(struct mobiveil_pcie *pcie)
> > +{
> > +     int reset_cnt = 0;
> > +     struct device *dev = &pcie->pdev->dev;
> > +
> > +     if (!mobiveil_pcie_link_is_up(pcie)) {
> > +             /*
> > +              * if FSBL is not patched, link won't be up so let's bring
> it
> > +              * up by writing DIRM and OEN registers EMIO 6:0
> programming
> > +              * sequence [3:0] = Link Width; [6:4] = Link Speed. Current
> > +              * setting width=4, speed = 1
> > +              */
> > +             gpio_write(pcie, 0x7f, 0xa02c4);
> > +             gpio_write(pcie, 0x7f, 0xa02c8);
> > +             gpio_write(pcie, 0x14, 0xa004c);
> > +
> > +             gpio_write(pcie, 0x0200, 0xa0244);
> > +             gpio_write(pcie, 0x0200, 0xa0248);
> > +             gpio_write(pcie, 0x37f7, 0x180208);
> > +             gpio_write(pcie, 0xfdff, 0xa0044);
> > +
> > +             mdelay(2 * 1000);
> > +
> > +             while (!mobiveil_pcie_link_is_up(pcie)) {
> > +                     dev_info(dev,
> > +                              "%s: PRESET retry, reset_cnt : %d\n",
> > +                              __func__, reset_cnt++);
> > +                     mobiveil_pcie_establish_link(pcie);
> > +             }
> > +
> > +     }
> > +     dev_info(dev, "link up\n");
> > +}
> > +
> > +static void mobiveil_setup_config_access(struct mobiveil_pcie *pcie)
> > +{
> > +     unsigned int value;
> > +     int type = 0;
> > +     int pab_ctrl;
> > +     struct resource_entry *win, *tmp;
> > +
> > +     /*
> > +      * program Bus Master Enable Bit in Command Register in PAB Config
> > +      * Space
> > +      */
> > +     value = csr_readl(pcie, PCI_COMMAND);
> > +     csr_writel(pcie,
> > +             value |
> > +             PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
> > +             PCI_COMMAND);
> > +
> > +     /*
> > +      * program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in
> PAB_CTRL
> > +      * register
> > +      */
> > +     pab_ctrl = csr_readl(pcie, PAB_CTRL);
> > +     csr_writel(pcie, pab_ctrl | (1 << AMBA_PIO_ENABLE_SHIFT) |
> > +             (1 << PEX_PIO_ENABLE_SHIFT),
> > +             PAB_CTRL);
> > +
> > +     csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
> > +             PAB_INTP_AMBA_MISC_ENB);
> > +
> > +     /* program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
> > +      * PAB_AXI_PIO_CTRL Register
> > +      */
> > +     value = csr_readl(pcie, PAB_AXI_PIO_CTRL);
> > +     csr_writel(pcie, value | APIO_EN_MASK, PAB_AXI_PIO_CTRL);
> > +
> > +     /*
> > +      * we'll program one outbound window for config reads and
> > +      * another default inbound window for all the upstream traffic
> > +      * rest of the outbound windows will be configured according to
> > +      * the "ranges" field defined in device tree
> > +      */
> > +
> > +     /* config outbound translation window */
> > +     program_ob_windows(pcie,
> > +                     pcie->ob_wins_configured, pcie->ob_io_res->start,
> > +                     0,
> > +                     CFG_WINDOW_TYPE,
> > +                     resource_size(pcie->ob_io_res)/1024);
> > +
> > +     /* memory inbound  translation window */
> > +     program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE_KB);
> > +
> > +     /* Get the I/O and memory ranges from DT */
> > +     resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
> > +             type = 0;
> > +             if (resource_type(win->res) == IORESOURCE_MEM)
> > +                     type = MEM_WINDOW_TYPE;
> > +             if (resource_type(win->res) == IORESOURCE_IO)
> > +                     type = IO_WINDOW_TYPE;
> > +             if (type) {
> > +                     /* configure outbound translation window */
> > +                     pcie->ob_mem_res[pcie->ob_wins_configured] =
> win->res;
> > +                     program_ob_windows(pcie,
> > +                             pcie->ob_wins_configured,
> > +                             win->res->start,
> > +                             0,
> > +                             type,
> > +                             resource_size(win->res)/1024);
> > +             }
> > +     }
> > +
> > +
> > +
> > +}
> > +
> > +/* routine to setup the INTx related data */
> > +static int mobiveil_pcie_intx_map(struct irq_domain *domain,
> > unsigned int irq,
> > +                               irq_hw_number_t hwirq)
> > +{
> > +     irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> > +     irq_set_chip_data(irq, domain->host_data);
> > +     return 0;
> > +}
> > +
> > +/* INTx domain opeartions structure */
> > +static const struct irq_domain_ops intx_domain_ops = {
> > +     .map = mobiveil_pcie_intx_map,
> > +};
> > +
> > +static void mobiveil_pcie_destroy_msi(unsigned int irq)
> > +{
> > +     struct msi_desc *msi;
> > +     struct mobiveil_pcie *pcie;
> > +
> > +     if (!test_bit(irq, msi_irq_in_use)) {
> > +             msi = irq_get_msi_desc(irq);
> > +             pcie = msi_desc_to_pci_sysdata(msi);
> > +             dev_info(&pcie->pdev->dev,
> > +                      "Trying to free unused MSI#%d\n", irq);
> > +     } else {
> > +             clear_bit(irq, msi_irq_in_use);
> > +     }
> > +}
> > +
> > +static int mobiveil_pcie_assign_msi(struct mobiveil_pcie *pcie)
> > +{
> > +     int pos;
> > +
> > +     pos = find_first_zero_bit(msi_irq_in_use, PCI_NUM_MSI);
> > +     if (pos < PCI_NUM_MSI)
> > +             set_bit(pos, msi_irq_in_use);
> > +     else
> > +             return -ENOSPC;
> > +
> > +     return pos;
> > +}
> > +
> > +static void mobiveil_msi_teardown_irq(struct msi_controller *chip,
> > +                             unsigned int irq)
> > +{
> > +     mobiveil_pcie_destroy_msi(irq);
> > +     irq_dispose_mapping(irq);
> > +}
> > +
> > +static int mobiveil_pcie_msi_setup_irq(struct msi_controller *chip,
> > +                             struct pci_dev *pdev,
> > +                             struct msi_desc *desc)
> > +{
> > +     int hwirq;
> > +     unsigned int irq;
> > +     struct msi_msg msg;
> > +     phys_addr_t msg_addr;
> > +     struct mobiveil_pcie *pcie = pdev->bus->sysdata;
> > +
> > +     hwirq = mobiveil_pcie_assign_msi(pcie);
> > +     if (hwirq < 0)
> > +             return -EINVAL;
> > +
> > +     irq = irq_create_mapping(pcie->irq_domain, hwirq);
> > +     if (!irq)
> > +             return -EINVAL;
> > +
> > +     irq_set_msi_desc(irq, desc);
> > +
> > +     msg_addr =
> > +             virt_to_phys((void *)pcie->msi_pages + (hwirq *
> sizeof(int)));
> > +
> > +     msg.address_hi = upper_32_bits(msg_addr);
> > +     msg.address_lo = lower_32_bits(msg_addr);
> > +     msg.data = irq;
> > +
> > +     pci_write_msi_msg(irq, &msg);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct msi_controller mobiveil_pcie_msi_chip = {
> > +     .setup_irq = mobiveil_pcie_msi_setup_irq,
> > +     .teardown_irq = mobiveil_msi_teardown_irq,
> > +};
> > +
> > +static struct irq_chip mobiveil_msi_irq_chip = {
> > +     .name = "Mobiveil PCIe MSI",
> > +     .irq_enable = pci_msi_unmask_irq,
> > +     .irq_disable = pci_msi_mask_irq,
> > +     .irq_mask = pci_msi_mask_irq,
> > +     .irq_unmask = pci_msi_unmask_irq,
> > +};
> > +
> > +static int mobiveil_pcie_msi_map(struct irq_domain *domain,
> > unsigned int irq,
> > +                              irq_hw_number_t hwirq)
> > +{
> > +     irq_set_chip_and_handler(irq, &mobiveil_msi_irq_chip,
> > +                              handle_simple_irq);
> > +     irq_set_chip_data(irq, domain->host_data);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct irq_domain_ops msi_domain_ops = {
> > +     .map = mobiveil_pcie_msi_map,
> > +};
> > +
> > +static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
> > +{
> > +     phys_addr_t msg_addr;
> > +
> > +     pcie->msi_pages = (void *)__get_free_pages(GFP_DMA, 0);
> > +     msg_addr = virt_to_phys((void *)pcie->msi_pages);
> > +     pcie->msi_pages_phys = (void *)msg_addr;
> > +
> > +     writel_relaxed(lower_32_bits(msg_addr),
> > +             pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
> > +     writel_relaxed(upper_32_bits(msg_addr),
> > +             pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
> > +     writel_relaxed(4096, pcie->apb_csr_base + MSI_SIZE_OFFSET);
> > +     writel_relaxed(1 << MSI_ENABLE_SHIFT,
> > +             pcie->apb_csr_base + MSI_ENABLE_OFFSET);
> > +}
> > +
> > +static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
> > +{
> > +     struct device *dev = &pcie->pdev->dev;
> > +     struct device_node *node = dev->of_node;
> > +
> > +     /* Setup INTx */
> > +     pcie->irq_domain =
> > +             irq_domain_add_linear(node, PCI_NUM_INTX + 1,
> &intx_domain_ops,
> > +                               pcie);
> > +
> > +     if (!pcie->irq_domain) {
> > +             dev_err(dev, "Failed to get a INTx IRQ domain\n");
> > +             return -ENOMEM;
> > +     }
> > +     /* Setup MSI */
> > +     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +             pcie->irq_domain =
> > +                     irq_domain_add_linear(node,
> > +                                             PCI_NUM_MSI,
> > +                                             &msi_domain_ops,
> > +                                             &mobiveil_pcie_msi_chip);
> > +             if (!pcie->irq_domain) {
> > +                     dev_err(dev, "Failed to get a MSI IRQ domain\n");
> > +                     return PTR_ERR(pcie->irq_domain);
> > +             }
> > +
> > +             mobiveil_pcie_enable_msi(pcie);
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int mobiveil_pcie_probe(struct platform_device *pdev)
> > +{
> > +     struct mobiveil_pcie *pcie;
> > +     struct pci_bus *bus;
> > +     struct pci_bus *child;
> > +     int ret;
> > +
> > +     /* allocate the PCIe port */
> > +     pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> > +     if (!pcie)
> > +             return -ENOMEM;
> > +
> > +     pcie->pdev = pdev;
> > +
> > +     /* parse the device tree */
> > +     ret = mobiveil_pcie_parse_dt(pcie);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Parsing DT failed, ret: %x\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     /* setup the PCIe slot link power*/
> > +     mobiveil_bringup_link(pcie);
> > +
> > +     /*
> > +      * configure all inbound and outbound windows and prepare the RC
> for
> > +      * config access
> > +      */
> > +     mobiveil_setup_config_access(pcie);
> > +
> > +     /* fixup for PCIe class register */
> > +     csr_writel(pcie, 0x060402AB, PAB_INTP_AXI_PIO_CLASS);
> > +
> > +     /* initialize the IRQ domains */
> > +     ret = mobiveil_pcie_init_irq_domain(pcie);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
> > +             return ret;
> > +     }
> > +
> > +     /* create the PCIe root bus */
> > +     bus =
> > +     pci_create_root_bus(&pdev->dev, 0,
> > +                     &mobiveil_pcie_ops, pcie, &pcie->resources);
> > +     if (!bus)
> > +             return -ENOMEM;
> > +
> > +     /* setup MSI, if enabled */
> > +     if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +             mobiveil_pcie_msi_chip.dev = &pcie->pdev->dev;
> > +             bus->msi = &mobiveil_pcie_msi_chip;
> > +     }
> > +
> > +     /* setup the kernel resources for the newly added PCIe root bus */
> > +     pci_scan_child_bus(bus);
> > +     pci_assign_unassigned_bus_resources(bus);
> > +
> > +     list_for_each_entry(child, &bus->children, node)
> > +             pcie_bus_configure_settings(child);
> > +
> > +     pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > +     pci_bus_add_devices(bus);
> > +     platform_set_drvdata(pdev, pcie);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id mobiveil_pcie_of_match[] = {
> > +     {.compatible = "mbvl,axi-pcie-host-1.00",},
> > +     {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
> > +
> > +static struct platform_driver mobiveil_pcie_driver = {
> > +     .probe = mobiveil_pcie_probe,
> > +     .driver = {
> > +                     .name = "mobiveil-pcie",
> > +                     .of_match_table = mobiveil_pcie_of_match,
> > +                     .suppress_bind_attrs = true,
> > +             },
> > +};
> > +
> > +builtin_platform_driver(mobiveil_pcie_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
> > +MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
> > --
> > 1.8.3.1
>

--f403045f5352ca4050055e776c3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;color:#073763">Bjorn,</div><div class=3D"gmail_default" style=3D=
"font-family:verdana,sans-serif;color:#073763">My apologies.=C2=A0</div><di=
v class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;color:#07=
3763">I will fix them and re submit.</div><div class=3D"gmail_default" styl=
e=3D"font-family:verdana,sans-serif;color:#073763"><br></div><div class=3D"=
gmail_default" style=3D"font-family:verdana,sans-serif;color:#073763">thank=
s,</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, N=
ov 21, 2017 at 2:28 AM, Bjorn Helgaas <span dir=3D"ltr">&lt;<a href=3D"mail=
to:helgaas@kernel.org" target=3D"_blank">helgaas@kernel.org</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">This patch doesn&#39;t apply clean=
ly:<br>
<br>
=C2=A0 $ stg branch --create pci/host-mobiveil pci-v4.15-changes<br>
=C2=A0 $ stg import -M m/subrahmanya<br>
=C2=A0 Importing patch &quot;pci-mobiveil-add-mobiveil-<wbr>pcie&quot; ... =
error: corrupt patch at line 108<br>
=C2=A0 stg import: Diff does not apply cleanly<br>
<br>
I think it&#39;s line wrapped.=C2=A0 Please fix your mailer so it doesn&#39=
;t<br>
insert extra newlines in the patch.<br>
<span class=3D""><br>
On Fri, Nov 17, 2017 at 06:21:25PM +0530, subrahmanya_lingappa wrote:<br>
&gt; From 6a514d9da7e58a2b9e98fa60a97d4b<wbr>1bcbaeef02 Mon Sep 17 00:00:00=
 2001<br>
&gt; From: Subrahmanya Lingappa &lt;<a href=3D"mailto:l.subrahmanya@mobivei=
l.co.in">l.subrahmanya@mobiveil.co.in</a>&gt;<br>
&gt; Date: Thu, 16 Nov 2017 23:56:10 -0500<br>
&gt; Subject: [PATCH v3] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP dr=
iver<br>
<br>
</span>s/PCI: Mobiveil/PCI: mobiveil/=C2=A0 (Driver names are all lower-cas=
e by<br>
convention)<br>
<span class=3D""><br>
&gt; This is the driver for Mobiveil=C2=A0 AXI PCIe Host Bridge Soft IP<br>
<br>
</span>s/=C2=A0 / /=C2=A0 (Remove extra space)<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt; Cc: <a href=3D"mailto:bhelgaas@google.com">bhelgaas@google.com</a><br>
&gt;<br>
&gt; v3 patch fixes:<br>
&gt; - spell checks<br>
&gt; - removed superfluous comments and headers<br>
&gt; - added COMPILE_TEST to Kconfig<br>
&gt; - removed spurious blank lines<br>
&gt; - removed unused functions<br>
&gt; - removed unused macro definitions<br>
&gt; - comments alignment<br>
&gt; - multi-line comment styles<br>
&gt; - removed bogus code from isr<br>
&gt; - made public functions static<br>
&gt; - made small functions inline<br>
&gt; - removed unnecessary functions replaced them inline<br>
&gt; - added irq_dispose_mapping() while=C2=A0 MSI tearing down<br>
&gt; - used upper_32_bits/lower_32_bits for bits extraction<br>
&gt; - removed mobiveil_pcie_remove and the children<br>
&gt; - removed superfluous printks<br>
&gt; - replaced printk with dev_info<br>
&gt; - replaced mobiveil_pcie_powerup_slot with mobiveil_pcie_establish_lin=
k<br>
&gt;=C2=A0 =C2=A0like other similar drivers<br>
&gt; - pci_scan_root_bus_bridge was not used to replace as testing branch i=
s<br>
&gt;=C2=A0 =C2=A04.9 version.<br>
&gt; - MODULE_LICENSE is fixed to &quot;GPL v2&quot; to align with file hea=
der<br>
&gt; - removed hard-coded inbound and out bound window parameters,<br>
&gt;=C2=A0 =C2=A0now read from device tree.<br>
&gt;<br>
&gt; Signed-off-by: Subrahmanya Lingappa &lt;<a href=3D"mailto:l.subrahmany=
a@mobiveil.co.in">l.subrahmanya@mobiveil.co.in</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../devicetree/bindings/pci/<wbr>mobiveil-pcie.txt=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 68 ++<br>
&gt;=C2=A0 .../devicetree/bindings/<wbr>vendor-prefixes.txt=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 drivers/pci/host/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 =
+<br>
&gt;=C2=A0 drivers/pci/host/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/pci/host/pcie-<wbr>mobiveil.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 899<br>
&gt; +++++++++++++++++++++<br>
&gt;=C2=A0 6 files changed, 985 insertions(+)<br>
&gt;=C2=A0 create mode 100644 Documentation/devicetree/<wbr>bindings/pci/mo=
biveil-pcie.txt<br>
&gt;=C2=A0 create mode 100644 drivers/pci/host/pcie-<wbr>mobiveil.c<br>
&gt;<br>
&gt; diff --git a/Documentation/devicetree/<wbr>bindings/pci/mobiveil-pcie.=
txt<br>
&gt; b/Documentation/devicetree/<wbr>bindings/pci/mobiveil-pcie.txt<br>
&gt; new file mode 100644<br>
&gt; index 0000000..c9e9818<br>
&gt; --- /dev/null<br>
&gt; +++ b/Documentation/devicetree/<wbr>bindings/pci/mobiveil-pcie.txt<br>
&gt; @@ -0,0 +1,68 @@<br>
&gt; +* Mobiveil AXI PCIe Root Port Bridge DT description<br>
&gt; +<br>
&gt; +Required properties:<br>
&gt; +- #address-cells: Address representation for root ports, set to &lt;3=
&gt;<br>
&gt; +- #size-cells: Size representation for root ports, set to &lt;2&gt;<b=
r>
&gt; +- #interrupt-cells: specifies the number of cells needed to encode an=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0interrupt source. The value must be 1.<br>
&gt; +- compatible: Should contain &quot;mbvl,axi-pcie-host-1.00&quot;<br>
&gt; +- reg: Should contain AXI PCIe registers location and length<br>
&gt; +- device_type: must be &quot;pci&quot;<br>
&gt; +- apio-wins : number of configured apio outbound windows<br>
&gt; +- ppio-wins : number of configured ppio inbound windows<br>
&gt; +- interrupts: Should contain AXI PCIe interrupt<br>
&gt; +- interrupt-map-mask,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0interrupt-map: standard PCI properties to define =
the mapping of the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0PCI interface to interrupt numbers.<br>
&gt; +- ranges: ranges for the PCI memory regions (I/O space region is not<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0supported by hardware)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Please refer to the standard PCI bus binding docu=
ment for a more<br>
&gt; +=C2=A0 =C2=A0 =C2=A0detailed explanation<br>
&gt; +<br>
&gt; +- bus-range: PCI bus numbers covered<br>
&gt; +<br>
&gt; +Interrupt controller child node<br>
&gt; ++++++++++++++++++++++++++++++<wbr>++<br>
&gt; +Required properties:<br>
&gt; +- interrupt-controller: identifies the node as an interrupt controlle=
r<br>
&gt; +- #address-cells: specifies the number of cells needed to encode an<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0address. The value must be 0.<br>
&gt; +- #interrupt-cells: specifies the number of cells needed to encode an=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0interrupt source. The value must be 1.<br>
&gt; +<br>
&gt; +NOTE:<br>
&gt; +The core provides a single interrupt for both INTx/MSI messages. So,<=
br>
&gt; +created a interrupt controller node to support &#39;interrupt-map&#39=
; DT<br>
&gt; +functionality.=C2=A0 The driver will create an IRQ domain for this ma=
p, decode<br>
&gt; +the four INTx interrupts in ISR and route them to this domain.<br>
&gt; +<br>
&gt; +Example:<br>
&gt; +++++++++<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_express: axi-pcie@a0000000 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#address-cells =3D &l=
t;3&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#size-cells =3D &lt;2=
&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#interrupt-cells =3D =
&lt;1&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible =3D &quot;=
mbvl,axi-pcie-host-1.00&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D=C2=A0 =C2=A0&=
lt; 0xa0000000 0x00001000 &gt;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&lt; 0xb0000000 0x00010000 &gt;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&lt; 0xFF000000 0x00200000 &gt;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&lt; 0xb0010000 0x00001000 &gt;;<br>
<br>
</div></div>You lined things up in a table, which is good.=C2=A0 Also remov=
e the extra<br>
spaces inside the &quot;&lt; ... &gt;&quot;, as in interrupt-map below.=C2=
=A0 And use<br>
lower-case consistently in your hex constants instead of mixing upper-<br>
and lower-case.<br>
<div><div class=3D"h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg-names =3D=C2=A0 =
=C2=A0 =C2=A0&quot;config_axi_slave&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;csr_axi_slave&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;gpio_slave&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;apb_csr&quot;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_type =3D &quot=
;pci&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0apio-wins =3D &lt;3&g=
t;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ppio-wins =3D &lt;3&g=
t;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-parent =3D =
&lt;&amp;gic&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupts =3D &lt; 0=
 89 4 &gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-controller;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-map-mask =
=3D &lt;0 0 0 7&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interrupt-map =3D &lt=
;0 0 0 1 &amp;pci_express 1&gt;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;0 0 0 2 &amp;pci_express 2&gt;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;0 0 0 3 &amp;pci_express 3&gt;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;0 0 0 4 &amp;pci_express 4&gt;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ranges =3D &lt; 0x830=
00000 0 0x00000000 0xa8000000 0 0x8000000&gt;;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; diff --git a/Documentation/devicetree/<wbr>bindings/vendor-prefixes.tx=
t<br>
&gt; b/Documentation/devicetree/<wbr>bindings/vendor-prefixes.txt<br>
&gt; index f0a48ea..be61439 100644<br>
&gt; --- a/Documentation/devicetree/<wbr>bindings/vendor-prefixes.txt<br>
&gt; +++ b/Documentation/devicetree/<wbr>bindings/vendor-prefixes.txt<br>
&gt; @@ -179,6 +179,7 @@ msi=C2=A0 =C2=A0 =C2=A0 =C2=A0Micro-Star Internati=
onal Co. Ltd.<br>
&gt;=C2=A0 mti=C2=A0 Imagination Technologies Ltd. (formerly MIPS Technolog=
ies Inc.)<br>
&gt;=C2=A0 mundoreader=C2=A0 Mundo Reader S.L.<br>
&gt;=C2=A0 murata=C2=A0 =C2=A0 =C2=A0 =C2=A0Murata Manufacturing Co., Ltd.<=
br>
&gt; +mbvl Mobiveil Inc.<br>
<br>
</div></div>Use a tab (not a space) after &quot;mbvl&quot;, like the other =
entries.<br>
<div><div class=3D"h5"><br>
&gt;=C2=A0 mxicy=C2=A0 =C2=A0 =C2=A0 =C2=A0 Macronix International Co., Ltd=
.<br>
&gt;=C2=A0 national=C2=A0 =C2=A0 =C2=A0National Semiconductor<br>
&gt;=C2=A0 nec=C2=A0 NEC LCD Technologies, Ltd.<br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index 63cefa6..d7dc6c3 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -9336,6 +9336,13 @@ F:<br>
&gt; Documentation/devicetree/<wbr>bindings/pci/host-generic-pci.<wbr>txt<b=
r>
&gt;=C2=A0 F:=C2=A0 =C2=A0drivers/pci/host/pci-host-<wbr>common.c<br>
&gt;=C2=A0 F:=C2=A0 =C2=A0drivers/pci/host/pci-host-<wbr>generic.c<br>
&gt;<br>
&gt; +PCI DRIVER FOR MOBIVEIL PCIE IP<br>
&gt; +M:=C2=A0 =C2=A0Subrahmanya Lingappa &lt;<a href=3D"mailto:l.subrahman=
ya@mobiveil.co.in">l.subrahmanya@mobiveil.co.in</a>&gt;<br>
&gt; +L:=C2=A0 =C2=A0<a href=3D"mailto:linux-pci@vger.kernel.org">linux-pci=
@vger.kernel.org</a><br>
&gt; +S:=C2=A0 =C2=A0Supported<br>
&gt; +F:=C2=A0 =C2=A0Documentation/devicetree/<wbr>bindings/pci/mobiveil-pc=
ie.txt<br>
&gt; +F:=C2=A0 =C2=A0drivers/pci/host/pcie-<wbr>mobiveil.c<br>
&gt; +<br>
&gt;=C2=A0 PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)<br>
&gt;=C2=A0 M:=C2=A0 =C2=A0Keith Busch &lt;<a href=3D"mailto:keith.busch@int=
el.com">keith.busch@intel.com</a>&gt;<br>
&gt;=C2=A0 L:=C2=A0 =C2=A0<a href=3D"mailto:linux-pci@vger.kernel.org">linu=
x-pci@vger.kernel.org</a><br>
&gt; diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig<br>
&gt; index 6f1de4f..d8fb02d 100644<br>
&gt; --- a/drivers/pci/host/Kconfig<br>
&gt; +++ b/drivers/pci/host/Kconfig<br>
&gt; @@ -37,6 +37,14 @@ config PCIE_XILINX_NWL<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 or End Point. The current option selection =
will only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 support root port enabling.<br>
&gt;<br>
&gt; +config PCIE_MOBIVEIL<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;Mobiveil AXI PCIe host bridge support&=
quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on ARCH_ZYNQMP || COMPILE_TEST<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on PCI_MSI_IRQ_DOMAIN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Say &#39;Y&#39; here if you want kernel to=
 support the Mobiveil AXI PCIe<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Host Bridge driver.<br>
&gt; +<br>
&gt;=C2=A0 config PCIE_DW_PLAT<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Platform bus based DesignWare PCI=
e Controller&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PCI_MSI_IRQ_DOMAIN<br>
&gt; @@ -103,6 +111,7 @@ config PCI_HOST_GENERIC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you want to support a s=
imple generic PCI host<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0controller, such as the one emulated =
by kvmtool.<br>
&gt;<br>
&gt; +<br>
<br>
</div></div>Remove this spurious diff.<br>
<br>
Darn it, I mentioned most of these things the first time around.<br>
<div><div class=3D"h5"><br>
&gt;=C2=A0 config PCIE_SPEAR13XX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;STMicroelectronics SPEAr PCIe con=
troller&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_SPEAR13XX<br>
&gt; diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile<br>
&gt; index 9b113c2..d851978 100644<br>
&gt; --- a/drivers/pci/host/Makefile<br>
&gt; +++ b/drivers/pci/host/Makefile<br>
&gt; @@ -34,3 +34,4 @@ obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o<br=
>
&gt;=C2=A0 obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o<br>
&gt;=C2=A0 obj-$(CONFIG_PCIE_ROCKCHIP) +=3D pcie-rockchip.o<br>
&gt;=C2=A0 obj-$(CONFIG_VMD) +=3D vmd.o<br>
&gt; +obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o<br>
&gt; diff --git a/drivers/pci/host/pcie-<wbr>mobiveil.c<br>
&gt; b/drivers/pci/host/pcie-<wbr>mobiveil.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..abc6adf<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/pci/host/pcie-<wbr>mobiveil.c<br>
&gt; @@ -0,0 +1,899 @@<br>
&gt; +/*<br>
&gt; + * PCIe host controller driver for Mobiveil PCIe Host controller<br>
&gt; + *<br>
&gt; + * Copyright Mobiveil Corporation (C) 2013-2017. All rights reserved<=
br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy it<br>
&gt; + * under the terms and conditions of the GNU General Public License,<=
br>
&gt; + * version 2, as published by the Free Software Foundation.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope it will be useful, but WIT=
HOUT<br>
&gt; + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public=
<br>
&gt; License for<br>
<br>
</div></div>Line wrapped; I pointed this out the first time, too.<br>
<div><div class=3D"h5"><br>
&gt; + * more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public<br>
&gt; License along with<br>
&gt; + * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/=
licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses=
/</a>&gt;<wbr>.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/irqchip/chained_irq.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/of_address.h&gt;<br>
&gt; +#include &lt;linux/of_irq.h&gt;<br>
&gt; +#include &lt;linux/irq.h&gt;<br>
&gt; +#include &lt;linux/msi.h&gt;<br>
&gt; +#include &lt;linux/of_pci.h&gt;<br>
&gt; +#include &lt;linux/pci.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/slab.h&gt;<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/irqdomain.h&gt;<br>
&gt; +#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/of_platform.h&gt;<br>
&gt; +<br>
&gt; +/* Register Offsets and Bit Positions*/<br>
<br>
</div></div>Add space before &quot;*/&quot; (also mentioned first time).<br=
>
<span class=3D""><br>
&gt; +#define WIN_NUM_0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define WIN_NUM_1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +<br>
&gt; +#define CFG_WINDOW_TYPE=C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define IO_WINDOW_TYPE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01<br>
&gt; +#define MEM_WINDOW_TYPE=C2=A0 =C2=A0 =C2=A0 2<br>
&gt; +#define MAX_PIO_WINDOWS=C2=A0 =C2=A0 =C2=A0 8<br>
&gt; +<br>
&gt; +#define PAB_INTA_POS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
&gt; +#define OP_READ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
&gt; +#define OP_WRITE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt; +<br>
&gt; +#define IB_WIN_SIZE_KB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(256*1024*1024)<br>
&gt; +<br>
&gt; +#define LTSSM_STATE_STATUS=C2=A0 =C2=A00x0404<br>
&gt; +#define LTSSM_STATUS_CODE_MASK=C2=A0 0x3F<br>
&gt; +#define LTSSM_STATUS_CODE=C2=A0 =C2=A0 0x2D=C2=A0 =C2=A0 /* LTSSM Sta=
tus Code L0 */<br>
<br>
</span>You ignored this comment from the first time:<br>
<br>
=C2=A0 This name (LTSSM_STATUS_CODE) is not very descriptive.=C2=A0 Presuma=
bly<br>
=C2=A0 there are *other* status codes, too, so this should be something lik=
e<br>
=C2=A0 LTSSM_STATUS_L0.<br>
<span class=3D""><br>
&gt; +#define PAB_CTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x080=
8<br>
&gt; +#define=C2=A0 AMBA_PIO_ENABLE_SHIFT 0<br>
&gt; +#define=C2=A0 PEX_PIO_ENABLE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +#define=C2=A0 PAGE_SEL_SHIFT=C2=A0 =C2=A0 =C2=A0 13<br>
&gt; +#define=C2=A0 PAGE_SEL_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x3f<br>
<br>
</span>Some of your hex constants use lower-case, others upper-case.=C2=A0 =
Pick<br>
one and use it consistently.<br>
<div><div class=3D"h5"><br>
&gt; +#define=C2=A0 PAGE_SEL_OFFSET_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A010<br>
&gt; +<br>
&gt; +#define PAB_AXI_PIO_CTRL=C2=A0 =C2=A0 =C2=A00x0840<br>
&gt; +#define=C2=A0 APIO_EN_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0xf<br>
&gt; +<br>
&gt; +#define PAB_PEX_PIO_CTRL=C2=A0 =C2=A0 =C2=A00x08C0<br>
&gt; +#define=C2=A0 PIO_ENABLE_SHIFT=C2=A0 =C2=A0 0<br>
&gt; +#define PAB_INTP_AMBA_MISC_ENB 0x0B0C<br>
&gt; +#define PAB_INTP_AMBA_MISC_STAT 0x0B1C<br>
&gt; +#define=C2=A0 PAB_INTP_INTX_MASK=C2=A0 =C2=A0 0x1E0 /* INTx(A-D) */<b=
r>
&gt; +#define=C2=A0 PAB_INTP_MSI_MASK=C2=A0 =C2=A00x8<br>
&gt; +<br>
&gt; +#define PAB_AXI_AMAP_CTRL(win_num)=C2=A0 =C2=A0(0x0BA0 + (0x10*win_nu=
m))<br>
&gt; +#define=C2=A0 WIN_ENABLE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0<br>
&gt; +#define=C2=A0 WIN_TYPE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1<br>
&gt; +#define=C2=A0 WIN_SIZE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 10<br>
&gt; +#define PAB_EXT_AXI_AMAP_SIZE(win_num)=C2=A0 (0xBAF0 + (0x4*win_num))=
<br>
&gt; +<br>
&gt; +#define PAB_AXI_AMAP_AXI_WIN(win_num)=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x0=
BA4 + (0x10*win_num))<br>
&gt; +#define=C2=A0 AXI_WINDOW_BASE_SHIFT=C2=A0 =C2=A0 2<br>
&gt; +<br>
&gt; +#define PAB_AXI_AMAP_PEX_WIN_L(win_<wbr>num)=C2=A0 =C2=A0 =C2=A0(0x0B=
A8 + (0x10*win_num))<br>
&gt; +#define=C2=A0 PAB_BUS_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A024<br>
&gt; +#define=C2=A0 PAB_DEVICE_SHIFT=C2=A0 =C2=A0 19<br>
&gt; +#define=C2=A0 PAB_FUNCTION_SHIFT=C2=A0 16<br>
&gt; +<br>
&gt; +#define PAB_AXI_AMAP_PEX_WIN_H(win_<wbr>num) (0x0BAC + (0x10*win_num)=
)<br>
&gt; +#define PAB_INTP_AXI_PIO_CLASS=C2=A0 =C2=A0 =C2=A0 =C2=A00x474<br>
&gt; +<br>
&gt; +#define PAB_PEX_AMAP_CTRL(win_num)=C2=A0 =C2=A0(0x4BA0 + (0x10*win_nu=
m))<br>
&gt; +#define AMAP_CTRL_EN_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<=
br>
&gt; +#define AMAP_CTRL_TYPE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0=
 =C2=A0 =C2=A0 =C2=A0/* 0: interrupt, 2: memory */<br>
&gt; +<br>
&gt; +#define PAB_EXT_PEX_AMAP_SIZEN(win_<wbr>num) (0xBEF0 + (0x4*win_num))=
<br>
&gt; +#define PAB_PEX_AMAP_AXI_WIN(win_num)=C2=A0 =C2=A0(0x4BA4 + (0x10*win=
_num))<br>
&gt; +#define PAB_PEX_AMAP_PEX_WIN_L(win_<wbr>num) (0x4BA8 + (0x10*win_num)=
)<br>
&gt; +#define PAB_PEX_AMAP_PEX_WIN_H(win_<wbr>num) (0x4BAC + (0x10*win_num)=
)<br>
&gt; +<br>
&gt; +#define PCI_NUM_INTX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br>
&gt; +#define PCI_NUM_MSI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16<br>
&gt; +<br>
&gt; +#define MSI_BASE_LO_OFFSET=C2=A0 =C2=A00x04<br>
&gt; +#define MSI_BASE_HI_OFFSET=C2=A0 =C2=A00x08<br>
&gt; +#define MSI_SIZE_OFFSET=C2=A0 =C2=A0 =C2=A0 0x0c<br>
&gt; +#define MSI_ENABLE_OFFSET=C2=A0 =C2=A0 0x14<br>
&gt; +#define MSI_ENABLE_SHIFT=C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define MSI_STATUS_OFFSET=C2=A0 =C2=A0 0x18<br>
&gt; +#define MSI_STATUS_SHIFT=C2=A0 =C2=A0 =C2=A00<br>
&gt; +#define MSI_OCCUPANCY_OFFSET=C2=A0 =C2=A0 0x1c<br>
&gt; +#define MSI_DATA_OFFSET=C2=A0 =C2=A0 =C2=A0 0x20<br>
&gt; +#define MSI_ADDR_L_OFFSET=C2=A0 =C2=A0 0x24<br>
&gt; +#define MSI_ADDR_H_OFFSET=C2=A0 =C2=A0 0x28<br>
&gt; +#define ilog2_u32(num) (__ffs(num)-1)<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * PCIe port information<br>
&gt; + */<br>
&gt; +struct mobiveil_pcie {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct platform_device *pdev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *config_axi_slave_base;=C2=A0 =C2=A0=
 /* endpoint config base */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *csr_axi_slave_base;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* root port config base */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *gpio_slave_base;=C2=A0 /* GPIO regi=
ster base */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0void __iomem *apb_csr_base;=C2=A0 =C2=A0 =C2=A0/*=
 MSI register base */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct irq_domain *irq_domain;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource bus_range;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct list_head resources;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int *msi_pages;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int *msi_pages_phys;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char root_bus_nr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int apio_wins;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ppio_wins;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ob_wins_configured; /*=C2=A0 configured outbo=
und windows */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ib_wins_configured; /*=C2=A0 configured inbou=
nd windows */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource *ob_io_res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource *ob_mem_res[3];<br>
&gt; +};<br>
&gt; +<br>
&gt; +static DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);<br>
&gt; +<br>
&gt; +static inline void csr_writel(struct mobiveil_pcie *pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const unsigned int value, const unsigned int reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel_relaxed(value, pcie-&gt;csr_axi_slave_base=
 + reg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline unsigned int csr_readl(struct mobiveil_pcie *pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0const unsigned int reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return readl_relaxed(pcie-&gt;csr_axi_<wbr>slave_=
base + reg);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline int gpio_read(struct mobiveil_pcie *pcie, int addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ioread32(pcie-&gt;gpio_slave_base + addr);=
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static inline void gpio_write(struct mobiveil_pcie *pcie, int val,<br=
>
&gt; int addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0iowrite32(val, pcie-&gt;gpio_slave_base + addr);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (val !=3D gpio_read(pcie, addr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&amp;pcie-&g=
t;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;WARNING:gpio_write: expected : %x at: %x, found: %x\n &quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 val, addr, gpio_read(pcie, addr));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool mobiveil_pcie_link_is_up(<wbr>struct mobiveil_pcie *pcie)=
<br>
<br>
</div></div>I already pointed this out:<br>
<br>
=C2=A0 Rename to mobiveil_pcie_link_up().=C2=A0 The altera and xilinx drive=
rs are<br>
=C2=A0 the oddballs here and should be renamed.=C2=A0 All the others use<br=
>
=C2=A0 .*_pcie_link_up().<br>
<br>
I&#39;m going to stop here because while you did fix a few things, there<br=
>
was a lot of other feedback that you haven&#39;t addressed yet.=C2=A0 It&#3=
9;s a<br>
waste of your reviewers&#39; time if you don&#39;t pay attention to what th=
ey<br>
write.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return (csr_readl(pcie, LTSSM_STATE_STATUS) &amp;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LTSSM_STATUS_CODE_MAS=
K) =3D=3D LTSSM_STATUS_CODE;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool mobiveil_pcie_valid_device(<wbr>struct pci_bus *bus,<br>
&gt; unsigned int devfn)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mobiveil_pcie *pcie =3D bus-&gt;sysdata;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Check if link is up when trying to access down=
stream ports */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bus-&gt;number !=3D pcie-&gt;root_bus_nr)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mobiveil_pcie_li=
nk_is_up(<wbr>pcie))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Only one device down on each root port */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((bus-&gt;number =3D=3D pcie-&gt;root_bus_nr) =
&amp;&amp; (devfn &gt; 0))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Do not read more than one device on the bus di=
rectly<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * attached to RC<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((bus-&gt;primary =3D=3D pcie-&gt;root_bus_nr)=
 &amp;&amp; (devfn &gt; 0))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * mobiveil_pcie_map_bus - routine to get the configuration base of e=
ither<br>
&gt; + * root port or endpoint<br>
&gt; + *<br>
&gt; + * Relies on pci_lock serialization<br>
&gt; + */<br>
&gt; +static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsi=
gned int devfn, int where)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mobiveil_pcie *pcie =3D bus-&gt;sysdata;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int value;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!mobiveil_pcie_valid_device(<wbr>bus, devfn))=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bus-&gt;number =3D=3D pcie-&gt;root_bus_nr) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* RC config access (=
in CSR space) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pcie-&gt;csr_a=
xi_slave_base + where;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * EP config access (=
in Config/APIO space)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Program PEX Addres=
s base (31..16 bits) with appropriate value<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * (BDF) in PAB_AXI_A=
MAP_PEX_WIN_L0 Register.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Relies on pci_lock=
 serialization */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D csr_readl(p=
cie, PAB_AXI_AMAP_PEX_WIN_L(0));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csr_writel(pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bus-&gt;number &lt;&lt; PAB_BUS_SHIFT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(devfn &gt;&gt; 3) &lt;&lt; PAB_DEVICE_SHIFT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(devfn &amp; 7) &lt;&lt; PAB_FUNCTION_SHIFT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PAB_AXI_AMAP_PEX_WIN_L(0));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return pcie-&gt;confi=
g_axi_slave_base + where;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct pci_ops mobiveil_pcie_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.map_bus =3D mobiveil_pcie_map_bus,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.read =3D pci_generic_config_read,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.write =3D pci_generic_config_write,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static irqreturn_t mobiveil_pcie_isr(int irq, void *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mobiveil_pcie *pcie =3D (struct mobiveil_p=
cie *)data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int fifo_occ;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int msi_addr_l, msi_addr_h, msi_data;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int status, status2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long shifted_status;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int bit1 =3D 0, virq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int val, mask;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * The core provides a single interrupt for both =
INTx/MSI messages.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * So we&#39;ll read both INTx and MSI statuses<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* read INTx status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0val =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mask =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status =3D val &amp; mask;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Handle INTx */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (status &amp; PAB_INTP_INTX_MASK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((shifted_statu=
s =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) &gt;&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 PAB_INTA_POS)) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0for_each_set_bit(bit1, &amp;shifted_status, PCI_NUM_INTX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear interrupts */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csr_writel(pcie, shifted_status &lt;&lt;=
 PAB_INTA_POS,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAB_=
INTP_AMBA_MISC_STAT);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virq =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_find_mapping(pcie-&gt;=
irq_<wbr>domain,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit1 + 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (virq)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generic_hand=
le_irq(virq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp=
;pcie-&gt;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;unexpected IRQ, INT%d\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bit1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0shifted_status =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* read MSI status */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0status2 =3D readl(pcie-&gt;apb_csr_base + MSI_STA=
TUS_OFFSET);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* handle MSI interrupts */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((status &amp; PAB_INTP_MSI_MASK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| (status2 &amp; (1 &lt;&lt; MSI_S=
TATUS_SHIFT))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fifo_occ =3D readl(pcie-&gt;apb_csr_base<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + MSI_OCCUP=
ANCY_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0msi_data =3D readl(pcie-&gt;apb_csr_base + MSI_DATA_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0msi_addr_l =3D readl(pcie-&gt;apb_csr_base<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + MS=
I_ADDR_L_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0msi_addr_h =3D readl(pcie-&gt;apb_csr_base<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + MS=
I_ADDR_H_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* Handle MSI */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (msi_data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0generic_handle_irq(msi_data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pcie-&gt;pdev-&gt;dev, &quo=
t;MSI data null\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0status2 =3D readl(pcie-&gt;apb_csr_base + MSI_STATUS_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} while ((status2 &am=
p; (1 &lt;&lt; MSI_STATUS_SHIFT)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, status, PAB_INTP_AMBA_MISC_STAT)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* routine to parse device tree */<br>
&gt; +static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pcie-&gt;pdev-&gt;dev=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct platform_device *pdev =3D pcie-&gt;pdev;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device_node *node =3D dev-&gt;of_node;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0resource_size_t iobase;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const char *type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0type =3D of_get_property(node, &quot;device_type&=
quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!type || strcmp(type, &quot;pci&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;in=
valid \&quot;device_type\&quot; %s\n&quot;, type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* map config resource */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0res =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_get_resource_byname(<wbr>p=
dev, IORESOURCE_MEM,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;confi=
g_axi_slave&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;config_axi_slave_base =3D devm_ioremap_r=
esource(dev, res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pcie-&gt;config_axi_<wbr>slave_base))<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(pcie-&=
gt;config_axi_<wbr>slave_base);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;ob_io_res =3D res;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* map csr resource */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0res =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_get_resource_byname(<wbr>p=
dev, IORESOURCE_MEM, &quot;csr_axi_slave&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;csr_axi_slave_base =3D devm_ioremap_reso=
urce(dev, res);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pcie-&gt;csr_axi_slave_<wbr>base))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(pcie-&=
gt;csr_axi_slave_<wbr>base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* map gpio resource */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(<wbr>pdev, I=
ORESOURCE_MEM, &quot;gpio_slave&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;gpio_slave_base =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devm_ioremap_nocache(dev, res-&gt;s=
tart, resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pcie-&gt;gpio_slave_base)<wbr>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(pcie-&=
gt;gpio_slave_base)<wbr>;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* map gpio resource */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource_byname(<wbr>pdev, I=
ORESOURCE_MEM, &quot;apb_csr&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;apb_csr_base =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devm_ioremap_nocache(dev, res-&gt;s=
tart, resource_size(res));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(pcie-&gt;apb_csr_base))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(pcie-&=
gt;apb_csr_base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* read the number of windows requested */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pcie-&gt;apio_wins &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of_property_read_u32(=
node, &quot;apio-wins&quot;, &amp;pcie-&gt;apio_wins)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;apio_wins =
=3D MAX_PIO_WINDOWS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pcie-&gt;ppio_wins &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0of_property_read_u32(=
node, &quot;ppio-wins&quot;, &amp;pcie-&gt;ppio_wins)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;ppio_wins =
=3D MAX_PIO_WINDOWS;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* map IRQ resource */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;irq =3D irq_of_parse_and_map(node, 0);<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D devm_request_irq(&amp;pdev-&gt;dev, pcie-=
&gt;irq, mobiveil_pcie_isr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IRQF_SHARED | IRQF_NO_THREAD,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;mobiveil-pcie&quot;, pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;unable to request IRQ %d\n&quot;, pcie-&gt;irq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&amp;pcie-&gt;<wbr>resources);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* parse the host bridge base addresses from the =
device tree file */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0err =3D of_pci_get_host_bridge_<wbr>resources(nod=
e,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00, 0xff, &amp;pcie-&gt;resources, &amp;iobase);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;Ge=
tting bridge resources failed\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * access_paged_register - routine to access paged register of root c=
omplex<br>
&gt; + *<br>
&gt; + * registers of RC are paged, with pg_sel field of the PAB_CTRL<br>
&gt; + * register needs to be updated with page of the register, before<br>
&gt; + * accessing least significant 10 bits offset<br>
&gt; + *<br>
&gt; + * This routine does the PAB_CTRL updation and split access of the<br=
>
&gt; + * offset<br>
&gt; + *<br>
&gt; + */<br>
&gt; +static unsigned int access_paged_register(struct mobiveil_pcie *pcie,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int=
 write,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int=
 val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int=
 offset)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int pab_ctrl_dw, pg_sel;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int off =3D (offset &amp; 0x3FF) + 0xC00=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pab_ctrl_dw =3D csr_readl(pcie, PAB_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pg_sel =3D (offset &gt;&gt; PAGE_SEL_OFFSET_SHIFT=
) &amp; PAGE_SEL_MASK;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* clear pg_sel field */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pab_ctrl_dw =3D (pab_ctrl_dw &amp; ~(PAGE_SEL_MAS=
K &lt;&lt; PAGE_SEL_SHIFT));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* set pg_sel field */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pab_ctrl_dw |=3D ((pg_sel &lt;&lt; PAGE_SEL_SHIFT=
));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, pab_ctrl_dw, PAB_CTRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (write =3D=3D OP_WRITE)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csr_writel(pcie, val,=
 off);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return csr_readl(pcie=
, off);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * routine to program the inbound windows<br>
&gt; + */<br>
&gt; +static void program_ib_windows(struct mobiveil_pcie *pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int win_num,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int pci_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size_kb)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int pio_ctrl_val;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int amap_ctrl_dw;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u64 size64 =3D (-1 &lt;&lt; (WIN_SIZE_SHIFT + ilo=
g2_u32(size_kb)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((pcie-&gt;ib_wins_configured + 1) &gt; pcie-&=
gt;ppio_wins) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pcie-&gt=
;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;ERROR: trying for more than max inbound windows in device tree=
 !\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pio_ctrl_val =3D csr_readl(pcie, PAB_PEX_PIO_CTRL=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pio_ctrl_val | (1 &lt=
;&lt; PIO_ENABLE_SHIFT), PAB_PEX_PIO_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0amap_ctrl_dw =3D=C2=A0 access_paged_register(pcie=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OP_READ, 0, PAB_PEX_AMAP_CTRL(win_num));=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0amap_ctrl_dw =3D (amap_ctrl_dw | (type &lt;&lt; A=
MAP_CTRL_TYPE_SHIFT));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0amap_ctrl_dw =3D (amap_ctrl_dw | (1 &lt;&lt; AMAP=
_CTRL_EN_SHIFT));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0access_paged_register(pcie, OP_WRITE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amap_ctrl_dw | (size64 &amp; 0xFFFFFFFF)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_PEX_AMAP_CTRL(win_num));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0access_paged_register(pcie, OP_WRITE, upper_32_bi=
ts(size64),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_EXT_PEX_AMAP_SIZEN(win_<wbr>num));<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0access_paged_register(pcie, OP_WRITE, pci_addr,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_PEX_AMAP_AXI_WIN(win_num))<wbr>;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0access_paged_register(pcie, OP_WRITE, pci_addr,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_PEX_AMAP_PEX_WIN_L(win_<wbr>num));<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0access_paged_register(pcie, OP_WRITE, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_PEX_AMAP_PEX_WIN_H(win_<wbr>num));<b=
r>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * routine to program the outbound windows<br>
&gt; + */<br>
&gt; +static void program_ob_windows(struct mobiveil_pcie *pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int win_num,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 cpu_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 pci_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int config_io_bit,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size_kb)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int value, type;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u64 size64 =3D (-1 &lt;&lt; (WIN_SIZE_SHIFT + ilo=
g2_u32(size_kb)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((pcie-&gt;ob_wins_configured + 1) &gt; pcie-&=
gt;apio_wins) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pcie-&gt=
;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&quot;ERROR: trying for more than max outbound windows in device tre=
e !\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * program Enable Bit to 1, Type Bit to (00) base=
 2, AXI Window Size Bit<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * to 4 KB in PAB_AXI_AMAP_CTRL register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0type =3D config_io_bit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_n=
um));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A01 &lt;&lt; WIN_ENABLE_SHIFT=C2=A0 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0type &lt;&lt; WIN_TYPE_SHIFT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0lower_32_bits(size64),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PAB_AXI_AMAP_CTRL(win_num));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0access_paged_register(pcie, OP_WRITE, upper_32_bi=
ts(size64),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_EXT_AXI_AMAP_SIZE(win_num)<wbr>);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * program AXI window base with appropriate value=
 in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * PAB_AXI_AMAP_AXI_WIN0 register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value =3D csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN(wi=
n_num))<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cpu_addr &gt;&gt; AXI_WINDOW_BASE_SHIFT &lt;&lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0AXI_WINDOW_BASE_SHIFT, PAB_AXI_AMAP_AXI_WIN(win_num))<wbr>;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value =3D csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H(=
win_<wbr>num));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, lower_32_bits(pci_addr),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PAB_AXI_AMAP_PEX_WIN_L(win_<wbr>num));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, upper_32_bits(pci_addr),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0PAB_AXI_AMAP_PEX_WIN_H(win_<wbr>num));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;ob_wins_configured++;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * routine to prepare the PCIe slot for power up<br>
&gt; + */<br>
&gt; +static void mobiveil_pcie_establish_link(<wbr>struct mobiveil_pcie *p=
cie)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int secs =3D 4;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* send PRESET to the slot */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x80000000, 0xa0344);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x80000000, 0xa0348);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x00000000, 0xa0054);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x80000000, 0xa0054);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(&amp;pcie-&gt;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mobiveil_pcie_=
establish_link: waiting for %d seconds\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 secs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mdelay(secs * 1000);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mobiveil_bringup_link(struct mobiveil_pcie *pcie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int reset_cnt =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pcie-&gt;pdev-&gt;dev=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!mobiveil_pcie_link_is_up(<wbr>pcie)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * if FSBL is not pat=
ched, link won&#39;t be up so let&#39;s bring it<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * up by writing DIRM=
 and OEN registers EMIO 6:0 programming<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * sequence [3:0] =3D=
 Link Width; [6:4] =3D Link Speed. Current<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * setting width=3D4,=
 speed =3D 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x7f=
, 0xa02c4);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x7f=
, 0xa02c8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x14=
, 0xa004c);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x02=
00, 0xa0244);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x02=
00, 0xa0248);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0x37=
f7, 0x180208);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gpio_write(pcie, 0xfd=
ff, 0xa0044);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mdelay(2 * 1000);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!mobiveil_pcie=
_link_is_up(<wbr>pcie)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_info(dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s: PRESET retry, reset_cnt : %d\=
n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func__, reset_cnt++);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mobiveil_pcie_establish_link(<wbr>pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;link up\n&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mobiveil_setup_config_access(<wbr>struct mobiveil_pcie *p=
cie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int type =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int pab_ctrl;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct resource_entry *win, *tmp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * program Bus Master Enable Bit in Command Regis=
ter in PAB Config<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Space<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value =3D csr_readl(pcie, PCI_COMMAND);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_COMMAND_IO | PCI_=
COMMAND_MEMORY | PCI_COMMAND_MASTER,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_COMMAND);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * program PIO Enable Bit to 1 (and PEX PIO Enabl=
e to 1) in PAB_CTRL<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pab_ctrl =3D csr_readl(pcie, PAB_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, pab_ctrl | (1 &lt;&lt; AMBA_PIO_=
ENABLE_SHIFT) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; PEX_PIO_E=
NABLE_SHIFT),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_CTRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_M=
SI_MASK),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PAB_INTP_AMBA_MISC_EN=
B);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* program PIO Enable Bit to 1 and Config Window =
Enable Bit to 1 in<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * PAB_AXI_PIO_CTRL Register<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0value =3D csr_readl(pcie, PAB_AXI_PIO_CTRL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, value | APIO_EN_MASK, PAB_AXI_PI=
O_CTRL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * we&#39;ll program one outbound window for conf=
ig reads and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * another default inbound window for all the ups=
tream traffic<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * rest of the outbound windows will be configure=
d according to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the &quot;ranges&quot; field defined in device=
 tree<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* config outbound translation window */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0program_ob_windows(pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pcie-&gt;ob_wins_configured, pcie-&gt;ob_io_res-&gt;start,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0CFG_WINDOW_TYPE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0resource_size(pcie-&gt;ob_io_res)<wbr>/1024);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* memory inbound=C2=A0 translation window */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW=
_TYPE, IB_WIN_SIZE_KB);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Get the I/O and memory ranges from DT */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0resource_list_for_each_entry_<wbr>safe(win, tmp, =
&amp;pcie-&gt;resources) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (resource_type(win=
-&gt;res) =3D=3D IORESOURCE_MEM)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0type =3D MEM_WINDOW_TYPE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (resource_type(win=
-&gt;res) =3D=3D IORESOURCE_IO)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0type =3D IO_WINDOW_TYPE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* configure outbound translation window */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pcie-&gt;ob_mem_res[pcie-&gt;ob_<wbr>wins_configured] =3D=C2=A0 win-=
&gt;res;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0program_ob_windows(pcie,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;ob_wins_configured,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0win-&gt;res-&gt;start,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resource_size(win-&gt;res)/1024);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* routine to setup the INTx related data */<br>
&gt; +static int mobiveil_pcie_intx_map(struct irq_domain *domain,<br>
&gt; unsigned int irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_hw_number_t hwirq)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq_set_chip_and_handler(irq, &amp;dummy_irq_chip=
, handle_simple_irq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq_set_chip_data(irq, domain-&gt;host_data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* INTx domain opeartions structure */<br>
&gt; +static const struct irq_domain_ops intx_domain_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.map =3D mobiveil_pcie_intx_map,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void mobiveil_pcie_destroy_msi(<wbr>unsigned int irq)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct msi_desc *msi;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mobiveil_pcie *pcie;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!test_bit(irq, msi_irq_in_use)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msi =3D irq_get_msi_d=
esc(irq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie =3D msi_desc_to_=
pci_sysdata(msi);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&amp;pcie-&g=
t;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;Trying to free unused MSI#%d\n&quot;, irq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clear_bit(irq, msi_ir=
q_in_use);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int mobiveil_pcie_assign_msi(<wbr>struct mobiveil_pcie *pcie)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int pos;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pos =3D find_first_zero_bit(msi_irq_<wbr>in_use, =
PCI_NUM_MSI);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pos &lt; PCI_NUM_MSI)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(pos, msi_irq_=
in_use);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOSPC;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return pos;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void mobiveil_msi_teardown_irq(<wbr>struct msi_controller *chi=
p,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int irq)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mobiveil_pcie_destroy_msi(irq)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq_dispose_mapping(irq);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int mobiveil_pcie_msi_setup_irq(<wbr>struct msi_controller *ch=
ip,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pci_dev *pdev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct msi_desc *desc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int hwirq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int irq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct msi_msg msg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0phys_addr_t msg_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mobiveil_pcie *pcie =3D pdev-&gt;bus-&gt;s=
ysdata;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0hwirq =3D mobiveil_pcie_assign_msi(pcie)<wbr>;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (hwirq &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq =3D irq_create_mapping(pcie-&gt;irq_<wbr>doma=
in, hwirq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!irq)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq_set_msi_desc(irq, desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg_addr =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virt_to_phys((void *)=
pcie-&gt;msi_pages + (hwirq * sizeof(int)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg.address_hi =3D upper_32_bits(msg_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg.address_lo =3D lower_32_bits(msg_addr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg.data =3D irq;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_write_msi_msg(irq, &amp;msg);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct msi_controller mobiveil_pcie_msi_chip =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.setup_irq =3D mobiveil_pcie_msi_setup_irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.teardown_irq =3D mobiveil_msi_teardown_irq,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct irq_chip mobiveil_msi_irq_chip =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.name =3D &quot;Mobiveil PCIe MSI&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.irq_enable =3D pci_msi_unmask_irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.irq_disable =3D pci_msi_mask_irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.irq_mask =3D pci_msi_mask_irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.irq_unmask =3D pci_msi_unmask_irq,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int mobiveil_pcie_msi_map(struct irq_domain *domain,<br>
&gt; unsigned int irq,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_hw_number_t hwirq)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq_set_chip_and_handler(irq, &amp;mobiveil_msi_i=
rq_chip,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 handle_simple_irq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0irq_set_chip_data(irq, domain-&gt;host_data);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct irq_domain_ops msi_domain_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.map =3D mobiveil_pcie_msi_map,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void mobiveil_pcie_enable_msi(<wbr>struct mobiveil_pcie *pcie)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0phys_addr_t msg_addr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;msi_pages =3D (void *)__get_free_pages(G=
FP_DMA, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msg_addr =3D virt_to_phys((void *)pcie-&gt;msi_pa=
ges);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;msi_pages_phys =3D (void *)msg_addr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel_relaxed(lower_32_bits(<wbr>msg_addr),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;apb_csr_base=
 + MSI_BASE_LO_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel_relaxed(upper_32_bits(<wbr>msg_addr),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;apb_csr_base=
 + MSI_BASE_HI_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel_relaxed(4096, pcie-&gt;apb_csr_base + MSI_=
SIZE_OFFSET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0writel_relaxed(1 &lt;&lt; MSI_ENABLE_SHIFT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;apb_csr_base=
 + MSI_ENABLE_OFFSET);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int mobiveil_pcie_init_irq_domain(<wbr>struct mobiveil_pcie *p=
cie)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pcie-&gt;pdev-&gt;dev=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct device_node *node =3D dev-&gt;of_node;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Setup INTx */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;irq_domain =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0irq_domain_add_linear=
(node, PCI_NUM_INTX + 1, &amp;intx_domain_ops,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pcie-&gt;irq_domain) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;Fa=
iled to get a INTx IRQ domain\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Setup MSI */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ENABLED(CONFIG_PCI_MSI)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie-&gt;irq_domain =
=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0irq_domain_add_linear(node,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PCI_NUM_MSI,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;msi_domain_ops,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;mobiveil_pcie_msi_chip);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pcie-&gt;irq_dom=
ain) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dev_err(dev, &quot;Failed to get a MSI IRQ domain\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return PTR_ERR(pcie-&gt;irq_domain);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mobiveil_pcie_enable_=
msi(pcie)<wbr>;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int mobiveil_pcie_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct mobiveil_pcie *pcie;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct pci_bus *bus;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct pci_bus *child;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* allocate the PCIe port */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie =3D devm_kzalloc(&amp;pdev-&gt;dev, sizeof(*=
pcie), GFP_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!pcie)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pcie-&gt;pdev =3D pdev;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* parse the device tree */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D mobiveil_pcie_parse_dt(pcie);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;Parsing DT failed, ret: %x\n&quot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* setup the PCIe slot link power*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mobiveil_bringup_link(pcie);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * configure all inbound and outbound windows and=
 prepare the RC for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * config access<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0mobiveil_setup_config_access(<wbr>pcie);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* fixup for PCIe class register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0csr_writel(pcie, 0x060402AB, PAB_INTP_AXI_PIO_CLA=
SS);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* initialize the IRQ domains */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D mobiveil_pcie_init_irq_domain(<wbr>pcie);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;Failed creating IRQ Domain\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* create the PCIe root bus */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bus =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_create_root_bus(&amp;pdev-&gt;<wbr>dev, 0,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;mobiveil_pcie_ops, pcie, &amp;pcie-&gt;resources);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!bus)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* setup MSI, if enabled */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ENABLED(CONFIG_PCI_MSI)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mobiveil_pcie_msi_chi=
p.dev =3D &amp;pcie-&gt;pdev-&gt;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bus-&gt;msi =3D &amp;=
mobiveil_pcie_msi_chip;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* setup the kernel resources for the newly added=
 PCIe root bus */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_scan_child_bus(bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_assign_unassigned_bus_<wbr>resources(bus);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0list_for_each_entry(child, &amp;bus-&gt;children,=
 node)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcie_bus_configure_se=
ttings(<wbr>child);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_fixup_irqs(pci_common_<wbr>swizzle, of_irq_pa=
rse_and_map_pci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pci_bus_add_devices(bus);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, pcie);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct of_device_id mobiveil_pcie_of_match[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{.compatible =3D &quot;mbvl,axi-pcie-host-1.00&qu=
ot;,},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{},<br>
&gt; +};<br>
&gt; +<br>
&gt; +MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);<br>
&gt; +<br>
&gt; +static struct platform_driver mobiveil_pcie_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.probe =3D mobiveil_pcie_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.name =3D &quot;mobiveil-pcie&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.of_match_table =3D mobiveil_pcie_of_match,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.suppress_bind_attrs =3D true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; +};<br>
&gt; +<br>
&gt; +builtin_platform_driver(<wbr>mobiveil_pcie_driver);<br>
&gt; +<br>
&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;Mobiveil PCIe host controller driver&quot;);=
<br>
&gt; +MODULE_AUTHOR(&quot;Subrahmanya Lingappa &lt;<a href=3D"mailto:l.subr=
ahmanya@mobiveil.co.in">l.subrahmanya@mobiveil.co.in</a>&gt;<wbr>&quot;);<b=
r>
&gt; --<br>
&gt; 1.8.3.1<br>
</div></div></blockquote></div><br></div></div>

--f403045f5352ca4050055e776c3a--
