Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:42843 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbbCYFy4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 01:54:56 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 25 Mar 2015 15:54:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 722FE3578057
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2015 16:54:52 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2P5sij217891578
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2015 16:54:52 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2P5sI5E026720
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2015 16:54:19 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V15 11/21] PCI: Add pcibios_iov_resource_alignment() interface
Date: Wed, 25 Mar 2015 13:44:47 +0800
Message-Id: <1427262297-5694-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1427262297-5694-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per the SR-IOV spec r1.1, sec 3.3.14, the required alignment of a PF's IOV
BAR is the size of an individual VF BAR, and the size consumed is the
individual VF BAR size times NumVFs.

The PowerNV platform has additional alignment requirements to help support
its Partitionable Endpoint device isolation feature (see
Documentation/powerpc/pci_iov_resource_on_powernv.txt).

Add a pcibios_iov_resource_alignment() interface to allow platforms to
request additional alignment.

[bhelgaas: changelog, adapt to reworked pci_sriov_resource_alignment(),
drop "align" parameter]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c   |    8 +++++++-
 include/linux/pci.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 64c4692..ee0ebff 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -569,6 +569,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
+						      int resno)
+{
+	return pci_iov_resource_size(dev, resno);
+}
+
 /**
  * pci_sriov_resource_alignment - get resource alignment for VF BAR
  * @dev: the PCI device
@@ -581,7 +587,7 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
  */
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
-	return pci_iov_resource_size(dev, resno);
+	return pcibios_iov_resource_alignment(dev, resno);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 99ea948..4e1f17d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1174,6 +1174,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.9.5

