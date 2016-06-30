Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18054 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752151AbcF3Kxl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 06:53:41 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5UArWTV068717
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 06:53:36 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt8pfrs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 06:53:36 -0400
Received: from localhost
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Thu, 30 Jun 2016 16:23:27 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
Subject: [PATCH v3 2/7] PCI: Ignore enforced alignment to VF BARs
Date: Thu, 30 Jun 2016 18:53:08 +0800
In-Reply-To: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <1467283993-3185-3-git-send-email-xyjxie@linux.vnet.ibm.com>
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
 drivers/pci/pci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index be8f72c..6ae02de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4822,6 +4822,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	resource_size_t align, size;
 	u16 command;
 
+	/* We should never try to reassign VF's alignment */
+	if (dev->is_virtfn)
+		return;
+
 	/* check if specified PCI is target device to reassign */
 	align = pci_specified_resource_alignment(dev);
 	if (!align)
-- 
1.7.9.5

