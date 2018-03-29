Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44042 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeC2SWs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Mar 2018 14:22:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id m68so3792218pfm.11
        for <linux-pci@vger.kernel.org>; Thu, 29 Mar 2018 11:22:48 -0700 (PDT)
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Sathya Perla <sathya.perla@broadcom.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        alexander.duyck@gmail.com, john.fastabend@gmail.com,
        Jacob Keller <jacob.e.keller@intel.com>,
        Donald Dutile <ddutile@redhat.com>, oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Date: Thu, 29 Mar 2018 11:22:31 -0700
Message-Id: <20180329182231.32151-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some user space depends on driver allowing sriov_totalvfs to be
enabled.  For devices which VF support depends on loaded FW we
have the pci_sriov_{g,s}et_totalvfs() API.  However, this API
uses 0 as a special "unset" value, meaning drivers can't limit
sriov_totalvfs to 0.  Change the special value to be U16_MAX.
Use simple min() to determine actual totalvfs.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c | 6 +++---
 drivers/pci/iov.c                             | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index c4b1f344b4da..dcd6e208a155 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -123,7 +123,7 @@ static int nfp_pcie_sriov_read_nfd_limit(struct nfp_pf *pf)
 		return pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
 
 	pf->limit_vfs = ~0;
-	pci_sriov_set_totalvfs(pf->pdev, 0); /* 0 is unset */
+	pci_sriov_set_totalvfs(pf->pdev, ~0);
 	/* Allow any setting for backwards compatibility if symbol not found */
 	if (err == -ENOENT)
 		return 0;
@@ -537,7 +537,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
 err_net_remove:
 	nfp_net_pci_remove(pf);
 err_sriov_unlimit:
-	pci_sriov_set_totalvfs(pf->pdev, 0);
+	pci_sriov_set_totalvfs(pf->pdev, ~0);
 err_fw_unload:
 	kfree(pf->rtbl);
 	nfp_mip_close(pf->mip);
@@ -570,7 +570,7 @@ static void nfp_pci_remove(struct pci_dev *pdev)
 	nfp_hwmon_unregister(pf);
 
 	nfp_pcie_sriov_disable(pdev);
-	pci_sriov_set_totalvfs(pf->pdev, 0);
+	pci_sriov_set_totalvfs(pf->pdev, ~0);
 
 	nfp_net_pci_remove(pf);
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924ae0350..aa3dfe3ecd68 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -446,6 +446,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID, &iov->vf_device);
 	iov->pgsz = pgsz;
 	iov->self = dev;
+	iov->driver_max_VFs = U16_MAX;
 	iov->drivers_autoprobe = true;
 	pci_read_config_dword(dev, pos + PCI_SRIOV_CAP, &iov->cap);
 	pci_read_config_byte(dev, pos + PCI_SRIOV_FUNC_LINK, &iov->link);
@@ -801,9 +802,6 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
 	if (!dev->is_physfn)
 		return 0;
 
-	if (dev->sriov->driver_max_VFs)
-		return dev->sriov->driver_max_VFs;
-
-	return dev->sriov->total_VFs;
+	return min(dev->sriov->total_VFs, dev->sriov->driver_max_VFs);
 }
 EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
-- 
2.16.2
