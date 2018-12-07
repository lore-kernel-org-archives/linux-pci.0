Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D01C65BAF
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBD12083D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 19:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NFDtF6J/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBD12083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeLGTIi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:08:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLGTIh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 14:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0D1hBxhqw3BrFVKVEInQ7lG9SDadKMOAuajkRFtQtQc=; b=NFDtF6J/Z7IsRRA/i9SNua+O9R
        qLpQThw/W5x5aJS4snqW2H+p1RzdiNPHD1sR6XRd+sLY6H4qqcpxDwzTESHOgvLcy5XlIIIBjsfuP
        5J5SpboKfl5EileV0TqVoBg6GYrG0bBeEbZwDBTls1ytnuTmGUPq/halcZgpRMoRNETFTRTF1qc1h
        cIatmNCGtD+5bLX851TtpXQDa4Ys/dR21M8DW4CSTPQVT9uySIiKNyMMYIlOF5laKAXCRfTJO8bDP
        fPUX9KPdu1W3mFxa9XZGxNoOC9xRX2DoRLKsw8RnGTpoweZpxsqmchN29FdrjI2OAT21GrHLfv34u
        /uqsxEvA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVLU9-0006vJ-HZ; Fri, 07 Dec 2018 19:08:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] dma-mapping: always build the direct mapping code
Date:   Fri,  7 Dec 2018 11:07:16 -0800
Message-Id: <20181207190720.18517-12-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207190720.18517-1-hch@lst.de>
References: <20181207190720.18517-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All architectures except for sparc64 use the dma-direct code in some
form, and even for sparc64 we had the discussion of a direct mapping
mode a while ago.  In preparation for directly calling the direct
mapping code don't bother having it optionally but always build the
code in.  This is a minor hardship for some powerpc and arm configs
that don't pull it in yet (although they should in a relase ot two),
and sparc64 which currently doesn't need it at all, but it will
reduce the ifdef mess we'd otherwise need significantly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig      | 1 -
 arch/arc/Kconfig        | 1 -
 arch/arm/Kconfig        | 1 -
 arch/arm64/Kconfig      | 1 -
 arch/c6x/Kconfig        | 1 -
 arch/csky/Kconfig       | 1 -
 arch/h8300/Kconfig      | 1 -
 arch/hexagon/Kconfig    | 1 -
 arch/m68k/Kconfig       | 1 -
 arch/microblaze/Kconfig | 1 -
 arch/mips/Kconfig       | 1 -
 arch/nds32/Kconfig      | 1 -
 arch/nios2/Kconfig      | 1 -
 arch/openrisc/Kconfig   | 1 -
 arch/parisc/Kconfig     | 1 -
 arch/riscv/Kconfig      | 1 -
 arch/s390/Kconfig       | 1 -
 arch/sh/Kconfig         | 1 -
 arch/sparc/Kconfig      | 1 -
 arch/unicore32/Kconfig  | 1 -
 arch/x86/Kconfig        | 1 -
 arch/xtensa/Kconfig     | 1 -
 kernel/dma/Kconfig      | 7 -------
 kernel/dma/Makefile     | 3 +--
 24 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index a7e748a46c18..5da6ff54b3e7 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -203,7 +203,6 @@ config ALPHA_EIGER
 config ALPHA_JENSEN
 	bool "Jensen"
 	depends on BROKEN
-	select DMA_DIRECT_OPS
 	help
 	  DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
 	  of the first-generation Alpha systems. A number of these systems
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index fd48d698da29..7deaabeb531a 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -17,7 +17,6 @@ config ARC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a858ee791ef0..586fc30b23bd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,7 +30,6 @@ config ARM
 	select CLONE_BACKWARDS
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select DMA_DIRECT_OPS if !MMU
 	select DMA_REMAP if MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 06cf0ef24367..2092080240b0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -80,7 +80,6 @@ config ARM64
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select CRC32
 	select DCACHE_WORD_ACCESS
-	select DMA_DIRECT_OPS
 	select DMA_DIRECT_REMAP
 	select EDAC_SUPPORT
 	select FRAME_POINTER
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 84420109113d..456e154674d1 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -9,7 +9,6 @@ config C6X
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLKDEV_LOOKUP
-	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index ea74f3a9eeaf..37bed8aadf95 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -7,7 +7,6 @@ config CSKY
 	select COMMON_CLK
 	select CLKSRC_MMIO
 	select CLKSRC_OF
