Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48739 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757262AbcIMJAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 05:00:42 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8D8wcwt123268
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2016 05:00:42 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25e0b1qerr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2016 05:00:41 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Tue, 13 Sep 2016 05:00:40 -0400
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        alex.williamson@redhat.com, paulus@samba.org, aik@ozlabs.ru,
        gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, zhong@linux.vnet.ibm.com
Subject: [PATCH v5 2/4] PCI: Ignore enforced alignment to VF BARs
Date: Tue, 13 Sep 2016 17:00:32 +0800
In-Reply-To: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1473757234-5284-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1473757234-5284-3-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VF BARs are read-only zeroes according to SRIOV spec,
the normal way(writing BARs) of allocating resources wouldn't
be applied to VFs. The VFs' resources would be allocated
when we enable SR-IOV capability. So we should not try to
reassign alignment after we enable VFs. It's meaningless
and will release the allocated resources which leads to a bug.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2d85a96..b8357d7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5048,6 +5048,15 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	resource_size_t align, size;
 	u16 command;
 
+	/*
+	 * VF BARs are RO zero according to SR-IOV spec 3.4.1.11. Their
+	 * resources would be allocated when we enable them and not be
+	 * re-allocated any more. So we should never try to reassign
+	 * VF's alignment here.
+	 */
+	if (dev->is_virtfn)
+		return;
+
 	/* check if specified PCI is target device to reassign */
 	align = pci_specified_resource_alignment(dev);
 	if (!align)
-- 
1.7.9.5

