Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35472 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab3HUXjj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2013 19:39:39 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so2246903obc.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2013 16:39:39 -0700 (PDT)
Subject: [PATCH v7 4/5] PCI: Simplify MPS test for Downstream Port
To: Yijing Wang <wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>
Date: Wed, 21 Aug 2013 17:39:36 -0600
Message-ID: <20130821233936.2300.53720.stgit@bhelgaas-glaptop>
In-Reply-To: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
References: <20130821233722.2300.81773.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe hotplug bridges are always either Root Ports or Downstream Ports.  No
other device type can have a PCIe link leading downstream to a slot.

Root Ports don't have an upstream bridge, so "dev->is_hotplug_bridge &&
dev->bus->self" is true if and only if "dev" is a Downstream Port.  That
means we can simplify this by looking at the type of "dev" itself, without
looking upstream at all.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ecae7f2..0591b08 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1507,8 +1507,7 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
 	 * will occur as normal.
 	 */
 	if (dev->is_hotplug_bridge && (!list_is_singular(&dev->bus->devices) ||
-	     (dev->bus->self &&
-	      pci_pcie_type(dev->bus->self) != PCI_EXP_TYPE_ROOT_PORT)))
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT))
 		*smpss = 0;
 
 	if (*smpss > dev->pcie_mpss)

