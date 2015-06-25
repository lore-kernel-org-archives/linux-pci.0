Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:30466 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbbFYBSN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2015 21:18:13 -0400
Message-ID: <558B56CC.8080808@huawei.com>
Date: Thu, 25 Jun 2015 09:18:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rajat Jain <rajatxjain@gmail.com>, PCI <linux-pci@vger.kernel.org>
Subject: Re: pciehp command complete timeout issue
References: <5582B43F.4090303@huawei.com> <20150624230534.GQ7710@google.com>
In-Reply-To: <20150624230534.GQ7710@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/25 7:05, Bjorn Helgaas wrote:
> On Thu, Jun 18, 2015 at 08:06:23PM +0800, Yijing Wang wrote:
>> When I tried to unbind pciehp driver on a pcie root port(bound pciehp driver),
>> a lot timeout warning appeared.
>>
>> The first timeout value is 102387672 msec :(
>> I debug and found that when pciehp complete pcie_enable_notification(), there was no command complete interrupt
>> be triggered, so cmd_busy always be set, and once another command post, a very long timeout warning noised.
>>
>>
>>  +-[0000:40]-+-00.0-[41]--
>>  |           +-01.0-[42-43]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>  |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>  |           +-03.0-[44-45]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>  |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>
>> [root@hulk slots]# ls
>> 0  0-1  0-2  0-3  0-4  0-5  1  10  11  12  13  14  15  16  2  3  4  5  6  7  8  9
>> [root@hulk slots]# cat 6/address
>> 0000:44:00
>> [root@hulk slots]#
>>
>> [root@hulk pciehp]# echo 0000:40:03.0:pcie04 > unbind
>> [root@hulk pciehp]#
>>
>> ...
>> [102413.749632] pciehp 0000:40:03.0:pcie04: unloading service driver pciehp
>> [102413.749638] pciehp_remove dev 0000:40:03.0, cmd_busy 1
>> [102413.754929] pcie_disable_notification: ctrl cmd busy 1
>> [102413.765903] pciehp 0000:40:03.0:pcie04: Timeout on hotplug command 0x11f1 (issued 102387672 msec ago)
> 
> The fact that you got this timeout message means the controller did
> not set the "No Command Completed Support" bit, right?  If we had
> NO_CMD_CMPL(ctrl), pcie_wait_cmd() becomes a no-op, and we would
> never print any timeout message.
> 
> Since the "No Command Completed Support" bit is NOT set, we expect
> to get an interrupt after every command completes.
> 
> This sounds like the Intel CF118 erratum mentioned just above that timeout
> message:
> 
>          * Controllers with errata like Intel CF118 don't generate
>          * completion notifications unless the power/indicator/interlock
>          * control bits are changed.  On such controllers, we'll emit this
>          * timeout message when we wait for completion of commands that
>          * don't change those bits, e.g., commands that merely enable
>          * interrupts.
> 
> So to me, this sounds like pciehp is working correctly.  What did you
> expect to happen instead?

I think if we could warn the timeout messages when the timeout is reached, not be detected in
next command write, it would be better.

Something like:

Write A command
trigger a timeout delay work event
interrupt coming (clean the cmd_busy, cancel the timeout delay work event)
timeout delay event work (detect whether the cmd_busy is still set, if yes, warn the timeout message)
..

But this is just my personal 3 seconds idea, it may make code more complex, I am not sure it's worth doing.

Thanks!
Yijing.


> 
>> [102413.775171] pcie_do_write_cmd: dev 0000:40:03.0, cmd_busy set to 1
>> [102415.377950] pciehp 0000:40:03.0:pcie04: Timeout on hotplug command 0x01c0 (issued 1600 msec ago)
>> ...
>>
>> -- 
>> Thanks!
>> Yijing
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

