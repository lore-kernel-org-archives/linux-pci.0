Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35232 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbbFJSsO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2015 14:48:14 -0400
Received: by iesa3 with SMTP id a3so40575737ies.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2015 11:48:14 -0700 (PDT)
Subject: [PATCH] PCI/ASPM: Simplify Clock Power Management setting
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joe Lawrence <joe.lawrence@stratus.com>,
	Matthew Garrett <mjg59@coreos.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Chris J Arges <chris.j.arges@canonical.com>
Date: Wed, 10 Jun 2015 13:48:11 -0500
Message-ID: <20150610184811.9459.82796.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update the Link Control Enable Clock Power Management bit the same
way we update the ASPM Control bits, with a single call of
pcie_capability_clear_and_set_word().

No functional change; this just makes both paths use the same style.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7d4fcdc..29ab40c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -127,15 +127,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
 {
 	struct pci_dev *child;
 	struct pci_bus *linkbus = link->pdev->subordinate;
+	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
 
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		if (enable)
-			pcie_capability_set_word(child, PCI_EXP_LNKCTL,
-						 PCI_EXP_LNKCTL_CLKREQ_EN);
-		else
-			pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_CLKREQ_EN);
-	}
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CLKREQ_EN,
+						   val);
 	link->clkpm_enabled = !!enable;
 }
 

