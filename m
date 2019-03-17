Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F70C4360F
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13AD20872
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgvUGmH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCQXjs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:39:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33085 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQXjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 19:39:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so934141wmi.0;
        Sun, 17 Mar 2019 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p9rqgpEXRqcaThH+Iu06pX1ydZZH6G1AsGRKpcQQGaU=;
        b=HgvUGmH6bsFv9jTz5mtFx29SrgjYrYrsBsrYpTaGE+Zzm5BhMfbyo7jE6rvirZwrYP
         5Qt9bdBRCRwBeR32hJOa7hTNwCXDXjM0RTqG8UrFJ+s5XcPpdQlymg5XAi2isgwzXioD
         4lnJFZHeIayJENouXtVr9siCDmVh3QjCEcEQFg3hxxpJuTmzBqBrqZ4J+BakQHwqnmWX
         vDQVz7bx1ubcTRJj0cbOgTv7/U0ADK7r76tXAP5oBRrDW6IL2CMWra2R/1YJI7fgKUYF
         kyyyXLMaI91J3+JiCibcWrECE4eZWFm/94J5/LHfxmQoRqmIqJfvBfugWl5o+jPUDO5O
         D4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p9rqgpEXRqcaThH+Iu06pX1ydZZH6G1AsGRKpcQQGaU=;
        b=tMixJEXKBoUrop6Yz4A763lxSHJalDtbElijAcYRWisHl4E2xWsCDs62oURRtIZQly
         j5ttO37EUFnPBw8erFfDm86xCG1B9ZioU1rIdvtaWzvvSQjLBCZkga0h/FNCC8TvsJC5
         V+JnAYD3S4n2Y0wRcxHHsh/OnGYtKVsoznKMmfn5SCW0bQIo+/MAg0gUkrOxwc2Vak7p
         JYi3tyM8kKXhdAazUj3gVXwlSB04J6yGLHuepzeEQcR9HGs0461DOntBmGCsPCIkCCGI
         vUaELPtjHj8PyN8Av+4Wb1H2YIZox5InG4ohJ8UeXtxXJMmi8PiNaeYNbfTJe+qidwcY
         /NKg==
X-Gm-Message-State: APjAAAXQXlfw6lDB9Qd9LExqJnUFzlln7NXIWQ+pGGrO6ni0Qhal+5nL
        84v9rQIZE0FrGVRUxj07nhhdMGeS
X-Google-Smtp-Source: APXvYqy0uIx3pOh+dbUSLFn+mzoZwlo/eE4wBncQ1jH5Du3JhgEwTFK8izKTefXLNhl8nEwAs3KvsA==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr9017359wml.33.1552865985499;
        Sun, 17 Mar 2019 16:39:45 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id x22sm8015729wmc.19.2019.03.17.16.39.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 16:39:44 -0700 (PDT)
Subject: Re: [PATCH 1/3] PCI: rcar: Replace unsigned long with u32 for
 register values
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-renesas-soc@vger.kernel.org
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317090901.GA2268@kunai>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <1e6b0726-e767-600c-7725-72db9312d105@gmail.com>
Date:   Sun, 17 Mar 2019 23:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190317090901.GA2268@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/19 10:09 AM, Wolfram Sang wrote:
> On Sun, Mar 17, 2019 at 01:06:06AM +0100, marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Replace unsigned long with u32 type for variables holding
> 
> s/unsigned long/various variable types/

Fixed

>> register values, since the registers are 32bit. Note that
>> rcar_pcie_msi_irq() still uses unsigned long because both
>> find_first_bit() and __fls() require unsigned long as an
>> argument.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> ...
> 
>> -	int shift = 8 * (where & 3);
>> +	u32 shift = 8 * (where & 3);
> 
> Minor nit: Since this is about shifting, maybe replace 8 with << 3 while
> we are here?
> 
> There is also a 'shift' var in rcar_pcie_write_conf(). I think we should
> convert this for consistency, too?

OK, I might as well collect this and the other cleanup series and repost
it together as a V2 to make it easier to pick.

-- 
Best regards,
Marek Vasut
