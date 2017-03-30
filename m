Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:4853 "EHLO
        dggrg02-dlp.huawei.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S933746AbdC3Ozs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2017 10:55:48 -0400
From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>
CC: <mark.rutland@arm.com>, <brian.starkey@arm.com>, <olof@lixom.net>,
        <lorenzo.pieralisi@arm.com>, <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <zourongrong@gmail.com>, <john.garry@huawei.com>,
        <gabriele.paoloni@huawei.com>, <zhichang.yuan02@gmail.com>,
        <kantyzc@163.com>, <xuwei5@hisilicon.com>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH V8 6/6] LPC: Add the ACPI LPC support
Date: Thu, 30 Mar 2017 23:26:59 +0800
Message-ID: <1490887619-61732-7-git-send-email-yuanzhichang@hisilicon.com>
In-Reply-To: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Based on the provious patches, this patch supports the ACPI LPC host on
Hip06/Hip07.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 018ea37..ef62045 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -458,7 +458,9 @@ static int hisilpc_probe(struct platform_device *pdev)
 	}
 
 	/* register the LPC host PIO resources */
-	if (!has_acpi_companion(dev)) {
+	if (has_acpi_companion(dev)) {
+		lpcdev->io_host = find_io_range_by_fwnode(dev->fwnode);
+	} else {
 		struct logic_pio_hwaddr *range, *tmprange;
 
 		range = kzalloc(sizeof(*range), GFP_KERNEL);
@@ -526,10 +528,18 @@ static int hisilpc_probe(struct platform_device *pdev)
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
