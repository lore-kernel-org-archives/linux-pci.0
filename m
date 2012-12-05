Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gh0-f202.google.com ([209.85.160.202]:35002 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab2LEU54 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Dec 2012 15:57:56 -0500
Received: by mail-gh0-f202.google.com with SMTP id z10so671231ghb.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Dec 2012 12:57:56 -0800 (PST)
Subject: [PATCH 07/12] e1000e: Use standard #defines for PCIe Capability ASPM
	fields
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Duyck <alexander.h.duyck@intel.com>,
	e1000-devel@lists.sourceforge.net,
	Don Skidmore <donald.c.skidmore@intel.com>,
	Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>,
	Bruce Allan <bruce.w.allan@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	John Ronciak <john.ronciak@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Carolyn Wyborny <carolyn.wyborny@intel.com>
Date: Wed, 05 Dec 2012 13:57:56 -0700
Message-ID: <20121205205755.13851.77284.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
References: <20121205205724.13851.50508.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the standard #defines for PCIe Capability ASPM fields.

Previously we used PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1 directly, but
these are defined for the Linux ASPM interfaces, e.g.,
pci_disable_link_state(), and only coincidentally match the actual register
bits.  PCIE_LINK_STATE_CLKPM, also part of that interface, does not match
the register bit.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: Bruce Allan <bruce.w.allan@intel.com>
CC: Carolyn Wyborny <carolyn.wyborny@intel.com>
CC: Don Skidmore <donald.c.skidmore@intel.com>
CC: Greg Rose <gregory.v.rose@intel.com>
CC: Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>
CC: Alex Duyck <alexander.h.duyck@intel.com>
CC: John Ronciak <john.ronciak@intel.com>
CC: e1000-devel@lists.sourceforge.net
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f444eb0..b8561ef 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5613,15 +5613,22 @@ static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
 #else
 static void __e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
 {
+	u16 aspm_ctl = 0;
+
+	if (state & PCIE_LINK_STATE_L0S)
+		aspm_ctl |= PCI_EXP_LNKCTL_ASPM_L0S;
+	if (state & PCIE_LINK_STATE_L1)
+		aspm_ctl |= PCI_EXP_LNKCTL_ASPM_L1;
+
 	/*
 	 * Both device and parent should have the same ASPM setting.
 	 * Disable ASPM in downstream component first and then upstream.
 	 */
-	pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, state);
+	pcie_capability_clear_word(pdev, PCI_EXP_LNKCTL, aspm_ctl);
 
 	if (pdev->bus->self)
 		pcie_capability_clear_word(pdev->bus->self, PCI_EXP_LNKCTL,
-					   state);
+					   aspm_ctl);
 }
 #endif
 static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)

