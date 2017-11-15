Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5717 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932509AbdKOTLV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2017 14:11:21 -0500
From: Neo Jia <cjia@nvidia.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: [PATCH 1/1] Change pci_enable_sriov, pci_disable_sriov and pci_reset_function to non-GPL symbol.
Date: Wed, 15 Nov 2017 11:10:58 -0800
Message-ID: <1510773058-1482-1-git-send-email-cjia@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This will allow proprietary linux drivers to adopt SR-IOV spec from
PCI-SIG, also switch pci_reset_function to non-GPL symbol as it mainly
does pci config space access per spec.

Signed-off-by: Neo Jia <cjia@nvidia.com>
Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 drivers/pci/iov.c | 4 ++--
 drivers/pci/pci.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 6bacb8995e96..ecc6e7cddc57 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -673,7 +673,7 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 
 	return sriov_enable(dev, nr_virtfn);
 }
-EXPORT_SYMBOL_GPL(pci_enable_sriov);
+EXPORT_SYMBOL(pci_enable_sriov);
 
 /**
  * pci_disable_sriov - disable the SR-IOV capability
@@ -688,7 +688,7 @@ void pci_disable_sriov(struct pci_dev *dev)
 
 	sriov_disable(dev);
 }
-EXPORT_SYMBOL_GPL(pci_disable_sriov);
+EXPORT_SYMBOL(pci_disable_sriov);
 
 /**
  * pci_num_vf - return number of VFs associated with a PF device_release_driver
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4a7c6864fdf4..e8318abedc73 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4367,7 +4367,7 @@ int pci_reset_function(struct pci_dev *dev)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(pci_reset_function);
+EXPORT_SYMBOL(pci_reset_function);
 
 /**
  * pci_reset_function_locked - quiesce and reset a PCI device function
-- 
2.7.4
