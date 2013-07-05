Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:39439 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab3GEC66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jul 2013 22:58:58 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Jul 2013 22:58:57 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CE848C90046
	for <linux-pci@vger.kernel.org>; Thu,  4 Jul 2013 22:58:53 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r652vc5j271490
	for <linux-pci@vger.kernel.org>; Thu, 4 Jul 2013 22:57:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r652vcFa027788
	for <linux-pci@vger.kernel.org>; Thu, 4 Jul 2013 23:57:38 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, Gavin Shan <shangw@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/8] PCI: Add pcibios_stop_dev()
Date: Fri,  5 Jul 2013 10:57:27 +0800
Message-Id: <1372993054-25730-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When stopping and removing one specific PCI device, the platform
might need take some actions. One example is that EEH already had
eeh cache and eeh device attached to the PCI device, and we need
release eeh cache and device during the time. The patch introduces
hook pcibios_stop_dev() for the purpose.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/probe.c  |    4 ++++
 drivers/pci/remove.c |    2 ++
 include/linux/pci.h  |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 70f10fa..7167dc4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1669,6 +1669,10 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
+void __weak pcibios_stop_dev(struct pci_dev *dev)
+{
+}
+
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 8fc54b7..e329efc 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -21,6 +21,8 @@ static void pci_stop_dev(struct pci_dev *dev)
 {
 	pci_pme_active(dev, false);
 
+	pcibios_stop_dev(dev);
+
 	if (dev->is_added) {
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3a24e4f..40df783 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -696,6 +696,7 @@ int no_pci_devices(void);
 void pcibios_resource_survey_bus(struct pci_bus *bus);
 void pcibios_add_bus(struct pci_bus *bus);
 void pcibios_remove_bus(struct pci_bus *bus);
+void pcibios_stop_dev(struct pci_dev *dev);
 void pcibios_fixup_bus(struct pci_bus *);
 int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 /* Architecture specific versions may override this (weak) */
-- 
1.7.5.4

