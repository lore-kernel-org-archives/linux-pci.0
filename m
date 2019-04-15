Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F584C282DA
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6090C2183F
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="kgiPTLqC";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="BxwnmMa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfDOPKI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:10:08 -0400
Received: from mail14.wdc04.mandrillapp.com ([205.201.139.14]:19541 "EHLO
        mail14.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbfDOPKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:10:07 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 11:10:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=o+R+7V6FYI76MGf1Yo3KgDdQ+TCerityJJLqd48cM54=;
 b=kgiPTLqC2FOX6hS3mxrPXYwnEG7obABlqMJmNtRdvksQMoZOWzVwTRv1B9bF9kcWr4nmicqXUIHf
   W3qJechCeQi5Jl9OdEJuNExR5kfbvFxXqS3EGJ1W5LhrtDTp+AUGy9mBXaNthSWy0wul0mn7R1dE
   ne1Funt11jEKj3ScRPI=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail14.wdc04.mandrillapp.com id hmifcs1jvmg1 for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2019 14:55:03 +0000 (envelope-from <bounce-md_31050260.5cb49b47.v1-edf2cd6649b84428b0aa6f8aae2a6bac@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1555340103; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=o+R+7V6FYI76MGf1Yo3KgDdQ+TCerityJJLqd48cM54=; 
 b=BxwnmMa6a23479Z7LpMFqIyo27Y6nZsQP3+EqVC7KuzgxZkOeoya6e5OTic2/Kn3CCnqaF
 NZA2bMpYwy9WetevxYMieDUc+lB1e2fNR68dNPNi3/HCQthWnHGrc1ELWo3o/U0QPaxMqQd6
 PL7A06iR8SIS2p53kktOZKgyne5Eg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] pci/switchtec: fix stream_open.cocci warnings (fwd)
Received: from [87.98.221.171] by mandrillapp.com id edf2cd6649b84428b0aa6f8aae2a6bac; Mon, 15 Apr 2019 14:55:03 +0000
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, <kbuild-all@01.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-Id: <20190415145456.GA15280@deco.navytux.spb.ru>
References: <alpine.DEB.2.21.1904131849350.2536@hadrien> <20190413170056.GA11293@deco.navytux.spb.ru> <20190415143857.kg2dbg3zxsxdktsi@linutronix.de>
In-Reply-To: <20190415143857.kg2dbg3zxsxdktsi@linutronix.de>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.edf2cd6649b84428b0aa6f8aae2a6bac
X-Mandrill-User: md_31050260
Date:   Mon, 15 Apr 2019 14:55:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sebastian,

On Mon, Apr 15, 2019 at 04:38:57PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-04-13 17:00:59 [+0000], Kirill Smelkov wrote:
> > Hello everyone,
> Hi,
> 
> > On Sat, Apr 13, 2019 at 06:50:57PM +0200, Julia Lawall wrote:
> > > Hello,
> > > 
> > > Kirill will explain about this issue.
> > 
> > pci/switchtec switching to stream_open is already queued to merge
> > window and it was acked by Logan Gunthorpe:
> > 
> >         https://lore.kernel.org/lkml/CAHk-=wgqgN5j1ZWnyVLqqoyU=CCWTYOko3MDyU8L_5e21KvHAg@mail.gmail.com/
> >         https://lab.nexedi.com/kirr/linux/commit/edaeb4101860
> > 
> > ( there are too many Cc's in that patch and email with it and reply-all to
> >   it did not get into mailing list probably due to being considered as spam )
> > 
> > stream_open.cocci was issuing only warning for pci/switchtec, but after
> > 8a29a3bae2a2 ("pci/switchtec: Don't use completion's wait queue") they
> > started to use wait_even_* inside read method and, since
> > stream_open.cocci considers wait_event_* as blocking the warning became
> > error. Previously it was completions there, but I added support for wait
> > events only for simplicity.
> 
> why is wait_event_interruptible() treated differently compared to
> wait_for_completion_interruptible()?

No particular reason. I just taught stream_open.cocci to consider
only "wait_event_*" as blocking:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/stream_open.cocci?h=v5.1-rc5#n35

based on original /proc/xen/xenbus deadlock:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/xen/xenbus/xenbus_dev_frontend.c?h=v5.1-rc5#n135
https://git.kernel.org/linus/581d21a2d02a

We can extend "a function that blocks" rule to cover other kernel
primitives.

For the reference: the deadlock scenario is described in

https://git.kernel.org/linus/10dce8af3422

Kirill
