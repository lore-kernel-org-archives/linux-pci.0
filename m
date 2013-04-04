Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:41043 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759352Ab3DDLjo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Apr 2013 07:39:44 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 07:39:43 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 672686E8040
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 07:39:38 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34BdeKe293578
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 07:39:40 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34Bdex7023814
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 08:39:40 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 4/5] PCI: Use cached MSI cap in pci_enable_msi_block_auto()
Date: Thu,  4 Apr 2013 19:39:31 +0800
Message-Id: <1365075572-20763-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch intends to use cached MSI capability offset instead of
polling that from config space in pci_enable_msi_block_auto().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/msi.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 182474d..0b6b254 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -848,14 +848,13 @@ EXPORT_SYMBOL(pci_enable_msi_block);
 
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec)
 {
-	int ret, pos, nvec;
+	int ret, nvec;
 	u16 msgctl;
 
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!pos)
+	if (!dev->msi_cap)
 		return -EINVAL;
 
-	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &msgctl);
 	ret = 1 << ((msgctl & PCI_MSI_FLAGS_QMASK) >> 1);
 
 	if (maxvec)
-- 
1.7.5.4

