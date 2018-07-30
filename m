Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32946 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbeGaBNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jul 2018 21:13:33 -0400
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/AER: Do not clear AER bits if we don't own AER
Date: Mon, 30 Jul 2018 18:35:31 -0500
Message-Id: <20180730233547.1238-1-mr.nuke.me@gmail.com>
In-Reply-To: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
References: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we don't own AER, we shouldn't touch the AER error bits. Clearing
error bits willy-nilly might cause firmware to miss some errors. In
theory, these bits get cleared by FFS, or via ACPI _HPX method. These
mechanisms are not subject to the problem.

This race is mostly of theoretical significance, since I can't
reasonably demonstrate this race in the lab.

On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
need for two checks: aer_cap and get_firmware_first().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

Changes since v2:
  - Added missing negation in pci_cleanup_aer_error_status_regs()

 drivers/pci/pcie/aer.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..40e5c86271d1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
+
+static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
+{
+	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
+}
+
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
@@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
-	if (!dev->aer_cap)
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
@@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
@@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
-	pos = dev->aer_cap;
-	if (!pos)
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
+	pos = dev->aer_cap;
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
-- 
2.17.1
