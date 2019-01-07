Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB4C43612
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502602085A
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="daZ4DhO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfAGI6s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:58:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37651 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfAGI6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 03:58:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so109400edb.4
        for <linux-pci@vger.kernel.org>; Mon, 07 Jan 2019 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Th9BvYaGibqs1kjLWZxxqSN1OnYLVs5YECXoMK3YXAo=;
        b=daZ4DhO+/5bDdu5p7qhrqEXNtvI9ZKHfB3jF6h/qjLLErgObp1YpshaLOQyKBEJk0y
         EaMs5XEBPyP0j2PagC2Y/e+OVpxwOc41mG/QEjZHvMoA8V38qlUgbGXejJafSrWMeXFR
         2dPKjQ5Dwd4eawxiV305PkqQSIMbwcWKbpsoEsvZgSr0MmQgRgeoEWkb05oRZL0NIyY5
         ksQw+CLQcCRKbPYKFvbD3M3sHyY9QVMC1F7fOsMC8mEk2Dy4TXaOTW/blFWu3xBKniRn
         Be4EaxB4L9xvU/JB2hoVvmL0U+Y4wv1P/FCt+nw6BmEHptbs1R9XqjoUs2lSfWRFF38N
         fSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Th9BvYaGibqs1kjLWZxxqSN1OnYLVs5YECXoMK3YXAo=;
        b=lr+H3oO1du6A+Y6X/dDX/CKUxMe588JJ0b+qX/SIPdUFVOrQPWLH4eGwpTc85w099I
         ZM31/ZU5DKr9K7Q9e6pte6nKvfQEe5K145qzmLs96+bypVtFyYhNrsf8ntHBOp0f+btt
         XmCj3cBK8LWJb8KjbZrpgXB7nhvWMjnOc+A1rxHlCY8LoEC/fcVhkqMipw3g01q85YPz
         haNagHfNkbU2ca5x2Foi0GLh5V4cu8C1Cct9TjmjhHwbkkiY+ME1302VLfB0yw8Qf3b7
         Omxxk9beiDqwsJ9zQURKS976upYZnQomL0JgHbtt+23hvgDu1mie1u5nNZeys3649u76
         WseQ==
X-Gm-Message-State: AA+aEWYLLtQJ9wZsvsYdhPiHQnHb+KVZT3cpqSdg+2fz6xpg4cvK5BEa
        4N2igFGnwUXzAXypFPpXIzFAqQ==
X-Google-Smtp-Source: AFSGD/Xajdc1Emkq7ZUOTJLFg+NCU+rqoFnhNUYJSh2h/RrQtKk7phnzQX1R6ZYlBYhtxN+U5b17kg==
X-Received: by 2002:a50:c31a:: with SMTP id a26mr56117105edb.160.1546851525970;
        Mon, 07 Jan 2019 00:58:45 -0800 (PST)
Received: from [192.168.3.176] ([91.179.126.85])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm17874417ejb.53.2019.01.07.00.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:58:45 -0800 (PST)
Subject: Re: [PATCH] arm: cns3xxx: fix writing to wrong PCI registers after
 alignment
To:     Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
        Robin Leblon <robin.leblon@ncentric.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
References: <20181218111743.25566-1-koen.vandeputte@ncentric.com>
 <20181230010625.GC159477@google.com> <m336qegfzv.fsf@t19.piap.pl>
 <20181231152918.GE159477@google.com>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <a7531ef2-d6d0-0a48-1558-23474c97b838@ncentric.com>
Date:   Mon, 7 Jan 2019 09:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181231152918.GE159477@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 31.12.18 16:29, Bjorn Helgaas wrote:
> On Mon, Dec 31, 2018 at 11:14:28AM +0100, Krzysztof Hałasa wrote:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>>
>>> 802b7c06adc7 replaced cns3xxx_pci_write_config(), which always used
>>> __raw_writel() so it only did 32-bit accesses, with
>>> pci_generic_config_write(), which uses writeb/writew/writel()
>>> depending on the size.
>>>
>>> 802b7c06adc7 also converted cns3xxx_pci_read_config() from always
>>> using __raw_readl() (a 32-bit access) to using
>>> pci_generic_config_read32(), which also always does a 32-bit access.
>>>
>>> This makes me think the cnx3xxx hardware is only capable of 32-bit
>>> accesses, and this patch should change the driver to use
>>> pci_generic_config_write32() instead of pci_generic_config_write() in
>>> addition to the mapping fix above.
>> Hasn't it already been verified that the CNS3xxx can do 8-bit accesses
>> (and probably 16-bit ones as well), and that the docs don't mention any
>> such limitation?
> Quite possibly.  I'm not familiar with the hardware or docs so can't
> comment personally.
>
> 802b7c06adc7 reimplemented cns3xxx_pci_read_config() using
> pci_generic_config_read32(), which preserved the property of only
> doing 32-bit reads.  It replaced cns3xxx_pci_write_config() with
> pci_generic_config_write(), so it changed writes from always being 32
> bits to being the actual size.  I think this was an error in the
> original commit, since the changelog doesn't mention this change; in
> fact, the changelog says it changes __raw_writel to writel.
>
> The change from 32-bit to actual size accesses would logically be a
> separate commit from changing to use the generic accessors.
>
> Assuming the hardware does support smaller accesses, I'd propose two
> patches:

Bjorn,

Thank you for your time to look into this.

>    1) The current one that corrects the address alignment error, and
Is it required to resend this specific patch?
>    2) A new one that converts cns3xxx_pci_read_config() to use
>       pci_generic_config_read() instead of pci_generic_config_read32().
I'll first extensively test non-32b reads later today and will send a 
patch for it
> Ideally the changelog for the second patch would refer to the
> verification that the hardware is capable of 8- and 16-bit accesses.
>
> Bjorn
Koen
