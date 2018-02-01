Return-Path: <SRS0=FKzq=E3=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=FKzq=E3=fredlawl.com=fred@kernel.org>
From: Frederick Lawler <fred@fredlawl.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@kernel.org,
	Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 1/1] PCI: Replace pci_find_ext_capability() calls with pci_dev aer_cap
Date: Wed, 31 Jan 2018 20:53:45 -0600
Message-Id: <1517453625-13110-2-git-send-email-fred@fredlawl.com>
In-Reply-To: <1517453625-13110-1-git-send-email-fred@fredlawl.com>
References: <1517453625-13110-1-git-send-email-fred@fredlawl.com>
List-ID: <linux-pci.vger.kernel.org>

Replace pci_find_ext_capability(..., PCI_EXT_CAP_ID_ERR) calls with
pci_dev aer_cap.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
--
V2:
* Reset program_hpp_type2() in probe.c back to its original state
---
 drivers/pci/pcie/aer/aer_inject.c |  4 ++--
 drivers/pci/pcie/aer/ecrc.c       |  4 ++--
 drivers/pci/pcie/portdrv_core.c   | 15 +++++++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 2b6a592..c8e6634 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -349,7 +349,7 @@ static int aer_inject(struct aer_error_inj *einj)
 		goto out_put;
 	}
 
-	pos_cap_err = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos_cap_err = dev->aer_cap;
 	if (!pos_cap_err) {
 		dev_err(&dev->dev, "aer_inject: Device doesn't support AER\n");
 		ret = -EPROTONOSUPPORT;
@@ -360,7 +360,7 @@ static int aer_inject(struct aer_error_inj *einj)
 	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK,
 			      &uncor_mask);
 
-	rp_pos_cap_err = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ERR);
+	rp_pos_cap_err = rpdev->aer_cap;
 	if (!rp_pos_cap_err) {
 		dev_err(&rpdev->dev,
 			"aer_inject: Root port doesn't support AER\n");
diff --git a/drivers/pci/pcie/aer/ecrc.c b/drivers/pci/pcie/aer/ecrc.c
index a2747a6..18289be 100644
--- a/drivers/pci/pcie/aer/ecrc.c
+++ b/drivers/pci/pcie/aer/ecrc.c
@@ -54,7 +54,7 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	if (!pos)
 		return -ENODEV;
 
@@ -82,7 +82,7 @@ static int disable_ecrc_checking(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	pos = dev->aer_cap;
 	if (!pos)
 		return -ENODEV;
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index a592103..5a5d817 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -52,7 +52,7 @@ static void release_pcie_device(struct device *dev)
 static int pcie_message_numbers(struct pci_dev *dev, int mask,
 				u32 *pme, u32 *aer, u32 *dpc)
 {
-	u32 nvec = 0, pos, reg32;
+	u32 nvec = 0, pos;
 	u16 reg16;
 
 	/*
@@ -68,8 +68,11 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 		nvec = *pme + 1;
 	}
 
+#ifdef CONFIG_PCIEAER
 	if (mask & PCIE_PORT_SERVICE_AER) {
-		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+		u32 reg32;
+
+		pos = dev->aer_cap;
 		if (pos) {
 			pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
 					      &reg32);
@@ -77,6 +80,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
 			nvec = max(nvec, *aer + 1);
 		}
 	}
+#endif
 
 	if (mask & PCIE_PORT_SERVICE_DPC) {
 		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
@@ -233,9 +237,10 @@ static int get_port_device_capability(struct pci_dev *dev)
 		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
 			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
 	}
+
+#ifdef CONFIG_PCIEAER
 	/* AER capable */
-	if ((cap_mask & PCIE_PORT_SERVICE_AER)
-	    && pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)) {
+	if ((cap_mask & PCIE_PORT_SERVICE_AER) && dev->aer_cap) {
 		services |= PCIE_PORT_SERVICE_AER;
 		/*
 		 * Disable AER on this port in case it's been enabled by the
@@ -243,6 +248,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 */
 		pci_disable_pcie_error_reporting(dev);
 	}
+#endif
+
 	/* VC support */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VC))
 		services |= PCIE_PORT_SERVICE_VC;
-- 
2.7.4
