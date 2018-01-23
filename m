Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751615AbeAWPpf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jan 2018 10:45:35 -0500
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
        <mark.rutland@arm.com>, <olof@lixom.net>, <hanjun.guo@linaro.org>,
        <dann.frazier@canonical.com>
CC: <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <rdunlap@infradead.org>, John Garry <john.garry@huawei.com>,
        Zhichang Yuan <yuanzhichang@hisilicon.com>,
        "Gabriele Paoloni" <gabriele.paoloni@huawei.com>
Subject: [PATCH v12 8/9] LPC, ACPI: Add the HISI LPC ACPI support
Date: Wed, 24 Jan 2018 00:36:24 +0800
Message-ID: <1516725385-24535-9-git-send-email-john.garry@huawei.com>
In-Reply-To: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Based on the previous patches, this patch supports the LPC host on
Hip06/Hip07 for ACPI FW.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Tested-by: Dann Frazier <dann.frazier@canonical.com>
---
 drivers/acpi/arm64/acpi_indirectio.c | 11 ++++++++++-
 drivers/bus/hisi_lpc.c               | 17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/acpi_indirectio.c b/drivers/acpi/arm64/acpi_indirectio.c
index 2649f57..6403f84 100644
--- a/drivers/acpi/arm64/acpi_indirectio.c
+++ b/drivers/acpi/arm64/acpi_indirectio.c
@@ -142,7 +142,7 @@ int acpi_indirectio_set_logicio_res(struct device *child,
 	return ret;
 }
 
-int
+static int
 acpi_indirectio_pre_setup(struct acpi_device *adev,
 			  struct acpi_indirectio_host_data *pdata)
 {
@@ -239,8 +239,17 @@ int acpi_indirectio_set_logicio_res(struct device *child,
 	return ret;
 }
 
+const struct acpi_indirectio_device_desc hisi_lpc_host_desc = {
+	.pdata = {
+		.io_size = PIO_INDIRECT_SIZE,
+		.io_start = 0,
+	},
+	.pre_setup = acpi_indirectio_pre_setup,
+};
+
 /* All the host devices which apply indirect-IO can be listed here. */
 static const struct acpi_device_id acpi_indirect_host_id[] = {
+	{"HISI0191", INDIRECT_IO_INFO(hisi_lpc_host_desc)},
 	{""},
 };
 
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 4ce089a..9cabb84 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -457,7 +457,13 @@ static int hisilpc_probe(struct platform_device *pdev)
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
@@ -515,10 +521,19 @@ static int hisilpc_probe(struct platform_device *pdev)
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
