Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0807FECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15E320645
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBtkL/RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15E320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJSUQU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:16:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 16:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g3Ofp2yKFio2DWF3K0YYAwI8DA2raI+ejnrdGDleVlk=; b=JBtkL/RVN396nN53LFB0IS8f4d
        edXyd1isCPYn8lfy5jeFzCX0GUUGrrL/dP7vCO+fVJhP541VEzUed3MWaUZrSBuEyB0yyF1kw9TdJ
        in+3z7FLkYYCU7f47BFXLA+Em/wq8aNtetItuoOvMe41fgorzklZc0/zazP6tbFLwttowWFYnqRk+
        hHuabtcD4WEfYUfhN2aVQKwc9ca86mXSdEgxQoInneTo4ZZh3cOMg9f/ToNYlr7WcQnd2Ahd/k+VW
        OtOFoYkRhjj2BK3oCRmL0aoUuUZ10Ob65TuBBNP46iwMXWmfEIA47+dfWQTAyjtgLN1bmHWrapG3j
        CxxqRQ5g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDTbT-00010a-P2; Fri, 19 Oct 2018 12:10:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/9] powerpc: remove CONFIG_MCA leftovers
Date:   Fri, 19 Oct 2018 14:09:47 +0200
Message-Id: <20181019120952.32763-5-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181019120952.32763-1-hch@lst.de>
References: <20181019120952.32763-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/Kconfig | 4 ----
 drivers/scsi/Kconfig | 6 +++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e8c8970248bc..d4e97469a5f0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -941,10 +941,6 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
-# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
-config MCA
-	bool
-
 # Platforms that what PCI turned unconditionally just do select PCI
 # in their config node.  Platforms that want to choose at config
 # time should select PPC_PCI_CHOICE
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 7c097006c54d..d3734c54aec9 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -535,7 +535,7 @@ config SCSI_HPTIOP
 
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
-	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
+	depends on (PCI || ISA) && SCSI && ISA_DMA_API && VIRT_TO_BUS
 	---help---
 	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
 	  Adapters. Consult the SCSI-HOWTO, available from
@@ -1142,12 +1142,12 @@ config SCSI_LPFC_DEBUG_FS
 
 config SCSI_SIM710
 	tristate "Simple 53c710 SCSI support (Compaq, NCR machines)"
-	depends on (EISA || MCA) && SCSI
+	depends on EISA && SCSI
 	select SCSI_SPI_ATTRS
 	---help---
 	  This driver is for NCR53c710 based SCSI host adapters.
 
-	  It currently supports Compaq EISA cards and NCR MCA cards
+	  It currently supports Compaq EISA cards.
 
 config SCSI_DC395x
 	tristate "Tekram DC395(U/UW/F) and DC315(U) SCSI support"
-- 
2.19.1

