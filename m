Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v10 8/9] LPC: Add the ACPI LPC support
Date: Fri, 27 Oct 2017 17:11:26 +0100
Message-ID: <1509120687-7352-9-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
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
 drivers/acpi/arm64/acpi_indirectio.c |   3 +
 drivers/acpi/arm64/acpi_indirectio.h |   4 +
 drivers/bus/hisi_lpc.c               | 164 +++++++++++++++++++++++++++++++----
 3 files changed, 154 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/arm64/acpi_indirectio.c b/drivers/acpi/arm64/acpi_indirectio.c
index 013db6f..424f3bd 100644
--- a/drivers/acpi/arm64/acpi_indirectio.c
+++ b/drivers/acpi/arm64/acpi_indirectio.c
@@ -123,6 +123,9 @@ int acpi_set_logicio_resource(struct device *child,
 
 /* All the host devices which apply indirect-IO can be listed here. */
 static const struct acpi_device_id acpi_indirect_host_id[] = {
+#ifdef CONFIG_HISILICON_LPC
+	{"HISI0191", INDIRECT_IO_INFO(lpc_host_desc)},
+#endif
 	{""},
 };
 
diff --git a/drivers/acpi/arm64/acpi_indirectio.h b/drivers/acpi/arm64/acpi_indirectio.h
index 8102ea0..1b18590 100644
--- a/drivers/acpi/arm64/acpi_indirectio.h
+++ b/drivers/acpi/arm64/acpi_indirectio.h
@@ -18,6 +18,10 @@ struct indirectio_device_desc {
 	int (*pre_setup)(struct acpi_device *adev, void *pdata);
 };
 
+#ifdef CONFIG_HISILICON_LPC
+extern const struct indirectio_device_desc lpc_host_desc;
+#endif
+
 int acpi_set_logicio_resource(struct device *child,
 		struct device *hostdev, const struct resource **res,
 		int *num_res);
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index c885483..26043f7 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -438,7 +438,6 @@ static int hisilpc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct hisilpc_dev *lpcdev;
-	struct logic_pio_hwaddr *range;
 	int ret = 0;
 
 	lpcdev = devm_kzalloc(dev, sizeof(struct hisilpc_dev), GFP_KERNEL);
@@ -460,21 +459,32 @@ static int hisilpc_probe(struct platform_device *pdev)
 	}
 
 	/* register the LPC host PIO resources */
