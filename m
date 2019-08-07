Return-Path: <SRS0=3xLC=WD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B814C32751
	for <linux-pci@archiver.kernel.org>; Wed,  7 Aug 2019 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A2321BE6
	for <linux-pci@archiver.kernel.org>; Wed,  7 Aug 2019 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfHGJPQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:15:16 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:36151 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfHGJPQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2019 05:15:16 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 22194100AFD86;
        Wed,  7 Aug 2019 11:15:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DC3054BEEC; Wed,  7 Aug 2019 11:15:13 +0200 (CEST)
Date:   Wed, 7 Aug 2019 11:15:13 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, yaohongbo@huawei.com,
        guohanjun@huawei.com, huawei.libin@huawei.com
Subject: Re: [RFC PATCH] pciehp: use completion to wait irq_thread
 'pciehp_ist'
Message-ID: <20190807091513.m2aqfbk32y6qb343@wunner.de>
References: <1562226638-54134-1-git-send-email-wangxiongfeng2@huawei.com>
 <20190806072428.2v7k775tvvgkbloh@wunner.de>
 <b522942f-053d-0e05-746d-7702ee9f8e61@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b522942f-053d-0e05-746d-7702ee9f8e61@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 07, 2019 at 04:28:32PM +0800, Xiongfeng Wang wrote:
> On 2019/8/6 15:24, Lukas Wunner wrote:
> > I'd suggest something like the below instead, could you give it a whirl
> > and see if it reliably fixes the issue for you?
> 
> I tested the below patch. It can fix the issue.

Thank you!  I'll submit it as a proper patch then.


> I am not sure whether the following sequence will be a problem.
> * pciehp_ist() is running, and 'ctrl->pending_events' is cleared
> * a request to disable the slot is submitted via sysfs.
>   'ctrl->pending_events' is set and the irq_thread 'pciehp_ist' is waken up.
>   But pciehp_ist() is running. So it doesn't take effect.
>   'ctrl->pending_events' is not cleared until next time pciehp_ist() is
>   waken up. So pciehp_sysfs_enable_slot() will wait until next
>   pciehp_ist() is waken up. I am not sure how 'irq_wake_thread()' will
>   effect the running irq_thread.

That's not a problem.  If irq_wake_thread() is called while pciehp_ist()
is running, the latter will automatically perform another iteration.
It's the same situation if an interrupt is received while pciehp_ist()
is running.

irq_wake_thread() sets the IRQTF_RUNTHREAD flag and irq_wait_for_interrupt()
checks that flag and causes irq_thread() to perform another invocation
of handler_fn(), which is pciehp_ist() in this case.

So pciehp basically treats a user request like an interrupt received from
the hardware.  It's meant to simplify the pciehp code.  But it's non-trivial
to understand because one needs to have an understanding of the genirq
code to appreciate the simplicity.

Let me know if this explanation wasn't clear enough and you have further
questions.


> How about making the process synchronous instead of waking up the
> irq_thread?

That's what we had before, but it has its own problems since it requires
locking and interaction between the IRQ thread and the sysfs entry points.

Thanks,

Lukas
