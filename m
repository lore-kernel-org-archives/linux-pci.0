Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:44423 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbaESDBT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 May 2014 23:01:19 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 19 May 2014 13:01:17 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 1/4] PCI: Export MSI message relevant functions
Date: Mon, 19 May 2014 13:01:07 +1000
Message-Id: <1400468470-11262-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch exports 2 MSI message relevant functions, which will be
used by VFIO PCI driver. The VFIO PCI driver would be built as
a module.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 955ab79..2350271 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -324,6 +324,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 
 	__get_cached_msi_msg(entry, msg);
 }
+EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
 void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
@@ -368,6 +369,7 @@ void write_msi_msg(unsigned int irq, struct msi_msg *msg)
 
 	__write_msi_msg(entry, msg);
 }
+EXPORT_SYMBOL_GPL(write_msi_msg);
 
 static void free_msi_irqs(struct pci_dev *dev)
 {
-- 
1.8.3.2

