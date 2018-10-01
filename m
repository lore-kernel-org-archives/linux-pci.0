Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E3C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 18:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE2E208AE
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 18:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTTeKYOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE2E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeJBAw2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:52:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45507 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBAw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Oct 2018 20:52:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id h6-v6so13614459eds.12;
        Mon, 01 Oct 2018 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LppgOLWi+fHuSrZwKOFr9gcIWC+Zdvnp/tPJOKBy48Y=;
        b=QTTeKYOFwALA1C+CVG7jh+0koGLYV9cVoN2WTs7sRY8+cEhW3JLJluw2ZSZqhsAzzr
         9sw63NWijhsvcSDIwpxoZYj8gf1qpU2qU2zCiGiVGw7R/uoblyZELEBxSJq481eI6wVt
         KsuN59603uI6JujuBH5gPjeKNecNY/EPLkqzSUgewsE3hjPcbMnXDnsBxHjGfQQzJNEC
         gAVL4kqS/8Wcoxc7FfILnWRvEAhJ9XUZKkbKFv78aiivBJTRNduvqoiQCoLnbOJmlyKr
         rsFuhkBkEpB7gDGvqCN1kl2JmZ/KkxS0ajKaaTXvoVOrKJtSFzuRDvkd8lpL64a6RMAs
         rAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LppgOLWi+fHuSrZwKOFr9gcIWC+Zdvnp/tPJOKBy48Y=;
        b=cnyT2ZboJyd/+JAaM1Hiimvmf/vJJcko5bFefBWJGKpmzV5KBlVRGgEFlzeO5/55M6
         8NglQgEXbD08zUuE87JvyRWsg7dfvSX/TJL++2/1Vtsg33/9iUCt6RS4ydKPUwXtX8Ts
         PlNGef+qU0yihTXX2WUiDV7Q05DGNu+S7NUr3M1Gi8GOELKMM67Zw8piam4c5vLhZIeO
         32ahyoiqKJ+J0n99J43Rv862T3NXkezb3mZVPxMxbtxasNyiWO7d/294+PyrUTGXXuoe
         T5IVV7KaNZMd63lH9/rvFTcpXe1RCtTkJAnKIanoaGI+xSai1slzbjTdgJR+Aiy4/ExU
         bsyQ==
X-Gm-Message-State: ABuFfogy3vM4nqu7VUDPiF8PmLikc9EUHGQU1t0WRwGsblYAq8mFkCLr
        /okmiFS9cY5GfGUV4MRHyzA=
X-Google-Smtp-Source: ACcGV626vAZxSwcXTr7LYS2GykZa7rh9c9W97WA5mV8V9+4wDEp0i6D1eyOiSNNQYHoPPZJEjYHKjw==
X-Received: by 2002:aa7:c458:: with SMTP id n24-v6mr17624450edr.55.1538417604832;
        Mon, 01 Oct 2018 11:13:24 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id a9-v6sm5312425edi.26.2018.10.01.11.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:13:23 -0700 (PDT)
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound
 traffic
To:     Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
 <7b25b09e-6f99-8a9b-d548-03becd9de8b5@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <332b42e3-67c6-9471-e18f-4d54954e3be3@gmail.com>
