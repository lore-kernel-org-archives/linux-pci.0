Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:50044 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbaFJB5B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jun 2014 21:57:01 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 10 Jun 2014 07:26:59 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 434CEE0045
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:56 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5A1vnOe56295484
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:27:49 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5A1uu6p021033
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2014 07:26:57 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [RFC PATCH V3 04/17] PCI: SRIOV: add VF enable/disable hook
Date: Tue, 10 Jun 2014 09:56:26 +0800
Message-Id: <1402365399-5121-5-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VFs are dynamically created/released when driver enable them. On some
platforms, like PowerNV, special resources are necessary to enable VFs.

This patch adds two hooks for platform initialization before creating the VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 1d21f43..cc87773 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -250,6 +250,11 @@ static void sriov_disable_migration(struct pci_dev *dev)
 	iounmap(iov->mstate);
 }
 
+int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
+{
+       return 0;
+}
+
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -260,6 +265,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
 	int bars = 0;
+	int retval;
 
 	if (!nr_virtfn)
 		return 0;
@@ -334,6 +340,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	if (nr_virtfn < initial)
 		initial = nr_virtfn;
 
+	if ((retval = pcibios_sriov_enable(dev, initial))) {
+		dev_err(&dev->dev, "Failure %d from pcibios_sriov_setup()\n",
+				retval);
+		return retval;
+	}
+
 	for (i = 0; i < initial; i++) {
 		rc = virtfn_add(dev, i, 0);
 		if (rc)
@@ -368,6 +380,11 @@ failed:
 	return rc;
 }
 
+int __weak pcibios_sriov_disable(struct pci_dev *pdev)
+{
+       return 0;
+}
+
 static void sriov_disable(struct pci_dev *dev)
 {
 	int i;
@@ -382,6 +399,8 @@ static void sriov_disable(struct pci_dev *dev)
 	for (i = 0; i < iov->num_VFs; i++)
 		virtfn_remove(dev, i, 0);
 
+	pcibios_sriov_disable(dev);
+
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-- 
1.7.9.5

