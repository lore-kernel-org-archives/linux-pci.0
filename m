Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50031 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933113AbcKGSrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2016 13:47:47 -0500
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] pci: Remove the irq_affinity mask from struct pci_dev
Date: Mon,  7 Nov 2016 10:47:41 -0800
Message-Id: <1478544462-9549-7-git-send-email-hch@lst.de>
In-Reply-To: <1478544462-9549-1-git-send-email-hch@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This has never been used, and now is totally unreferenced.  Nuke it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7090f5f..f2ba6ac 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -333,7 +333,6 @@ struct pci_dev {
 	 * directly, use the values stored here. They might be different!
 	 */
 	unsigned int	irq;
-	struct cpumask	*irq_affinity;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
 	bool match_driver;		/* Skip attaching driver */
-- 
2.1.4

