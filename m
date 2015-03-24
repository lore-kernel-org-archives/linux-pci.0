Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:14761 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbCXDhN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 23:37:13 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang Liu <jiang.liu@linux.intel.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Russell King <linux@arm.linux.org.uk>, <x86@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Guan Xuetao" <gxt@mprc.pku.edu.cn>, <linux-alpha@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, Liviu Dudau <liviu@dudau.co.uk>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Yijing Wang" <wangyijing@huawei.com>
Subject: [PATCH v8 02/30] PCI: Remove deprecated pci_scan_bus_parented()
Date: Tue, 24 Mar 2015 11:33:56 +0800
Message-ID: <1427168064-8657-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No one uses pci_scan_bus_parented() any more,
remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   19 -------------------
 include/linux/pci.h |    2 --
 2 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8ef0375..699a238 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2091,25 +2091,6 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 }
 EXPORT_SYMBOL(pci_scan_root_bus);
 
-/* Deprecated; use pci_scan_root_bus() instead */
-struct pci_bus *pci_scan_bus_parented(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata)
-{
-	LIST_HEAD(resources);
-	struct pci_bus *b;
-
-	pci_add_resource(&resources, &ioport_resource);
-	pci_add_resource(&resources, &iomem_resource);
-	pci_add_resource(&resources, &busn_resource);
-	b = pci_create_root_bus(parent, bus, ops, sysdata, &resources);
-	if (b)
-		pci_scan_child_bus(b);
-	else
-		pci_free_resource_list(&resources);
-	return b;
-}
-EXPORT_SYMBOL(pci_scan_bus_parented);
-
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
 					void *sysdata)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..36effb8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -769,8 +769,6 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 void pcibios_scan_specific_bus(int busn);
 struct pci_bus *pci_find_bus(int domain, int busnr);
 void pci_bus_add_devices(const struct pci_bus *bus);
-struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus,
-				      struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 				    struct pci_ops *ops, void *sysdata,
-- 
1.7.1

