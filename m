Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:53182 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbbAOC2U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jan 2015 21:28:20 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Thu, 15 Jan 2015 12:28:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id AF0B92CE8040
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 13:28:15 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0F2SFKm44433574
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 13:28:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0F2SEFJ019612
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 13:28:15 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V11 02/17] PCI/IOV: add VF enable/disable hook
Date: Thu, 15 Jan 2015 10:27:52 +0800
Message-Id: <1421288887-7765-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VFs are dynamically created/released when driver enable them. On some
platforms, like PowerNV, special resources are necessary to enable VFs.

This patch adds two hooks for platform initialization before creating the
VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/iov.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index e76d1a0..933d8cc 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -213,6 +213,11 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 	pci_dev_put(dev);
 }
 
+int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
+{
+       return 0;
+}
+
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -223,6 +228,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
 	int bars = 0;
+	int retval;
 
 	if (!nr_virtfn)
 		return 0;
@@ -297,6 +303,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	if (nr_virtfn < initial)
 		initial = nr_virtfn;
 
+	if ((retval = pcibios_sriov_enable(dev, initial))) {
+		dev_err(&dev->dev, "Failure %d from pcibios_sriov_setup()\n",
+			retval);
+		return retval;
+	}
+
 	for (i = 0; i < initial; i++) {
 		rc = virtfn_add(dev, i, 0);
 		if (rc)
@@ -325,6 +337,11 @@ failed:
 	return rc;
 }
 
+int __weak pcibios_sriov_disable(struct pci_dev *pdev, u16 vf_num)
+{
+       return 0;
+}
+
 static void sriov_disable(struct pci_dev *dev)
 {
 	int i;
@@ -336,6 +353,8 @@ static void sriov_disable(struct pci_dev *dev)
 	for (i = 0; i < iov->num_VFs; i++)
 		virtfn_remove(dev, i, 0);
 
+	pcibios_sriov_disable(dev, iov->num_VFs);
+
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-- 
1.7.9.5

