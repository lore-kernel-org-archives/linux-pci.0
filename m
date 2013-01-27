Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:38264 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3A0TYT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:19 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	x86@kernel.org
Subject: [PATCH v3 10/22] PCI, x86: Kill pci_root_buses in resources reservations
Date: Sun, 27 Jan 2013 11:23:37 -0800
Message-Id: <1359314629-18651-11-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version for iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/pci/i386.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 94919e3..b13e0af 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -340,11 +340,11 @@ static void pcibios_allocate_rom_resources(struct pci_bus *bus)
 
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
@@ -367,17 +367,17 @@ void pcibios_resource_survey_bus(struct pci_bus *bus)
 
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
1.7.10.4

