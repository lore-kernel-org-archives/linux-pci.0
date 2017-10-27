Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>, <lorenzo.pieralisi@arm.com>
CC: <gabriele.paoloni@huawei.com>, <mark.rutland@arm.com>,
        <brian.starkey@arm.com>, <olof@lixom.net>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with DT bindings
Date: Fri, 27 Oct 2017 17:11:24 +0100
Message-ID: <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

The low-pin-count(LPC) interface of Hip06/Hip07 accesses the peripherals in
I/O port addresses. This patch implements the LPC host controller driver
which perform the I/O operations on the underlying hardware.
We don't want to touch those existing peripherals' driver, such as ipmi-bt.
So this driver applies the indirect-IO introduced in the previous patch
after registering an indirect-IO node to the indirect-IO devices list which
will be searched in the I/O accessors to retrieve the host-local I/O port.

Signed-off-by: Zou Rongrong <zourongrong@huawei.com>
Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Rob Herring <robh@kernel.org> #dts part
---
 .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/hisi_lpc.c                             | 526 +++++++++++++++++++++
 4 files changed, 569 insertions(+)
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
index 2408ea3..358eed3 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -64,6 +64,15 @@ config BRCMSTB_GISB_ARB
 	  arbiter. This driver provides timeout and target abort error handling
 	  and internal bus master decoding.
 
