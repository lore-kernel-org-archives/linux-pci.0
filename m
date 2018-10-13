Return-Path: <SRS0=1awV=MZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C58BC28CF8
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 15:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252AF20895
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I7f34KTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252AF20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeJMWsO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:48:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeJMWsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Oct 2018 18:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e2M4x6Di82IjUYtVVlGQAJo/6xAoTWNHc0fE3LO/Xaw=; b=I7f34KTRbVwJdqPMZZF498MTU7
        yoIltDsGbqzLHXKYsVWW9GAKecu5UCoBFVAQt1E+UbiNBlOQqZKgS+z0Mpbv/R697OzKmmxRy7yUz
        KONKRfD0hnTcyvBrmXcRE45eRYL7vyVQDeRYgC4h9L7C0jdVfAm7rKUQjeX8X84ZhTRYniiTl1H7p
        JF2j3A/6FxzDmog3undFhhdDv9yM9a+mu7UYq/aSpAdTXgY/wS8Zc0gKZoPAB2tYqw2ND7L4XX5tr
        MoqSsiOW04aNNreT0/nr5eHv3R4qMN4XiRG+zLHN514JEg99acQVkdbRJpbavJ5nr6ccRbYU8b4q0
        BEz18G6A==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLYu-00030N-Q6; Sat, 13 Oct 2018 15:10:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] kconfig: remove CONFIG_MCA leftovers
Date:   Sat, 13 Oct 2018 17:10:16 +0200
Message-Id: <20181013151016.31674-9-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181013151016.31674-1-hch@lst.de>
References: <20181013151016.31674-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig | 4 ----
 drivers/scsi/Kconfig | 6 +++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f0ea460653cd..8b9edf7caf96 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -944,10 +944,6 @@ config FSL_GTM
 	help
 	  Freescale General-purpose Timers support
 
-# Yes MCA RS/6000s exist but Linux-PPC does not currently support any
-config MCA
-	bool
-
 config PCI_DOMAINS
 	def_bool PCI
 
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

