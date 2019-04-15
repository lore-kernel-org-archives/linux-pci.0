Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E4C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E560420825
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="Z6r4nUjn";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="TnXRxb07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfDOP4J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:56:09 -0400
Received: from mail14.wdc04.mandrillapp.com ([205.201.139.14]:19383 "EHLO
        mail14.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbfDOP4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:56:08 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 11:56:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=d0W7Z8nFQ4X/vRXX6lWS7UtbrZ1ez/JWeQL7TBTIJzI=;
 b=Z6r4nUjnICcRu92UOvH1XLj1O2A5EDL31V3MLAN3cTrtfpNy4gMSogFswdRkS6H9ireQ0ZYVZi40
   jvJBqI0Il8KV93yYFOJshvpgAXUn3qyfKIrxmc8pmATF06UOjskJo3NkO4g5lDbmNo83nIR8OpeY
   SoyXjTzX78M6O74KugA=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail14.wdc04.mandrillapp.com id hmikpe1jvmgt for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2019 15:41:06 +0000 (envelope-from <bounce-md_31050260.5cb4a612.v1-3f3c5cc50f284377b40ee293cc4d4f21@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555342866; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=d0W7Z8nFQ4X/vRXX6lWS7UtbrZ1ez/JWeQL7TBTIJzI=; 
 b=TnXRxb07AgPlitqE9ik3R/d/o0teu5WwmZL83xejwjmN9SqJcJZ6IZYs60XvLQD2cwNO05
 kL9fgCyt7vMEKkIJAVU2TrAz0OeBzRWIDL0HDSKqG0GN8ms4ThIxey9byVQYgpcCJFaVui4/
 EDEKVXjz/b+7TTQtBcc//s2QHS3B8=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Received: from [87.98.221.171] by mandrillapp.com id 3f3c5cc50f284377b40ee293cc4d4f21; Mon, 15 Apr 2019 15:41:06 +0000
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, <kbuild-all@01.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190415154102.GB17661@deco.navytux.spb.ru>
References: <alpine.DEB.2.21.1904131849350.2536@hadrien> <20190413170056.GA11293@deco.navytux.spb.ru> <20190415143857.kg2dbg3zxsxdktsi@linutronix.de> <20190415145456.GA15280@deco.navytux.spb.ru> <20190415152021.3j3riefeoz7rf2pa@linutronix.de>
In-Reply-To: <20190415152021.3j3riefeoz7rf2pa@linutronix.de>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.3f3c5cc50f284377b40ee293cc4d4f21
X-Mandrill-User: md_31050260
Date:   Mon, 15 Apr 2019 15:41:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sebastian,

On Mon, Apr 15, 2019 at 05:20:22PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-04-15 14:55:02 [+0000], Kirill Smelkov wrote:
> > Hi Sebastian,
> Hi Kirill,
> 
> > On Mon, Apr 15, 2019 at 04:38:57PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-04-13 17:00:59 [+0000], Kirill Smelkov wrote:
> > > > stream_open.cocci was issuing only warning for pci/switchtec, but after
> > > > 8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue") they
> > > > started to use wait_even_* inside read method and, since
> > > > stream_open.cocci considers wait_event_* as blocking the warning became
> > > > error. Previously it was completions there, but I added support for wait
> > > > events only for simplicity.
> > > 
> > > why is wait_event_interruptible() treated differently compared to
> > > wait_for_completion_interruptible()?
> > 
> > No particular reason. I just taught stream_open.cocci to consider
> > only "wait_event_*" as blocking:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/stream_open.cocci?h=v5.1-rc5#n35
> > 
> > based on original /proc/xen/xenbus deadlock:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/xen/xenbus/xenbus_dev_frontend.c?h=v5.1-rc5#n135
> > https://git.kernel.org/linus/581d21a2d02a
> > 
> > We can extend "a function that blocks" rule to cover other kernel
> > primitives.
> > 
> > For the reference: the deadlock scenario is described in
> > 
> > https://git.kernel.org/linus/10dce8af3422
> 
> As far I understand the problem is when the ->read() callback waits for
> the ->write() callback. The locking isn't changed by patch you
> mentioned.

Yes, correct. The patch that I mentioned only adds semantic patch which
find places with such problem and can generate a regular patch to change
locking. Here is that place for pci/switchtec:

https://lab.nexedi.com/kirr/linux/commit/edaeb4101860?expand_all_diffs=1#ccc4baef911c8dad164d4ff29a8c0b287abed7c2_393_393

> So extended might make sense. But then wait_event_* by itself in
> ->read() isn't a problem as long as its counter part isn't in ->write().

It is a problem either if its counterpart is in write _or_ if that
wait_event depends on external source and waiting can be for potentially
unbounded time, like e.g. waiting to receive a character from serial
port or network.

But you are right that even with wait_event used, cases are possible that
there is no blocking that depend on external source and it could be just
e.g. spawn kernel thread to do some limited amount of work and wait for
it to complete. I did not taught stream_open.cocci about that because
when something goes wrong with semantic patch and Coccinelle complains,
it is hard to understand what is going on, and because generally it is
better to convert files that do not depend on position, even if there is
no deadlock at all, to stream_open - i.e. don't do any f_pos_lock
locking at all.

> But yes, nice finding.

Thanks,

Kirill
