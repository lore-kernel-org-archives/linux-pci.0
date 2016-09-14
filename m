Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:3737 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761462AbcINL7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 07:59:36 -0400
From: Zhichang Yuan <yuanzhichang@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
CC: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <will.deacon@arm.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <benh@kernel.crashing.org>,
        <lorenzo.pieralisi@arm.com>, <liviu.dudau@arm.com>,
        <zourongrong@gmail.com>, <john.garry@huawei.com>,
        <gabriele.paoloni@huawei.com>, <zhichang.yuan02@gmail.com>,
        <kantyzc@163.com>, <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 14 Sep 2016 20:15:52 +0800
Message-ID: <1473855354-150093-3-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

On Hip06, the accesses to LPC peripherals work in an indirect way. A
corresponding LPC driver configure some registers in LPC master at first, then
the real accesses on LPC slave devices are finished by the LPC master, which
is transparent to LPC driver.
This patch implement the relevant driver for Hip06 LPC. Cooperating with
indirect-IO, ipmi messages is in service without any changes on ipmi driver.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
---
 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  35 ++
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/hisi_lpc.c                             | 653 +++++++++++++++++++++
 drivers/of/address.c                               |   9 +
 5 files changed, 707 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 create mode 100644 drivers/bus/hisi_lpc.c

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
new file mode 100644
index 0000000..820e26d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
@@ -0,0 +1,35 @@
+Hisilicon Hip06 low-pin-count device
+  Usually LPC controller is part of PCI host bridge, so the legacy ISA ports
+  locate on LPC bus can be accessed direclty. But some SoCs have independent
+  LPC controller, and access the legacy ports by triggering LPC I/O cycles.
+  Hisilicon Hip06 implements this LPC device.
+
+Required properties:
+- compatible: should be "hisilicon,low-pin-count"
+- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
+- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
+- reg: base address and length of the register set for the device.
+- ranges: define a 1:1 mapping between the I/O space of the child device and
+	  the parent.
+
+Note:
+  The node name before '@' must be "isa" to represent the binding stick to the
+  ISA/EISA binding specification.
+
+Example:
+
+isa@a01b0000 {
+	compatible = "hisilicom,low-pin-count";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	reg = <0x0 0xa01b0000 0x0 0x1000>;
+	ranges = <0x01 0xe4 0x0 0xe4 0x1000>;
+
+
+	ipmi0: bt@e4 {
+		compatible = "ipmi-bt";
+		device_type = "ipmi";
+		reg = <0x01 0xe4 0x04>;
+		status = "disabled";
+	};
+};
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3b205e2..fdb232b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -64,6 +64,14 @@ config BRCMSTB_GISB_ARB
 	  arbiter. This driver provides timeout and target abort error handling
 	  and internal bus master decoding.
 
+config HISILICON_LPC
+	bool "Workaround for nonstandard ISA I/O space on Hisilicon Hip0X"
+	depends on (ARCH_HISI || COMPILE_TEST) && ARM64
+	select ARM64_INDIRECT_PIO
+	help
+	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
+	  on Hisilicon Hip0X Soc.
+
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
 	depends on ARCH_MXC
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ac84cc4..6ffbb27 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -7,6 +7,8 @@ obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
 
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
+obj-$(CONFIG_ARM64_INDIRECT_PIO)	+= extio.o
+obj-$(CONFIG_HISILICON_LPC)	+= hisi_lpc.o
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
 obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
