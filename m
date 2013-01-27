Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31216 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3A0TYc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:32 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 16/22] PCI, arm: Kill pci_root_buses
Date: Sun, 27 Jan 2013 11:23:43 -0800
Message-Id: <1359314629-18651-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version iteration.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/kernel/bios32.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 9b72261..d0befe4 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -57,13 +57,10 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
 
 void pcibios_report_status(u_int status_mask, int warn)
 {
-	struct list_head *l;
+	struct pci_host_bridge *host_bridge = NULL;
 
-	list_for_each(l, &pci_root_buses) {
-		struct pci_bus *bus = pci_bus_b(l);
-
-		pcibios_bus_report_status(bus, status_mask, warn);
-	}
+	for_each_pci_host_bridge(host_bridge)
+		pcibios_bus_report_status(host_bridge->bus, status_mask, warn);
 }
 
 /*
-- 
1.7.10.4

