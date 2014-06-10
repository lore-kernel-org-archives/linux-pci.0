Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:52686 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933775AbaFJB5N (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jun 2014 21:57:13 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Jun 2014 07:27:11 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9E8D4E0044
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:28:06 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5A1vLYB2359784
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:21 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5A1v7KU030277
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:07 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [RFC PATCH V3 09/17] PCI: Add weak pcibios_sriov_resource_alignment() interface
Date: Tue, 10 Jun 2014 09:56:31 +0800
Message-Id: <1402365399-5121-10-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
 drivers/pci/iov.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9fd4648..dd7fc42 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -628,6 +628,12 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno,
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
@@ -642,13 +648,16 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
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
-- 
1.7.9.5

