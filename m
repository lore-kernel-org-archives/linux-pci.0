Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A045FC4360F
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EC020872
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1rV8nmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfCQXjp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:39:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34840 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQXjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 19:39:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id 81so3630464wme.0;
        Sun, 17 Mar 2019 16:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W0AGrUQU4RQ1Rh8lzIta0OsLxz/E85KjXJvIpuaCh8c=;
        b=W1rV8nmj+umBdL19Lg+e/+kW8qz4Lm22Mx17qKXOCpnNuv7pxv8DL75wMoUic9jCEO
         N1+wYp7Orc7LsvtkUqLy9VZyp6Z3uBFqnSD0cGu8jI3DvKqOX4aPhXStQgyGKHgXmf7S
         XdSudlpqFPRVhomzl7o/W9rpC1u5nnPmk8fjbnABo8PjEKnMLDwDXM0L19rYF53M3zAv
         xYaI/yULaei1DtyJfEff3YEPEmBsP1Eqn1nxaxePLEDrt7B5EsHJADRMR+xcKovJicwH
         dUsJzYnBPrxN2L9gUZBoUVsWC7WvTmK0Vn9ynXIX7UYS+mH+X3XH3H40fe1VZ8+cqbUr
         kMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W0AGrUQU4RQ1Rh8lzIta0OsLxz/E85KjXJvIpuaCh8c=;
        b=nULmMukU7/cVug/rm1Xc7rKw6Dm4tqraTIKCjlLQg9rRxX74oHPK4zdNIiHu//8MLc
         QhMAg4NTnqwb1dn2hjfxwhatsNS3M1vSoX9Y0xXPzGacNFRKr/9xwLbZoQfmpP1jd5Sa
         XJbpBUlM5cyvLa2RqAcYRmlx378dlneGE57LSVy5zFrBz/7TVK/AmUq8Z9vySXCqbVSB
         Qu1bwLOoeHInCbIoPXzG3U4/bzUiOg1wy6qx5nIgSBAwaPSMIJFA1KH+mqudvuRjX22q
         fMPBgdcL9AwxvUAFg74xTPmT/QzsbRsM9wk/UPr3X6tgLWPXglK5YiwFWCOp0TXrJOG3
         0BtQ==
X-Gm-Message-State: APjAAAWPUUKDnYZ49PR8BFSADRD+Imhdssx4eW+uJSu2wSmkSyt0JZ5C
        L2zPn3ycBM/tdJDjKPjcMzKJARGA
X-Google-Smtp-Source: APXvYqwdQFf8LaHA2AKorflKwj32R7yPtGxnUI9NOxd8MhpsfaYkkymgnxnEBOmjqEOLIhiGX6ztBw==
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr8975733wmg.14.1552865983348;
        Sun, 17 Mar 2019 16:39:43 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y192sm7732148wmc.6.2019.03.17.16.39.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 16:39:42 -0700 (PDT)
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
 <d49be905-2e59-e65f-cf3b-191eb972ec45@gmail.com>
 <CAMuHMdXWKWtzmm=MiSxmBk-C0Y2QSGVQNNYstJidSOp637f3+g@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <e3dc95ed-c331-2b92-8e3f-8e69937c8d66@gmail.com>
Date:   Sun, 17 Mar 2019 23:50:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXWKWtzmm=MiSxmBk-C0Y2QSGVQNNYstJidSOp637f3+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/19 11:22 AM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Sun, Mar 17, 2019 at 1:06 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 3/11/19 10:41 AM, Geert Uytterhoeven wrote:
>>> On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
>>>> --- a/drivers/pci/controller/pcie-rcar.c
>>>> +++ b/drivers/pci/controller/pcie-rcar.c
>>>> @@ -152,14 +152,12 @@ struct rcar_pcie {
>>>>         struct                  rcar_msi msi;
>>>>  };
>>>>
>>>> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
>>>> -                              unsigned long reg)
>>>> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
>>>
>>> Doesn't unsigned int make more sense for reg?
>>
>> Isn't u32 more explicit ?
> 
> It's just an offset in the register block, with a range much smaller than u32.

We could use u16 ? However, Bjorn's concern was that using unsigned long
for registers was not recommended ; how's unsigned int better ?

-- 
Best regards,
Marek Vasut
