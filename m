Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA1EECDE35
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21B2214C3
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X7MU2yqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21B2214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJQP4r (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:56:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQP4q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yoAjUj25y4R5GH19rZSL/JJsy5pd/GhDvZgdcIB62yA=; b=X7MU2yqVEazsuPyRnacvedaPZs
        CsZ3UgrEyqpk+KX71xFAxo5avenQuxLrMo7sZNbYJ01awLxfPLW8rsyOF+CwbMVqupXfm0slqPxVc
        sxkswDsXfRb5hlcpbirxzqTf9FtK4uTSZ4m27wjj5ryNrZ0V1AYA97KSgtZKcUScHKL0g1HW3+evo
        jia79FxVUj7IP24meksQRq3pUqQGZYI6hGJRHlhBPnJ7BMIGmP2RuwgSvz8ShsYQVBRPNzu4bB8jt
        VhXbgJApHbyDQG5NhN2gmUJ1B8GbDycaQyJ4uh1P5OzLsQoWTX5vEIew8hki7y1N4dAkvPIkQ8EIq
        PP3PF9gQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCgmR-0003GY-0K; Wed, 17 Oct 2018 08:02:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] powerpc: remove CONFIG_PCI_QSPAN
Date:   Wed, 17 Oct 2018 10:01:55 +0200
Message-Id: <20181017080201.10866-3-hch@lst.de>
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

This option isn't actually used anywhere.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..e8c8970248bc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -955,7 +955,6 @@ config PCI
 	bool "PCI support" if PPC_PCI_CHOICE
 	default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
-	default PCI_QSPAN if PPC_8xx
 	select GENERIC_PCI_IOMAP
 	help
 	  Find out whether your system includes a PCI bus. PCI is the name of
@@ -969,14 +968,6 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI
 
-config PCI_QSPAN
-	bool "QSpan PCI"
-	depends on PPC_8xx
-	select PPC_I8259
-	help
-	  Say Y here if you have a system based on a Motorola 8xx-series
-	  embedded processor with a QSPAN PCI interface, otherwise say N.
-
 config PCI_8260
 	bool
 	depends on PCI && 8260
-- 
2.19.1

