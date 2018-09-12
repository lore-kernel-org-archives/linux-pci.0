Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726758AbeILRij (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2018 13:38:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CCUJGM016718
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2018 08:34:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf1n0uhp2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2018 08:34:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sebott@linux.ibm.com>;
        Wed, 12 Sep 2018 13:34:17 +0100
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 1/2] pci: provide pcibios_sriov_add_vfs
Date: Wed, 12 Sep 2018 14:34:10 +0200
In-Reply-To: <20180912123411.23229-1-sebott@linux.ibm.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com>
Message-Id: <20180912123411.23229-2-sebott@linux.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Move vf detection and device creation code to weak functions
such that architectures can provide a different implementation.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 drivers/pci/iov.c   | 43 +++++++++++++++++++++++++++++++------------
 include/linux/pci.h |  2 ++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c5f3cd4ed766..6452cb8f397f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -251,6 +251,33 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 	return 0;
 }
 
+int __weak pcibios_sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
+{
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < num_vfs; i++) {
+		rc = pci_iov_add_virtfn(dev, i);
+		if (rc)
+			goto failed;
+	}
+	return 0;
+failed:
+	while (i--)
+		pci_iov_remove_virtfn(dev, i);
+
+	return rc;
+}
+
+void __weak pcibios_sriov_del_vfs(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+	int i;
+
+	for (i = 0; i < iov->num_VFs; i++)
+		pci_iov_remove_virtfn(dev, i);
+}
+
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -336,21 +363,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	msleep(100);
 	pci_cfg_access_unlock(dev);
 
-	for (i = 0; i < initial; i++) {
-		rc = pci_iov_add_virtfn(dev, i);
-		if (rc)
-			goto failed;
-	}
+	rc = pcibios_sriov_add_vfs(dev, initial);
+	if (rc)
+		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
 	iov->num_VFs = nr_virtfn;
 
 	return 0;
 
-failed:
-	while (i--)
-		pci_iov_remove_virtfn(dev, i);
-
 err_pcibios:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
@@ -369,14 +390,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 
 static void sriov_disable(struct pci_dev *dev)
 {
-	int i;
 	struct pci_sriov *iov = dev->sriov;
 
 	if (!iov->num_VFs)
 		return;
 
-	for (i = 0; i < iov->num_VFs; i++)
-		pci_iov_remove_virtfn(dev, i);
+	pcibios_sriov_del_vfs(dev);
 
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e72ca8dd6241..76ff5b70f9a7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1989,6 +1989,8 @@ void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
 /* Arch may override these (weak) */
 int pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs);
 int pcibios_sriov_disable(struct pci_dev *pdev);
+int pcibios_sriov_add_vfs(struct pci_dev *dev, u16 num_vfs);
+void pcibios_sriov_del_vfs(struct pci_dev *dev);
 resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
-- 
2.13.4
