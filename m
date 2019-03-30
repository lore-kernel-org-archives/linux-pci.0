Return-Path: <SRS0=NgI7=SB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD12C10F00
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 07:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF53218AC
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 07:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDgKYI73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfC3HqF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 30 Mar 2019 03:46:05 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54773 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfC3HqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Mar 2019 03:46:05 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so7385543itj.4;
        Sat, 30 Mar 2019 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u1beSa5oIAQ7wGPU59jRJJBM8WCUP2Zz2XbEbrMl6pk=;
        b=dDgKYI73kdqr6XaEA0yjNb5MdPPZ6Ah6PLE/TiEHLtQwi4sVeHEZVXIn9wja5DDKFi
         5fNX9fXJUGEAIog79g+TdyMnL9ylxqwBGzM4Dw3y2/YPmvIeFhd0Ln1EJ1N3QbQKgB1h
         sK0Q3p+p1v2XhqwQCasCIS75ni3eFBOWvSNS0zLhmFb9hQGWH8l5jxTXKicdb3VqrZef
         el/0eXAjc3H81oyi58CCvG7KMAV3R/8bc2jk73cok40ERZUi0xz47O+EVxGlG8Ue1BDz
         J3uUpYP6vBEl3VWmlLTrOaNG3teFoou/j65srVqtOUn71Ht69ThRaFXplOXbPoxw5LbQ
         fDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1beSa5oIAQ7wGPU59jRJJBM8WCUP2Zz2XbEbrMl6pk=;
        b=Nzva0cOS7MQetc9gLbpWi1JVDb+r2NgEwNSFByjsdX8yaC55enJx8xGWY8DQB8UHIH
         W1tNS8rsUkCJFMLDpAZr0fedQLxPdVoR+O3Z7DN7/zuYkdYWXHiriU5lPhO3e3jKO39L
         M+gJZH+6J5YHrFu5AMUAsfwCqb+bnAqjg9ErZ9TWQ7sJDP273MyuDWhUdyTO6Kgf9W3w
         70LVzlRxaGvP8Cgaow6tINZODY81OvPNfTr5DrVjaoI5qPsUVTu/vBF1F00jC2jGF1wz
         5HEgN0VkmO+3kzGfocqxRNrRou4BG+CIRtqjakUlxAveT0MY2vtxDpPDDbtoTMUuvWJ8
         D52g==
X-Gm-Message-State: APjAAAVOeSKNKzj+q2C1lWlT1IgGuDUD0mZFDpYAFKOkUv4raHClyD8f
        CnPBECq8SFnN6iUaDXw9Z9HAbsl3
X-Google-Smtp-Source: APXvYqx8x5v/lz4zVwyjFYQCCZDLVscZVCZBI35DNLqleYiuZI3iq+OGzgW6v2lFmCI7D5Vtagy3IQ==
X-Received: by 2002:a24:35c9:: with SMTP id k192mr6951720ita.156.1553931963622;
        Sat, 30 Mar 2019 00:46:03 -0700 (PDT)
Received: from [192.168.43.97] ([1.1.125.121])
        by smtp.gmail.com with ESMTPSA id y2sm1817000iob.44.2019.03.30.00.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 00:46:02 -0700 (PDT)
Subject: Re: [PATCH V4 6/6] PCI: rcar: Fix 64bit MSI message address handling
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190325114101.10198-6-marek.vasut@gmail.com>
 <CAMuHMdUEDR+oTAXeE+rjzHw5HzsjB_SerJZP4b8uDtfxTht-ew@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <56b074ef-cfcf-bcba-d332-c4f766c73402@gmail.com>
Date:   Sat, 30 Mar 2019 08:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUEDR+oTAXeE+rjzHw5HzsjB_SerJZP4b8uDtfxTht-ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/29/19 8:32 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Mar 25, 2019 at 12:41 PM <marek.vasut@gmail.com> wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> The MSI message address in the RC address space can be 64 bit. The
>> R-Car PCIe RC supports such a 64bit MSI message address as well.
>> The code currently uses virt_to_phys(__get_free_pages()) to obtain
>> a reserved page for the MSI message address, and the return value
>> of which can be a 64 bit physical address on 64 bit system.
>>
>> However, the driver only programs PCIEMSIALR register with the bottom
>> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
>> not program the top 32 bits into PCIEMSIAUR, but rather programs the
>> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
>> SoCs, however may fail on new 64 bit R-Car SoCs.
>>
>> Since from a PCIe controller perspective, an inbound MSI is a memory
>> write to a special address (in case of this controller, defined by
>> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
>> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
>> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
>> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
>> cause memory corruption or other issues.
>>
>> There is however the possibility that if virt_to_phys(__get_free_pages())
>> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
>> to 0x0 _and_ if the system had physical RAM at the address matching the
>> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
>> physical address matching the value of PCIEMSIALR and a remote write to
>> such a buffer by a PCIe card would trigger a spurious MSI.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> To: linux-pci@vger.kernel.org
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> V2: - s/it's/its/ in commit message
>>     - Add R-B from Geert
>> V3: - Reworded commit message and thus dropped Geerts R-B
>> V4: - Add Geert's R-B again
>> ---
>>  drivers/pci/controller/pcie-rcar.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
>> index c6013f95bdb2..62d2de9fbf1c 100644
>> --- a/drivers/pci/controller/pcie-rcar.c
>> +++ b/drivers/pci/controller/pcie-rcar.c
>> @@ -890,7 +890,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>>  {
>>         struct device *dev = pcie->dev;
>>         struct rcar_msi *msi = &pcie->msi;
>> -       unsigned long base;
>> +       phys_addr_t base;
>>         int err, i;
>>
>>         mutex_init(&msi->lock);
>> @@ -932,7 +932,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>>         base = virt_to_phys((void *)msi->pages);
>>
>>         rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
>> -       rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
>> +       rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);
> 
> As reported by 0day, this causes a warning on arm32 without LPAE:
> 
>     drivers/pci/controller/pcie-rcar.c:935:32: warning: right shift
> count >= width of type
> 
> Using upper_32_bits() instead of an explicit shift should fix that.

I saw the report too.

Lorenzo, do you want a separate patch to squash with this or V5 ?

-- 
Best regards,
Marek Vasut
