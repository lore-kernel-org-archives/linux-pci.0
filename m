Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E6ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2A721534
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKQf7Tm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2A721534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeIUDSs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:18:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34616 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbeIUDSs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 23:18:48 -0400
Received: by mail-io1-f65.google.com with SMTP id c22-v6so9890488iob.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Sep 2018 14:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kllJXPymULRvvbvi8TTwOjhT6I3N/ZUtRO1TbjctCzU=;
        b=AKQf7Tm366Wuwe8kFgISiQNiS8bPMs0nHXMhWUp1HkvbB51NDU9X/g3tRp50ykSvgW
         x68kH/WYY472I+IFDp7826qy56vPfK9UvMp60KLLJ3r3TaifQ9RC/c71+z9qElAVoNc3
         UBYvc6TLVbtoW0IJPmbecLcnwfkD+DT4JuAR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kllJXPymULRvvbvi8TTwOjhT6I3N/ZUtRO1TbjctCzU=;
        b=HEmLegHwMQzfSZXMfZ74Edafkyc06Da2ioIidxvPqoBFNLDaWi/0s6p/MYswjPKna5
         cdPZf1Rqu4ltHJ/FDCF0JI0LDgB6lI4W71GalvcLC3tZGcQkHwS+ChaQ3DcKj0isYJWF
         QofXwCowHdo5y/e7xR9vc+7ty0C9/JVVnmi89RgvbZ/T5wmIzD+vry8QhaDLKofJEL/B
         mDrUUVJxbVHKVLBqLQTUHNwyI1Wsf4v+vrzBYPdavfQYI9hddMF3VCoL22R79034IFfM
         xolLGXbC+7iZ2i/shNIT3kfh0wm6bUGrA/A6TCb0qS1MyMaJDIF1GI6gJPHjoFUv6tP+
         0/tA==
X-Gm-Message-State: APzg51BHjhZ1tCxPm9ie31I7nv70FACQs4ls+Mmf+ETxCE5mmi1vv8lh
        gpkfo6eM92IC5ASqXl4hBafVsIlQcHl7RvTBH/JAlA==
X-Google-Smtp-Source: ANB0VdZSlz6iryDnD6SpqHmZxzSD1VyRrT/ietRsCqKveghCv1wURANmo/UpC7H2Ncu/15kF5gFUal1P8RSdxPqhxA8=
X-Received: by 2002:a02:1515:: with SMTP id j21-v6mr38050020jad.2.1537479196958;
 Thu, 20 Sep 2018 14:33:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 14:33:16
 -0700 (PDT)
In-Reply-To: <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-5-git-send-email-jim2101024@gmail.com> <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
 <7fa897cf-4d58-c63f-afdd-a3ec5a6a56bf@gmail.com> <CAKv+Gu8aJRV4nqq1e-5HRLvbrANQsYuMf-pwWB53BhxLgX7iWg@mail.gmail.com>
 <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Sep 2018 14:33:16 -0700
Message-ID: <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound traffic
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20 September 2018 at 14:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
>> On 20 September 2018 at 13:55, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
>>>> On 19 September 2018 at 07:31, Jim Quinlan <jim2101024@gmail.com> wrote:
>>>>> The Broadcom STB PCIe host controller is intimately related to the
>>>>> memory subsystem.  This close relationship adds complexity to how cpu
>>>>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
>>>>> identity mapping, or an identity mapping off by a constant.  Not so in
>>>>> this case.
>>>>>
>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
>>>>> of system memory.  Here is how the PCIe controller maps the
>>>>> system memory to PCIe memory:
>>>>>
>>>>>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>>>>>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>>>>>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>>>>>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>>>>>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>>>>>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>>>>>
>>>>
>>>> So is describing this as
>>>>
>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
>>>>              <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
>>>>              <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
>>>>              <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
>>>>              <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
>>>>              <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
>>>>
>>>> not working for you? I haven't tried this myself, but since DT permits
>>>> describing the inbound mappings this way, we should fix the code if it
>>>> doesn't work at the moment.
>>>
>>> You mean encoding the memory controller index in the first cell? If that
>>> works, that's indeed a much cleaner solution, though is it standard
>>> compliant in any form?
>>
>> No those are just memory addresses (although I may have screwed up the
>> order). From Documentation/devicetree/booting-without-of.txt:
>>
>> """
>> Optional property:
>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
>>         (child-bus-address, parent-bus-address, length). Each triplet specified
>>         describes a contiguous DMA address range.
>> """
>>
>
> Then I am confused by your comment, that's what this patch does, it adds
> support for reading "dma-ranges" from Device Tree and setting up inbound
> windows using that. The only caveat is that because the PCIe root
> complex has some ties with the memory bus architecture it is connected
> to (SCB in our case) there is still a requirement to know the
> translation between a given physical address and its backing memory
> controller/aperture.
>

Ah ok, apologies for the noise then.

I was hoping that having working support for dma-ranges would remove
the need for the special phys<->dma conversion routines.
