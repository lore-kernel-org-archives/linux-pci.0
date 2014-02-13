Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:43483 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbaBMNRa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 08:17:30 -0500
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Russell King <linux@arm.linux.org.uk>,
	David Airlie <airlied@linux.ie>,
	<dri-devel@lists.freedesktop.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<linux-pcmcia@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/6] PCI/arm: Use list_for_each_entry() for bus traversal
Date: Thu, 13 Feb 2014 21:13:59 +0800
Message-ID: <1392297243-61848-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace list_for_each() + pci_bus_b() with the simpler
list_for_each_entry().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/kernel/bios32.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 317da88..0a77858 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -57,13 +57,10 @@ static void pcibios_bus_report_status(struct pci_bus *bus, u_int status_mask, in
 
 void pcibios_report_status(u_int status_mask, int warn)
 {
-	struct list_head *l;
-
-	list_for_each(l, &pci_root_buses) {
-		struct pci_bus *bus = pci_bus_b(l);
+	struct pci_bus *bus;
 
+	list_for_each_entry(bus, &pci_root_buses, node)
 		pcibios_bus_report_status(bus, status_mask, warn);
-	}
 }
 
 /*
-- 
1.7.1


