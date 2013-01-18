Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailhub5.stratus.com ([134.111.1.18]:58603 "EHLO
	mailhub5.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab3ARTIL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2013 14:08:11 -0500
Date: Fri, 18 Jan 2013 13:23:55 -0500 (EST)
From: Joe Lawrence <Joe.Lawrence@stratus.com>
To: Joe Lawrence <Joe.Lawrence@stratus.com>
cc: linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Subject: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
In-Reply-To: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
Message-ID: <alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 3a51bbad5555ba6c6e144aa5176c8112eb449325 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@stratus.com>
Date: Tue, 15 Jan 2013 14:51:57 -0500
Subject: [PATCH 1/2] PCI: ASPM exit link state code could skip devices

On PCI bus hotplug removal, pcie_aspm_exit_link_state could potentially skip
parent devices that have link_state allocated.  Instead of exiting early if
a given device is not PCIe, check that the device's parent is PCIe.  This
enables pcie_aspm_exit_link_state to properly clean up parent link_state when
the last function in a slot might not be PCIe.

Reviewed-by: David Bulkow <david.bulkow@stratus.com>
Signed-off-by: Joe Lawrence <joe.lawrence@stratus.com>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index b52630b..6122447 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -634,7 +634,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	struct pci_dev *parent = pdev->bus->self;
 	struct pcie_link_state *link, *root, *parent_link;
 
-	if (!pci_is_pcie(pdev) || !parent || !parent->link_state)
+	if (!parent || !pci_is_pcie(parent) || !parent->link_state)
 		return;
 	if ((pci_pcie_type(parent) != PCI_EXP_TYPE_ROOT_PORT) &&
 	    (pci_pcie_type(parent) != PCI_EXP_TYPE_DOWNSTREAM))
-- 
1.8.0.2

