Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeDYFQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Apr 2018 01:16:41 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc: sstabellini@kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/13] arm: don't build swiotlb by default
Date: Wed, 25 Apr 2018 07:15:36 +0200
Message-Id: <20180425051539.1989-11-hch@lst.de>
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

swiotlb is only used as a library of helper for xen-swiotlb if Xen support
is enabled on arm, so don't build it by default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aa1c187d756d..90b81a3a28a7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1774,7 +1774,7 @@ config SECCOMP
 	  defined by each seccomp mode.
 
 config SWIOTLB
-	def_bool y
+	bool
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
@@ -1807,6 +1807,7 @@ config XEN
 	depends on MMU
 	select ARCH_DMA_ADDR_T_64BIT
 	select ARM_PSCI
+	select SWIOTLB
 	select SWIOTLB_XEN
 	select PARAVIRT
 	help
-- 
2.17.0
