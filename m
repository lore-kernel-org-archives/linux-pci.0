Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0092.outbound.protection.outlook.com ([104.47.36.92]:21669
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751457AbdJ0CiA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Oct 2017 22:38:00 -0400
From: sbates@raithlin.com
To: corbet@lwn.net, bhelgaas@google.com, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, akpm@linux-foundation.org, mingo@kernel.org,
        cdall@linaro.org, marc.zyngier@arm.com, zohar@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: logang@deltatee.com, tom@talpey.com,
        Stephen Bates <sbates@raithlin.com>
Subject: [PATCH] pci: Add a acs_disable option for pci kernel parameter
Date: Thu, 26 Oct 2017 20:37:49 -0600
Message-Id: <1509071869-18771-1-git-send-email-sbates@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

On some servers the BIOS sets up ACS on any valid pci_dev in the
system. The kernel has no way of backing this out since the kernel
only turns ACS capabilities on.

This patch adds a new boot option to the pci kernel parameter called
"acs_disable" that will disable ACS. This is useful for PCI peer to
peer communication but can cause problems when IOVA isolation is
required and an IOMMU is enabled. Use with care.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/pci/pci.c                               | 23 ++++++++++++++++++++---
 drivers/pci/pci.h                               |  2 +-
 drivers/pci/probe.c                             |  4 ++--
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0549662..695eb12 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2907,6 +2907,10 @@
 		earlydump	[X86] dump PCI config space before the kernel
 			        changes anything
 		off		[X86] don't probe for the PCI bus
+		acs_disable     [PCIE] disable access control services. Note
+				this can interfere with IOVA isolation if an IOMMU
+				is enabled but can be necessary when doing PCI
+				peer to peer communication. Use with care.
 		bios		[X86-32] force use of PCI BIOS, don't access
 				the hardware directly. Use this if your machine
 				has a non-standard PCI host bridge.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6078dfc..ce33608 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -110,6 +110,9 @@ unsigned int pcibios_max_latency = 255;
 /* If set, the PCIe ARI capability will not be used. */
 static bool pcie_ari_disabled;
 
+/* If set, the PCIe ACS capability will be disabled. */
+static bool pci_acs_disable;
+
 /* Disable bridge_d3 for all PCIe ports */
 static bool pci_bridge_d3_disable;
 /* Force bridge_d3 for all PCIe ports */
@@ -1182,7 +1185,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_msi_state(dev);
 
 	/* Restore ACS and IOV configuration state */
-	pci_enable_acs(dev);
+	pci_config_acs(dev);
 	pci_restore_iov_state(dev);
 
 	dev->state_saved = false;
@@ -2821,11 +2824,23 @@ static void pci_std_enable_acs(struct pci_dev *dev)
 }
 
 /**
- * pci_enable_acs - enable ACS if hardware support it
+ * pci_config_acs - configure ACS
  * @dev: the PCI device
  */
-void pci_enable_acs(struct pci_dev *dev)
+void pci_config_acs(struct pci_dev *dev)
 {
+	int pos;
+
+	if (pci_acs_disable) {
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
+		if (!pos)
+			return;
+
+		dev_warn_ratelimited(&dev->dev,
+				     "disabling ACS via pci_acs_disable\n");
+		pci_write_config_word(dev, pos + PCI_ACS_CTRL, 0);
+	}
+
 	if (!pci_acs_enable)
 		return;
 
@@ -5471,6 +5486,8 @@ static int __init pci_setup(char *str)
 		if (*str && (str = pcibios_setup(str)) && *str) {
 			if (!strcmp(str, "nomsi")) {
 				pci_no_msi();
+			} else if (!strcmp(str, "acs_disable")) {
+				pci_acs_disable = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a6560c9..16d94d3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -338,7 +338,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 	return resource_alignment(res);
 }
 
-void pci_enable_acs(struct pci_dev *dev);
+void pci_config_acs(struct pci_dev *dev);
 
 #ifdef CONFIG_PCIE_PTM
 void pci_ptm_init(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ff94b69..86c3299 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2020,8 +2020,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	/* Address Translation Services */
 	pci_ats_init(dev);
 
-	/* Enable ACS P2P upstream forwarding */
-	pci_enable_acs(dev);
+	/* Configure ACS P2P upstream forwarding */
+	pci_config_acs(dev);
 
 	/* Precision Time Measurement */
 	pci_ptm_init(dev);
-- 
2.7.4
