Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755277AbcJZNxo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 09:53:44 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Hannes Reinecke <hare@suse.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] pci: Don't set RCB bit in LNKCTL if the upstream bridge hasn't
Date: Wed, 26 Oct 2016 15:53:34 +0200
Message-Id: <1477490014-115917-1-git-send-email-jthumshirn@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Read Completion Boundary bit must only be set on a device or endpoint if
it is set on the upstream bridge.

Fixes: 7a1562d4f ("PCI: Apply _HPX Link Control settings to all devices with a link")
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/pci/probe.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ab00267..5007b96 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1439,6 +1439,16 @@ static void program_hpp_type1(struct pci_dev *dev, struct hpp_type1 *hpp)
 		dev_warn(&dev->dev, "PCI-X settings not supported\n");
 }
 
+static bool pcie_get_upstream_rcb(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	u16 lnkctl;
+
+	pcie_capability_read_word(bridge, PCI_EXP_LNKCTL, &lnkctl);
+
+	return lnkctl & PCI_EXP_LNKCTL_RCB;
+}
+
 static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 {
 	int pos;
@@ -1468,9 +1478,21 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 			~hpp->pci_exp_devctl_and, hpp->pci_exp_devctl_or);
 
 	/* Initialize Link Control Register */
-	if (pcie_cap_has_lnkctl(dev))
+	if (pcie_cap_has_lnkctl(dev)) {
+		bool us_rcb;
+		u16 clear;
+		u16 set;
+
+		us_rcb = pcie_get_upstream_rcb(dev);
+
+		clear = ~hpp->pci_exp_lnkctl_and;
+		set = hpp->pci_exp_lnkctl_or;
+		if (!us_rcb)
+			set &= ~PCI_EXP_LNKCTL_RCB;
+
 		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
-			~hpp->pci_exp_lnkctl_and, hpp->pci_exp_lnkctl_or);
+						  clear, set);
+	}
 
 	/* Find Advanced Error Reporting Enhanced Capability */
 	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-- 
1.8.5.6

