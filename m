Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v4 2/2] PCI/IOV: Use VF0 cached config space size for other VFs
Date: Mon, 19 Mar 2018 21:06:01 +0100
Message-Id: <1521489961-18291-2-git-send-email-karahmed@amazon.de>
In-Reply-To: <1521489961-18291-1-git-send-email-karahmed@amazon.de>
References: <1521489961-18291-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Cache the config space size from VF0 and use it for all other VFs instead
of reading it from the config space of each VF.  We assume that it will be
the same across all associated VFs.

This is an optimization when enabling SR-IOV on a device with many VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 drivers/pci/iov.c   |  3 +++
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 11 ++++++++++-
 include/linux/pci.h |  1 +
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 30bf8f7..046e0d3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -135,6 +135,9 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 			     &physfn->sriov->subsystem_vendor);
 	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
 			     &physfn->sriov->subsystem_device);
+
+	virtfn->class = physfn->sriov->class;
+	physfn->sriov->cfg_size = __pci_cfg_space_size(virtfn);
 }
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bdb4ba2..69da57b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -271,6 +271,7 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
+	u32		cfg_size;	/* VF config space size */
 	u32		class;		/* VF device */
 	u8		hdr_type;	/* VF header type */
 	u16		subsystem_vendor; /* VF subsystem vendor */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 21ee1c3..fd21e2b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1365,7 +1365,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 	return PCI_CFG_SPACE_EXP_SIZE;
 }
 
-int pci_cfg_space_size(struct pci_dev *dev)
+int __pci_cfg_space_size(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
@@ -1389,6 +1389,15 @@ int pci_cfg_space_size(struct pci_dev *dev)
 	return PCI_CFG_SPACE_SIZE;
 }
 
+int pci_cfg_space_size(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_ATS
+	if (dev->is_virtfn)
+		return dev->physfn->sriov->cfg_size;
+#endif
+	return __pci_cfg_space_size(dev);
+}
+
 static int pci_cfg_space_class(struct pci_dev *dev)
 {
 	int class;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1be..fcd5d88 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1290,6 +1290,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+int __pci_cfg_space_size(struct pci_dev *dev);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
-- 
2.7.4
