Return-Path: <SRS0=1awV=MZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D5BC71122
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 15:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F00206B2
	for <linux-pci@archiver.kernel.org>; Sat, 13 Oct 2018 15:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KUtd94DE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F00206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeJMWrz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:47:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJMWry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Oct 2018 18:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cwcwm2vgjyIKuNqAgBAUGLyrP6a8beJUjg7kDKl0syw=; b=KUtd94DEljRYiEfSHwPvOLY4r
        udKaT2I3zOGnid/1SY2czwxyzKtNAix8OpVy6AP4tfZV3ecVJIZWf/qom9/BDgLnkVki6Vl0CLGQ9
        ZxQPUYbcsN4nsbADILOWFihznR73DSo0N/Ay1DQ1iJMbp8jgajUiotZzcxedvU/2Fh8Ar84B3/ZyZ
        8356fVhpB4eURHA3r1yMaRS7HeQoZCaQs7iZw7igPHrRDxD9sq5Wi3lqFaJ7AwxnJXWmmc6AOubJI
        k2LKa/hz1PdmcWFuj/40WnxUVnOgNomDVsE8W0L5++5ZJnTsDsOJCHRAC2Zz6ECCvdVu5GxY38jJo
        zdGoV82UQ==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLYY-0002r5-Te; Sat, 13 Oct 2018 15:10:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/
Date:   Sat, 13 Oct 2018 17:10:08 +0200
Message-Id: <20181013151016.31674-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

currently every architecture that wants to provide on of the common
periphal busses needs to add some boilerplate code and include the
right Kconfig files.   This series instead just selects the presence
(when needed) and then handles everything in the bus-specific
Kconfig file under drivers/.

