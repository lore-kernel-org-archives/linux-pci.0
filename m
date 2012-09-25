Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:38999 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab2IYI1F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 04:27:05 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 23/29] PCI, arm: kill pci_root_buses
Date: Tue, 25 Sep 2012 01:26:24 -0700
Message-Id: <1348561590-28067-24-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/kernel/bios32.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 9cf16b8..83b7cdc 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -56,13 +56,10 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
 
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
1.7.7

