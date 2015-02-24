Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43831 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbbBXIdy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:33:54 -0500
Received: by paceu11 with SMTP id eu11so34339225pac.10
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:33:54 -0800 (PST)
Subject: [PATCH v12 08/21] PCI: Add pcibios_sriov_enable() and
 pcibios_sriov_disable()
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 24 Feb 2015 02:33:52 -0600
Message-ID: <20150224083352.32124.63952.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

VFs are dynamically created when a driver enables them.  On some platforms,
like PowerNV, special resources are necessary to enable VFs.

Add platform hooks for enabling and disabling VFs.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5643a1011e23..cc6fedf4a1b9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -220,6 +220,11 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
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
@@ -231,6 +236,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	struct pci_sriov *iov = dev->sriov;
 	int bars = 0;
 	int bus;
+	int retval;
 
 	if (!nr_virtfn)
 		return 0;
@@ -307,6 +313,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	if (nr_virtfn < initial)
 		initial = nr_virtfn;
 
+	if ((retval = pcibios_sriov_enable(dev, initial))) {
+		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n",
+			retval);
+		return retval;
+	}
+
 	for (i = 0; i < initial; i++) {
 		rc = virtfn_add(dev, i, 0);
 		if (rc)
@@ -335,6 +347,11 @@ failed:
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
@@ -346,6 +363,8 @@ static void sriov_disable(struct pci_dev *dev)
 	for (i = 0; i < iov->num_VFs; i++)
 		virtfn_remove(dev, i, 0);
 
+	pcibios_sriov_disable(dev);
+
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);

