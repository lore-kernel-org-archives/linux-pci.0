Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64187 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3DVXMK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:12:10 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so16143iea.10
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:12:09 -0700 (PDT)
Subject: [PATCH v4 17/22] PCI: Remove "extern" from function declarations
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 17:12:08 -0600
Message-ID: <20130422231208.32621.16719.stgit@bhelgaas-glaptop>
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We had an inconsistent mix of using and omitting the "extern" keyword
on function declarations in header files.  This removes them all.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/msi.h |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index ce93a34..20c2d6d 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -13,14 +13,14 @@ struct msi_msg {
 /* Helper functions */
 struct irq_data;
 struct msi_desc;
-extern void mask_msi_irq(struct irq_data *data);
-extern void unmask_msi_irq(struct irq_data *data);
-extern void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-extern void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-extern void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-extern void read_msi_msg(unsigned int irq, struct msi_msg *msg);
-extern void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
-extern void write_msi_msg(unsigned int irq, struct msi_msg *msg);
+void mask_msi_irq(struct irq_data *data);
+void unmask_msi_irq(struct irq_data *data);
+void __read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+void read_msi_msg(unsigned int irq, struct msi_msg *msg);
+void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
+void write_msi_msg(unsigned int irq, struct msi_msg *msg);
 
 struct msi_desc {
 	struct {
@@ -54,9 +54,8 @@ struct msi_desc {
  */
 int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
-extern int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-extern void arch_teardown_msi_irqs(struct pci_dev *dev);
-extern int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
-
+int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void arch_teardown_msi_irqs(struct pci_dev *dev);
+int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
 
 #endif /* LINUX_MSI_H */

