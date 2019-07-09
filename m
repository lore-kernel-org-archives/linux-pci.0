Return-Path: <SRS0=0Iuk=VG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B611FC73C46
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jul 2019 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22F214AF
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jul 2019 15:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nK0icQBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfGIPkU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:40:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIPkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 11:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1l3rYx+kdkqRUYKxZa5I4Bcd/Jr0zCKsf+Y32tRAj8k=; b=nK0icQBHnnBELp9a4tnAn7iYZu
        8SQl77UBjbdsdFZYKz6tjgmYbMZJgkDl1PixjvrI0zZ1x/SMQazJF2xsY6Wxua4zkeOrzrEro7GZq
        XC5skft0HaTRojhjvp5AOEbY+ESCVilMxDb3DzRQTztZeIITpdCu1uiANx4eYOdprGki99e8UPHQm
        kcxX9E+pMpT01ynTsQeNzomCqGZ/L+Tk4vg9Ul056rZs0R5LovgLXWZCP0cKky6iJKpXoXnbqnVem
        jdN1O6jERX/gNgHoZwUVoAFTwYzDEPQLqFelWTSDqGF0SA4JoL9EpfFd1xq8jQGF5bfm+RS5Qe7mi
        agK10BmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hksE7-0000nb-If
        for linux-pci@vger.kernel.org; Tue, 09 Jul 2019 15:40:19 +0000
Date:   Tue, 9 Jul 2019 08:40:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     linux-pci@vger.kernel.org
Subject: reprobing BAR sizes and capabilities after a FLR?
Message-ID: <20190709154019.GA30673@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I've just been talking to some firmware developers that were a little
surprised that Linux does not reprobe BAR sizes after a FLR.  I looked
at our code and we do not reprobe anything at all after a FLR.  Is it
a good assumption that a devices comes back in exactly the same state
after an FLR?
