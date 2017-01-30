Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753716AbdA3PYB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 10:24:01 -0500
Subject: [PATCH] PCI/ASPM: Handle PCI-to-PCIe bridges as roots of PCIe
 hierarchies
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Jao Ching Chen <jcchen@pericom.com>, lists@ssl-mail.com,
        linux-kernel@vger.kernel.org, Blake Moore <blake.moore@men.de>,
        Takashi Iwai <tiwai@suse.com>
Date: Mon, 30 Jan 2017 09:23:24 -0600
Message-ID: <20170130152324.32437.37400.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In a struct pcie_link_state, link->root points to the pcie_link_state of
the root of the PCIe hierarchy.  For the topmost link, this points to
itself (link->root = link).  For others, we copy the pointer from the
parent (link->root = link->parent->root).

Previously we recognized that Root Ports originated PCIe hierarchies, but
we treated PCI/PCI-X to PCIe Bridges as being in the middle of the
hierarchy, and when we tried to copy the pointer from link->parent->root,
there was no parent, and we dereferenced a NULL pointer:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000090
  IP: [<ffffffff9e424350>] pcie_aspm_init_link_state+0x170/0x820

Recognize that PCI/PCI-X to PCIe Bridges originate PCIe hierarchies just
like Root Ports do, so link->root for these devices should also point to
itself.

Fixes: 51ebfc92b72b ("PCI: Enumerate switches below PCI-to-PCIe bridges")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=193411
Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1022181
Tested-by: lists@ssl-mail.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.2+
---
 drivers/pci/pcie/aspm.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 17ac1dce3286..3dd8bcbb3011 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -532,25 +532,32 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		return NULL;
+
 	INIT_LIST_HEAD(&link->sibling);
 	INIT_LIST_HEAD(&link->children);
 	INIT_LIST_HEAD(&link->link);
 	link->pdev = pdev;
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) {
+
+	/*
+	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
+	 * hierarchies.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE) {
+		link->root = link;
+	} else {
 		struct pcie_link_state *parent;
+
 		parent = pdev->bus->parent->self->link_state;
 		if (!parent) {
 			kfree(link);
 			return NULL;
 		}
+
 		link->parent = parent;
+		link->root = link->parent->root;
 		list_add(&link->link, &parent->children);
 	}
-	/* Setup a pointer to the root port link */
-	if (!link->parent)
-		link->root = link;
-	else
-		link->root = link->parent->root;
 
 	list_add(&link->sibling, &link_list);
 	pdev->link_state = link;

