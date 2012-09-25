Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:42836 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab2IYI0r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:26:47 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	x86@kernel.org
Subject: [PATCH 17/29] PCI, x86: kill pci_root_buses in resources reservations
Date: Tue, 25 Sep 2012 01:26:18 -0700
Message-Id: <1348561590-28067-18-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/pci/i386.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 42dd755..c5055b8 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -332,11 +332,11 @@ static void __init pcibios_allocate_rom_resources(struct pci_bus *bus)
 
 static int __init pcibios_assign_resources(void)
 {
-	struct pci_bus *bus;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	if (!(pci_probe & PCI_ASSIGN_ROMS))
-		list_for_each_entry(bus, &pci_root_buses, node)
-			pcibios_allocate_rom_resources(bus);
+		for_each_pci_host_bridge(host_bridge)
+			pcibios_allocate_rom_resources(host_bridge->bus);
 
 	pci_assign_unassigned_resources();
 	pcibios_fw_addr_list_del();
@@ -346,17 +346,17 @@ static int __init pcibios_assign_resources(void)
 
 void __init pcibios_resource_survey(void)
 {
-	struct pci_bus *bus;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	DBG("PCI: Allocating resources\n");
 
-	list_for_each_entry(bus, &pci_root_buses, node)
-		pcibios_allocate_bus_resources(bus);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_allocate_bus_resources(host_bridge->bus);
 
-	list_for_each_entry(bus, &pci_root_buses, node)
-		pcibios_allocate_resources(bus, 0);
-	list_for_each_entry(bus, &pci_root_buses, node)
-		pcibios_allocate_resources(bus, 1);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_allocate_resources(host_bridge->bus, 0);
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_allocate_resources(host_bridge->bus, 1);
 
 	e820_reserve_resources_late();
 	/*
-- 
1.7.7

