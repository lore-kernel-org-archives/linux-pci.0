Return-Path: <linux-acpi-owner@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>,
        <andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v16 6/9] HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings
Date: Tue, 6 Mar 2018 18:47:45 +0800
Message-ID: <1520333268-82754-7-git-send-email-john.garry@huawei.com>
In-Reply-To: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Zhichang Yuan <yuanzhichang@hisilicon.com>

The low-pin-count(LPC) interface of Hip06/Hip07 accesses the peripherals in
I/O port addresses. This patch implements the LPC host controller driver
which perform the I/O operations on the underlying hardware.
We don't want to touch those existing peripherals' driver, such as ipmi-bt.
So this driver applies the indirect-IO introduced in the previous patch
after registering an indirect-IO node to the indirect-IO devices list which
will be searched in the I/O accessors to retrieve the host-local I/O port.

The driver config is set as a bool instead of a trisate. The reason
here is that, by the very nature of the driver providing a logical
PIO range, it does not make sense to have this driver as a loadable
module. Another more specific reason is that the Huawei D03 board
which includes hip06 SoC requires the LPC bus for UART console, so
should be built in.

Signed-off-by: Zou Rongrong <zourongrong@huawei.com>
Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Rob Herring <robh@kernel.org> #dts part
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/hisi_lpc.c                             | 421 +++++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
 create mode 100644 drivers/bus/hisi_lpc.c

diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
new file mode 100644
index 0000000..213181f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
@@ -0,0 +1,33 @@
+Hisilicon Hip06 low-pin-count device
+  Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
+  provides I/O access to some legacy ISA devices.
+  Hip06 is based on arm64 architecture where there is no I/O space. So, the
+  I/O ports here are not cpu addresses, and there is no 'ranges' property in
+  LPC device node.
+
+Required properties:
+- compatible:  value should be as follows:
+	(a) "hisilicon,hip06-lpc"
+	(b) "hisilicon,hip07-lpc"
+- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
+- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
+- reg: base memory range where the LPC register set is mapped.
+
+Note:
+  The node name before '@' must be "isa" to represent the binding stick to the
+  ISA/EISA binding specification.
+
+Example:
+
+isa@a01b0000 {
+	compatible = "hisilicon,hip06-lpc";
+	#address-cells = <2>;
+	#size-cells = <1>;
+	reg = <0x0 0xa01b0000 0x0 0x1000>;
+
+	ipmi0: bt@e4 {
+		compatible = "ipmi-bt";
+		device_type = "ipmi";
+		reg = <0x01 0xe4 0x04>;
+	};
+};
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 769599b..0097317 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -65,6 +65,14 @@ config BRCMSTB_GISB_ARB
 	  arbiter. This driver provides timeout and target abort error handling
 	  and internal bus master decoding.
 
+config HISILICON_LPC
+	bool "Support for ISA I/O space on Hisilicon hip06/7"
+	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
+	select INDIRECT_PIO
+	help
+	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
+	  on Hisilicon hip06/7 SoC.
+
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
 	depends on ARCH_MXC
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index b666c49..b8d9ffb 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
 # DPAA2 fsl-mc bus
 obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 
+obj-$(CONFIG_HISILICON_LPC)	+= hisi_lpc.o
+
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
 obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
