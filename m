Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <mark.rutland@arm.com>,
        <rjw@rjwysocki.net>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC: <linux-acpi@vger.kernel.org>, <lorenzo.pieralisi@arm.com>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <minyard@acm.org>, <liviu.dudau@arm.com>, <zourongrong@gmail.com>,
        <john.garry@huawei.com>, <gabriele.paoloni@huawei.com>,
        <zhichang.yuan02@gmail.com>, <kantyzc@163.com>,
        <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V7 7/7] LPC: Add the ACPI LPC support
Date: Mon, 13 Mar 2017 10:42:43 +0800
Message-ID: <1489372963-9000-8-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch update the _CRS of LPC children based on the relevant LIBIO
interfaces. Then the ACPI platform device enumeration for LPC can apply the
right I/O resource to request the system I/O space from ioport_resource and
ensure the LPC peripherals work well.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 345ea12..3796b1f 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -464,6 +464,27 @@ static int hisilpc_host_io_register(struct device *dev,
 
 	lpcdev->io_host = range;
 
+	/*
+	 * For ACPI children, translate the bus-local I/O range to logical
+	 * I/O range and set it as the current resource before the children
+	 * are enumerated.
+	 */
+	if (has_acpi_companion(dev)) {
+		struct acpi_device *root, *child;
+
+		root = to_acpi_device_node(dev->fwnode);
+		/* For hisilpc, only care about the sons of host. */
+		list_for_each_entry(child, &root->children, node) {
+			int ret;
+
+			ret = acpi_set_libio_resource(child, root);
+			if (ret) {
+				dev_err(&child->dev, "set resource failed..\n");
+				return ret;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -558,10 +579,18 @@ static int hisilpc_probe(struct platform_device *pdev)
 	{},
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hisilpc_acpi_match[] = {
+	{"HISI0191", },
+	{},
+};
+#endif
+
 static struct platform_driver hisilpc_driver = {
 	.driver = {
 		.name           = "hisi_lpc",
 		.of_match_table = hisilpc_of_match,
+		.acpi_match_table = ACPI_PTR(hisilpc_acpi_match),
 	},
 	.probe = hisilpc_probe,
 };
-- 
1.9.1

