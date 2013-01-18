Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailhub4.stratus.com ([134.111.1.17]:35604 "EHLO
	mailhub4.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab3ARTJ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2013 14:09:28 -0500
Date: Fri, 18 Jan 2013 13:24:55 -0500 (EST)
From: Joe Lawrence <Joe.Lawrence@stratus.com>
To: Joe Lawrence <Joe.Lawrence@stratus.com>
cc: linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Subject: [PATCH 2/2] PCI: Don't touch ASPM if forcibly disabled
In-Reply-To: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
Message-ID: <alpine.DEB.2.02.1301181324010.31163@jlaw-desktop.mno.stratus.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From 108cca7bee5b04f45d9712507d14b5f3fbc22c29 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@stratus.com>
Date: Tue, 15 Jan 2013 15:31:28 -0500
Subject: [PATCH 2/2] PCI: Don't touch ASPM if forcibly disabled

Don't allocate and track PCIe ASPM state when "pcie_aspm=off" is specified on
the kernel parameter list.

Based-on-patch-from: Matthew Garrett <mjg59@srcf.ucam.org>
Reviewed-by: David Bulkow <david.bulkow@stratus.com>
Signed-off-by: Joe Lawrence <joe.lawrence@stratus.com>
---
 drivers/pci/pcie/aspm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 6122447..f912a93 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -556,6 +556,9 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	struct pcie_link_state *link;
 	int blacklist = !!pcie_aspm_sanity_check(pdev);
 
+	if (!aspm_support_enabled)
+		return;
+
 	if (!pci_is_pcie(pdev) || pdev->link_state)
 		return;
 	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
-- 
1.8.0.2

