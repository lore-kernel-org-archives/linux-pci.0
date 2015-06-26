Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:9105 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbbFZCHw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jun 2015 22:07:52 -0400
Message-ID: <558CB3EF.8050406@huawei.com>
Date: Fri, 26 Jun 2015 10:07:43 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rajat Jain <rajatxjain@gmail.com>, PCI <linux-pci@vger.kernel.org>
Subject: Re: pciehp command complete timeout issue
References: <5582B43F.4090303@huawei.com> <20150624230534.GQ7710@google.com> <558B56CC.8080808@huawei.com> <CAErSpo57xfCLQNbXOC2LpHryBBbxGaJMDdM-NVkTrjziOsv8sw@mail.gmail.com>
In-Reply-To: <CAErSpo57xfCLQNbXOC2LpHryBBbxGaJMDdM-NVkTrjziOsv8sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> The fact that you got this timeout message means the controller did
>>> not set the "No Command Completed Support" bit, right?  If we had
>>> NO_CMD_CMPL(ctrl), pcie_wait_cmd() becomes a no-op, and we would
>>> never print any timeout message.
>>>
>>> Since the "No Command Completed Support" bit is NOT set, we expect
>>> to get an interrupt after every command completes.
>>>
>>> This sounds like the Intel CF118 erratum mentioned just above that timeout
>>> message:
>>>
>>>          * Controllers with errata like Intel CF118 don't generate
>>>          * completion notifications unless the power/indicator/interlock
>>>          * control bits are changed.  On such controllers, we'll emit this
>>>          * timeout message when we wait for completion of commands that
>>>          * don't change those bits, e.g., commands that merely enable
>>>          * interrupts.
>>>
>>> So to me, this sounds like pciehp is working correctly.  What did you
>>> expect to happen instead?
>>
>> I think if we could warn the timeout messages when the timeout is reached, not be detected in
>> next command write, it would be better.
>>
>> Something like:
>>
>> Write A command
>> trigger a timeout delay work event
>> interrupt coming (clean the cmd_busy, cancel the timeout delay work event)
>> timeout delay event work (detect whether the cmd_busy is still set, if yes, warn the timeout message)
>> ..
>>
>> But this is just my personal 3 seconds idea, it may make code more complex, I am not sure it's worth doing.
> 
> It would make the code more complex, I think.  If you want to code it
> up, we could see what it would look like.

Make code more complex maybe is not a good idea, after all, this just is a alarming message issue.

> 
> I think the real problem is the message itself.  We could emit the
> message one second after pciehp claims the device (as you propose), or
> the next time pciehp issues a command (as we do today).  EIther way, I
> think users will see this as a problem.  You did, and I'm sure I
> would, too.

Agree.

> 
> Maybe there's some alternate wording that would be less alarming.
> 
> Or maybe we should emit the timeout message only if the previous
> command actually changed PCC, PIC, AIC, or EIC, i.e., assume the Intel
> CF118 erratum.

I like this, because we only touch PCC, PIC, AIC, EIC when we do hotplug,
all other slot control bits ABPE, PFDE, MRLSCE, PDCE, CCIE, HPIE, DLLSCE
only be touched when pciehp probe or reset.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

