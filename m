Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:58370 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3H1T1T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2013 15:27:19 -0400
Received: by mail-ye0-f180.google.com with SMTP id r9so1625794yen.25
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2013 12:27:18 -0700 (PDT)
Subject: [PATCH 3/4] PCI: Support PCIe Capability Slot registers only for
 ports with slots
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yuval Mintz <yuvalmin@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiang Liu <jiang.liu@huawei.com>, Jiang Liu <liuj97@gmail.com>
Date: Wed, 28 Aug 2013 13:27:15 -0600
Message-ID: <20130828192715.5895.37408.stgit@bhelgaas-glaptop>
In-Reply-To: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
References: <20130828192627.5895.26558.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously we allowed callers to access Slot Capabilities, Status, and
Control for Root Ports even if the Root Port did not implement a slot.
This seems dubious because the spec only requires these registers if a
slot is implemented.

It's true that even Root Ports without slots must have *space* for these
slot registers, because the Root Capabilities, Status, and Control
registers are after the slot registers in the capability.  However,
for a v1 PCIe Capability, the *semantics* of the slot registers are
undefined unless a slot is implemented.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/access.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 9a46fa9..061da8c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -497,9 +497,9 @@ static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
-	return type == PCI_EXP_TYPE_ROOT_PORT ||
-	       (type == PCI_EXP_TYPE_DOWNSTREAM &&
-		pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT);
+	return (type == PCI_EXP_TYPE_ROOT_PORT ||
+		type == PCI_EXP_TYPE_DOWNSTREAM) &&
+	       pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT;
 }
 
 static inline bool pcie_cap_has_rtctl(const struct pci_dev *dev)

