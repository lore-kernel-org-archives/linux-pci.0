Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CBC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A4F224E0
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2Jh0KMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A4F224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeKPFO5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:14:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 00:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kW4IZ50dTVLE0ZGSEmrOaBcjCtzndNxGLa47dnAiUQI=; b=f2Jh0KMiTEjztiqW6Rfg8QrrIy
        EbYyB1SUGTOFIJQxSYYLoPVZglVWmYoabBCNVi0l7wGq+lPGwlT+4T2E+oIcW50sKBw5MaNSjH9p4
        TfvSrdsPnWbJvbA7lPsldZ/CAqYgiMarNoXeMPZbjMiQqqoUFxCczz4ZMNKaK2qohomrEAb5gKTHX
        tdFfuLqXnD6e+hPiNBYHAJ/TD+6EVWAGNMLiVERYGwJ/+j7Gm3IrHJJuIG09Amu1r2EQ5PxJuNlT5
        +4zDRJtx6sWQVvCCnJRvARtgeP7ayqxKmUrrT3t9SJAR1UymG7vPlzyBQWfh/eppfVxVV55D0j3ha
        t9NfdLDA==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNMxc-0005t6-34; Thu, 15 Nov 2018 19:05:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 2/9] alpha: force PCI on for non-jensen configs
Date:   Thu, 15 Nov 2018 20:05:30 +0100
Message-Id: <20181115190538.17016-3-hch@lst.de>
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

Without PCI support the kernel won't even compile, so force it on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 5b4f88363453..65f6d0bf69d4 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -6,6 +6,7 @@ config ALPHA
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ARCH_NO_PREEMPT
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select PCI if !ALPHA_JENSEN
 	select HAVE_AOUT
 	select HAVE_IDE
 	select HAVE_OPROFILE
-- 
2.19.1

