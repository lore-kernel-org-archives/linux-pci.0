Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47495 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3A0Fhr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 00:37:47 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 06/22] PCI, hotplug: Kill pci_find_next_bus in sgi_hotplug
Date: Sat, 26 Jan 2013 21:36:27 -0800
Message-Id: <1359265003-16166-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/hotplug/sgi_hotplug.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index 180e760..ea81618 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -669,7 +669,7 @@ alloc_err:
 
 static int __init sn_pci_hotplug_init(void)
 {
-	struct pci_bus *pci_bus = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
 	int rc;
 	int registered = 0;
 
@@ -681,7 +681,9 @@ static int __init sn_pci_hotplug_init(void)
 
 	INIT_LIST_HEAD(&sn_hp_list);
 
-	while ((pci_bus = pci_find_next_bus(pci_bus))) {
+	for_each_pci_host_bridge(host_bridge) {
+		struct pci_bus *pci_bus = host_bridge->bus;
+
 		if (!pci_bus->sysdata)
 			continue;
 
-- 
1.7.10.4

