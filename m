Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A0C4360F
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 09:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02282184C
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 09:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghiXCBL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfC2JwL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:52:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43216 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfC2JwL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 05:52:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so959475pgu.10;
        Fri, 29 Mar 2019 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6rfQx6fc7H5V/jHPU82ei46X8QGQB9MSa5L0qpRdVLw=;
        b=ghiXCBL6ZH1pZTFbUTnjiA8+3+9hzAfEzbcKSq6JnRJ5QEIzsrCVbk4mPZJttHgPAz
         IZFWxOX9gZNwoHk4qxnS0neoR9Dj7qepW96U4ZsIuslxrek+FTydtj0L0QxsaJS6H/de
         Hh+fMd/wmzjJbi5Po9i1AkkCkd4ZiD99wAu6xuVeRx1MEUpr/qb0VA2RCV3c+aossJ29
         SxDQ5/avIIJ0xgAlTEjjpPT+e85a2xPzSG1ilNtbC6vmmEq+NoThWkjomZbZqgPD40m0
         ZzwfoE8Dn1+CNFOGI3Z3QVdsPWxg3ZjwEzbxeaVqfIJZh/+/lq5Gb730SvAGnjItSxcc
         kgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6rfQx6fc7H5V/jHPU82ei46X8QGQB9MSa5L0qpRdVLw=;
        b=E6AKkXjuxzn4QDBzYdZz1owDyJ6oAPtXZewOBQtaefQttOqZwB7uqifFLD7E62no56
         CU7abeHrAVOM9BjVbeA5iG+o+UNsSmxG47nW0U+unsb1sVISXf4Uk1TxT4tSugeiXjBx
         /NlKqwyYXUnVBmt4h6DELE0ScYGkWqvPyf3wRijIGkvwx64wjn++n9ZSKi+lfLq8NoG9
         38/s4y61WpMuTEA9yYzqAXEh5+63qBB8vAwJzGZXWQJxuroSkRc5M+iCi01ibtcCkKvo
         bEdRT1Arm+CU/RHrM6r21Bq0R+g+OHSDyK9tgirfGOtabgQfD1A57KBKcN4cENkS13BU
         htdA==
X-Gm-Message-State: APjAAAVWYCWCsY1sxEKHGgKNuJFvEYWjzyZzjSdX7ZzRtx2LWpwL3zNd
        bdW3MruYN4EW/vUQDkSKY5L2ioSv
X-Google-Smtp-Source: APXvYqzTKSD23nbQZYp1JkSNW768bKwgAODRyIroQJvvuPVLemnNmV2y2ESLqiRb3i7iXG7kFe3GuQ==
X-Received: by 2002:a63:df4d:: with SMTP id h13mr44259446pgj.220.1553853130440;
        Fri, 29 Mar 2019 02:52:10 -0700 (PDT)
Received: from [192.168.42.180] (219x120x4x122.ap219.ftth.ucom.ne.jp. [219.120.4.122])
        by smtp.gmail.com with ESMTPSA id k9sm2538897pfc.57.2019.03.29.02.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 02:52:09 -0700 (PDT)
Subject: Re: [PATCH V3] PCI: rcar: Add the initialization of PCIe link in
 resume_noirq()
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        stable <stable@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20190325194319.12850-1-marek.vasut@gmail.com>
 <20190328141822.GA156243@google.com>
 <CAMuHMdVsJ1MW40ABuieLq7F6=zG_btAHZUr82Z4_pPVem3h=jA@mail.gmail.com>
 <20190328185913.GC24180@google.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8cf5b9d4-37e1-7a8d-ed44-9b978430d5f6@gmail.com>
Date:   Fri, 29 Mar 2019 10:52:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328185913.GC24180@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/28/19 7:59 PM, Bjorn Helgaas wrote:
> On Thu, Mar 28, 2019 at 03:59:11PM +0100, Geert Uytterhoeven wrote:
>> On Thu, Mar 28, 2019 at 3:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Mon, Mar 25, 2019 at 08:43:19PM +0100, marek.vasut@gmail.com wrote:
>>>> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>>>>
>>>> Reestablish the PCIe link very early in the resume process in case it
>>>> went down to prevent PCI accesses from hanging the bus. Such accesses
>>>> can happen early in the PCI resume process, as early as the
>>>> SUSPEND_RESUME_NOIRQ step, thus the link must be reestablished in the
>>>> driver resume_noirq() callback.
>>>>
>>>> Fixes: e015f88c368d ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
>>>
>>> I'm fine with the fix itself, but since e015f88c368d appeared more
>>> than two years ago in v4.5, the justification for merging this after
>>> the merge window is a little weak.
>>
>> V1 of this fix was posted in November 2017, but IIRC, the series became
>> the target of some bike-shedding...
>>
>>> Is there a more recent change that exposed this problem?  The usual
>>> situation is that we merged something during the v5.1 merge window
>>> that caused a regression, and we're now fixing that before v5.1 final.
>>
>> There are several reasons most people couldn't even run suspend/resume
>> cycles on their systems:
>>   1. Early releases of the affected boards came with firmware revisions with
>>      non-functional PSCI system suspend,
>>   2. Preparing the PMIC for suspend required ugly assistance from i2cset
>>      in userspace, until the Linux driver learned to take care of that itself
>>      in v4.18/v4.19.
>>
>> I guess the fix can survive postponing to v5.2, though...
> 
> Ok, I'll merge it to -next for v5.2, thanks.

ACK.

-- 
Best regards,
Marek Vasut