Date:   Mon, 1 Oct 2018 11:13:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7b25b09e-6f99-8a9b-d548-03becd9de8b5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/26/2018 03:56 AM, Robin Murphy wrote:
> On 26/09/18 03:59, Florian Fainelli wrote:
>>
>>
>> On 9/24/2018 8:01 AM, Jim Quinlan wrote:
>>> On Mon, Sep 24, 2018 at 4:25 AM Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>>
>>>> On Fri, 21 Sep 2018 at 19:41, Jim Quinlan <jim2101024@gmail.com> wrote:
>>>>>
>>>>> On Thu, Sep 20, 2018 at 5:39 PM Florian Fainelli
>>>>> <f.fainelli@gmail.com> wrote:
>>>>>>
>>>>>> On 09/20/2018 02:33 PM, Ard Biesheuvel wrote:
>>>>>>> On 20 September 2018 at 14:31, Florian Fainelli
>>>>>>> <f.fainelli@gmail.com> wrote:
>>>>>>>> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
>>>>>>>>> On 20 September 2018 at 13:55, Florian Fainelli
>>>>>>>>> <f.fainelli@gmail.com> wrote:
>>>>>>>>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
>>>>>>>>>>> On 19 September 2018 at 07:31, Jim Quinlan
>>>>>>>>>>> <jim2101024@gmail.com> wrote:
>>>>>>>>>>>> The Broadcom STB PCIe host controller is intimately related
>>>>>>>>>>>> to the
>>>>>>>>>>>> memory subsystem.  This close relationship adds complexity
>>>>>>>>>>>> to how cpu
>>>>>>>>>>>> system memory is mapped to PCIe memory.  Ideally, this
>>>>>>>>>>>> mapping is an
>>>>>>>>>>>> identity mapping, or an identity mapping off by a constant. 
>>>>>>>>>>>> Not so in
>>>>>>>>>>>> this case.
>>>>>>>>>>>>
>>>>>>>>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which
>>>>>>>>>>>> has 6 GB
>>>>>>>>>>>> of system memory.  Here is how the PCIe controller maps the
>>>>>>>>>>>> system memory to PCIe memory:
>>>>>>>>>>>>
>>>>>>>>>>>>    memc0-a@[        0....3fffffff] <=> pci@[       
>>>>>>>>>>>> 0....3fffffff]
>>>>>>>>>>>>    memc0-b@[100000000...13fffffff] <=> pci@[
>>>>>>>>>>>> 40000000....7fffffff]
>>>>>>>>>>>>    memc1-a@[ 40000000....7fffffff] <=> pci@[
>>>>>>>>>>>> 80000000....bfffffff]
>>>>>>>>>>>>    memc1-b@[300000000...33fffffff] <=> pci@[
>>>>>>>>>>>> c0000000....ffffffff]
>>>>>>>>>>>>    memc2-a@[ 80000000....bfffffff] <=>
>>>>>>>>>>>> pci@[100000000...13fffffff]
>>>>>>>>>>>>    memc2-b@[c00000000...c3fffffff] <=>
>>>>>>>>>>>> pci@[140000000...17fffffff]
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> So is describing this as
>>>>>>>>>>>
>>>>>>>>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
>>>>>>>>>>>               <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
>>>>>>>>>>>               <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
>>>>>>>>>>>               <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
>>>>>>>>>>>               <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
>>>>>>>>>>>               <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
>>>>>>>>>>>
>>>>>>>>>>> not working for you? I haven't tried this myself, but since
>>>>>>>>>>> DT permits
>>>>>>>>>>> describing the inbound mappings this way, we should fix the
>>>>>>>>>>> code if it
>>>>>>>>>>> doesn't work at the moment.
>>>>>>>>>>
>>>>>>>>>> You mean encoding the memory controller index in the first
>>>>>>>>>> cell? If that
>>>>>>>>>> works, that's indeed a much cleaner solution, though is it
>>>>>>>>>> standard
>>>>>>>>>> compliant in any form?
>>>>>>>>>
>>>>>>>>> No those are just memory addresses (although I may have screwed
>>>>>>>>> up the
>>>>>>>>> order). From Documentation/devicetree/booting-without-of.txt:
>>>>>>>>>
>>>>>>>>> """
>>>>>>>>> Optional property:
>>>>>>>>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number
>>>>>>>>> of triplets of
>>>>>>>>>          (child-bus-address, parent-bus-address, length). Each
>>>>>>>>> triplet specified
>>>>>>>>>          describes a contiguous DMA address range.
>>>>>>>>> """
>>>>>>>>>
>>>>>>>>
>>>>>>>> Then I am confused by your comment, that's what this patch does,
>>>>>>>> it adds
>>>>>>>> support for reading "dma-ranges" from Device Tree and setting up
>>>>>>>> inbound
>>>>>>>> windows using that. The only caveat is that because the PCIe root
>>>>>>>> complex has some ties with the memory bus architecture it is
>>>>>>>> connected
>>>>>>>> to (SCB in our case) there is still a requirement to know the
>>>>>>>> translation between a given physical address and its backing memory
>>>>>>>> controller/aperture.
>>>>>>>>
>>>>>>>
>>>>>>> Ah ok, apologies for the noise then.
>>>>>>>
>>>>>>> I was hoping that having working support for dma-ranges would remove
>>>>>>> the need for the special phys<->dma conversion routines.
>>>>>>
>>>>>> What you describe definitively works with platform devices, but I
>>>>>> am not
>>>>>> sure this is working for PCIe devices, although, conceptually it
>>>>>> should,
>>>>>> yes.
>>>>> Sorry for my delay in responding.  One problem is that
>>>>> of_dma_configure() only looks at the first dma-range given and then
>>>>> converts it to dev->dma_pfn_offset which is respected by the DMA API.
>>>>> However, we often have multiple dma-ranges, not just one.  This is the
>>>>> big issue.
>>>>>
>>>>
>>>> Given the recent attention to getting these APIs in shape, this may be
>>>> something Robin or Christoph may care to look into?
>>>
>>> It looks like this has been brought up before in the "[RFC PATCH] of:
>>> Fix DMA configuration for non-DT masters" thread aka
>>>
>>> https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021325.html
>>>
>>> In the thread "Oza Oza", a Broadcom coworker probably dealing with the
>>> same exact problem as I,  enumerates three problems.   #1 and #2 are
>>> the exact same ones I've just given: the "dma-ranges" prop of the RC
>>> DT node is "skipped", and of_dma_get_range() only considers the first
>>> entry in any "dma-ranges".
>>
>> Robin, is that something that is expected or should the "dma-ranges"
>> somehow propagate from host bridge down the PCIe end-point drivers?
> 
> Nope, the code is most definitely incomplete - it's sufficient to
> support the system it was originally needed for (i.e. platform devices
> with a single range), but can by no means even pretend to support the
> binding fully. Furthermore, the way that PCI support was later grafted
> into of_dma_configure() was *only* in support of dma-coherent without
> consideration for dma-ranges. Hence the current mess.

