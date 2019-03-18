Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFAEC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 04:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F97120872
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 04:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfCREdR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:33:17 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:48209 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfCREdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 00:33:16 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A643A2800B3F5;
        Mon, 18 Mar 2019 05:33:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5B1DC11431F; Mon, 18 Mar 2019 05:33:14 +0100 (CET)
Date:   Mon, 18 Mar 2019 05:33:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [GIT PULL] PCI changes for v5.1
Message-ID: <20190318043314.noyj6t4sh26spuzt@wunner.de>
References: <20190308173154.GC214730@google.com>
 <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
 <b723cbf8-be2a-bbdb-8ad5-eac8eddf2bb3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b723cbf8-be2a-bbdb-8ad5-eac8eddf2bb3@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 17, 2019 at 07:22:17PM -0500, Alex G wrote:
> On 3/17/19 4:18 PM, Linus Torvalds wrote:
> > On Fri, Mar 8, 2019 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > 
> > >    - Report PCIe links that become degraded at run-time (Alexandru Gagniuc)
> > 
> > Gaah. Only now as I'm about to do the rc1 release am I looking at new
> > runtime warnings, and noticing that this causes
> > 
> >    genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
> >    pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
> > 
> > because you can't have a NULL handler for a level-triggered interrupt
> > (you need something to shut the interrupt off so that it doesn't keep
> > screaming!).
> 
> Thanks for the catch. I did not see the error on my test machines. I'll take
> a look tomorrow, and update through Bjorn. Seems like an easy fix.

My apologies for not spotting this during review.

This can't be fixed by setting the IRQF_ONESHOT flag because the IRQ is
always shared with pciehp, dpc and other port services, which do not set
the flag, so you'd get a flags mismatch error in __setup_irq().

The solution is thus to acknowledge the interrupt in
pcie_bw_notification_handler() and move the portion which may sleep
to a separate function which is used as IRQ thread.  In other words,
move the down_read() / up_read() portion to a separate function and
return IRQ_WAKE_THREAD instead of IRQ_HANDLED.

The reason why it didn't show up on your test machines is likely that
they're using MSI on all PCIe ports, whereas Linus' machines appear
to possess at least one PCIe port which uses legacy INTx interrupts.
(MSI sets IRQCHIP_ONESHOT_SAFE for the irq_chip.)

Thanks,

Lukas
