Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB81C10F00
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 03:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5AD206C0
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 03:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvmDbeNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfC1DTq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:19:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36246 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfC1DTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 23:19:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id k2so4274972plt.3;
        Wed, 27 Mar 2019 20:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kWd9WFpfLctaR5oPlxuRQQ7DS8FiCctxgA13vLEX+ko=;
        b=JvmDbeNShp0RPZVVjXpGIfcZDRxpjoiuC5utdWc1XNR9KQx6PyVm9caTDX0w1GiiGq
         hSOGBeKvhJ5cTbjQP6shiFg0y2g6CuNXYv953tDv9E59HBoGvX1O0H1GWUNGoObnE/8Q
         7AhnaWo4DueLwQfuBvcUvDdqsAc7fITX3Bmw0Twy1HhpOkdPFgjZgZDq8HBhCCdk6iR9
         29kunl4NHZGWQ0D39u4qHw/rpyU+SuHzKiCZSVhTzmzUSSzaKYCDlmpk1Y6QD9tTsH/R
         rca4eF08TZ+qHnKgvP+2acTftAQZET1GQOhJkKOPdfFt+aahDkflKjuDQaB54f2fbdI5
         uY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kWd9WFpfLctaR5oPlxuRQQ7DS8FiCctxgA13vLEX+ko=;
        b=gWFUi31FIv/iA9vj92CarRxCL2RnOcIWBc06tL4o4j8AR57yImm9f//lPmjjm1YkDO
         PE2ljOIitu4UQ8LdFrlfCbCKF0gBqVgQGdj3+i40RrxNF/FDxzDwDoPPpec9a5dPs0WP
         1gCiwxmJl2X5F7pvdwWVfeYkxLdB8B2yhaRg2faf0Dfpxi/kf3eQL2Dwocx7Bq7kkXvj
         pl9L+ps+gpEwfuzhJ3lEpiRFV7ItGXdh3mtpOT3h9gAZ7WrlONQFGAclzjRICX+59VbM
         UqbeoVQ9bHcY7OQNPgRoS42L2s+y5Eg5By/Yj1JrzkCctcvkftHg5loaDkv1IB/iYp1d
         OoGA==
X-Gm-Message-State: APjAAAW3m69S9aSh6GlitepoLO0GNMsUjpu+Nwn3hg/N34lmaPZibj4b
        IHi8dc+Dx6Cw0USpy9ofaoBNbDUL
X-Google-Smtp-Source: APXvYqz6dbAp2hlPICggBWjtrPrs3o/5rehKwVDYQ2Oo3ecEzFx63sWZ+7c7vh4kM9MZjImow646rQ==
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8mr40740098plr.12.1553743185039;
        Wed, 27 Mar 2019 20:19:45 -0700 (PDT)
Received: from [192.168.42.184] (219x120x4x122.ap219.ftth.ucom.ne.jp. [219.120.4.122])
        by smtp.gmail.com with ESMTPSA id h23sm28875432pfn.68.2019.03.27.20.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:19:44 -0700 (PDT)
Subject: Re: [PATCH V4 6/6] PCI: rcar: Fix 64bit MSI message address handling
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190325114101.10198-6-marek.vasut@gmail.com>
 <20190327113023.zhnx5v5spcx7uoqj@verge.net.au>
 <CAMuHMdW_6hutek-vk+mwDHJ1kBUytLvtkgLKb2mkSEFFasJ_0g@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <efcf526b-cfbc-ea54-f97e-f280e1f672fa@gmail.com>
Date:   Thu, 28 Mar 2019 04:03:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW_6hutek-vk+mwDHJ1kBUytLvtkgLKb2mkSEFFasJ_0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/27/19 1:22 PM, Geert Uytterhoeven wrote:
> On Wed, Mar 27, 2019 at 12:30 PM Simon Horman <horms@verge.net.au> wrote:
>> On Mon, Mar 25, 2019 at 12:41:01PM +0100, marek.vasut@gmail.com wrote:
>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>> The MSI message address in the RC address space can be 64 bit. The
>>> R-Car PCIe RC supports such a 64bit MSI message address as well.
>>> The code currently uses virt_to_phys(__get_free_pages()) to obtain
>>> a reserved page for the MSI message address, and the return value
>>> of which can be a 64 bit physical address on 64 bit system.
>>>
>>> However, the driver only programs PCIEMSIALR register with the bottom
>>> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
>>> not program the top 32 bits into PCIEMSIAUR, but rather programs the
>>> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
>>> SoCs, however may fail on new 64 bit R-Car SoCs.
>>>
>>> Since from a PCIe controller perspective, an inbound MSI is a memory
>>> write to a special address (in case of this controller, defined by
>>> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
>>> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
>>> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
>>> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
>>> cause memory corruption or other issues.
>>>
>>> There is however the possibility that if virt_to_phys(__get_free_pages())
>>> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
>>> to 0x0 _and_ if the system had physical RAM at the address matching the
>>> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
>>> physical address matching the value of PCIEMSIALR and a remote write to
>>> such a buffer by a PCIe card would trigger a spurious MSI.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>> Cc: linux-renesas-soc@vger.kernel.org
>>> To: linux-pci@vger.kernel.org
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Does this warrant a Fixes tag?
> 
> (digging in old sent email)
> Fixes: 290c1fb358605402 ("PCI: rcar: Add MSI support for PCIe")

But does it really fix that commit, given that on Gen2 and earlier, it
was not broken as those were 32bit platforms ?

-- 
Best regards,
Marek Vasut
