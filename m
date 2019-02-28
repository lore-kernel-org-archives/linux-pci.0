Return-Path: <SRS0=y4Wk=RD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714DC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 13:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1952171F
	for <linux-pci@archiver.kernel.org>; Thu, 28 Feb 2019 13:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfB1NDO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:03:14 -0500
Received: from elvis.franken.de ([193.175.24.41]:34087 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfB1NDO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Feb 2019 08:03:14 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1gzLLD-0003NH-00; Thu, 28 Feb 2019 14:03:11 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 55FDAC043F; Thu, 28 Feb 2019 14:03:03 +0100 (CET)
Date:   Thu, 28 Feb 2019 14:03:03 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] PCI: call add_bus method also for root bus
Message-ID: <20190228130303.GA14225@alpha.franken.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
 <20190219155728.19163-8-tbogendoerfer@suse.de>
 <20190221233708.GC219879@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221233708.GC219879@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 21, 2019 at 05:37:08PM -0600, Bjorn Helgaas wrote:
> I haven't researched the details of how other platforms do it, but if
> it would be possible for pci-xtalk to do it the same way, that would
> be ideal.

I don't need this patch any longer. So you could just ignore it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
