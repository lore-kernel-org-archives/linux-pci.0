Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336EAC43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 13:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BCA20866
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C+LLVBvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfAONH2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:07:28 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:58106 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfAONH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jan 2019 08:07:28 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7FC9F24E14FB;
        Tue, 15 Jan 2019 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547557647; bh=OYIl3StJoyOYR8oNTjs3ZKwguYyNbZiIcS1QFPi/pzs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=C+LLVBvnMgBRMRRMci95MMw1r5ZnHy2NX351MGat61EffJfhUlVWQUuWTtUruKWrE
         zp8/1ehry6CAy5ZChoIvJWxBKTWTs6FnmVW3o68Cld6pGUzabmiL/sa+YCc2QNvfsA
         xOMdmbFrYi3Rba6u7fEFgLvf6bEHQJQyzSOfbAZZiFNn95mVObEheZTDHyKn3qLx4x
         T/yAk9LQWPBZdZUyIUzt1GO3WKOL+Af2CM/zqKIII+elgF5Yf3Iwzbt1zHCk2PBbO0
         ZosgLuLEY8MKWRT9LFhJFxgsVF4fDgj/FiJImgme6Soa+wMho8THP4SkBI6f4z89Tu
         I+fIpTISmMvKQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3053B4B7C;
        Tue, 15 Jan 2019 05:07:27 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 05:07:27 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 14:07:25 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 14:07:24 +0100
Subject: Re: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        "Luis Oliveira" <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194819.GV9170@smile.fi.intel.com>
 <2de7f43e-0702-9ab3-b24c-a1b212e18f7c@synopsys.com>
 <20190115054531.GC9170@smile.fi.intel.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <453ecbd8-af75-1d5c-18d0-c272142d4424@synopsys.com>
Date:   Tue, 15 Jan 2019 13:02:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115054531.GC9170@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/01/2019 05:45, Andy Shevchenko wrote:
> On Mon, Jan 14, 2019 at 11:44:22AM +0000, Gustavo Pimentel wrote:
>> On 11/01/2019 19:48, Andy Shevchenko wrote:
>>> On Fri, Jan 11, 2019 at 07:33:43PM +0100, Gustavo Pimentel wrote:
>>>> Add Synopsys eDMA IP test and sample driver to be use for testing
>>>> purposes and also as a reference for any developer who needs to
>>>> implement and use Synopsys eDMA.
>>>>
>>>> This driver can be compile as built-in or external module in kernel.
>>>>
>>>> To enable this driver just select DW_EDMA_TEST option in kernel
>>>> configuration, however it requires and selects automatically DW_EDMA
>>>> option too.
>>>>
>>>
>>> Hmm... This doesn't explain what's wrong with dmatest module.
>>
>> There isn't anything wrong with dmatest module, that I know of. In beginning I
>> was planning to used it, however only works with MEM_TO_MEM transfers, that's
>> why I created a similar module but for MEM_TO_DEV and DEV_TO_MEM with
>> scatter-gather and cyclic transfers type for my use case. I don't know if can be
>> applied to other cases, if that is feasible, I'm glad to share it.
> 
> What I'm trying to tell is that the dmatest driver would be nice to have such
> capability.
> 

At the beginning I thought to add those features to dmatest module, but because
of several points such as:
 - I didn't want, by any chance, to broke dmatest module while implementing the
support of those new features;
 - Since I'm still gaining knowledge about this subsystem I preferred to do in a
more controlled environment;
 - Since this driver is also a reference driver aim to teach and to be use by
someone how to use the dmaengine API, I preferred to keep it simple.

Maybe in the future both modules could be merged in just one tool, but for now I
would prefer to keep it separated specially to fix any immaturity error of this
module.

