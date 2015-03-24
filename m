Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:15171 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbbCXDhT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Mar 2015 23:37:19 -0400
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
	Yijing Wang <wangyijing0307@gmail.com>
Subject: [PATCH v8 08/30] PCI: Update pci_host_bridge bus resource
Date: Tue, 24 Mar 2015 11:34:02 +0800
Message-ID: <1427168064-8657-9-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yijing Wang <wangyijing0307@gmail.com>

Sometimes, the bus resource start number is not equal to
root bus number. For example, in pci_scan_bus(), we always
add the default bus resource which start bus number is 0,
but the root bus number callers given may != 0, so
we need to update pci_host_bridge bus resource, because we
would check whether host bridge bus resoruce is confict
in later patch.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host-bridge.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index ecc1a7c..1a9834b 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -26,8 +26,11 @@ static void pci_host_update_busn_res(
 	struct resource_entry *window;
 
 	resource_list_for_each_entry(window, resources)
-		if (window->res->flags & IORESOURCE_BUS)
+		if (window->res->flags & IORESOURCE_BUS) {
+			if (bus > window->res->start)
+				window->res->start = bus;
 			return;
+		}
 
 	pr_info(
 	 "No busn resource found for pci%04x:%02x, will use [bus %02x-ff]\n",
-- 
1.7.1

