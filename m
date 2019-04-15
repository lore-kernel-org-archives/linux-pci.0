Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF2C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814782075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfDOOjV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:39:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46064 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfDOOjU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:39:20 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hG2l7-0002Ch-L4; Mon, 15 Apr 2019 16:38:57 +0200
Date:   Mon, 15 Apr 2019 16:38:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, kbuild-all@01.org,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Message-ID: <20190415143857.kg2dbg3zxsxdktsi@linutronix.de>
References: <alpine.DEB.2.21.1904131849350.2536@hadrien>
 <20190413170056.GA11293@deco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413170056.GA11293@deco.navytux.spb.ru>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-04-13 17:00:59 [+0000], Kirill Smelkov wrote:
> Hello everyone,
Hi,

> On Sat, Apr 13, 2019 at 06:50:57PM +0200, Julia Lawall wrote:
> > Hello,
> > 
> > Kirill will explain about this issue.
> 
> pci/switchtec switching to stream_open is already queued to merge
> window and it was acked by Logan Gunthorpe:
> 
>         https://lore.kernel.org/lkml/CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com/
>         https://lab.nexedi.com/kirr/linux/commit/edaeb4101860
> 
> ( there are too many Cc's in that patch and email with it and reply-all to
>   it did not get into mailing list probably due to being considered as spam )
> 
> stream_open.cocci was issuing only warning for pci/switchtec, but after
> 8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue") they
> started to use wait_even_* inside read method and, since
> stream_open.cocci considers wait_event_* as blocking the warning became
> error. Previously it was completions there, but I added support for wait
> events only for simplicity.

why is wait_event_interruptible() treated differently compared to
wait_for_completion_interruptible()?
> Kirill

Sebastian
