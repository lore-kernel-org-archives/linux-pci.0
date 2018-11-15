Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CC6C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE90223CB
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 15:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="f07DkMwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE90223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbeKPBek (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:34:40 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37724 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 20:34:40 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8976F24E116D;
        Thu, 15 Nov 2018 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542295582; bh=VZhk0Jd0RJXrwsTCFHNdCeYZs6Q2XNi2h3tFSDuyvoQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=f07DkMwJOleAdIHbkp5BJdvnXEdpqbpJSwEQ1W2QvAlhYuwNPOH0m7Ghj/etAe+xr
         Yy7/09bo9bGnMEBVcyN//Lp3CUzfFlARKur357AUT8asKf72Z3BVejuZk79WaeFrKY
         QZNVJOZq8xRlBTqbCGSrpT8uWNyllK5knJzduZETSbitzfTrgqX6i1EyYCJH70K/9W
         P8xNLX51cnU5zuuwSi3U9HCdwWD0UbaKdFu8bdXNuYriUyra8b8lk+B0HWSOmV0J2j
         cbyFfnOtsxbDWS/m/TRleUttXRaoGbOYjj8RieTWaNJqsTzwqeBiA2Hr6Qptz60qqn
         Ci+0fuVMVPI0A==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6237C5CCF;
        Thu, 15 Nov 2018 07:26:22 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 07:26:22 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 15 Nov 2018 16:26:20 +0100
Received: from [10.4.120.14] (10.4.120.14) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 15 Nov
 2018 16:26:19 +0100
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Trent Piepho <tpiepho@impinj.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@google.com" <helgaas@google.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <1542220084.30311.453.camel@impinj.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <a5f464c5-bc21-5986-7974-6fbabc450147@synopsys.com>
Date:   Thu, 15 Nov 2018 15:22:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542220084.30311.453.camel@impinj.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.4.120.14]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/11/2018 18:28, Trent Piepho wrote:
> On Tue, 2018-11-13 at 22:57 +0000, Marc Zyngier wrote:
>> It recently came to light that the Designware PCIe driver is rather
>> broken in the way it handles MSI[1]:
>>
>> - It masks interrupt by disabling them, meaning that MSIs generated
>>   during the masked window are simply lost. Oops.
>>
>> - Acking of the currently pending MSI is done outside of the
>> interrupt
>>   flow, getting moved around randomly and ultimately breaking the
>>   driver. Not great.
>>
>> This series attempts to address this by switching to using the MASK
>> register for masking interrupts (!), and move the ack into the
>> appropriate callback, giving it a fixed place in the MSI handling
>> flow.
>>
>> Note that this is only compile-tested on my arm64 laptop, as I'm
>> travelling and do not have the required HW to test it anyway. I'd
>> welcome both review and testing by the interested parties (dwc
>> maintainer and users affected by existing bugs).
>>
> 
> I've started to test this series after porting all the patches needed
> to make IMX7d work from 4.16.8 to 4.20.0-rc2.
> 
> Took a little while to figure out that the pcieport driver has a new
> config entry to enable, or one gets no interrupts.  I'm not sure if
> this is entirely correct behavior.
> 
> The new domain stuff does not appear to integrate into the existing irq
> framework perfectly.  My interrupt has changed from MSI #1 to MSI
> #524288.  Not the most user friendly number.
> 
> 292:          0          0   PCI-MSI   0 Edge      PCIe PME, aerdrv
> 293:          1          0   PCI-MSI 524288 Edge      impinj-rfid-modem
> 
> Previously the dwc controller would show up as the owner of GPCv2 IRQ
> 122.  It doesn't any more.  Seems like the kernel info for it is wrong.
> 
> /sys/kernel/irq/65/actions:(null)
> /sys/kernel/irq/65/chip_name:GPCv2
> /sys/kernel/irq/65/hwirq:122
> /sys/kernel/irq/65/per_cpu_count:0,0
> /sys/kernel/irq/65/type:edge
> 
> Should be level and the count should be 1,0.  The debugfs interface is
> more accurate:
> 
> # cat /sys/kernel/debug/irq/irqs/65
> handler:  dw_chained_msi_isr
> device:   (null)
> status:   0x00010c00
>             _IRQ_NOPROBE
>             _IRQ_NOREQUEST
>             _IRQ_NOTHREAD
> dstate:   0x03400204
>             IRQ_TYPE_LEVEL_HIGH
>             IRQD_ACTIVATED
>             IRQD_IRQ_STARTED
>             IRQD_SINGLE_TARGET
> 
> Still doesn't know what device it's for.
> 
> Now I can finally test it!
> 
> Confirmed interrupt race is still there in stock kernel.
> 
> Confirmed after my patch I didn't see the race.  Didn't check why the
> broken enable/disable as mask didn't appear cause a new race, but
> something must be wrong somewhere.
> 
> Tried your 1st patch.  As I mentioned before in a reply to Gustavo,
> just changing the enable to mask results in the MSI never getting
> enabled in the first place.  Nothing else writes to the enable
> register...
> 
> As a workaround, I added an irq_enable method to dw_pcie_msi_irq_chip
> that just chains to the parent, and then a hacky irq_enable in
> dw_pci_msi_bottom_irq_chip that manipulates the enable register.
> 
> Now it works again.  Race still present.  I don't see the
> dw_pci_msi_bottom_(un)mask methods ever get called.  I seem to recall
> that they are called as a substitute if enable/disable are not present,
> but haven't confirmed that, which would explain why they are not called
> after I added enable.

Hum, this probably is correlated with [1] where on the describition the this
enumerator says that "One shot does not require mask/unmask" see [2]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/msi.c?h=v4.20-rc2#n1453

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/irq.h?h=v4.20-rc2#n504

I'm still waiting for an internal confirmation from the IP team about the good
procedure to take on this matter.

As soon I get something I'll post here.

Regards,
Gustavo

> 
> Next tried your next two patches.  No longer see lost interrupts, as
> the status is cleared before the handler is called.
> 
> From what I see the clear of the status bit is effectively at the same
> point in the irq path as the way I cleared it in my patch.  There's
> just a longer call chain to get to it in the ack method.  Not that it's
> not a better place for it (which isn't there in 4.16), but I don't
> think it changes anything.  Is there some reason dw_pci_bottom_ack
> would not be called?
> 
> Since I don't see the un(mask) methods ever get called, I'm not sure if
> they are correct or not.  I also had some unanswered details of
> behavior on unmask.  I can see possible flaws, depending on how this
> works.
> 

