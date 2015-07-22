Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13593 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbGVVyJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:54:09 -0400
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
Subject: [PATCH v4 12/12] x86: declare support for DMA P2P
Date: Wed, 22 Jul 2015 16:39:57 -0500
Message-ID: <1437601197-6481-13-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use CONFIG_HAS_DMA_P2P to declare that we want the DMA peer resource APIs
enabled on x86, and provide the requisite dma_peer_mapping_error()
implementation.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/dma-mapping.h | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3dbb7e7..581d1ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,6 +149,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_DEV_DMA_OPS			if X86_64
 	select X86_FEATURE_NAMES		if PROC_FS
+	select HAS_DMA_P2P
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 1f5b728..64472d8 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -44,16 +44,30 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 #include <asm-generic/dma-mapping-common.h>
 
 /* Make sure we keep the same behaviour */
-static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+static inline int dma_mapping_error_common(struct device *dev, u64 dma_addr)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
-	debug_dma_mapping_error(dev, dma_addr);
 	if (ops->mapping_error)
 		return ops->mapping_error(dev, dma_addr);
 
 	return (dma_addr == DMA_ERROR_CODE);
 }
 
+static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	debug_dma_mapping_error(dev, dma_addr);
+	return dma_mapping_error_common(dev, (u64)dma_addr);
+}
+
+#ifdef CONFIG_HAS_DMA_P2P
+static inline int dma_peer_mapping_error(struct device *dev,
+					 dma_peer_addr_t dma_addr)
+{
+	debug_dma_peer_mapping_error(dev, dma_addr);
+	return dma_mapping_error_common(dev, (u64)dma_addr);
+}
+#endif
+
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
-- 
2.4.6

