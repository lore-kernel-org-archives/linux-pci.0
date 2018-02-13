Return-Path: <linux-arch-owner@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>
Subject: [PATCH v13 8/9] LPC, ACPI: Add the HISI LPC ACPI support
Date: Wed, 14 Feb 2018 01:45:32 +0800
Message-ID: <1518543933-22456-9-git-send-email-john.garry@huawei.com>
In-Reply-To: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Based on the previous patches, this patch supports the LPC host on
Hip06/Hip07 for ACPI FW.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Tested-by: Dann Frazier <dann.frazier@canonical.com>
---
 drivers/acpi/arm64/acpi_indirectio.c |  1 +
 drivers/bus/hisi_lpc.c               | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/acpi_indirectio.c b/drivers/acpi/arm64/acpi_indirectio.c
index 51a1b92..52519a21 100644
--- a/drivers/acpi/arm64/acpi_indirectio.c
+++ b/drivers/acpi/arm64/acpi_indirectio.c
@@ -225,6 +225,7 @@ static int acpi_indirect_io_setup(struct acpi_device *adev)
 
 /* All the host devices which apply indirect-IO can be listed here. */
 static const struct acpi_device_id acpi_indirect_io_host_id[] = {
+	{"HISI0191"},
 	{}
 };
 
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 2290cf2..6211c95 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -439,7 +439,13 @@ static int hisilpc_probe(struct platform_device *pdev)
 	}
 
 	/* register the LPC host PIO resources */
-	{
+	if (has_acpi_companion(dev)) {
+		lpcdev->io_host = find_io_range_by_fwnode(dev->fwnode);
+		if (!lpcdev->io_host) {
+			dev_err(dev, "range not registered!\n");
+			return -EFAULT;
+		}
+	} else {
 		struct logic_pio_hwaddr *range;
 
 		range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
@@ -496,10 +502,19 @@ static int hisilpc_probe(struct platform_device *pdev)
 	{},
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hisilpc_acpi_match[] = {
+	{"HISI0191", },
+	{},
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
1.9.1
