Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35857 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030996AbeEZDAe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 May 2018 23:00:34 -0400
Received: by mail-qt0-f193.google.com with SMTP id q6-v6so8969954qtn.3
        for <linux-pci@vger.kernel.org>; Fri, 25 May 2018 20:00:34 -0700 (PDT)
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Sathya Perla <sathya.perla@broadcom.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        alexander.duyck@gmail.com, Jacob Keller <jacob.e.keller@intel.com>,
        Donald Dutile <ddutile@redhat.com>, oss-drivers@netronome.com,
        Christoph Hellwig <hch@infradead.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] PCI: reset driver SR-IOV state after remove
Date: Fri, 25 May 2018 20:00:24 -0700
Message-Id: <20180526030024.14866-1-jakub.kicinski@netronome.com>
In-Reply-To: <20180525214525.GB92995@bhelgaas-glaptop.roam.corp.google.com>
References: <20180525214525.GB92995@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn points out that currently core and most of the drivers don't
clean up dev->sriov->driver_max_VFs settings on .remove().  This
means that if a different driver is bound afterwards it will
inherit the old setting:

  - load PF driver 1
  - driver calls pci_sriov_set_totalvfs() to reduce driver_max_VFs
  - unload PF driver 1
  - load PF driver 2

Reset driver_max_VFs back to total_VFs after device remove.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
I gave into the temptation and also added a warning about SR-IOV
being on after remove :)  Please let me know if this is anywhere
close to what you had in mind!

 drivers/pci/iov.c        | 16 ++++++++++++++++
 drivers/pci/pci-driver.c |  1 +
 drivers/pci/pci.h        |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index db86fd26f8e1..5d0f560a1e28 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -574,6 +574,22 @@ void pci_iov_release(struct pci_dev *dev)
 		sriov_release(dev);
 }
 
+/**
+ * pci_sriov_drv_cleanup - clean up SR-IOV state after PF driver is detached
+ * @dev: the PCI device
+ */
+void pci_sriov_drv_cleanup(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+
+	if (!dev->is_physfn)
+		return;
+	iov->driver_max_VFs = iov->total_VFs;
+	if (iov->num_VFs)
+		dev_warn(&dev->dev,
+			 "driver left SR-IOV enabled after remove\n");
+}
+
 /**
  * pci_iov_update_resource - update a VF BAR
  * @dev: the PCI device
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b9a131137e64..932a1acf7b1b 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -443,6 +443,7 @@ static int pci_device_remove(struct device *dev)
 		}
 		pcibios_free_irq(pci_dev);
 		pci_dev->driver = NULL;
+		pci_sriov_drv_cleanup(pci_dev);
 	}
 
 	/* Undo the runtime PM settings in local_pci_probe() */
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 023f7cf25bff..5fa6d19762bd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -311,6 +311,7 @@ static inline void pci_restore_ats_state(struct pci_dev *dev)
 #ifdef CONFIG_PCI_IOV
 int pci_iov_init(struct pci_dev *dev);
 void pci_iov_release(struct pci_dev *dev);
+void pci_sriov_drv_cleanup(struct pci_dev *dev);
 void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
@@ -323,6 +324,9 @@ static inline int pci_iov_init(struct pci_dev *dev)
 }
 static inline void pci_iov_release(struct pci_dev *dev)
 
+{
+}
+static inline void pci_sriov_drv_cleanup(struct pci_dev *dev)
 {
 }
 static inline void pci_restore_iov_state(struct pci_dev *dev)
-- 
2.17.0
