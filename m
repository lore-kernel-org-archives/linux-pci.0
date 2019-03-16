Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2727FC10F03
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E427F218E0
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 00:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csfuSrxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfCQAGk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 16 Mar 2019 20:06:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCQAGk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Mar 2019 20:06:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so13205492wri.7;
        Sat, 16 Mar 2019 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FiEiMwhVyHOx5HVB+onPD8sXRF3yP6ld81UFhnLGG4w=;
        b=csfuSrxz5MMa8B7LpBp6eTZIvcvwLhhIXsA61nUQDPkydYXEFsju4QPbNEKaSjRG8P
         9C5t33GwzlxfymRZKf0pOJ2gZHWf8Ty8DxxW87K1FeS11k/p7za2lfPnMsZgGLsGHPwY
         1R+HtIuE3ZUlW4N++s0z7fKmIswM1gebuGqBYsowzL2hoycGR2VtEBkODRYvle2asBak
         NdQS0XzNwqfI1dlNZwcOjXcf4rDVOdUSL8j87TPB6+GLivrlNpRDLOTd/wGa2Z2JV3C5
         HfcZ2P/Eit7rfd2lcLNZvWr3FBz9ACsvO+4okomgHMUS+1RekmBq42fVOIRpMZYF5aTL
         uiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiEiMwhVyHOx5HVB+onPD8sXRF3yP6ld81UFhnLGG4w=;
        b=WZmcOEY93mMWEdqZahNN7MEt753vya8AoEDkN7svZeypUE6Eo6iZRwxJ+Vym0ewg++
         5Rya2D2/qJfcbJtob0e0+9k0krpi5/9zLyY7tSAK8z5KYNTr686YlcKPFBXs4ULfTB+y
         RzBPgbfBqID4P5t8UKldKEy7xJUwmct+ttbtymXQSxr2JxVIew01lWKuPKzK/n8guykE
         5d403VTfjb8vOOsR3MTtOvmiLk4p+NOtfpbSWST0eUffFLsDZE5Lck5cDjpWnPrmSwq/
         XxDK+H6w5GCebJvuXyKjj8AUxx0CscTykJQPOUHoBmGZqra0fbtZS5dL1T/h+IZ0E3qV
         9E+w==
X-Gm-Message-State: APjAAAUvZ5jpRgI7mDfQgoGGHX1nLA1Vrd5uBveyTKTRAFCybWC5gIW3
        UEW+GYjWBgub3Ifh+g6KM854T303
X-Google-Smtp-Source: APXvYqx6go4G2DvrDhQjZ4jkoNRG3yNvSVy5I40LYJST/5yb8eZOKixZQLsHVdfYg6rsmep9P5hW6A==
X-Received: by 2002:adf:eb8f:: with SMTP id t15mr138018wrn.119.1552781198082;
        Sat, 16 Mar 2019 17:06:38 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id h1sm3158294wmb.5.2019.03.16.17.06.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 17:06:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] PCI: rcar: Replace unsigned long with u32 in register
 accessors
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190309005613.1493-1-marek.vasut@gmail.com>
 <20190309005613.1493-2-marek.vasut@gmail.com>
 <CAMuHMdXGn50+hAoPBmnatf+onXezhNUwDWv+izj3j_QVMMFNGw@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d49be905-2e59-e65f-cf3b-191eb972ec45@gmail.com>
Date:   Sun, 17 Mar 2019 00:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXGn50+hAoPBmnatf+onXezhNUwDWv+izj3j_QVMMFNGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/11/19 10:41 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Replace unsigned long with u32 in register accessor functions,
>> since they access 32bit registers.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Thanks for your patch!
> 
> Minor nit below.
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> BTW, there are a few more suspicious/incorrect uses of unsigned long:
>   - incorrect debug prints on arm64,
>   - more unsigned long register values,
>   - phys_addr_t
> Care to fix these as well?

I'll send those shortly, as a separate series since they don't conflict
with each other.

> Thanks!
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
> Doesn't unsigned int make more sense for reg?

Isn't u32 more explicit ?

-- 
Best regards,
Marek Vasut
