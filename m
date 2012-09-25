Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:43282 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2IYI1f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:27:35 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 27/29] PCI, powerpc: kill pci_root_buses in resources reservations
Date: Tue, 25 Sep 2012 01:26:28 -0700
Message-Id: <1348561590-28067-28-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/pci-common.c |   13 ++++++-------
 arch/powerpc/kernel/pci_64.c     |    7 ++++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 43fea54..1e13133 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1390,11 +1390,11 @@ static void __init pcibios_reserve_legacy_regions(struct pci_bus *bus)
 
 void __init pcibios_resource_survey(void)
 {
-	struct pci_bus *b;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	/* Allocate and assign resources */
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_allocate_bus_resources(b);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_allocate_bus_resources(host_bridge->bus);
 	pcibios_allocate_resources(0);
 	pcibios_allocate_resources(1);
 
@@ -1402,10 +1402,9 @@ void __init pcibios_resource_survey(void)
 	 * the low IO area and the VGA memory area if they intersect the
 	 * bus available resources to avoid allocating things on top of them
 	 */
-	if (!pci_has_flag(PCI_PROBE_ONLY)) {
-		list_for_each_entry(b, &pci_root_buses, node)
-			pcibios_reserve_legacy_regions(b);
-	}
+	if (!pci_has_flag(PCI_PROBE_ONLY))
+		for_each_pci_host_bridge(host_bridge)
+			pcibios_reserve_legacy_regions(host_bridge);
 
 	/* Now, if the platform didn't decide to blindly trust the firmware,
 	 * we proceed to assigning things that were left unassigned
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 4ff190f..dafa7c5 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -213,8 +213,9 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 {
 	struct pci_controller* hose;
 	struct list_head *ln;
-	struct pci_bus *bus = NULL;
+	struct pci_bus *bus;
 	struct device_node *hose_node;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	/* Argh ! Please forgive me for that hack, but that's the
 	 * simplest way to get existing XFree to not lockup on some
@@ -234,8 +235,8 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
 	 * used on pre-domains setup. We return the first match
 	 */
 
-	for (ln = pci_root_buses.next; ln != &pci_root_buses; ln = ln->next) {
-		bus = pci_bus_b(ln);
+	for_each_pci_host_bridge(host_bridge) {
+		bus = host_bridge->bus;
 		if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
 			break;
 		bus = NULL;
-- 
1.7.7

