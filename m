Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ashok Raj <ashok.raj@intel.com>
To: Jean-Phillipe Brucker <jean-philippe.brucker@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: Cache PRI and PASID bits in pci_dev
Date: Tue, 30 May 2017 09:25:48 -0700
Message-Id: <1496161549-167468-2-git-send-email-ashok.raj@intel.com>
In-Reply-To: <1496161549-167468-1-git-send-email-ashok.raj@intel.com>
References: <1496161549-167468-1-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Device drivers need to check if an IOMMU enabled ATS, PRI and PASID in
order to know when they can use the SVM API. Cache PRI and PASID bits in
the pci_dev structure, similarly to what is currently done for ATS.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/pci/ats.c   | 23 +++++++++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index eeb9fb2..2126497 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -153,6 +153,9 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	u32 max_requests;
 	int pos;
 
+	if (WARN_ON(pdev->pri_enabled))
+		return -EBUSY;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return -EINVAL;
@@ -170,6 +173,8 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 	control |= PCI_PRI_CTRL_ENABLE;
 	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
 
+	pdev->pri_enabled = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pri);
@@ -185,6 +190,9 @@ void pci_disable_pri(struct pci_dev *pdev)
 	u16 control;
 	int pos;
 
+	if (WARN_ON(!pdev->pri_enabled))
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return;
@@ -192,6 +200,8 @@ void pci_disable_pri(struct pci_dev *pdev)
 	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
 	control &= ~PCI_PRI_CTRL_ENABLE;
 	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
+
+	pdev->pri_enabled = 0;
 }
 EXPORT_SYMBOL_GPL(pci_disable_pri);
 
@@ -207,6 +217,9 @@ int pci_reset_pri(struct pci_dev *pdev)
 	u16 control;
 	int pos;
 
+	if (WARN_ON(pdev->pri_enabled))
+		return -EBUSY;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
 	if (!pos)
 		return -EINVAL;
@@ -239,6 +252,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	u16 control, supported;
 	int pos;
 
+	if (WARN_ON(pdev->pasid_enabled))
+		return -EBUSY;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return -EINVAL;
@@ -259,6 +275,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 
 	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
 
+	pdev->pasid_enabled = 1;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_enable_pasid);
@@ -273,11 +291,16 @@ void pci_disable_pasid(struct pci_dev *pdev)
 	u16 control = 0;
 	int pos;
 
+	if (WARN_ON(!pdev->pasid_enabled))
+		return;
+
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
 	if (!pos)
 		return;
 
 	pci_write_config_word(pdev, pos + PCI_PASID_CTRL, control);
+
+	pdev->pasid_enabled = 0;
 }
 EXPORT_SYMBOL_GPL(pci_disable_pasid);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..bee980e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -351,6 +351,8 @@ struct pci_dev {
 	unsigned int	msix_enabled:1;
 	unsigned int	ari_enabled:1;	/* ARI forwarding */
 	unsigned int	ats_enabled:1;	/* Address Translation Service */
+	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
+	unsigned int	pri_enabled:1;		/* Page Request Interface */
 	unsigned int	is_managed:1;
 	unsigned int    needs_freset:1; /* Dev requires fundamental reset */
 	unsigned int	state_saved:1;
-- 
2.7.4
