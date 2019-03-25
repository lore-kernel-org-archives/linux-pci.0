Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB264C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6762085A
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRXRUOPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfCYLgv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:36:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37478 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfCYLgu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:36:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so9717417wrm.4;
        Mon, 25 Mar 2019 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7pyoazIT7Cx44Avi/cWlxN/yNSoGZ4txuYEPDZUMMF0=;
        b=RRXRUOPTN0MjR5WXIQR8onnhOhN4rUqSp15lUWWpbgezdn0ERJQw+xNRK8UOLZyuK/
         yG+wmr4c3ez6LGibVHqDwOulh7TmrA94XVO/7fIbsFA6lQoIwWyhr7JcHdp6z8inRxgA
         +Q04ZRUWBR/MqHATMnlCPYpPZpkMbc65w0AMcKTNmuiDj84TBZoEZzWMGadga5cLgjRJ
         R8FCVHw/jh9urU+z8my8AMSnr7YrnNa/cYyoVS5Sft2KNw/NC56B6NM/njhT3SnoOHhk
         NJ46Vb2WrNoeoxubiRyeP0bE3+5tc7y7uOlycALBQMN2jWdAMT8D3nS1OSNsAzVbqh7v
         nG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7pyoazIT7Cx44Avi/cWlxN/yNSoGZ4txuYEPDZUMMF0=;
        b=WDplD1HJakRytGw1aIahKs7z1rZyKo/gpO7vzIfqGz8Irp72lU2Q+RgwW7D/hfCpfl
         KQPnLdVEDDvMDL6rOrOXwld3/QMvgIrBFFOt07zYQt2CLNySA25EAaFWrKM0XSiNIHD/
         3C9dZd5CW777f6IUUVHKAzx1EG3pYWDtWOYjJdZ39lIyGwLQ+E/njCa3m7KsBTOIGK8D
         V+KjmQc53OreBm0ZIRWh7y90QRgY14pyPgk/1KVVfnIDmbkl1IazRVmgsVrYgPKWVhmI
         1Lr9PpXT9SpiMpNXkG95eCqHYT8vsrORwfDoTqKnv92l+PaQeJtuz3CgR6XIboO34zH+
         DP8g==
X-Gm-Message-State: APjAAAWBtzeL5OeNpJboxknIWV3ZmXYGiEzvqJU9BS8mQS1DQveRCY4N
        nj50MHbwE9yUBtFaQZ/ecBW2IfmE
X-Google-Smtp-Source: APXvYqw/qUMzZiaXgKx9ZJREO/Drvw3LIbCMPw8QZrtLNU/46me0PNI6RfXAtyHcrBVJSorJmYBUnQ==
X-Received: by 2002:a5d:68c6:: with SMTP id p6mr16192383wrw.321.1553513808619;
        Mon, 25 Mar 2019 04:36:48 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id z13sm13034302wrw.36.2019.03.25.04.36.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:36:47 -0700 (PDT)
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
 <e3dc95ed-c331-2b92-8e3f-8e69937c8d66@gmail.com>
 <CAMuHMdWCY-QjnrG83MezY0Qq=h1nMqayYKantssSBxJrHJrAaw@mail.gmail.com>
 <c715f6e2-e7bb-791b-4c85-e09cf1b7758c@gmail.com>
 <CAMuHMdURsR3ReGejsMnToQu+xoXCdaoRWxFg1r8yAcmWvQAXOw@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8d107ef9-608e-2077-c32e-3454914e6dee@gmail.com>
Date:   Mon, 25 Mar 2019 12:36:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdURsR3ReGejsMnToQu+xoXCdaoRWxFg1r8yAcmWvQAXOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/19 9:06 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Thu, Mar 21, 2019 at 4:20 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 3/18/19 9:19 AM, Geert Uytterhoeven wrote:
>>> On Mon, Mar 18, 2019 at 12:39 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 3/17/19 11:22 AM, Geert Uytterhoeven wrote:
>>>>> On Sun, Mar 17, 2019 at 1:06 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>> On 3/11/19 10:41 AM, Geert Uytterhoeven wrote:
>>>>>>> On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
>>>>>>>> --- a/drivers/pci/controller/pcie-rcar.c
>>>>>>>> +++ b/drivers/pci/controller/pcie-rcar.c
>>>>>>>> @@ -152,14 +152,12 @@ struct rcar_pcie {
>>>>>>>>         struct                  rcar_msi msi;
>>>>>>>>  };
>>>>>>>>
>>>>>>>> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
>>>>>>>> -                              unsigned long reg)
>>>>>>>> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
>>>>>>>
>>>>>>> Doesn't unsigned int make more sense for reg?
>>>>>>
>>>>>> Isn't u32 more explicit ?
>>>>>
>>>>> It's just an offset in the register block, with a range much smaller than u32.
>>>>
>>>> We could use u16 ?
>>>
>>> u16 may be more expensive on some processor architectures
>>> (MIPS comes too mind, don't know about ARM).
>>
>> On armv8a, none.
>>
>>>> However, Bjorn's concern was that using unsigned long
>>>> for registers was not recommended ;
>>>
>>> Wasn't that comment meant for the size of the register values?
>>>
>>>> how's unsigned int better ?
>>>
>>> Basic rule "If you don't care about the size, use (unsigned) int"?
>>
>> This only applies to the $shift variable, yes ? The rest are u32 since
>> those contain actual values read/written into the registers.
> 
> There is no "shift" variable. "reg" is a register offset, not an actual register
> value.

Sure

-- 
Best regards,
Marek Vasut
