Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42693 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750810AbdBOGua (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2017 01:50:30 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1F6mX2t102119
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 01:50:29 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28mcwhsa6p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 15 Feb 2017 01:50:29 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
        Tue, 14 Feb 2017 23:50:28 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com
Subject: [PATCH] PCI: Ignore requested alignment for IOV BARs
Date: Wed, 15 Feb 2017 14:50:22 +0800
Message-Id: <1487141422-2744-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We would call pci_reassigndev_resource_alignment() before
pci_init_capabilities(). So the requested alignment would
never work for IOV BARs.

Furthermore, it's meaningless to request additional alignment
for IOV BARs, the IOV BAR alignment is only determined by the
VF BAR size.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a881c0d..220c31e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5084,7 +5084,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
 
-	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
 		r = &dev->resource[i];
 		if (!(r->flags & IORESOURCE_MEM))
 			continue;
-- 
1.7.9.5
