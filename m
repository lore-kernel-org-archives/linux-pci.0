Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF21AC10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8AA20850
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfCYLqF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:46:05 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33417 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730559AbfCYLqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:46:04 -0400
Received: by mail-vk1-f195.google.com with SMTP id r189so1873308vkb.0;
        Mon, 25 Mar 2019 04:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sg9wb6at8RK3llFcehPcR8VorcjQ81v8o6bfHmHtJY=;
        b=C7uXo2/CymC73ULBFfJ5GsBxngIsL2pl6M1Vx38LBEAXR5TkYN68v7PAcuYA0UAHbQ
         T5KhtcS2ycm99oLvxlcGiw78EQlR/oUCXY6RKqJ/yT01StDpLBI7PSSBB/Y9nFcIsWxv
         TSX9CnFHsqxijR0+hu3HlqEFJaRKFLycRL6ljlF6/qB8U3l2/Akb8cyfiC+yPhJDq45v
         ueWudeqmwW3YNA+ydKpgOhF7w9KF3JGAMBOEAUnNt6SyL+/Joydx8pLe6UFfshqI1bKJ
         3SqxwvMeSr4pLsEyUFw9dsVDXDaXq13au96Gt2AnqvJ5UoUWqginm5Ai9xy/HZiB3lRK
         ZnkA==
X-Gm-Message-State: APjAAAXnLE6/bwi1FsbFLMfZSpSjZonhyvx62baasui0WKdCKqdjYL72
        1qbL33wmw9Vwg898Q44XXo3IlsYqvXPoQPBYwyA=
X-Google-Smtp-Source: APXvYqzzGAPGOJVYCHQPkcBW91fsvUIZt4irrcD+lrT6QmcQaViKi0iyWeVaz6NoEn9WKLrsFeY6whGU1uTZ15RSP3Y=
X-Received: by 2002:a1f:711:: with SMTP id 17mr14679864vkh.65.1553514363682;
 Mon, 25 Mar 2019 04:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190325114101.10198-1-marek.vasut@gmail.com> <20190325114101.10198-4-marek.vasut@gmail.com>
In-Reply-To: <20190325114101.10198-4-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 12:45:51 +0100
Message-ID: <CAMuHMdUUGniZCPb+Wn+wNDGUfiEUUQXwU3ie3S=wnye7JThPOw@mail.gmail.com>
Subject: Re: [PATCH V4 4/6] PCI: rcar: Replace (8 * n) with (BITS_PER_BYTE * n)
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 12:41 PM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace (8 * n) with (BITS_PER_BYTE * n) to make bit shift operations
> consistent. No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
