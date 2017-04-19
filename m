Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763843AbdDSNxh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Apr 2017 09:53:37 -0400
Date: Wed, 19 Apr 2017 08:53:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH] PCI: Include PCI-to-PCIe bridges as "Downstream Ports"
Message-ID: <20170419135332.GA16404@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A PCI/PCI-X to PCI Express bridge, sometimes referred to as a "reverse
bridge", is a bridge with conventional PCI or PCI-X on its primary side and
a PCI Express Port on its secondary (downstream) side.

That PCIe Port is a Downstream Port and could be connected to a slot, just
like a Root Port or a Switch Downstream Port.  Make pcie_downstream_port()
return true for them, so we can access the Slot registers in the PCIe
capability.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 1c8051003e67..9b09cd31158c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -700,7 +700,8 @@ static bool pcie_downstream_port(const struct pci_dev *dev)
 	int type = pci_pcie_type(dev);
 
 	return type == PCI_EXP_TYPE_ROOT_PORT ||
-	       type == PCI_EXP_TYPE_DOWNSTREAM;
+	       type == PCI_EXP_TYPE_DOWNSTREAM ||
+	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
 }
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
