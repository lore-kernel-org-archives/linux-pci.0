Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FACFC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 00:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663122085A
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 00:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVoP11ph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCRAW0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 20:22:26 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:39834 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCRAW0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 20:22:26 -0400
Received: by mail-pf1-f180.google.com with SMTP id i17so250744pfo.6;
        Sun, 17 Mar 2019 17:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XKqFGhKFg3haRgRxDPeNIiMi0Nfn/XqAe870UIQSOB0=;
        b=SVoP11phJ85XwAi1nbcghaJ7diCjJGAAYuK7zbv8WO1fyQn+po/e5AGeqpuFEH/u0P
         2SLqffTqcK3TM9G7S0wMqHVdSZOP5qON+FZU6vRogPo0vAZKM+FGlwFwVb0xC5jHPqL0
         HYO6SJI2DZcqlccocfeni+Jd8ybwoOKb5Qq9ZdoPt8lVdJyPuqYJUKOCIWaKI5Vr3mq1
         gStI90CjrjvdLebyEuE2FlhQlB7amTvYasqRj4fYjeKrJajZUDDo/UL+W9hmA/H1IQ/3
         WgOUzqV+4ToISHKPivUOlM+RYTUg1Njt6giT7UaDGKS56FvrbNWEBEnaN2oF0Vv0HIoa
         1P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XKqFGhKFg3haRgRxDPeNIiMi0Nfn/XqAe870UIQSOB0=;
        b=bwvxgDI8l6dvi6fTpuGyFeLs5Yo5IhmF42o8k1g2AUzMOneowJtBahnOLBJ+VK7X2e
         hLNQpF3wNfW6FtaaGX/Qo/UzJUSiDiMmBUtiQe/Zrom0k0jrf7pJiq54OPNTnbjTnsa5
         nu2WEc5vKxoMVPOo7sRHLE1qeeS4nEitNnZERKRFtFAfN53h2/TZkeQjxA4FyrvWEFZM
         Ngi+US6KCMpQyOZwRiWUSEpYolahcidlAEnQWsnUzdE28nLB/ej8MHJbrNRmRI+u7ytZ
         XbuugdxWGfAEtbwJ1WX1KXw6HcbndsA602ddWZrmMHuevIcvwtkDG0HGuWxyrNNqDgfw
         lCkw==
X-Gm-Message-State: APjAAAUpHAZrKghsSwIYqfM3X5Rr9Z407d1zy/DKKEsd8NP/HvIB7e7D
        9P3Trqjjq2ouc4++hRuZpvA=
X-Google-Smtp-Source: APXvYqxrTo6b+P9YV6czB+Ci4Bb1AJQZP0nGr8c3bInD/aWQupncM5o4aGzEm3+a9YjBVGagIqtdDA==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr15015818pga.66.1552868545169;
        Sun, 17 Mar 2019 17:22:25 -0700 (PDT)
Received: from nukespec.gtech ([2607:fb90:5ee8:c4dc:5d46:b9e8:6d49:e64f])
        by smtp.gmail.com with ESMTPSA id j20sm383125pfi.27.2019.03.17.17.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 17:22:24 -0700 (PDT)
Subject: Re: [GIT PULL] PCI changes for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190308173154.GC214730@google.com>
 <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <b723cbf8-be2a-bbdb-8ad5-eac8eddf2bb3@gmail.com>
Date:   Sun, 17 Mar 2019 19:22:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/19 4:18 PM, Linus Torvalds wrote:
> On Fri, Mar 8, 2019 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>    - Report PCIe links that become degraded at run-time (Alexandru Gagniuc)
> 
> Gaah. Only now as I'm about to do the rc1 release am I looking at new
> runtime warnings, and noticing that this causes
> 
>    genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
>    pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
> 
> because you can't have a NULL handler for a level-triggered interrupt
> (you need something to shut the interrupt off so that it doesn't keep
> screaming!).

Thanks for the catch. I did not see the error on my test machines. I'll 
take a look tomorrow, and update through Bjorn. Seems like an easy fix.

Alex
