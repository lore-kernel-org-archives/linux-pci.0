Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37606 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3A0Fh4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 00:37:56 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 07/22] PCI: Kill pci_find_next_bus in pci_sysfs
Date: Sat, 26 Jan 2013 21:36:28 -0800
Message-Id: <1359265003-16166-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9c6e9bb..6f41daf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -289,15 +289,15 @@ static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 				size_t count)
 {
 	unsigned long val;
-	struct pci_bus *b = NULL;
+	struct pci_host_bridge *host_bridge = NULL;
 
 	if (strict_strtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	if (val) {
 		mutex_lock(&pci_remove_rescan_mutex);
-		while ((b = pci_find_next_bus(b)) != NULL)
-			pci_rescan_bus(b);
+		for_each_pci_host_bridge(host_bridge)
+			pci_rescan_bus(host_bridge->bus);
 		mutex_unlock(&pci_remove_rescan_mutex);
 	}
 	return count;
-- 
1.7.10.4

