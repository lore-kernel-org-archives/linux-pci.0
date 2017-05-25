Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 6/7] LPC: Add the ACPI LPC support
Date: Thu, 25 May 2017 12:37:27 +0100
Message-ID: <1495712248-5232-7-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, minyard@acm.org, gabriele.paoloni@huawei.com,
 benh@kernel.crashing.org, john.garry@huawei.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-acpi@vger.kernel.org,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, linux-pci@vger.kernel.org,
 olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

Based on the provious patches, this patch supports the ACPI LPC host on
Hip06/Hip07.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
---
 drivers/acpi/arm64/acpi_indirect_pio.c |  3 ++
 drivers/bus/hisi_lpc.c                 | 71 ++++++++++++++++++++++++++++++++--
 include/acpi/acpi_indirect_pio.h       |  4 ++
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/acpi_indirect_pio.c b/drivers/acpi/arm64/acpi_indirect_pio.c
index 7813f73..3a5ba7a 100644
--- a/drivers/acpi/arm64/acpi_indirect_pio.c
+++ b/drivers/acpi/arm64/acpi_indirect_pio.c
@@ -261,6 +261,9 @@ int acpi_set_logic_pio_resource(struct device *child,
 
 /* All the host devices which apply indirect-PIO can be listed here. */
 static const struct acpi_device_id acpi_indirect_host_id[] = {
+#ifdef CONFIG_HISILICON_LPC
+	{"HISI0191", INDIRECT_PIO_INFO(lpc_host_desc)},
+#endif
 	{""},
 };
 
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 4f3bf76..05a0a84 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -467,7 +467,9 @@ static int hisilpc_probe(struct platform_device *pdev)
 	}
 
 	/* register the LPC host PIO resources */
-	if (!has_acpi_companion(dev)) {
+	if (has_acpi_companion(dev)) {
+		lpcdev->io_host = find_io_range_by_fwnode(dev->fwnode);
+	} else {
 		struct logic_pio_hwaddr *range;
 
 		range = kzalloc(sizeof(*range), GFP_KERNEL);
@@ -481,13 +483,14 @@ static int hisilpc_probe(struct platform_device *pdev)
 		ret = logic_pio_register_range(range);
 		if (ret) {
 			kfree(range);
-			dev_err(dev, "OF: register IO range FAIL!\n");
+			dev_err(dev, "OF: logic_pio_register_range returned %d!\n",
+					ret);
 			return -ret;
 		}
 		lpcdev->io_host = range;
 	}
 	if (!lpcdev->io_host) {
-		dev_err(dev, "Hisilpc IO hasn't registered!\n");
+		dev_err(dev, "HiSi LPC IO hasn't been registered!\n");
 		return -EFAULT;
 	}
 
@@ -533,10 +536,72 @@ static const struct of_device_id hisilpc_of_match[] = {
 	{},
 };
 
+#ifdef CONFIG_ACPI
+#include <acpi/acpi_indirect_pio.h>
+
+struct lpc_private_data {
+	resource_size_t io_size;
+	resource_size_t io_start;
+};
+
+static struct lpc_private_data lpc_data = {
+	.io_size = LPC_BUS_IO_SIZE,
+	.io_start = LPC_MIN_BUS_RANGE,
+};
+
+static int lpc_host_io_setup(struct acpi_device *adev, void *pdata)
+{
+	int ret = 0;
+	struct logic_pio_hwaddr *range;
+	struct lpc_private_data *lpc_private;
+	struct acpi_device *child;
+
+	lpc_private = (struct lpc_private_data *)pdata;
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+	range->fwnode = &adev->fwnode;
+	range->flags = PIO_INDIRECT;
+	range->size = lpc_private->io_size;
+	range->hw_start = lpc_private->io_start;
+
+	ret = logic_pio_register_range(range);
+	if (ret) {
+		kfree(range);
+		return ret;
+	}
+
+	/* In HiSilicon lpc, only care about the children of the host. */
+	list_for_each_entry(child, &adev->children, node) {
+		ret = acpi_set_logic_pio_resource(&child->dev, &adev->dev);
+		if (ret) {
+			dev_err(&child->dev,
+					"acpi_set_logic_pio_resource() returned %d\n",
+					ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static const struct acpi_device_id hisilpc_acpi_match[] = {
+	{"HISI0191", },
+	{},
+};
+
+const struct indirect_pio_device_desc lpc_host_desc = {
+	.pdata = &lpc_data,
+	.pre_setup = lpc_host_io_setup,
+};
+
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
diff --git a/include/acpi/acpi_indirect_pio.h b/include/acpi/acpi_indirect_pio.h
index efc5c43..7a8d26b 100644
--- a/include/acpi/acpi_indirect_pio.h
+++ b/include/acpi/acpi_indirect_pio.h
@@ -18,6 +18,10 @@ struct indirect_pio_device_desc {
 	int (*pre_setup)(struct acpi_device *adev, void *pdata);
 };
 
+#ifdef CONFIG_HISILICON_LPC
+extern const struct indirect_pio_device_desc lpc_host_desc;
+#endif
+
 int acpi_set_logic_pio_resource(struct device *child,
 		struct device *hostdev);
 
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
