Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:42209 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbAOC2U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jan 2015 21:28:20 -0500
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 15 Jan 2015 12:28:18 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 35E3F2CE8040
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 13:28:17 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0F2SG5U35651612
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 13:28:17 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0F2SFML019660
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 13:28:16 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V11 03/17] PCI: Add weak pcibios_iov_resource_alignment() interface
Date: Thu, 15 Jan 2015 10:27:53 +0800
Message-Id: <1421288887-7765-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The alignment of PF's IOV BAR is designed to be the individual size of a
VF's BAR size. This works fine for many platforms, but on PowerNV platform
it needs some change.

The original alignment works, since at sizing and assigning stage the
requirement is from an individual VF's BAR size instead of the PF's IOV
BAR.  This is the reason for the original code to just retrieve the
individual VF BAR size as the alignment.

On PowerNV platform, it is required to align the whole PF IOV BAR to a
hardware segment. Based on this fact, the alignment of PF's IOV BAR should
be calculated seperately.

This patch introduces a weak pcibios_iov_resource_alignment() interface,
which gives platform a chance to implement specific method to calculate
the PF's IOV BAR alignment.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c   |   11 ++++++++++-
 include/linux/pci.h |    3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 933d8cc..5f48201 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -556,6 +556,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
 		4 * (resno - PCI_IOV_RESOURCES);
 }
 
+resource_size_t __weak pcibios_iov_resource_alignment(struct pci_dev *dev,
+		int resno, resource_size_t align)
+{
+	return align;
+}
+
 /**
  * pci_sriov_resource_alignment - get resource alignment for VF BAR
  * @dev: the PCI device
@@ -570,12 +576,15 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
 {
 	struct resource tmp;
 	int reg = pci_iov_resource_bar(dev, resno);
+	resource_size_t align;
 
 	if (!reg)
 		return 0;
 
 	__pci_read_base(dev, pci_bar_unknown, &tmp, reg);
-	return resource_alignment(&tmp);
+	align = resource_alignment(&tmp);
+
+	return pcibios_iov_resource_alignment(dev, resno, align);
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 74ef944..ae7a7ea 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1163,6 +1163,9 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev,
+						 int resno,
+						 resource_size_t align);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
-- 
1.7.9.5

