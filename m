Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A3BC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C390224E0
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mGrQbhuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C390224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeKPFPB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:15:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 00:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IylCCNV0aDkueSo9V0FfpQRG6hvw8k3aFkjN7Oh7FrU=; b=mGrQbhuCTitVob/QGO1MHKIOOr
        U7W9l473uZ8mtVrZKaOQWm9ayIlBziRDLQBddqrUsn8CjAR9bPy1LW8ktfv6w1jfjgCqKEt6tDFzq
        b7lV2vZuKdk4L41Jt6RBIOr4JvsBU6xGFtUNvdC6z5HsM2dVEuuk2yF78wy7bAlL8xB1lthRQld1k
        ZIXfGu0qNIJw9YAc5YMaNCDdCVHA4uu6YUj3hLC1xY2LcFkRKvpE6mkKTRkDMl1ArZF1lS1nx8L2U
        yySGpV4JJ7mmEjdXuYhNraI1eh3rAepOgyxY1FPrtJ5vC/mtKEJZ0JKh3tKb7CNSLmWE7tG5Da4lF
        +iB4IDxg==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNMxe-0005vy-QY; Thu, 15 Nov 2018 19:05:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 3/9] MIPS: remove the HT_PCI config option
Date:   Thu, 15 Nov 2018 20:05:31 +0100
Message-Id: <20181115190538.17016-4-hch@lst.de>
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

This option is always selected from LOONGSON_MACH3X.  Switch to just
seleting PCI from that option and definining LOONGSON_PCIIO_BASE based
on CONFIG_LOONGSON_MACH3X.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig                                | 11 -----------
 arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
 arch/mips/loongson64/Kconfig                     |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8272ea4c7264..7d28c9dd75d0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3040,17 +3040,6 @@ config PCI
 	  your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
 	  say Y, otherwise N.
 
-config HT_PCI
-	bool "Support for HT-linked PCI"
-	default y
-	depends on CPU_LOONGSON3
-	select PCI
-	select PCI_DOMAINS
-	help
-	  Loongson family machines use Hyper-Transport bus for inter-core
-	  connection and device connection. The PCI bus is a subordinate
-	  linked at HT. Choose Y for Loongson-3 based machines.
-
 config PCI_DOMAINS
 	bool
 
diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
index d0ae5d55413b..b6870fec0f99 100644
--- a/arch/mips/include/asm/mach-loongson64/loongson.h
+++ b/arch/mips/include/asm/mach-loongson64/loongson.h
@@ -113,7 +113,7 @@ static inline void do_perfcnt_IRQ(void)
 #define LOONGSON_PCICFG_SIZE	0x00000800	/* 2K */
 #define LOONGSON_PCICFG_TOP	(LOONGSON_PCICFG_BASE+LOONGSON_PCICFG_SIZE-1)
 
-#if defined(CONFIG_HT_PCI)
+#ifdef CONFIG_CPU_LOONGSON3
 #define LOONGSON_PCIIO_BASE	loongson_sysconf.pci_io_base
 #else
 #define LOONGSON_PCIIO_BASE	0x1fd00000
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index c865b4b9b775..781a5156ab21 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -76,7 +76,7 @@ config LOONGSON_MACH3X
 	select CPU_HAS_WB
 	select HW_HAS_PCI
 	select ISA
-	select HT_PCI
+	select PCI
 	select I8259
 	select IRQ_MIPS_CPU
 	select NR_CPUS_DEFAULT_4
-- 
2.19.1

