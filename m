Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8726 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbbGVVyB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:54:01 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v4 02/12] linux/types.h: Add dma_peer_addr_t type
Date: Wed, 22 Jul 2015 16:39:47 -0500
Message-ID: <1437601197-6481-3-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On some platforms, a dma_addr_t is only 32 bits wide, but the bus addresses
can be 64 bits wide. For peer-to-peer DMA, a device needs to use the full
64-bit address. Therefore, introduce a DMA address type that is not
constrained by the CPU DMA address size.

This is only needed for peer-to-peer DMA, so guard this definition with a
CONFIG_HAS_DMA_P2P check.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 include/linux/types.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index 8715287..dd85173 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -140,13 +140,13 @@ typedef unsigned long blkcnt_t;
 #define pgoff_t unsigned long
 
 /*
- * A dma_addr_t can hold any valid DMA address, i.e., any address returned
+ * A dma_addr_t can hold any valid DMA address, i.e., most addresses returned
  * by the DMA API.
  *
  * If the DMA API only uses 32-bit addresses, dma_addr_t need only be 32
  * bits wide.  Bus addresses, e.g., PCI BARs, may be wider than 32 bits,
  * but drivers do memory-mapped I/O to ioremapped kernel virtual addresses,
- * so they don't care about the size of the actual bus addresses.
+ * so they don't care about the size of the actual bus addresses in most cases.
  */
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 dma_addr_t;
@@ -154,6 +154,15 @@ typedef u64 dma_addr_t;
 typedef u32 dma_addr_t;
 #endif
 
+/*
+ * Unlike dma_addr_t, a dma_peer_addr_t can hold any bus address for the
+ * platform. Drivers should only need this for peer-to-peer use cases, where
+ * the DMA target is also on the bus.
+ */
+#ifdef CONFIG_HAS_DMA_P2P
+typedef u64 dma_peer_addr_t;
+#endif
+
 typedef unsigned __bitwise__ gfp_t;
 typedef unsigned __bitwise__ fmode_t;
 typedef unsigned __bitwise__ oom_flags_t;
-- 
2.4.6

