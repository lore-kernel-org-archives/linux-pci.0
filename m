Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47528 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3A0FiJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 00:38:09 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Doug Thompson <dougthompson@xmission.com>,
	linux-edac@vger.kernel.org
Subject: [PATCH v2 08/22] PCI, edac: Kill pci_find_next_bus in edac
Date: Sat, 26 Jan 2013 21:36:29 -0800
Message-Id: <1359265003-16166-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: linux-edac@vger.kernel.org
Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 drivers/edac/i7core_edac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 10c8c00..be6ef4f 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1294,10 +1294,10 @@ static void __init i7core_xeon_pci_fixup(const struct pci_id_table *table)
 static unsigned i7core_pci_lastbus(void)
 {
 	int last_bus = 0, bus;
-	struct pci_bus *b = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
 
-	while ((b = pci_find_next_bus(b)) != NULL) {
-		bus = b->number;
+	for_each_pci_host_bridge(host_bridge) {
+		bus = host_bridge->bus->number;
 		edac_dbg(0, "Found bus %d\n", bus);
 		if (bus > last_bus)
 			last_bus = bus;
-- 
1.7.10.4

