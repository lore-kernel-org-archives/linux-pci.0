Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83CC10F05
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E523D20879
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltHuqhiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfCZRY3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:24:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40204 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZRY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 13:24:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so10600443wmi.5;
        Tue, 26 Mar 2019 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gVLN1pxg7UWkSp/Tcnurq+jyhk0N/Fd73p7EHEMDktE=;
        b=ltHuqhiOqZdrqskHj1/s6i0VconGX5YrSU5Kg84y25FYuyN5DQczh83kUQVyUQUwTV
         Tph61+L/ZUjUJqCssgaHOZYgw4tGnTwJqIFivYL5+QFV8viPeWkKTtnqyunc8WgTZHM6
         fN1BA4HPD5vUyCUz4V+Wl01gRHaP9xEV6Hcq+5C/P0nMEqRXO2GIGmQQDicZhIrxL+rE
         lHxnM/cw9xnFtXkLpLq5nXOGcI06HqP0+6r2nGzi+7vXRdXFkN/79p8lC5MT3z13XgUJ
         cQ1lMkNLr2oFGAfV8gHS67hdn1eOucMW1111EybMa2//H5O7XZLpjtUBjKC9utkUq4l7
         PLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gVLN1pxg7UWkSp/Tcnurq+jyhk0N/Fd73p7EHEMDktE=;
        b=KglS8hdLfYNe+iFDZ+gBzZ027r2LeQwYcVywnogWjS/XtXpNSCQYrJkFYGiMoZrrMQ
         A9+iU8Dv16tURUpcfdu+0yYsxs4aJN+JkmGoHNRghGvqjlm0JY/UnGlJYldI5NQtvzkt
         4alKpPUXTImRFdp6wujoPO2e7LQCPgKqyokBcaN31jqFheEIvaWnsJRHXxtYhBWrtRTc
         OnwdOIlqbp2PUVottUVb5DhfYBV77y/ipOA5oGu88SDEW1ZQWPgRbQ0/TqzPHfrLeQGB
         1le+LgR1y6oD8Sx29MVCAOOohQrj64rRZ7Kn3U3iBCU7hvwQTVL6UL7zP288GsZaanjc
         N8yQ==
X-Gm-Message-State: APjAAAXwMrojIBPQKs5zMlRSdxEN71pz0A810uXAv9KDGazt/mY0UD2h
        DCg/7xJbhvir4Z6vgHWuP9c=
X-Google-Smtp-Source: APXvYqzK7s6WOqstHGLvVku/AUziJjRnSoyxz0oLpGqu14ls9rCRb4mnLvBXIGX9m87UJZAANlkiTQ==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr9953652wmi.141.1553621067096;
        Tue, 26 Mar 2019 10:24:27 -0700 (PDT)
Received: from [192.168.42.184] (cst-prg-31-181.cust.vodafone.cz. [46.135.31.181])
        by smtp.gmail.com with ESMTPSA id r63sm31255253wmr.32.2019.03.26.10.24.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:24:26 -0700 (PDT)
Subject: Re: [PATCH V4 1/6] PCI: rcar: Clean up remaining macros defining bits
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190326130444.GA5466@e107981-ln.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <515ae430-edf3-b895-cd3a-5cdc830ecd35@gmail.com>
Date:   Tue, 26 Mar 2019 17:48:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326130444.GA5466@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/26/19 2:04 PM, Lorenzo Pieralisi wrote:
> On Mon, Mar 25, 2019 at 12:40:56PM +0100, marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Replace macros using constants with BIT()s instead, no functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> To: linux-pci@vger.kernel.org
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> V2: Bundle this patch with other cleanups before resending
>> V3: Add Wolfram's R-B
>> V4: Add Geert's R-B
>> ---
>>  drivers/pci/controller/pcie-rcar.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Hi Marek,

Hi,

> I assume this series makes:
> 
> https://patchwork.ozlabs.org/patch/1053779/
> https://patchwork.ozlabs.org/patch/1057454/
> 
> obsolete, please let me know and I will drop
> them from the PCI patches queue, I will get to
> this series later for v5.2.
Yes, I decided to merge the two series together to make it easier to pick.

Thanks

-- 
Best regards,
Marek Vasut
