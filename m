Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446CBC43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 09:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E43A223C8
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 09:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E43A223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeKPTVi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:21:38 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44727 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPTVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 14:21:38 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so13328296vsd.11;
        Fri, 16 Nov 2018 01:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qIfpn7h25apnxv19ipNRo2saSk++fXxcgVKZddxbd8=;
        b=EE9VFIdEUGl6BOttRQ5VEbMkIQLdwLTx8OW6FKfUtKdAC55fPQAtJbRBHTRxyQo/rs
         0Twmyn94E+n9YQUKPjsJV4b7tL/ErX1s9opGUwWU92D5L2oA9yK9B6fWHttIcRaKld1+
         ILcOQic4mgFtparzRWVtiRPymOMZgDmsaQKUtiB3YWN8bhLwXJpJ4r0S9zY1UY35xYHh
         f1ye/rO6r9i0oX1F2CltVgqCVBUS1/GRn8yUYaOlwdwYbTNepxdda3/tJAGyZkbBwnN9
         20Ze3Is5C0fwG6c3VypD+2myY17muvjotVUYV9sXYLYMhDqvG7ws24zyXuvxmtiRzOrP
         Tp0A==
X-Gm-Message-State: AGRZ1gIbrcbOTvc3TRSyXw3h0PlaQa3icfQBQ7BJxlU0LMXONOo1CyRp
        Ilh1WnPex8z7sDGBIxUYKeiqE0pCCsDhHwFcpX4=
X-Google-Smtp-Source: AJdET5dlfGYqms4VL8TAsTO4xbguV5f6uh/c85Xjvb5Y+HsSloqPxkMAmjYYAmv6yQBQjwLoHd4Z5CWuXeMdl6pHxzk=
X-Received: by 2002:a67:3885:: with SMTP id n5mr3694101vsi.96.1542359412431;
 Fri, 16 Nov 2018 01:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-5-hch@lst.de>
In-Reply-To: <20181115190538.17016-5-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Nov 2018 10:10:00 +0100
Message-ID: <CAMuHMdUSr6uxXUv8HtWZihFVj9zR8SJoFByLJ=J+_Lj-Mmgagg@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: consolidate PCI config entry in drivers/pci
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 8:06 PM Christoph Hellwig <hch@lst.de> wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support, and a FORCE_PCI symbol to for PCI on and the handle the
> rest in drivers/pci.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
