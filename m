Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624DC32789
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 11:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FDC2146D
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 11:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XdQNmNVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FDC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeKHVDE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:03:04 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47994 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHVDE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 16:03:04 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0D99C10C083D;
        Thu,  8 Nov 2018 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541676481; bh=7q4ltoylc0rjRsLuZes2kVWhcU9dlpeJsZLSCLWShOE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=XdQNmNVt5MHw5zy/7hWuxwnkbSvk+etruZTwITlAmztFEOIdq1OMgRD/QNka1ggGX
         5mEYdxGqare+n/sY1kRXt/mDFDVsIoryce43TFazsfUauCET7SWvyVz6s5x2GxWwV8
         qepjmHWMQzPq3g60/TIBUcMr8v1A1tRrB6mLCFH6kbW6RlqzVVUD6bmkmOY23KC0wf
         m5UubpJNjxJOLzUF3WDEWUhcfz9aAVfr/hLggL30LDvtxSqYgy+31xwZYQKyikqwDK
         V9r75kvEOcn1fcfdU3Y0Rax1b8oF9WazCHiB8TTb3jmf9PtqTbm0SP+Vq7Qj3h0bgK
         3dgn9loXh+p8g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id AEFCB3F33;
        Thu,  8 Nov 2018 03:28:00 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 8 Nov 2018 03:28:00 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 8 Nov 2018 12:27:58 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 8 Nov 2018 12:27:58 +0100
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
 <6f8f5c2c-6164-dae8-72d8-a49832d0d760@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <d873eac1-fde2-4fd1-be9c-93bb86594513@synopsys.com>
Date:   Thu, 8 Nov 2018 11:24:00 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6f8f5c2c-6164-dae8-72d8-a49832d0d760@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/11/2018 18:46, Marc Zyngier wrote:
> On 07/11/18 12:57, Gustavo Pimentel wrote:
>> On 06/11/2018 16:00, Marc Zyngier wrote:
>>> On 06/11/18 14:53, Lorenzo Pieralisi wrote:
>>>> [CC Marc]
>>>>
>>>> On Sat, Oct 27, 2018 at 12:00:57AM +0000, Trent Piepho wrote:
>>>>> This reverts commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status
>>>>> after it is handled, not before").
>>>>>
>>>>> This is a very real race that we observed quickly after switching from
>>>>> 4.13 to 4.16.  Using a custom PCI-e endpoint and driver, I was able to
>>>>> track it to the precise race and verify the fixed behavior, as will be
>>>>> described below.
>>>>>
>>>>> This bug was originally fixed in 2013, in commit ca1658921b63 ("PCI:
>>>>> designware: Fix missing MSI IRQs") The discussion of that commit,
>>>>> archived in patchwork [1], is informative and worth reading.
>>>>>
>>>>> The bug was re-added in the '8c934 commit this is reverting, which
>>>>> appeared in the 4.14 kernel.
>>>>>
>>>>> Unfortunately, Synopsys appears to consider the operation of this PCI-e
>>>>> controller secret.  They provide no publicly available docs for it nor
>>>>> allow the references manuals of SoCs using the controller to publish any
>>>>> documentation of it.
>>>>>
>>>>> So I can not say certain this code is correctly using the controller's
>>>>> features.  However, extensive testing gives me high confidence in the
>>>>> accuracy of what is described below.
>>>>>
>>>>> If an MSI is received by the PCI-e controller while the status register
>>>>> bit for that MSI is set, the PCI-e controller will NOT generate another
>>>>> interrupt.  In addition, it will NOT queue or otherwise mark the
>>>>> interrupt as "pending", which means it will NOT generate an interrupt
>>>>> when the status bit is unmasked.
>>>>>
>>>>> This gives the following race scenario:
>>>>>
>>>>> 1.  An MSI is received by, and the status bit for the MSI is set in, the
>>>>> DWC PCI-e controller.
>>>>> 2.  dw_handle_msi_irq() calls a driver's registered interrupt handler
>>>>> for the MSI received.
>>>>> 3.  At some point, the interrupt handler must decide, correctly, that
>>>>> there is no more work to do and return.
>>>>> 4.  The hardware generates a new MSI.  As the MSI's status bit is still
>>>>> set, this new MSI is ignored.
>>>>> 6.  dw_handle_msi_irq() unsets the MSI status bit.
>>>>>
>>>>> The MSI received at point 4 will never be acted upon.  It occurred after
>>>>> the driver had finished checking the hardware status for interrupt
>>>>> conditions to act on.  Since the MSI status was masked, it does not
>>>>> generated a new IRQ, neither when it was received nor when the MSI is
>>>>> unmasked.
>>>>>
>>>>> It seems clear there is an unsolvable race here.
>>>>>
>>>>> After this patch, the sequence becomes as follows:
>>>>>
>>>>> 1.  An MSI is received and the status bit for the MSI is set in the
>>>>> DWC PCI-e controller.
>>>>> 2.  dw_handle_msi_irq() clears this MSI status bit.
>>>>> 3.  dw_handle_msi_irq() calls a driver's registered interrupt handler
>>>>> for the MSI received.
>>>>> 3.  At some point, the interrupt handler must decide, correctly, that
>>>>> there is no more work to do and return.
>>>>> 4.  The hardware generates a new MSI.  This sets the MSI status bit and
>>>>> triggers another interrupt in the interrupt controller(s) above the DWC
>>>>> PCI-e controller.  As the the dwc-pcie handler is not re-entrant, it is
>>>>> not run again at this time.
>>>>> 6.  dw_handle_msi_irq() finishes.  The MSI status bit remains set.
>>>>> 7.  The IRQ is re-raised and dw_handle_msi_irq() runs again.
>>>>> 8.  dw_handle_msi_irq() invokes the MSI's registered interrupt handler
>>>>> again as the status bit was still set.
>>>>
>>>> Not sure why (5) is not used in your lists, I assume because you want
>>>> to highlight the race condition with the jump from 4 to 6 (or maybe
>>>> you do not like number 5 :), just curious).
>>>>
>>>>> The observant will notice that point 4 present the opportunity for the
>>>>> SoC's interrupt controller to lose the interrupt in the same manner as
>>>>> the bug in this driver.  The driver for that interrupt controller will
>>>>> be written to properly deal with this.  In some cases the hardware
>>>>> supports an EOI concept, where the 2nd IRQ is masked and internally
>>>>> queued in the hardware, to be re-raised at EOI in step 7.  In other
>>>>> cases the IRQ will be unmasked and re-raised at step 4, but the kernel
>>>>> will see the handler is INPROGRESS and not re-invoke it, and instead set
>>>>> a PENDING flag, which causes the handler to re-run at step 7.
>>>>>
>>>>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.org_patch_3333681_&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3fxVS1aKAoLsOD0JiRgCC9pnyPfwwNVecSPqFznQ3Kc&s=X9ZYshlrXFwQbZJTzWC3ZC77lveB4ZlqfYqGJiSuqY8&e=
>>>>>
>>>>> Fixes: 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled, not before")
>>>>
>>>> I have two questions:
>>>>
>>>> - Commit 8c934095fa2f has been in the kernel for a year and no
>>>>   regression was reported. It was assumed to fix a problem so before
>>>>   reverting it I want to make sure we are not breaking anything else.
>>>> - Your reasoning seems correct but I would pick Marc's brain on this
>>>>   because I want to understand if what this patch does is what IRQ core
>>>>   expects it to do, especially in relation to the IRQ chaining you
>>>>   are mentioning.
>>>
>>> It is hard to decide what the right solution is without understanding
>>> exactly what this particular write actually does. It seems to be some
>>> form of acknowledgement, but I'm only making an educated guess, and some
>>> of the defines suggest that there might be another register for that.
>>
>> This status register indicates whether exists or not a MSI interrupt on that
>> controller [0..7] to be handle.
> 
> OK. What happen when the interrupt is masked? Does this interrupt appear
> in the status register? And what is the effect of writing to that register?

