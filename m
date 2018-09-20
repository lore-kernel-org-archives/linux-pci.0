Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6904BC433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EB521534
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbDJrflF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EB521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIUDZE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:25:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33308 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUDZE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 23:25:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id i10-v6so54651qtp.0;
        Thu, 20 Sep 2018 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crh7B/Hz2t5OLCMZclcst7yFirtVksMJ2t1wVHRDTQo=;
        b=TbDJrflFtSMiDJNqjJYaH0X6vfI41QjJjbJAhCuOn7lllX1Zm8w7hnEzgCFyw6VhGu
         ecLd631muwpceA+ZW8YutcdwpiCt/xhQLQ8MWpndybEKv02j+bu9Cb3UolbxPxa785j9
         9yYVVjKKIqnmTR0Oieyi05mRwB0kx8ToBZ8kSZL/Xv7XgzRuOHgKlpL8AonXUO2Gix5U
         sMyQOpPli5YqDE1d8xM4Qt7frAVorDfYbOMKrvuioYVkfUHg2QS1xcA8O4kJ02v+j4hx
         mFAkg0yDiSzgYloWItyEt1+4Atp/35AbPLzB5cQpngiNZp3CbRLVDY2Szcf4KZhECHpU
         qdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=crh7B/Hz2t5OLCMZclcst7yFirtVksMJ2t1wVHRDTQo=;
        b=FFHNv7G1GM55dOlkAZTnmuefhepkXQj3ulYFMVTb/82TrfQezIu0ypRkiuKsuMIwob
         iK4ssozPQaU0D9nD7eH0wOOZ5Y4Bd71izY5LUkkqo+MXIEvyVjCHfFcreyHotQovXuwP
         SqOUh/NhN1P2Ehn2+XbLkyzWCp2opJXsnT8mFjvpPOOJ2TiYyKpjDHJ+HlPh1ooV0zby
         vEtvi/y/CNRQZdXP+BWRNWjepb+0IbSQZtGmb55t40LjhR4cy2uvAww+PykXEziK+hy2
         /OleiUYq8zlfEoFFF98g6VbkP8qfgqMVwsmNMLS7TBSAwTJxgM4etwDOcECQCNHzwqkp
         UFiA==
X-Gm-Message-State: APzg51DZ1NSWGEvPnpCDVlREdoAp8Zutqgx6RryKRYKsNC5UUn0MpPnM
        6UzscWAoIzYVYmpoeVCqRlY=
X-Google-Smtp-Source: ANB0VdZGW/EMlcWuZeTZqH2UrcvLVNkQQqSZBE0aAKIVfAM/gLvGQ4S3g+eZ32rjTKYobyvSfiwC/w==
X-Received: by 2002:aed:2f83:: with SMTP id m3-v6mr29245026qtd.96.1537479570806;
        Thu, 20 Sep 2018 14:39:30 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v10-v6sm18077619qtv.77.2018.09.20.14.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 14:39:29 -0700 (PDT)
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: add dma-range mapping for inbound
 traffic
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-5-git-send-email-jim2101024@gmail.com>
 <CAKv+Gu_d-r0ubyqZcDzERYd5FVTSpjBk++iACHqVgtHrOK0F7A@mail.gmail.com>
 <7fa897cf-4d58-c63f-afdd-a3ec5a6a56bf@gmail.com>
 <CAKv+Gu8aJRV4nqq1e-5HRLvbrANQsYuMf-pwWB53BhxLgX7iWg@mail.gmail.com>
 <b74d3c16-a512-73dc-c94a-ef6adde5f757@gmail.com>
 <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <fa285694-c3e1-adf8-032a-202e7598de41@gmail.com>
Date:   Thu, 20 Sep 2018 14:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8ZbN3BDRyuFzt4o--SSUmhuOh+jnpq8ZR-Ay13DJrAqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/20/2018 02:33 PM, Ard Biesheuvel wrote:
> On 20 September 2018 at 14:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 09/20/2018 02:04 PM, Ard Biesheuvel wrote:
>>> On 20 September 2018 at 13:55, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>> On 09/19/2018 07:19 PM, Ard Biesheuvel wrote:
>>>>> On 19 September 2018 at 07:31, Jim Quinlan <jim2101024@gmail.com> wrote:
>>>>>> The Broadcom STB PCIe host controller is intimately related to the
>>>>>> memory subsystem.  This close relationship adds complexity to how cpu
>>>>>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
>>>>>> identity mapping, or an identity mapping off by a constant.  Not so in
>>>>>> this case.
>>>>>>
>>>>>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
>>>>>> of system memory.  Here is how the PCIe controller maps the
>>>>>> system memory to PCIe memory:
>>>>>>
>>>>>>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>>>>>>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>>>>>>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>>>>>>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>>>>>>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>>>>>>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>>>>>>
>>>>>
>>>>> So is describing this as
>>>>>
>>>>> dma-ranges = <0x0 0x0 0x0 0x0 0x0 0x40000000>,
>>>>>              <0x0 0x40000000 0x1 0x0 0x0 0x40000000>,
>>>>>              <0x0 0x80000000 0x0 0x40000000 0x0 0x40000000>,
>>>>>              <0x0 0xc0000000 0x3 0x0 0x0 0x40000000>,
>>>>>              <0x1 0x0 0x0 0x80000000 0x0 0x40000000>,
>>>>>              <0x1 0x40000000 0x0 0xc0000000 0x0 0x40000000>;
>>>>>
>>>>> not working for you? I haven't tried this myself, but since DT permits
>>>>> describing the inbound mappings this way, we should fix the code if it
>>>>> doesn't work at the moment.
>>>>
>>>> You mean encoding the memory controller index in the first cell? If that
>>>> works, that's indeed a much cleaner solution, though is it standard
>>>> compliant in any form?
>>>
>>> No those are just memory addresses (although I may have screwed up the
>>> order). From Documentation/devicetree/booting-without-of.txt:
>>>
>>> """
>>> Optional property:
>>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
>>>         (child-bus-address, parent-bus-address, length). Each triplet specified
>>>         describes a contiguous DMA address range.
>>> """
>>>
>>
>> Then I am confused by your comment, that's what this patch does, it adds
>> support for reading "dma-ranges" from Device Tree and setting up inbound
>> windows using that. The only caveat is that because the PCIe root
>> complex has some ties with the memory bus architecture it is connected
>> to (SCB in our case) there is still a requirement to know the
>> translation between a given physical address and its backing memory
>> controller/aperture.
>>
> 
> Ah ok, apologies for the noise then.
> 
> I was hoping that having working support for dma-ranges would remove
> the need for the special phys<->dma conversion routines.

What you describe definitively works with platform devices, but I am not
sure this is working for PCIe devices, although, conceptually it should,
yes.
-- 
Florian
