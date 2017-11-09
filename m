Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:56721 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdKIMCw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 07:02:52 -0500
Received: by mail-it0-f65.google.com with SMTP id r127so10424504itb.5
        for <linux-pci@vger.kernel.org>; Thu, 09 Nov 2017 04:02:51 -0800 (PST)
Subject: [PATCH 1/1 v2 ] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP
 driver
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Peter W Newton <peter.newton@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
References: <CAFZiPx3yvDY-qOkTeakyKuk+G=bXGFxjEvPxeQLy+qW0jwpBiA@mail.gmail.com>
From: subrahmanya_lingappa <l.subrahmanya@mobiveil.co.in>
Message-ID: <0ebbcfea-4186-5987-bdf1-3288a4e1f907@mobiveil.co.in>
Date: Thu, 9 Nov 2017 17:33:03 +0530
MIME-Version: 1.0
In-Reply-To: <CAFZiPx3yvDY-qOkTeakyKuk+G=bXGFxjEvPxeQLy+qW0jwpBiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 From f0eef95dec090bd211b398dee52c31c18212be9a Mon Sep 17 00:00:00 2001
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Thu, 9 Nov 2017 01:46:10 -0500
Subject: [PATCH 1/1 v2 ] PCI: Mobiveil: Add Mobiveil PCIe Host Bridge IP 
driver

This is the driver for Mobiveil  AXI PCIe Host Bridge Soft IP

Cc: bhelgaas@google.com

Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
  .../devicetree/bindings/pci/mobiveil-pcie.txt      |   67 ++
  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
  MAINTAINERS                                        |    8 +
  drivers/pci/host/Kconfig                           |   10 +
  drivers/pci/host/Makefile                          |    1 +
  drivers/pci/host/pcie-mobiveil.c                   | 1144 
++++++++++++++++++++
  6 files changed, 1231 insertions(+)
  create mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
  create mode 100644 drivers/pci/host/pcie-mobiveil.c

diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt 
b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
new file mode 100644
index 0000000..2426cab
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
@@ -0,0 +1,67 @@
+* mobiveil AXI PCIe Root Port Bridge DT description
+
+Required properties:
+- #address-cells: Address representation for root ports, set to <3>
+- #size-cells: Size representation for root ports, set to <2>
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+- compatible: Should contain "mbvl,axi-pcie-host-1.00"
+- reg: Should contain AXI PCIe registers location and length
+- device_type: must be "pci"
+- interrupts: Should contain AXI PCIe interrupt
+- interrupt-map-mask,
+  interrupt-map: standard PCI properties to define the mapping of the
+	PCI interface to interrupt numbers.
+- ranges: ranges for the PCI memory regions (I/O space region is not
+	supported by hardware)
+	Please refer to the standard PCI bus binding document for a more
+	detailed explanation
+
+Optional properties for Zynq/Microblaze:
+- bus-range: PCI bus numbers covered
+
+Interrupt controller child node
++++++++++++++++++++++++++++++++
+Required properties:
+- interrupt-controller: identifies the node as an interrupt controller
+- #address-cells: specifies the number of cells needed to encode an
+	address. The value must be 0.
+- #interrupt-cells: specifies the number of cells needed to encode an
+	interrupt source. The value must be 1.
+
+NOTE:
+The core provides a single interrupt for both INTx/MSI messages. So,
+created a interrupt controller node to support 'interrupt-map' DT
+functionality.  The driver will create an IRQ domain for this map, decode
+the four INTx interrupts in ISR and route them to this domain.
+
+
+Example:
+++++++++
+	pci_express: axi-pcie@a0000000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		compatible = "mbvl,axi-pcie-host-1.00";
+	        reg =   < 0xa0000000 0x1000
+                     	  0xb0000000 0x00010000
+                          0xFF000000 0x200000
+                          0xb0010000 0x1000 >;
+	        reg-names = "config_axi_slave",
+                            "csr_axi_slave",
+                            "gpio_slave",
+                            "apb_csr";
+
+		device_type = "pci";
+		interrupt-parent = <&gic>;
+		interrupts = < 0 89 4 >;
+		interrupt-controller;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pci_express 1>,
+				<0 0 0 2 &pci_express 2>,
+				<0 0 0 3 &pci_express 3>,
+				<0 0 0 4 &pci_express 4>;
+		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
+
+	};
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt 
b/Documentation/devicetree/bindings/vendor-prefixes.txt
index f0a48ea..29172e0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -179,6 +179,7 @@ msi	Micro-Star International Co. Ltd.
  mti	Imagination Technologies Ltd. (formerly MIPS Technologies Inc.)
  mundoreader	Mundo Reader S.L.
  murata	Murata Manufacturing Co., Ltd.
+mbvl Mobiveil Inc.
  mxicy	Macronix International Co., Ltd.
  national	National Semiconductor
  nec	NEC LCD Technologies, Ltd.
diff --git a/MAINTAINERS b/MAINTAINERS
index 63cefa6..6f3212e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9336,6 +9336,14 @@ F: 
Documentation/devicetree/bindings/pci/host-generic-pci.txt
  F:	drivers/pci/host/pci-host-common.c
  F:	drivers/pci/host/pci-host-generic.c

+PCI DRIVER FOR ALTERA PCIE IP
+M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+F:	drivers/pci/host/pcie-mobiveil.c
+
+
  PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (VMD)
  M:	Keith Busch <keith.busch@intel.com>
  L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 6f1de4f..c6a1209 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -37,6 +37,15 @@ config PCIE_XILINX_NWL
  	 or End Point. The current option selection will only
  	 support root port enabling.

