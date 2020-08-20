Return-Path: <SRS0=W/B3=B6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29F3C433E1
	for <linux-pci@archiver.kernel.org>; Thu, 20 Aug 2020 21:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660C42184D
	for <linux-pci@archiver.kernel.org>; Thu, 20 Aug 2020 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597958397;
	bh=LpHLI5zWx/R79E5iCR5MaeHXWs+4w+la5T/EIrcC6g8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jVr1sLotV1kHfBdSsJuSu/9k6JP87m0CUs6iWCxxZWT2gTcuvqbIwLt+n/9E0md+D
	 wsizUP0FMw8PWFVnRCjMzfdqcq8CYQPhrDHyEcqUE1Ghp8ZpRV6DHZi+A3HlkJvScm
	 91OLSNosg9sGbPAbFqR2oe72K8/cmIAdZC3xxmbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHTVT4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbgHTVT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 17:19:56 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597958395;
        bh=LpHLI5zWx/R79E5iCR5MaeHXWs+4w+la5T/EIrcC6g8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vp0XH0+qSLbS6m1Rbg/WERBKDjQJduOQ0htypMXT8jvz99c3MXTMrrUfnrNZDl48g
         oJHGg5Yccne2+zXHTJOR/P2jUfqTd7rKW0SbWhmmK6ICSoMNzsjBezRuEDIl4Hwcsc
         LLyIEsLTRqUA9Jk6OHIv8OTzLQ1iFSShM0iwXD3g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200820205034.GA1565627@bjorn-Precision-5520>
References: <20200820205034.GA1565627@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200820205034.GA1565627@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-fixes-1
X-PR-Tracked-Commit-Id: 7c2308f79fc81ba0bf24ccd2429fb483a91bcd51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da2968ff879b9e74688cdc658f646971991d2c56
Message-Id: <159795839574.11229.5737153371339944893.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Aug 2020 21:19:55 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 20 Aug 2020 15:50:34 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da2968ff879b9e74688cdc658f646971991d2c56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
