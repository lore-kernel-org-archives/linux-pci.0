Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50992 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeC1Lio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Mar 2018 07:38:44 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 4/8] misc: pci_endpoint_test: Add designware EP entry
Date: Wed, 28 Mar 2018 12:38:34 +0100
Message-Id: <1bc09dfd205d0721366267e023550c4a5a4a84db.1522235224.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the designware EP device ID entry to pci_endpoint_test driver table
to allow this device to be recognize and handle by the pci_endpoint_test
driver.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 320276f..e80c533 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -632,6 +632,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.7.4
