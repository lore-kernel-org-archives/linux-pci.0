Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:44687 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760914Ab1LPWbz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:31:55 -0500
Received: by mail-yx0-f202.google.com with SMTP id m5so459948yen.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:31:55 -0800 (PST)
Subject: [PATCH 5/6] de4x5/PCI: use list_for_each_entry() for bus->devices
	traversal
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Grant Grundler <grundler@parisc-linux.org>,
	netdev@vger.kernel.org
Date: Fri, 16 Dec 2011 15:31:54 -0700
Message-ID: <20111216223154.5963.39965.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace open-coded list traversal with list_for_each_entry().

CC: Grant Grundler <grundler@parisc-linux.org>
CC: netdev@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/dec/tulip/de4x5.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
index 871bcaa..3f5d3b9 100644
--- a/drivers/net/ethernet/dec/tulip/de4x5.c
+++ b/drivers/net/ethernet/dec/tulip/de4x5.c
@@ -2127,14 +2127,9 @@ srom_search(struct net_device *dev, struct pci_dev *pdev)
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     int i, j;
     struct de4x5_private *lp = netdev_priv(dev);
-    struct list_head *walk;
-
-    list_for_each(walk, &pdev->bus_list) {
-	struct pci_dev *this_dev = pci_dev_b(walk);
-
-	/* Skip the pci_bus list entry */
-	if (list_entry(walk, struct pci_bus, devices) == pdev->bus) continue;
+    struct pci_dev *this_dev;
 
+    list_for_each_entry(this_dev, &pdev->bus->devices, bus_list) {
 	vendor = this_dev->vendor;
 	device = this_dev->device << 8;
 	if (!(is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x)) continue;

