Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:23755 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbbCICnO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Mar 2015 22:43:14 -0400
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
	"Yijing Wang" <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 18/30] PCI: Remove weak pcibios_root_bridge_prepare()
Date: Mon, 9 Mar 2015 10:34:15 +0800
Message-ID: <1425868467-9667-19-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now no one use weak pcibios_root_bridge_prepare(),
we could remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   16 +---------------
 include/linux/pci.h |    2 --
 2 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 99f17e3..1080eff 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1845,18 +1845,6 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 
-/**
- * pcibios_root_bridge_prepare - Platform-specific host bridge setup.
- * @bridge: Host bridge to set up.
- *
- * Default empty implementation.  Replace with an architecture-specific setup
- * routine, if necessary.
- */
-int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	return 0;
-}
-
 void __weak pcibios_add_bus(struct pci_bus *bus)
 {
 }
@@ -1889,11 +1877,9 @@ static struct pci_bus *__pci_create_root_bus(
 
 	bridge->bus = b;
 	b->bridge = get_device(&bridge->dev);
+
 	if (bridge->ops && bridge->ops->set_root_bus_speed)
 		bridge->ops->set_root_bus_speed(bridge);
-	error = pcibios_root_bridge_prepare(bridge);
-	if (error)
-		goto err_out;
 
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 28eafb5..cfaf217 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -424,8 +424,6 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
-
 /*
  * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
  * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
-- 
1.7.1

