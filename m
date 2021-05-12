Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29068C43462
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 18:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2AB613D6
	for <linux-pci@archiver.kernel.org>; Wed, 12 May 2021 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbhELSX6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 May 2021 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348846AbhELRjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 13:39:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F207FC061361
        for <linux-pci@vger.kernel.org>; Wed, 12 May 2021 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CSfjNBvzil5sM6GVUFquLjTSRDxkucMPz8fSfFbpK/A=; b=ibPG6GfaDdZJuqr30q7dyDUOxH
        fwTVd7+5t6OyRSkxMpyxqbpynsS/ZHuHW3vBe6jFHfd0w3E0t7p6KTrh748OUqaC1hoAaEe0Cl5lw
        Ki6Xij8qS7x5ODo2y0ws/METh13R/7E9iiNUd43DZxg61zjdXuKxLbGHHzA8MpT906VgGtKBHU6ct
        WDr/5+aepl+KfRpW9TDlColaPuBFl6RhVxR/pVnCqq9rttzL1a/NqYGPhmg8TCovWW4BJjovoYNZC
        aHMJUdGA0Ozg7y7o2Fm7VJcHT08dw1ioeAJpWGQSxvLHshALAvMqS4VIj3hQKjdUSuHE/wmQQG5ep
        4dsakJwA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgslm-008cMN-7W; Wed, 12 May 2021 17:35:47 +0000
Date:   Wed, 12 May 2021 18:35:38 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/VPD: Use unaligned access helpers in pci_vpd_read
Message-ID: <YJwR6ssFDkuUiklx@infradead.org>
References: <5719b91c-9f91-0029-0a28-386f1cb29d31@gmail.com>
 <YJjUWulw8vkscdwg@infradead.org>
 <26a9b3ec-07dc-c474-25ad-d7082060d305@gmail.com>
 <YJuCD9WCpV+rViys@infradead.org>
 <fa73ec3d-55d5-b430-39fc-fab7938b18bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa73ec3d-55d5-b430-39fc-fab7938b18bd@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 12, 2021 at 09:56:31AM +0200, Heiner Kallweit wrote:
> Which version is easier to read may be a question of personal taste.
> Using the unaligned access helper in pci_vpd_read() was asked for by
> Bjorn to complement a use of get_unaligned_le32() in pci_vpd_write().
> So I leave it up to him. Functionally it's the same anyway.

get_unaligned_le32 and friends are really nice helpers, but only when
they fit the use case.  In this case the existing code is a fairly easy
to follow loop, while the "new" version is a mess by all counts.
