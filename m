Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:56633 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751661Ab2J2HCQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:16 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 04/15] SPEAr13xx: Add PCIe Root Complex driver support
Date: Mon, 29 Oct 2012 12:31:18 +0530
Message-ID: <b26d316d6822888ccdeecf72346c7dbd618759eb.1351492562.git.pratyush.anand@st.com>
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SPEAr13xx has dual mode PCIe controller which can be used as Root
Complex as well as Endpoint. This driver supports RC mode of the
controller.

If CONFIG_PCI_MSI is defined then support of MSI interrupt for
downstream  PCIe devices will be enabled.

If CONFIG_PM is defined then it supports suspend/resume functionality.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 arch/arm/mach-spear13xx/include/mach/pcie.h |  233 ++++++
 arch/arm/mach-spear13xx/pcie.c              | 1145 +++++++++++++++++++++++++++
 2 files changed, 1378 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/pcie.h
 create mode 100644 arch/arm/mach-spear13xx/pcie.c

diff --git a/arch/arm/mach-spear13xx/include/mach/pcie.h b/arch/arm/mach-spear13xx/include/mach/pcie.h
new file mode 100644
index 0000000..39bff4f
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/pcie.h
@@ -0,0 +1,233 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/pcie.h
+ *
+ * Copyright (C) 2010-2012 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef __MACH_PCIE_H
+#define __MACH_PCIE_H
+
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/clk.h>
+
+#define MAX_LINK_UP_WAIT_MS	2
+/* Max port defined can be changed if required */
+#define MAX_PCIE_PORT_SUPPORTED	3
+struct pcie_port;
+
+struct pcie_port_info {
+	u32	is_host;
+	u32	is_gen1;
+	u32	cfg0_size;
+	u32	cfg1_size;
+	u32	mem_size;
+	u32	msg_size;
+	u32	in_mem_size;
+	u32	io_size;
+	int (*clk_init)(struct pcie_port *pp);
+	int (*clk_exit)(struct pcie_port *pp);
+};
+
+struct pcie_port {
+	u8			controller;
+	u8			root_bus_nr;
+	void __iomem		*dbi_base;
+	void __iomem		*va_dbi_base;
+	void __iomem		*app_base;
+	void __iomem		*va_app_base;
+	void __iomem		*base;
+	void __iomem		*phy_base;
+	void __iomem		*va_phy_base;
+	void __iomem		*cfg0_base;
+	void __iomem		*va_cfg0_base;
+	void __iomem		*cfg1_base;
+	void __iomem		*va_cfg1_base;
+	void __iomem		*mem_base;
+	void __iomem		*io_base;
+	spinlock_t		conf_lock;
+	char			mem_space_name[16];
+	char			io_space_name[16];
+	struct resource		res[2];
+	struct pcie_port_info	config;
+	struct list_head	next;
+	struct clk		*clk;
+	int			irq;
+	int			virt_irq_base;
+	int			susp_state;
+};
+
+/* synopsis specific PCIE configuration registers*/
+#define PCIE_PORT_LOGIC			0x80C
+#define PORT_LOGIC_SPD_CHANGE_ID	17
+
+#define PCIE_MSI_ADDR_LO		0x820
+#define PCIE_MSI_ADDR_HI		0x824
+#define PCIE_MSI_INTR0_ENABLE		0x828
+#define PCIE_MSI_INTR0_MASK		0x82C
+#define PCIE_MSI_INTR0_STATUS		0x830
+
+#define PCIE_ATU_VIEWPORT		0x900
+#define PCIE_ATU_REGION_INBOUND		(1 << 31)
+#define PCIE_ATU_REGION_OUTBOUND	(0 << 31)
+#define PCIE_ATU_CR1			0x904
+#define PCIE_ATU_TYPE_MEM		0
+#define PCIE_ATU_TYPE_IO		2
+#define PCIE_ATU_TYPE_CFG0		4
+#define PCIE_ATU_TYPE_CFG1		5
+#define PCIE_ATU_CR2			0x908
+#define PCIE_ATU_ENABLE			(1 << 31)
+#define PCIE_ATU_BAR_MODE_ENABLE	(1 << 30)
+#define PCIE_ATU_LOWER_BASE		0x90C
+#define PCIE_ATU_UPPER_BASE		0x910
+#define PCIE_ATU_LIMIT			0x914
+#define PCIE_ATU_LOWER_TARGET		0x918
+#define PCIE_ATU_UPPER_TARGET		0x91C
+
+/*BAR MASK registers*/
+#define PCIE_BAR0_MASK_REG		0x1010
+
+struct pcie_app_reg {
+	u32	app_ctrl_0;		/*cr0*/
+	u32	app_ctrl_1;		/*cr1*/
+	u32	app_status_0;		/*cr2*/
+	u32	app_status_1;		/*cr3*/
+	u32	msg_status;		/*cr4*/
+	u32	msg_payload;		/*cr5*/
+	u32	int_sts;		/*cr6*/
+	u32	int_clr;		/*cr7*/
+	u32	int_mask;		/*cr8*/
+	u32	mst_bmisc;		/*cr9*/
+	u32	phy_ctrl;		/*cr10*/
+	u32	phy_status;		/*cr11*/
+	u32	cxpl_debug_info_0;	/*cr12*/
+	u32	cxpl_debug_info_1;	/*cr13*/
+	u32	ven_msg_ctrl_0;		/*cr14*/
+	u32	ven_msg_ctrl_1;		/*cr15*/
+	u32	ven_msg_data_0;		/*cr16*/
+	u32	ven_msg_data_1;		/*cr17*/
+	u32	ven_msi_0;		/*cr18*/
+	u32	ven_msi_1;		/*cr19*/
+	u32	mst_rmisc;		/*cr 20*/
+	u32	slv_awmisc;		/*cr 21*/
+	u32	slv_armisc;		/*cr 22*/
+	u32	pom0_mem_addr_start;	/*cr23*/
+	u32	pom1_mem_addr_start;	/*cr24*/
+	u32	pom_io_addr_start;	/*cr25*/
+	u32	pom_cfg0_addr_start;	/*cr26*/
+	u32	pom_cfg1_addr_start;	/*cr27*/
+	u32	in0_mem_addr_start;	/*cr28*/
+	u32	in1_mem_addr_start;	/*cr29*/
+	u32	in_io_addr_start;	/*cr30*/
+	u32	in_cfg0_addr_start;	/*cr31*/
+	u32	in_cfg1_addr_start;	/*cr32*/
+	u32	in_msg_addr_start;	/*cr33*/
+	u32	in0_mem_addr_limit;	/*cr34*/
+	u32	in1_mem_addr_limit;	/*cr35*/
+	u32	in_io_addr_limit;	/*cr36*/
+	u32	in_cfg0_addr_limit;	/*cr37*/
+	u32	in_cfg1_addr_limit;	/*cr38*/
+	u32	in_msg_addr_limit;	/*cr39*/
+	u32	mem0_addr_offset_limit;	/*cr40*/
+	u32	pim0_mem_addr_start;	/*cr41*/
+	u32	pim1_mem_addr_start;	/*cr42*/
+	u32	pim_io_addr_start;	/*cr43*/
+	u32	pim_rom_addr_start;	/*cr44*/
+};
+
+/*CR0 ID*/
+#define RX_LANE_FLIP_EN_ID			0
+#define TX_LANE_FLIP_EN_ID			1
+#define SYS_AUX_PWR_DET_ID			2
+#define APP_LTSSM_ENABLE_ID			3
+#define SYS_ATTEN_BUTTON_PRESSED_ID		4
+#define SYS_MRL_SENSOR_STATE_ID			5
+#define SYS_PWR_FAULT_DET_ID			6
+#define SYS_MRL_SENSOR_CHGED_ID			7
+#define SYS_PRE_DET_CHGED_ID			8
+#define SYS_CMD_CPLED_INT_ID			9
+#define APP_INIT_RST_0_ID			11
+#define APP_REQ_ENTR_L1_ID			12
+#define APP_READY_ENTR_L23_ID			13
+#define APP_REQ_EXIT_L1_ID			14
+#define DEVICE_TYPE_EP				(0 << 25)
+#define DEVICE_TYPE_LEP				(1 << 25)
+#define DEVICE_TYPE_RC				(4 << 25)
+#define SYS_INT_ID				29
+#define MISCTRL_EN_ID				30
+#define REG_TRANSLATION_ENABLE			31
+
+/*CR1 ID*/
+#define APPS_PM_XMT_TURNOFF_ID			2
+#define APPS_PM_XMT_PME_ID			5
+
+/*CR3 ID*/
+#define XMLH_LTSSM_STATE_ID			0
+#define XMLH_LTSSM_STATE_L0	((u32)0x11 << XMLH_LTSSM_STATE_ID)
+#define XMLH_LTSSM_STATE_MASK	((u32)0x3F << XMLH_LTSSM_STATE_ID)
+#define XMLH_LINK_UP_ID				6
+
+/*CR4 ID*/
+#define CFG_MSI_EN_ID				18
+
+/*CR6*/
+#define INTA_CTRL_INT				(1 << 7)
+#define INTB_CTRL_INT				(1 << 8)
+#define INTC_CTRL_INT				(1 << 9)
+#define INTD_CTRL_INT				(1 << 10)
+#define MSI_CTRL_INT				(1 << 26)
+
+/*CR19 ID*/
+#define VEN_MSI_REQ_ID				11
+#define VEN_MSI_FUN_NUM_ID			8
+#define VEN_MSI_TC_ID				5
+#define VEN_MSI_VECTOR_ID			0
+#define VEN_MSI_REQ_EN		((u32)0x1 << VEN_MSI_REQ_ID)
+#define VEN_MSI_FUN_NUM_MASK	((u32)0x7 << VEN_MSI_FUN_NUM_ID)
+#define VEN_MSI_TC_MASK		((u32)0x7 << VEN_MSI_TC_ID)
+#define VEN_MSI_VECTOR_MASK	((u32)0x1F << VEN_MSI_VECTOR_ID)
+
+/*CE21-22 ID*/
+/*ID definition of ARMISC*/
+#define AXI_OP_TYPE_ID				0
+#define AXI_OP_BCM_ID				5
+#define AXI_OP_EP_ID				6
+#define AXI_OP_TD_ID				7
+#define AXI_OP_ATTRIBUTE_ID			8
+#define AXI_OP_TC_ID				10
+#define AXI_OP_MSG_CODE_ID			13
+#define AXI_OP_DBI_ACCESS_ID			21
+#define AXI_OP_TYPE_MASK			0x1F
+#define AXI_OP_TYPE_MEM_RDRW			0
+#define AXI_OP_TYPE_MEM_RDRW_LOCKED		1
+#define AXI_OP_TYPE_IO_RDRW			2
+#define AXI_OP_TYPE_CONFIG_RDRW_TYPE0		4
+#define AXI_OP_TYPE_CONFIG_RDRW_TYPE1		5
+#define AXI_OP_TYPE_MSG_REQ			16
+#define AXI_OP_TYPE_COMPLETION			10
+#define AXI_OP_TYPE_COMPLETION_LOCKED		11
+#define AXI_OP_TYPE_DBI_ELBI_ENABLE		1
+
+#define PCI_CAP_ID_EXP_OFFSET			0x70
+
+#define PCIE_IS_HOST		1
+#define PCIE_IS_DEVICE		0
+
+#define PCIE_IS_GEN1		1
+#define PCIE_IS_GEN2		0
+
+#define NUM_INTX_IRQS		4
+/*
+ * Maximum number of MSI IRQs can be 256 per controller. But keep it 64
+ * as of now. Probably we will never need more than 64. If needed, then
+ * Increment it in multiple of 32.
+ */
+#define NUM_MSI_IRQS		64
+
+#define	IO_SIZE_PER_PORT	SZ_16K
+#endif
diff --git a/arch/arm/mach-spear13xx/pcie.c b/arch/arm/mach-spear13xx/pcie.c
new file mode 100644
index 0000000..bfed3b7
--- /dev/null
+++ b/arch/arm/mach-spear13xx/pcie.c
@@ -0,0 +1,1145 @@
+/*
+ * arch/arm/mach-spear13xx/pcie.c
+ *
+ * PCIe functions for SPEAr13XX PCIe Host controllers
+ *
+ * Copyright (C) 2010-2012 ST Microelectronics
+ * Pratyush Anand <pratyush.anand@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/msi.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/slab.h>
+#include <asm/mach/irq.h>
+#include <asm/signal.h>
+#include <mach/pcie.h>
+
+static struct list_head	pcie_port_list;
+static struct hw_pci pci;
+
+static inline int cfg_read(void *addr, int where, int size, u32 *val)
+{
+	*val = readl(addr);
+
+	if (size == 1)
+		*val = (*val >> (8 * (where & 3))) & 0xff;
+	else if (size == 2)
+		*val = (*val >> (8 * (where & 3))) & 0xffff;
+	else if (size != 4)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int cfg_write(void *addr, int where, int size, u32 val)
+{
+	if (size == 4)
+		writel(val, addr);
+	else if (size == 2)
+		writew(val, addr + (where & 2));
+	else if (size == 1)
+		writeb(val, addr + (where & 3));
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
+		u32 *val)
+{
+	return cfg_read(pp->va_dbi_base + (where & ~0x3), where, size, val);
+}
+
+static int pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
+		u32 val)
+{
+	return cfg_write(pp->va_dbi_base + (where & ~0x3), where, size, val);
+}
+
+static void spear_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
+{
+	u32 val;
+	void __iomem *dbi_base = pp->va_dbi_base;
+
+	/* Program viewport 0 : OUTBOUND : CFG0 */
+	val = PCIE_ATU_REGION_OUTBOUND | (0 & 0xF);
+	writel(val, dbi_base + PCIE_ATU_VIEWPORT);
+	writel(PCIE_ATU_TYPE_CFG0, dbi_base + PCIE_ATU_CR1);
+	val = PCIE_ATU_ENABLE;
+	writel(val, dbi_base + PCIE_ATU_CR2);
+	writel(pp->cfg0_base, dbi_base + PCIE_ATU_LOWER_BASE);
+	writel(0, dbi_base + PCIE_ATU_UPPER_BASE);
+	writel(pp->cfg0_base + pp->config.cfg0_size - 1,
+			dbi_base + PCIE_ATU_LIMIT);
+	writel(busdev, dbi_base + PCIE_ATU_LOWER_TARGET);
+	writel(0, dbi_base + PCIE_ATU_UPPER_TARGET);
+}
+
+static void spear_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
+{
+	u32 val;
+	void __iomem *dbi_base = pp->va_dbi_base;
+
+	/* Program viewport 1 : OUTBOUND : CFG1 */
+	val = PCIE_ATU_REGION_OUTBOUND | (1 & 0xF);
+	writel(val, dbi_base + PCIE_ATU_VIEWPORT);
+	writel(PCIE_ATU_TYPE_CFG1, dbi_base + PCIE_ATU_CR1);
+	val = PCIE_ATU_ENABLE;
+	writel(val, dbi_base + PCIE_ATU_CR2);
+	writel(pp->cfg1_base, dbi_base + PCIE_ATU_LOWER_BASE);
+	writel(0, dbi_base + PCIE_ATU_UPPER_BASE);
+	writel(pp->cfg1_base + pp->config.cfg1_size - 1,
+			dbi_base + PCIE_ATU_LIMIT);
+	writel(busdev, dbi_base + PCIE_ATU_LOWER_TARGET);
+	writel(0, dbi_base + PCIE_ATU_UPPER_TARGET);
+}
+
+static void spear_pcie_prog_viewport_mem(struct pcie_port *pp)
+{
+	u32 val;
+	void __iomem *dbi_base = pp->va_dbi_base;
+
+	/* Program viewport 0 : OUTBOUND : MEM */
+	val = PCIE_ATU_REGION_OUTBOUND | (0 & 0xF);
+	writel(val, dbi_base + PCIE_ATU_VIEWPORT);
+	writel(PCIE_ATU_TYPE_MEM, dbi_base + PCIE_ATU_CR1);
+	val = PCIE_ATU_ENABLE;
+	writel(val, dbi_base + PCIE_ATU_CR2);
+	writel(pp->mem_base, dbi_base + PCIE_ATU_LOWER_BASE);
+	writel(0, dbi_base + PCIE_ATU_UPPER_BASE);
+	writel(pp->mem_base + pp->config.mem_size - 1,
+			dbi_base + PCIE_ATU_LIMIT);
+	writel(pp->mem_base, dbi_base + PCIE_ATU_LOWER_TARGET);
+	writel(0, dbi_base + PCIE_ATU_UPPER_TARGET);
+}
+
+static void spear_pcie_prog_viewport_io(struct pcie_port *pp)
+{
+	u32 val;
+	void __iomem *dbi_base = pp->va_dbi_base;
+
+	/* Program viewport 1 : OUTBOUND : IO */
+	val = PCIE_ATU_REGION_OUTBOUND | (1 & 0xF);
+	writel(val, dbi_base + PCIE_ATU_VIEWPORT);
+	writel(PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
+	val = PCIE_ATU_ENABLE;
+	writel(val, dbi_base + PCIE_ATU_CR2);
+	writel(pp->io_base, dbi_base + PCIE_ATU_LOWER_BASE);
+	writel(0, dbi_base + PCIE_ATU_UPPER_BASE);
+	writel(pp->io_base + pp->config.io_size - 1,
+			dbi_base + PCIE_ATU_LIMIT);
+	writel(pp->io_base, dbi_base + PCIE_ATU_LOWER_TARGET);
+	writel(0, dbi_base + PCIE_ATU_UPPER_TARGET);
+}
+
+static int pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+		u32 devfn, int where, int size, u32 *val)
+{
+	int ret = PCIBIOS_SUCCESSFUL;
+	u32 address, busdev;
+
+	busdev = (bus->number << 24) | (PCI_SLOT(devfn) << 19);
+	address = (PCI_FUNC(devfn) << 16) | (where & 0xFFFC);
+
+	if (bus->parent->number == pp->root_bus_nr) {
+		spear_pcie_prog_viewport_cfg0(pp, busdev);
+		ret = cfg_read(pp->va_cfg0_base + address, where, size, val);
+		spear_pcie_prog_viewport_mem(pp);
+	} else {
+		spear_pcie_prog_viewport_cfg1(pp, busdev);
+		ret = cfg_read(pp->va_cfg1_base + address, where, size, val);
+		spear_pcie_prog_viewport_io(pp);
+	}
+
+	return ret;
+}
+
+static int pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+		u32 devfn, int where, int size, u32 val)
+{
+	int ret = PCIBIOS_SUCCESSFUL;
+	u32 address, busdev;
+
+	busdev = (bus->number << 24) | (PCI_SLOT(devfn) << 19);
+	address = (PCI_FUNC(devfn) << 16) | (where & 0xFFFC);
+
+	if (bus->parent->number == pp->root_bus_nr) {
+		spear_pcie_prog_viewport_cfg0(pp, busdev);
+		ret = cfg_write(pp->va_cfg0_base + address, where, size, val);
+		spear_pcie_prog_viewport_mem(pp);
+	} else {
+		spear_pcie_prog_viewport_cfg1(pp, busdev);
+		ret = cfg_write(pp->va_cfg1_base + address, where, size, val);
+		spear_pcie_prog_viewport_io(pp);
+	}
+
+	return ret;
+}
+
+static struct pcie_port *controller_to_port(int controller)
+{
+	struct pcie_port *pp;
+
+	if (controller >= pci.nr_controllers)
+		return NULL;
+
+	list_for_each_entry(pp, &pcie_port_list, next) {
+		if (pp->controller == controller)
+			return pp;
+	}
+	return NULL;
+}
+
+static struct pcie_port *bus_to_port(int bus)
+{
+	int i;
+	int rbus;
+	struct pcie_port *pp;
+
+	for (i = pci.nr_controllers - 1 ; i >= 0; i--) {
+		pp = controller_to_port(i);
+		rbus = pp->root_bus_nr;
+		if (rbus != -1 && rbus <= bus)
+			break;
+	}
+
+	return i >= 0 ? pp : NULL;
+}
+
+#ifdef CONFIG_PCI_MSI
+static DECLARE_BITMAP(msi_irq_in_use[MAX_PCIE_PORT_SUPPORTED],
+		NUM_MSI_IRQS);
+static unsigned int msi_data[MAX_PCIE_PORT_SUPPORTED];
+
+/* MSI int handler */
+static void handle_msi(struct pcie_port *pp)
+{
+	unsigned long val;
+	int i, pos;
+
+	for (i = 0; i < NUM_MSI_IRQS / 32; i++) {
+		pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
+				(u32 *)&val);
+		if (val) {
+			pos = 0;
+			while ((pos = find_next_bit(&val, 32, pos)) != 32) {
+				generic_handle_irq(pp->virt_irq_base +
+						NUM_INTX_IRQS + (i * 32) + pos);
+				pos++;
+			}
+		}
+		pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4, val);
+	}
+}
+
+static void msi_nop(struct irq_data *d)
+{
+	return;
+}
+
+static struct irq_chip msi_chip = {
+	.name = "PCI-MSI",
+	.irq_ack = msi_nop,
+	.irq_enable = unmask_msi_irq,
+	.irq_disable = mask_msi_irq,
+	.irq_mask = mask_msi_irq,
+	.irq_unmask = unmask_msi_irq,
+};
+
+/* Dynamic irq allocate and deallocation */
+static int get_irq(struct msi_desc *desc, int *pos)
+{
+	int res, bit, irq, pos0;
+	u32 val;
+	struct pcie_port *pp = bus_to_port(desc->dev->bus->number);
+
+	if (!pp) {
+		BUG();
+		return -EINVAL;
+	}
+
+	pos0 = find_first_zero_bit(msi_irq_in_use[pp->controller],
+			NUM_MSI_IRQS);
+
+	irq = pp->virt_irq_base + NUM_INTX_IRQS + pos0;
+
+	if (pos0 > NUM_MSI_IRQS)
+		goto no_valid_irq;
+
+	set_bit(pos0, msi_irq_in_use[pp->controller]);
+
+	dynamic_irq_init(irq);
+	irq_set_msi_desc(irq, desc);
+	irq_set_chip_and_handler(irq, &msi_chip, handle_simple_irq);
+	set_irq_flags(irq, IRQF_VALID);
+	irq_set_chip_data(irq, pp);
+
+	/*
+	 * Enable corresponding interrupt on MSI interrupt
+	 * controller.
+	 */
+	res = (pos0 / 32) * 12;
+	bit = pos0 % 32;
+	pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
+	val |= 1 << bit;
+	pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+
+	*pos = pos0;
+	return irq;
+
+no_valid_irq:
+	*pos = pos0;
+
+	return -ENOSPC;
+}
+
+static void clean_irq(unsigned int irq)
+{
+	int res, bit, val, pos;
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct msi_desc *msi_desc = irq_desc_get_msi_desc(desc);
+	struct pcie_port *pp = bus_to_port(msi_desc->dev->bus->number);
+
+	if (!pp) {
+		BUG();
+		return;
+	}
+
+	pos = irq - pp->virt_irq_base - NUM_INTX_IRQS;
+
+	dynamic_irq_cleanup(irq);
+
+	clear_bit(pos, msi_irq_in_use[pp->controller]);
+
+	/*
+	 * Disable corresponding interrupt on MSI interrupt
+	 * controller.
+	 */
+	res = (pos / 32) * 12;
+	bit = pos % 32;
+	pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
+	val &= ~(1 << bit);
+	pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
+}
+
+int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
+{
+	int irq, pos;
+	struct msi_msg msg;
+	struct pcie_port *pp = bus_to_port(pdev->bus->number);
+
+	if (!pp) {
+		BUG();
+		return -EINVAL;
+	}
+
+	irq = get_irq(desc, &pos);
+
+	if (irq < 0)
+		return irq;
+	/*
+	 * An EP will modify lower 8 bits(max) of msi data while
+	 * sending any msi interrupt
+	 */
+	msg.address_hi = 0x0;
+	msg.address_lo = __virt_to_phys((u32)(&msi_data[pp->controller]));
+	msg.data = pos;
+	write_msi_msg(irq, &msg);
+
+	return 0;
+}
+
+void arch_teardown_msi_irq(unsigned int irq)
+{
+	clean_irq(irq);
+}
+
+static void msi_init(struct pcie_port *pp)
+{
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+
+	pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
+			__virt_to_phys((u32)(&msi_data[pp->controller])));
+	pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4, 0);
+
+	/* Enable MSI interrupt */
+	writel(readl(&app_reg->int_mask) | MSI_CTRL_INT,
+			&app_reg->int_mask);
+}
+#endif
+
+static int __init pcie_setup(int nr, struct pci_sys_data *sys)
+{
+	struct pcie_port *pp;
+
+	pp = controller_to_port(nr);
+
+	if (!pp)
+		return 0;
+
+	pp->root_bus_nr = sys->busnr;
+
+	snprintf(pp->mem_space_name, sizeof(pp->mem_space_name),
+			"PCIe %d MEM", nr);
+	pp->mem_space_name[sizeof(pp->mem_space_name) - 1] = 0;
+	pp->res[0].name = pp->mem_space_name;
+	pp->res[0].start = (resource_size_t)pp->mem_base;
+	pp->res[0].end = pp->res[0].start + pp->config.mem_size - 1;
+	pp->res[0].flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, &pp->res[0]))
+		panic("can't allocate PCIe Mem space");
+	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->mem_offset);
+
+	snprintf(pp->io_space_name, sizeof(pp->io_space_name),
+			"PCIe %d I/O", nr);
+	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
+	pp->res[1].name = pp->io_space_name;
+	pp->res[1].start = PCIBIOS_MIN_IO + nr * pp->config.io_size;
+	pp->res[1].end = pp->res[1].start + (pp->config.io_size - 1);
+	pp->res[1].flags = IORESOURCE_IO;
+	if (request_resource(&ioport_resource, &pp->res[1]))
+		panic("can't allocate PCIe IO space");
+	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->io_offset);
+
+	return 1;
+}
+
+static int pcie_link_up(struct pcie_app_reg *app_reg)
+{
+	int ucount = 0;
+
+	do {
+		if (readl(&app_reg->app_status_1) &
+			((u32)1 << XMLH_LINK_UP_ID))
+			return 1;
+		ucount++;
+		udelay(1);
+	} while (ucount <= MAX_LINK_UP_WAIT_MS * 1000);
+
+	return 0;
+}
+
+static int pcie_valid_config(struct pcie_port *pp, struct pci_bus *bus, int dev)
+{
+	/* If there is no link, then there is no device */
+	if (bus->number != pp->root_bus_nr) {
+		if (!pcie_link_up(pp->va_app_base))
+			return 0;
+	}
+
+	/*
+	 * Don't go out when trying to access non-existing devices
+	 * on the local bus.
+	 * we have only one slot on each root port.
+	 */
+	if (bus->number == pp->root_bus_nr && dev > 0)
+		return 0;
+
+	/*
+	 * do not read more than one device on the bus directly attached
+	 * to RC's (Virtual Bridge's) DS side.
+	 */
+	if (bus->primary == pp->root_bus_nr && dev > 0)
+		return 0;
+
+	return 1;
+}
+
+static int pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
+			int size, u32 *val)
+{
+	struct pcie_port *pp = bus_to_port(bus->number);
+	unsigned long flags;
+	int ret;
+
+	if (!pp) {
+		BUG();
+		return -EINVAL;
+	}
+
+	if (pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	spin_lock_irqsave(&pp->conf_lock, flags);
+	if (bus->number != pp->root_bus_nr)
+		ret = pcie_rd_other_conf(pp, bus, devfn, where, size, val);
+	else
+		ret = pcie_rd_own_conf(pp, where, size, val);
+	spin_unlock_irqrestore(&pp->conf_lock, flags);
+
+	return ret;
+}
+
+static int pcie_wr_conf(struct pci_bus *bus, u32 devfn,
+			int where, int size, u32 val)
+{
+	struct pcie_port *pp = bus_to_port(bus->number);
+	unsigned long flags;
+	int ret;
+
+	if (!pp) {
+		BUG();
+		return -EINVAL;
+	}
+
+	if (pcie_valid_config(pp, bus, PCI_SLOT(devfn)) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	spin_lock_irqsave(&pp->conf_lock, flags);
+	if (bus->number != pp->root_bus_nr)
+		ret = pcie_wr_other_conf(pp, bus, devfn, where, size, val);
+	else
+		ret = pcie_wr_own_conf(pp, where, size, val);
+	spin_unlock_irqrestore(&pp->conf_lock, flags);
+
+	return ret;
+}
+
+static struct pci_ops pcie_ops = {
+	.read = pcie_rd_conf,
+	.write = pcie_wr_conf,
+};
+
+static struct pci_bus __init *pcie_scan_bus(int nr, struct pci_sys_data *sys)
+{
+	struct pci_bus *bus;
+	struct pcie_port *pp = controller_to_port(nr);
+
+	if (pp) {
+		pp->root_bus_nr = sys->busnr;
+
+		return bus = pci_scan_root_bus(NULL, sys->busnr, &pcie_ops, sys,
+				&sys->resources);
+	} else {
+		bus = NULL;
+		BUG();
+	}
+
+	return bus;
+}
+
+static int pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	struct pcie_port *pp = bus_to_port(dev->bus->number);
+	int irq;
+
+	if (!pp) {
+		BUG();
+		return -EINVAL;
+	}
+
+	irq = (pp->virt_irq_base + pin - 1);
+
+	return irq;
+}
+
+static struct hw_pci pci = {
+	.setup		= pcie_setup,
+	.scan		= pcie_scan_bus,
+	.map_irq	= pcie_map_irq,
+};
+
+static void mask_intx_irq(struct irq_data *data)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+	int irq_offset = data->irq - pp->virt_irq_base;
+	u32 mask;
+
+	switch (irq_offset) {
+	case 0:
+		mask = ~INTA_CTRL_INT;
+		break;
+	case 1:
+		mask = ~INTB_CTRL_INT;
+		break;
+	case 2:
+		mask = ~INTC_CTRL_INT;
+		break;
+	case 3:
+		mask = ~INTD_CTRL_INT;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	writel(readl(&app_reg->int_mask) & mask, &app_reg->int_mask);
+}
+
+static void unmask_intx_irq(struct irq_data *data)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+	int irq_offset = data->irq - pp->virt_irq_base;
+	u32 mask;
+
+	switch (irq_offset) {
+	case 0:
+		mask = INTA_CTRL_INT;
+		break;
+	case 1:
+		mask = INTB_CTRL_INT;
+		break;
+	case 2:
+		mask = INTC_CTRL_INT;
+		break;
+	case 3:
+		mask = INTD_CTRL_INT;
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	writel(readl(&app_reg->int_mask) | mask, &app_reg->int_mask);
+}
+
+static struct irq_chip intx_chip = {
+	.name = "PCI-INTX",
+	.irq_mask = mask_intx_irq,
+	.irq_unmask = unmask_intx_irq,
+};
+
+static void pcie_int_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct pcie_port *pp = irq_get_handler_data(irq);
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	unsigned int status;
+
+	chained_irq_enter(irqchip, desc);
+
+	status = readl(&app_reg->int_sts);
+
+	if (status & MSI_CTRL_INT) {
+#ifdef CONFIG_PCI_MSI
+		handle_msi(pp);
+#endif
+		writel(MSI_CTRL_INT, &app_reg->int_clr);
+	} else if (status & INTA_CTRL_INT)
+		generic_handle_irq(pp->virt_irq_base);
+	else if (status & INTB_CTRL_INT)
+		generic_handle_irq(pp->virt_irq_base + 1);
+	else if (status & INTC_CTRL_INT)
+		generic_handle_irq(pp->virt_irq_base + 2);
+	else if (status & INTD_CTRL_INT)
+		generic_handle_irq(pp->virt_irq_base + 3);
+	else
+		writel(status, &app_reg->int_clr);
+
+	chained_irq_exit(irqchip, desc);
+}
+
+static void pcie_irq_init(struct pcie_port *pp)
+{
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+	int i;
+
+	irq_set_chained_handler(pp->irq, pcie_int_handler);
+	irq_set_handler_data(pp->irq, pp);
+
+#ifdef CONFIG_PCI_MSI
+	msi_init(pp);
+#endif
+	/*
+	 * initialize INTX chip here only. MSI chip will be
+	 * initialized dynamically.
+	 */
+	for (i = 0; i < NUM_INTX_IRQS; i++) {
+		irq_set_chip_and_handler(pp->virt_irq_base + i, &intx_chip,
+				handle_simple_irq);
+		set_irq_flags(pp->virt_irq_base + i, IRQF_VALID);
+		irq_set_chip_data(pp->virt_irq_base + i, pp);
+	}
+
+	/* Enable INTX interrupt */
+	writel(readl(&app_reg->int_mask) | INTA_CTRL_INT
+			| INTB_CTRL_INT	| INTC_CTRL_INT
+			| INTD_CTRL_INT, &app_reg->int_mask);
+}
+
+static int patch_txdetectrx_spear1340(struct pcie_port *pp)
+{
+	void __iomem *miphy = pp->va_phy_base;
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+	int ucount = 0;
+	u32 tempa;
+	u8 tempm;
+
+	tempa = readl(&app_reg->app_status_1);
+	/* till ltsmm state is not L0 */
+	while ((tempa & 0x3F) != 0x11) {
+		while (((tempa & 0x3F) == 0) || ((tempa & 0x3F) == 1)) {
+			tempm = readb(miphy + 0x20);
+			tempm &= ~0x3;
+			writeb(tempm, miphy + 0x20);
+
+			writeb(0, miphy + 0x21);
+
+			tempm = readb(miphy + 0x16);
+			tempm &= ~(1 << 3);
+			writeb(tempm, miphy + 0x16);
+
+			tempm = readb(miphy + 0x12);
+			tempm &= ~0x3;
+			writeb(tempm, miphy + 0x12);
+
+			tempm = readb(miphy + 0x10);
+			tempm |= 0x1;
+			writeb(tempm, miphy + 0x10);
+
+			tempa = readl(&app_reg->app_status_1);
+
+			ucount++;
+			udelay(1);
+			if (ucount > MAX_LINK_UP_WAIT_MS * 100000)
+				return -ECONNRESET;
+		}
+		tempm = readb(miphy + 0x10);
+		tempm &= ~0x1;
+		writeb(tempm, miphy + 0x10);
+
+		tempa = readl(&app_reg->app_status_1);
+	}
+
+	return 0;
+}
+
+void __iomem *spear13xx_pcie_io_base(unsigned long addr)
+{
+	int controller = (addr - PCIBIOS_MIN_IO) / IO_SIZE_PER_PORT;
+	struct pcie_port *pp;
+
+	pp = controller_to_port(controller);
+
+	return pp->io_base;
+}
+
+static void pcie_host_init(struct pcie_port *pp)
+{
+	struct pcie_port_info *config = &pp->config;
+	void __iomem *dbi_base = pp->va_dbi_base;
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+	u32 exp_cap_off = PCI_CAP_ID_EXP_OFFSET;
+	u32 val;
+
+	/* Keep first 64K for IO */
+	pp->io_base = pp->base;
+	pp->mem_base = pp->io_base + config->io_size;
+	pp->cfg0_base = pp->mem_base + config->mem_size;
+	pp->cfg1_base = pp->cfg0_base + config->cfg0_size;
+
+	/*
+	 * setup registers for inbound translation. Fix viewport 0 for
+	 * Memory and viewport 1 for IO transaction
+	 */
+
+	/* Program viewport 0 : INBOUND : MEMORY */
+	val = PCIE_ATU_REGION_INBOUND | (0 & 0xF);
+	writel(val, dbi_base + PCIE_ATU_VIEWPORT);
+	writel(PCIE_ATU_TYPE_MEM, dbi_base + PCIE_ATU_CR1);
+	val = PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE;
+	writel(val, dbi_base + PCIE_ATU_CR2);
+
+	/* program first 256 MB as inbound address */
+	writel(0, dbi_base + PCIE_ATU_LOWER_BASE);
+	writel(0, dbi_base + PCIE_ATU_UPPER_BASE);
+	writel(config->in_mem_size - 1, dbi_base + PCIE_ATU_LIMIT);
+	writel(0, dbi_base + PCIE_ATU_LOWER_TARGET);
+	writel(0, dbi_base + PCIE_ATU_UPPER_TARGET);
+
+	/* Program viewport 1 : INBOUND : IO */
+	val = PCIE_ATU_REGION_INBOUND | (1 & 0xF);
+	writel(val, dbi_base + PCIE_ATU_VIEWPORT);
+	writel(PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
+	val = PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE;
+	writel(val, dbi_base + PCIE_ATU_CR2);
+
+	/* program first 256 MB as inbound address */
+	writel(0, dbi_base + PCIE_ATU_LOWER_BASE);
+	writel(0, dbi_base + PCIE_ATU_UPPER_BASE);
+	writel(config->in_mem_size - 1, dbi_base + PCIE_ATU_LIMIT);
+	writel(0, dbi_base + PCIE_ATU_LOWER_TARGET);
+	writel(0, dbi_base + PCIE_ATU_UPPER_TARGET);
+
+	pcie_wr_own_conf(pp, PCIE_BAR0_MASK_REG, 4,
+			(config->in_mem_size - 1));
+	pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
+
+	/*
+	 * this controller support only 128 bytes read size, however its
+	 * default value in capability register is 512 bytes. So force
+	 * it to 128 here.
+	 */
+
+	pcie_rd_own_conf(pp, exp_cap_off + PCI_EXP_DEVCTL, 4, &val);
+	val &= ~PCI_EXP_DEVCTL_READRQ;
+	pcie_wr_own_conf(pp, exp_cap_off + PCI_EXP_DEVCTL, 4, val);
+
+	/* program correct class for RC */
+	pcie_rd_own_conf(pp, PCI_CLASS_REVISION, 4, &val);
+	val &= 0xFFFF;
+	val |= (PCI_CLASS_BRIDGE_PCI << 16);
+	pcie_wr_own_conf(pp, PCI_CLASS_REVISION, 4, val);
+
+	/* program vid and did for RC */
+	pcie_wr_own_conf(pp, PCI_VENDOR_ID, 2, 0x104A);
+	pcie_wr_own_conf(pp, PCI_DEVICE_ID, 2, 0xCD80);
+
+	/* if is_gen1 is set then handle it */
+	if (pp->config.is_gen1) {
+		pcie_rd_own_conf(pp, exp_cap_off + PCI_EXP_LNKCAP, 4, &val);
+		if ((val & 0xF) != 1) {
+			val &= ~((u32)0xF);
+			val |= 1;
+			pcie_wr_own_conf(pp, exp_cap_off + PCI_EXP_LNKCAP, 4,
+					val);
+		}
+
+		pcie_rd_own_conf(pp, exp_cap_off + PCI_EXP_LNKCTL2, 4, &val);
+		if ((val & 0xF) != 1) {
+			val &= ~((u32)0xF);
+			val |= 1;
+			pcie_wr_own_conf(pp, exp_cap_off + PCI_EXP_LNKCTL2, 4,
+					val);
+		}
+	} else {
+		pcie_rd_own_conf(pp, PCIE_PORT_LOGIC, 4, &val);
+		val |= (1 << PORT_LOGIC_SPD_CHANGE_ID);
+		pcie_wr_own_conf(pp, PCIE_PORT_LOGIC, 4, val);
+	}
+
+	/* set max trial before lock failure */
+	writeb(0xC0, pp->va_phy_base + 0x85);
+	/* set max trial before lock failure */
+	writeb(0x01, pp->va_phy_base + 0x86);
+
+	/* txdetect RX settings for SPEAr1310 */
+	if (of_machine_is_compatible("st,spear1310"))
+		writeb(0x00, pp->va_phy_base + 0x16);
+
+	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
+			| (1 << APP_LTSSM_ENABLE_ID)
+			| ((u32)1 << REG_TRANSLATION_ENABLE),
+			&app_reg->app_ctrl_0);
+
+	/* txdetect RX settings for SPEAr1340 */
+	if (of_machine_is_compatible("st,spear1340"))
+		patch_txdetectrx_spear1340(pp);
+
+	pcie_irq_init(pp);
+}
+
+static void pcie_host_exit(struct pcie_port *pp)
+{
+	struct pcie_app_reg *app_reg = pp->va_app_base;
+
+	writel(0, &app_reg->app_ctrl_0);
+
+}
+
+static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
+{
+	struct resource *base;
+	struct resource *dbi_base;
+	struct resource *phy_base;
+	int virt_irq_base;
+	struct device_node *np = pdev->dev.of_node;
+	struct irq_domain *irq_domain;
+	int num_virt_irqs = NUM_INTX_IRQS;
+
+	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!dbi_base) {
+		dev_err(&pdev->dev, "couldn't get dbi base resource\n");
+		return -EINVAL;
+	}
+	if (!devm_request_mem_region(&pdev->dev, dbi_base->start,
+				resource_size(dbi_base), pdev->name)) {
+		dev_err(&pdev->dev, "dbi base resource is busy\n");
+		return -EBUSY;
+	}
+
+	pp->dbi_base = (void __iomem *)dbi_base->start;
+	pp->va_dbi_base = devm_ioremap(&pdev->dev, dbi_base->start,
+			resource_size(dbi_base));
+	if (!pp->va_dbi_base) {
+		dev_err(&pdev->dev, "error with ioremap\n");
+		return -ENOMEM;
+	}
+
+	/* App base starts from offset 0x2000 of dbi base */
+	pp->app_base = pp->dbi_base + 0x2000;
+	pp->va_app_base = pp->va_dbi_base + 0x2000;
+
+	phy_base = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (!phy_base) {
+		dev_err(&pdev->dev, "couldn't get phy base resource\n");
+		return -EINVAL;
+	}
+	if (!devm_request_mem_region(&pdev->dev, phy_base->start,
+				resource_size(phy_base), pdev->name)) {
+		dev_err(&pdev->dev, "phy base resource is busy\n");
+		return -EBUSY;
+	}
+
+	pp->phy_base = (void __iomem *)phy_base->start;
+	pp->va_phy_base = devm_ioremap(&pdev->dev, phy_base->start,
+			resource_size(phy_base));
+	if (!pp->va_phy_base) {
+		dev_err(&pdev->dev, "error with ioremap\n");
+		return -ENOMEM;
+	}
+
+	base = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!base) {
+		dev_err(&pdev->dev, "couldn't get base resource\n");
+		return -EINVAL;
+	}
+
+	pp->base = (void __iomem *)base->start;
+
+	pp->root_bus_nr = -1;
+
+#ifdef CONFIG_PCI_MSI
+	num_virt_irqs += NUM_MSI_IRQS;
+#endif
+
+	virt_irq_base = irq_alloc_descs(-1, 0, num_virt_irqs, 0);
+	if (IS_ERR_VALUE(virt_irq_base)) {
+		dev_err(&pdev->dev, "irq desc alloc failed\n");
+		return -ENXIO;
+	}
+
+	irq_domain = irq_domain_add_legacy(np, num_virt_irqs, virt_irq_base,
+			0, &irq_domain_simple_ops, NULL);
+	if (!irq_domain) {
+		dev_err(&pdev->dev, "irq domain init failed\n");
+		irq_free_descs(virt_irq_base, 32);
+		return -ENXIO;
+	}
+
+	pp->virt_irq_base = irq_find_mapping(irq_domain, 0);
+
+	spin_lock_init(&pp->conf_lock);
+	if (pcie_link_up(pp->va_app_base)) {
+		dev_info(&pdev->dev, "link up\n");
+	} else {
+		dev_info(&pdev->dev, "link down\n");
+		pcie_host_init(pp);
+		pp->va_cfg0_base = devm_ioremap(&pdev->dev,
+				(resource_size_t)pp->cfg0_base,
+					pp->config.cfg0_size);
+		if (!pp->va_cfg0_base) {
+			dev_err(&pdev->dev, "error with ioremap in function\n");
+			return -ENOMEM;
+		}
+		pp->va_cfg1_base = devm_ioremap(&pdev->dev,
+				(resource_size_t)pp->cfg1_base,
+					pp->config.cfg1_size);
+		if (!pp->va_cfg1_base) {
+			dev_err(&pdev->dev, "error with ioremap\n");
+			return -ENOMEM;
+		}
+
+	}
+
+	return 0;
+}
+
+static int __devinit pcie_probe(struct platform_device *pdev)
+{
+	int err;
+	struct clk *clk;
+	struct pcie_port *pp;
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!pdev->dev.platform_data)
+		return -EINVAL;
+
+	pp = devm_kzalloc(&pdev->dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp) {
+		dev_err(&pdev->dev, "no memory for pcie port\n");
+		return -ENOMEM;
+	}
+
+	memcpy(&pp->config, pdev->dev.platform_data, (sizeof(pp->config)));
+	pp->config.io_size = IO_SIZE_PER_PORT;
+	of_property_read_u32(np, "pcie-host,is_host", &pp->config.is_host);
+	of_property_read_u32(np, "pcie-host,is_gen1", &pp->config.is_gen1);
+	of_property_read_u32(np, "pcie-host,cfg0_size", &pp->config.cfg0_size);
+	of_property_read_u32(np, "pcie-host,cfg1_size", &pp->config.cfg1_size);
+	of_property_read_u32(np, "pcie-host,mem_size", &pp->config.mem_size);
+	of_property_read_u32(np, "pcie-host,msg_size", &pp->config.msg_size);
+	of_property_read_u32(np, "pcie-host,in_mem_size",
+			&pp->config.in_mem_size);
+
+	if (!pp->config.is_host)
+		return -EINVAL;
+
+	err = pp->config.clk_init(pp);
+	if (err)
+		goto free_mem;
+
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "couldn't get clk for pcie\n");
+		err = PTR_ERR(clk);
+		goto free_mem;
+	}
+
+	if (clk_prepare_enable(clk)) {
+		dev_err(&pdev->dev, "couldn't enable clk for pcie\n");
+		err = -EINVAL;
+		goto clk_put;
+	}
+
+	pp->irq = platform_get_irq(pdev, 0);
+	if (pp->irq < 0) {
+		err = -EINVAL;
+		goto clk_put;
+	}
+
+	if (!add_pcie_port(pp, pdev)) {
+		pp->controller = pci.nr_controllers;
+		pci.nr_controllers++;
+		list_add_tail(&pp->next, &pcie_port_list);
+		return 0;
+	}
+
+clk_put:
+	clk_put(clk);
+free_mem:
+	kfree(pp);
+
+	return err;
+}
+
+static int __devinit pcie_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM
+int spear_pcie_suspend(void)
+{
+	struct pcie_port *pp;
+	int i;
+
+	for (i = 0; i < pci.nr_controllers; i++) {
+		pp = controller_to_port(i);
+		if (pcie_link_up(pp->va_app_base)) {
+			pcie_host_exit(pp);
+			pp->config.clk_exit(pp);
+			pp->susp_state = 1;
+		}
+	}
+
+	return 0;
+}
+
+int spear_pcie_resume(void)
+{
+	struct pcie_port *pp;
+	int i;
+
+	for (i = 0; i < pci.nr_controllers; i++) {
+		pp = controller_to_port(i);
+		if (pp->susp_state) {
+			pp->config.clk_init(pp);
+			pp->susp_state = 0;
+			if (!pcie_link_up(pp->va_app_base))
+				pcie_host_init(pp);
+		}
+	}
+
+	return 0;
+}
+#endif
+
+static const struct of_device_id pcie_of_match[] = {
+	{ .compatible = "st,pcie-host", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pcie_of_match);
+
+static struct platform_driver pcie_driver = {
+	.driver = {
+		.name	= "pcie",
+		.owner = THIS_MODULE,
+		.of_match_table = pcie_of_match,
+	},
+	.probe = pcie_probe,
+	.remove = __devexit_p(pcie_remove),
+
+};
+
+static int
+pcie_abort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+	unsigned long pc = instruction_pointer(regs);
+	unsigned long instr = *(unsigned long *)(pc - 8);
+
+	WARN_ONCE(1, "pcie abort\n");
+	/*
+	 * If the instruction being executed was a read,
+	 * make it look like it read all-ones.
+	 */
+	if ((instr & 0x0c100000) == 0x04100000) {
+		int reg = (instr >> 12) & 15;
+		unsigned long val;
+
+		if (instr & 0x00400000)
+			val = 255;
+		else
+			val = -1;
+
+		regs->uregs[reg] = val;
+		regs->ARM_pc += 4;
+
+		return 0;
+	}
+
+	return 1;
+}
+
+static int __init pcie_init(void)
+{
+	hook_fault_code(16+6, pcie_abort, SIGBUS, 0,
+			"imprecise external abort");
+
+	INIT_LIST_HEAD(&pcie_port_list);
+	platform_driver_probe(&pcie_driver, pcie_probe);
+
+	if (pci.nr_controllers) {
+		pci_common_init(&pci);
+		pci_assign_unassigned_resources();
+		pr_info("pcie init successful\n");
+	}
+
+	return 0;
+}
+subsys_initcall(pcie_init);
+
+static void __exit pcie_exit(void)
+{
+	platform_driver_unregister(&pcie_driver);
+}
+module_exit(pcie_exit);
-- 
1.7.5.4

