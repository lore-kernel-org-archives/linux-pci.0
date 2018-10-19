Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25583ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB84920645
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d41ltsyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB84920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeJSUQX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:16:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 16:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NU8hc3wOH75SjWyKDE305NVPfLPJR7iXVJpwS3eg4UQ=; b=d41ltsyQvMVGnhOAYaACQHPr5a
        FJSjrZiOABjQFiSTEySnPgFFTMKT3n7RRhpjO6YdBtFnhsKDzovM9H6Ue45CH6LUHTZBZ8vf6cfx3
        H64llrxlOBR/6xmhAIjRUPlg7xCa5hi+viBhPMF4mnSVWwKd9LLgmlTpNtNW65uNc3uo4lpfPT08J
        aV5eTKRfdc8HvJ0o6JOsrtLMkjCHzGnVWIBlvYPIPjOgk2F1YQovGm2kqcrc70rclZ+cHWo1ug59b
        0UUcGqadzml09l9k+bkUuoyFbT58Cg9KoKxyZjkG0ZZe84C/jMzIQqNJCWH+9jrrqDLh5a9V13sPJ
        U5a65TMQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDTbW-00016N-UD; Fri, 19 Oct 2018 12:10:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/9] powerpc: PCI_MSI needs PCI
Date:   Fri, 19 Oct 2018 14:09:48 +0200
Message-Id: <20181019120952.32763-6-hch@lst.de>
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

