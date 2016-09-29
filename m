Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35537 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934896AbcI2Xxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2016 19:53:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8TNqoIx125271
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2016 19:53:50 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 25s8suh4us-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 29 Sep 2016 19:53:50 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Fri, 30 Sep 2016 09:53:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
        by d23dlp03.au.ibm.com (Postfix) with ESMTP id E960D357805A
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2016 09:53:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u8TNriN44915678
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2016 09:53:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u8TNrhbR026932
        for <linux-pci@vger.kernel.org>; Fri, 30 Sep 2016 09:53:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        benh@au1.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        clsoto@us.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] pci: Call pcibios_sriov_enable() before IOV BARs are enabled
Date: Fri, 30 Sep 2016 09:47:49 +1000
Message-Id: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In current implementation, pcibios_sriov_enable() is used by PPC
PowerNV platform only. In PowerNV specific pcibios_sriov_enable(),
PF's IOV BARs might be updated (shifted) by pci_update_resource().
It means the IOV BARs aren't ready for decoding incoming memory
address until pcibios_sriov_enable() returns.

This calls pcibios_sriov_enable() earlier before the IOV BARs are
enabled. As the result, the IOV BARs have been configured correctly
when they are enabled.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Carol Soto <clsoto@us.ibm.com>
---
 drivers/pci/iov.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2194b44..f1343f0 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -303,13 +303,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			return rc;
 	}
 
-	pci_iov_set_numvfs(dev, nr_virtfn);
-	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
-	pci_cfg_access_lock(dev);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	msleep(100);
-	pci_cfg_access_unlock(dev);
-
 	iov->initial_VFs = initial;
 	if (nr_virtfn < initial)
 		initial = nr_virtfn;
@@ -320,6 +313,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		goto err_pcibios;
 	}
 
+	pci_iov_set_numvfs(dev, nr_virtfn);
+	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
+	pci_cfg_access_lock(dev);
+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
+	msleep(100);
+	pci_cfg_access_unlock(dev);
+
 	for (i = 0; i < initial; i++) {
 		rc = pci_iov_add_virtfn(dev, i, 0);
 		if (rc)
-- 
2.1.0

