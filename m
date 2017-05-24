Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:33514 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdEXBPM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2017 21:15:12 -0400
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
To: Brian Norris <briannorris@chromium.org>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
 <20170523180048.GA115572@google.com>
 <3fea7598-501e-6131-612a-977f005e9a2b@rock-chips.com>
 <20170524010014.GA109842@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <30a7917c-4e2f-c0be-2d0b-04e05013708c@rock-chips.com>
Date: Wed, 24 May 2017 09:14:52 +0800
MIME-Version: 1.0
In-Reply-To: <20170524010014.GA109842@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brian,

在 2017/5/24 9:00, Brian Norris 写道:
> On Wed, May 24, 2017 at 08:54:14AM +0800, Shawn Lin wrote:
>> 在 2017/5/24 2:00, Brian Norris 写道:
>>> On Fri, May 19, 2017 at 02:58:27PM +0800, Shawn Lin wrote:
>>>> This patch checks the link status before reading and
>>>> writing configure space of devices attached to the RC.
>>>> If the link status is down, we shouldn't try to access
>>>> the devices.
>>>
>>> I'm curious, in what situations are you seeing the link down? In all the
>>> cases where I can manage to screw up my endpoint and see system aborts
>>> due to config accesses, this check still says the link is up. Presumably
>>> you have some test cases that benefit from this though.
>
> NB: Bjorn asked a similar question in a different form. The underlying
> concern though, is that this is racy.

yes, I saw that.

>
>> Of course. This patch doesn't prevent all these cases, for instance,
>> you do a memory read/write in the EP function driver, since it doesn't
>> call these two APIs at all.
>
> Of course. I'm only talking about config accesses.

okay.

>
>> The reason for me to added this check is that I saw a external abort
>> down to rockchip_pcie_rd_own_conf, of which I highly suspected was that
>> the link was re-init or total broken at that time.
>
> I've seen plenty of aborts in this function as well, but I've verified
> that the link was still reported "up" in all the cases I could reproduce.
>

I think it's reasonable as the link could be retrained automatically if
it's not totaly broken at all. Did you poweroff the endpoint and could
still pass this check?

> So, do you "suspect" or did you "prove"? e.g., log cases where this
> check actually helps?

I was powering off the devices and did a lspci, and saw the log cases
there. I will check this again.

>
> And to Bjorn's point: do you know *why* such cases were hit? That would
> help to understand if the cases you're worrying about are hopelessly
> racy, or if there's some way to ensure synchronization.
>
> Brian
>
>
>
