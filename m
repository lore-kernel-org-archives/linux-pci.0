Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E9C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D272218AF
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="vz0PAS7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAXPXI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:23:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38355 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfAXPXI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 10:23:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so4876837ede.5
        for <linux-pci@vger.kernel.org>; Thu, 24 Jan 2019 07:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GXdQgYGth7576FUZgtf9G8w7Dw9MAY0ouCZtk1cxqAE=;
        b=vz0PAS7BMLyCFXCwTiDRcEcgbo7tefk81wrS+2sSiQ0ZCqUzd/KlcU2mVNLrgQZSIm
         WDwnTp3L2vSQBcKORpEbJxH9nlOnlQSppRREtLRbbMQXR9OpVANOgDCui08pbIXZalPh
         oT+I104XAMTblJB3diHbRmIKhwxOQOMJ16z+q1hXWZ6R55MnXwXbprhtzmX4oZ68EhrA
         oJkjHKOZ+uIoYy4gl75yy5frQE2NDZmvQiY8ZEjvWRCnJI0faG8ASp759yTllFXpyb2c
         ssaHBBCdHEDtojyojq6nY93AzWmS87/Ruy6dWsQaq0T/aYd4/DgE4QIxucaKgCwlapza
         vWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GXdQgYGth7576FUZgtf9G8w7Dw9MAY0ouCZtk1cxqAE=;
        b=Etn/U8JC4igG2FZ9D7Z9WttccIac7Gp4sHBMJGFP8zVKLKIG4BvWONGAA0i5D3VR1O
         52IxS4IN5kUEdvu7IGbYKo1jAr7Icfpag1rcNAeISwJBwiu8NiO7VV07rWpZRZYBgCI5
         Ya9zxGeztmxTWNRNzouT14YwmCUTelZIvHUQr9SQ3LbmImwI3C8D29So38WoD/zIl3d5
         1YPrrkD6gSZTLpUpf6FakG5wE5vvR6DYw8MT5iJIExIu3H4nfi2fepgZlJn+9cCqZC46
         Xl7rJHbXSAw5OU3+RtTVpmIF4qwOcxmidhZNvpKPM0nijt0ro5zGt2jovo/MVjTi8wfL
         PHTQ==
X-Gm-Message-State: AJcUukeXpg2omhn0nWHOWVfXyyrrI2V+tO8C3tAqpJuTO/MXIbsRxYAc
        iA3PUw2RC8sliziyMvq7MhFQWA==
X-Google-Smtp-Source: ALg8bN6V2l/V6wONt2XPRn+VspGdmGGQQ/07YDk1Kyy4Qd1kkPFTg7Krk+/FdjIDu1OTdrkS14I8bw==
X-Received: by 2002:a50:8863:: with SMTP id c32mr6832840edc.156.1548343386823;
        Thu, 24 Jan 2019 07:23:06 -0800 (PST)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id v11sm10873020edy.49.2019.01.24.07.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 07:23:06 -0800 (PST)
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
Date:   Thu, 24 Jan 2019 16:23:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124115656.GA23362@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:
>> Originally, cns3xxx used it's own functions for mapping, reading and writing registers.
>>
>> Commit 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
>> removed the internal PCI config write function in favor of the generic one:
>>
>> cns3xxx_pci_write_config() --> pci_generic_config_write()
>>
>> cns3xxx_pci_write_config() expected aligned addresses, being produced by cns3xxx_pci_map_bus()
>> while the generic one pci_generic_config_write() actually expects the real address
>> as both the function and hardware are capable of byte-aligned writes.
>>
>> This currently leads to pci_generic_config_write() writing
>> to the wrong registers on some ocasions.
>>
>> First issue seen due to this:
>>
>> - driver ath9k gets loaded
>> - The driver wants to write value 0xA8 to register PCI_LATENCY_TIMER, located at 0x0D
>> - cns3xxx_pci_map_bus() aligns the address to 0x0C
>> - pci_generic_config_write() effectively writes 0xA8 into register 0x0C (CACHE_LINE_SIZE)
>>
>> This seems to cause some slight instability when certain PCI devices are used.
>>
>> Another issue example caused by this this is the PCI bus numbering,
>> where the primary bus is higher than the secondary, which is impossible.
>>
>> Before:
>>
>> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>>      Flags: bus master, fast devsel, latency 0, IRQ 255
>>      Bus: primary=02, secondary=01, subordinate=ff, sec-latency=0
>>
>> After fix:
>>
>> 00:00.0 PCI bridge: Cavium, Inc. Device 3400 (rev 01) (prog-if 00 [Normal decode])
>>      Flags: bus master, fast devsel, latency 0, IRQ 255
>>      Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
>>
>> And very likely some more ..
>>
>> Fix all by omitting the alignment being done in the mapping function.
>>
>> Fixes: 802b7c06adc7 ("ARM: cns3xxx: Convert PCI to use generic config accessors")
>> Acked-by: Krzysztof Halasa <khalasa@piap.pl>
>> Acked-by: Tim Harvey <tharvey@gateworks.com>
>> Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Olof Johansson <olof@lixom.net>
>> CC: Robin Leblon <robin.leblon@ncentric.com>
>> CC: Rob Herring <robh@kernel.org>
>> CC: Russell King <linux@armlinux.org.uk>
>> CC: stable@vger.kernel.org # v4.0+
>> ---
>>   arch/arm/mach-cns3xxx/pcie.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> I have applied both patches to pci/arm-cns3xxx for v5.1, however I had
> to reformat and rewrite both logs (commit line wrappings,
> capitalization, etc.) so have a look.
>
> Thanks,
> Lorenzo

Hi Lorenzo,

Thank you for taking care of the wrappings etc.  it seems my auto-wrap 
was disabled in my git tooling ..
Your adaptions look more than fine.


Purely for my information:

Testing on a lot of devices here shows a huge improvement towards stability.
Is it possible to get it merged sooner?
Does "queued for 5.1" also mean that backporting to stables only will 
happen at 5.1_rc1 release?


Thanks again!

Koen