+config HISILICON_LPC
+	bool "Support for ISA I/O space on Hisilicon Hip0X"
+	depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
+	select LOGIC_PIO
+	select INDIRECT_PIO
+	help
+	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
+	  on Hisilicon Hip0X SoC.
+
 config IMX_WEIM
 	bool "Freescale EIM DRIVER"
 	depends on ARCH_MXC
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index cc6364b..28e3862 100644
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
index 0000000..c885483
--- /dev/null
+++ b/drivers/bus/hisi_lpc.c
@@ -0,0 +1,526 @@
+/*
+ * Copyright (C) 2017 Hisilicon Limited, All Rights Reserved.
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
+#include <linux/logic_pio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#define LPC_MIN_BUS_RANGE	0x0
+
+/*
+ * The default maximal IO size for Hip06/Hip07 LPC bus.
+ * Defining the I/O range size as 0x4000 here should be sufficient for
+ * all peripherals under the bus.
+ */
+#define LPC_BUS_IO_SIZE		0x4000
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
+struct hisilpc_dev {
+	spinlock_t cycle_lock;
+	void __iomem  *membase;
+	struct logic_pio_hwaddr *io_host;
+};
+
+/* The maximum continuous cycles per burst */
+#define LPC_MAX_BURST	16
+/* The IO cycle counts supported is four per operation at maximum */
+#define LPC_MAX_DULEN	4
+#if LPC_MAX_DULEN > LPC_MAX_BURST
+#error "LPC.. MAX_DULEN must be not bigger than MAX_OPCNT!"
+#endif
+
+#if LPC_MAX_BURST % LPC_MAX_DULEN
+#error "LPC.. LPC_MAX_BURST must be multiple of LPC_MAX_DULEN!"
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
+/* The command register fields */
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
+/* The minimal nanosecond interval for each query on LPC cycle status. */
+#define LPC_NSEC_PERWAIT	100
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
+/*
+ * hisilpc_target_in - trigger a series of lpc cycles to read required data
+ *		       from target peripheral.
+ * @pdev: pointer to hisi lpc device
+ * @para: some parameters used to control the lpc I/O operations
+ * @ptaddr: the lpc I/O target port address
+ * @buf: where the read back data is stored
+ * @opcnt: how many I/O operations required in this calling
+ *
+ * Only one byte data is read each I/O operation.
+ *
+ * Returns 0 on success, non-zero on fail.
+ */
+static int
+hisilpc_target_in(struct hisilpc_dev *lpcdev, struct lpc_cycle_para *para,
+		  unsigned long ptaddr, unsigned char *buf,
+		  unsigned long opcnt)
+{
+	unsigned long cnt_per_trans;
+	unsigned int cmd_word;
+	unsigned int waitcnt;
+	int ret;
+
+	if (!buf || !opcnt || !para || !para->csize || !lpcdev)
+		return -EINVAL;
+
+	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
+	waitcnt = LPC_PEROP_WAITCNT;
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
+		writel_relaxed(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
+
+		writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
+
+		writel_relaxed(ptaddr, lpcdev->membase + LPC_REG_ADDR);
+
+		writel(START_WORK, lpcdev->membase + LPC_REG_START);
+
+		/* whether the operation is finished */
+		ret = wait_lpc_idle(lpcdev->membase, waitcnt);
+		if (!ret) {
+			opcnt -= cnt_per_trans;
+			for (cnt_per_trans--; cnt_per_trans--; buf++)
+				*buf = readb_relaxed(lpcdev->membase +
+					LPC_REG_RDATA);
+			*buf = readb(lpcdev->membase + LPC_REG_RDATA);
+		}
+
+		spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
+	}
+
+	return ret;
+}
+
+/*
+ * hisilpc_target_out - trigger a series of lpc cycles to write required
+ *			data to target peripheral.
+ * @pdev: pointer to hisi lpc device
+ * @para: some parameters used to control the lpc I/O operations
+ * @ptaddr: the lpc I/O target port address
+ * @buf: where the data to be written is stored
+ * @opcnt: how many I/O operations required
+ *
+ * Only one byte data is read each I/O operation.
+ *
+ * Returns 0 on success, non-zero on fail.
+ *
+ */
+static int
+hisilpc_target_out(struct hisilpc_dev *lpcdev, struct lpc_cycle_para *para,
+		   unsigned long ptaddr, const unsigned char *buf,
+		   unsigned long opcnt)
+{
+	unsigned long cnt_per_trans;
+	unsigned int cmd_word;
+	unsigned int waitcnt;
+	int ret;
+
+	if (!buf || !opcnt || !para || !lpcdev)
+		return -EINVAL;
+
+	/* default is increasing address */
+	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_WRITE;
+	waitcnt = LPC_PEROP_WAITCNT;
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
+		writel_relaxed(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
+		writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
+		writel_relaxed(ptaddr, lpcdev->membase + LPC_REG_ADDR);
+
+		opcnt -= cnt_per_trans;
+		for (; cnt_per_trans--; buf++)
+			writeb_relaxed(*buf, lpcdev->membase + LPC_REG_WDATA);
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
+static inline unsigned long
+hisi_lpc_pio_to_addr(struct hisilpc_dev *lpcdev, unsigned long pio)
+{
+	return pio - lpcdev->io_host->io_start +
+		lpcdev->io_host->hw_start;
+}
+
+
+/**
+ * hisilpc_comm_in - read/input the data from the I/O peripheral
+ *		     through LPC.
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @pio: the target I/O port address.
+ * @dlen: the data length required to read from the target I/O port.
+ *
+ * when succeed, the data read back is stored in buffer pointed by inbuf.
+ * For inb, return the data read from I/O or -1 when error occur.
+ */
+static u32 hisilpc_comm_in(void *devobj, unsigned long pio, size_t dlen)
+{
+	int ret = 0;
+	unsigned char rd_data = 0;
+	unsigned long ptaddr;
+	struct lpc_cycle_para iopara;
+	struct hisilpc_dev *lpcdev = devobj;
+
+	if (!lpcdev || !dlen || dlen > LPC_MAX_DULEN)
+		return -1;
+
+	ptaddr = hisi_lpc_pio_to_addr(lpcdev, pio);
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	ret = hisilpc_target_in(lpcdev, &iopara, ptaddr, &rd_data, dlen);
+	if (ret)
+		return -1;
+
+	return le32_to_cpu((u32)rd_data);
+}
+
+/**
+ * hisilpc_comm_out - output the data whose maximum length is four bytes
+		      to the I/O peripheral through the LPC host.
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @outval: a value to be outputted from caller, maximum is four bytes.
+ * @pio: the target I/O port address.
+ * @dlen: the data length required writing to the target I/O port.
+ *
+ * This function is corresponding to out(b,w,l) only
+ *
+ */
+static void hisilpc_comm_out(void *devobj, unsigned long pio,
+			     u32 outval, size_t dlen)
+{
+	unsigned long ptaddr;
+	struct hisilpc_dev *lpcdev = devobj;
+	struct lpc_cycle_para iopara;
+	const unsigned char *newbuf;
+
+	if (!lpcdev || !dlen || dlen > LPC_MAX_DULEN)
+		return;
+
+	outval = cpu_to_le32(outval);
+
+	newbuf = (const unsigned char *)&outval;
+	ptaddr = hisi_lpc_pio_to_addr(lpcdev, pio);
+
+	iopara.opflags = FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	hisilpc_target_out(lpcdev, &iopara, ptaddr, newbuf, dlen);
+}
+
+/*
+ * hisilpc_comm_ins - read/input the data in buffer to the I/O
+ *		peripheral through LPC, it corresponds to ins(b,w,l)
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @pio: the target I/O port address.
+ * @inbuf: a buffer where read/input data bytes are stored.
+ * @dlen: the data length required writing to the target I/O port.
+ * @count: how many data units whose length is dlen will be read.
+ *
+ * when succeed, the data read back is stored in buffer pointed by inbuf.
+ * Returns 0 on success, -errno otherwise
+ *
+ */
+static u32
+hisilpc_comm_ins(void *devobj, unsigned long pio, void *inbuf,
+		 size_t dlen, unsigned int count)
+{
+	struct hisilpc_dev *lpcdev = devobj;
+	struct lpc_cycle_para iopara;
+	unsigned char *newbuf;
+	unsigned int loopcnt, cntleft;
+	unsigned long ptaddr;
+
+	if (!lpcdev || !inbuf || !count || !dlen || dlen > LPC_MAX_DULEN ||
+			count % dlen)
+		return -EINVAL;
+
+	iopara.opflags = 0;
+	if (dlen > 1)
+		iopara.opflags |= FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	ptaddr = hisi_lpc_pio_to_addr(lpcdev, pio);
+	newbuf = inbuf;
+	/*
+	 * ensure data stream whose length is multiple of dlen to be processed
+	 * each IO input
+	 */
+	cntleft = count * dlen;
+	do {
+		int ret;
+
+		loopcnt = min_t(unsigned int, LPC_MAX_BURST, cntleft);
+		ret = hisilpc_target_in(lpcdev, &iopara, ptaddr,
+					newbuf, loopcnt);
+		if (ret)
+			return ret;
+		newbuf += loopcnt;
+		cntleft -= loopcnt;
+	} while (cntleft);
+
+	return 0;
+}
+
+/*
+ * hisilpc_comm_outs - write/output the data in buffer to the I/O
+ *		peripheral through LPC, it corresponds to outs(b,w,l)
+ * @devobj: pointer to the device information relevant to LPC controller.
+ * @pio: the target I/O port address.
+ * @outbuf: a buffer where write/output data bytes are stored.
+ * @dlen: the data length required writing to the target I/O port .
+ * @count: how many data units whose length is dlen will be written.
+ *
+ */
+static void
+hisilpc_comm_outs(void *devobj, unsigned long pio, const void *outbuf,
+		  size_t dlen, unsigned int count)
+{
+	struct hisilpc_dev *lpcdev = devobj;
+	struct lpc_cycle_para iopara;
+	const unsigned char *newbuf;
+	unsigned int loopcnt, cntleft;
+	unsigned long ptaddr;
+
+	if (!lpcdev || !outbuf || !count || !dlen || dlen > LPC_MAX_DULEN ||
+			count % dlen)
+		return;
+
+	iopara.opflags = 0;
+	if (dlen > 1)
+		iopara.opflags |= FG_INCRADDR_LPC;
+	iopara.csize = dlen;
+
+	ptaddr = hisi_lpc_pio_to_addr(lpcdev, pio);
+	newbuf = outbuf;
+	/*
+	 * ensure data stream whose length is multiple of dlen to be processed
+	 * each IO input
+	 */
+	cntleft = count * dlen;
+	do {
+		loopcnt = min_t(unsigned int, LPC_MAX_BURST, cntleft);
+		if (hisilpc_target_out(lpcdev, &iopara, ptaddr, newbuf,
+						loopcnt))
+			break;
+		newbuf += loopcnt;
+		cntleft -= loopcnt;
+	} while (cntleft);
+}
+
+static struct hostio_ops hisi_lpc_ops = {
+	.pfin = hisilpc_comm_in,
+	.pfout = hisilpc_comm_out,
+	.pfins = hisilpc_comm_ins,
+	.pfouts = hisilpc_comm_outs,
+};
+
+/**
+ * hisilpc_probe - the probe callback function for hisi lpc device,
+ *		   will finish all the initialization.
+ * @pdev: the platform device corresponding to hisi lpc
+ *
+ * Returns 0 on success, non-zero on fail.
+ */
+static int hisilpc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct hisilpc_dev *lpcdev;
+	struct logic_pio_hwaddr *range;
+	int ret = 0;
+
+	lpcdev = devm_kzalloc(dev, sizeof(struct hisilpc_dev), GFP_KERNEL);
+	if (!lpcdev)
+		return -ENOMEM;
+
+	spin_lock_init(&lpcdev->cycle_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "no MEM resource\n");
+		return -ENODEV;
+	}
+
+	lpcdev->membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(lpcdev->membase)) {
+		dev_err(dev, "remap failed\n");
+		return PTR_ERR(lpcdev->membase);
+	}
+
+	/* register the LPC host PIO resources */
+	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+	range->fwnode = dev->fwnode;
+	range->flags = PIO_INDIRECT;
+	range->size = LPC_BUS_IO_SIZE;
+	range->hw_start = LPC_MIN_BUS_RANGE;
+
+	ret = logic_pio_register_range(range);
+	if (ret) {
+		kfree(range);
+		dev_err(dev, "OF: register IO range FAIL!\n");
+		return -ret;
+	}
+	lpcdev->io_host = range;
+	lpcdev->io_host->devpara = lpcdev;
+	lpcdev->io_host->ops = &hisi_lpc_ops;
+
+	/*
+	 * It is time to start the children scannings....
+	 * For ACPI children, the corresponding devices had been created
+	 * during the ACPI enumeration.
+	 * The OF scanning must be performed after initialization of 'lpcdev'
+	 * to avoid some children which complete the scanning trigger the
+	 * MMIO accesses which will probably cause panic.
+	 */
+	dev_info(dev, " calling of_platform_populate");
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret) {
+		/*
+		 * When LPC probing is not completely successful, set 'devpara'
+		 * as NULL. This will make all the LPC I/O return failure
+		 * directly without any hardware operations. It will prevent
+		 * some peripherals which had not finished the initialization to
+		 * manipulate I/O for safety.
+		 */
+		lpcdev->io_host->devpara = NULL;
+		dev_err(dev, "OF: scan hisilpc children got failed(%d)\n",
+			ret);
+		return ret;
+	}
+
+	dev_info(dev, "hslpc end probing. range[%pa - sz:%pa]\n",
+		&lpcdev->io_host->io_start,
+		&lpcdev->io_host->size);
+
+	return ret;
+}
+
+static const struct of_device_id hisilpc_of_match[] = {
+	{ .compatible = "hisilicon,hip06-lpc", },
+	{ .compatible = "hisilicon,hip07-lpc", },
+	{},
+};
+
+static struct platform_driver hisilpc_driver = {
+	.driver = {
+		.name           = "hisi_lpc",
+		.of_match_table = hisilpc_of_match,
+	},
+	.probe = hisilpc_probe,
+};
+
+builtin_platform_driver(hisilpc_driver);
-- 
2.7.4


