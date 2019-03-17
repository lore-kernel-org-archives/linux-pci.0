Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAE4C10F05
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAAF20872
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 23:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA3wZ2vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCQXju (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:39:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36553 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQXjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 19:39:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so10533122wrd.3;
        Sun, 17 Mar 2019 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxQPSlt631vzTDE/fOSdqsARHMBHGS5Tpyqc/5LJudQ=;
        b=GA3wZ2vh40DNQoVLa7zRx8gKtJKjU/SPp02nCWaxwUO8bPccQcR1SbNsDifrWPFBmT
         y0gojOKg5psM2J84vUwg956CN+tB1me6QzK0yalJWRpVjch4Jti7hAkduqlF8/FBtiIn
         kEDbmNzVKMbCc1/m81KCqkyXHoM5NiEfGFUeSZSRkuCqgfGi2gqskZAXQ0ryyRDpyOMn
         o8W/ROtErBglSbCsYuZFls6/b7gdcVALT4qfW9GZmQsuW+1xqI9+lY6d5XUcm11hB8f7
         ocVGUuarIqEslzBbBfR2vyVetZ0/zUA3psiTKoBdTEGQE8xBwNIpA0Xjf0EmDOjAbl/+
         94AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxQPSlt631vzTDE/fOSdqsARHMBHGS5Tpyqc/5LJudQ=;
        b=NmbUb5rOqT9qRz5a5va9IGQcbERUTKTFnkyBTiy4pX3F0zaqECacO9m9G9/fuKN74w
         JySEpEZMJf2k09KFJqovRJR1UHt6jGK/yes/64sSwV9Ad6L0aJhapQTdoEHadvjnpyO+
         2RObE5YUXFM69RH1WhJHvb1L4f6GdSkqnLgTDk4YzM/9pLGoMRt3Yv8u5j9PG6wdUTyp
         Mt2xU0ONQrcqRvDeFl84nJs2JTULCd8b1ipq8GHvS9u+TVi8A+HLD6lJCG4/On1D+/jv
         xBSdVl7lcznNI8jlc7SNXYetXgbXRFWtW84yZyPiodtyhOBuMox1Ie14FKR5BOV2+Arj
         ClbQ==
X-Gm-Message-State: APjAAAWZ9itkDv5BuNSFVa7EcdAMWDFOhmOv2pT09wYqx0vjz57yBrqk
        NnWgx4T0d3mnROzY/jSzH6YPZ982
X-Google-Smtp-Source: APXvYqwAz7QL9KI9pdiHPimnCaMPKyXXp68edigFeo0REF4i30QxGJneDlR9+B1YTlHYuzxLMllHiQ==
X-Received: by 2002:adf:e442:: with SMTP id t2mr9806063wrm.256.1552865987525;
        Sun, 17 Mar 2019 16:39:47 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id n4sm840489wrx.39.2019.03.17.16.39.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 16:39:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190317000608.24881-1-marek.vasut@gmail.com>
 <20190317000608.24881-2-marek.vasut@gmail.com>
 <8c60a8c1-76ba-02c5-5306-1122eca2bcbf@cogentembedded.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <1762c7cf-d6e1-fca8-edbe-7c002ab533a3@gmail.com>
Date:   Sun, 17 Mar 2019 23:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8c60a8c1-76ba-02c5-5306-1122eca2bcbf@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/19 9:03 AM, Sergei Shtylyov wrote:
> Hello!
> 
> On 17.03.2019 3:06, marek.vasut@gmail.com wrote:
> 
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> The MSI address can be 64bit. Switch the data type used to hold the
>> result of virt_to_phys() to phys_addr_t to reflect it's properties
> 
>    Its.

Fixed

>> correctly and program the top 32bits of PA into PCIEMSIAUR.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> To: linux-pci@vger.kernel.org
> [...]
> 
> MBR, Sergei


-- 
Best regards,
Marek Vasut
