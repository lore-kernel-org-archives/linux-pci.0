Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C93C10F05
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 09:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96082082F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 09:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYOEqrqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfC2JxZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:53:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42715 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfC2JxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 05:53:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so962226pgh.9;
        Fri, 29 Mar 2019 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fFE8b3BpTyOPrNF2kNR6XYzB/xOh8vipwlT1IcJRG6w=;
        b=PYOEqrqAPWQXnHedYY1p8DEB1BHcD/0BiRPtQ8oeeR8smnXHI051ILW9EBrK18Sh/2
         XT6OaerP7V/gUjFC2kwcBDRK5LvQf09sZ40vgdHiHbLSQlIOLdMTqfW34cszGYrg/as9
         kJoJmol9773Bdn1dHxaqapMOZ5HRGWU2W2Ve/hKxgUxuS476zWD09UHZUS3/RfS962vs
         WdDKgKqI4Zy+HxE6qCkQPZ5hj1X2bwDBCMkb/ggeIjFeZSwDklGNxI4GFHoRvtR9fzJD
         q718kDDPbb5NZkDTYlw9b1jUo/Xj7YtMm/aZbEZnL9xLYQdJYHbPNu2Pq+n1sGsImVdw
         mG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fFE8b3BpTyOPrNF2kNR6XYzB/xOh8vipwlT1IcJRG6w=;
        b=rRcZqgLM/YzBAoMOhYr1jYKguE4fDwV5UWbtC+2L0PSmrYFo9SydNM2Bbzh4X7xhT6
         YxxifUW4gcZTiASNOC3lANvy6useeepHhO4/8ePDNPLIewUcHQC6UIIg8VPm3Sl658is
         zCSqkMBLeX2dlan1MnIMV72D4yGuMAGzKzGP1HLkj1t5Lf+WVc6VL0wC43E4NRGhgpIu
         01tAT2m115+57X1c9tco654th5OWoS7twxhZLugczozBwkHViye1YXP9af5GcymGI9j3
         GHUahHyltlWaGMJZAEMBp4+wehO4HT8QfmCGPcr8WJYiOdBKBLqFgLwsUe0sSX/3/RjJ
         M5dw==
X-Gm-Message-State: APjAAAWIzJCNIjbTP48oFhQ4Nc/uKbtbSE7kJPqGBycWQDwlomcO0Awn
        /Xiv0N46sP+CQLjX/c1wG+BtX0dj
X-Google-Smtp-Source: APXvYqw8FlSTSsLaARoWxd7mwACxB9hqjYF/ZC4JvawQdnNQFWmonKqbT+ulJtlBeGE15p7BKnqaBw==
X-Received: by 2002:a63:6e4c:: with SMTP id j73mr46204529pgc.276.1553853203649;
        Fri, 29 Mar 2019 02:53:23 -0700 (PDT)
Received: from [192.168.42.180] (219x120x4x122.ap219.ftth.ucom.ne.jp. [219.120.4.122])
        by smtp.gmail.com with ESMTPSA id k22sm2300897pfa.84.2019.03.29.02.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:53:22 -0700 (PDT)
Subject: Re: [PATCH V4 6/6] PCI: rcar: Fix 64bit MSI message address handling
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Simon Horman <horms@verge.net.au>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190325114101.10198-6-marek.vasut@gmail.com>
 <20190327113023.zhnx5v5spcx7uoqj@verge.net.au>
 <CAMuHMdW_6hutek-vk+mwDHJ1kBUytLvtkgLKb2mkSEFFasJ_0g@mail.gmail.com>
 <efcf526b-cfbc-ea54-f97e-f280e1f672fa@gmail.com>
 <CAMuHMdU7dQ=8UaSCoZ8TucMfaGyu38rxDYV=Tspw_UmCu5YVwQ@mail.gmail.com>
 <20190328162857.GB19825@red-moon>
 <CAMuHMdWuGx8wDmW7LZ3mbocieL1ZaKBvr=Um4XZ8FKdjiFqdzA@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8a25537c-482f-fd74-a61c-de14e342c38b@gmail.com>
