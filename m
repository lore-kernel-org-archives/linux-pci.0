Return-Path: <SRS0=1awV=MZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751DEC71122
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 15:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9EF20895
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 15:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l6lfmgac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9EF20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJMWr6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:47:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeJMWr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Oct 2018 18:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4KnDnsDd5PAywnB9BlCvHW1koC0hdetxQg1aO7hfXyA=; b=l6lfmgac58iV0uNWJLEEprBzT5
        u3W5sUxjHd2Yzknn+VifdYZUIh8IedbqZduA93sW5yzU7zyjrZiWPFbR9EaRH69VCXEEiRYe573fz
        m3XR+gjco3gVmOjnB8rTgS/9NGKzblG+cj6Cb1/txDdIjsNDid/RwVtKWy2MIhVSdIZOFJYZpjHeT
        ce4HsIG64NEetUrRFRQ9IyE7QCtFHHa2PFb6/68SVafgMWzt88jX9mI1SXXhXIcrxF9lE3i2GkyvC
        1vav2UhJ7HEnhRopYTmZIRzq87d594z7128L6qd/jTZFERrmvpfbZxeODrI0VOOIMGDMshZF4JVfv
        UvtKZ/cw==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLYe-0002rO-3Z; Sat, 13 Oct 2018 15:10:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] powerpc: simplify CONFIG_PCI_QSPAN Kconfig magic
Date:   Sat, 13 Oct 2018 17:10:10 +0200
Message-Id: <20181013151016.31674-3-hch@lst.de>
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

The way how CONFIG_PCI_QSPAN selects the CONFIG_PCI default is highly
unusual and gets in the way of moving CONFIG_PCI into
drivers/pci/Kconfig.  Simplify it by just having it depend on
CONFIG_PCI.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..6fa6f92edb7f 100644
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
@@ -971,7 +970,7 @@ config PCI_SYSCALL
 
 config PCI_QSPAN
 	bool "QSpan PCI"
-	depends on PPC_8xx
+	depends on PPC_8xx && PCI
 	select PPC_I8259
 	help
 	  Say Y here if you have a system based on a Motorola 8xx-series
-- 
2.19.1

