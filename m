Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:33919 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdLGW3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 17:29:07 -0500
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        boris.ostrovsky@Oracle.COM, jgross@suse.com, JBeulich@suse.com,
        roger.pau@citrix.com
Cc: konrad.wilk@Oracle.COM
Subject: [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr() interface
Date: Thu,  7 Dec 2017 17:21:44 -0500
Message-Id: <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
In-Reply-To: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch exports pcie_has_flr() and it is being used by Xen pciback
driver to reset (flr/slot/bus) PCI devices based on 'reset' SysFS
attribute.

Signed-off-by: Govinda Tatti <Govinda.Tatti@Oracle.COM>
---
v3: -New

 drivers/pci/pci.c   | 3 ++-
 include/linux/pci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6078dfc..499e922 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3872,7 +3872,7 @@ static void pci_flr_wait(struct pci_dev *dev)
  * Returns true if the device advertises support for PCIe function level
  * resets.
  */
-static bool pcie_has_flr(struct pci_dev *dev)
+bool pcie_has_flr(struct pci_dev *dev)
 {
 	u32 cap;
 
@@ -3882,6 +3882,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
 	return cap & PCI_EXP_DEVCAP_FLR;
 }
+EXPORT_SYMBOL_GPL(pcie_has_flr);
 
 /**
  * pcie_flr - initiate a PCIe function level reset
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d16a7c0..44bf2b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1089,6 +1089,7 @@ int pcie_get_mps(struct pci_dev *dev);
 int pcie_set_mps(struct pci_dev *dev, int mps);
 int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 			  enum pcie_link_width *width);
+bool pcie_has_flr(struct pci_dev *dev);
 void pcie_flr(struct pci_dev *dev);
 int __pci_reset_function(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
-- 
2.9.5
