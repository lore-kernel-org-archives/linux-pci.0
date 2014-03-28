Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52527 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaC1TNz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Mar 2014 15:13:55 -0400
From: Ryan Desfosses <ryan@desfo.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ryan Desfosses <ryan@desfo.org>
Subject: [PATCH] pci: changed '...pci_bus* bus' to '...pci_bus *bus'
Date: Fri, 28 Mar 2014 15:13:38 -0400
Message-Id: <1396034018-5645-1-git-send-email-ryan@desfo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

   change made to resolve following checkpatch message:
       drivers/pci/pci.c:109: ERROR: "foo* bar" should be "foo *bar"
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fdbc294..a50d542 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -106,7 +106,7 @@ static bool pcie_ari_disabled;
  * Given a PCI bus, returns the highest PCI bus number present in the set
  * including the given PCI bus and its list of child PCI buses.
  */
-unsigned char pci_bus_max_busnr(struct pci_bus* bus)
+unsigned char pci_bus_max_busnr(struct pci_bus *bus)
 {
 	struct list_head *tmp;
 	unsigned char max, n;
-- 
1.9.1

