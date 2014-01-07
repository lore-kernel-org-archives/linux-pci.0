Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:14880
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753868AbaAGIHZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2014 03:07:25 -0500
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <bhelgaas@google.com>, <rjw@rjwysocki.net>
CC: <scottwood@freescale.com>, <galak@codeaurora.org>,
	<roy.zang@freescale.com>, <linux-pci@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: [PATCH 1/2] pci: Fix root port bus->self is NULL
Date: Tue, 7 Jan 2014 16:04:07 +0800
Message-ID: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

the root port bus->self always NULL, so put root port pci device
into root port bus->self.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 38e403d..7f2d1ab 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1472,6 +1472,9 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 	if (!dev->is_added)
 		nr++;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		bus->self = dev;
+
 	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
-- 
1.8.5


