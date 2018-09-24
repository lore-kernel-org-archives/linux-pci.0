Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531E2C433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BEC214C1
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 09:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BEC214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeIXPaN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:30:13 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36231 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXPaN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 11:30:13 -0400
Received: by mail-vs1-f67.google.com with SMTP id z19-v6so7869977vso.3;
        Mon, 24 Sep 2018 02:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+keIwW+F2c7Zlkf53jrhD7lWn/p6BS87mDZRmxnCs8=;
        b=Ml4OkSv0nHH0e9kstm7Up8avWodUYoypPDBc7jSD4BSxo6+BnhUWbTatYy1wZtj+JH
         QnSJgUp2tq2ujYG+l5vazd/t3QZc02NTqrg/s50Wj9v0CQ9FBVuRhHEg+imjU1X4jUES
         sWhZtE0SxIIjs9yT+8kyIAQq5lfLtO4aTT6+4S3g+95q23uC/XPE68dmR6sW+1s/CEoP
         rCGO+rL/UYpwzL2d6y5Cpt55J7k+FwOeeBLS9tshT7gTGDOdAzCNTzn2MURa8IAfsVBi
         FGrkTN2/vuLL+uZfzVxX1BGFZW0XqCkt4Xpmg2royQYxUuX0gX8eyxr0C9Z5jcEge95h
         depg==
X-Gm-Message-State: APzg51CX5EOSlya7oS9oVxarasnSP9cXcHtyn9G9CJ3s1kG5ggkyIbXE
        NailgjGf4nDcY2WvQWULCMUmPK39vpAWmi8v5EU=
X-Google-Smtp-Source: ANB0VdaBoL6MREUaY/PZ53xNe0+gx1wyYFv/PvLhT6Fh8HPn7RgsjYQMNrDStynczGZH9E7KkVcMNq5sM1TJgHHWhJc=
X-Received: by 2002:a67:3a51:: with SMTP id h78-v6mr1975618vsa.63.1537781343936;
 Mon, 24 Sep 2018 02:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
In-Reply-To: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 11:28:51 +0200
Message-ID: <CAMuHMdVpQobZWGdJ5aBfhNfvspsWVxtH_dgoqW-0b_wFvi6XYw@mail.gmail.com>
Subject: Re: [PATCH] DT: pci: rcar-pci: document R8A77990 bindings
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, tho.vu.wh@rvc.renesas.com,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 22, 2018 at 5:02 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> From: Tho Vu <tho.vu.wh@rvc.renesas.com>
>
> Document the R-Car E3 (R8A77990) SoC in the R-Car PCIe bindings.
>
> Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
