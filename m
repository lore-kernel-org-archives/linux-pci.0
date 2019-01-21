Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8D7C2F421
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9720844
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="itT8FYHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfAUQD5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:03:57 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:37564 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfAUQD5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 11:03:57 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 96D7224E0FE0;
        Mon, 21 Jan 2019 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548086636; bh=rB17cfPXfR3P1s55xq/SlnFnzzhKxEgSuYdWyA7/AXw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=itT8FYHf3zLL6XXzfHsUy2xORvSCfor1rhXe21wi71RMkU4r1Ol7Lnw+fB+DzRJsi
         byHx6Zc+KGwK8YW0+mARSu8YrNpGwji8pdd56chG0rlfBnNqQMR6z/m0W89bE3b1qy
         U5QUYTLRAlan8qyLhqOvvDtm02kVeSjwGKoQ6ofJPUuOSvtmEtN3M37iZ3dQGv7YFl
         8nqGD8pmZ2a0AJNkHCmtKa3XFkEUwS70Ej/hLaoux7h9WTeJqHjH5HqaoO/RKs10mm
         Muw2JuyYEf+DdQIEu4LSTccqVpf1JIAJ4Vzp0MymZW+65gbuL3/gW4oppHScww6w1C
         dgX9KMZOkOoew==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 487B4A02D2;
        Mon, 21 Jan 2019 16:03:56 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 08:03:56 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 17:03:53 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Jan 2019 17:03:53 +0100
Subject: Re: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample
 driver
To:     Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194819.GV9170@smile.fi.intel.com>
 <2de7f43e-0702-9ab3-b24c-a1b212e18f7c@synopsys.com>
 <20190115054531.GC9170@smile.fi.intel.com>
 <453ecbd8-af75-1d5c-18d0-c272142d4424@synopsys.com>
 <20190117050308.GF13372@vkoul-mobl.Dlink>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <bc5bae93-556b-9740-a741-a70226bf8bd2@synopsys.com>
Date:   Mon, 21 Jan 2019 15:59:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117050308.GF13372@vkoul-mobl.Dlink>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/01/2019 05:03, Vinod Koul wrote:
> On 15-01-19, 13:02, Gustavo Pimentel wrote:
>> On 15/01/2019 05:45, Andy Shevchenko wrote:
>>> On Mon, Jan 14, 2019 at 11:44:22AM +0000, Gustavo Pimentel wrote:
>>>> On 11/01/2019 19:48, Andy Shevchenko wrote:
>>>>> On Fri, Jan 11, 2019 at 07:33:43PM +0100, Gustavo Pimentel wrote:
>>>>>> Add Synopsys eDMA IP test and sample driver to be use for testing
>>>>>> purposes and also as a reference for any developer who needs to
>>>>>> implement and use Synopsys eDMA.
>>>>>>
>>>>>> This driver can be compile as built-in or external module in kernel.
>>>>>>
>>>>>> To enable this driver just select DW_EDMA_TEST option in kernel
>>>>>> configuration, however it requires and selects automatically DW_EDMA
>>>>>> option too.
>>>>>>
>>>>>
>>>>> Hmm... This doesn't explain what's wrong with dmatest module.
>>>>
>>>> There isn't anything wrong with dmatest module, that I know of. In beginning I
>>>> was planning to used it, however only works with MEM_TO_MEM transfers, that's
>>>> why I created a similar module but for MEM_TO_DEV and DEV_TO_MEM with
>>>> scatter-gather and cyclic transfers type for my use case. I don't know if can be
>>>> applied to other cases, if that is feasible, I'm glad to share it.
>>>
>>> What I'm trying to tell is that the dmatest driver would be nice to have such
>>> capability.
>>>
>>
>> At the beginning I thought to add those features to dmatest module, but because
>> of several points such as:
>>  - I didn't want, by any chance, to broke dmatest module while implementing the
>> support of those new features;
>>  - Since I'm still gaining knowledge about this subsystem I preferred to do in a
>> more controlled environment;
>>  - Since this driver is also a reference driver aim to teach and to be use by
>> someone how to use the dmaengine API, I preferred to keep it simple.
>>
>> Maybe in the future both modules could be merged in just one tool, but for now I
>> would prefer to keep it separated specially to fix any immaturity error of this
>> module.
> 
> With decent testing we should be able to iron out kinks in dmatest
> module. It gets tested for memcpy controllers so we should easily catch
> issues.

Ok, since I don't have a setup to test that, may I count with you for test it?

> 
> Said that, it would make sense to add support in generic dmatest so that
> other folks can reuse and contribute as well. Future work always gets
> side tracked by life, so lets do it now :)

But there are some points that will need to be reworked or clarified.
For instance, I require to know the physical and virtual address and the maximum
size allowed for the Endpoint (in my case), where I will put/get the data.

Another difference is, I create all threads and only after that I start them all
simultaneously, the dmatest doesn't have that behavior.

There are 1 or 2 more details, but the ones that have the greatest impact are those.


> 
> 

