Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59908 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab3K1DML (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 22:12:11 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00FCEE8A1J40@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 28 Nov 2013 12:12:10 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH] PCI: PCIe portdrv: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 12:12:09 +0900
Message-id: <002801ceebe7$a0293170$e07b9450$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/pcie/portdrv_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0d8fdc4..5356902 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -368,7 +368,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
 /*
  * LINUX Device Driver Model
  */
-static const struct pci_device_id port_pci_ids[] = { {
+static DEFINE_PCI_DEVICE_TABLE(port_pci_ids) = { {
 	/* handle any PCI-Express port */
 	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
 	}, { /* end: all zeroes */ }
-- 
1.7.10.4


