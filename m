Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:41375 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab3EFNpd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 May 2013 09:45:33 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 6 May 2013 07:45:32 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 592613E40052
	for <linux-pci@vger.kernel.org>; Mon,  6 May 2013 07:44:28 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r46DiZgN117414
	for <linux-pci@vger.kernel.org>; Mon, 6 May 2013 07:44:35 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r46DiWvX012346
	for <linux-pci@vger.kernel.org>; Mon, 6 May 2013 07:44:35 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: benh@kernel.crashing.org, yinghai@kernel.org, bhelgaas@google.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/powernv: Don't configure IO window on PHB3
Date: Mon,  6 May 2013 21:44:18 +0800
Message-Id: <1367847858-6506-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1367847858-6506-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We needn't configure IO windows for the corresponding PEs on PHB3
since that doesn't support IO.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0c3fa29..b4f3edb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -894,7 +894,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
 		    res->start > res->end)
 			continue;
 
-		if (res->flags & IORESOURCE_IO) {
+		/* We needn't setup IO windows for PHB3 */
+		if (!(pe->pbus->bus_flags & PCI_BUS_FLAGS_NO_IO) &&
+		    res->flags & IORESOURCE_IO) {
 			region.start = res->start - phb->ioda.io_pci_base;
 			region.end   = res->end - phb->ioda.io_pci_base;
 			index = region.start / phb->ioda.io_segsize;
-- 
1.7.5.4

