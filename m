Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8597 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbbCWSJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Mar 2015 14:09:34 -0400
Date: Tue, 24 Mar 2015 02:08:59 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH pci] PCI: pci_find_host_bridge() can be static
Message-ID: <20150323180859.GA44683@snb>
References: <201503240247.Lu2Ttzhc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503240247.Lu2Ttzhc%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 host-bridge.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 8efb3a7..61171c4 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -144,7 +144,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
+static struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
