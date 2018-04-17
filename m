Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:35801 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbeDQOeg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Apr 2018 10:34:36 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v5 03/10] PCI: endpoint: functions/pci-epf-test: Add second entry
Date: Tue, 17 Apr 2018 15:34:21 +0100
Message-Id: <2f0c370d4308380672bd4a5afcad58a385dcf21f.1523973931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
References: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
References: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds a seconds entry on the pci_epf_test_ids structure that disables the
linkup_notifier parameter on driver for the designware EP.

This allows designware EPs that doesn't have linkup notification signal
to work with pcitest.

Updates the binding documentation accordingly.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v2->v3:
 - Added second entry in pci_epf_test_ids structure.
 - Remove test_reg_bar field assignment on second entry.
Changes v3->v4:
 - Nothing changed, just to follow the patch set version.
Changes v4->v5:
 - Changed pci_epf_test_cfg2 to pci_epf_test_designware.

 Documentation/PCI/endpoint/function/binding/pci-test.txt | 2 ++
 drivers/pci/endpoint/functions/pci-epf-test.c            | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
index 3b68b95..b321f9d 100644
--- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
+++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
@@ -1,6 +1,8 @@
 PCI TEST ENDPOINT FUNCTION
 
 name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
+name: Should be "pci_epf_designware" to bind to the pci_epf_test driver
+      with a custom configuration for the designware EP.
 
 Configurable Fields:
 vendorid	 : should be 0x104c
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7cef851..3f613d2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -459,10 +459,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	return 0;
 }
 
+static const struct pci_epf_test_data data_cfg2 = {
+	.linkup_notifier = false
+};
+
 static const struct pci_epf_device_id pci_epf_test_ids[] = {
 	{
 		.name = "pci_epf_test",
 	},
+	{
+		.name = "pci_epf_test_designware",
+		.driver_data = (kernel_ulong_t)&data_cfg2,
+	},
 	{},
 };
 
-- 
2.7.4
