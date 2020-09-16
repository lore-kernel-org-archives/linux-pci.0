Return-Path: <SRS0=XVho=CZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5C0C43461
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 06:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BFF21D7D
	for <linux-pci@archiver.kernel.org>; Wed, 16 Sep 2020 06:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="guuG3Pt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIPGR3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgIPGR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 02:17:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06907C06174A;
        Tue, 15 Sep 2020 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=s8mnqat7GGupYmev9VBKRE+GEfYSOGcbHcyGgV6dyXw=; b=guuG3Pt1J5nWsCBoJItPym1+vj
        0aeWJGDaGySTSVHSbdpYTROMBmteFH+Ivy8Zcc9K2kuDL9q/BHZaVU9P+3UB8GuUEB6nb9cpn3vJs
        wLOdAxW2P1ebiJKFM5z8soepZFlJ+GavE5MtpF9fqeNPBdaX7D4/P1FTuTOe+Sfh6XVA6A7O/CLXU
        w3qBYTP9KuYLJA+yOvt9dHDHudjL/zx/juLg4iNzT2TzEiEW1C3fGPvt2j2m3aeCKiwFIG0qemx9K
        jAsFkAcEn75npyjux686+2kMCFRQyW2+unJYAl4riVuilCbhQu8NYGFcpcfFv6dErBpR6Agd4IqhB
        RsiUOCTg==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIQkh-0006mN-CM; Wed, 16 Sep 2020 06:17:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: support range based offsets in dma-direct v3
Date:   Wed, 16 Sep 2020 08:14:53 +0200
Message-Id: <20200916061500.1970090-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

this series adds range-based offsets to the dma-direct implementation.  The
guts of the change are a patch from Jim with some modifications from me,
but to do it nicely we need to ARM patches to prepare for it as well.

Changes since v2:
 - fix a mismerge
 - return (phys_addr_t)-1 from translate_dma_to_phys when there is no
   matching range to fix dma_capable checks

Changes since v1:
 - rebased on top of the latests dma-mapping for-next tree
 - add two more trivial ARM cleanups
 - remove the DMA property inheritance hack in usb
 - move the remaining copy of the ranges into the remoteproc driver
   as it should not be seen as a general API, but as a quirk for
   remoteproc that we need to fix ASAP

Diffstat:
