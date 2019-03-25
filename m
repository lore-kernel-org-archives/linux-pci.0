Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021F8C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C386520830
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfCYIDx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:03:53 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45636 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbfCYIDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:03:52 -0400
Received: by mail-ua1-f68.google.com with SMTP id c13so1269341uao.12;
        Mon, 25 Mar 2019 01:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNMSj/koiI0zBVOfomOQNutrO4hz21ndSV+8YNokP6o=;
        b=Hnjld6MPPQ+3GdwqO6+0gmoNXcJ/Y6batLRZveC1Y8Iw+AHYkeVaAkNNJ1lH/mMDL6
         qLagdidy9sxuEc5XwKy22Y4yMjoQoCATCMhIgqYLytOHUAOfs+Kdm8c39Ku99Q+MFm2P
         k5L0TSDx9sxEhatNEJOpqB4sqtmrdTy6BXqy2u7YwBw6JGlXtF/U7m6cgCfO5og4I+bB
         vPNOUcLr3HyyNC4RMAz5vidCxE2TuAGTnqiAXrMbPUGwpVGt4bp059mEAlIoPrAJwXbs
         H/CsYvWjetYsPCwe9EQAfv3Zxg/iawbqyZVXB1kcFgF6TQe8499IJOxDfJFWeVtEROqA
         AztA==
X-Gm-Message-State: APjAAAXSmCvrEH4Ugrbym+pVHkeb9U3pZa8IqAmlR3RYvKXY4tpwYheE
        jtXy1jmtY4/gzqp2aLtpEE7Wv3JrWE7JFsfUFbY=
X-Google-Smtp-Source: APXvYqy7vUQaW9Zwp68wrZPT06Olqc/gbcR76JT4re7uK5Ru+ryYKDlyRT8wjkVgjFClZ7RqUecEuzkFqZPJXPPR08c=
X-Received: by 2002:ab0:28d6:: with SMTP id g22mr13007997uaq.75.1553501031105;
 Mon, 25 Mar 2019 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015359.7231-1-marek.vasut@gmail.com>
In-Reply-To: <20190323015359.7231-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 09:03:39 +0100
Message-ID: <CAMuHMdU2gtR5VsZ_pd2rd8zC0a8bZNxG3jj1n6YWbDuEk69Ysw@mail.gmail.com>
Subject: Re: [PATCH V3 1/6] PCI: rcar: Clean up remaining macros defining bits
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
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

On Sat, Mar 23, 2019 at 2:54 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace macros using constants with BIT()s instead, no functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> V2: Bundle this patch with other cleanups before resending
> V3: Add Wolfram's R-B

Seems you forgot to add mine?
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
