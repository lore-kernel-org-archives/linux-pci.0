Return-Path: <SRS0=1WiX=OD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DCC43610
	for <linux-pci@archiver.kernel.org>; Sat, 24 Nov 2018 03:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF3120874
	for <linux-pci@archiver.kernel.org>; Sat, 24 Nov 2018 03:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WOa3E8ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF3120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeKXOo7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 24 Nov 2018 09:44:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeKXOo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Nov 2018 09:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rnt75NovqVREUcNFpNXwhtKry1MGSJYgxwyIiIT7cjM=; b=WOa3E8veuEPBENe8Rkn2rbWC4
        CcnJVvjxj1938b+WMg+lpH4tBhEQoInXFChdPXzfxhWjAADqWP/N/tyyLzqWrBlOvShmcnzzi1J9c
        cMNShOjvBNiupl8ZU8HN0F/0fxc/KRzRpX7YInRCuxra4em8K2G8CoL8qu1u79HHO0nbQnRSEdc67
        DHkaZ/BZCINx9jMGK34cOyIIcQCkWLcMz8XZhb7q7uu+DkluHqHeXBLzsV9i49LFpUCCOh74eIr1k
        zoBCwOnCDAGMcPYZVzD+MRt2qPgAX+kQpeVYpUzoOqaU9zyh17o41RgfG5j1uQFQX3t09vXeM3kUW
        tq/8y9xgA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQP51-00050n-Rx; Sat, 24 Nov 2018 03:58:03 +0000
Date:   Fri, 23 Nov 2018 19:58:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, LKP <lkp@01.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dad4f140ed ("Merge branch 'xarray' of .."):  Mem-Info:
Message-ID: <20181124035803.GX3065@bombadil.infradead.org>
References: <5bf8a766.2eiLO6qApoh2dO55%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf8a766.2eiLO6qApoh2dO55%lkp@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 24, 2018 at 09:20:38AM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit dad4f140edaa3f6bb452b6913d41af1ffd672e45

I think you've got the wrong bisection point, confused by other messages.
Here's the messages I think you intend to chase:

[  155.389297] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck
 for 52s!
[  155.409004] BUG: workqueue lockup - pool cpus=0 flags=0x4 nice=0 stuck for 40
s!
[  155.420377] Showing busy workqueues and worker pools:
[  155.428445] workqueue events: flags=0x0
[  155.434634]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
[  155.437904]     pending: cache_reap
[  155.449671] workqueue events_power_efficient: flags=0x82
[  155.458000]   pwq 2: cpus=0 flags=0x4 nice=0 active=3/256
[  155.461269]     pending: neigh_periodic_work, do_cache_clean, check_lifetime


but you're getting hung up on the testsuite problems.


