Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:56868 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbaGXGWo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 02:22:44 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 24 Jul 2014 16:22:34 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8703F2BB0040
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6O6MMFN10355148
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6O6MblV030100
	for <linux-pci@vger.kernel.org>; Thu, 24 Jul 2014 16:22:38 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V7 03/17] PCI: Add weak pcibios_sriov_resource_alignment() interface
Date: Thu, 24 Jul 2014 14:22:13 +0800
Message-Id: <1406182947-11302-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The sriov resource alignment is designed to be the individual size of a sriov
resource. This works fine for many platforms, but on powernv platform it needs
some change.

The original alignment works, since at sizing and assigning stage the
requirement is from an individual VF's resource size instead of the big IOV
BAR. This is the reason for the original code to just retrieve the individual
sriov size as the alignment.

On powernv platform, it is required to align the whole IOV BAR to a hardware
aperture. Based on this fact, the alignment of sriov resource should be the
total size of the IOV BAR.

This patch introduces a weak pcibios_sriov_resource_alignment() interface, which
gives platform a chance to implement specific method to calculate the sriov
resource alignment.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   11 ++++++++++-
 include/linux/pci.h |    3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ef1c546..d395769 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -505,6 +505,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno,
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+resource_size_t __weak pcibios_sriov_resource_alignment(struct pci_dev *dev,
+		int resno, resource_size_t align)
+{
+	return align;
+}
+
 /**
  * pci_sriov_resource_alignment - get resource alignment for VF BAR
  * @dev: the PCI device
@@ -519,13 +525,16 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
 	struct resource tmp;
 	enum pci_bar_type type;
+	resource_size_t align;
 	int reg = pci_iov_resource_bar(dev, resno, &type);
 
 	if (!reg)
 		return 0;
 
 	__pci_read_base(dev, type, &tmp, reg);
-	return resource_alignment(&tmp);
+	align = resource_alignment(&tmp);
+
+	return pcibios_sriov_resource_alignment(dev, resno, align);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 194db52..541ef4eb43 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1166,6 +1166,9 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+resource_size_t pcibios_sriov_resource_alignment(struct pci_dev *dev,
+						 int resno,
+						 resource_size_t align);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.9.5