Is this the way we should go? If the PCIe root complex has a
"dma-ranges" property, we need to make sure that all child devices
behind it get that translation applied as well? Right now we tried to
follow Christoph's recommendations from the v1 through v4 submissions,
but that does not really seem to be working well.

I am really not a fan of having to go audit every architecture, and
possibly insert the right translation in there, while introducing a
possible layering problem too...

> 
>>>
>>> Thanks, Jim
>>>
>>>>
>>>> In any case, the description of dma-ranges should be in sync with the
>>>> way Linux interprets it, so this is either a documentation bug or a
>>>> DMA layer bug.
>>>>
>>>>> There is another issue with of_dma_configure() being invoked by the EP
>>>>> driver on "bridge->parent->of_node", which is our RC device,
>>>>> Of_dma_configure() calls of_dma_range() on the of_get_next_parent() of
>>>>> our RC's device node and this misses the dma-ranges property which is
>>>>> contained within the RC.  I think I could workaround this but there is
>>>>> no getting around the first problem.
>>>>>
>>>>
>>>> IIUC dma-ranges should be added to the parent bus of a device, which I
>>>> guess is slightly ambiguous for a root complex that incorporates a
>>>> host bridge.
>>
>> Humm, why is that ambiguous for a host bridge/root complex?
> 
> The real problem is that FDT machines don't describe the PCI hierarchy
> in DT as proper OF does, so we have this awkward crossing between the DT
> model and the Linux device model where the devices have no DT
> representation and the "parent bus" is a DT leaf node, which cocks up
> the way the current code is expecting to work.

OK, I see what you mean, we still have to work with what we have here,
which is FDT...
-- 
Florian
