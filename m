Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBDC10F0E
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613320855
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG8UEEqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfDDQUe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:20:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46373 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfDDQUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 12:20:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so1399363pll.13;
        Thu, 04 Apr 2019 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2SEusfEFXsiILNdaOyq8RGU5v/5vptx1DUIt4v74SOE=;
        b=ZG8UEEqnYmwA+v7DAMPYEpJY0D6ZOVQVjnSJ4jT8Uyq1pZhlGrZcoIh77ZpKMTLkL9
         NqX7xI9+howvnDrxgC4IrhDJW0q7t8KK4NP3zroPqNHW4ERyzqB/6aTONhuTaN9M9fwe
         w8VknQRLjQh/DI3PVPgeHUjSYWIWoqvzN7NXMcfglxgtu4F1Pugue5IsaPVACjEPmH9b
         2bz4/UduOoDSRHGI6rU1LLSrzrOyiLYKHHd8sa58+qkC5M759e8br2ZDZ4dnqeeV7Bxb
         1VgN+DdqEqnJAM21Bi0ZyEXA+cNxTVX01a4uLaga4FJl4+WZqD1SYsNPac20p1GhG83F
         6znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2SEusfEFXsiILNdaOyq8RGU5v/5vptx1DUIt4v74SOE=;
        b=LY56H+VDH2CDIh3yujV/B0HJITOTXZdTO/fTpPm9wesp89dvqPRGXKU6wGRZz6lIDb
         uF1kwhhF5XzOohOUmb6gyvtkiu87a9hzPtdUTQMMrQL4belVF5JUi6IfbnFGtmnX6U3Z
         O+SAXNIPfWURHJjw5I3EzRHz32LS/lceq2zuJTHbrelBiHWAB7V0WRq8sXr2+nztaasx
         VrFx0wdqBynY+yNloG9xEMp7T4H1meT/ef0QR2BPmX4Zl6LLq1Hd74HDX9ruUx6tdtLO
         10ebAHZPcNT65sTvNpb+NQsHdFrfgKbtAyaPEk6HkbzvBGqNLAt24GVBbcD8bKlloqUL
         V8pg==
X-Gm-Message-State: APjAAAUVa2Q9Hw4puAjiEpUs3yank8qN4JGF4VLZQj9ibcly8EUsc4oA
        zf1UkyJhWIrAw3/kqZ9aVACFYVdU
X-Google-Smtp-Source: APXvYqxFaiURWOnArfwq2OvSdhklthSldRb2fTIzjkp+1GAKNJkDTFeABq4lbb3PuluVyCUZKoVQnQ==
X-Received: by 2002:a17:902:2888:: with SMTP id f8mr7426327plb.244.1554394833169;
        Thu, 04 Apr 2019 09:20:33 -0700 (PDT)
Received: from [192.168.42.180] (219x120x4x122.ap219.ftth.ucom.ne.jp. [219.120.4.122])
        by smtp.gmail.com with ESMTPSA id y37sm29705052pgk.78.2019.04.04.09.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 09:20:32 -0700 (PDT)
Subject: Re: [PATCH V5 6/6] PCI: rcar: Fix 64bit MSI message address handling
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190402013307.20912-1-marek.vasut@gmail.com>
 <20190402013307.20912-6-marek.vasut@gmail.com>
 <20190404092833.GA13236@red-moon>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <267aa1b1-9761-aff7-8462-8efc644083bd@gmail.com>
Date:   Thu, 4 Apr 2019 17:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190404092833.GA13236@red-moon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/4/19 11:28 AM, Lorenzo Pieralisi wrote:
> On Tue, Apr 02, 2019 at 03:33:07AM +0200, marek.vasut@gmail.com wrote:
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
>> V5: - Rebase on next/master 20190401
>>     - Use {lower,upper}_32_bits() instead of >> 32
> 
> If that's the only reason you resent this series I will add the
> lower_32_bits() code myself.

Yes, you asked me to resend the whole series after the bot complained.

> Please do not rebase on top of next, apply code on top of a fixed -rc1
> (we are currently using v5.1-rc1) and if there are dependencies on code
> already queued do let us know, we will handle conflicts in next
> ourselves.

So do you want me to resend this one more time ?

-- 
Best regards,
Marek Vasut
