Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:43988 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdJBOIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Oct 2017 10:08:49 -0400
Received: by mail-wm0-f49.google.com with SMTP id m72so7657856wmc.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Oct 2017 07:08:48 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: graeme.gregory@linaro.org, leif.lindholm@linaro.org,
        daniel.thompson@Linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] PCI: aspm: deal with missing root ports in link state handling
Date: Mon,  2 Oct 2017 15:08:40 +0100
Message-Id: <20171002140840.7767-1-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Even though it is unconventional, some PCIe host implementations omit
the root ports entirely, and simply consist of a host bridge (which
is not modeled as a device in the PCI hierarchy) and a link.

When the downstream device is an endpoint, our current code does not
seem to mind this unusual configuration. However, when PCIe switches
are involved, the ASPM code assumes that any downstream switch port
has a parent, and blindly derefences the bus->parent->self field of
the pci_dev struct to chain the downstream link state to the link
state of the root port. Given that the root port is missing, the link
is not modeled at all, and nor is the link state, and attempting to
access it results in a NULL pointer dereference and a crash.

So let's avoid this by allowing the link state chain to terminate at
the downstream port if no root port exists.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/pcie/aspm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1dfa10cc566b..0bea8498b5a5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -802,10 +802,14 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 	/*
 	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
-	 * hierarchies.
+	 * hierarchies.  Note that some PCIe host implementations omit
+	 * the root ports entirely, in which case a downstream port on
+	 * a switch may become the root of the link state chain for all
+	 * its subordinate endpoints.
 	 */
 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE) {
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE ||
+	    !pdev->bus->parent->self) {
 		link->root = link;
 	} else {
 		struct pcie_link_state *parent;
-- 
2.11.0
