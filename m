Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A5CC43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 19:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96120817
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 19:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA96120817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sedsystems.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeK0GcV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:32:21 -0500
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:12583 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeK0GcV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Nov 2018 01:32:21 -0500
X-Greylist: delayed 736 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 01:32:20 EST
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id wAQJOUjo008825
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Nov 2018 13:24:30 -0600 (CST)
Received: from eng1n65.eng.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id wAQJOUqZ006587
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 26 Nov 2018 13:24:30 -0600
Subject: Re: iMX6 PCIe MSI issues
To:     Trent Piepho <tpiepho@impinj.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
References: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
 <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
 <1543252169.18519.49.camel@impinj.com>
From:   Robert Hancock <hancock@sedsystems.ca>
Openpgp: preference=signencrypt
Autocrypt: addr=hancock@sedsystems.ca; prefer-encrypt=mutual; keydata=
 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
Organization: SED Systems
Message-ID: <4a582df8-f7dc-3ad5-42d7-33924eb57b0a@sedsystems.ca>
Date:   Mon, 26 Nov 2018 13:24:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543252169.18519.49.camel@impinj.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018-11-26 11:09 a.m., Trent Piepho wrote:
> There is a bug that appeared in 4.14 that will result in an MSI getting
> dropped if it occurs during or shortly after that/another MSI interrupt
> handler is run.  Obviously, then means one needs to get at least one
> MSI to work in the first place to see the bug!
> 
> Robert's description also has MSI status set in dwc msi status register
> (0x830), that would not be the case for the MSI race.
> 
> An interrupt is only passed up to the GIC on a 0->1 transition in the
> dwc msi status bit.  We see it's a 1 now, but was the GIC interrupt
> enabled when the transition happened?  It's not said below if that was
> checked.
> 
> Try clearing the status (write a *1* to the bit clear it) in the dwc
> msi status register, check that it is now zero, and then see if another
> MSI causes it to become set, and does that make it to the GIC?

I've tried that (writing ones to the status register, verifying it goes
to zero, raising another interrupt) and it doesn't seem to make it to
the GIC even though the status register has transitioned from zero to
non-zero.

> 
> If it does become set, but no irq to the GIC, then I have no idea what
> is there to stop it.  This part of the chip is not documented well.
> 
> Also, I think the new irq domain stuff in 4.17 breaks irq accounting to
> the GIC chain interrupt (152) to the dwc msi domain.  It'll always show
> as zero in /proc/interrupts.  But I've mostly been working in 4.16 so
> I'm not sure about the precise interaction of irq domains and
> /proc/interrupts yet.

I'm not actually seeing the MSI interrupt showing up in /proc/interrupts
at all in 4.19. From adding some debug output into the dwc PCIe code, it
appears it's using Linux IRQ 24 as the chaining interrupt, but there's
no entry in /proc/interrupts for either Linux IRQ 24 or GIC vector 152.
Not sure if there is supposed to be or not. It does appear that the
vector isn't masked in the GIC in any case, however, and when I force
the interrupt into the GIC pending register, things seem to happen
properly after that.

> 
> On Mon, 2018-11-26 at 14:31 -0200, Fabio Estevam wrote:
>> Adding Trent and Tim (as I think they managed to fix some imx6 MSI
>> issues)
>>
>> On Fri, Nov 23, 2018 at 8:17 PM Robert Hancock <hancock@sedsystems.ca
>>> wrote:
>>>
>>> I am working with a custom FPGA PCI Express endpoint connected to
>>> an NXP
>>> iMX6D processor running the 4.19.2 kernel. It seems happy using
>>> INTx
>>> interrupts but when trying to enable MSI the device driver is not
>>> receiving any interrupts.
>>>
>>> From some register poking I have figured out:
>>> -the MSI address set on the PCIe device is correctly set in the iMX
>>> MSI
>>> controller's MSI Controller Address register (0x1ffc820)
>>> -the interrupt vectors are enabled in the MSI controller's
>>> Interrupt
>>> Enable register (0x1ffc828)
>>> -the interrupt vectors are not masked in the MSI controller's
>>> Interrupt
>>> Mask register (0x1ffc82c)
>>> -The MSI controller's Interrupt Status register (0x1ffc830) shows
>>> that
>>> the requested interrupt vectors are pending
>>> -In the ARM GIC, vector 152 (for msi_ctrl_int) is enabled in the IS
>>> enable register (0x00a01110), but not set in the IS pending
>>> (0x00a01210)
>>> or IS active (0x00a01310) registers
>>> -Vector 152 is not masked in the GPC interrupt mask (0x00a01310)
>>> -Vector 152 is not active in the GPC interrupt status (0x00a01310)
>>>
>>> So it appears the MSI controller is receiving and recognizing the
>>> MSI
>>> from the device, but the interrupt is not making it into the GIC
>>> for
>>> some reason. If I manually set vector 152 to pending in the GIC,
>>> the
>>> dw_handle_msi_irq handler in pci-designware-host.c does get called
>>> along
>>> with the interrupt handler(s) for the PCIe device, so it appears
>>> the
>>> chain from that point on is working:
>>>
>>> # devmem 0x00a01210 32 0x1000000
>>>
>>> I found someone else reporting this in 2014 with an unknown kernel
>>> version on the NXP forums here, but with no resolution listed
>>> there:
>>>
>>> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fco
>>> mmunity.nxp.com%2Fthread%2F318307&amp;data=02%7C01%7Ctpiepho%40impi
>>> nj.com%7Cb1e4af4c58704651bc4e08d653bcaabe%7C6de70f0f73574529a415d8c
>>> bb7e93e5e%7C0%7C0%7C636788467119945424&amp;sdata=I1b%2BZ1L99MErNA44
>>> JlffTejqZlFSWhSkLeSFmv830Rg%3D&amp;reserved=0
>>>
>>> Any ideas on what may be going wrong? My next step may be to try an
>>> older kernel version to see if this got broken at some point.
>>>
>>> --
>>> Robert Hancock
>>> Senior Software Developer
>>> SED Systems
>>> Email: hancock@sedsystems.ca
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flis
>>> ts.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
>>> kernel&amp;data=02%7C01%7Ctpiepho%40impinj.com%7Cb1e4af4c58704651bc
>>> 4e08d653bcaabe%7C6de70f0f73574529a415d8cbb7e93e5e%7C0%7C0%7C6367884
>>> 67119945424&amp;sdata=6jndN8yOGxm60y%2B2fUuWTZnNvAs967PL6KnoncXyb6w
>>> %3D&amp;reserved=0

-- 
Robert Hancock
Senior Software Developer
SED Systems
Phone: (306) 933-1567
Email: hancock@sedsystems.ca
