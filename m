Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDE8ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB37820838
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UOynJtN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB37820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJSUQF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:16:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 16:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OLdpU/Lx2kG/LtqEJaUA/6yYmO6K2xQpzfu8jS6tJX0=; b=UOynJtN6fLkjrjEuEDJdlfRI7r
        rJKtlO3dI54AaE6B6RSOAyJxw1hxddhhm/0oNeZqt8s95JOErgutKjT2yiDBr1So6LvguiCYNCEID
        +HKNIbfIaCgJkRonBCbU+oLJFfWzzDv/aiIkwlAnuUGMM1C9OGxnD2g7u//Ab+/VBxnf1deDqqnjw
        JNQmBU4m9TEpLdU1sxH028jNNnqizi9n0zJ/CW2K8flUJEn5+FM5l6knlCPypUfxR7sb8oeEoJ/9g
        YUvdPwrXuwgwHbIZJITzO5L98+821rws8Nfkja3HvsFnUPh87VFo7CvLKPBRfe0ED+tERWUclITOF
        kWfX3dfQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDTbN-0000uR-Jn; Fri, 19 Oct 2018 12:10:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/9] arm: remove EISA kconfig option
Date:   Fri, 19 Oct 2018 14:09:45 +0200
Message-Id: <20181019120952.32763-3-hch@lst.de>
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

No arm config enables EISA, and arm does not include drivers/eisa/Kconfig
which provides support for things like PCI to EISA bridges, so it is most
likely dead.

If this is wrong we will be able to resurrect it easily by selecting
HAVE_EISA for the right arm configs after this series.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..e33735ce1c14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -165,21 +165,6 @@ config HAVE_PROC_CPU
 config NO_IOPORT_MAP
 	bool
 
-config EISA
-	bool
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
 config SBUS
 	bool
 
-- 
2.19.1

