Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:58784 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdFOUMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 16:12:34 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 15 Jun 2017 14:12:24 -0600
Message-Id: <20170615201224.5371-3-logang@deltatee.com>
In-Reply-To: <20170615201224.5371-1-logang@deltatee.com>
References: <20170615201224.5371-1-logang@deltatee.com>
Subject: [PATCH 2/2] switchtec: add device ids for additional switchtec products
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The switchtec driver also supports PAX, PFXL and PFXI products which
have the same management interface.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/pci/switch/switchtec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5cf59af989f4..af81b2dec42e 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1558,6 +1558,24 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x8544),  //PSX 64xG3
 	SWITCHTEC_PCI_DEVICE(0x8545),  //PSX 80xG3
 	SWITCHTEC_PCI_DEVICE(0x8546),  //PSX 96xG3
+	SWITCHTEC_PCI_DEVICE(0x8551),  //PAX 24XG3
+	SWITCHTEC_PCI_DEVICE(0x8552),  //PAX 32XG3
+	SWITCHTEC_PCI_DEVICE(0x8553),  //PAX 48XG3
+	SWITCHTEC_PCI_DEVICE(0x8554),  //PAX 64XG3
+	SWITCHTEC_PCI_DEVICE(0x8555),  //PAX 80XG3
+	SWITCHTEC_PCI_DEVICE(0x8556),  //PAX 96XG3
+	SWITCHTEC_PCI_DEVICE(0x8561),  //PFXL 24XG3
+	SWITCHTEC_PCI_DEVICE(0x8562),  //PFXL 32XG3
+	SWITCHTEC_PCI_DEVICE(0x8563),  //PFXL 48XG3
+	SWITCHTEC_PCI_DEVICE(0x8564),  //PFXL 64XG3
+	SWITCHTEC_PCI_DEVICE(0x8565),  //PFXL 80XG3
+	SWITCHTEC_PCI_DEVICE(0x8566),  //PFXL 96XG3
+	SWITCHTEC_PCI_DEVICE(0x8571),  //PFXI 24XG3
+	SWITCHTEC_PCI_DEVICE(0x8572),  //PFXI 32XG3
+	SWITCHTEC_PCI_DEVICE(0x8573),  //PFXI 48XG3
+	SWITCHTEC_PCI_DEVICE(0x8574),  //PFXI 64XG3
+	SWITCHTEC_PCI_DEVICE(0x8575),  //PFXI 80XG3
+	SWITCHTEC_PCI_DEVICE(0x8576),  //PFXI 96XG3
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
-- 
2.11.0
