Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:48860 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbcDPBfy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2016 21:35:54 -0400
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] device: Add irq affinity hint cpumask pointer
Date: Fri, 15 Apr 2016 18:35:45 -0700
Message-Id: <1460770552-31260-2-git-send-email-hch@lst.de>
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

This optional cpumask will be used by the irq core code to optimize interrupt
allocation and affinity setup for multiqueue devices.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/device.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 002c597..0270103 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -741,6 +741,8 @@ struct device_dma_parameters {
  * @msi_list:	Hosts MSI descriptors
  * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
+ * @irq_affinity: Hint for irq affinities and descriptor allocation
+ *		  (optional).
  * @dma_mask:	Dma mask (if dma'ble device).
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
  * 		hardware supports 64-bit addresses for consistent allocations
@@ -813,6 +815,8 @@ struct device {
 #ifdef CONFIG_NUMA
 	int		numa_node;	/* NUMA node this device is close to */
 #endif
+
+	struct cpumask	*irq_affinity;
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
 					     alloc_coherent mappings as
-- 
2.1.4

