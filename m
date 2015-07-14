Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34122 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbGNTpP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 15:45:15 -0400
Received: by obre1 with SMTP id e1so12848927obr.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 12:45:14 -0700 (PDT)
Subject: [PATCH 2/2] PCI: Add pcie_downstream_port() (true for Root and
 Switch Downstream Ports)
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>
Date: Tue, 14 Jul 2015 14:45:11 -0500
Message-ID: <20150714194511.13471.8395.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714193757.13471.77973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714193757.13471.77973.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As used in the PCIe spec, "Downstream Port" includes both Root Ports and
Switch Downstream Ports.  We sometimes checked for PCI_EXP_TYPE_DOWNSTREAM
when we should have checked for PCI_EXP_TYPE_ROOT_PORT or
PCI_EXP_TYPE_DOWNSTREAM.

For a Root Port without a slot, the effect of this was that using
pcie_capability_read_word() to read PCI_EXP_SLTSTA returned zero instead of
showing the Presence Detect State bit hardwired to one as the PCIe Spec,
r3.0, sec 7.8, requires.  (This read is completed in software because
previous PCIe spec versions didn't require PCI_EXP_SLTSTA to exist at all.)

Nothing in the kernel currently depends on this (pciehp only reads
PCI_EXP_SLTSTA on ports with slots), so this is a cleanup and not a
functional change.

Add a pcie_downstream_port() helper function and use it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index d9b64a1..79f0102 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -531,6 +531,14 @@ static inline int pcie_cap_version(const struct pci_dev *dev)
 	return pcie_caps_reg(dev) & PCI_EXP_FLAGS_VERS;
 }
 
+static bool pcie_downstream_port(constr struct pci_dev *dev)
+{
+	int type = pci_pcie_type(dev);
+
+	return type == PCI_EXP_TYPE_ROOT_PORT ||
+	       type == PCI_EXP_TYPE_DOWNSTREAM;
+}
+
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
@@ -546,10 +554,7 @@ bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
 
 static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
 {
-	int type = pci_pcie_type(dev);
-
-	return (type == PCI_EXP_TYPE_ROOT_PORT ||
-		type == PCI_EXP_TYPE_DOWNSTREAM) &&
+	return pcie_downstream_port(dev) &&
 	       pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT;
 }
 
@@ -628,10 +633,9 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 	 * State bit in the Slot Status register of Downstream Ports,
 	 * which must be hardwired to 1b.  (PCIe Base Spec 3.0, sec 7.8)
 	 */
-	if (pci_is_pcie(dev) && pos == PCI_EXP_SLTSTA &&
-		 pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
 		*val = PCI_EXP_SLTSTA_PDS;
-	}
 
 	return 0;
 }
@@ -657,10 +661,9 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 		return ret;
 	}
 
-	if (pci_is_pcie(dev) && pos == PCI_EXP_SLTCTL &&
-		 pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) {
+	if (pci_is_pcie(dev) && pcie_downstream_port(dev) &&
+	    pos == PCI_EXP_SLTSTA)
 		*val = PCI_EXP_SLTSTA_PDS;
-	}
 
 	return 0;
 }

