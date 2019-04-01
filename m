Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D253C10F05
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DA321852
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 22:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JkVlpIGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfDAWDn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:03:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45426 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfDAWDm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 18:03:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so5232655pfi.12
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2019 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3u1ExPRlwZAMEiIT9Vd5RR4JyNUHGTSd0xBeLH2nYLY=;
        b=JkVlpIGR86TMyw4WDD0X3LPV2QDEQ0KGXnBY5TpHPE87hG+4YBpuRU5ThsUlVAb7a8
         ZXsnVxfAVWIPHpGdVdu4Qh/WgdQ/8NxQ9J584muLOzElgWGcPvZoj659fwzP74K5CHgC
         rjPWRT5vcUt03hsCVR5Zy/CQ+Q0PRInOCRsQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3u1ExPRlwZAMEiIT9Vd5RR4JyNUHGTSd0xBeLH2nYLY=;
        b=k8aeoI9pP6smVlcJEpOl1WS8vr328VxkzeVLwhLRSAprkFsaUZApY317EfdrLP/iDU
         dZ2wcXDdkOOXlhQjGYdUg26fPiEDf7QaDUyto+BonNe67GtIYbMV9O29sFP0t+ohC2gc
         7gFKBGteNFLR/LXrEqFPLbK/Qkh7h3LOCKa7Q9GrJ5/lgORCmOI6cIhOW0VHjjLOpGq2
         82dzT7HptuE2BbNFmLcjMQeLQjtGYe3B0vpkgajkNKWYm/frI/hhRZMdUj7waX5CT/K+
         oJde7VUXGdu5PbUt8rwVGfU7bGkOCQL0EiuzJMm6PxQRitItryJo90ewCtoslHOAcPuX
         k2gg==
X-Gm-Message-State: APjAAAW2ag1Y/2EyIluyBXz2CUZSx1DVSFVTf8UibpnD3inMqQGQ0Ez7
        Czhimmj2zpLpNzTsJGO7SBPr+w==
X-Google-Smtp-Source: APXvYqzxI5jZlSKwoNIzbtwMO1u27g00SjDYuVCy3uQixL0mlY28kM4QyOBSESS28cvKaY8IFjcI2g==
X-Received: by 2002:a62:174c:: with SMTP id 73mr65070121pfx.33.1554156221252;
        Mon, 01 Apr 2019 15:03:41 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c3sm20728780pfg.88.2019.04.01.15.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 15:03:40 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com>
 <20190329173515.GA10367@e107981-ln.cambridge.arm.com>
 <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
 <20190401164416.GA8616@e107981-ln.cambridge.arm.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <e7d3e5a1-db5c-8438-f10f-81b87aba0e03@broadcom.com>
Date:   Mon, 1 Apr 2019 15:03:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190401164416.GA8616@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo/Srinath,

I look at the commit message again and indeed it looks quite confusing.

I'll add my comment inline in the code section. I hope that will help to
make it more clear.

