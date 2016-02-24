Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44276 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247AbcBXTof (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 14:44:35 -0500
Subject: [PATCH v4 6/6] PCI: Squash pci_dev_flags to remove holes
To: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Wed, 24 Feb 2016 13:44:31 -0600
Message-ID: <20160224194431.7585.78791.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>

After removing PCI_DEV_FLAGS_DMA_ALIAS_DEVFN, the (1 << 4) value was
unused.  Squash the other values so all the bits are adjacent.  No
functional change intended.

(I'm not sure this is worth doing.  We have 16 flag bits and we're not
even close to exhausting them.  But if we do squash them, it should be
in a separate patch so we don't clutter up the main patches.)
---
 include/linux/pci.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index d9e0c84..4e36024 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -173,13 +173,13 @@ enum pci_dev_flags {
 	/* Flag for quirk use to store if quirk-specific ACS is enabled */
 	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1 << 3),
 	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
-	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 5),
+	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 4),
 	/* Do not use bus resets for device */
-	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 6),
+	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 5),
 	/* Do not use PM reset even if device advertises NoSoftRst- */
-	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
+	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 6),
 	/* Get VPD from function 0 VPD */
-	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 7),
 };
 
 enum pci_irq_reroute_variant {

