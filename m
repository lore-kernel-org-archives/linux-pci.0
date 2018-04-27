Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v8 3/9] PCI: endpoint: functions/pci-epf-test: Add second entry
Date: Fri, 27 Apr 2018 12:59:58 +0100
Message-Id: <c2b6cb8de2502e1b5352be3b6d687b1cb4b7033a.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a seconds entry on the pci_epf_test_ids structure that disables the
linkup_notifier parameter on driver for the DesignWare EP.

Allow DesignWare EPs that doesn't have linkup notification signal to work
with pcitest.

Update the binding documentation accordingly.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v2->v3:
 - Added second entry in pci_epf_test_ids structure.
 - Remove test_reg_bar field assignment on second entry.
Changes v3->v4:
 - Nothing changed, just to follow the patch set version.
Changes v4->v5:
 - Changed pci_epf_test_cfg2 to pci_epf_test_designware.
Changes v5->v6:
 - Changed name field from pci_epf_test_designware to pci_epf_test_dw.
Changes v6->v7:
 - Changed variable name from data_cfg2 to data_linkup_notifier_disabled.
Changes v7->v8:
 - Patch description rework for an imperative verbal mode.

 Documentation/PCI/endpoint/function/binding/pci-test.txt | 2 ++
 drivers/pci/endpoint/functions/pci-epf-test.c            | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
index 3b68b95..dc39f47 100644
--- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
+++ b/Documentation/PCI/endpoint/function/binding/pci-test.txt
@@ -1,6 +1,8 @@
 PCI TEST ENDPOINT FUNCTION
 
 name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
+name: Should be "pci_epf_test_dw" to bind to the pci_epf_test driver
+      with a custom configuration for the designware EP.
 
 Configurable Fields:
 vendorid	 : should be 0x104c
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7cef851..4ab463b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -459,10 +459,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	return 0;
 }
 
+static const struct pci_epf_test_data data_linkup_notifier_disabled = {
+	.linkup_notifier = false
+};
+
 static const struct pci_epf_device_id pci_epf_test_ids[] = {
 	{
 		.name = "pci_epf_test",
 	},
+	{
+		.name = "pci_epf_test_dw",
+		.driver_data = (kernel_ulong_t)&data_linkup_notifier_disabled,
+	},
 	{},
 };
 
-- 
2.7.4