Date:   Fri, 29 Mar 2019 10:53:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWuGx8wDmW7LZ3mbocieL1ZaKBvr=Um4XZ8FKdjiFqdzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/28/19 5:31 PM, Geert Uytterhoeven wrote:
> Hi Lorenzo,
> 
> On Thu, Mar 28, 2019 at 5:28 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>> On Thu, Mar 28, 2019 at 09:02:00AM +0100, Geert Uytterhoeven wrote:
>>> On Thu, Mar 28, 2019 at 4:19 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 3/27/19 1:22 PM, Geert Uytterhoeven wrote:
>>>>> On Wed, Mar 27, 2019 at 12:30 PM Simon Horman <horms@verge.net.au> wrote:
>>>>>> On Mon, Mar 25, 2019 at 12:41:01PM +0100, marek.vasut@gmail.com wrote:
>>>>>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>>>> The MSI message address in the RC address space can be 64 bit. The
>>>>>>> R-Car PCIe RC supports such a 64bit MSI message address as well.
>>>>>>> The code currently uses virt_to_phys(__get_free_pages()) to obtain
>>>>>>> a reserved page for the MSI message address, and the return value
>>>>>>> of which can be a 64 bit physical address on 64 bit system.
>>>>>>>
>>>>>>> However, the driver only programs PCIEMSIALR register with the bottom
>>>>>>> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
>>>>>>> not program the top 32 bits into PCIEMSIAUR, but rather programs the
>>>>>>> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
>>>>>>> SoCs, however may fail on new 64 bit R-Car SoCs.
>>>>>>>
>>>>>>> Since from a PCIe controller perspective, an inbound MSI is a memory
>>>>>>> write to a special address (in case of this controller, defined by
>>>>>>> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
>>>>>>> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
>>>>>>> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
>>>>>>> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
>>>>>>> cause memory corruption or other issues.
>>>>>>>
>>>>>>> There is however the possibility that if virt_to_phys(__get_free_pages())
>>>>>>> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
>>>>>>> to 0x0 _and_ if the system had physical RAM at the address matching the
>>>>>>> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
>>>>>>> physical address matching the value of PCIEMSIALR and a remote write to
>>>>>>> such a buffer by a PCIe card would trigger a spurious MSI.
>>>>>>>
>>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>>>>>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>>>>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>>>>>> Cc: linux-renesas-soc@vger.kernel.org
>>>>>>> To: linux-pci@vger.kernel.org
>>>>>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>
>>>>>> Does this warrant a Fixes tag?
>>>>>
>>>>> (digging in old sent email)
>>>>> Fixes: 290c1fb358605402 ("PCI: rcar: Add MSI support for PCIe")
>>>>
>>>> But does it really fix that commit, given that on Gen2 and earlier, it
>>>> was not broken as those were 32bit platforms ?
>>>
>>> It does not fix the bug on that commit, as the bug cannot happen on arm32.
>>> It does fix that commit, in that that commit used "unsigned long" for a
>>> physical address, which is wrong, even on arm32 (esp. with LPAE).
>>> If you insist on having a Fixes tag for a commit where the bug could be
>>> seen:
>>> Fixes: e015f88c368da1e6 ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
>>>
>>> Apart from that, drivers should use the DMA API instead of virt_to_phys().
>>> However, now we have a better understanding of how MSI interrupts
>>> work, we don't even need to allocate that page. All we need is the
>>> physical address of a page that is guaranteed not to be backed by RAM
>>> (i.e. not to be a valid target for a legitimate PCI bus mastering
>>> transaction).
>>
>> Agreed but I would merge this patch first since it is a fix
>> and update it later.
> 
> Sure, definitely.
> 
>> Shall I go with the Fixes: tag above ?
> 
> Fine for me, thanks!

I don't feel strongly either way.

-- 
Best regards,
Marek Vasut