new file mode 100644
index 0000000..c331609
--- /dev/null
+++ b/drivers/bus/hisi_lpc.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
+ * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ * Author: Zou Rongrong <zourongrong@huawei.com>
+ * Author: John Garry <john.garry@huawei.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/logic_pio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#define DRV_NAME "hisi-lpc"
+
+/*
+ * Setting this bit means each IO operation will target to a
+ * different port address:
+ * 0 means repeatedly IO operations will stick on the same port,
+ * such as BT;
+ */
+#define FG_INCRADDR_LPC		0x02
+
+struct lpc_cycle_para {
+	unsigned int opflags;
+	unsigned int csize; /* the data length of each operation */
+};
+
+struct hisi_lpc_dev {
+	spinlock_t cycle_lock;
+	void __iomem  *membase;
+	struct logic_pio_hwaddr *io_host;
+};
+
+/* The maxIO cycle counts supported is four per operation at maximum */
+#define LPC_MAX_DWIDTH	4
+
+#define LPC_REG_STARTUP_SIGNAL		0x00
+#define LPC_REG_STARTUP_SIGNAL_START	BIT(0)
+#define LPC_REG_OP_STATUS		0x04
+#define LPC_REG_OP_STATUS_IDLE		BIT(0)
+#define LPC_REG_OP_STATUS_FINISHED	BIT(1)
+#define LPC_REG_OP_LEN			0x10 /* LPC cycles count per start */
+#define LPC_REG_CMD			0x14
+#define LPC_REG_CMD_OP			BIT(0) /* 0: read, 1: write */
+#define LPC_REG_CMD_SAMEADDR		BIT(3)
+#define LPC_REG_ADDR			0x20 /* target address */
+#define LPC_REG_WDATA			0x24 /* write FIFO */
+#define LPC_REG_RDATA			0x28 /* read FIFO */
+
+/* The minimal nanosecond interval for each query on LPC cycle status. */
+#define LPC_NSEC_PERWAIT	100
+
+/*
+ * The maximum waiting time is about 128us.
+ * It is specific for stream I/O, such as ins.
+ * The fastest IO cycle time is about 390ns, but the worst case will wait
+ * for extra 256 lpc clocks, so (256 + 13) * 30ns = 8 us. The maximum
+ * burst cycles is 16. So, the maximum waiting time is about 128us under
+ * worst case.
+ * choose 1300 as the maximum.
+ */
+#define LPC_MAX_WAITCNT		1300
+/* About 10us. This is specific for single IO operation, such as inb. */
+#define LPC_PEROP_WAITCNT	100
+
+static inline int wait_lpc_idle(unsigned char *mbase,
+				unsigned int waitcnt) {
+	do {
+		u32 status;
+
+		status = readl(mbase + LPC_REG_OP_STATUS);
+		if (status & LPC_REG_OP_STATUS_IDLE)
+			return (status & LPC_REG_OP_STATUS_FINISHED) ? 0 : -EIO;
+		ndelay(LPC_NSEC_PERWAIT);
+	} while (--waitcnt);
+
+	return -ETIME;
+}
+
+/*
+ * hisi_lpc_target_in - trigger a series of LPC cycles for read operation
+ * @lpcdev: pointer to hisi lpc device
+ * @para: some parameters used to control the lpc I/O operations
+ * @addr: the lpc I/O target port address
+ * @buf: where the read back data is stored
+ * @opcnt: how many I/O operations required, i.e. data width
+ *
+ * Returns 0 on success, non-zero on fail.
+ */
+static int
+hisi_lpc_target_in(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
+		  unsigned long addr, unsigned char *buf,
+		  unsigned long opcnt)
+{
+	unsigned int cmd_word;
+	unsigned int waitcnt;
+	unsigned long flags;
+	int ret;
+
+	if (!buf || !opcnt || !para || !para->csize || !lpcdev)
+		return -EINVAL;
+
+	cmd_word = 0; /* IO mode, Read */
+	waitcnt = LPC_PEROP_WAITCNT;
+	if (!(para->opflags & FG_INCRADDR_LPC)) {
+		cmd_word |= LPC_REG_CMD_SAMEADDR;
+		waitcnt = LPC_MAX_WAITCNT;
+	}
+
+	/* whole operation must be atomic */
+	spin_lock_irqsave(&lpcdev->cycle_lock, flags);
+
+	writel_relaxed(opcnt, lpcdev->membase + LPC_REG_OP_LEN);
+
+	writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
+
+	writel_relaxed(addr, lpcdev->membase + LPC_REG_ADDR);
+
+	writel(LPC_REG_STARTUP_SIGNAL_START,
+	       lpcdev->membase + LPC_REG_STARTUP_SIGNAL);
+
+	/* whether the operation is finished */
+	ret = wait_lpc_idle(lpcdev->membase, waitcnt);
+	if (ret) {
+		spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
+		return ret;
+	}
+
+	readsb(lpcdev->membase + LPC_REG_RDATA, buf, opcnt);
+
+	spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
+
+	return 0;
+}
+
+/*
+ * hisi_lpc_target_out - trigger a series of LPC cycles for write operation
+ * @lpcdev: pointer to hisi lpc device
+ * @para: some parameters used to control the lpc I/O operations
+ * @addr: the lpc I/O target port address
+ * @buf: where the data to be written is stored
+ * @opcnt: how many I/O operations required, i.e. data width
+ *
+ * Returns 0 on success, non-zero on fail.
+ */
+static int
+hisi_lpc_target_out(struct hisi_lpc_dev *lpcdev, struct lpc_cycle_para *para,
+		    unsigned long addr, const unsigned char *buf,
+		    unsigned long opcnt)
+{
+	unsigned int waitcnt;
+	unsigned long flags;
+	u32 cmd_word;
+	int ret;
+
+	if (!buf || !opcnt || !para || !lpcdev)
+		return -EINVAL;
+
+	/* default is increasing address */
+	cmd_word = LPC_REG_CMD_OP; /* IO mode, write */
+	waitcnt = LPC_PEROP_WAITCNT;
+	if (!(para->opflags & FG_INCRADDR_LPC)) {
+		cmd_word |= LPC_REG_CMD_SAMEADDR;
+		waitcnt = LPC_MAX_WAITCNT;
+	}
+
+	spin_lock_irqsave(&lpcdev->cycle_lock, flags);
+
+	writel_relaxed(opcnt, lpcdev->membase + LPC_REG_OP_LEN);
+	writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
+	writel_relaxed(addr, lpcdev->membase + LPC_REG_ADDR);
+
+	writesb(lpcdev->membase + LPC_REG_WDATA, buf, opcnt);
+
+	writel(LPC_REG_STARTUP_SIGNAL_START,
+	       lpcdev->membase + LPC_REG_STARTUP_SIGNAL);
+
+	/* whether the operation is finished */
+	ret = wait_lpc_idle(lpcdev->membase, waitcnt);
+
+	spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
+
+	return ret;
+}
+
+static inline unsigned long
+hisi_lpc_pio_to_addr(struct hisi_lpc_dev *lpcdev, unsigned long pio)
+{
+	return pio - lpcdev->io_host->io_start + lpcdev->io_host->hw_start;
+}
+
+/*
+ * hisi_lpc_comm_in - input the data in a single operation
+ * @hostdata: pointer to the device information relevant to LPC controller.
+ * @pio: the target I/O port address.
+ * @dwidth: the data length required to read from the target I/O port.
+ *
+ * When success, data is returned. Otherwise, ~0 is returned.
+ */
+static u32 hisi_lpc_comm_in(void *hostdata, unsigned long pio, size_t dwidth)
+{
+	struct hisi_lpc_dev *lpcdev = hostdata;
+	struct lpc_cycle_para iopara;
+	unsigned long addr;
+	u32 rd_data = 0;
+	int ret;
+
+	if (!lpcdev || !dwidth || dwidth > LPC_MAX_DWIDTH)
+		return ~0;
+
+	addr = hisi_lpc_pio_to_addr(lpcdev, pio);
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	iopara.csize = dwidth;
+
+	ret = hisi_lpc_target_in(lpcdev, &iopara, addr,
+				 (unsigned char *)&rd_data, dwidth);
+	if (ret)
+		return ~0;
+
+	return le32_to_cpu(rd_data);
+}
+
+/*
+ * hisi_lpc_comm_out - output the data in a single operation
+ * @hostdata: pointer to the device information relevant to LPC controller.
+ * @pio: the target I/O port address.
+ * @val: a value to be outputted from caller, maximum is four bytes.
+ * @dwidth: the data width required writing to the target I/O port.
+ *
+ * This function is corresponding to out(b,w,l) only
+ *
+ */
+static void hisi_lpc_comm_out(void *hostdata, unsigned long pio,
+			     u32 val, size_t dwidth)
+{
+	struct hisi_lpc_dev *lpcdev = hostdata;
+	struct lpc_cycle_para iopara;
+	const unsigned char *buf;
+	unsigned long addr;
+
+	if (!lpcdev || !dwidth || dwidth > LPC_MAX_DWIDTH)
+		return;
+
+	val = cpu_to_le32(val);
+
+	buf = (const unsigned char *)&val;
+	addr = hisi_lpc_pio_to_addr(lpcdev, pio);
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	iopara.csize = dwidth;
+
+	hisi_lpc_target_out(lpcdev, &iopara, addr, buf, dwidth);
+}
+
+/*
+ * hisi_lpc_comm_ins - input the data in the buffer in multiple operations
+ * @hostdata: pointer to the device information relevant to LPC controller.
+ * @pio: the target I/O port address.
+ * @buffer: a buffer where read/input data bytes are stored.
+ * @dwidth: the data width required writing to the target I/O port.
+ * @count: how many data units whose length is dwidth will be read.
+ *
+ * When success, the data read back is stored in buffer pointed by buffer.
+ * Returns 0 on success, -errno otherwise
+ *
+ */
+static u32
+hisi_lpc_comm_ins(void *hostdata, unsigned long pio, void *buffer,
+		  size_t dwidth, unsigned int count)
+{
+	struct hisi_lpc_dev *lpcdev = hostdata;
+	unsigned char *buf = buffer;
+	struct lpc_cycle_para iopara;
+	unsigned long addr;
+
+	if (!lpcdev || !buf || !count || !dwidth || dwidth > LPC_MAX_DWIDTH)
+		return -EINVAL;
+
+	iopara.opflags = 0;
+	if (dwidth > 1)
+		iopara.opflags |= FG_INCRADDR_LPC;
+	iopara.csize = dwidth;
+
+	addr = hisi_lpc_pio_to_addr(lpcdev, pio);
+
+	do {
+		int ret;
+
+		ret = hisi_lpc_target_in(lpcdev, &iopara, addr, buf, dwidth);
+		if (ret)
+			return ret;
+		buf += dwidth;
+	} while (--count);
+
+	return 0;
+}
+
+/*
+ * hisi_lpc_comm_outs - output the data in the buffer in multiple operations
+ * @hostdata: pointer to the device information relevant to LPC controller.
+ * @pio: the target I/O port address.
+ * @buffer: a buffer where write/output data bytes are stored.
+ * @dwidth: the data width required writing to the target I/O port .
+ * @count: how many data units whose length is dwidth will be written.
+ *
+ */
+static void
+hisi_lpc_comm_outs(void *hostdata, unsigned long pio, const void *buffer,
+		   size_t dwidth, unsigned int count)
+{
+	struct hisi_lpc_dev *lpcdev = hostdata;
+	struct lpc_cycle_para iopara;
+	const unsigned char *buf = buffer;
+	unsigned long addr;
+
+	if (!lpcdev || !buf || !count || !dwidth || dwidth > LPC_MAX_DWIDTH)
+		return;
+
+	iopara.opflags = 0;
+	if (dwidth > 1)
+		iopara.opflags |= FG_INCRADDR_LPC;
+	iopara.csize = dwidth;
+
+	addr = hisi_lpc_pio_to_addr(lpcdev, pio);
+	do {
+		if (hisi_lpc_target_out(lpcdev, &iopara, addr, buf, dwidth))
+			break;
+		buf += dwidth;
+	} while (--count);
+}
+
+static const struct logic_pio_host_ops hisi_lpc_ops = {
+	.in = hisi_lpc_comm_in,
+	.out = hisi_lpc_comm_out,
+	.ins = hisi_lpc_comm_ins,
+	.outs = hisi_lpc_comm_outs,
+};
+
+/*
+ * hisi_lpc_probe - the probe callback function for hisi lpc host,
+ *		   will finish all the initialization.
+ * @pdev: the platform device corresponding to hisi lpc host
+ *
+ * Returns 0 on success, non-zero on fail.
+ */
+static int hisi_lpc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_device *acpi_device = ACPI_COMPANION(dev);
+	struct logic_pio_hwaddr *range;
+	struct hisi_lpc_dev *lpcdev;
+	resource_size_t io_end;
+	struct resource *res;
+	int ret;
+
+	lpcdev = devm_kzalloc(dev, sizeof(*lpcdev), GFP_KERNEL);
+	if (!lpcdev)
+		return -ENOMEM;
+
+	spin_lock_init(&lpcdev->cycle_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	lpcdev->membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(lpcdev->membase))
+		return PTR_ERR(lpcdev->membase);
+
+	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+	range->fwnode = dev->fwnode;
+	range->flags = LOGIC_PIO_INDIRECT;
+	range->size = PIO_INDIRECT_SIZE;
+
+	ret = logic_pio_register_range(range);
+	if (ret) {
+		dev_err(dev, "register IO range failed (%d)!\n", ret);
+		return ret;
+	}
+	lpcdev->io_host = range;
+
+	/* register the LPC host PIO resources */
+	if (!acpi_device)
+		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		return ret;
+
+	lpcdev->io_host->hostdata = lpcdev;
+	lpcdev->io_host->ops = &hisi_lpc_ops;
+
+	io_end = lpcdev->io_host->io_start + lpcdev->io_host->size;
+	dev_info(dev, "registered range [%pa - %pa]\n",
+		 &lpcdev->io_host->io_start, &io_end);
+
+	return ret;
+}
+
+static const struct of_device_id hisi_lpc_of_match[] = {
+	{ .compatible = "hisilicon,hip06-lpc", },
+	{ .compatible = "hisilicon,hip07-lpc", },
+	{}
+};
+
+static struct platform_driver hisi_lpc_driver = {
+	.driver = {
+		.name           = DRV_NAME,
+		.of_match_table = hisi_lpc_of_match,
+	},
+	.probe = hisi_lpc_probe,
+};
+
+builtin_platform_driver(hisi_lpc_driver);
-- 
1.9.1

