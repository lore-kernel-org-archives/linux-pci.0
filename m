Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:31360 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbcKHDpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 22:45:50 -0500
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <mark.rutland@arm.com>, <olof@lixom.net>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC: <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <benh@kernel.crashing.org>,
        <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Tue, 8 Nov 2016 11:47:09 +0800
Message-ID: <1478576829-112707-4-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On hip06, the accesses to LPC peripherals work in an indirect way. A
corresponding LPC driver configure some registers in LPC master at first, then
the real accesses on LPC slave devices are finished by the LPC master, which
is transparent to LPC driver.
This patch implement the relevant driver for Hip06 LPC. Cooperating with
indirect-IO, ipmi messages is in service without any changes on ipmi driver.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS            |   8 +
 drivers/bus/Kconfig    |   8 +
 drivers/bus/Makefile   |   1 +
 drivers/bus/hisi_lpc.c | 501 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 518 insertions(+)
 create mode 100644 drivers/bus/hisi_lpc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ccae35b..4c7a350 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5729,6 +5729,14 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON LPC BUS DRIVER
+M:	Zhichang Yuan <yuanzhichang@hisilicon.com>
+L:	linux-arm-kernel@lists.infradead.org
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7875105..4fa8ab4 100644
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
+	  on Hisilicon Hip0X SoC.
+
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
 	depends on ARCH_MXC
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index c6cfa6b..10b4983 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
 
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
+obj-$(CONFIG_HISILICON_LPC)	+= hisi_lpc.o
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
 obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
