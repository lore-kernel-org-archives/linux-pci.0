Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:5857
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754682AbeFYIbX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 04:31:23 -0400
From: Alan Douglas <adouglas@cadence.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH 5/5] PCI: cadence: Add shutdown callback to host driver
Date: Mon, 25 Jun 2018 09:30:53 +0100
Message-ID: <1529915453-4633-6-git-send-email-adouglas@cadence.com>
In-Reply-To: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
References: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add shutdown callback to host driver which will disable PHY and
PM runtime.

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-host.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index e3e9b7d..ec394f6 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -343,6 +343,20 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void cdns_pcie_shutdown(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_dbg(dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(pcie);
+}
+
 static struct platform_driver cdns_pcie_host_driver = {
 	.driver = {
 		.name = "cdns-pcie-host",
@@ -350,5 +364,6 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 		.pm	= &cdns_pcie_pm_ops,
 	},
 	.probe = cdns_pcie_host_probe,
+	.shutdown = cdns_pcie_shutdown,
 };
 builtin_platform_driver(cdns_pcie_host_driver);
-- 
1.7.1
