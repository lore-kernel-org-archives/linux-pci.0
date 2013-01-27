Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:32341 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab3A0TYc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:32 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Michal Simek <monstr@monstr.eu>,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH v3 18/22] PCI, microblaze: Kill pci_root_buses in resources reservations
Date: Sun, 27 Jan 2013 11:23:45 -0800
Message-Id: <1359314629-18651-19-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: microblaze-uclinux@itee.uq.edu.au
---
 arch/microblaze/pci/pci-common.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index a1c5b99..51f6651 100644
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
1.7.10.4

