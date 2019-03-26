Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E9C10F05
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 07:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C350420879
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 07:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbfCZH5R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:57:17 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37114 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbfCZH5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 03:57:17 -0400
Received: by mail-ua1-f68.google.com with SMTP id x1so3972223uaj.4;
        Tue, 26 Mar 2019 00:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPRH9eDWNbvi0uKMMUGGF77TbpzvUgjjZNft9wRxCXk=;
        b=IP71/0bM3SEuqcYcGntNLAyNC9/l2LvfCMxfLrdE1CzFENTtpFhhCiSJaitzqqXnXK
         +6gGOKDRIX7QzdELPOJDL1UYSJX6ylSv157kLDzWtpZ9qo6k/13KthUVPrLY65Yeb9PU
         H/13Zajxe5yGmpHFiKSyiNILZuwUfHBF17qITUkF3dcvfYiYJUDRcDSAmfi/FFooJ/JA
         /jOdpWEcgnn3y0GJrR0b82lPZbu/+ymXrmzcw88lNsh3TT4TEGF86co+pLdd5010B/f0
         vN19U/7gd2bBx6RG3xOPnU7EqBkX82m75as06ld9RZqkLDZdcPivpU59dAbhYag8OAnr
         XLQg==
X-Gm-Message-State: APjAAAX1il7UUlQ37MEdJbebaMYwSRmNjprrVtW2DGUE8xTltwj9rO/u
        e5gCFQ3MvDZRmPy4bOzDvqiXBX6zsM4GJcKUkH0=
X-Google-Smtp-Source: APXvYqwweeNSasS0o6gp8vd9G/wC1k9f8+TiBpQkU5Wf0UPgUmJPN5Qng3BHgyIR0H+PUGksJkp9jjN2X6CyPIP8NVE=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr12261359uao.86.1553587036431;
 Tue, 26 Mar 2019 00:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190325194319.12850-1-marek.vasut@gmail.com>
In-Reply-To: <20190325194319.12850-1-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Mar 2019 08:57:04 +0100
Message-ID: <CAMuHMdW3tQHUXuXGQT5xf-Cpbsqwiz0bo=sy4ZK-6O2uMHg7AQ@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the initialization of PCIe link in resume_noirq()
To:     Marek Vasut <marek.vasut@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 8:43 PM <marek.vasut@gmail.com> wrote:
> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
>
> Reestablish the PCIe link very early in the resume process in case it
> went down to prevent PCI accesses from hanging the bus. Such accesses
> can happen early in the PCI resume process, as early as the
> SUSPEND_RESUME_NOIRQ step, thus the link must be reestablished in the
> driver resume_noirq() callback.
>
> Fixes: e015f88c368d ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> [lorenzo.pieralisi@arm.com: reformatted commit log]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
