Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E28C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 00:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07402250F
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 00:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jt5dmjjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07402250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeKMKlH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:41:07 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37564 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 05:41:07 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4556510C09BD;
        Mon, 12 Nov 2018 16:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542069931; bh=SnbddjpwnGUQd7jaQzuH/zuFQjeyM9fUeb2bzi/QziA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=jt5dmjjYcre6jWLH75wJ8urD3GB5nYGjdt3uBs89yNZGp2NwxumPLeVmvpoORw6Ym
         9j1XqrImRduJFhPkAwhfJBIDH8QZ/u3gO55XyQphYp9JodBgnQj0VqUQoF9H9r1ykO
         GgeI9M+gzfUzDA9yuL/2c5Xo6dYlHhB+3yxagzjIf6GMqWmfgMMhXQd+tWPk/uxPSf
         Zsal7H0b+TISiuMqvQaLSndxTzDzdRnn4nQJ7EIA51EOAI27E1b04YkQih5TB1BbT6
         dMSy4EWLlAe1PuXv5ORwyaTHnXtQslm7NjWncX77x1uuMiSyzUrxxEW1RUTwIN4e0m
         9on9R5Vs7GdiA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 124EA512F;
        Mon, 12 Nov 2018 16:45:31 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 12 Nov 2018 16:45:31 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 13 Nov 2018 01:45:28 +0100
Received: from [10.4.120.67] (10.4.120.67) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 01:45:28 +0100
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Trent Piepho <tpiepho@impinj.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jpinto@synopsys.com" <joao.pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <1541533217.30311.263.camel@impinj.com>
 <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
 <1541621853.30311.294.camel@impinj.com>
 <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
 <1541706591.30311.308.camel@impinj.com>
 <b4dfa6e0-c569-c669-d3f1-b1016eecefa8@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <f474f03d-4b3f-9175-f91f-327f67060936@synopsys.com>
Date:   Tue, 13 Nov 2018 00:41:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b4dfa6e0-c569-c669-d3f1-b1016eecefa8@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.4.120.67]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/11/2018 11:34, Marc Zyngier wrote:
> On 08/11/18 19:49, Trent Piepho wrote:
>> On Thu, 2018-11-08 at 09:49 +0000, Marc Zyngier wrote:
>>> On 07/11/18 20:17, Trent Piepho wrote:
>>>> On Wed, 2018-11-07 at 18:41 +0000, Marc Zyngier wrote:
>>>>> On 06/11/18 19:40, Trent Piepho wrote:
>>>>>>
>>>>>> What about stable kernels that don't have the hierarchical API?
>>>>>
>>>>> My goal is to fix mainline first. Once we have something that works on
>>>>> mainline, we can look at propagating the fix to other versions. But
>>>>> mainline always comes first.
>>>>
>>>> This is a regression that went into 4.14.  Wouldn't the appropriate
>>>> action for the stable series be to undo the regression?
>>>
>>> This is not how stable works. Stable kernels *only* contain patches that
>>> are backported from mainline, and do not take standalone patch.
>>>
>>> Furthermore, your fix is to actually undo someone else's fix. Who is
>>> right? In the absence of any documentation, the answer is "nobody".
>>
>> Little more history to this bug.  The code was originally the way it is
>> now, but this same bug was fixed in 2013 in https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.kernel.or&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=Tk2dtPxJ5WvHjQbWWx35od-JZmur8mRuDrSSVhf8nYs&s=3nFZMUc2qvOXJht1WuNCDorudHeFiWyeDaO1UbhTXmw&e=
>> g/patch/3333681/
>>
>> Then that lasted four years until it was changed Aug 2017 in https://urldefense.proofpoint.com/v2/url?u=https-3A__pa&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=Tk2dtPxJ5WvHjQbWWx35od-JZmur8mRuDrSSVhf8nYs&s=yfWJAoFIGjLbTnuE_KLzhW7J_pyMD3X1dXm4eHoy7_o&e=
>> tchwork.kernel.org/patch/9893303/
>>
>> That lasted just six months until someone tried to revert it, https://urldefense.proofpoint.com/v2/url?u=https-3A__p&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=Tk2dtPxJ5WvHjQbWWx35od-JZmur8mRuDrSSVhf8nYs&s=q1LGEb9w_CjcwmWVFOM5VWJ17oS9XHd8SsWTsBF8zfU&e=
>> atchwork.kernel.org/patch/9893303/
>>
>> Seems pretty clear the way it is now is much worse than the way it was
>> before, even if the previous design may have had another flaw.  Though
>> I've yet to see anyone point out something makes the previous design
>> broken.  Sub-optimal yes, but not broken.
> 
> This is not what was reported by the previous submitter. I guess they
> changed this for a reason, no? I'm prepared to admit this is a end-point
> driver bug, but we need to understand what is happening and stop
> changing this driver randomly.
> 
>>> Anything can be backported to stable once we understand the issue. At
>>> the moment, we're just playing games moving stuff around and hope
>>> nothing else will break. That's not a sustainable way of maintaining
>>> this driver. At the moment, the only patch I'm inclined to propose until
>>> we get an actual interrupt handling flow from Synopsys is to mark this
>>> driver as "BROKEN".
>>
>> It feels like you're using this bug to hold designware hostage in a
>> broken kernel, and me along with them.  I don't have the documentation,
>> no one does, there's no way for me to give you want you want.  But I've
>> got hardware that doesn't work in the mainline kernel.
> 
> I take it as a personal offence that I'd be holding anything or anyone
> hostage. I think I have a long enough track record working with the
> Linux kernel not to take any of this nonsense. What's my interest in
> keeping anything in this sorry state? Think about it for a minute.
> 
> When I'm asking for documentation, I'm not asking you. I perfectly
> understood that you don't have any. We need Synopsys to step up and give
> us a simple description of what the MSI workflow is. Because no matter
> how you randomly mutate this code, it will still be broken until we get
> a clear answer from *Synopsys*.
> 
> Gustavo, here's one simple ask. Please reply to this email with a step
> by step, register by register description of how an MSI must be handled
> on this HW. We do need it, and we need it now.

Hi Marc, I thought that I did respond to your question on Nov 8. However I will
repeat it and add some extra information to it now.

About the registers:

PCIE_MSI_INTR0_MASK
When an MSI is received for a masked interrupt, the corresponding status bit
gets set in the interrupt status register but the controller will not signal it.
As soon as the masked interrupt is unmasked and assuming the status bit is still
set the controller will signal it.

PCIE_MSI_INTR0_ENABLE
Enables/disables every interrupt. When an MSI is received from a disabled
interrupt, no status bit gets set in MSI controller interrupt status register.

About this new callbacks:

The dw_pci_bottom_mask() and dw_pci_bottom_unmask() callbacks were added on
Linux kernel v4.17 on PCI: dwc: Move MSI IRQs allocation to IRQ domains
hierarchical API patch [1] and based on what I've seen so far, before this patch
there were no interrupt masking been performed.

Based on the information provided, its very likely that I should use the
PCIE_MSI_INTR0_MASK register instead of PCIE_MSI_INTR0_ENABLE on the
dw_pci_bottom_mask() and dw_pci_bottom_unmask() callbacks. As soon as I return
from Linux plumbers conference, I will test the system using the
PCIE_MSI_INTR0_MASK register.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.20-rc2&id=7c5925afbc58c6d6b384e1dc051bb992969bf787

Is there anything else that has not been clarified yet?

Regards,
Gustavo

> 
> Thanks,
> 
> 	M.
> 

