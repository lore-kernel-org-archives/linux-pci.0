Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22135 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752208AbcF3KyX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 06:54:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5UAsG8q065033
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 06:54:17 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23utca7nnw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 06:54:17 -0400
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Thu, 30 Jun 2016 16:23:24 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
Subject: [PATCH v3 1/7] PCI: Ignore enforced alignment when kernel uses existing firmware setup
Date: Thu, 30 Jun 2016 18:53:07 +0800
In-Reply-To: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1467283993-3185-2-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI resources allocator will use firmware setup and not try to
reassign resource when PCI_PROBE_ONLY or IORESOURCE_PCI_FIXED
is set.

The enforced alignment in pci_reassigndev_resource_alignment()
should be ignored in this case. Otherwise, some PCI devices'
resources would be released here and not re-allocated.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c8b4dbd..be8f72c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4760,6 +4760,13 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		if (*p)
+			printk_once(KERN_INFO "PCI: Ignore resource_alignment parameter: %s with PCI_PROBE_ONLY set\n",
+						p);
+		spin_unlock(&resource_alignment_lock);
+		return 0;
+	}
 	while (*p) {
 		count = 0;
 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
@@ -4837,6 +4844,11 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
+		if (r->flags & IORESOURCE_PCI_FIXED) {
+			dev_info(&dev->dev, "No alignment for fixed BAR%d: %pR\n",
+				i, r);
+			continue;
+		}
 		size = resource_size(r);
 		if (size < align) {
 			size = align;
-- 
1.7.9.5

