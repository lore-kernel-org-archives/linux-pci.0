Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:53639 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753625AbeDQOeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Apr 2018 10:34:37 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH v5 06/10] misc: pci_endpoint_test: Add designware EP entry
Date: Tue, 17 Apr 2018 15:34:24 +0100
Message-Id: <37e68003e28d2056429276985aae631ed131de5e.1523973931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
References: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
References: <cover.1523973931.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the designware EP device ID entry to pci_endpoint_test driver table
to allow this device to be recognize and handle by the pci_endpoint_test
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

 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index fe8897e..37db0fc 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -634,6 +634,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_SMPL_EP) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.7.4