-	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
-	if (!range)
-		return -ENOMEM;
-	range->fwnode = dev->fwnode;
-	range->flags = PIO_INDIRECT;
-	range->size = LPC_BUS_IO_SIZE;
-	range->hw_start = LPC_MIN_BUS_RANGE;
-
-	ret = logic_pio_register_range(range);
-	if (ret) {
-		kfree(range);
-		dev_err(dev, "OF: register IO range FAIL!\n");
-		return -ret;
+	if (has_acpi_companion(dev)) {
+		lpcdev->io_host = find_io_range_by_fwnode(dev->fwnode);
+		if (!lpcdev->io_host) {
+			dev_err(dev, "HiSilicon LPC range not registered!\n");
+			return -EFAULT;
+		}
+	} else {
+		struct logic_pio_hwaddr *range;
+
+		range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
+		if (!range)
+			return -ENOMEM;
+		range->fwnode = dev->fwnode;
+		range->flags = PIO_INDIRECT;
+		range->size = LPC_BUS_IO_SIZE;
+		range->hw_start = LPC_MIN_BUS_RANGE;
+
+		ret = logic_pio_register_range(range);
+		if (ret) {
+			kfree(range);
+			dev_err(dev, "OF: register IO range FAIL!\n");
+			return -ret;
+		}
+		lpcdev->io_host = range;
 	}
-	lpcdev->io_host = range;
+
 	lpcdev->io_host->devpara = lpcdev;
 	lpcdev->io_host->ops = &hisi_lpc_ops;
 
@@ -486,8 +496,11 @@ static int hisilpc_probe(struct platform_device *pdev)
 	 * to avoid some children which complete the scanning trigger the
 	 * MMIO accesses which will probably cause panic.
 	 */
-	dev_info(dev, " calling of_platform_populate");
-	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (!has_acpi_companion(dev)) {
+		dev_info(dev, " calling of_platform_populate");
+		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	}
+
 	if (ret) {
 		/*
 		 * When LPC probing is not completely successful, set 'devpara'
@@ -515,10 +528,127 @@ static const struct of_device_id hisilpc_of_match[] = {
 	{},
 };
 
+#ifdef CONFIG_ACPI
+#include "../acpi/arm64/acpi_indirectio.h"
+#include <linux/mfd/core.h>
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
+static struct mfd_cell_acpi_match hisi_lpc_ipmi_acpi_match = {
+	.pnpid = "IPI0001",
+};
+
+static const char *hisi_lpc_ipmi_name = "hisi_lpc_ipmi";
+
+static int lpc_host_io_setup(struct acpi_device *adev, void *pdata)
+{
+	int ret;
+	struct platform_device *pdev;
+	struct mfd_cell *ipmi_devs;
+	struct logic_pio_hwaddr *range;
+	struct lpc_private_data *lpc_private;
+	struct acpi_device *child;
+	int ipmi_dev_num = 0;
+
+	lpc_private = pdata;
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return -ENOMEM;
+	range->fwnode = &adev->fwnode;
+	range->flags = PIO_INDIRECT;
+	range->size = lpc_private->io_size;
+	range->hw_start = lpc_private->io_start;
+
+	ret = logic_pio_register_range(range);
+	if (ret)
+		goto free_range;
+
+	/* count the ipmi children first */
+	list_for_each_entry(child, &adev->children, node) {
+		if (!strcmp(hisi_lpc_ipmi_acpi_match.pnpid,
+			    acpi_device_hid(child)))
+			ipmi_dev_num++;
+	}
+
+	/* allocate the mfd cells */
+	ipmi_devs = kcalloc(ipmi_dev_num, sizeof(*ipmi_devs), GFP_KERNEL);
+	if (!ipmi_devs) {
+		dev_err(&adev->dev, "ipmi_devs kzalloc failed!\n");
+		ret = -ENOMEM;
+		goto free_range;
+	}
+
+	ipmi_dev_num = 0;
+	/* For hisilpc, only care about the sons of host. */
+	list_for_each_entry(child, &adev->children, node) {
+		if (!strcmp(hisi_lpc_ipmi_acpi_match.pnpid,
+			    acpi_device_hid(child))) {
+			ipmi_devs[ipmi_dev_num].name = hisi_lpc_ipmi_name;
+			ipmi_devs[ipmi_dev_num].acpi_match =
+					&hisi_lpc_ipmi_acpi_match;
+			ret = acpi_set_logicio_resource(&child->dev, &adev->dev,
+					&ipmi_devs[ipmi_dev_num].resources,
+					&ipmi_devs[ipmi_dev_num].num_resources);
+			if (ret) {
+				dev_err(&child->dev, "set resource failed..\n");
+				goto free_ipmi_devs;
+			}
+			ipmi_dev_num++;
+		}
+	}
+
+	pdev = acpi_create_platform_device(adev, NULL);
+	if (IS_ERR_OR_NULL(pdev)) {
+		dev_err(&adev->dev, "Create platform device for host FAIL!\n");
+		ret = -EFAULT;
+		goto free_ipmi_devs;
+	}
+	acpi_device_set_enumerated(adev);
+
+	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+			ipmi_devs, ipmi_dev_num, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add ipmi mfd cell\n");
+		goto free_ipmi_devs;
+	}
+
+	return ret;
+
+free_ipmi_devs:
+	while (ipmi_dev_num--)
+		kfree(ipmi_devs[ipmi_dev_num].resources);
+	kfree(ipmi_devs);
+free_range:
+	kfree(range);
+
+	return ret;
+}
+
+static const struct acpi_device_id hisilpc_acpi_match[] = {
+	{"HISI0191", },
+	{},
+};
+
+const struct indirectio_device_desc lpc_host_desc = {
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
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
