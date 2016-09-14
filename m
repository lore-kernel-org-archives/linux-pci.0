Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:57964 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761918AbcINMC4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 08:02:56 -0400
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
Subject: [PATCH V3 4/4] ARM64 LPC: support earlycon for UART connected to LPC
Date: Wed, 14 Sep 2016 20:15:54 +0800
Message-ID: <1473855354-150093-5-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

This patch support the earlycon for UART connected to LPC on Hip06.
This patch is depended on the LPC driver.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
---
 drivers/bus/hisi_lpc.c               | 113 +++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_early.c |  26 +++++++-
 2 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 9b364d0..2269828 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -360,6 +360,119 @@ void hisilpc_comm_outb(void *devobj, unsigned long ptaddr,
 
 
 /**
+ * hisilpc_early_in - read/input operation specific for hisi LPC earlycon.
+ * @devobj: pointer to device relevant information of the caller.
+ * @inbuf: the buffer where the read back data is populated.
+ *
+ * for earlycon, dlen and count should be one.
+ *
+ * Return the data read from earlycon on success, error ID on fail.
+ *
+ */
+static unsigned int __init hisilpc_early_in(struct uart_port *port, int offset)
+{
+	unsigned int backval = 0;
+	unsigned int ret = 0;
+	struct lpc_cycle_para para;
+	struct hisilpc_dev lpcdev;
+
+	if (!port->mapbase || !port->iobase || !port->membase)
+		return -EINVAL;
+
+	para.opflags = FG_EARLYCON_LPC;
+	para.csize = 1;
+	lpcdev.membase = port->membase;
+
+	ret = hisilpc_target_in(&lpcdev, &para,
+				port->iobase + (offset << port->regshift),
+				(unsigned char *)&backval, 1);
+	return (ret) ? : backval;
+}
+
+/**
+ * hisilpc_early_out - write/output operation specific for hisi LPC earlycon.
+ * @port: pointer to uart_port of eralycon
+ *
+ * for earlycon, dlen and count should be one.
+ *
+ */
+static void __init hisilpc_early_out(struct uart_port *port, int offset,
+					int value)
+{
+	struct lpc_cycle_para para;
+	struct hisilpc_dev lpcdev;
+
+	if (!port->mapbase || !port->iobase || !port->membase)
+		return;
+
+	para.opflags = FG_EARLYCON_LPC;
+	para.csize = 1;
+	lpcdev.membase = port->membase;
+
+	(void)hisilpc_target_out(&lpcdev, &para,
+				port->iobase + (offset << port->regshift),
+				(unsigned char *)&value, 1);
+}
+
+
+/**
+ * early_hisilpc8250_setup - initilize the lpc earlycon
+ * @device: pointer to the elarycon device
+ * @options: a option string from earlycon kernel-parameter
+ *
+ * Returns 0 on success, non-zero on fail.
+ *
+ */
+static int __init early_hisilpc8250_setup(struct earlycon_device *device,
+						const char *options)
+{
+	char *p;
+	int ret;
+
+	if (!device->port.membase)
+		return -ENODEV;
+
+	if (device->port.iotype != UPIO_MEM)
+		return -EINVAL;
+
+	if (device->options) {
+		p = strchr(device->options, ',');
+		if (p && (p + 1) != '\0') {
+			ret = kstrtoul(++p, 0,
+				(unsigned long *)&device->port.iobase);
+			if (ret || device->port.iobase == 0)
+				return ret ?: -EFAULT;
+		} else
+			device->port.iobase = 0x2f8;
+	} else {
+		device->port.iobase = 0x2f8;
+		device->baud = 0;
+	}
+
+	device->port.serial_in = hisilpc_early_in;
+	device->port.serial_out = hisilpc_early_out;
+	/* must convert iotype to UPIO_PORT for Hip06 indirect-io */
+	device->port.iotype = UPIO_PORT;
+
+	/* disable interrupts from LPC */
+	writel(LPC_IRQ_CLEAR, device->port.membase + LPC_REG_IRQ_ST);
+	/* ensure the LPC is available */
+	while (!(readl(device->port.membase + LPC_REG_OP_STATUS) &
+			LPC_STATUS_IDLE))
+		cpu_relax();
+
+	return early_serial8250_setup(device, options);
+}
+
+
+
+EARLYCON_DECLARE(hisilpcuart, early_hisilpc8250_setup);
+OF_EARLYCON_DECLARE(hisilpcuart, "hisilicon,lpc-uart",
+					early_hisilpc8250_setup);
+
+
+
+/**
  * hisilpc_ischild_ipmi - check whether the designated device is ipmi
  * @dev: the device to be checked.
  * @data: the value used to match the acpi device in checking.
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 85a12f0..3b5d0a8 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -37,7 +37,7 @@
 #include <asm/io.h>
 #include <asm/serial.h>
 
-static unsigned int __init serial8250_early_in(struct uart_port *port, int offset)
+static unsigned int __init serial8250_early_in_raw(struct uart_port *port, int offset)
 {
 	offset <<= port->regshift;
 
@@ -57,7 +57,7 @@ static unsigned int __init serial8250_early_in(struct uart_port *port, int offse
 	}
 }
 
-static void __init serial8250_early_out(struct uart_port *port, int offset, int value)
+static void __init serial8250_early_out_raw(struct uart_port *port, int offset, int value)
 {
 	offset <<= port->regshift;
 
@@ -80,6 +80,28 @@ static void __init serial8250_early_out(struct uart_port *port, int offset, int
 	}
 }
 
+static inline void __init serial8250_early_out(struct uart_port *port,
+					int offset, int value)
+{
+	if (port->serial_out)
+		port->serial_out(port, offset, value);
+	else {
+		port->serial_out = serial8250_early_out_raw;
+		serial8250_early_out_raw(port, offset, value);
+	}
+}
+
+static inline unsigned int __init serial8250_early_in(struct uart_port *port,
+					int offset)
+{
+	if (port->serial_in)
+		return port->serial_in(port, offset);
+
+	port->serial_in = serial8250_early_in_raw;
+	return serial8250_early_in_raw(port, offset);
+}
+
+
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
 static void __init serial_putc(struct uart_port *port, int c)
-- 
1.9.1