-	select DMA_DIRECT_OPS
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index d19c6b16cd5d..6472a0685470 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -22,7 +22,6 @@ config H8300
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_HASH
 	select CPU_NO_EFFICIENT_FFS
-	select DMA_DIRECT_OPS
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 2b688af379e6..d71036c598de 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -31,7 +31,6 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
-	select DMA_DIRECT_OPS
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 1bc9f1ba759a..8a5868e9a3a0 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -26,7 +26,6 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
-	select DMA_DIRECT_OPS if HAS_DMA
 	select ARCH_DISCARD_MEMBLOCK
 
 config CPU_BIG_ENDIAN
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index effed2efd306..eda9e2315ef5 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -12,7 +12,6 @@ config MICROBLAZE
 	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
-	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..2993aa9842c0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -16,7 +16,6 @@ config MIPS
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select CPU_PM if CPU_IDLE
-	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 7a04adacb2f0..1af6bbae7220 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -11,7 +11,6 @@ config NDS32
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 7e95506e957a..f6c4b0f49997 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -4,7 +4,6 @@ config NIOS2
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_SWAP
-	select DMA_DIRECT_OPS
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 285f7d05c8ed..d0feebad5a8f 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,7 +7,6 @@
 config OPENRISC
 	def_bool y
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select DMA_DIRECT_OPS
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 428ee50fc3db..6e1b71da0e71 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -185,7 +185,6 @@ config PA11
 	depends on PA7000 || PA7100LC || PA7200 || PA7300LC
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select DMA_DIRECT_OPS
 	select DMA_NONCOHERENT_CACHE_SYNC
 
 config PREFETCH
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 55da93f4e818..51d89c4b1dca 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,7 +19,6 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_DIRECT_OPS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_SHOW
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5624e8607054..21d271d04ca6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -139,7 +139,6 @@ config S390
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
-	select DMA_DIRECT_OPS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f82a4da7adf3..10fd4e9c454b 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -7,7 +7,6 @@ config SUPERH
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_PATA_PLATFORM
 	select CLKDEV_LOOKUP
-	select DMA_DIRECT_OPS
 	select HAVE_IDE if HAS_IOPORT_MAP
 	select HAVE_MEMBLOCK_NODE_MAP
 	select ARCH_DISCARD_MEMBLOCK
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8853b6ceae17..f5bb9ded1d18 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -48,7 +48,6 @@ config SPARC
 config SPARC32
 	def_bool !64BIT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
-	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index a4c05159dca5..2681027d7bff 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -4,7 +4,6 @@ config UNICORE32
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
-	select DMA_DIRECT_OPS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index adc845b66f01..c14d4a35be13 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -89,7 +89,6 @@ config X86
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
-	select DMA_DIRECT_OPS
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 75488b606edc..36338e7564a3 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -9,7 +9,6 @@ config XTENSA
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_DIRECT_OPS
 	select DMA_REMAP if MMU
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 41c3b1df70eb..ca88b867e7fe 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -35,13 +35,8 @@ config ARCH_HAS_DMA_COHERENT_TO_PFN
 config ARCH_HAS_DMA_MMAP_PGPROT
 	bool
 
-config DMA_DIRECT_OPS
-	bool
-	depends on HAS_DMA
-
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
-	depends on DMA_DIRECT_OPS
 
 config DMA_VIRT_OPS
 	bool
@@ -49,7 +44,6 @@ config DMA_VIRT_OPS
 
 config SWIOTLB
 	bool
-	select DMA_DIRECT_OPS
 	select NEED_DMA_MAP_STATE
 
 config DMA_REMAP
@@ -58,5 +52,4 @@ config DMA_REMAP
 
 config DMA_DIRECT_REMAP
 	bool
-	depends on DMA_DIRECT_OPS
 	select DMA_REMAP
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index f4feeceb8020..a626f643cd63 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_HAS_DMA)			+= mapping.o
+obj-$(CONFIG_HAS_DMA)			+= mapping.o direct.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += coherent.o
-obj-$(CONFIG_DMA_DIRECT_OPS)		+= direct.o
 obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
-- 
2.19.1