new file mode 100644
index 0000000..47dc081
--- /dev/null
+++ b/drivers/bus/hisi_lpc.c
@@ -0,0 +1,501 @@
+/*
+ * Copyright (C) 2016 Hisilicon Limited, All Rights Reserved.
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ * Author: Zou Rongrong <zourongrong@huawei.com>
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
+/*
+ * setting this bit means each IO operation will target to different port address;
+ * 0 means repeatly IO operations will be sticked on the same port, such as BT;
+ */
+#define FG_INCRADDR_LPC		0x02
+
+struct lpc_cycle_para {
+	unsigned int opflags;
+	unsigned int csize; /* the data length of each operation */
+};
+
+struct hisilpc_dev {
+	spinlock_t cycle_lock;
+	void __iomem  *membase;
+	struct extio_ops io_ops;
+};
+
+
+/* The maximum continous operations*/
+#define LPC_MAX_OPCNT	16
+/* only support IO data unit length is four at maximum */
+#define LPC_MAX_DULEN	4
+#if LPC_MAX_DULEN > LPC_MAX_OPCNT
+#error "LPC.. MAX_DULEN must be not bigger than MAX_OPCNT!"
+#endif
+
+#define LPC_REG_START		0x00 /* start a new LPC cycle */
+#define LPC_REG_OP_STATUS	0x04 /* the current LPC status */
+#define LPC_REG_IRQ_ST		0x08 /* interrupt enable&status */
+#define LPC_REG_OP_LEN		0x10 /* how many LPC cycles each start */
+#define LPC_REG_CMD		0x14 /* command for the required LPC cycle */
+#define LPC_REG_ADDR		0x20 /* LPC target address */
+#define LPC_REG_WDATA		0x24 /* data to be written */
+#define LPC_REG_RDATA		0x28 /* data coming from peer */
+
+
+/* The command register fields*/
+#define LPC_CMD_SAMEADDR	0x08
+#define LPC_CMD_TYPE_IO		0x00
+#define LPC_CMD_WRITE		0x01
+#define LPC_CMD_READ		0x00
+/* the bit attribute is W1C. 1 represents OK. */
+#define LPC_STAT_BYIRQ		0x02
+
+#define LPC_STATUS_IDLE		0x01
+#define LPC_OP_FINISHED		0x02
+
+#define START_WORK		0x01
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
+	u32 opstatus;
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
+static int hisilpc_target_in(struct hisilpc_dev *lpcdev,
+				struct lpc_cycle_para *para,
+				unsigned long ptaddr, unsigned char *buf,
+				unsigned long opcnt)
+{
+	unsigned long cnt_per_trans;
+	unsigned int cmd_word;
+	unsigned int waitcnt;
+	int ret;
+
+	if (!buf || !opcnt || !para || !para->csize || !lpcdev)
+		return -EINVAL;
+
+	if (opcnt  > LPC_MAX_OPCNT)
+		return -EINVAL;
+
+	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
+	waitcnt = (LPC_PEROP_WAITCNT);
+	if (!(para->opflags & FG_INCRADDR_LPC)) {
+		cmd_word |= LPC_CMD_SAMEADDR;
+		waitcnt = LPC_MAX_WAITCNT;
+	}
+
+	ret = 0;
+	cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
+	for (; opcnt && !ret; cnt_per_trans = para->csize) {
+		unsigned long flags;
+
+		/* whole operation must be atomic */
+		spin_lock_irqsave(&lpcdev->cycle_lock, flags);
+
+		writel(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
+
+		writel(cmd_word, lpcdev->membase + LPC_REG_CMD);
+
+		writel(ptaddr, lpcdev->membase + LPC_REG_ADDR);
+
+		writel(START_WORK, lpcdev->membase + LPC_REG_START);
+
+		/* whether the operation is finished */
+		ret = wait_lpc_idle(lpcdev->membase, waitcnt);
+		if (!ret) {
+			opcnt -= cnt_per_trans;
+			for (; cnt_per_trans--; buf++)
+				*buf = readl(lpcdev->membase + LPC_REG_RDATA);
+		}
+
+		spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
+	}
+
+	return ret;
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
+static int hisilpc_target_out(struct hisilpc_dev *lpcdev,
+				struct lpc_cycle_para *para,
+				unsigned long ptaddr,
+				const unsigned char *buf,
+				unsigned long opcnt)
+{
+	unsigned long cnt_per_trans;
+	unsigned int cmd_word;
+	unsigned int waitcnt;
+	int ret;
+
+	if (!buf || !opcnt || !para || !lpcdev)
+		return -EINVAL;
+
+	if (opcnt > LPC_MAX_OPCNT)
+		return -EINVAL;
+	/* default is increasing address */
+	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_WRITE;
+	waitcnt = (LPC_PEROP_WAITCNT);
+	if (!(para->opflags & FG_INCRADDR_LPC)) {
+		cmd_word |= LPC_CMD_SAMEADDR;
+		waitcnt = LPC_MAX_WAITCNT;
+	}
+
+	ret = 0;
+	cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
+	for (; opcnt && !ret; cnt_per_trans = para->csize) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&lpcdev->cycle_lock, flags);
+
+		writel(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
+		opcnt -= cnt_per_trans;
+		for (; cnt_per_trans--; buf++)
+			writel(*buf, lpcdev->membase + LPC_REG_WDATA);
+
+		writel(cmd_word, lpcdev->membase + LPC_REG_CMD);
+
+		writel(ptaddr, lpcdev->membase + LPC_REG_ADDR);
+
+		writel(START_WORK, lpcdev->membase + LPC_REG_START);
+
+		/* whether the operation is finished */
+		ret = wait_lpc_idle(lpcdev->membase, waitcnt);
+
+		spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
+	}
+
+	return ret;
+}
+
+/**
+ * hisilpc_comm_in - read/input the data from the I/O peripheral through LPC.
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @ptaddr: the target I/O port address.
+ * @dlen: the data length required to read from the target I/O port.
+ *
+ * when succeed, the data read back is stored in buffer pointed by inbuf.
+ * For inb, return the data read from I/O or -1 when error occur.
+ */
+static u64 hisilpc_comm_in(void *devobj, unsigned long ptaddr, size_t dlen)
+{
+	struct hisilpc_dev *lpcdev;
+	struct lpc_cycle_para iopara;
+	u32 rd_data;
+	unsigned char *newbuf;
+	int ret = 0;
+
+	if (!devobj || !dlen || dlen > LPC_MAX_DULEN ||	(dlen & (dlen - 1)))
+		return -1;
+
+	/* the local buffer must be enough for one data unit */
+	if (sizeof(rd_data) < dlen)
+		return -1;
+
+	newbuf = (unsigned char *)&rd_data;
+
+	lpcdev = (struct hisilpc_dev *)devobj;
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	ret = hisilpc_target_in(lpcdev, &iopara, ptaddr, newbuf, dlen);
+	if (ret)
+		return -1;
+
+	return le32_to_cpu(rd_data);
+}
+
+/**
+ * hisilpc_comm_out - write/output the data whose maximal length is four bytes to
+ *		the I/O peripheral through LPC.
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @outval: a value to be outputed from caller, maximum is four bytes.
+ * @ptaddr: the target I/O port address.
+ * @dlen: the data length required writing to the target I/O port .
+ *
+ * This function is corresponding to out(b,w,l) only
+ *
+ */
+static void hisilpc_comm_out(void *devobj, unsigned long ptaddr,
+				u32 outval, size_t dlen)
+{
+	struct hisilpc_dev *lpcdev;
+	struct lpc_cycle_para iopara;
+	const unsigned char *newbuf;
+
+	if (!devobj || !dlen || dlen > LPC_MAX_DULEN)
+		return;
+
+	if (sizeof(outval) < dlen)
+		return;
+
+	outval = cpu_to_le32(outval);
+
+	newbuf = (const unsigned char *)&outval;
+	lpcdev = (struct hisilpc_dev *)devobj;
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	hisilpc_target_out(lpcdev, &iopara, ptaddr, newbuf, dlen);
+}
+
+/**
+ * hisilpc_comm_ins - read/input the data in buffer to the I/O peripheral
+ *		    through LPC, it corresponds to ins(b,w,l)
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @ptaddr: the target I/O port address.
+ * @inbuf: a buffer where read/input data bytes are stored.
+ * @dlen: the data length required writing to the target I/O port.
+ * @count: how many data units whose length is dlen will be read.
+ *
+ */
+static u64 hisilpc_comm_ins(void *devobj, unsigned long ptaddr,
+			void *inbuf, size_t dlen, unsigned int count)
+{
+	struct hisilpc_dev *lpcdev;
+	struct lpc_cycle_para iopara;
+	unsigned char *newbuf;
+	unsigned int loopcnt, cntleft;
+	unsigned int max_perburst;
+	int ret = 0;
+
+	if (!devobj || !inbuf || !count || !dlen ||
+			dlen > LPC_MAX_DULEN || (dlen & (dlen - 1)))
+		return -1;
+
+	iopara.opflags = 0;
+	if (dlen > 1)
+		iopara.opflags |= FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	lpcdev = (struct hisilpc_dev *)devobj;
+	newbuf = (unsigned char *)inbuf;
+	/*
+	 * ensure data stream whose length is multiple of dlen to be processed
+	 * each IO input
+	 */
+	max_perburst = LPC_MAX_OPCNT & (~(dlen - 1));
+	cntleft = count * dlen;
+	do {
+		loopcnt = (cntleft >= max_perburst) ? max_perburst : cntleft;
+		ret = hisilpc_target_in(lpcdev, &iopara, ptaddr, newbuf,
+						loopcnt);
+		if (ret)
+			break;
+		newbuf += loopcnt;
+		cntleft -= loopcnt;
+	} while (cntleft);
+
+	return ret;
+}
+
+/**
+ * hisilpc_comm_outs - write/output the data in buffer to the I/O peripheral
+ *		    through LPC, it corresponds to outs(b,w,l)
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @ptaddr: the target I/O port address.
+ * @outbuf: a buffer where write/output data bytes are stored.
+ * @dlen: the data length required writing to the target I/O port .
+ * @count: how many data units whose length is dlen will be written.
+ *
+ */
+static void hisilpc_comm_outs(void *devobj, unsigned long ptaddr,
+			const void *outbuf, size_t dlen, unsigned int count)
+{
+	struct hisilpc_dev *lpcdev;
+	struct lpc_cycle_para iopara;
+	const unsigned char *newbuf;
+	unsigned int loopcnt, cntleft;
+	unsigned int max_perburst;
+	int ret = 0;
+
+	if (!devobj || !outbuf || !count || !dlen ||
+			dlen > LPC_MAX_DULEN || (dlen & (dlen - 1)))
+		return;
+
+	iopara.opflags = 0;
+	if (dlen > 1)
+		iopara.opflags |= FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	lpcdev = (struct hisilpc_dev *)devobj;
+	newbuf = (unsigned char *)outbuf;
+	/*
+	 * ensure data stream whose lenght is multiple of dlen to be processed
+	 * each IO input
+	 */
+	max_perburst = LPC_MAX_OPCNT & (~(dlen - 1));
+	cntleft = count * dlen;
+	do {
+		loopcnt = (cntleft >= max_perburst) ? max_perburst : cntleft;
+		ret = hisilpc_target_out(lpcdev, &iopara, ptaddr, newbuf,
+						loopcnt);
+		if (ret)
+			break;
+		newbuf += loopcnt;
+		cntleft -= loopcnt;
+	} while (cntleft);
+}
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
+	dev_info(&pdev->dev, "probing hslpc...\n");
+
+	lpcdev = devm_kzalloc(&pdev->dev,
+				sizeof(struct hisilpc_dev), GFP_KERNEL);
+	if (!lpcdev)
+		return -ENOMEM;
+
+	spin_lock_init(&lpcdev->cycle_lock);
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lpcdev->membase = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(lpcdev->membase)) {
+		dev_err(&pdev->dev, "ioremap memory FAIL(%d)!\n",
+				PTR_ERR(lpcdev->membase));
+		return PTR_ERR(lpcdev->membase);
+	}
+	/*
+	 * The first PCIBIOS_MIN_IO is reserved specifically for indirectIO.
+	 * It will separate indirectIO range from pci host bridge to
+	 * avoid the possible PIO conflict.
+	 * Set the indirectIO range directly here.
+	 */
+	lpcdev->io_ops.start = 0;
+	lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
+	lpcdev->io_ops.devpara = lpcdev;
+	lpcdev->io_ops.pfin = hisilpc_comm_in;
+	lpcdev->io_ops.pfout = hisilpc_comm_out;
+	lpcdev->io_ops.pfins = hisilpc_comm_ins;
+	lpcdev->io_ops.pfouts = hisilpc_comm_outs;
+
+	platform_set_drvdata(pdev, lpcdev);
+
+	arm64_set_extops(&lpcdev->io_ops);
+
+	/*
+	 * The children scanning is only for dts mode. For ACPI children,
+	 * the corresponding devices had be created during acpi scanning.
+	 */
+	ret = 0;
+	if (!has_acpi_companion(&pdev->dev))
+		ret = of_platform_populate(pdev->dev.of_node, NULL, NULL,
+				&pdev->dev);
+
+	if (!ret)
+		dev_info(&pdev->dev, "hslpc end probing. range[0x%lx - %lx]\n",
+			arm64_extio_ops->start, arm64_extio_ops->end);
+	else
+		dev_info(&pdev->dev, "hslpc probing is fail(%d)\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id hisilpc_of_match[] = {
+	{
+		.compatible = "hisilicon,hip06-lpc",
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
-- 
1.9.1