On 4/1/2019 9:44 AM, Lorenzo Pieralisi wrote:
> On Mon, Apr 01, 2019 at 11:04:48AM +0530, Srinath Mannam wrote:
>> Hi Lorenzo,
>>
>> Please see my reply below,
>>
>> On Fri, Mar 29, 2019 at 11:06 PM Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>>
>>> On Fri, Mar 01, 2019 at 10:22:16AM +0530, Srinath Mannam wrote:
>>>> In the present driver outbound window configuration is done to map above
>>>> 32-bit address I/O regions with corresponding PCI memory range given in
>>>> ranges DT property.
>>>>
>>>> This patch add outbound window configuration to map below 32-bit I/O range
>>>> with corresponding PCI memory, which helps to access I/O region in ARM
>>>> 32-bit and one to one mapping of I/O region to PCI memory.
>>>>
>>>> Ex:
>>>> 1. ranges DT property given for current driver is,
>>>>     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
>>>>     I/O region address is 0x400000000
>>>> 2. ranges DT property can be given after this patch,
>>>>     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
>>>>     I/O region address is 0x42000000
>>>
>>> I was applying this patch but I don't understand the commit log and
>>> how it matches the code, please explain it to me and I will reword
>>> it.
>> Iproc PCIe host controller supports outbound address translation
>> feature to translate AXI address to PCI bus address.
>> IO address ranges (AXI and PCI) given through ranges DT property have
>> to program to controller outbound window registers.
>> Present driver has the support for only 64bit AXI address. so that
>> ranges DT property has given as 64bit AXI address and 32 bit
>> PCI bus address.
>> But with this patch 32-bit AXI address also could be programmed to
>> Iproc host controller outbound window registers. so that ranges
>> DT property can have 32bit AXI address which can map to 32-bit PCI bus address.
> 
> The code change seems to add a check for the window size, I see no
> notion of 64 vs 32 bit addressing there so I am pretty sure there is
> something you are not telling me that is implicit in the IProc outbound
> window configuration, for instance why is the lowest index window
> considered for 32-bit.
> 
> AFAICS you are adding code to allow a window whose size is < than
> the lowest index in the ob_map array. How this relates to 64 vs
> 32 bit addresses is not clear but it should be.
> 
> When I read your commit log it is impossible to understand how it
> correlates to the code you are changing - I still have not figured it
> out myself.
> 
> Please explain in detail to me how this works, forget DT changes I
> want to understand how HW works.
> 
> Lorenzo
> 
>> Example given in commit log is describing ranges DT property changes
>> with and without this patch.
>> In the case, without this patch AXI address is more than 32bit
>> "0x400000000". and with this patch AXI address is 32-bit "0x42000000".
>> PCI bus address is 32 bit address in both the cases "0x40000000" and 0x42000000.
>>
>> Regards,
>> Srinath.
>>> Thanks,
>>> Lorenzo
>>>
>>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>>>> Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> ---
>>>>  drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
>>>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
>>>> index b882255..080f142 100644
>>>> --- a/drivers/pci/controller/pcie-iproc.c
>>>> +++ b/drivers/pci/controller/pcie-iproc.c
>>>> @@ -955,8 +955,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
>>>>                       resource_size_t window_size =
>>>>                               ob_map->window_sizes[size_idx] * SZ_1M;
>>>>
>>>> -                     if (size < window_size)
>>>> -                             continue;
>>>> +                     /*
>>>> +                      * Keep iterating until we reach the last window and
>>>> +                      * with the minimal window size at index zero. In this
>>>> +                      * case, we take a compromise by mapping it using the
>>>> +                      * minimum window size that can be supported
>>>> +                      */

I think the code comment above is much more clear than the commit
message. It looks like the commit message was to describe a particular
use case that prompts the code change. However, if I remember correctly,
during our internal review, I already made some modification to the code
to make the change much more generic than dealing with a special use
case. This patch contains the generic change I made.

Basically, 'size' is the intended outbound mapping size (from DT or ACPI
or whatever, it does not really matter). 'window_size' is a specific
mapping window size our PCIe controller can support. Our PCIe controller
supports a fixed set of outbound mapping window sizes. I don't think
this is much different from some other PCIe controllers.

It looks like, there are cases where one cannot find an exact match
between 'size' and 'window_size'. In this case, and when we know we have
already exhausted all possible mapping windows, i.e., 'size_idx' == 0
AND 'window_idx' == 0, we take a compromise by programming the outbound
mapping by using a window size that's actually larger than the 'size'.

Srinath, please correct me if I'm wrong. But I carefully reviewed the
code again and I believe this is essentially what it is.

If so, then the commit message is quite misleading and can be changed to
above descriptions.

>>>> +                     if (size < window_size) {
>>>> +                             if (size_idx > 0 || window_idx > 0)
>>>> +                                     continue;
>>>> +
>>>> +                             /*
>>>> +                              * For the corner case of reaching the minimal
>>>> +                              * window size that can be supported on the
>>>> +                              * last window
>>>> +                              */
>>>> +                             axi_addr = ALIGN_DOWN(axi_addr, window_size);
>>>> +                             pci_addr = ALIGN_DOWN(pci_addr, window_size);
>>>> +                             size = window_size;
>>>> +                     }
>>>>
>>>>                       if (!IS_ALIGNED(axi_addr, window_size) ||
>>>>                           !IS_ALIGNED(pci_addr, window_size)) {
>>>> --
>>>> 2.7.4
>>>>
