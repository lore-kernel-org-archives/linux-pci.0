Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Subject: [PATCH V3 3/4] ARM64 LPC: support serial based on low-pin-count
Date: Wed, 14 Sep 2016 20:15:53 +0800
Message-ID: <1473855354-150093-4-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

On Hip06 platform, a 16550 compatible UART is connected to low-pin-count and
controlled through the LPC I/O cycles. After registering the LPC uart specific
serial_in/serial_out to 8250 core driver, serial data can be read/written
through the LPC.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
---
 .../devicetree/bindings/serial/hisi-lpc-uart.txt   |  60 ++++++++
 drivers/tty/serial/8250/8250_hisi_lpc.c            | 171 +++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |   9 ++
 drivers/tty/serial/8250/Makefile                   |   1 +
 4 files changed, 241 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/hisi-lpc-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_hisi_lpc.c

diff --git a/Documentation/devicetree/bindings/serial/hisi-lpc-uart.txt b/Documentation/devicetree/bindings/serial/hisi-lpc-uart.txt
new file mode 100644
index 0000000..0f8ec2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/hisi-lpc-uart.txt
@@ -0,0 +1,60 @@
+* Hisilicon hip06 UART through low-pin-count
+
+Required properties:
+- compatible : "hisilicon,lpc-uart"
+- reg : offset and length of the I/O port set for the device.
+- reg-names : name the uart resources.
+		"lpc_mem" represents memory resource of the LPC parent. When
+		flat-tree earlycon is needed, this memory resource and
+		resource name are mandatory. Otherwise they are optional;
+		"dev_io" represents I/O resource of this device. It is
+		mandatory to access this device;
+
+Clock handling:
+  The clock rate of this device is same as the 8250 default clock rate, that
+  is 1843200. No need to define the clock rate in device tree.
+
+Note:
+  This device depends on its parent device whose compatible string is
+  "hisilicon,low-pin-count".
+
+  The format of "reg" property follows the I/O space definition in ISA/EISA
+  binding specification linked to:
+  http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
+
+Example:
+
+	uart0: lpc-uart@2f8 {
+		compatible = "hisilicon,lpc-uart";
+		reg = <0x01 0x2f8 0x08>;
+		status = "disabled";
+	};
+
+
+Example with low-pin-count parent device:
+
+	isa@a01b0000 {
+		compatible = "hisilicon,low-pin-count";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x0 0xa01b0000 0x0 0x1000>;
+		ranges = <0x00 0xa01b0000 0x00 0xa01b0000 0x1000>,
+			<0x01 0xe4 0x0 0xe4 0x04>,
+			<0x01 0x2f8 0x0 0x2f8 0x08>;
+
+		ipmi0: bt@e4 {
+			compatible = "ipmi-bt";
+			device_type = "ipmi";
+			reg = <0x01 0xe4 0x04>;
+			reg-names = "dev_io";
+			status = "disabled";
+		};
+
+		uart0: lpc-uart@2f8 {
+			compatible = "hisilicon,lpc-uart";
+			reg =  <0x00 0xa01b0000 0x1000>,
+				<0x01 0x2f8 0x08>;
+			ret-names = "lpc_mem", "dev_io";
+			status = "disabled";
+		};
+	};
diff --git a/drivers/tty/serial/8250/8250_hisi_lpc.c b/drivers/tty/serial/8250/8250_hisi_lpc.c
new file mode 100644
index 0000000..a8ba1ca
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_hisi_lpc.c
@@ -0,0 +1,171 @@
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
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/serial_8250.h>
+#include <asm-generic/serial.h>
+#include <linux/of_address.h>
+
+
+/**
+ * hisilpc_serial_inb - read/input data from the designated serial port.
+ * @p: the serial port where the data read from
+ * @offset:  the target I/O port address where the read is from
+ *
+ * Returns the byte data from this serial port.
+ * -1 means some failures.
+ *
+ */
+static unsigned int hisilpc_serial_inb(struct uart_port *p, int offset)
+{
+	struct extio_ops *parentops;
+
+	parentops = p->private_data;
+	if (!parentops || !parentops->pfin)
+		return -1;
+
+	return parentops->pfin(parentops->devpara,
+				p->iobase + (offset << p->regshift),
+				NULL, sizeof(u8), 1);
+}
+
+/**
+ * hisilpc_serial_outb - write/output data from the designated serial port.
+ * @p: the serial port where the data is written to
+ * @offset:  the target I/O port address where the write is from
+ *
+ */
+static void hisilpc_serial_outb(struct uart_port *p, int offset, int value)
+{
+	struct extio_ops *parentops;
+
+	parentops = p->private_data;
+	if (!parentops || !parentops->pfout)
+		return;
+
+	parentops->pfout(parentops->devpara,
+				p->iobase + (offset << p->regshift),
+				&value, sizeof(u8), 1);
+}
+
+
+static int hisilpc8250_probe(struct platform_device *pdev)
+{
+	struct uart_8250_port uart = {};
+	struct uart_port *port = &uart.port;
+	int err = 0;
+	struct resource *iores;
+	struct extio_ops *platdata;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+	dev_info(&pdev->dev, "##probe entering\n");
+
+	/* To support the earlycon in bootargs, the first reg must be MEM */
+	iores = platform_get_resource_byname(pdev, IORESOURCE_IO,
+						"dev_io");
+	if (!iores) {
+		dev_err(&pdev->dev, "can not find the IO0\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * save the platform data from parent in uart_port for serial_in,
+	 * serial_out
+	 */
+	platdata = dev_get_platdata(&pdev->dev);
+	port->private_data = (void *)platdata;
+	if (!port->private_data) {
+		dev_err(&pdev->dev, "no platform data!\n");
+		return -ENODEV;
+	}
+
+	if (platdata->start != iores->start || platdata->end != iores->end) {
+		dev_err(&pdev->dev, "PIO range[0x%lx - %lx] isn't fit!\n",
+			(unsigned long)iores->start,
+			(unsigned long)iores->end);
+		return -ENXIO;
+	}
+	port->iobase = (unsigned long)iores->start + platdata->ptoffset;
+	dev_info(&pdev->dev, "real port start is 0x%lx\n", port->iobase);
+
+	port->irq	= 0;
+	port->flags	= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
+	port->dev	= &pdev->dev;
+	port->iotype	= UPIO_PORT;
+	port->regshift	= 0;
+	port->uartclk	= BASE_BAUD * 16;
+
+	spin_lock_init(&port->lock);
+
+	port->serial_in = hisilpc_serial_inb;
+	port->serial_out = hisilpc_serial_outb;
+
+	err = serial8250_register_8250_port(&uart);
+	if (err < 0) {
+		dev_err(&pdev->dev, "register uart FAIL(%d)!\n", -err);
+		return err;
+	}
+
+	platform_set_drvdata(pdev, (void *)&err);
+	dev_info(&pdev->dev, "##probing OK(%d)\n", err);
+	return 0;
+}
+
+static int hisilpc8250_remove(struct platform_device *pdev)
+{
+	int line = *((int *)platform_get_drvdata(pdev));
+
+	serial8250_unregister_port(line);
+
+	return 0;
+}
+
+
+static const struct of_device_id hs8250_of_match[] = {
+	{ .compatible = "hisilicon,lpc-uart" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hs8250_of_match);
+
+static const struct acpi_device_id hs8250_acpi_match[] = {
+	/*{ "PNP0501", 0 },*/
+	{ "HISI1031", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, hs8250_acpi_match);
+
+static struct platform_driver hs_lpc8250_driver = {
+	.driver = {
+		.name		= "hisi-lpc-uart",
+		.of_match_table	= hs8250_of_match,
+		.acpi_match_table = ACPI_PTR(hs8250_acpi_match),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe			= hisilpc8250_probe,
+	.remove			= hisilpc8250_remove,
+};
+
+module_platform_driver(hs_lpc8250_driver);
+
+
+MODULE_AUTHOR("Rongrong Zou");
+MODULE_DESCRIPTION("8250 serial probe module for Hisilicon LPC UART");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("v1.0");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 7c6f7af..c2e42f7 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -246,6 +246,15 @@ config SERIAL_8250_HUB6
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8250_hub6.
 
+config SERIAL_8250_HISI_LPC
+	tristate "Support Hisilicon Hip0X UART through LPC"
+	depends on SERIAL_8250 !=n && HISILICON_LPC
+	help
+	  Say Y here if you have a hip06 board.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called 8250_hisi_lpc.
+
 #
 # Misc. options/drivers.
 #
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 367d403..1f2915b 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
+obj-$(CONFIG_SERIAL_8250_HISI_LPC)	+= 8250_hisi_lpc.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
 obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
-- 
1.9.1
