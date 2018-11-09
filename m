Return-Path: <SRS0=f7a+=NU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EFEC43441
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C192720825
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C192720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeKJC6D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:58:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38762 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJC6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Nov 2018 21:58:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9HGQrZ067125;
        Fri, 9 Nov 2018 11:16:26 -0600
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9HGQwL014962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 11:16:26 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 11:16:26 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 11:16:26 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9HGMb4008902;
        Fri, 9 Nov 2018 11:16:23 -0600
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>
CC:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Sekhar Nori <nsekhar@ti.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
 <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
 <db3462e2-422c-161a-1f58-135bc4eab7eb@arm.com>
 <1541533217.30311.263.camel@impinj.com>
 <597d9ebd-f95f-0a4d-e1a3-fe79d4333879@arm.com>
 <1541621853.30311.294.camel@impinj.com>
 <268eae88-274e-edfe-5668-5759efae62e6@arm.com>
 <1541706591.30311.308.camel@impinj.com>
 <20181109101316.GA25155@e107981-ln.cambridge.arm.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <614ee9cd-fea2-304c-61a3-04d4b0174098@ti.com>
Date:   Fri, 9 Nov 2018 22:47:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109101316.GA25155@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 09/11/18 3:43 PM, Lorenzo Pieralisi wrote:
> On Thu, Nov 08, 2018 at 07:49:52PM +0000, Trent Piepho wrote:
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
>> now, but this same bug was fixed in 2013 in https://patchwork.kernel.or
>> g/patch/3333681/
>>
>> Then that lasted four years until it was changed Aug 2017 in https://pa
>> tchwork.kernel.org/patch/9893303/
>>
>> That lasted just six months until someone tried to revert it, https://p
>> atchwork.kernel.org/patch/9893303/
> 
> The last link is the same as the previous one, unless I am missing
> something.
> 
>> Seems pretty clear the way it is now is much worse than the way it was
>> before, even if the previous design may have had another flaw.  Though
>> I've yet to see anyone point out something makes the previous design
>> broken.  Sub-optimal yes, but not broken.
> 
> The way I see it is: either the MSI handling works or it does not.
> 
> AFAICS:
> 
> 8c934095fa2f ("PCI: dwc: Clear MSI interrupt status after it is handled,
> not before")
> 
> was fixing a bug, causing "timeouts on some wireless lan cards", we want
> to understand what the problem is, fix it once for all on all DWC
> based systems.
> 

That issue was root caused to be due to a HW errata in dra7xx DWC
wrapper which requires a special way of handling MSI interrupts at
wrapper level. More info in this thread:
https://www.spinics.net/lists/linux-pci/msg70462.html

Unfortunately, commit 8c934095fa2f did not fix WLAN issue in longer
tests and also broke PCIe USB cards. Therefore, it makes sense to revert
8c934095fa2f

I am working on patches fix dra7xx wrapper for WLAN card issue.

Regards
Vignesh

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
> Nobody is holding anyone hostage here, it is a pretty normal patch
> discussion, given the controversial history of fixes you reported
> we are just trying to get the whole picture.
> 
> There is a bug that ought to be fixed, you are doing the right thing
> with the feedback you are providing and DWC maintainers must provide the
> information you need to get to the bottom of this, once for all, that's
> as simple as that.
> 
> Thanks,
> Lorenzo
> 
