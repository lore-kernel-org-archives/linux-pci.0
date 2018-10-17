Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B21ECDE32
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65837214C3
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JHK/8Gde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65837214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeJQP4v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:56:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQP4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NU8hc3wOH75SjWyKDE305NVPfLPJR7iXVJpwS3eg4UQ=; b=JHK/8GdeZw3cG+c7MPDYm1+/Ks
        mSx0WfGiOF8BPxsc/nGNM5btL7DT3HZpprZEHsBhEdUnblkiXH0BGR53cf253UDVKUbfui54lwgsy
        95/Q269n8x4i8oZsXNgfHnozTkVhqmC+w3k5FAEmTxyWQFAOLS96v5/ptMFRalpaaOKLxvgw6Ojuk
        P11lQTunIy1WsfmZBsC9q33jRm8B4HCoOPapDKP4hIlI3uB4Y9LVFEjtKh/yrTKIvdYqvGAb98Vdz
        3H2faUZTxoc7+JN5nYDSq67XfdX7FJpqPAd+ktYHlZb8nzgaYR74FhOHWk6ULV9yUAGmAzUKhbey3
        Izgq5/oA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCgmT-0003Hh-Fm; Wed, 17 Oct 2018 08:02:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] powerpc: PCI_MSI needs PCI
Date:   Wed, 17 Oct 2018 10:01:56 +0200
Message-Id: <20181017080201.10866-4-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017080201.10866-1-hch@lst.de>
References: <20181017080201.10866-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Various powerpc boards select the PCI_MSI config option without selecting
PCI, resulting in potentially not compilable configurations if the by
default enabled PCI option is disabled.  Explicitly select PCI to ensure
we always have valid configs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/40x/Kconfig | 1 +
 arch/powerpc/platforms/44x/Kconfig | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 60254a321a91..d5361e63e0bb 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -33,6 +33,7 @@ config KILAUEA
 	select 405EX
 	select PPC40x_SIMPLE
 	select PPC4xx_PCI_EXPRESS
+	select PCI
 	select PCI_MSI
 	select PPC4xx_MSI
 	help
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index a6011422b861..70856a213663 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -24,6 +24,7 @@ config BLUESTONE
 	default n
 	select PPC44x_SIMPLE
 	select APM821xx
+	select PCI
 	select PCI_MSI
 	select PPC4xx_MSI
 	select PPC4xx_PCI_EXPRESS
@@ -78,6 +79,7 @@ config KATMAI
 	select 440SPe
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select PCI
 	select PCI_MSI
 	select PPC4xx_MSI
 	help
@@ -219,6 +221,7 @@ config AKEBONO
 	select SWIOTLB
 	select 476FPE
 	select PPC4xx_PCI_EXPRESS
+	select PCI
 	select PCI_MSI
 	select PPC4xx_HSTA_MSI
 	select I2C
-- 
2.19.1

