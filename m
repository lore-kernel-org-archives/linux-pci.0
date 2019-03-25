Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EDCC10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DA02085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxmL0m6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfCYLgs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:36:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54830 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfCYLgr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:36:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so8545744wmj.4;
        Mon, 25 Mar 2019 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZFoRSHzL1wo422cW5POlbNg9ry25LefJ/bduAAp8fWs=;
        b=uxmL0m6SuXHalWPP+GtO2i+m+Hcxt1CZZI76BJSYwr6jFp/Mb90K7FJ/0k6Ag/+Wdm
         n+TyZpUfjBUG1iUWUwaj2Qcq8RF4Rv1Y+nUoGWvuZwPDwo/hI9fACEWpZkxpELv9Uljs
         aPLYCHhw2zzukv0hCkWm//lZ1rIj3Va2AobokWujTmYhQashwsK2Q1id4O7U23yswAxj
         RePPgFsZa/fxJ7+kQCNqZGMk/E7vYWt+O7gQDcu/OOgAuIdUIWW9cNCCsXt0Nqt0iNBH
         ZfZCLSe8MC2YX8+zethVvt1rvAG3GfvSllg/w3V+VPayMK9fagVKgrYnk9wgkCJy9WJY
         4MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFoRSHzL1wo422cW5POlbNg9ry25LefJ/bduAAp8fWs=;
        b=RODMfl0h7ypKCffmJJluZzKBCroBMhcE2N5frwJX7NlkPk+IPvJTNMIglLAtKmkM7w
         CizoReZEsR/GwrMZDpGES/gHnn69PeHQvED1MiedAlFwca5wgXYJDV98HULGLfkIQ48K
         kKRHeot8MSn2ew9lzi5CrEWIJW5d2+17hjNzH7cNuPOvKr0kXx7Fw5P+mDcQJYMowIWY
         RlZK//cn5CMnwfDhaixeYRFMAXArRUO4kQS+ubZQV/D3bSsxOVLz6ag/sBo5osyU1YOq
         trk9VHseFB1cI4BmtXL4fy7k9R0Jp+q/41QBRvHK2Ps1lfiMB6/H3y+HZNLy5mzi2LSa
         uJQg==
X-Gm-Message-State: APjAAAWJf1ObgIWrMPVLGkxooMh8ispZz5NO/DhBsIvKWs1q0UTeUF1p
        0L0MiLwCjZt4+hwWjIMEfB6UwFQc
X-Google-Smtp-Source: APXvYqxd6LQSDuyzi4n3mdvTZ8MxANY62cE8WX7VR5YbRtPPAYxWRd9rkB4K7Lt0S35wSmeHKjIm0g==
X-Received: by 2002:a1c:c4c3:: with SMTP id u186mr1678139wmf.138.1553513805323;
        Mon, 25 Mar 2019 04:36:45 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id u19sm18101506wmc.7.2019.03.25.04.36.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:36:44 -0700 (PDT)
Subject: Re: [PATCH V3 2/6] PCI: rcar: Replace unsigned long with u32 in
 register accessors
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20190323015359.7231-1-marek.vasut@gmail.com>
 <20190323015359.7231-2-marek.vasut@gmail.com>
 <CAMuHMdVad84pxwQHP4kQTUxabKbNyD9nURpYkoJnZrQULN1sbA@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <f01b1c52-6548-c7d1-4866-bbd62dd83543@gmail.com>
Date:   Mon, 25 Mar 2019 12:24:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVad84pxwQHP4kQTUxabKbNyD9nURpYkoJnZrQULN1sbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/19 9:07 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Sat, Mar 23, 2019 at 2:54 AM <marek.vasut@gmail.com> wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Replace unsigned long with u32 in register accessor functions,
>> since they access 32bit registers.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> To: linux-pci@vger.kernel.org
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> ---
>> V2: Bundle this patch with other cleanups before resending
>> V3: Add Wolfram's R-B
> 
> Forgot mine?
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>> --- a/drivers/pci/controller/pcie-rcar.c
>> +++ b/drivers/pci/controller/pcie-rcar.c
>> @@ -152,14 +152,12 @@ struct rcar_pcie {
>>         struct                  rcar_msi msi;
>>  };
>>
>> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
>> -                              unsigned long reg)
>> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
> 
> reg is is not a register value, but a simple integer offset.
> 
>>  {
>>         writel(val, pcie->base + reg);
>>  }
>>
>> -static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
>> -                                      unsigned long reg)
>> +static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, u32 reg)
> 
> Likewise.

Sure

-- 
Best regards,
Marek Vasut
