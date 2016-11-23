Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:54322 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbcKWCwS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 21:52:18 -0500
Subject: Re: [PATCH 3/3] PCI: rockchip: Add system PM support
To: Brian Norris <briannorris@chromium.org>
References: <1479863953-123874-1-git-send-email-shawn.lin@rock-chips.com>
 <1479863953-123874-3-git-send-email-shawn.lin@rock-chips.com>
 <20161123020835.GB119441@google.com>
 <1c4bd848-67f7-0d31-6392-d9550e4767a9@rock-chips.com>
 <20161123024527.GA18020@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <bf970e48-80a0-7a18-4d87-93a5748f01c2@rock-chips.com>
Date: Wed, 23 Nov 2016 10:51:50 +0800
MIME-Version: 1.0
In-Reply-To: <20161123024527.GA18020@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/11/23 10:45, Brian Norris 写道:
> On Wed, Nov 23, 2016 at 10:39:30AM +0800, Shawn Lin wrote:
>> 在 2016/11/23 10:08, Brian Norris 写道:
>>> On Wed, Nov 23, 2016 at 09:19:13AM +0800, Shawn Lin wrote:
>>>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>>>> index 71d056d..720535b 100644
>>>> --- a/drivers/pci/host/pcie-rockchip.c
>>>> +++ b/drivers/pci/host/pcie-rockchip.c
>
> ...
>
>>>> +static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
>>>> +{
>>>> +	u32 value;
>>>> +	int err;
>>>> +
>>>> +	/* send PME_TURN_OFF message */
>>>> +	writel(0x0, rockchip->msg_region + PCIE_RC_SEND_PME_OFF);
>>>> +
>>>> +	/* read LTSSM and wait for falling into L2 link state */
>>>> +	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_DEBUG_OUT_0,
>>>> +				 value, PCIE_LINK_IS_L2(value), 20,
>>>> +				 jiffies_to_usecs(5 * HZ));
>>>
>>> You really want to wait a whole 5 seconds for this? Last I saw, you were
>>> doing testing with about 500ms or less. As I read the spec, there's cap
>>> on per-device time to ACK the request, and I recall that was on the
>>> order of 10s of milliseconds. But technically that can add up if you
>>> have a large hierarchy of devices attached...
>>>
>>
>> I have no very clear thought about how long we should set up the
>> timeout for PME_ACK. As you point out that a large hierarchy of devices
>> need quite a long time I guess.
>>
>> A possible work for PCIe core is walk through the hierarchy of devices
>> and calculate the max ACK timeout(including the latency of HUB).. But
>> I guess ACPI-base platforms don't need linux-pci to handle L2 stuff at
>> S3 at all, instead it will be handled by firmware, so still I don't
>> know how they will calculate it.
>
> I'm not sure if that's necessary. I was just curious on how this got
> determined, when it seemed that 500ms was plenty.
>

Refer to https://lists.launchpad.net/kernel-packages/msg123315.html

"When the host (Linux/Driver) sends the PME_TURN_OFF message it should
wait for PME_TO_ACK from the device. Microsoft Windows versions 
typically wait for 5 seconds."

This is the reason for why I added 5s for timeout.

> We shouldn't be hitting this (and if we do, then that means we'd
> probably need to reassess anyway), so maybe "too large" is fine.
>
> Brian
>
>
>


-- 
Best Regards
Shawn Lin

