Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D4C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306A12086C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 18:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306A12086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeKHERp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:17:45 -0500
Received: from foss.arm.com ([217.140.101.70]:56872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeKHERp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 23:17:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CDF6A78;
        Wed,  7 Nov 2018 10:46:07 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7413F5C0;
        Wed,  7 Nov 2018 10:46:05 -0800 (PST)
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <6f8f5c2c-6164-dae8-72d8-a49832d0d760@arm.com>
Date:   Wed, 7 Nov 2018 18:46:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/11/18 12:57, Gustavo Pimentel wrote:
> On 06/11/2018 16:00, Marc Zyngier wrote:
>> On 06/11/18 14:53, Lorenzo Pieralisi wrote:
>>> [CC Marc]
>>>
>>> On Sat, Oct 27, 2018 at 12:00:57AM +0000, Trent Piepho wrote:
>>>> This reverts commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status
>>>> after it is handled, not before").
>>>>
>>>> This is a very real race that we observed quickly after switching from
>>>> 4.13 to 4.16.  Using a custom PCI-e endpoint and driver, I was able to
>>>> track it to the precise race and verify the fixed behavior, as will be
>>>> described below.
>>>>
>>>> This bug was originally fixed in 2013, in commit ca1658921b63 ("PCI:
>>>> designware: Fix missing MSI IRQs") The discussion of that commit,
>>>> archived in patchwork [1], is informative and worth reading.
>>>>
>>>> The bug was re-added in the '8c934 commit this is reverting, which
>>>> appeared in the 4.14 kernel.
>>>>
>>>> Unfortunately, Synopsys appears to consider the operation of this PCI-e
>>>> controller secret.  They provide no publicly available docs for it nor
>>>> allow the references manuals of SoCs using the controller to publish any
>>>> documentation of it.
>>>>
>>>> So I can not say certain this code is correctly using the controller's
>>>> features.  However, extensive testing gives me high confidence in the
>>>> accuracy of what is described below.
>>>>
>>>> If an MSI is received by the PCI-e controller while the status register
>>>> bit for that MSI is set, the PCI-e controller will NOT generate another
>>>> interrupt.  In addition, it will NOT queue or otherwise mark the
>>>> interrupt as "pending", which means it will NOT generate an interrupt
>>>> when the status bit is unmasked.
>>>>
>>>> This gives the following race scenario:
>>>>
>>>> 1.  An MSI is received by, and the status bit for the MSI is set in, the
>>>> DWC PCI-e controller.
>>>> 2.  dw_handle_msi_irq() calls a driver's registered interrupt handler
>>>> for the MSI received.
>>>> 3.  At some point, the interrupt handler must decide, correctly, that
>>>> there is no more work to do and return.
>>>> 4.  The hardware generates a new MSI.  As the MSI's status bit is still
>>>> set, this new MSI is ignored.
>>>> 6.  dw_handle_msi_irq() unsets the MSI status bit.
>>>>
>>>> The MSI received at point 4 will never be acted upon.  It occurred after
>>>> the driver had finished checking the hardware status for interrupt
>>>> conditions to act on.  Since the MSI status was masked, it does not
>>>> generated a new IRQ, neither when it was received nor when the MSI is
>>>> unmasked.
>>>>
>>>> It seems clear there is an unsolvable race here.
>>>>
>>>> After this patch, the sequence becomes as follows:
>>>>
>>>> 1.  An MSI is received and the status bit for the MSI is set in the
>>>> DWC PCI-e controller.
>>>> 2.  dw_handle_msi_irq() clears this MSI status bit.
>>>> 3.  dw_handle_msi_irq() calls a driver's registered interrupt handler
>>>> for the MSI received.
>>>> 3.  At some point, the interrupt handler must decide, correctly, that
>>>> there is no more work to do and return.
>>>> 4.  The hardware generates a new MSI.  This sets the MSI status bit and
>>>> triggers another interrupt in the interrupt controller(s) above the DWC
>>>> PCI-e controller.  As the the dwc-pcie handler is not re-entrant, it is
>>>> not run again at this time.
>>>> 6.  dw_handle_msi_irq() finishes.  The MSI status bit remains set.
>>>> 7.  The IRQ is re-raised and dw_handle_msi_irq() runs again.
>>>> 8.  dw_handle_msi_irq() invokes the MSI's registered interrupt handler
>>>> again as the status bit was still set.
>>>
>>> Not sure why (5) is not used in your lists, I assume because you want
>>> to highlight the race condition with the jump from 4 to 6 (or maybe
>>> you do not like number 5 :), just curious).
>>>
>>>> The observant will notice that point 4 present the opportunity for the
>>>> SoC's interrupt controller to lose the interrupt in the same manner as
>>>> the bug in this driver.  The driver for that interrupt controller will
>>>> be written to properly deal with this.  In some cases the hardware
>>>> supports an EOI concept, where the 2nd IRQ is masked and internally
>>>> queued in the hardware, to be re-raised at EOI in step 7.  In other
>>>> cases the IRQ will be unmasked and re-raised at step 4, but the kernel
>>>> will see the handler is INPROGRESS and not re-invoke it, and instead set
>>>> a PENDING flag, which causes the handler to re-run at step 7.
>>>>
>>>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_3333681_&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3fxVS1aKAoLsOD0JiRgCC9pnyPfwwNVecSPqFznQ3Kc&s=X9ZYshlrXFwQbZJTzWC3ZC77lveB4ZlqfYqGJiSuqY8&e=
>>>>
>>>> Fixes: 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled, not before")
>>>
>>> I have two questions:
>>>
>>> - Commit 8c934095fa2f has been in the kernel for a year and no
>>>   regression was reported. It was assumed to fix a problem so before
>>>   reverting it I want to make sure we are not breaking anything else.
>>> - Your reasoning seems correct but I would pick Marc's brain on this
>>>   because I want to understand if what this patch does is what IRQ core
>>>   expects it to do, especially in relation to the IRQ chaining you
>>>   are mentioning.
>>
>> It is hard to decide what the right solution is without understanding
>> exactly what this particular write actually does. It seems to be some
>> form of acknowledgement, but I'm only making an educated guess, and some
>> of the defines suggest that there might be another register for that.
> 
> This status register indicates whether exists or not a MSI interrupt on that
> controller [0..7] to be handle.

OK. What happen when the interrupt is masked? Does this interrupt appear
in the status register? And what is the effect of writing to that register?

> In theory, we should clear the interrupt flag only after the interrupt has
> actually handled (which can take some time to process on the worst case scenario).

At this stage, we do not care about performance, but correctness. If we
loose interrupts, then the driver is not correct, and we need to address
this first.

> However, the Trent's patch allows to acknowledge the flag and handle the
> interrupt later, giving the opportunity to catch a possible new interrupt, which
> will be handle by a new call of this function.
> 
>>
>> What I'm interested in is the relationship this has with the mask/unmask
>> callbacks, and whether masking the interrupt before acking it would help.
> 
> Although there is the possibility of mask/unmask the interruptions on the
> controller, from what I've seen typically in other dw drivers this is not done.
> Probably we don't get much benefit from using it.

I don't worry care about the drivers. I need to know what the HW does,
and how this maps to the Linux interrupt subsystem. At the moment, this
is just too blurry to be understandable.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
