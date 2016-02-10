Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:59325 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbcBJGEG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 01:04:06 -0500
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 10 Feb 2016 16:04:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 697BD2CE8054
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:56 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1A63iUr43581482
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1A63N6n011789
	for <linux-pci@vger.kernel.org>; Wed, 10 Feb 2016 17:03:24 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru, ruscur@russell.cc,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v14 2/9] PCI: Add pcibios_bus_add_device() weak function
Date: Wed, 10 Feb 2016 17:02:50 +1100
Message-Id: <1455084177-15525-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

This adds weak function pcibios_bus_add_device() for arch dependent
code could do proper setup. For example, powerpc could setup EEH
related resources for SRIOV VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c   | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 89b3bef..6469ff6 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -271,6 +271,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
+void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
+
 /**
  * pci_bus_add_device - start driver for a single device
  * @dev: device to add
@@ -285,6 +287,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
 	 */
+	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3db5e30..bc435d62 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -770,6 +770,7 @@ extern struct list_head pci_root_buses;	/* list of all known PCI buses */
 int no_pci_devices(void);
 
 void pcibios_resource_survey_bus(struct pci_bus *bus);
+void pcibios_bus_add_device(struct pci_dev *pdev);
 void pcibios_add_bus(struct pci_bus *bus);
 void pcibios_remove_bus(struct pci_bus *bus);
 void pcibios_fixup_bus(struct pci_bus *);
-- 
2.1.0

