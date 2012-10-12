Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59788 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab2JLFfz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Oct 2012 01:35:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2496249pad.19
        for <linux-pci@vger.kernel.org>; Thu, 11 Oct 2012 22:35:55 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [PATCH 2/3] PCI: Fix comment syntax
Date: Thu, 11 Oct 2012 22:35:54 -0700
Message-Id: <1350020155-3782-3-git-send-email-jdmason@kudzu.us>
In-Reply-To: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
References: <1350020155-3782-1-git-send-email-jdmason@kudzu.us>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Correct minor wording issue in MPS Peer-to-peer comment.

Noticed by Don Dutile

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/pci/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6b672c1..5a18652 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1581,7 +1581,7 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
 	 */
 	case PCIE_BUS_PERFORMANCE:
 	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
-	 * to be aware to the MPS of the destination.  To work around this,
+	 * to be aware of the MPS of the destination.  To work around this,
 	 * simply force the MPS of the entire system to the smallest possible.
 	 */
 	case PCIE_BUS_PEER2PEER:
-- 
1.7.9.5