new file mode 100644
index 0000000..9b364d0
--- /dev/null
+++ b/drivers/bus/hisi_lpc.c
@@ -0,0 +1,653 @@
+/*
+ * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ * Author: Zou Rongrong <@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/acpi.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+#include <linux/slab.h>
+
+
+struct hisilpc_dev;
+
+/* This flag is specific to differentiate earlycon operations and the others */
+#define FG_EARLYCON_LPC		0x0001
+/*
+ * this bit set means each IO operation will target to different port address;
+ * 0 means repeatly IO operations will be sticked on the same port, such as BT;
+ */
+#define FG_INCRADDR_LPC		0x0002
+
+struct lpc_cycle_para {
+	unsigned int opflags;
+	unsigned int csize;/*the data length of each operation*/
+};
+
+struct hisilpc_dev {
+	spinlock_t cycle_lock;
+	void __iomem  *membase;
+	struct platform_device *pltdev;
+};
+
+
+/* The maximum continous operations*/
+#define LPC_MAX_OPCNT	16
+
+#define LPC_REG_START		(0x00)/*start a new LPC cycle*/
+#define LPC_REG_OP_STATUS	(0x04)/*the current LPC status*/
+#define LPC_REG_IRQ_ST		(0x08)/*interrupt enable&status*/
+#define LPC_REG_OP_LEN		(0x10)/*how many LPC cycles each start*/
+#define LPC_REG_CMD		(0x14)/*command for the required LPC cycle*/
+#define LPC_REG_ADDR		(0x20)/*LPC target address*/
+#define LPC_REG_WDATA		(0x24)/*data to be written*/
+#define LPC_REG_RDATA		(0x28)/*data coming from peer*/
+
+
+/* The command register fields*/
+#define LPC_CMD_SAMEADDR_SING	(0x00000008)
+#define LPC_CMD_SAMEADDR_INC	(0x00000000)
+#define LPC_CMD_TYPE_IO		(0x00000000)
+#define LPC_CMD_TYPE_MEM	(0x00000002)
+#define LPC_CMD_TYPE_FWH	(0x00000004)
+#define LPC_CMD_WRITE		(0x00000001)
+#define LPC_CMD_READ		(0x00000000)
+
+#define LPC_IRQ_CLEAR		(0x02)
+#define LPC_IRQ_OCCURRED	(0x02)
+
+#define LPC_STATUS_IDLE		(0x01)
+#define LPC_OP_FINISHED		(0x02)
+
+#define START_WORK		(0x01)
+
+/*
+ * The minimal waiting interval... Suggest it is not less than 10.
+ * Bigger value probably will lower the performance.
+ */
+#define LPC_NSEC_PERWAIT	100
+/*
+ * The maximum waiting time is about 128us.
+ * The fastest IO cycle time is about 390ns, but the worst case will wait
+ * for extra 256 lpc clocks, so (256 + 13) * 30ns = 8 us. The maximum
+ * burst cycles is 16. So, the maximum waiting time is about 128us under
+ * worst case.
+ * choose 1300 as the maximum.
+ */
+#define LPC_MAX_WAITCNT		1300
+/* About 10us. This is specfic for single IO operation, such as inb. */
+#define LPC_PEROP_WAITCNT	100
+
+
+static inline int wait_lpc_idle(unsigned char *mbase,
+				unsigned int waitcnt) {
+	u32 opstatus = 0;
+
+	while (waitcnt--) {
+		ndelay(LPC_NSEC_PERWAIT);
+		opstatus = readl(mbase + LPC_REG_OP_STATUS);
+		if (opstatus & LPC_STATUS_IDLE)
+			return (opstatus & LPC_OP_FINISHED) ? 0 : (-EIO);
+	}
+	return -ETIME;
+}
+
+
+/**
+ * hisilpc_target_in - trigger a series of lpc cycles to read required data
+ *		  from target periperal.
+ * @pdev: pointer to hisi lpc device
+ * @para: some paramerters used to control the lpc I/O operations
+ * @ptaddr: the lpc I/O target port address
+ * @buf: where the read back data is stored
+ * @opcnt: how many I/O operations required in this calling
+ *
+ * only one byte data is read each I/O operation.
+ *
+ * Returns 0 on success, non-zero on fail.
+ *
+ */
+static int hisilpc_target_in(struct hisilpc_dev *pdev,
+				struct lpc_cycle_para *para,
+				unsigned long ptaddr, unsigned char *buf,
+				unsigned long opcnt)
+{
+	unsigned int cmd_word;
+	unsigned int waitcnt;
+	int retval;
+	/*initialized as 0 to remove compile warning */
+	unsigned long flags = 0;
+
+	if (!buf || !opcnt || !para || !pdev)
+		return -EINVAL;
+
+	if (para->csize != 1 || opcnt  > LPC_MAX_OPCNT)
+		return -EINVAL;
+
+	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
+	waitcnt = (LPC_PEROP_WAITCNT);
+	if (!(para->opflags & FG_INCRADDR_LPC)) {
+		cmd_word |= LPC_CMD_SAMEADDR_SING;
+		waitcnt = LPC_MAX_WAITCNT;
+	}
+
+	/* whole operation must be atomic */
+	if (!(para->opflags & FG_EARLYCON_LPC))
+		spin_lock_irqsave(&pdev->cycle_lock, flags);
+
+	writel(opcnt, pdev->membase + LPC_REG_OP_LEN);
+
+	writel(cmd_word, pdev->membase + LPC_REG_CMD);
+
+	writel(ptaddr, pdev->membase + LPC_REG_ADDR);
+
+	writel(START_WORK, pdev->membase + LPC_REG_START);
+
+	/* whether the operation is finished */
+	retval = wait_lpc_idle(pdev->membase, waitcnt);
+	if (!retval) {
+		for (; opcnt--; buf++)
+			*buf = readl(pdev->membase + LPC_REG_RDATA);
+	}
+
+	if (!(para->opflags & FG_EARLYCON_LPC))
+		spin_unlock_irqrestore(&pdev->cycle_lock, flags);
+
+	return retval;
+}
+
+/**
+ * hisilpc_target_out - trigger a series of lpc cycles to write required data
+ *		  to target periperal.
+ * @pdev: pointer to hisi lpc device
+ * @para: some paramerters used to control the lpc I/O operations
+ * @ptaddr: the lpc I/O target port address
+ * @buf: where the data to be written is stored
+ * @opcnt: how many I/O operations required
+ *
+ * only one byte data is read each I/O operation.
+ *
+ * Returns 0 on success, non-zero on fail.
+ *
+ */
+static int hisilpc_target_out(struct hisilpc_dev *pdev,
+				struct lpc_cycle_para *para,
+				unsigned long ptaddr,
+				const unsigned char *buf,
+				unsigned long opcnt)
+{
+	unsigned int cmd_word;
+	unsigned int waitcnt;
+	int retval;
+	/* initialized as 0 to remove compile warning */
+	unsigned long flags = 0;
+
+
+	if (!buf || !opcnt || !para || !pdev)
+		return -EINVAL;
+
+	if (para->csize != 1 || opcnt  > LPC_MAX_OPCNT)
+		return -EINVAL;
+
+	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_WRITE;
+	waitcnt = (LPC_PEROP_WAITCNT);
+	if (!(para->opflags & FG_INCRADDR_LPC)) {
+		cmd_word |= LPC_CMD_SAMEADDR_SING;
+		waitcnt = LPC_MAX_WAITCNT;
+	}
+
+	/* whole operation must be atomic */
+	if (!(para->opflags & FG_EARLYCON_LPC))
+		spin_lock_irqsave(&pdev->cycle_lock, flags);
+
+	writel(opcnt, pdev->membase + LPC_REG_OP_LEN);
+	for (; opcnt--; buf++)
+		writel(*buf, pdev->membase + LPC_REG_WDATA);
+
+	writel(cmd_word, pdev->membase + LPC_REG_CMD);
+
+	writel(ptaddr, pdev->membase + LPC_REG_ADDR);
+
+	writel(START_WORK, pdev->membase + LPC_REG_START);
+
+	/* whether the operation is finished */
+	retval = wait_lpc_idle(pdev->membase, waitcnt);
+
+	if (!(para->opflags & FG_EARLYCON_LPC))
+		spin_unlock_irqrestore(&pdev->cycle_lock, flags);
+
+	return retval;
+}
+
+/**
+ * hisilpc_comm_inb - read/input the data from the I/O peripheral through LPC.
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @outbuf: a buffer where the data read is stored at.
+ * @ptaddr: the target I/O port address.
+ * @dlen: the data length required to read from the target I/O port.
+ * @count: how many I/O operations required in this calling.  >1 is for ins.
+ *
+ * For this lpc, only support inb/insb now.
+ *
+ * For inbs, returns 0 on success, -1 on fail.
+ * when succeed, the data read back is stored in buffer pointed by inbuf.
+ * For inb, return the data read from I/O or -1 when error occur.
+ */
+u64 hisilpc_comm_inb(void *devobj, unsigned long ptaddr,
+				void *inbuf, size_t dlen,
+				unsigned int count)
+{
+	struct hisilpc_dev *lpcdev;
+	struct lpc_cycle_para iopara;
+	unsigned int loopcnt, cntleft;
+	unsigned int rd_data;
+	unsigned char *newbuf;
+	int ret = 0;
+	/* only support data unit length is 1 now... */
+	if (!count || (!inbuf && count != 1) || !devobj || dlen != 1)
+		return -1;
+
+	newbuf = (unsigned char *)inbuf;
+	/*
+	 * the operation data len is 4 bytes, need to ensure the buffer
+	 * is big enough.
+	 */
+	if (!inbuf || count < sizeof(u32))
+		newbuf = (unsigned char *)&rd_data;
+
+	lpcdev = (struct hisilpc_dev *)devobj;
+	dev_dbg(&lpcdev->pltdev->dev, "In-IO(0x%lx), count=%u\n", ptaddr,
+			count);
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	/*
+	 * to improve performance, support repeatly rd at same target
+	 * address.
+	 */
+	if (count > 1)
+		iopara.opflags &= ~FG_INCRADDR_LPC;
+
+	iopara.csize = dlen;
+
+	cntleft = count;
+	do {
+		loopcnt = (cntleft > LPC_MAX_OPCNT) ? LPC_MAX_OPCNT : cntleft;
+		ret = hisilpc_target_in(lpcdev,
+				&iopara, ptaddr, newbuf, loopcnt);
+		if (ret)
+			return -1;
+		newbuf += loopcnt;
+		cntleft -= loopcnt;
+	} while (cntleft);
+
+	/* for inb */
+	if (!inbuf)
+		return rd_data;
+	/* for insb, copy the data to the return variable */
+	if (inbuf != newbuf)
+		memcpy(inbuf, &rd_data, count);
+
+	return 0;
+}
+
+/**
+ * hisilpc_comm_outb - write/output the data in out buffer to the I/O peripheral
+ *		    through LPC.
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @outbuf: a buffer where the data to be written is stored.
+ * @ptaddr: the target I/O port address.
+ * @dlen: the data length required writing to the target I/O port .
+ * @count: how many I/O operations required in this calling. >1 is for outs.
+ *
+ * For this lpc, only support outb/outsb now.
+ *
+ */
+void hisilpc_comm_outb(void *devobj, unsigned long ptaddr,
+				const void *outbuf, size_t dlen,
+				unsigned int count)
+{
+	struct hisilpc_dev *lpcdev;
+	struct lpc_cycle_para iopara;
+	unsigned int loopcnt;
+	const unsigned char *newbuf;
+	int ret = 0;
+
+	if (!count || !outbuf || !devobj)
+		return;
+
+	newbuf = (const unsigned char *)outbuf;
+	lpcdev = (struct hisilpc_dev *)devobj;
+
+	dev_dbg(&lpcdev->pltdev->dev, "Out-IO(0x%lx), cnt=%u\n", ptaddr, count);
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	/* to improve performance,  support repeatly wr same target address */
+	if (count > 1)
+		iopara.opflags &= ~FG_INCRADDR_LPC;
+
+	iopara.csize = 1;
+
+	do {
+		loopcnt = (count > LPC_MAX_OPCNT) ? LPC_MAX_OPCNT : count;
+		ret = hisilpc_target_out(lpcdev,
+				&iopara, ptaddr, newbuf, loopcnt);
+		if (ret)
+			return;
+		newbuf += loopcnt;
+		count -= loopcnt;
+	} while (count);
+}
+
+
+/**
+ * hisilpc_ischild_ipmi - check whether the designated device is ipmi
+ * @dev: the device to be checked.
+ * @data: the value used to match the acpi device in checking.
+ *
+ * Returns 1 means the device to be checked is matched.
+ * 0 means some failures.
+ *
+ */
+static int  hisilpc_ischild_ipmi(struct device *dev)
+{
+	struct acpi_device *adev;
+	struct acpi_hardware_id *hwid;
+	/* only support dts and acpi */
+	if (IS_ERR_OR_NULL(dev->fwnode) && !dev->of_node) {
+		dev_err(dev, "Not valid child device!\n");
+		return -EINVAL;
+	}
+
+	adev = ACPI_COMPANION(dev);
+	if (adev) {
+		list_for_each_entry(hwid, &adev->pnp.ids, list) {
+			dev_info(dev, "hwid is %s\n", hwid->id);
+			if (!strcmp("IPI0001", hwid->id))
+				return 1;
+		}
+	} else {
+		if (!strcmp(dev->of_node->type, "ipmi"))
+			return 1;
+	}
+
+	dev_info(dev, "not ipmi child device!\n");
+	return 0;
+}
+
+
+/**
+ * hisilpc_children_map_sysio - setup the mapping between system Io and
+ *			physical IO
+ *
+ * @child: the device whose IO is handling
+ * @data: some device specific data. For ACPI device, should be NULL.
+ *
+ * Returns >=0 means the mapping is successfully created;
+ * others mean some failures.
+ */
+static int hisilpc_children_map_sysio(struct device * child, void * data)
+{
+	struct resource *iores;
+	unsigned long cpuio;
+	struct extio_ops *opsnode;
+	int ret;
+	struct hisilpc_dev *lpcdev;
+
+	if (!child || !child->parent)
+		return -EINVAL;
+
+	iores = platform_get_resource_byname(to_platform_device(child),
+					IORESOURCE_IO, "dev_io");
+	if (!iores)
+		return -ENODEV;
+
+	/*
+	 * can not use devm_kzalloc to allocate slab for child before its driver
+	 * start probing. Here allocate the slab with the name of parent.
+	 */
+	opsnode = devm_kzalloc(child->parent, sizeof(*opsnode), GFP_KERNEL);
+	if (!opsnode)
+		return -ENOMEM;
+
+	cpuio = data ? *((unsigned long *)data) : 0;
+
+	opsnode->start = iores->start;
+	opsnode->end = iores->end;
+	opsnode->ptoffset = cpuio ? (cpuio - iores->start) : 0;
+
+	dev_info(child, "map sys port[%lx - %lx] offset=0x%lx",
+				(unsigned long)iores->start,
+				(unsigned long)iores->end,
+				opsnode->ptoffset);
+
+	opsnode->pfin = hisilpc_comm_inb;
+	opsnode->pfout = hisilpc_comm_outb;
+
+	lpcdev = platform_get_drvdata(to_platform_device(child->parent));
+	opsnode->devpara = lpcdev;
+
+	/* only apply indirect-IO to ipmi child device */
+	ret = hisilpc_ischild_ipmi(child);
+	if (ret < 0)
+		return ret;
+
+	if (ret > 0) {
+		WRITE_ONCE(arm64_extio_ops, opsnode);
+		/* update ret as successful */
+		ret = 0;
+	} else {
+		ret = platform_device_add_data(to_platform_device(child),
+						opsnode,
+						sizeof(*opsnode));
+		devm_kfree(child->parent, opsnode);
+	}
+
+	if (!ret)
+		dev_info(child, "to phy [%lx-%lx]\n", cpuio,
+			(unsigned long)(iores->end - iores->start) + cpuio);
+	else
+		dev_info(child, "FAIL(0x%x)!!\n", ret);
+
+	return ret;
+}
+
+/**
+ * of_hisilpc_register_pio - register the deivce physical IO address into
+ *			io_range_list
+ *
+ * Returns >=0 means ok.
+ * others mean some failures.
+ */
+static int of_hisilpc_register_pio(struct device_node *dev,
+					unsigned long *phyport)
+{
+	static int isfirst = 0;
+	const __be32	*addrp;
+	u64		size;
+	unsigned int	flags;
+	u64	taddr;
+	int residx = 0;
+
+
+	if (!dev || !phyport)
+		return -EINVAL;
+	/* only one IO reg exists */
+	do {
+		addrp = of_get_address(dev, residx, &size, &flags);
+		if (addrp == NULL) {
+			pr_err("%s:: get OF address(%d) FAIL!\n",
+				dev->name, residx);
+			return -EINVAL;
+		}
+		residx++;
+	} while(!(flags & IORESOURCE_IO));
+
+
+	taddr = of_translate_address(dev, addrp);
+	if (taddr == OF_BAD_ADDR) {
+		pr_err("%s:: translate IO address fail\n", dev->name);
+		return -EINVAL;
+	}
+
+	/* register one more IO byte for the first register */
+	if (!isfirst) {
+		size += 1;
+		isfirst = 1;
+	}
+
+	if (pci_register_io_range(taddr, size)) {
+		pr_err("%s::register physical range[%llx, %llx) FAIL!\n",
+			dev->name, taddr, size);
+		return -ENXIO;
+	}
+
+	pr_info("%s:: register physical range[%llx, %llx) OK\n",
+			dev->name, taddr, size);
+
+	*phyport = taddr;
+
+	return 0;
+}
+
+/**
+ * hisilpc_probe_child_dev - setup the mapping between linux IO and
+ *			physical IO for all children under hisilpc
+ *
+ * @ppdev: point to the hisilpc device
+ *
+ * Returns =0 means ok.
+ * others mean some failures.
+ */
+static int hisilpc_probe_child_dev(struct device *ppdev)
+{
+	int ret;
+
+	if (!ppdev)
+		return -EINVAL;
+
+	ret = 0;
+	/* for device tree, scan the child devices now */
+	if (!has_acpi_companion(ppdev)) {
+		struct device_node *root, *child;
+
+		root = ppdev->of_node;
+		for_each_available_child_of_node(root, child) {
+			struct platform_device *ptdev;
+			unsigned long cpuio;
+
+			/* register the IO range configured in dt */
+			ret = of_hisilpc_register_pio(child, &cpuio);
+			if (ret) {
+				dev_err(ppdev, "fail to register raw IO for %s\n",
+						child->name);
+				return ret;
+			}
+
+			ptdev = of_platform_device_create(child, NULL, ppdev);
+			if (!ptdev) {
+				dev_err(ppdev, "create platform device fail for %s\n",
+					child->name);
+				return -EFAULT;
+			}
+
+			ret = hisilpc_children_map_sysio(&ptdev->dev, &cpuio);
+			if (ret)
+				dev_err(&ptdev->dev, "Mapping sysio for dts child devices FAIL\n");
+		}
+	} else {
+		ret = device_for_each_child(ppdev, NULL,
+					hisilpc_children_map_sysio);
+		if (ret)
+			dev_err(ppdev, "Mapping sysio for ACPI child devices FAIL\n");
+	}
+
+	return ret;
+}
+
+
+/**
+ * hisilpc_probe - the probe callback function for hisi lpc device,
+ *		will finish all the intialization.
+ * @pdev: the platform device corresponding to hisi lpc
+ *
+ * Returns 0 on success, non-zero on fail.
+ *
+ */
+static int hisilpc_probe(struct platform_device *pdev)
+{
+	struct resource *iores;
+	struct hisilpc_dev *lpcdev;
+	int ret;
+
+	dev_info(&pdev->dev, "hslpc start probing...\n");
+
+	lpcdev = devm_kzalloc(&pdev->dev,
+				sizeof(struct hisilpc_dev), GFP_KERNEL);
+	if (!lpcdev)
+		return -ENOMEM;
+
+	spin_lock_init(&lpcdev->cycle_lock);
+
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lpcdev->membase = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(lpcdev->membase)) {
+		dev_err(&pdev->dev, "No mem resource\n");
+		return PTR_ERR(lpcdev->membase);
+	}
+
+	lpcdev->pltdev = pdev;
+	platform_set_drvdata(pdev, lpcdev);
+
+	ret = hisilpc_probe_child_dev(&pdev->dev);
+	if (!ret)
+		dev_info(&pdev->dev, "hslpc finish probing...\n");
+	else
+		dev_err(&pdev->dev, "hslpc probe got fail(%d)!\n", -ret);
+
+	return ret;
+}
+
+
+static const struct of_device_id hisilpc_of_match[] = {
+	{
+		.compatible = "hisilicon,low-pin-count",
+	},
+	{},
+};
+
+static const struct acpi_device_id hisilpc_acpi_match[] = {
+	{"HISI0191", },
+	{},
+};
+
+static struct platform_driver hisilpc_driver = {
+	.driver = {
+		.name           = "hisi_lpc",
+		.of_match_table = hisilpc_of_match,
+		.acpi_match_table = hisilpc_acpi_match,
+	},
+	.probe = hisilpc_probe,
+};
+
+
+builtin_platform_driver(hisilpc_driver);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903..ba4a330 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -690,9 +690,18 @@ static int __of_address_to_resource(struct device_node *dev,
 	memset(r, 0, sizeof(struct resource));
 	if (flags & IORESOURCE_IO) {
 		unsigned long port;
+
 		port = pci_address_to_pio(taddr);
 		if (port == (unsigned long)-1)
 			return -EINVAL;
+		/*
+		 * special processing for non-pci device gurantee the linux start pio
+		 * is not ZERO. Otherwise, some drivers' initialization will fail.
+		 */
+		if (!port && (!IS_ENABLED(CONFIG_OF_ADDRESS_PCI) ||
+				!of_bus_pci_match(dev)))
+			port += 1;
+
 		r->start = port;
 		r->end = port + size - 1;
 	} else {
-- 
1.9.1

