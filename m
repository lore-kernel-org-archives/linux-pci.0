Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751110AbdB0ATp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Feb 2017 19:19:45 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v1R0HEgd128368
        for <linux-pci@vger.kernel.org>; Sun, 26 Feb 2017 19:19:44 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0a-001b2d01.pphosted.com with ESMTP id 28u6wa67yg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Sun, 26 Feb 2017 19:19:44 -0500
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Mon, 27 Feb 2017 10:19:42 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
        by d23dlp01.au.ibm.com (Postfix) with ESMTP id 26C502CE8054
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2017 11:19:39 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v1R0JV2l35782824
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2017 11:19:39 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v1R0Iw6R022434
        for <linux-pci@vger.kernel.org>; Mon, 27 Feb 2017 11:18:58 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, clsoto@us.ibm.com,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Disable IOV before pcibios_sriov_disable()
Date: Mon, 27 Feb 2017 11:18:32 +1100
Message-Id: <1488154712-8354-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PowerNV platform is the only user of pcibios_sriov_disable().
The IOV BAR could be shifted by pci_iov_update_resource(). The
warning message in the function is printed if the IOV capability
is in enabled (PCI_SRIOV_CTRL_VFE && PCI_SRIOV_CTRL_MSE) state.

   pci_disable_sriov
   sriov_disable
   pnv_pci_sriov_disable
   pnv_pci_vf_resource_shift
   pci_update_resource
   pci_iov_update_resource

This fixes the issue by disabling IOV capability before calling
pcibios_sriov_disable(). With it, the disabling path matches with
the enabling path: pcibios_sriov_enable() is called before the
IOV capability is enabled.

Reported-by: Carol L Soto <clsoto@us.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Carol L Soto <clsoto@us.ibm.com>
---
 drivers/pci/iov.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 2479ae8..138830f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -331,7 +331,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	while (i--)
 		pci_iov_remove_virtfn(dev, i, 0);
 
-	pcibios_sriov_disable(dev);
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
@@ -339,6 +338,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
 
+	pcibios_sriov_disable(dev);
+
 	if (iov->link != dev->devfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
@@ -357,14 +358,14 @@ static void sriov_disable(struct pci_dev *dev)
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i, 0);
 
-	pcibios_sriov_disable(dev);
-
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
 
+	pcibios_sriov_disable(dev);
+
 	if (iov->link != dev->devfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
-- 
2.7.4
