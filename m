Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C169ECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A15321479
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 12:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eUo6raTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A15321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJSUPv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:15:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 16:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rk95EKoVo1kSFkisE1sNUnclnCTjbHNdzsZGKJ8PR8Q=; b=eUo6raTRVZ5YPHamERPcUP9M4
        qkA/gbwTx65psu0S/0UUZQm8ZybktRL+NV7JFmjLlqq6U5ygyW6uEwEP2YRjGViWYsSNExKSQ159e
        UGn8JMlR/+gFm4GFVITHGWJq5ehbK1PhVbuz0tI3wT1lofJR0BM0v4SySSmxV5sqB4tQNNtFCs+b+
        W+laY+7eCHK+9Cl7ir7999Pe10IXYhJwwUqFgC/rYZ4gWan8OSUAB35DsnAxlhzm3lJkgT1tKFBgk
        IDwNppG7HObaGlkLtfZP8MU0Q9h9CBbacc8tcZz/HHzpJ+Budw9lLFJDs3sQwNvR0XsJWTsOBBA62
        lBX8IrT9A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDTbH-0000ro-EW; Fri, 19 Oct 2018 12:09:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v3
Date:   Fri, 19 Oct 2018 14:09:43 +0200
Message-Id: <20181019120952.32763-1-hch@lst.de>
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

Changes since v2:
 - depend on HAVE_PCI for PCIe endpoint code
 - fix some commit message typos
 - remove CONFIG_PCI from xtensa iss defconfig
 - drop EISA support from arm
 - clean up EISA selection for alpha

Changes since v1:
 - rename all HAS_* Kconfig symbols to HAVE_*
 - drop the CONFIG_PCI_QSPAN option entirely
 - drop duplicate select from powerpc
 - restore missing selection of PCI_MSI for riscv
 - update x86 and riscv defconfigs to include PCI
 - actually inclue drivers/eisa/Kconfig
 - adjust some captilizations
