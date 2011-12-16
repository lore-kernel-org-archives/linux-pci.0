Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:44687 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760898Ab1LPWbu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:31:50 -0500
Received: by yenm5 with SMTP id m5so459948yen.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:31:50 -0800 (PST)
Subject: [PATCH 4/6] sunhme/PCI: use list_for_each_entry() for bus->devices
	traversal
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Date: Fri, 16 Dec 2011 15:31:49 -0700
Message-ID: <20111216223149.5963.61942.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace open-coded list traversal with list_for_each_entry().

CC: David S. Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/sun/sunhme.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index cf14ab9..1d00a4c 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -2849,7 +2849,7 @@ err_out:
 static int is_quattro_p(struct pci_dev *pdev)
 {
 	struct pci_dev *busdev = pdev->bus->self;
-	struct list_head *tmp;
+	struct pci_dev *this_pdev;
 	int n_hmes;
 
 	if (busdev == NULL ||
@@ -2858,15 +2858,10 @@ static int is_quattro_p(struct pci_dev *pdev)
 		return 0;
 
 	n_hmes = 0;
-	tmp = pdev->bus->devices.next;
-	while (tmp != &pdev->bus->devices) {
-		struct pci_dev *this_pdev = pci_dev_b(tmp);
-
+	list_for_each_entry(this_pdev, &pdev->bus->devices, bus_list) {
 		if (this_pdev->vendor == PCI_VENDOR_ID_SUN &&
 		    this_pdev->device == PCI_DEVICE_ID_SUN_HAPPYMEAL)
 			n_hmes++;
-
-		tmp = tmp->next;
 	}
 
 	if (n_hmes != 4)

