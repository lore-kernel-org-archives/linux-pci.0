Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E870C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 23:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D3E218D3
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 23:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfADXAu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 18:00:50 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:48104 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfADXAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 18:00:50 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 24B1A1C0144;
        Fri,  4 Jan 2019 16:00:48 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
To:     Trent Piepho <tpiepho@impinj.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Cc:     "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "marex@denx.de" <marex@denx.de>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <1ff5138e-3de9-e7f9-38e6-feee4b8cefa7@wwwdotorg.org>
Date:   Fri, 4 Jan 2019 16:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546641949.14247.20.camel@impinj.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/4/19 3:45 PM, Trent Piepho wrote:
> On Fri, 2019-01-04 at 14:45 -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The current code does this when handling MSI IRQs:
>>
>> a) Process the irq.
>> b) Clear the latched IRQ status.
>>
>> If a new IRQ occurs any time after (a) has read the IRQ status for the
>> last time and before (b), it will be lost. For example, this occurs in
> 
> There was a patch series to fix this bug, sent in October, stretching
> to December.
> 
> See "PCI: dwc: Fix interrupt race in when handling MSI"
> 
> And "PCI: designware: Move interrupt acking into the proper callback"
> 
> The result was more code changes, which in the end produce the same
> order of operations as is done here to fix the race.  But it uses the
> irq framework correctly.
> 
> I do not think this problem was introduced until 4.14, so the nvidia
> 4.9 must have additional patches if this is observed there.  I'm sure
> it was not present in 4.12, as we used that, and did not see the issue
> until updating to 4.16.

Yes, I took the DWC driver from our 4.14 kernel and dropped it into the 
4.9 kernel, so that's why the issue shows up in 4.9 for us.

> The current fix (for 4.21?) depends on significant restructuring that
> was done to this driver around 4.17, see "PCI: dwc: Move MSI IRQs
> allocation to IRQ domains hierarchical API".
> 
> I think my original patch ("Fix interrupt race ..") or your patch here,
> which is basically the same, should be ported to 4.14 stable.  But
> there are some other opinions on that.  It's not clear to me if the
> hierarchical domain stuff would be back ported to stable series.  It
> does not seem to me to be a good idea to do so.

Hmm. Well I guess I'll go for the patch I posted in our downstream 
kernels, since back-porting a bunch of not-yet-available restructuring 
to our ancient kernels doesn't sound pleasant:-) But I'll go and take a 
quick look at the other patches you mentioned just in case. Thanks!
