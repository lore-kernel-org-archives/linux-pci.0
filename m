Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45128 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423901AbcFMTFv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 15:05:51 -0400
Subject: [PATCH v6 2/3] PCI: Add pci_enable_ptm() for drivers to enable PTM
 on endpoints
To: Jonathan Yong <jonathan.yong@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 14:05:43 -0500
Message-ID: <20160613190543.12503.49954.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c        |   45 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |    7 ++++++
 include/uapi/linux/pci_regs.h |    1 +
 3 files changed, 53 insertions(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 5c8479b..9cfa64a 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -68,3 +68,48 @@ void pci_ptm_init(struct pci_dev *dev)
 
 	pci_ptm_info(dev);
 }
+
+int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+{
+	int pos;
+	struct pci_dev *ups;
+	u32 cap, ctrl;
+
+	if (!pci_is_pcie(dev))
+		return -EINVAL;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!pos)
+		return -EINVAL;
+
+	/*
+	 * For a PCIe Endpoint, PTM is only useful if the endpoint can
+	 * issue PTM requests to upstream devices that have PTM enabled and
+	 * can respond.
+	 *
+	 * For Root Complex Integrated Endpoints, there is no upstream
+	 * device, so there must be some implementation-specific way to
+	 * associate the endpoint with a time source.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
+		/* PTM is only useful if an upstream device has it enabled */
+		ups = pci_upstream_bridge(dev);
+		if (!ups || !ups->ptm_enabled)
+			return -EINVAL;
+	} else if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END)
+		return -EINVAL;
+
+	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+	if (!(cap & PCI_PTM_CAP_REQ))
+		return -EINVAL;
+
+	ctrl = PCI_PTM_CTRL_ENABLE;
+	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
+	dev->ptm_enabled = 1;
+
+	pci_ptm_info(dev);
+
+	if (granularity)
+		*granularity = 0;
+	return 0;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 09e6c18..593b2c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1365,6 +1365,13 @@ static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
 #endif
 
+#ifdef CONFIG_PCIE_PTM
+int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
+#else
+static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
+{ return -EINVAL; }
+#endif
+
 void pci_cfg_access_lock(struct pci_dev *dev);
 bool pci_cfg_access_trylock(struct pci_dev *dev);
 void pci_cfg_access_unlock(struct pci_dev *dev);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 926fff4..72bbe14 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -967,6 +967,7 @@
 
 /* Precision Time Measurement */
 #define PCI_PTM_CAP			0x04	    /* PTM Capability */
+#define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
 #define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
 #define PCI_PTM_CTRL			0x08	    /* PTM Control */
 #define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */

