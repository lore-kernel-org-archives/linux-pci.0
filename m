Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D184C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5902190A
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b48IOyBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389282AbfCVMJR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53357 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388632AbfCVMJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 08:09:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so1917426wmj.3;
        Fri, 22 Mar 2019 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JEFVBAYQJChY++e3KQIQ6mpcV19ILydeGMIRKzSka80=;
        b=b48IOyBwvncxttPB4s7PVkcZMRnvirzuruUGEDksjsNHM3QW1Nu2AhDh78FAiQFqkt
         ud7I6S1YoTAg5z1y2p129y/t4c2GGHs+Q+GUwxHoTfx1MKGn2/Gk2Sai+TXZJrLSEMdX
         jiBweHZjPLqK8ew0QaMq629RYVJXvhBqmX+ynw2ZmBYl2hUvzyZERJFSmg8n/eY51Jla
         3/iY3G2UBarYJABlIVmauWgF+rSPGRh+CPEH3J8zWclTOe5OOYZerSPIptHob+onlzoW
         jRCI2Jbe3nGBBH3BeVHHliRqTsj0XW9TnBMr3iRfy9dOgK/a2tHEbCQYfl9YWstNG8oD
         1drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JEFVBAYQJChY++e3KQIQ6mpcV19ILydeGMIRKzSka80=;
        b=rEjjKqZs4yifWEsatIbxsCptZfN8uzKopo0e4tK5cvbPIz2//5iK0GICJqqEUhTcY1
         RCyanl6gAQcoMV5tQDrBE3yfSCsRfLTf5xr8iahQZyeX8y6shuu0lhbjJkLABpDufDZW
         axfBZMcP5xSLYCeIGUTYzkCC++a8KRP1Mpyj1/Zjs+jR5QdSxPsvc+AFCzlmBVzcLoHu
         whgDUzMOl3llm9D3a3uLDI8Wm8OAP4DcZdyCLBRxcUVU7LIc88EHTqEEay0V+Bzw6O0f
         WVi4j6q98Wq5nHYgYZuI+xLPYXe2ROK2gjbNkH9kP32+v96350uCmIUEvUXgsU6COwbS
         apxQ==
X-Gm-Message-State: APjAAAWCnvR9iyYCwBBKq9ZnAU3lSq8Cr7m3HET7cXiE0YLIOpN2Q/1Z
        gMMCswEoO3OnxY5XR+h7KEuIqltZ
X-Google-Smtp-Source: APXvYqyyvqclLhmsqBQLegr22cwU4vB8t814vM9swxhlwHuLq1pAVbt53yZjxyMLC7k15pY76+f3sw==
X-Received: by 2002:a7b:c044:: with SMTP id u4mr2995463wmc.88.1553256554775;
        Fri, 22 Mar 2019 05:09:14 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id e16sm18508235wrs.0.2019.03.22.05.09.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 05:09:14 -0700 (PDT)
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190322113133.GB24257@e107981-ln.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <95d1076c-5490-3803-f394-9a0928c2cccb@gmail.com>
Date:   Fri, 22 Mar 2019 13:09:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322113133.GB24257@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/22/19 12:31 PM, Lorenzo Pieralisi wrote:
> On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>
>> Reestablish the PCIe link very early in the resume process in case it
>> went down to prevent PCI accesses from hanging the bus. Such accesses
> 
> Hi Marek, Kazufumi,

Hi,

> Apologies for the delay.
> 
> Just as a clarification, when you state "in case it went down" isn't
> this supposed to happen for every suspend cycle ? Let me know and I
> will add a comment to the patch commit log.

It does happen on every suspend/resume cycle and if you manually put a
remote endpoint into non-L0 state.

>> can happen early in the PCI resume process, in the resume_noirq, thus
>> the link must be reestablished in the resume_noirq callback of the
>> driver.
>>
>> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
> 
> This looks like a fix (most likely fixing initial S2R support, please
> help me chase the commit ID), should we consider it for stable kernels ?
> 
> Without it I understand S2R is actually broken on platforms with this
> host bridge.
I don't think this ever worked, so it's hard to find a Fixes: commit for
this.

-- 
Best regards,
Marek Vasut