+config PCIE_MOBIVEIL
+	bool "Mobiveil AXI PCIe host bridge support"
+	depends on ARCH_ZYNQMP
+	depends on PCI_MSI_IRQ_DOMAIN
+	help
+	  Say 'Y' here if you want kernel to support the Mobiveil AXI PCIe
+	  Host Bridge driver.
+
+
  config PCIE_DW_PLAT
  	bool "Platform bus based DesignWare PCIe Controller"
  	depends on PCI_MSI_IRQ_DOMAIN
@@ -103,6 +112,7 @@ config PCI_HOST_GENERIC
  	  Say Y here if you want to support a simple generic PCI host
  	  controller, such as the one emulated by kvmtool.

+
  config PCIE_SPEAR13XX
  	bool "STMicroelectronics SPEAr PCIe controller"
  	depends on ARCH_SPEAR13XX
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 9b113c2..0f2b5f5 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o 
pci-keystone.o
  obj-$(CONFIG_PCIE_XDMA_PL) += pcie-xdma-pl.o
  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
  obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
+obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
  obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
diff --git a/drivers/pci/host/pcie-mobiveil.c 
b/drivers/pci/host/pcie-mobiveil.c
new file mode 100644
index 0000000..3c1edf6
--- /dev/null
+++ b/drivers/pci/host/pcie-mobiveil.c
@@ -0,0 +1,1144 @@
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright mobiveil Corporation (C) 2013-2017. All rights reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public 
License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License 
along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/irqdomain.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+/*Register Offsets and Bit Positions*/
+
+#define BAR_MAP_BASE                0x00000000
+#define WIN1_BAR_MAP_DISTANCE       0x8000000
+#define WIN2_BAR_MAP_DISTANCE       0x4000000
+#define WIN3_BAR_MAP_DISTANCE       0x8000000
+#define WIN_NUM_0                   0
+#define WIN_NUM_1                   1
+#define WIN_NUM_2                   2
+#define WIN_NUM_3                   3
+
+#define PAB_INTA_POS			5
+#define OP_READ				0
+#define OP_WRITE			1
+
+#define WIN_1_SIZE                  (1024 * 1024)
+#define WIN_1_BASE                  (0xa0000000)
+#define WIN_2_SIZE                  (128 * 1024 * 1024)
+#define WIN_2_BASE                  (WIN_1_BASE + WIN_1_SIZE)
+#define IB_WIN_SIZE_KB              (1*1024*1024*1024)
+#define OB_CFG_WIN_SIZE_KB              (0x0010000/1024)	// 64KB
+#define OB_MEM_WIN_SIZE_KB              (0x8000000/1024)	// 128MB
+
+/* ltssm_state_status*/
+#define LTSSM_STATE_STATUS_REG		0x0404
+#define LTSSM_STATUS_CODE_MASK		0x3F
+#define LTSSM_STATUS_CODE		0x2D	/* LTSSM Status Code L0 */
+
+#define PAB_CAP_REG                 0x0804
+#define PAB_CTRL_REG                0x0808
+#define AMBA_PIO_ENABLE_BIT		0
+#define PEX_PIO_ENABLE_BIT		1
+
+#define PAB_AXI_PIO_CTRL_REG(engine)		(0x0840 + 0x10*engine)
+#define  PIO_ENABLE_BIT		0
+#define  CFG_WINDOW_TYPE		0
+#define  IO_WINDOW_TYPE		1
+#define  MEM_WINDOW_TYPE		2
+
+#define PAB_PEX_PIO_CTRL_REG		0x08C0
+#define PAB_INTP_AMBA_MISC_ENB		0x0B0C
+#define PAB_INTP_AMBA_MISC_STAT		0x0B1C
+#define  PAB_INTP_INTX_MASK		0x1E0	/* INTx(A-D) */
+#define  PAB_INTP_MSI_MASK		0x8
+
+#define PAB_AXI_AMAP_CTRL_REG(win_num)  (0x0BA0 + 0x10*win_num)
+#define PAB_EXT_AXI_AMAP_SIZE(win_num)  (0xBAF0 + 0x4*win_num)
+#define  ENABLE_BIT		0
+#define  TYPE_BIT		1
+#define  AXI_WINDOW_SIZE_BIT		10
+
+#define PAB_AXI_AMAP_AXI_WIN_REG(win_num)       (0x0BA4 + 0x10*win_num)
+#define  AXI_WINDOW_BASE_BIT		2
+#define PAB_EXT_AXI_AMAP_AXI_WIN_REG(win_num)   (0x80A0 + 0x4*win_num)
+
+#define PAB_AXI_AMAP_PEX_WIN_L_REG(win_num)     (0x0BA8 + 0x10*win_num)
+#define  BUS_BIT		24
+#define  DEVICE_BIT		19
+#define  FUNCTION_BIT		16
+#define  REGISTER_BIT		0
+
+#define PAB_AXI_AMAP_PEX_WIN_H_REG(win_num) (0x0BAC + 0x10*win_num)
+#define PAB_INTP_AXI_PIO_ENB_REG        0xB00
+#define PAB_INTP_AXI_PIO_STAT_REG       0xB10
+#define PAB_INTP_AXI_PIO_VENID_REG      0x470
+#define PAB_INTP_AXI_PIO_DEVID_REG      0x472
+#define PAB_INTP_AXI_PIO_CLASS_REG      0x474
+
+#define PAB_PEX_AMAP_CTRL(win_num)      (0x4BA0 + (0x10*win_num))
+#define PAB_EXT_PEX_AMAP_SIZEN(win_num) (0xBEF0 + (0x4*win_num))
+#define PAB_PEX_AMAP_AXI_WIN(win_num)   (0x4BA4 + (0x10*win_num))
+#define PAB_PEX_AMAP_PEX_WIN_L(win_num) (0x4BA8 + (0x10*win_num))
+#define PAB_PEX_AMAP_PEX_WIN_H(win_num) (0x4BAC + (0x10*win_num))
+
+#define INTX_NUM                        4
+#define MOBIVEIL_NUM_MSI_IRQS           16
+
+#define MSI_BASE_LO_OFFSET		0x04
+#define MSI_BASE_HI_OFFSET		0x08
+#define MSI_SIZE_OFFSET		0x0c
+#define MSI_ENABLE_OFFSET		0x14
+#define MSI_ENABLE_BIT_POS		0
+#define MSI_STATUS_OFFSET		0x18
+#define MSI_STATUS_BIT_POS		0
+#define MSI_OCCUPANCY_OFFSET		0x1c
+#define MSI_DATA_OFFSET		0x20
+#define MSI_ADDR_L_OFFSET		0x24
+#define MSI_ADDR_H_OFFSET		0x28
+
+#define ilog2_u32(num) (__ffs(num)-1)
+
+/*	local prototypes */
+static irqreturn_t mobiveil_pcie_isr(int irq, void *data);
+
+/*
+ *	PCIe port information
+ */
+struct mobiveil_pcie {
+	/* platform device pointer */
+	struct platform_device *pdev;
+	/* memory  mapped register base for endpoint config access */
+	void __iomem *config_axi_slave_base;
+	/* memory mapped register  base for root port config access */
+	void __iomem *csr_axi_slave_base;
+	/* memory mapped GPIO register base for root port config access */
+	void __iomem *gpio_slave_base;
+	/* memory mapped GPIO register base for root port config access */
+	void __iomem *apb_csr_base;
+	/* irq domain associated with root port */
+	struct irq_domain *irq_domain;
+	/* bus range resource */
+	struct resource bus_range;
+	/* head pointer for all the enumerated resources */
+	struct list_head resources;
+	/*  Virtual and physical addresses of the MSI data */
+	int *msi_pages;
+	int *msi_pages_phys;
+	/* Root port bus number */
+	u8 root_bus_nr;
+	/* IRQ number */
+	int irq;
+};
+
+/*
+ *	union pab_pex_amap_ctrl_t - PAB_PEX_AMAP register bitfields
+ */
+__packed union pab_pex_amap_ctrl_t{
+	int dw;
+
+	__packed struct {
+
+		int enable:1;
+		int type:2;
+		int no_snoop_ov_en:1;
+		int no_snoop:1;
+		int rsvd:5;
+		int size:22;
+	};
+};
+
+/*
+ *	union pab_ctrl_t - PAB_CTRL register bitfields
+ */
+__packed union pab_ctrl_t{
+	int dw;
+
+	__packed struct {
+
+		int amba_pio:1;
+		int pex_pio:1;
+		int wdma:1;
+		int rdma:1;
+		int axi_max_burst_len:2;
+		int rsvd:1;
+		int dma_pio_arb:1;
+		int prefetch_depth:2;
+		int mrrs:3;
+		int pg_sel:6;
+		int func_sel:9;
+		int res1:1;
+		int msi_sw_ctrl_en:1;
+		int res2:2;
+	};
+};
+
+/*	global variables  */
+
+u32 serving_interrupt = 0, max_msi_allocated = 0;
+u32 msi_ints = 0, msi_msgs = 0;
+static DECLARE_BITMAP(msi_irq_in_use, MOBIVEIL_NUM_MSI_IRQS);
+
+/*
+ *	csr_writel - routine to write one DWORD to memory mapper register
+ *
+ *	@pcie :   pointer to root port
+ *	@value:   value to be written to register
+ *	@reg  :   register offset
+ */
+static inline void csr_writel(struct mobiveil_pcie *pcie, const u32 value,
+			      const u32 reg)
+{
+	writel_relaxed(value, pcie->csr_axi_slave_base + reg);
+}
+
+/*
+ *	csr_readl - routine to read one DWORD from memory mapper register
+ *
+ *	@pcie :    pointer to root port
+ *	@reg  :    register offset
+ */
+
+static inline u32 csr_readl(struct mobiveil_pcie *pcie, const u32 reg)
+{
+	return readl_relaxed(pcie->csr_axi_slave_base + reg);
+}
+
+/*
+ *	mobiveil_pcie_link_is_up - routine to check if PCIe link is up
+ *
+ *	@pcie :    pointer to root port
+ */
+
+static bool mobiveil_pcie_link_is_up(struct mobiveil_pcie *pcie)
+{
+	return (csr_readl(pcie, LTSSM_STATE_STATUS_REG) &
+		LTSSM_STATUS_CODE_MASK) == LTSSM_STATUS_CODE;
+}
+
+/*
+ *	mobiveil_pcie_valid_device - routine to check if a valid device/function
+ *	is present on the bu
+ *
+ *	@pcie :    pointer to root por
+ */
+static bool mobiveil_pcie_valid_device(struct pci_bus *bus, u32 devfn)
+{
+	struct mobiveil_pcie *pcie = bus->sysdata;
+
+	/* Check if link is up when trying to access downstream ports */
+	if (bus->number != pcie->root_bus_nr)
+		if (!mobiveil_pcie_link_is_up(pcie))
+			return false;
+
+	/* Only one device down on each root port */
+	if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
+		return false;
+
+	/* Do not read more than one device on the bus directly
+	 * attached to RC
+	 */
+	if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
+		return false;
+
+	return true;
+}
+
+/*
+ *	mobiveil_pcie_map_bus - routine to get the configuration base of either
+ *	root port or endpoin
+ *
+ *	@bus  :   pointer to local bu
+ *	@devfn:   variable containing the device and function number
+ *	@where:   register offse
+ */
+static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
+					   u32 devfn, int where)
+{
+	struct mobiveil_pcie *pcie = bus->sysdata;
+	void __iomem *addr = NULL;
+
+	if (!mobiveil_pcie_valid_device(bus, devfn))
+		return NULL;
+
+	if (bus->number == pcie->root_bus_nr) {
+		/* RC config access (in CSR space) */
+		addr = pcie->csr_axi_slave_base + where;
+	} else {
+		/* EP config access (in Config/APIO space) */
+		u32 value;
+
+		/* Program PEX Address base (31..16 bits) with appropriate value
+		 * (BDF) in PAB_AXI_AMAP_PEX_WIN_L0 Register
+		 */
+		value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_L_REG(0));
+		csr_writel(pcie,
+			   bus->
+			   number << BUS_BIT | (devfn >> 3) << DEVICE_BIT |
+			   (devfn & 7) << FUNCTION_BIT,
+			   PAB_AXI_AMAP_PEX_WIN_L_REG(0));
+		addr = pcie->config_axi_slave_base + where;
+	}
+	return addr;
+}
+
+/*	PCIe operations */
+static struct pci_ops mobiveil_pcie_ops = {
+	.map_bus = mobiveil_pcie_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
+/*
+ *	mobiveil_pcie_isr - interrupt handler for root complex
+ *
+ *	@irq    : IRQ numbe
+ *	@data   : pointer to driver specific data
+ */
+static irqreturn_t mobiveil_pcie_isr(int irq, void *data)
+{
+	struct mobiveil_pcie *pcie;
+	u32 status, shifted_status, status2;
+	u32 bit1 = 0, virq = 0;
+	u32 val, mask;
+
+	if (serving_interrupt == 0)
+		serving_interrupt = 1;
+	else
+		return IRQ_NONE;
+
+	pcie = (struct mobiveil_pcie *)data;
+
+	val = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
+	status2 = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);
+	mask = csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
+	status = val & mask;
+
+	if (status & PAB_INTP_INTX_MASK) {
+		while ((shifted_status =
+			(csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT) >>
+			 PAB_INTA_POS)) != 0) {
+			for_each_set_bit(bit1, &shifted_status, INTX_NUM) {
+				/* clear interrupts */
+				csr_writel(pcie, shifted_status << PAB_INTA_POS,
+					   PAB_INTP_AMBA_MISC_STAT);
+
+				virq =
+				    irq_find_mapping(pcie->irq_domain,
+						     bit1 + 1);
+				if (virq)
+					generic_handle_irq(virq);
+				else
+					dev_err(&pcie->pdev->dev,
+						"unexpected IRQ, INT%d\n",
+						bit1);
+
+			}
+			shifted_status = 0;
+		}
+	}
+
+	if ((status & PAB_INTP_MSI_MASK)
+	    || (status2 & (1 << MSI_STATUS_BIT_POS))) {
+		u32 fifo_occ = 0;
+		u32 msi_addr_l = 0, msi_addr_h = 0, msi_data = 0;
+
+		do {
+			fifo_occ = readl(pcie->apb_csr_base
+					+ MSI_OCCUPANCY_OFFSET);
+			msi_data = readl(pcie->apb_csr_base
+					+ MSI_DATA_OFFSET);
+			msi_addr_l = readl(pcie->apb_csr_base
+					+ MSI_ADDR_L_OFFSET);
+			msi_addr_h = readl(pcie->apb_csr_base
+					+ MSI_ADDR_H_OFFSET);
+			/* Handle MSI */
+			if (msi_data)
+				generic_handle_irq(msi_data);
+			else
+				dev_err(&pcie->pdev->dev, "MSI data null\n");
+
+			status2 = readl(pcie->apb_csr_base + MSI_STATUS_OFFSET);
+		} while ((status2 & (1 << MSI_STATUS_BIT_POS)));
+	}
+
+	csr_writel(pcie, status, PAB_INTP_AMBA_MISC_STAT);
+	serving_interrupt = 0;
+	return IRQ_HANDLED;
+}
+
+/*
+ *	map_resource_base - routine to parse the device tree memory resource
+ *	and remap it; returns the remapped address.
+ *
+ *	@pcie       : pointer to root port
+ *	@res_name   : pointer to the device tree resource name
+ *
+ */
+void __iomem *map_resource_base(struct mobiveil_pcie *pcie, s8 *res_name)
+{
+	struct platform_device *pdev = pcie->pdev;
+	struct resource *res;
+	void __iomem *res_base;
+
+	/* read  resource */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
+	if (!res) {
+		dev_err(&pdev->dev, "no %s memory resource defined\n",
+			res_name);
+		return res;
+	}
+
+	/* remap  resource */
+	res_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(res_base)) {
+		dev_err(&pdev->dev, "failed to map %s memory\n", res_name);
+		return res_base;
+	}
+
+	return res_base;
+}
+
+/*
+ *	remap_reg_base - routine to parse the device tree registers base
+ *	resource and remap it.
+ *
+ *	@pcie       : pointer to root port
+ *	@res_name   : pointer to the device tree resource name
+ *
+ *	returns the remapped address
+ *
+ */
+void __iomem *remap_reg_base(struct mobiveil_pcie *pcie, s8 *res_name)
+{
+
+	struct platform_device *pdev = pcie->pdev;
+	struct resource *res;
+	void __iomem *res_base;
+
+	/* read  resource */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
+	if (!res) {
+		dev_err(&pdev->dev, "no %s memory resource defined\n",
+			res_name);
+		return res;
+	}
+
+	/* remap  resource */
+	res_base = ioremap_nocache(res->start, resource_size(res));
+	if (IS_ERR(res_base)) {
+		dev_err(&pdev->dev, "failed to map %s memory\n", res_name);
+		return res_base;
+	}
+
+	return res_base;
+}
+
+/*
+ *	pcie_request_irq - Routrine to parse the device tree and map the
+ *	IRQ number.
+ *
+ *	@pcie       : pointer to root port
+ *
+ *	returns the mapped IRQ number
+ */
+int pcie_request_irq(struct mobiveil_pcie *pcie)
+{
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+	int ret = 0, irq = 0;
+
+	/* map IRQ */
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+		return -EINVAL;
+	}
+	ret = devm_request_irq(&pdev->dev, irq, mobiveil_pcie_isr,
+			       IRQF_SHARED | IRQF_NO_THREAD,
+			       "mobiveil-pcie", pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to request irq %d\n", irq);
+		return ret;
+
+	}
+
+	return irq;
+}
+
+/*
+ *	mobiveil_pcie_parse_dt - routine to parse the device tree structure and
+ *	extract the resource info
+ *
+ *	@pcie :    pointer to root port
+ */
+
+static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+	const s8 *type;
+
+	type = of_get_property(node, "device_type", NULL);
+	if (!type || strcmp(type, "pci")) {
+		dev_err(dev, "invalid \"device_type\" %s\n", type);
+		return -EINVAL;
+	}
+
+	/* map config resource */
+	pcie->config_axi_slave_base =
+		map_resource_base(pcie, "config_axi_slave");
+	if (IS_ERR(pcie->config_axi_slave_base))
+		return PTR_ERR(pcie->config_axi_slave_base);
+
+	/* map csr resource */
+	pcie->csr_axi_slave_base = map_resource_base(pcie, "csr_axi_slave");
+	if (IS_ERR(pcie->csr_axi_slave_base))
+		return PTR_ERR(pcie->csr_axi_slave_base);
+
+	/* map gpio resource */
+	pcie->gpio_slave_base = remap_reg_base(pcie, "gpio_slave");
+	if (IS_ERR(pcie->gpio_slave_base))
+		return PTR_ERR(pcie->gpio_slave_base);
+
+	/* map gpio resource */
+	pcie->apb_csr_base = remap_reg_base(pcie, "apb_csr");
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->gpio_slave_base);
+
+	/* map IRQ resource */
+	pcie->irq = pcie_request_irq(pcie);
+	if (pcie->irq  < 0)
+		return pcie->irq;
+
+	return 0;
+}
+
+/*
+ *	access_paged_register - routine to access paged register of root complex
+ *
+ *	@pcie   : pointer to rootport
+ *	@write  : type of operation flag
+ *	@val    : value to be written to the register
+ *	@offset : full offset of the register address
+ *
+ *	registers of RC are paged, with pg_sel field of the PAB_CTRL_REG
+ *	register needs to be updated with page of the register, before
+ *	accessing least significant 10 bits offset
+ *
+ *	This routine does the PAB_CTRL_REG updation and split access of the
+ *	offset
+ *
+ *
+ */
+u32 access_paged_register(struct mobiveil_pcie *pcie,
+				   u32 write, u32 val,
+				   u32 offset)
+{
+	union pab_ctrl_t pab_ctrl;
+	u32 off = (offset & 0x3FF) + 0xC00;
+
+	pab_ctrl.dw = csr_readl(pcie, PAB_CTRL_REG);
+	pab_ctrl.pg_sel = (offset >> 10) & 0x3F;
+	csr_writel(pcie, pab_ctrl.dw, PAB_CTRL_REG);
+
+	if (write == OP_WRITE)
+		csr_writel(pcie, val, off);
+	else
+		return csr_readl(pcie, off);
+	return 0;
+}
+
+/*
+ *	program_ib_windows - routine to program the inbound windows of
+ *	Rootport
+ *
+ *	@pcie   : pointer to rootpor
+ */
+void program_ib_windows(struct mobiveil_pcie *pcie)
+{
+	int value;
+	int window = WIN_NUM_1;
+	union pab_pex_amap_ctrl_t amap_ctrl;
+	int ib_start = 0;
+	int size_kb = IB_WIN_SIZE_KB;
+
+	u64 size64 = (-1 << (AXI_WINDOW_SIZE_BIT + ilog2_u32(size_kb)));
+
+	value = csr_readl(pcie, PAB_PEX_PIO_CTRL_REG);
+	csr_writel(pcie, value | 0x01, PAB_PEX_PIO_CTRL_REG);
+
+	amap_ctrl.dw =
+	    access_paged_register(pcie, OP_READ, 0, PAB_PEX_AMAP_CTRL(window));
+	amap_ctrl.enable = 1;
+	amap_ctrl.type = 2;	/* 0: interrupt, 2: prefetchable memory */
+	access_paged_register(pcie, OP_WRITE,
+			      amap_ctrl.dw | (size64 & 0xFFFFFFFF),
+			      PAB_PEX_AMAP_CTRL(window));
+	access_paged_register(pcie, OP_WRITE, (size64 >> 32),
+			      PAB_EXT_PEX_AMAP_SIZEN(window));
+
+	access_paged_register(pcie, OP_WRITE, ib_start,
+			      PAB_PEX_AMAP_AXI_WIN(window));
+	access_paged_register(pcie, OP_WRITE, ib_start,
+			      PAB_PEX_AMAP_PEX_WIN_L(window));
+	access_paged_register(pcie, OP_WRITE, 0x00000000,
+			      PAB_PEX_AMAP_PEX_WIN_H(window));
+}
+
+/*
+ *	program_ob_windows - routine to program the outbound windows of R
+ *
+ *	@pcie                 : pointer to rootport
+ *	@win_num              : window number
+ *	@pci_axi_window_base  : AXI window base
+ *	@pex_addr_base_lower  : PCI window base
+ *	@config_io_bit        : flag bit to indecate memory or IO type
+ *	@size_kb              : window size requester
+ */
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
+			u64 pci_axi_window_base, u64 pex_addr_base_lower,
+			int config_io_bit, int size_kb)
+{
+	u32 value, type;
+	u64 size64 = (-1 << (AXI_WINDOW_SIZE_BIT + ilog2_u32(size_kb)));
+
+	/* Program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
+	 * to 4 KB in PAB_AXI_AMAP_CTRL Register
+	 */
+	type = config_io_bit;
+	value = csr_readl(pcie, PAB_AXI_AMAP_CTRL_REG(win_num));
+	csr_writel(pcie,
+		   1 << ENABLE_BIT | type << TYPE_BIT | (size64 & 0xFFFFFFFF),
+		   PAB_AXI_AMAP_CTRL_REG(win_num));
+	access_paged_register(pcie, OP_WRITE, (size64 >> 32),
+			      PAB_EXT_AXI_AMAP_SIZE(win_num));
+
+	/* Program AXI window base with appropriate value in
+	 * PAB_AXI_AMAP_AXI_WIN0
+	 * Register
+	 */
+	value = csr_readl(pcie, PAB_AXI_AMAP_AXI_WIN_REG(win_num));
+	csr_writel(pcie,
+		   pci_axi_window_base >> AXI_WINDOW_BASE_BIT <<
+		   AXI_WINDOW_BASE_BIT, PAB_AXI_AMAP_AXI_WIN_REG(win_num));
+
+	value = csr_readl(pcie, PAB_AXI_AMAP_PEX_WIN_H_REG(win_num));
+	csr_writel(pcie, pex_addr_base_lower,
+		   PAB_AXI_AMAP_PEX_WIN_L_REG(win_num));
+	csr_writel(pcie, 0, PAB_AXI_AMAP_PEX_WIN_H_REG(win_num));
+
+}
+
+/*
+ *	gpio_read -  routine to read a GPIO register
+ *
+ *	@pcie - pcie root port
+ *	@addr - register address
+ *
+ */
+int gpio_read(struct mobiveil_pcie *pcie, int addr)
+{
+	return ioread32(pcie->gpio_slave_base + addr);
+}
+
+/*
+ *	gpio_write -  routine to write a GPIO register
+ *
+ *	@pcie - pcie root port
+ *	@addr - register address
+ *
+ */
+void gpio_write(struct mobiveil_pcie *pcie, int val, int addr)
+{
+	iowrite32(val, pcie->gpio_slave_base + addr);
+	if (val != gpio_read(pcie, addr)) {
+		pr_info("ERROR:gpio_write: expected : %x at: %x, found: %x\n ",
+		       val, addr, gpio_read(pcie, addr));
+	}
+}
+
+/*
+ *	mobiveil_pcie_powerup_slot - routine to prepare the RC for config access
+ *
+ *	@pcie                 : pointer to rootport
+ */
+void mobiveil_pcie_powerup_slot(struct mobiveil_pcie *pcie)
+{
+
+	int secs = 0;
+
+	// sent PRESET to the slot
+	gpio_write(pcie, 0x80000000, 0xa0344);
+	gpio_write(pcie, 0x80000000, 0xa0348);
+	gpio_write(pcie, 0x00000000, 0xa0054);
+	gpio_write(pcie, 0x80000000, 0xa0054);
+	secs = 4;
+	pr_info("mobiveil_pcie_powerup_slot: waitring for %d seconds\n", secs);
+	mdelay(secs * 1000);
+
+}
+
+/*
+ *	mobiveil_pcie_setup_csr_for_config_access - routine to prepare the RC
+ *	for config access
+ *
+ *	@pcie                 : pointer to rootport
+ *
+ */
+void mobiveil_pcie_setup_csr_for_config_access(struct mobiveil_pcie *pcie)
+{
+	u32 value;
+	union pab_ctrl_t pab_ctrl;
+
+	/* Program Bus Master Enable Bit in Command Register in PAB Config
+	 * Space
+	 */
+	value = csr_readl(pcie, PCI_COMMAND);
+	csr_writel(pcie,
+		   value | PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+		   PCI_COMMAND_MASTER, PCI_COMMAND);
+
+	/* Program PIO Enable Bit to 1 (and PEX PIO Enable to 1) in PAB_CTRL
+	 * Register
+	 */
+	pab_ctrl.dw = csr_readl(pcie, PAB_CTRL_REG);
+	pab_ctrl.amba_pio = 1;
+	pab_ctrl.pex_pio = 1;
+	csr_writel(pcie, pab_ctrl.dw, PAB_CTRL_REG);
+
+	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
+		   PAB_INTP_AMBA_MISC_ENB);
+
+	/* Program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
+	 * PAB_AXI_PIO_CTRL Register
+	 */
+	value = csr_readl(pcie, PAB_AXI_PIO_CTRL_REG(0));
+	csr_writel(pcie, value | 0xf, PAB_AXI_PIO_CTRL_REG(0));
+
+	/* Config outbound translation window */
+	program_ob_windows(pcie,
+			   WIN_NUM_0, WIN_1_BASE,
+			   0, CFG_WINDOW_TYPE, OB_CFG_WIN_SIZE_KB);
+
+	/* Memory outbound translation window */
+	program_ob_windows(pcie,
+			   WIN_NUM_1, WIN_1_BASE + WIN1_BAR_MAP_DISTANCE,
+			   BAR_MAP_BASE, MEM_WINDOW_TYPE, OB_MEM_WIN_SIZE_KB);
+
+	/* Memory inbound  translation window */
+	program_ib_windows(pcie);
+
+}
+
+/*
+ *	mobiveil_pcie_intx_map - routine to setup the INTx related data
+ *	structures
+ *
+ *	@domain   : pointer to IRQ domain
+ *	@irq      : IRQ number
+ *	@hwirq    : hardware IRQ number
+ *
+ */
+static int mobiveil_pcie_intx_map(struct irq_domain *domain, u32 irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+	return 0;
+}
+
+/*	INTx domain opeartions structure */
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = mobiveil_pcie_intx_map,
+};
+
+/*
+ *	mobiveil_pcie_destroy_msi - Free MSI number
+ *	@irq: IRQ to be freed
+ */
+static void mobiveil_pcie_destroy_msi(u32 irq)
+{
+	struct msi_desc *msi;
+	struct mobiveil_pcie *pcie;
+
+	if (!test_bit(irq, msi_irq_in_use)) {
+		msi = irq_get_msi_desc(irq);
+		pcie = msi_desc_to_pci_sysdata(msi);
+		pr_info("Trying to free unused MSI#%d\n", irq);
+	} else {
+		clear_bit(irq, msi_irq_in_use);
+	}
+}
+
+/*
+ *	mobiveil_pcie_assign_msi - Allocate MSI number
+ *	@pcie: PCIe port structure
+ *
+ *	Return: A valid IRQ on success and error value on failure.
+ */
+static int mobiveil_pcie_assign_msi(struct mobiveil_pcie *pcie)
+{
+	int pos;
+
+	pos = find_first_zero_bit(msi_irq_in_use, MOBIVEIL_NUM_MSI_IRQS);
+	if (pos < MOBIVEIL_NUM_MSI_IRQS)
+		set_bit(pos, msi_irq_in_use);
+	else
+		return -ENOSPC;
+
+	return pos;
+}
+
+/*
+ *	mobiveil_msi_teardown_irq - Destroy the MSI
+ *
+ *	@chip: MSI Chip descriptor
+ *	@irq: MSI IRQ to destroy
+ */
+static void mobiveil_msi_teardown_irq(struct msi_controller *chip,
+				      u32 irq)
+{
+	mobiveil_pcie_destroy_msi(irq);
+}
+
+/*
+ *	mobiveil_pcie_msi_setup_irq - routine to compose MSI message descriptor
+ *
+ *	@chip   : pointer to MSI controller structure
+ *	@pdev   : pointer to PCI device
+ *	@desc   : MSI descriptor to be setup
+ */
+static int mobiveil_pcie_msi_setup_irq(struct msi_controller *chip,
+				       struct pci_dev *pdev,
+				       struct msi_desc *desc)
+{
+	int hwirq;
+	u32 irq;
+	struct msi_msg msg;
+	phys_addr_t msg_addr;
+	struct mobiveil_pcie *pcie = pdev->bus->sysdata;
+
+	hwirq = mobiveil_pcie_assign_msi(pcie);
+	if (hwirq < 0)
+		return -EINVAL;
+
+	irq = irq_create_mapping(pcie->irq_domain, hwirq);
+	if (!irq)
+		return -EINVAL;
+
+	irq_set_msi_desc(irq, desc);
+
+	msg_addr =
+	    virt_to_phys((void *)pcie->msi_pages + (hwirq * sizeof(int)));
+
+	msg.address_hi = 0xFFFFFFFF & (msg_addr >> 32);
+	msg.address_lo = 0xFFFFFFFF & msg_addr;
+	msg.data = irq;
+
+	pci_write_msi_msg(irq, &msg);
+	max_msi_allocated++;
+
+	return 0;
+}
+
+/* MSI Chip Descriptor */
+static struct msi_controller mobiveil_pcie_msi_chip = {
+	.setup_irq = mobiveil_pcie_msi_setup_irq,
+	.teardown_irq = mobiveil_msi_teardown_irq,
+};
+
+/* HW Interrupt Chip Descriptor */
+static struct irq_chip mobiveil_msi_irq_chip = {
+	.name = "Mobiveil PCIe MSI",
+	.irq_enable = pci_msi_unmask_irq,
+	.irq_disable = pci_msi_mask_irq,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+/*
+ *	mobiveil_pcie_msi_map - routine to initialize MSI data structures
+ *
+ *	@domain :   pointer IRQ domain
+ *	@irq    :   IRQ number
+ *	@hwirq  :   hardware IRQ number
+ */
+static int mobiveil_pcie_msi_map(struct irq_domain *domain, u32 irq,
+				 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &mobiveil_msi_irq_chip,
+				 handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+/*	MSI IRQ Domain operations */
+static const struct irq_domain_ops msi_domain_ops = {
+	.map = mobiveil_pcie_msi_map,
+};
+
+/*
+ *	mobiveil_pcie_enable_msi - Enable MSI support
+ *	@pcie: PCIe port information
+ */
+static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
+{
+	phys_addr_t msg_addr;
+
+	pcie->msi_pages = (void *)__get_free_pages(GFP_DMA, 0);
+	msg_addr = virt_to_phys((void *)pcie->msi_pages);
+	pcie->msi_pages_phys = (void *)msg_addr;
+
+	writel_relaxed(msg_addr & 0xFFFFFFFF,
+		       pcie->apb_csr_base + MSI_BASE_LO_OFFSET);
+	writel_relaxed(msg_addr >> 32,
+			pcie->apb_csr_base + MSI_BASE_HI_OFFSET);
+	writel_relaxed(4096,
+			pcie->apb_csr_base + MSI_SIZE_OFFSET);
+	writel_relaxed(1 << MSI_ENABLE_BIT_POS,
+			pcie->apb_csr_base + MSI_ENABLE_OFFSET);
+}
+
+/*
+ *	mobiveil_pcie_init_irq_domain - routine to setup IRQ domains for
+ *	both INTx and MSI interrupts
+ *
+ *	@pcie : pointer to pci root port
+ */
+static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	/* Setup INTx */
+	pcie->irq_domain =
+	    irq_domain_add_linear(node, INTX_NUM + 1, &intx_domain_ops, pcie);
+
+	if (!pcie->irq_domain) {
+		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		return -ENOMEM;
+	}
+	/* Setup MSI */
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pcie->irq_domain = irq_domain_add_linear(node,
+						 MOBIVEIL_NUM_MSI_IRQS,
+						 &msi_domain_ops,
+						 &mobiveil_pcie_msi_chip);
+		if (!pcie->irq_domain) {
+			dev_err(dev, "Failed to get a MSI IRQ domain\n");
+			return PTR_ERR(pcie->irq_domain);
+		}
+
+		mobiveil_pcie_enable_msi(pcie);
+	}
+	return 0;
+}
+
+/*
+ *	mobiveil_pcie_free_irq_domain - routine to free the IRQ domain of
+ *	the root port
+ *
+ *	@pcie : pointer to pci root port
+ */
+static void mobiveil_pcie_free_irq_domain(struct mobiveil_pcie *pcie)
+{
+	int i;
+	u32 irq;
+
+	for (i = 0; i < INTX_NUM; i++) {
+		irq = irq_find_mapping(pcie->irq_domain, i + 1);
+		if (irq > 0)
+			irq_dispose_mapping(irq);
+	}
+	if (pcie->irq_domain)
+		irq_domain_remove(pcie->irq_domain);
+
+}
+
+/*
+ *	mobiveil_pcie_probe  - probe routine which will get called by kernel
+ *	once the RC is discovered
+ *
+ *	@pdev :  pointer to platform device
+ */
+static int mobiveil_pcie_probe(struct platform_device *pdev)
+{
+	struct mobiveil_pcie *pcie;
+	struct pci_bus *bus;
+	struct pci_bus *child;
+	int ret, reset_cnt = 0;
+	struct device_node *np = pdev->dev.of_node;
+
+	resource_size_t iobase = 0;
+	LIST_HEAD(res);
+
+	/* allocate the PCIe port */
+	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pcie->pdev = pdev;
+
+	/* parse the device tree */
+	ret = mobiveil_pcie_parse_dt(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Parsing DT failed, ret: %x\n", ret);
+		return ret;
+	}
+
+	if (!mobiveil_pcie_link_is_up(pcie)) {
+		/* if FSBL is not patched, link wont be up so lets bring it
+		 * up by writng DIRM and OEN registers EMIO 6:0 programing
+		 * sequence [3:0] = Link Width; [6:4] = link Speed. Current
+		 * setting width=4, speed = 1
+		 */
+		gpio_write(pcie, 0x7f, 0xa02c4);
+		gpio_write(pcie, 0x7f, 0xa02c8);
+		gpio_write(pcie, 0x14, 0xa004c);
+
+		gpio_write(pcie, 0x0200, 0xa0244);
+		gpio_write(pcie, 0x0200, 0xa0248);
+		gpio_write(pcie, 0x37f7, 0x180208);
+		gpio_write(pcie, 0xfdff, 0xa0044);
+
+		pr_info("waiting for %d seconds\n", 2);
+		mdelay(2 * 1000);
+		mobiveil_pcie_powerup_slot(pcie);
+
+		while (!mobiveil_pcie_link_is_up(pcie)) {
+			pr_info("%s: PRESET retry, reset_cnt : %d\n",
+			     __func__, reset_cnt++);
+			mobiveil_pcie_powerup_slot(pcie);
+		}
+
+	}
+
+	pr_info("%s: PCIE link is up , resets: %x, state: %x\n",
+		__func__,
+		reset_cnt,
+		csr_readl(pcie, LTSSM_STATE_STATUS_REG)
+				& LTSSM_STATUS_CODE_MASK);
+
+	INIT_LIST_HEAD(&pcie->resources);
+
+	/* configure all inbound and outbound windows and prepare the RC for
+	 * config access
+	 */
+	mobiveil_pcie_setup_csr_for_config_access(pcie);
+
+	/* fixup for PCIe config space register data */
+	csr_writel(pcie, 0x060402AB, PAB_INTP_AXI_PIO_CLASS_REG);
+
+	/* parse the host bridge base addresses from the device tree file */
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &iobase);
+	if (ret) {
+		dev_err(&pdev->dev, "Getting bridge resources failed\n");
+		return -ENOMEM;
+	}
+
+	/* initialize the IRQ domains */
+	ret = mobiveil_pcie_init_irq_domain(pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed creating IRQ Domain\n");
+		return ret;
+	}
+
+	/* create the PCIe root bus */
+	bus =
+	    pci_create_root_bus(&pdev->dev, 0, &mobiveil_pcie_ops, pcie, &res);
+	if (!bus)
+		return -ENOMEM;
+
+	/* setup MSI, if enabled */
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		mobiveil_pcie_msi_chip.dev = &pcie->pdev->dev;
+		bus->msi = &mobiveil_pcie_msi_chip;
+	}
+
+	/* setup the kernel resources for the newly added PCIe root bus */
+	pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+	pci_bus_add_devices(bus);
+	platform_set_drvdata(pdev, pcie);
+
+	pr_info("%s: platform driver registered\n", __func__);
+	return ret;
+}
+
+/*
+ *	mobiveil_pcie_remove  - routine which will cleanup the driver removal
+ *
+ *	@pdev :  pointer to platform device
+ */
+
+static int mobiveil_pcie_remove(struct platform_device *pdev)
+{
+	struct mobiveil_pcie *pcie = platform_get_drvdata(pdev);
+
+	mobiveil_pcie_free_irq_domain(pcie);
+	platform_set_drvdata(pdev, NULL);
+	pr_info("%s: platform driver unregistered\n", __func__);
+	return 0;
+}
+
+/*	device id structure mentioning the compatible string to search for
+ *	in the device tree
+ */
+static const struct of_device_id mobiveil_pcie_of_match[] = {
+	{.compatible = "mbvl,axi-pcie-host-1.00",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
+
+/*	platform driver structure */
+static struct platform_driver mobiveil_pcie_driver = {
+	.probe = mobiveil_pcie_probe,
+	.remove = mobiveil_pcie_remove,
+	.driver = {
+		   .name = "mobiveil-pcie",
+		   .of_match_table = mobiveil_pcie_of_match,
+		   .suppress_bind_attrs = true,
+		   },
+};
+
+/*	Declare the platform driver */
+builtin_platform_driver(mobiveil_pcie_driver);
+
+/*	kernel module descriptions */
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
+MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
-- 
1.8.3.1
