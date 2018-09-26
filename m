Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC54C43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212D0214D5
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 10:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212D0214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeIZRJY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:09:24 -0400
Received: from foss.arm.com ([217.140.101.70]:43132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeIZRJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 13:09:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B601596;
        Wed, 26 Sep 2018 03:57:00 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 706413F5BD;
        Wed, 26 Sep 2018 03:56:58 -0700 (PDT)
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound
 traffic
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>, ard.biesheuvel@linaro.org
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-5-git-send-email-jim2101024@gmail.com>
 <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
 <7fa897cf-4d58-c63f-afdd-a3ec5a6a56bf@gmail.com>
 <CAKv+Gu8aJRV4nqq1e-5HRLvbrANQsYuMf-pwWB53BhxLgX7iWg@mail.gmail.com>
 <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com>
 <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
 <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com>
 <CANCKTBsypcVS_iC1+sbW5fMKfj+tTsxbQv9CvDwcO8GV3a8_Yg@mail.gmail.com>
 <CAKv+Gu-+OjJi8zGLqvnsOJQ9ygMot-O0EbyMKO-yyG-+k-274A@mail.gmail.com>
 <CANCKTBtbwSqfSU0b_d6Yi7TV3R_ijEpPE8a4bpgpkcOxJOa_zQ@mail.gmail.com>
 <7accc1a7-647b-1f92-13f8-2fab315ddc45@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7b25b09e-6f99-8a9b-d548-03becd9de8b5@arm.com>
Date:   Wed, 26 Sep 2018 11:56:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7accc1a7-647b-1f92-13f8-2fab315ddc45@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/09/18 03:59, Florian Fainelli wrote:
> 
> 
> On 9/24/2018 8:01 AM, Jim Quinlan wrote:
>> On Mon, Sep 24, 2018 at 4:25 AM Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>>
>>> On Fri, 21 Sep 2018 at 19:41, Jim Quinlan <jim2101024@gmail.com> wrote:
>>>>
>>>> On Thu, Sep 20, 2018 at 5:39 PM Florian Fainelli 
>>>> <f.fainelli@gmail.com> wrote:
>>>>>
>>>>> On 09/20/2018 02:33 PM, Ard Biesheuvel wrote:
>>>>>> On 20 September 2018 at 14:31, Florian Fainelli 
>>>>>> <f.fainelli@gmail.com> wrote:
>>>>>>> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
>>>>>>>> On 20 September 2018 at 13:55, Florian Fainelli 
>>>>>>>> <f.fainelli@gmail.com> wrote:
>>>>>>>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
>>>>>>>>>> On 19 September 2018 at 07:31, Jim Quinlan 
>>>>>>>>>> <jim2101024@gmail.com> wrote:
>>>>>>>>>>> The Broadcom STB PCIe host controller is intimately related 
>>>>>>>>>>> to the
>>>>>>>>>>> memory subsystem.  This close relationship adds complexity to 
>>>>>>>>>>> how cpu
>>>>>>>>>>> system memory is mapped to PCIe memory.  Ideally, this 
>>>>>>>>>>> mapping is an
>>>>>>>>>>> identity mapping, or an identity mapping off by a constant.  
>>>>>>>>>>> Not so in
>>>>>>>>>>> this case.
>>>>>>>>>>>
>>>>>>>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which 
>>>>>>>>>>> has 6 GB
>>>>>>>>>>> of system memory.  Here is how the PCIe controller maps the
>>>>>>>>>>> system memory to PCIe memory:
>>>>>>>>>>>
>>>>>>>>>>>    memc0-a@[        0....3fffffff] <=> pci@[        
>>>>>>>>>>> 0....3fffffff]
>>>>>>>>>>>    memc0-b@[100000000...13fffffff] <=> pci@[ 
>>>>>>>>>>> 40000000....7fffffff]
>>>>>>>>>>>    memc1-a@[ 40000000....7fffffff] <=> pci@[ 
>>>>>>>>>>> 80000000....bfffffff]
>>>>>>>>>>>    memc1-b@[300000000...33fffffff] <=> pci@[ 
>>>>>>>>>>> c0000000....ffffffff]
>>>>>>>>>>>    memc2-a@[ 80000000....bfffffff] <=> 
>>>>>>>>>>> pci@[100000000...13fffffff]
>>>>>>>>>>>    memc2-b@[c00000000...c3fffffff] <=> 
>>>>>>>>>>> pci@[140000000...17fffffff]
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> So is describing this as
>>>>>>>>>>
>>>>>>>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
>>>>>>>>>>               <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
>>>>>>>>>>               <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
>>>>>>>>>>               <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
>>>>>>>>>>               <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
>>>>>>>>>>               <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
>>>>>>>>>>
>>>>>>>>>> not working for you? I haven't tried this myself, but since DT 
>>>>>>>>>> permits
>>>>>>>>>> describing the inbound mappings this way, we should fix the 
>>>>>>>>>> code if it
>>>>>>>>>> doesn't work at the moment.
>>>>>>>>>
>>>>>>>>> You mean encoding the memory controller index in the first 
>>>>>>>>> cell? If that
>>>>>>>>> works, that's indeed a much cleaner solution, though is it 
>>>>>>>>> standard
>>>>>>>>> compliant in any form?
>>>>>>>>
>>>>>>>> No those are just memory addresses (although I may have screwed 
>>>>>>>> up the
>>>>>>>> order). From Documentation/devicetree/booting-without-of.txt:
>>>>>>>>
>>>>>>>> """
>>>>>>>> Optional property:
>>>>>>>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number 
>>>>>>>> of triplets of
>>>>>>>>          (child-bus-address, parent-bus-address, length). Each 
>>>>>>>> triplet specified
>>>>>>>>          describes a contiguous DMA address range.
>>>>>>>> """
>>>>>>>>
>>>>>>>
>>>>>>> Then I am confused by your comment, that's what this patch does, 
>>>>>>> it adds
>>>>>>> support for reading "dma-ranges" from Device Tree and setting up 
>>>>>>> inbound
>>>>>>> windows using that. The only caveat is that because the PCIe root
>>>>>>> complex has some ties with the memory bus architecture it is 
>>>>>>> connected
>>>>>>> to (SCB in our case) there is still a requirement to know the
>>>>>>> translation between a given physical address and its backing memory
>>>>>>> controller/aperture.
>>>>>>>
>>>>>>
>>>>>> Ah ok, apologies for the noise then.
>>>>>>
>>>>>> I was hoping that having working support for dma-ranges would remove
>>>>>> the need for the special phys<->dma conversion routines.
>>>>>
>>>>> What you describe definitively works with platform devices, but I 
>>>>> am not
>>>>> sure this is working for PCIe devices, although, conceptually it 
>>>>> should,
>>>>> yes.
>>>> Sorry for my delay in responding.  One problem is that
>>>> of_dma_configure() only looks at the first dma-range given and then
>>>> converts it to dev->dma_pfn_offset which is respected by the DMA API.
>>>> However, we often have multiple dma-ranges, not just one.  This is the
>>>> big issue.
>>>>
>>>
>>> Given the recent attention to getting these APIs in shape, this may be
>>> something Robin or Christoph may care to look into?
>>
>> It looks like this has been brought up before in the "[RFC PATCH] of:
>> Fix DMA configuration for non-DT masters" thread aka
>>
>> https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021325.html
>>
>> In the thread "Oza Oza", a Broadcom coworker probably dealing with the
>> same exact problem as I,  enumerates three problems.   #1 and #2 are
>> the exact same ones I've just given: the "dma-ranges" prop of the RC
>> DT node is "skipped", and of_dma_get_range() only considers the first
>> entry in any "dma-ranges".
> 
> Robin, is that something that is expected or should the "dma-ranges" 
> somehow propagate from host bridge down the PCIe end-point drivers?

Nope, the code is most definitely incomplete - it's sufficient to 
support the system it was originally needed for (i.e. platform devices 
with a single range), but can by no means even pretend to support the 
binding fully. Furthermore, the way that PCI support was later grafted 
into of_dma_configure() was *only* in support of dma-coherent without 
consideration for dma-ranges. Hence the current mess.

>>
>> Thanks, Jim
>>
>>>
>>> In any case, the description of dma-ranges should be in sync with the
>>> way Linux interprets it, so this is either a documentation bug or a
>>> DMA layer bug.
>>>
>>>> There is another issue with of_dma_configure() being invoked by the EP
>>>> driver on "bridge->parent->of_node", which is our RC device,
>>>> Of_dma_configure() calls of_dma_range() on the of_get_next_parent() of
>>>> our RC's device node and this misses the dma-ranges property which is
>>>> contained within the RC.  I think I could workaround this but there is
>>>> no getting around the first problem.
>>>>
>>>
>>> IIUC dma-ranges should be added to the parent bus of a device, which I
>>> guess is slightly ambiguous for a root complex that incorporates a
>>> host bridge.
> 
> Humm, why is that ambiguous for a host bridge/root complex?

The real problem is that FDT machines don't describe the PCI hierarchy 
in DT as proper OF does, so we have this awkward crossing between the DT 
model and the Linux device model where the devices have no DT 
representation and the "parent bus" is a DT leaf node, which cocks up 
the way the current code is expecting to work.

Robin.
