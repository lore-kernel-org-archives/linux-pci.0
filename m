Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EBC10F03
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA662175B
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 19:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfCVTOd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:14:33 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44645 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfCVTOd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 15:14:33 -0400
Received: by mail-ua1-f68.google.com with SMTP id r21so1093378uan.11;
        Fri, 22 Mar 2019 12:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hlNmTqE/DDz2Igp//Zff4mtIGRB67dc75NmSK2tdWkU=;
        b=oR5ka3qgJwjLjRmcMcCzKcuuAj2BbzpX+dHPqWMZHEWgwwX4IUDQNveDuSWRfLXegR
         fBIaZbIRpYNWReMqCjk+GzsbFvHGzX3MQUuzEuwZn5erJKZSy2RXvQu926/V+0zO2E02
         ouNgCUY8iO4E92WBAWBRq7eJJ4cNSQHYXfck11PZU5GN9XMyqyELGyBBnc7DmqWINXNU
         VQM9g7dZnJs8ihSu7zEuFxDNeMiqpSm5Tbea/srDH5krOwS4aMltrra3qMH5q+dbv/sX
         q8RdwYoUQdVvVkYEw8JwGo9I5ZLYaVBp3yyjwgdOwdazOrmbBY+nr0Et9Rll9gIZBxc9
         5qAA==
X-Gm-Message-State: APjAAAUf5g7n/3URrKIOnuYxEaxqJiM2pjR07mAjJIufzn8DIVU1I4fC
        FcnEPbVf0vgIqI4qmqWE61xCmKsR3/T9cB31mGE=
X-Google-Smtp-Source: APXvYqwESRhPrReaJ+09dUA2ouFkEjYPCUkd7jz+WI80HA4oH0Km0a3pEhKvVHWLODrhL9qwx/jFzS99Chak0aQhiLA=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr2073034uao.86.1553282071917;
 Fri, 22 Mar 2019 12:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <1553271070-7509-1-git-send-email-gareth.williams.jx@renesas.com>
In-Reply-To: <1553271070-7509-1-git-send-email-gareth.williams.jx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Mar 2019 20:14:20 +0100
Message-ID: <CAMuHMdWoCdYYwVu6UsUxE2KNK3Qr52d7=0BemdOCvRNDy41FnA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen2: Ensure the mandatory clock is enabled
To:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gareth, Phil,

Thanks for your patch!

On Fri, Mar 22, 2019 at 5:11 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> All SoC devices that use this driver have a module stop clock associated
> with it that we must ensure is enabled. All SoCs enabled this clock
> by default, so I guess no one noticed that the driver didn't enable it.

This is not really correct: the module clock has always been controlled
through the clock domain the device is part of, either through the
"power-domains" property in DT, or through the legacy clock domain
before that, combined with Runtime PM (see also commit fb178d8b2fab3f2a
("PCI: rcar: Add runtime PM support")).

Furthermore adding explicit clock management (with a mandatory clock)
makes it harder to use the device with virtualization and VFIO, and to
reuse the driver on other SoCs where no module clock may be present.
Using Runtime PM allows to abstract the presence of the module clock,
or whatever power saving feature that may be present (e.g. a power area),
which is an integration feature, and not a feature of the actual device.

So I don't think this change is needed or wanted.

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Note: This change was tested on RZN1 and R-Car M2 hardware. NULL is
> passed to devm_clk_get for backwards compatibility reasons with R-Car gen2
> devices which do not name the clock.
>
> DTS files for Renesas devices that use this driver have been checked to
> ensure they specify a clock and do not name that clock.

I understand RZ/N1 has the same PCI controller, and you're trying to add
support for it?  I think the solution there is to add clock domain support to
drivers/clk/renesas/r9a06g032-clocks.c.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
