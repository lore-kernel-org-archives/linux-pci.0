Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B19C04EB8
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 09:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FD22086D
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 09:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZA3ujX+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FD22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeLLJPT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:15:19 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:60462 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLJPT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2018 04:15:19 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 35F1124E209C;
        Wed, 12 Dec 2018 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544606119; bh=0ie0/hrcVjNPP7dnFRewnvBLEyluZ1ydaNI1tzoh/0I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ZA3ujX+fMbeIiRA3kSsqmHhAYwZ9pEilEmA1Nn/h3u6bYMJh7WCo0Co6tWzoZUprP
         Vt1YPKmcD6mLL9JwvxofDBJqJc8jehlcStJWM3f8LrbDp8H6X81Upo1Qm/Ie55nRNJ
         O8VBYu++HDjCMiAY4U4O50l/V39p9DqmLOMVBuxgn3xbhfYXrvuQ7DcDfHc4EhQUNP
         qEOV7CNNdt9mAc6Sb7qRWlQsRvKQ2q8QIUyvpa5OQG+AfrBrFVdACslxyHsGETWBOW
         BMOo10P+/mPI+rQOb1xH5o7Y7PWjY8mAyhCUj0dXkrbi9505iBjvez4P9l6Xq/upHY
         aLYOfF9xKs3/g==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7DD8F3AD9;
        Wed, 12 Dec 2018 01:15:16 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 01:15:16 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 10:15:14 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Dec 2018 10:15:14 +0100
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Trent Piepho <tpiepho@impinj.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <20181210161753.GA12563@e107981-ln.cambridge.arm.com>
 <1544465752.18519.188.camel@impinj.com>
 <bf6cf5c9-6f82-79b3-c23e-05c48bf9f0f2@arm.com>
 <1544474054.18519.199.camel@impinj.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <bdffa5ff-1119-a711-5b03-7d651edfc15e@synopsys.com>
Date:   Wed, 12 Dec 2018 09:10:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <1544474054.18519.199.camel@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Trent,

On 10/12/2018 20:34, Trent Piepho wrote:
> On Mon, 2018-12-10 at 18:31 +0000, Marc Zyngier wrote:
>>
>>> I had concerns about what appears to be an unnecessary extra lock taken
>>> before handling an interrupt and enabling all MSIs even if nothing has
>>> tried to enable them.
>>
>> Regarding the lock: I'm quite puzzled that you consider it
>> "unnecessary", given that all the DWC callbacks expect such a locking. I
>> suspect you are considering from a pure performance angle, and I'd
>> suggest that you post numbers showing the unacceptable overhead of an
>> otherwise uncontended lock.
> 
> The difference is that the other callbacks can be called outside the
> path of handling an interrupt.  Any thread could possibly make a call
> to mask the interrupt at any time, so the lock is needed.
> 
> But the ack is only called in the path of handling an irq.  That's why
> its different.  There's already a system insuring that callback is not
> called reentrantly.  If the lock was ever taken when it was attempted
> to be locked, then we'd already be broken.
> 
>> As for enabling all MSIs upfront, same thing. Please demonstrate how
>> harmful it is, given that they are all masked by default, consistently
>> with what other interrupt controllers are doing.
> 
> Without any information on the controller, who knows what the
> differences between a masked and enabled vs a disabled msi are?  I
> don't know there is a difference, but on the other hand, you don't know
> there isn't.  It's like a dozen lines of code to not change the
> behavior.

That is not true, I've replied on 13/18/2018 with that information.

I leave here again the information provided.

*PCIE_MSI_INTRx_MASK*
When an MSI is received for a masked interrupt, the corresponding status bit
gets set in the interrupt status register but the controller will not signal it.
As soon as the masked interrupt is unmasked and assuming the status bit is still
set the controller will signal it.

*PCIE_MSI_INTRx_ENABLE*
Enables/disables every interrupt. When an MSI is received from a disabled
interrupt, no status bit gets set in MSI controller interrupt status register,
in another word, the interruption will be lost.

Regards,
Gustavo

> 

