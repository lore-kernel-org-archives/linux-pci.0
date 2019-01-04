Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8519C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 23:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749B621872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfADXXK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 18:23:10 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:48142 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfADXXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 18:23:09 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 3DF481C0144;
        Fri,  4 Jan 2019 16:23:07 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
From:   Stephen Warren <swarren@wwwdotorg.org>
To:     Trent Piepho <tpiepho@impinj.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "marex@denx.de" <marex@denx.de>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "swarren@nvidia.com" <swarren@nvidia.com>,
        "m.mann@arkona-technologies.de" <m.mann@arkona-technologies.de>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "xobs@kosagi.com" <xobs@kosagi.com>,
        "hrhaan@gmail.com" <hrhaan@gmail.com>,
        "jbe@pengutronix.de" <jbe@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
References: <20190104214509.16891-1-swarren@wwwdotorg.org>
 <1546641949.14247.20.camel@impinj.com>
 <1ff5138e-3de9-e7f9-38e6-feee4b8cefa7@wwwdotorg.org>
Message-ID: <253b5dce-08cc-611e-1412-397b9faa5d7a@wwwdotorg.org>
Date:   Fri, 4 Jan 2019 16:23:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1ff5138e-3de9-e7f9-38e6-feee4b8cefa7@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/4/19 4:00 PM, Stephen Warren wrote:
> On 1/4/19 3:45 PM, Trent Piepho wrote:
>> On Fri, 2019-01-04 at 14:45 -0700, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> The current code does this when handling MSI IRQs:
>>>
>>> a) Process the irq.
>>> b) Clear the latched IRQ status.
>>>
>>> If a new IRQ occurs any time after (a) has read the IRQ status for the
>>> last time and before (b), it will be lost. For example, this occurs in
>>
>> There was a patch series to fix this bug, sent in October, stretching
>> to December.
>>
>> See "PCI: dwc: Fix interrupt race in when handling MSI"
>>
>> And "PCI: designware: Move interrupt acking into the proper callback"
>>
>> The result was more code changes, which in the end produce the same
>> order of operations as is done here to fix the race.  But it uses the
>> irq framework correctly.
>>
>> I do not think this problem was introduced until 4.14, so the nvidia
>> 4.9 must have additional patches if this is observed there.  I'm sure
>> it was not present in 4.12, as we used that, and did not see the issue
>> until updating to 4.16.
> 
> Yes, I took the DWC driver from our 4.14 kernel and dropped it into the 
> 4.9 kernel, so that's why the issue shows up in 4.9 for us.
> 
>> The current fix (for 4.21?) depends on significant restructuring that
>> was done to this driver around 4.17, see "PCI: dwc: Move MSI IRQs
>> allocation to IRQ domains hierarchical API".
>>
>> I think my original patch ("Fix interrupt race ..") or your patch here,
>> which is basically the same, should be ported to 4.14 stable.  But
>> there are some other opinions on that.  It's not clear to me if the
>> hierarchical domain stuff would be back ported to stable series.  It
>> does not seem to me to be a good idea to do so.
> 
> Hmm. Well I guess I'll go for the patch I posted in our downstream 
> kernels, since back-porting a bunch of not-yet-available restructuring 
> to our ancient kernels doesn't sound pleasant:-) But I'll go and take a 
> quick look at the other patches you mentioned just in case. Thanks!

So I went and read the thread for "PCI: dwc: Fix interrupt race in when 
handling MSI" and see:

Vignesh R wrote:
 > Lorenzo Pieralisi wrote:
>> AFAICS:
>> 
>> 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled,
>> not before")
>> 
>> was fixing a bug, causing "timeouts on some wireless lan cards", we want
>> to understand what the problem is, fix it once for all on all DWC
>> based systems.
>> 
> 
> That issue was root caused to be due to a HW errata in dra7xx DWC
> wrapper which requires a special way of handling MSI interrupts at
> wrapper level. More info in this thread:
> https://www.spinics.net/lists/linux-pci/msg70462.html
> 
> Unfortunately, commit 8c934095fa2f did not fix WLAN issue in longer
> tests and also broke PCIe USB cards. Therefore, it makes sense to revert
> 8c934095fa2f
> 
> I am working on patches fix dra7xx wrapper for WLAN card issue.

So it seems quite clear that the correct course of action is to 
immediately revert commit 8c934095fa2f ("PCI: dwc: Clear MSI interrupt 
status after it is handled, not before") (or apply my or Trent's patches 
which are effectively reverts) since it (a) attempts to fix a bug (in 
the core DWC driver) that doesn't actually exist (the bug is in the DRA 
HW and is being fixed in the DRA wrapper driver), and (b) has many 
reports that the change causes regressions; I'm at least the 3rd or 4th 
person to confirm this now (Faiz originally, then later Trent, Vignesh, 
myself).

Now, whether there's some cleanup or additional fixes needed beyond the 
simple revert is another question I currently have no insight into, but 
let's at least get back to a driver without that worked well for people 
for years, even if there's a theoretical issue to be fixed that nobody 
hit in practice.
