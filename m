Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF240C10F00
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DC721900
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRITu0vM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfCVCbg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:31:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCVCbf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 22:31:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so651625wrx.9;
        Thu, 21 Mar 2019 19:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J3Fj+6NUMgIJaiwL4IgLV/04FbIGniueXIM7u0H/NNg=;
        b=oRITu0vMBjkPJihpwFmye2r7ki+hVVv29nW6dzDPYDVWBkZxWMMrENXcL5PXvpU9NS
         IPO/kGx6v0PLCf7hy8Hes2PgEWOXmn4VIAHoZcAYBv3z3HPThKIaU7z01+Fb6pOUl4UN
         MT4nqe6/DWmlcdjqzAomf32cU6x0KPC1UNE63gZfEy91+LMJGk/3iTd6sQkK9rmJMhtn
         loghEmQrzgBmKeEURxnpgV4luxaaDD8HcCaTC1RJ/fJkkqaCbVlJE+p+ytjPFzknDM53
         zzZFQ6uM8ZJ2qfaQqL/u+oOSMKhk5iHWcjdu+eo4K9N3BA2vH04AQ0ddXgrzOd3J05AM
         rEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J3Fj+6NUMgIJaiwL4IgLV/04FbIGniueXIM7u0H/NNg=;
        b=rFWi+yFZrrUP0WjyAp7xGmrBjmjndsApmZDWHQNHN4FTsusrosjjIt7Kc6TTWaJAwk
         k1wXJdTOsuY+hxgTbhReGt4Uu7cD1xjlKkxohpaqIz20nkhHfkayC8Jq/zCaySzSgD6N
         hHxQU2DxJeTan9A+IUVLjPtckz4H5kXEt4RQLDRG3p1QzqZFnJbMfSztznDQJvNB/CVK
         5H4IzzTKIkWbMjhrisNZm6wOTS3Chn/ZYOm8h1XAFpIiZ1akDd8jamFCIVvhJDE7SCFm
         RE6RktnqZhRr4AjNy5EUh+F50JEoscRryLFn59nr6sieyc/Z6yMlx3KdUqJWJ4fISqa3
         loug==
X-Gm-Message-State: APjAAAXIK+7zwfeWdfQXQQIPeI6RlDhq/oXqZs3KzLU2RD/xsrMS8Vmn
        pbxny27jZx0TdpRAbZDu8i/yj5mc
X-Google-Smtp-Source: APXvYqyA8yG9sRgJdMmF8zM3ZlJJxx27e4ODL3dhQABE7gfPxWlYdAplPL5lYPGhSerB/q5YV4BukA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr4395176wrx.80.1553221893476;
        Thu, 21 Mar 2019 19:31:33 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id z20sm7992763wma.48.2019.03.21.19.31.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:31:32 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317000608.24881-2-marek.vasut@gmail.com>
 <CAMuHMdV0fUV8De4QGq9Jjaepic06nVVby8p3W6DYr9X9MqM+Jw@mail.gmail.com>
Openpgp: preference=signencrypt
Message-ID: <0fdfb018-23d9-e557-d413-10d8d5d72663@gmail.com>
Date:   Fri, 22 Mar 2019 03:30:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV0fUV8De4QGq9Jjaepic06nVVby8p3W6DYr9X9MqM+Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/18/19 9:35 AM, Geert Uytterhoeven wrote:
> On Sun, Mar 17, 2019 at 1:06 AM <marek.vasut@gmail.com> wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> The MSI address can be 64bit. Switch the data type used to hold the
>> result of virt_to_phys() to phys_addr_t to reflect it's properties
> 
> Side note: probably this should use a proper DMA API instead of
> get_free_pages()/virt_to_phys().

In fact, I think it doesn't matter. The MSI message is never written
into this page as an actual memory write, it is interpreted by the
hardware as an interrupt when it arrives. So I believe this page is just
a safety net, which is never actually written.

>> correctly and program the top 32bits of PA into PCIEMSIAUR.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

[...]

-- 
Best regards,
Marek Vasut
