Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f74.google.com ([74.125.82.74]:50693 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab2LEU5h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 15:57:37 -0500
Received: by mail-wg0-f74.google.com with SMTP id dt14so395140wgb.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Dec 2012 12:57:36 -0800 (PST)
Subject: [PATCH 03/12] PCI/portdrv: Use PCI Express Capability accessors
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>
Date: Wed, 05 Dec 2012 13:57:35 -0700
Message-ID: <20121205205735.13851.23975.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use PCI Express Capability access functions to simplify portdrv.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@huawei.com>
---
 drivers/pci/pcie/portdrv_core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index d03a7a3..70d3555 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -120,8 +120,7 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *vectors, int mask)
 		 * the value in this field indicates which MSI-X Table entry is
 		 * used to generate the interrupt message."
 		 */
-		pos = pci_pcie_cap(dev);
-		pci_read_config_word(dev, pos + PCI_EXP_FLAGS, &reg16);
+		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
 		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
 		if (entry >= nr_entries)
 			goto Error;

