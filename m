Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032EC32789
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 11:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451AC2086A
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 11:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gl/GAvdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451AC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeKHVZL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:25:11 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:48560 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeKHVZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 16:25:11 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DB64310C1336;
        Thu,  8 Nov 2018 03:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541677804; bh=9yz5wS2A11JWHMVSRbUI/o2l2R81IN6sqY23F8OSKFk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Gl/GAvdWPUgNMSDdglPK/NyKBVjNe7kaWQxAXGHBv9DVVXPoNn7jtYQTMK6VcCBvs
         j/Mmh9nD7GYXRXGB1q6VvMT+SWmTDGb4CvqDTaRfhaLEXVnJBi9etm1gqoYr61guxp
         xio2aNpvv3intmdEIjfjHqaCqC6MJRaIoEciPA9NXoqBrMHoNk395mzFqrUGOVsfQQ
         rl1iD3Z1acdwMxyj6ENvHic4/T6CN9C3+WLrauLkNm98AfUeQ6TlRNoRjE24D1we7/
         Jgt3G7MwUQE8agb59194kPEKBCKUo8SD0zByFLqt15zTaUCD7gPAKDdlqZDObrnvvF
         NIG+H2PRubDgQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id A93563246;
        Thu,  8 Nov 2018 03:50:03 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 8 Nov 2018 03:50:03 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 8 Nov 2018 12:50:01 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 8 Nov 2018 12:50:01 +0100
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Trent Piepho <tpiepho@impinj.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <725afc4a-ec19-e4e6-7091-f499bfb63652@synopsys.com>
 <1541615551.30311.286.camel@impinj.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <60173610-25c2-5f11-a55f-bd431199dc0c@synopsys.com>
Date:   Thu, 8 Nov 2018 11:46:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541615551.30311.286.camel@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07/11/2018 18:32, Trent Piepho wrote:
> On Wed, 2018-11-07 at 12:57 +0000, Gustavo Pimentel wrote:
>> On 06/11/2018 16:00, Marc Zyngier wrote:
>>> On 06/11/18 14:53, Lorenzo Pieralisi wrote:
>>>> On Sat, Oct 27, 2018 at 12:00:57AM +0000, Trent Piepho wrote:
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
> 
>> This status register indicates whether exists or not a MSI interrupt on that
>> controller [0..7] to be handle.
> 
> While the status for an MSI is set, no new interrupt will be triggered

Yes

> if another identical MSI is received, correct?

You cannot receive another identical MSI till you acknowledge the current one
(This is ensured by the PCI protocol, I guess).

> 
>> In theory, we should clear the interrupt flag only after the interrupt has
>> actually handled (which can take some time to process on the worst case scenario).
> 
> But see above, there is a race if a new MSI arrives while still masked.
>  I can see no possible way to solve this in software that does not
> involve unmasking the MSI before calling the handler.  To leave the
> interrupt masked while calling the handler requires the hardware to
> queue an interrupt that arrives while masked.  We have no docs, but the
> designware controller doesn't appear to do this in practice.

See my reply to Marc about the interrupt masking. Like you said, probably the
solution pass through using interrupt mask/unmask register instead of interrupt
enable/disable register.

Can you do a quick test, since you can easily reproduce the issue? Can you
change register offset on both functions dw_pci_bottom_mask() and
dw_pci_bottom_unmask()?

Basically exchange the PCIE_MSI_INTR0_ENABLE register by PCIE_MSI_INTR0_MASK.

Thanks.
Gustavo

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
>>
>> Gustavo
>>
>>>
>>> Gustavo, can you help here?
>>>
>>> In any way, moving the action of acknowledging the interrupt to its
>>> right spot in the kernel (dw_pci_bottom_ack) would be a good start.
>>>
>>> Thanks,
>>>
>>> 	M.
>>>
>>

