Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932614AbdAKPoJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 10:44:09 -0500
Date: Wed, 11 Jan 2017 09:44:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Blake Moore <blake.moore@men.de>,
        Jao Ching Chen <jcchen@pericom.com>,
        Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI: Enumerate switches below PCI-to-PCIe bridges
Message-ID: <20170111154403.GA8768@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI: Enumerate switches below PCI-to-PCIe bridges

A PCI-to-PCIe bridge (a "reverse bridge") has a PCI or PCI-X primary
interface and a PCI Express secondary interface.  The PCIe interface is a
Downstream Port that originates a Link.  See the "PCI Express to PCI/PCI-X
Bridge Specification", rev 1.0, sections 1.2 and A.6.

The bug report below involves a PCI-to-PCIe bridge and a PCIe switch below
the bridge:

  00:1e.0 Intel 82801 PCI Bridge to [bus 01-0a]
  01:00.0 Pericom PI7C9X111SL PCIe-to-PCI Reversible Bridge to [bus 02-0a]
  02:00.0 Pericom Device 8608 [PCIe Upstream Port] to [bus 03-0a]
  03:01.0 Pericom Device 8608 [PCIe Downstream Port] to [bus 0a]

01:00.0 is configured as a PCI-to-PCIe bridge (despite the name printed by
lspci).  As we traverse a PCIe hierarchy, device connections alternate
between PCIe Links and internal Switch logic.  Previously we did not
recognize that 01:00.0 had a secondary link, so we thought the 02:00.0
Upstream Port *did* have a secondary link.  In fact, it's the other way
around: 01:00.0 has a secondary link, and 02:00.0 has internal Switch logic
on its secondary side.

When we thought 02:00.0 had a secondary link, the pci_scan_slot() ->
only_one_child() path assumed 02:00.0 could have only one child, so 03:00.0
was the only possible downstream device.  But 03:00.0 doesn't exist, so we
didn't look for any other devices on bus 03.

Booting with "pci=pcie_scan_all" is a workaround, but we don't want users
to have to do that.

Recognize that PCI-to-PCIe bridges originate links on their secondary
interfaces.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=189361
Fixes: d0751b98dfa3 ("PCI: Add dev->has_secondary_link to track downstream PCIe links")
Tested-by: Blake Moore <blake.moore@men.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org      # v4.2+

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e164b5c9f0f0..204960e70333 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1169,6 +1169,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
 	if (!pos)
 		return;
+
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
@@ -1176,13 +1177,14 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
 
 	/*
-	 * A Root Port is always the upstream end of a Link.  No PCIe
-	 * component has two Links.  Two Links are connected by a Switch
-	 * that has a Port on each Link and internal logic to connect the
-	 * two Ports.
+	 * A Root Port or a PCI-to-PCIe bridge is always the upstream end
+	 * of a Link.  No PCIe component has two Links.  Two Links are
+	 * connected by a Switch that has a Port on each Link and internal
+	 * logic to connect the two Ports.
 	 */
 	type = pci_pcie_type(pdev);
-	if (type == PCI_EXP_TYPE_ROOT_PORT)
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_PCIE_BRIDGE)
 		pdev->has_secondary_link = 1;
 	else if (type == PCI_EXP_TYPE_UPSTREAM ||
 		 type == PCI_EXP_TYPE_DOWNSTREAM) {
