Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C03C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA65217D6
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfDOPUb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:20:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfDOPUb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:20:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hG3PC-0003Uz-Bo; Mon, 15 Apr 2019 17:20:22 +0200
Date:   Mon, 15 Apr 2019 17:20:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, kbuild-all@01.org,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Message-ID: <20190415152021.3j3riefeoz7rf2pa@linutronix.de>
References: <alpine.DEB.2.21.1904131849350.2536@hadrien>
 <20190413170056.GA11293@deco.navytux.spb.ru>
 <20190415143857.kg2dbg3zxsxdktsi@linutronix.de>
 <20190415145456.GA15280@deco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415145456.GA15280@deco.navytux.spb.ru>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-04-15 14:55:02 [+0000], Kirill Smelkov wrote:
> Hi Sebastian,
Hi Kirill,

> On Mon, Apr 15, 2019 at 04:38:57PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-04-13 17:00:59 [+0000], Kirill Smelkov wrote:
> > > stream_open.cocci was issuing only warning for pci/switchtec, but after
> > > 8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue") they
> > > started to use wait_even_* inside read method and, since
> > > stream_open.cocci considers wait_event_* as blocking the warning became
> > > error. Previously it was completions there, but I added support for wait
> > > events only for simplicity.
> > 
> > why is wait_event_interruptible() treated differently compared to
> > wait_for_completion_interruptible()?
> 
> No particular reason. I just taught stream_open.cocci to consider
> only "wait_event_*" as blocking:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/stream_open.cocci?h=v5.1-rc5#n35
> 
> based on original /proc/xen/xenbus deadlock:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/xen/xenbus/xenbus_dev_frontend.c?h=v5.1-rc5#n135
> https://git.kernel.org/linus/581d21a2d02a
> 
> We can extend "a function that blocks" rule to cover other kernel
> primitives.
> 
> For the reference: the deadlock scenario is described in
> 
> https://git.kernel.org/linus/10dce8af3422

As far I understand the problem is when the ->read() callback waits for
the ->write() callback. The locking isn't changed by patch you
mentioned.
So extended might make sense. But then wait_event_* by itself in
->read() isn't a problem as long as its counter part isn't in ->write().
But yes, nice finding.

> Kirill

Sebastian