When an MSI is received for a masked interrupt, the corresponding status bit
gets set in the interrupt status register but the controller will not signal it.
As soon as the masked interrupt is unmasked and assuming the status bit is still
set the controller will signal it. Have I explain this clearly?

> 
>> In theory, we should clear the interrupt flag only after the interrupt has
>> actually handled (which can take some time to process on the worst case scenario).
> 
> At this stage, we do not care about performance, but correctness. If we
> loose interrupts, then the driver is not correct, and we need to address
> this first.

Ok, Marc. Let see if I can summarize it. You are suggesting to change the
register from PCIE_MSI_INTR0_ENABLE to PCIE_MSI_INTR0_MASK on
dw_pci_bottom_mask() and dw_pci_bottom_unmask() and clearing the interrupt
status bit inside of dw_pci_bottom_ack() instead of dw_handle_msi_irq(), right?

> 
>> However, the Trent's patch allows to acknowledge the flag and handle the
>> interrupt later, giving the opportunity to catch a possible new interrupt, which
>> will be handle by a new call of this function.
>>
>>>
>>> What I'm interested in is the relationship this has with the mask/unmask
>>> callbacks, and whether masking the interrupt before acking it would help.
>>
>> Although there is the possibility of mask/unmask the interruptions on the
>> controller, from what I've seen typically in other dw drivers this is not done.
>> Probably we don't get much benefit from using it.
> 
> I don't worry care about the drivers. I need to know what the HW does,
> and how this maps to the Linux interrupt subsystem. At the moment, this
> is just too blurry to be understandable.

Ok, let's clarify this then.

> 
> Thanks,
> 
> 	M.
> 

