Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52901 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754950AbcI2Gqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 02:46:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8T6h0HT090675
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2016 02:46:29 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25rv9au6su-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2016 02:46:29 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Thu, 29 Sep 2016 02:46:28 -0400
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
        gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v6 1/4] PCI: Ignore enforced alignment when kernel uses existing firmware setup
Date: Thu, 29 Sep 2016 14:46:18 +0800
In-Reply-To: <1475131581-4373-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1475131581-4373-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1475131581-4373-2-git-send-email-xyjxie@linux.vnet.ibm.com>
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
 drivers/pci/pci.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..2d85a96 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4959,6 +4959,13 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
+	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		if (*p)
+			pr_info_once("PCI: resource_alignment ignored with PCI_PROBE_ONLY\n");
+		spin_unlock(&resource_alignment_lock);
+		return 0;
+	}
+
 	while (*p) {
 		count = 0;
 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
@@ -5063,6 +5070,12 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
+		if (r->flags & IORESOURCE_PCI_FIXED) {
+			dev_info(&dev->dev, "No alignment for fixed BAR%d: %pR\n",
+				i, r);
+			continue;
+		}
+
 		size = resource_size(r);
 		if (size < align) {
 			size = align;
-- 
1.7.9.5

