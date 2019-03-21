Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42511C10F00
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 03:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC07218A2
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 03:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thkaujc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCUDUZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:20:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52097 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfCUDUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 23:20:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so726071wmf.1;
        Wed, 20 Mar 2019 20:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ABXG8X1yIYK/IDQ8DP4zf1ZnwVTyt3eLfmLYzpB8eG0=;
        b=Thkaujc4SARa2wMgWsKrnkP14dwSqmqFf4p5vbD8ESvRfKGgtvyawjoLjJaUz31JQS
         9/L6CIzfXblsaKVLUBkQgddTb1U1my1ywyrg6QaJtKypQqgXeCLEgXlwX2ijm3AbZnXq
         IwoKzEw/ivvqxVIQ+0WY7jELmq4JKPJDkouNg2E9HinnCYAAkq6xKdoz82R5JQlsejYm
         q066lWT18EZv++uN3Bnibz1B+fuHVCJ6y7Vp3T7MtRVh/mJXHp0eqv2vl8cF0TlszMF2
         SPO5DHXliAHEE8y4FTnltydp3ZtG3l7jyeN7qfTZgNAXR2RwCkPOXTelNmCA9sI/tHQU
         GJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ABXG8X1yIYK/IDQ8DP4zf1ZnwVTyt3eLfmLYzpB8eG0=;
        b=niyBf5xLdejlqxcyS7aAHS3RmHT2FS7wydKmasLIQk6LSPsNtbbD0/WqueEoy6CvsO
         RLGIUl5akUV6c/7T0HvURSRzvbvHV4PQhhW06KRrcSV/3XdlHHZrCQFZYo661a1oVFX2
         O+96hMnuxLYIQ1dV1aP9cIohfWKErh4j0iyxWi1gaUmhfufv4uyMYFyET/IhtzlhmYHp
         FqcyIXb83NOZzPpkSWmApJG/bs4GpKojBYsrGynnnsnGILL+jocLN6D4kthpeIa/Mnsv
         gWqoZCEYnN/Qu9YHb81O8g9aec/o2bVk64IraGer3QiLPcy8uxsR1y1sa0r3H0srWeWD
         5hpg==
X-Gm-Message-State: APjAAAWnBFqVwVKL1Ob32aULbGJ8UpdrDzYp4PWz92+bX4qZTIIr32M9
        LJjG/vJd0H3YzG1sCZdrR0ZoF13v
X-Google-Smtp-Source: APXvYqx9gkR1EL8TmT6n5RwX6yTozD5AuveIlyjUMMvq+iOFQHQQmKg4IG9gkg2BL4Ug1Zlv6CYrjA==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr920504wme.26.1553138423184;
        Wed, 20 Mar 2019 20:20:23 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id c126sm3765908wma.0.2019.03.20.20.20.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 20:20:22 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
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
Openpgp: preference=signencrypt
Message-ID: <c715f6e2-e7bb-791b-4c85-e09cf1b7758c@gmail.com>
Date:   Thu, 21 Mar 2019 04:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWCY-QjnrG83MezY0Qq=h1nMqayYKantssSBxJrHJrAaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/19 9:19 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Mon, Mar 18, 2019 at 12:39 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 3/17/19 11:22 AM, Geert Uytterhoeven wrote:
>>> On Sun, Mar 17, 2019 at 1:06 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 3/11/19 10:41 AM, Geert Uytterhoeven wrote:
>>>>> On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
>>>>>> --- a/drivers/pci/controller/pcie-rcar.c
>>>>>> +++ b/drivers/pci/controller/pcie-rcar.c
>>>>>> @@ -152,14 +152,12 @@ struct rcar_pcie {
>>>>>>         struct                  rcar_msi msi;
>>>>>>  };
>>>>>>
>>>>>> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
>>>>>> -                              unsigned long reg)
>>>>>> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
>>>>>
>>>>> Doesn't unsigned int make more sense for reg?
>>>>
>>>> Isn't u32 more explicit ?
>>>
>>> It's just an offset in the register block, with a range much smaller than u32.
>>
>> We could use u16 ?
> 
> u16 may be more expensive on some processor architectures
> (MIPS comes too mind, don't know about ARM).

On armv8a, none.

>> However, Bjorn's concern was that using unsigned long
>> for registers was not recommended ;
> 
> Wasn't that comment meant for the size of the register values?
> 
>> how's unsigned int better ?
> 
> Basic rule "If you don't care about the size, use (unsigned) int"?

This only applies to the $shift variable, yes ? The rest are u32 since
those contain actual values read/written into the registers.

-- 
Best regards,
Marek Vasut
