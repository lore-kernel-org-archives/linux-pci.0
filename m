Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753927AbdGJMcg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 08:32:36 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] MIPS/PCI: Fix pcibios_scan_bus() NULL check code path
Date: Mon, 10 Jul 2017 13:34:09 +0100
Message-Id: <20170710123409.9043-2-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170710123409.9043-1-lorenzo.pieralisi@arm.com>
References: <20170710123409.9043-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If pci_scan_root_bus() fails (ie returns NULL) pcibios_scan_bus() must
return immediately since the struct pci_bus pointer it returns is not
valid and cannot be used.

Move code checking the pci_scan_root_bus() return value to reinstate
proper pcibios_scanbus() error path behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/mips/pci/pci-legacy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 174575a..71d62f8 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -89,16 +89,16 @@ static void pcibios_scanbus(struct pci_controller *hose)
 	pci_add_resource(&resources, hose->busn_resource);
 	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
 				&resources);
-	hose->bus = bus;
-
-	need_domain_info = need_domain_info || pci_domain_nr(bus);
-	set_pci_need_domain_info(hose, need_domain_info);
-
 	if (!bus) {
 		pci_free_resource_list(&resources);
 		return;
 	}
 
+	hose->bus = bus;
+
+	need_domain_info = need_domain_info || pci_domain_nr(bus);
+	set_pci_need_domain_info(hose, need_domain_info);
+
 	next_busno = bus->busn_res.end + 1;
 	/* Don't allow 8-bit bus number overflow inside the hose -
 	   reserve some space for bridges. */
-- 
2.10.0
