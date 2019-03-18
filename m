Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E70C10F00
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A62083D
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCRKQ2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:16:28 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41041 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfCRKQ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 06:16:28 -0400
Received: by mail-vs1-f68.google.com with SMTP id z25so7780411vsk.8;
        Mon, 18 Mar 2019 03:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GPMeQ9UAfGF4IUSaZ55d3QSxRjOD1KKb+FTRyi+/Mc=;
        b=fSpGvw5xICHKqwY3p+gxYKGE170zSWNkl7/P7B9rXmNDfbfrFw+a+akW/2Bqr5PWGK
         NZyKF7rempQHEW6Q5Ri8vDwXYaPuL93QcRcs7fovgiXXoonUKkjQl/m1abzGH+zo4H8T
         diGXtcsruoIttTswDQkIIge1TD/FTJr+Gx9PpaA1q1xFZyttVi2hPP7DaPRfLucJFVmf
         iqX5mtDpGb35zG0aLG2yoBYmR6LiqDH3bN9PAngXJ5dFqNQwPNlvOtiMGYK0FfYTq+Xs
         D9240Ul9ofDCy0ksKV07huJ+nqNoBs6GWhCILBDSharnrby8RwGTAf3eev+Iel4Dv2nT
         cJEQ==
X-Gm-Message-State: APjAAAULDvi4/9hvTuLsNOyr4+eZSZibWEG4fxa0N7YJlg6V0mjVjPaK
        AU4Y93EfA6vfWtqjKVCSba8BUvU0v+FIzoqcljQ=
X-Google-Smtp-Source: APXvYqxIvDukWwM9nxnvly3WzBgl6iZ0o+tt0e1uRYRWmV0zN+ujcm5caSIRoENJxU50f3ZTyQZQkhpVnceoHo7lT5g=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr8756498vsp.166.1552904187890;
 Mon, 18 Mar 2019 03:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190317093445.7746-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190317093445.7746-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Mar 2019 11:16:16 +0100
Message-ID: <CAMuHMdUwH1kLr_n1fCDwAQdP+yBqH++LOasx6FxOr_Z+CDNfNg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: don't shadow the 'irq' variable
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 17, 2019 at 10:35 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> sparse rightfully says:
> drivers/pci/controller/pcie-rcar.c:741:30: warning: symbol 'irq' shadows an earlier one
>
> It doesn't affect the current code. But fix it now to avoid future
> surprises and for good coding style.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
