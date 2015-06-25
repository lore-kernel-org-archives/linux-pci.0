Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35048 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbFYTSF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 15:18:05 -0400
Received: by wgbhy7 with SMTP id hy7so70643762wgb.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2015 12:18:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <558B56CC.8080808@huawei.com>
References: <5582B43F.4090303@huawei.com> <20150624230534.GQ7710@google.com> <558B56CC.8080808@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jun 2015 14:17:44 -0500
Message-ID: <CAErSpo57xfCLQNbXOC2LpHryBBbxGaJMDdM-NVkTrjziOsv8sw@mail.gmail.com>
Subject: Re: pciehp command complete timeout issue
To: Yijing Wang <wangyijing@huawei.com>
Cc: Rajat Jain <rajatxjain@gmail.com>, PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 8:18 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2015/6/25 7:05, Bjorn Helgaas wrote:
>> On Thu, Jun 18, 2015 at 08:06:23PM +0800, Yijing Wang wrote:
>>> When I tried to unbind pciehp driver on a pcie root port(bound pciehp driver),
>>> a lot timeout warning appeared.
>>>
>>> The first timeout value is 102387672 msec :(
>>> I debug and found that when pciehp complete pcie_enable_notification(), there was no command complete interrupt
>>> be triggered, so cmd_busy always be set, and once another command post, a very long timeout warning noised.
>>>
>>>
>>>  +-[0000:40]-+-00.0-[41]--
>>>  |           +-01.0-[42-43]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>>  |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>>  |           +-03.0-[44-45]--+-00.0  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>>  |           |               \-00.1  Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network Connection
>>>
>>> [root@hulk slots]# ls
>>> 0  0-1  0-2  0-3  0-4  0-5  1  10  11  12  13  14  15  16  2  3  4  5  6  7  8  9
>>> [root@hulk slots]# cat 6/address
>>> 0000:44:00
>>> [root@hulk slots]#
>>>
>>> [root@hulk pciehp]# echo 0000:40:03.0:pcie04 > unbind
>>> [root@hulk pciehp]#
>>>
>>> ...
>>> [102413.749632] pciehp 0000:40:03.0:pcie04: unloading service driver pciehp
>>> [102413.749638] pciehp_remove dev 0000:40:03.0, cmd_busy 1
>>> [102413.754929] pcie_disable_notification: ctrl cmd busy 1
>>> [102413.765903] pciehp 0000:40:03.0:pcie04: Timeout on hotplug command 0x11f1 (issued 102387672 msec ago)
>>
>> The fact that you got this timeout message means the controller did
>> not set the "No Command Completed Support" bit, right?  If we had
>> NO_CMD_CMPL(ctrl), pcie_wait_cmd() becomes a no-op, and we would
>> never print any timeout message.
>>
>> Since the "No Command Completed Support" bit is NOT set, we expect
>> to get an interrupt after every command completes.
>>
>> This sounds like the Intel CF118 erratum mentioned just above that timeout
>> message:
>>
>>          * Controllers with errata like Intel CF118 don't generate
>>          * completion notifications unless the power/indicator/interlock
>>          * control bits are changed.  On such controllers, we'll emit this
>>          * timeout message when we wait for completion of commands that
>>          * don't change those bits, e.g., commands that merely enable
>>          * interrupts.
>>
>> So to me, this sounds like pciehp is working correctly.  What did you
>> expect to happen instead?
>
> I think if we could warn the timeout messages when the timeout is reached, not be detected in
> next command write, it would be better.
>
> Something like:
>
> Write A command
> trigger a timeout delay work event
> interrupt coming (clean the cmd_busy, cancel the timeout delay work event)
> timeout delay event work (detect whether the cmd_busy is still set, if yes, warn the timeout message)
> ..
>
> But this is just my personal 3 seconds idea, it may make code more complex, I am not sure it's worth doing.

It would make the code more complex, I think.  If you want to code it
up, we could see what it would look like.

I think the real problem is the message itself.  We could emit the
message one second after pciehp claims the device (as you propose), or
the next time pciehp issues a command (as we do today).  EIther way, I
think users will see this as a problem.  You did, and I'm sure I
would, too.

Maybe there's some alternate wording that would be less alarming.

Or maybe we should emit the timeout message only if the previous
command actually changed PCC, PIC, AIC, or EIC, i.e., assume the Intel
CF118 erratum.

Bjorn
