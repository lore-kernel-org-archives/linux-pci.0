Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42967 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab2IYI07 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:59 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 25/29] PCI, microblaze: kill pci_root_buses in resources reservations
Date: Tue, 25 Sep 2012 01:26:26 -0700
Message-Id: <1348561590-28067-26-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: microblaze-uclinux@itee.uq.edu.au
---
 arch/microblaze/pci/pci-common.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 4dbb505..a82e215 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1323,13 +1323,13 @@ static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
 
 void __init pcibios_resource_survey(void)
 {
-	struct pci_bus *b;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	/* Allocate and assign resources. If we re-assign everything, then
 	 * we skip the allocate phase
 	 */
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_allocate_bus_resources(b);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_allocate_bus_resources(host_bridge->bus);
 
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
@@ -1338,8 +1338,8 @@ void __init pcibios_resource_survey(void)
 	 * the low IO area and the VGA memory area if they intersect the
 	 * bus available resources to avoid allocating things on top of them
 	 */
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_reserve_legacy_regions(b);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_reserve_legacy_regions(host_bridge->bus);
 
 	/* Now proceed to assigning things that were left unassigned */
 	pr_debug("PCI: Assigning unassigned resources...\n");
-- 
1.7.7

