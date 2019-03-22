Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9ADC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7FB2183E
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 12:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLVhrpxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfCVMuD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:50:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50519 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387426AbfCVMuB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 08:50:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so2073877wmi.0;
        Fri, 22 Mar 2019 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=68RL712ll0+fURRKI/qkdALrin3TuAjab9Zvxjv238E=;
        b=RLVhrpxi728ZP6P+D3h9jClg42ZPgtzdS3f/Ep9iXVzEIH0Ipbk7L0FyS0C2YPqNMP
         BhuP9BGsjkpdUFaX6CiH3nRXU1xnzpcujV39zHKvy9lWFPP6NEJVnhEO1PohEas/ym2s
         pkKfzY/mD4QFZBIFV62/7ulDWzS9Vuk1wvNUERGWdIO87usAHGVsH4FjglrXDQHSD44n
         d7Zpqb+yvn1TQR6tPBf1UmG9ZM6GCyNGCWua4JECvuTSH+K5cSYRUzehbhRSjCHnXcfg
         YYFIT7aLfgrDWLdDi32fJMjAYb7CyCJZVKoOgmKuU/10+gzPizxuDfWorVKIsMHwOzP3
         gb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68RL712ll0+fURRKI/qkdALrin3TuAjab9Zvxjv238E=;
        b=jFqzeCzSbV0dvRCGI8GsXRH0ACIuEFqBHHDznjybwthU+GLsNI+eDBlDIlv+5S3PRU
         AGBMmVvu3EkJRtW+B2VktIRqwBWiBh1jfqJY8/DeY4QwH7z3xunL5yWFouZoQH5FBkyi
         OF2R9oWWFTDSy6stU1dBAngrVodQjEhzQxYbSEV6UBcBE8Sy9Q1XroR+bpyLcFpTpJGn
         8JpIb1FkgC4nrKtFRICOgrSCHXQ+e3SpkYzUJozJ0jYnMkHfeWizB8fjl7UB8afcAPW3
         m1sDZe8schvNUYHAlOOJDhyy2TrhBLTynmmhZAM0fkaAc0a9H3q7dpwsZAfmzvdCPrsj
         k/Xg==
X-Gm-Message-State: APjAAAWJIRJ0FYW5iK1WnTGZ2Ybe5mmGpNQ5vbgN1+r0ByKRFH/6FUZl
        Xz0gPiVkakZ+Pafjd/4SvCe/qed5
X-Google-Smtp-Source: APXvYqwQaJbyo4wD7zIxxcTaLclWY+vf8SNLguhaypMXST3tKVdxoa2PbtZ12EuCx4rlZ9o7MNCeJg==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr3198437wmh.74.1553258998823;
        Fri, 22 Mar 2019 05:49:58 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id e16sm18679590wrs.0.2019.03.22.05.49.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 05:49:58 -0700 (PDT)
Subject: Re: [PATCH V2] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190217132441.15139-1-marek.vasut@gmail.com>
 <20190322113133.GB24257@e107981-ln.cambridge.arm.com>
 <95d1076c-5490-3803-f394-9a0928c2cccb@gmail.com>
 <20190322121822.GA26257@e107981-ln.cambridge.arm.com>
 <CAMuHMdVt9S8ECq=FFHHLRDF4ozQc5E-kEHLZsCZaWTTi2TeC=g@mail.gmail.com>
 <9b432b16-35a1-c4ec-df97-8f6f854ab8b4@gmail.com>
 <CAMuHMdWPZdD3Kat_XJ33ubiiXr4CE_zP7crqrAcbzqOB58V-PQ@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <f491ae44-37dd-89fa-b4eb-c57715cfbe14@gmail.com>
Date:   Fri, 22 Mar 2019 13:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWPZdD3Kat_XJ33ubiiXr4CE_zP7crqrAcbzqOB58V-PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/22/19 1:42 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Fri, Mar 22, 2019 at 1:33 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 3/22/19 1:29 PM, Geert Uytterhoeven wrote:
>>> On Fri, Mar 22, 2019 at 1:18 PM Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>> On Fri, Mar 22, 2019 at 01:09:13PM +0100, Marek Vasut wrote:
>>>>> On 3/22/19 12:31 PM, Lorenzo Pieralisi wrote:
>>>>>> On Sun, Feb 17, 2019 at 02:24:41PM +0100, marek.vasut@gmail.com wrote:
>>>>>>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>>>>>>
>>>>>>> Reestablish the PCIe link very early in the resume process in case it
>>>>>>> went down to prevent PCI accesses from hanging the bus. Such accesses
>>>>>>> can happen early in the PCI resume process, in the resume_noirq, thus
>>>>>>> the link must be reestablished in the resume_noirq callback of the
>>>>>>> driver.
>>>>>>
>>>>>> This looks like a fix (most likely fixing initial S2R support, please
>>>>>> help me chase the commit ID), should we consider it for stable kernels ?
>>>>>>
>>>>>> Without it I understand S2R is actually broken on platforms with this
>>>>>> host bridge.
>>>>> I don't think this ever worked, so it's hard to find a Fixes: commit for
>>>>> this.
>>>>
>>>> If we want to send it to stable kernels we have to select which versions
>>>> we are covering. I think the only options for a Fixes: tag are either
>>>> the initial S2R support commit for the platforms this driver runs on
>>>> or the initial driver commit that harks back to v3.16 AFAICS.
>>>
>>> This only started to become an issue when support for arm64 platforms
>>> was added, where PSCI may power down the SoC, right?
>>
>> Wouldn't you also hit this on ARM32 LPAE ones ?
> 
> This is about the PCI link issue on system resume, right?

Forget what I said, yes, I mixed this with the MSI 64bit patch.

>>> Hence:
>>> Fixes: e015f88c368da1e6 ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
Best regards,
Marek Vasut
