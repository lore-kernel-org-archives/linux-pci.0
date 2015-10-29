Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35307 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756910AbbJ2WXZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 18:23:25 -0400
Subject: [PATCH v2 5/7] PCI: Wait 1 second between disabling VFs and
 clearing NumVFs
To: Alexander Duyck <aduyck@mirantis.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2015 17:23:22 -0500
Message-ID: <20151029222322.11908.13738.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <aduyck@mirantis.com>

Per sec 3.3.3.1 of the SR-IOV spec, r1.1, we must allow 1.0s after clearing
VF Enable before reading any field in the SR-IOV Extended Capability.

Wait 1 second before calling pci_iov_set_numvfs(), which reads
PCI_SRIOV_VF_OFFSET and PCI_SRIOV_VF_STRIDE after it sets PCI_SRIOV_NUM_VF.

[bhelgaas: split to separate patch for reviewability, add spec reference]
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/iov.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index fada98d..24428d5 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -339,13 +339,13 @@ failed:
 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-	pci_iov_set_numvfs(dev, 0);
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
 
 	if (iov->link != dev->devfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 
+	pci_iov_set_numvfs(dev, 0);
 	return rc;
 }
 

