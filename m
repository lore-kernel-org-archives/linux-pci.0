Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:36057 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757565AbeD0MAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2018 08:00:14 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v8 5/9] misc: pci_endpoint_test: Add DesignWare EP entry
Date: Fri, 27 Apr 2018 13:00:00 +0100
Message-Id: <152476fafc95478727904486aac6d5b50b13fb9d.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
References: <cover.1524829928.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the DesignWare EP device ID entry to pci_endpoint_test driver table.

Allow the device to be recognize and handle by the pci_endpoint_test
driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Change v1->v2:
 - Changed device id following Kishon's suggestion.
Change v2->v3:
 - Nothing changed, just to follow the patch set version.
Changes v3->v4:
 - Nothing changed, just to follow the patch set version.
Changes v4->v5:
 - Nothing changed, just to follow the patch set version.
Changes v5->v6:
 - Reverted Kishon's suggestion by Bjorn request.
Changes v6->v7:
 - Nothing changed, just to follow the patch set version.
Changes v7->v8:
 - Patch description rework for an imperative verbal mode.

 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index fe8897e..58a88ba 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -634,6 +634,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.7.4
