Return-Path: <SRS0=ZPBx=RJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0FCC43381
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6A0206DD
	for <linux-pci@archiver.kernel.org>; Wed,  6 Mar 2019 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LrC6MCLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfCFKBH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:01:07 -0500
Received: from smtprelay.synopsys.com ([198.182.37.59]:40364 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfCFKBD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2019 05:01:03 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2019 05:01:02 EST
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1EB941E262F;
        Wed,  6 Mar 2019 10:54:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551866067; bh=NSJioObb2dc3gNDXpbIh4eml9OXs4BNRB+njLxAJVfY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=LrC6MCLjolW2EhIUxrvW9LiHqEuCnK+5MDpmvAau/7Ix4E9h7FOSquY9mO6SEL0XK
         6/4HXA1lcUZg/1Dyr+lEGsVv4FthDIO5XtfJCB7Z5UDa9UuvMg3UdXyDQUmNxN92aK
         Gbgeog8nFOYaR2AgN8xd3Xtz/7y+VGx7ke1/bwj/DEOj5zbV7zAQT7UYwhgF/yycLt
         3DUtXhCw4r6UaXaT9vctwdLwy9zfMW1kxS3vU3AUufYcD4gcBYTuKdpLInWM5sLe1c
         sD78PVmj9jpDIInhLuG5v/9L1PV9i8+x40zFHJ4XPkw2W8wYP4aOql96dOyNhMH0DZ
         A+npvhHC6txqA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1B8D0A0062;
        Wed,  6 Mar 2019 09:54:23 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Mar 2019 01:53:43 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Mar 2019 10:53:41 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Mar 2019 10:53:41 +0100
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly
 disabled
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>
References: <20190227165219.31911-1-l.stach@pengutronix.de>
 <20190304192548.GB26569@google.com> <1551728385.9298.18.camel@pengutronix.de>
 <86ef7m1ji2.wl-marc.zyngier@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <9abfe0b2-edfc-a989-04d3-0dd143b7557b@synopsys.com>
Date:   Wed, 6 Mar 2019 09:53:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <86ef7m1ji2.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 04/03/2019 20:18, Marc Zyngier wrote:
> Hi both,
> 
> On Mon, 04 Mar 2019 19:39:45 +0000,
> Lucas Stach <l.stach@pengutronix.de> wrote:
>>

(snipped)

>>>>
>>>> As MSI and legacy IRQs are already mutually exclusive on the DWC core,
>>>> as the core won't forward any legacy IRQs once any MSI has been enabled,
>>>> users wishing to use legacy IRQs already need to explictly disable MSI
>>>> support (usually via the pci=nomsi kernel commandline option). To avoid
>>>> any issues with MSI conflicting with legacy IRQs, just skip all of the
>>>> DWC MSI initalization, including the IRQ line claim, when MSI is disabled.
>>>
>>> Does this mean that if we have a device that uses legacy IRQs, the
>>> user has to figure out to boot with "pci=nomsi"?
>>
>> As long as there is only a single device connected and there are no
>> port services things will work. If port services are active, those will
>> start to use MSIs, breaking legacy IRQs in the process.
>>
>> I've asked Synopsys if there is a workaround for this, but it seems
>> that the core is working "as designed" with no workaround for this icky
>> behavior.
> 
> Is this the general DWC controller behaviour? Or something that is
> specific to a given implementation? I can't believe someone actually
> thought this is an acceptable behaviour...
> 
> Gustavo, can you please check with your HW colleagues and let
> everybody know what's the official Synopsys position on this?
> 

Sure, I can ask the HW team to provide me more info about this, This can take a
while. Unfortunately on my setup I only have MSI and MSI-X, therefore I can't
really test what has been statemented.

Regards,
Gustavo
