Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EEEC04EBF
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244AC2245E
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOHK68Ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244AC2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbeKPFPQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:15:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388928AbeKPFPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 00:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v7wXLeFtkaAp7mc6Jbsv0ZZ51efz+b8f/3q39LoAxBk=; b=HOHK68UlsgOaULnSRfyxEZ8yD6
        S8bZkOXbf7SiYvFMngPlwTNtFdzjGrLgPPDFpvcILIAZH5VIKh7HgRZqqra9/2YdSc6VO/JlYtdJH
        5CuAY45cqy1/cSqPBVeEGfa1P6MSCNqGO1LOgeXdpXkKwh/JR69r90+iYc0AASp8RQ0LdURDF9Bb7
        XlkvYyWkMiGFaxKAVwTE7PbUG+BOgG6UpaxlK/FxjOrvicsAZgFK2Zx9ZUHhXDzX4COx/5CbMuW1R
        GBZxzlsviCkRx79xdYlWoyIslbed742FMiBZb0hgeBxQLohCXa9AgYMW7YHYt8DcTS5mKKBB6Azej
        WLV1DQNg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNMxu-0006Gx-Da; Thu, 15 Nov 2018 19:06:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 8/9] rapidio: consolidate RAPIDIO config entry in drivers/rapidio
Date:   Thu, 15 Nov 2018 20:05:36 +0100
Message-Id: <20181115190538.17016-9-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115190538.17016-1-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no good reason to duplicate the RAPIDIO menu in various
architectures.  Instead provide a selectable HAVE_RAPIDIO symbol
that indicates native availability of RAPIDIO support and the handle
the rest in drivers/pci.  This also means we now provide support
for PCI(e) to Rapidio bridges for every architecture instead of a
limited subset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig                   | 15 +--------------
 arch/powerpc/Kconfig                | 14 +-------------
 arch/powerpc/platforms/85xx/Kconfig |  8 ++++----
 arch/powerpc/platforms/86xx/Kconfig |  4 ++--
 arch/x86/Kconfig                    |  9 ---------
 drivers/Kconfig                     |  1 +
 drivers/rapidio/Kconfig             | 11 +++++++++++
 7 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3912250ff813..67fbd4952ff4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -892,7 +892,7 @@ config CAVIUM_OCTEON_SOC
 	bool "Cavium Networks Octeon SoC based boards"
 	select CEVT_R4K
 	select ARCH_HAS_PHYS_TO_DMA
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select PHYS_ADDR_T_64BIT
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
@@ -3107,19 +3107,6 @@ config ZONE_DMA
 config ZONE_DMA32
 	bool
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
-
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config TRAD_SIGNALS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cc8435d87949..f2f70cc2bd44 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -939,26 +939,14 @@ config PCI_8260
 	select PPC_INDIRECT_PCI
 	default y
 
-config HAS_RAPIDIO
-	bool
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
-
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
-	depends on RAPIDIO = y && HAS_RAPIDIO
+	depends on RAPIDIO = y && HAVE_RAPIDIO
 	default "n"
 	---help---
 	  Include support for RapidIO controller on Freescale embedded
 	  processors (MPC8548, MPC8641, etc).
 
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config NONSTATIC_KERNEL
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index ba0ea84ce578..d1af0ee2f8c8 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -66,7 +66,7 @@ config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
 	select PPC_I8259
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	help
 	  This option enables support for the MPC85xx CDS board
 
@@ -74,7 +74,7 @@ config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
 	select PHYLIB if NETDEVICES
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select SWIOTLB
 	help
 	  This option enables support for the MPC85xx MDS board
@@ -219,7 +219,7 @@ config PPA8548
 	help
 	  This option enables support for the Prodrive PPA8548 board.
 	select DEFAULT_UIMAGE
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 
 config GE_IMP3A
 	bool "GE Intelligent Platforms IMP3A"
@@ -277,7 +277,7 @@ config CORENET_GENERIC
 	select SWIOTLB
 	select GPIOLIB
 	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
 	  This option enables support for the FSL CoreNet based boards.
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index a4fa31a40502..413837a63242 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -15,7 +15,7 @@ config MPC8641_HPCN
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select FSL_ULI1575 if PCI
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	select SWIOTLB
 	help
 	  This option enables support for the MPC8641 HPCN board.
@@ -57,7 +57,7 @@ config GEF_SBC610
 	select MMIO_NVRAM
 	select GPIOLIB
 	select GE_FPGA
-	select HAS_RAPIDIO
+	select HAVE_RAPIDIO
 	help
 	  This option enables support for the GE SBC610.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 659d59d7f033..4c8052a7c3f9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2811,15 +2811,6 @@ config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
 
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on PCI
-	help
-	  If enabled this option will include drivers and the core
-	  infrastructure code to support RapidIO interconnect devices.
-
-source "drivers/rapidio/Kconfig"
-
 config X86_SYSFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
 	help
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 58ee88c36cf5..065d308fcb00 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -6,6 +6,7 @@ menu "Device Drivers"
 source "drivers/amba/Kconfig"
 source "drivers/pci/Kconfig"
 source "drivers/pcmcia/Kconfig"
+source "drivers/rapidio/Kconfig"
 
 
 source "drivers/base/Kconfig"
diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index d6d2f20c4597..e3d8fe41b50c 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -1,6 +1,17 @@
 #
 # RapidIO configuration
 #
+
+config HAVE_RAPIDIO
+	bool
+
+menuconfig RAPIDIO
+	tristate "RapidIO support"
+	depends on HAVE_RAPIDIO || PCI
+	help
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
 source "drivers/rapidio/devices/Kconfig"
 
 config RAPIDIO_DISC_TIMEOUT
-- 
2.19.1

