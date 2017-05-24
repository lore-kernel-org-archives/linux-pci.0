Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34433 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdEXB0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2017 21:26:00 -0400
Received: by mail-pf0-f182.google.com with SMTP id 9so130711147pfj.1
        for <linux-pci@vger.kernel.org>; Tue, 23 May 2017 18:26:00 -0700 (PDT)
Date: Tue, 23 May 2017 18:25:57 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
Message-ID: <20170524012556.GA128370@google.com>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
 <20170523180048.GA115572@google.com>
 <3fea7598-501e-6131-612a-977f005e9a2b@rock-chips.com>
 <20170524010014.GA109842@google.com>
 <30a7917c-4e2f-c0be-2d0b-04e05013708c@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <30a7917c-4e2f-c0be-2d0b-04e05013708c@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 09:14:52AM +0800, Shawn Lin wrote:
> 在 2017/5/24 9:00, Brian Norris 写道:
> >On Wed, May 24, 2017 at 08:54:14AM +0800, Shawn Lin wrote:
> >>The reason for me to added this check is that I saw a external abort
> >>down to rockchip_pcie_rd_own_conf, of which I highly suspected was that
> >>the link was re-init or total broken at that time.
> >
> >I've seen plenty of aborts in this function as well, but I've verified
> >that the link was still reported "up" in all the cases I could reproduce.
> >
> 
> I think it's reasonable as the link could be retrained automatically if
> it's not totaly broken at all. Did you poweroff the endpoint and could
> still pass this check?

I don't think I powered it off entirely, but I did try asserting its PD#
pin, which powers of most of the functionality -- enough that it
apparently causes aborts, but doesn't bring the link down.

> >So, do you "suspect" or did you "prove"? e.g., log cases where this
> >check actually helps?
> 
> I was powering off the devices and did a lspci, and saw the log cases
> there. I will check this again.
> 
> >
> >And to Bjorn's point: do you know *why* such cases were hit? That would
> >help to understand if the cases you're worrying about are hopelessly
> >racy, or if there's some way to ensure synchronization.

OK, so you've answered this question: losing power is hopelessly racy.

I guess it's up to Bjorn as to whether this racy check is useful at all
then.

Brian
