Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B886FC10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865512087E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfCYI0q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:26:46 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46631 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfCYI0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:26:45 -0400
Received: by mail-vk1-f194.google.com with SMTP id x2so1743961vkx.13;
        Mon, 25 Mar 2019 01:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CF52NXG1CmchWvZhtvZcWfYgwWDdC9bm2MOfHmM3XTI=;
        b=UsEFOgfMqw8YYDE2a5xRIZL37UDZZbpXFLQG4dlwNe9BaXWgWgEVVT2AbKFZ+kmpuM
         hAw2+uPPanD8zDGOGzNAbLSPWTph/vfoEJOwQ1GB2p3lTVJvXrWPkS5pQl/KsDbvomdc
         t+r1hIPrQGd8hhDqWiEub2XeGD7chZXteSj2eS9OqOuqd4O98Xj79AZfBqbp+r2dfeDi
         LMPnz/2RlSOpz4io+aOkK0lgBsVEDPv0JSn3dngn4BU4uj0tlFJAAod650PuWltJCFou
         F4jnwac2iDf26m/ihB0IqboNEkMZmDtu9j7LFszxXdqzQKGP2oHgglaM8iauu/dHOm1y
         9oIQ==
X-Gm-Message-State: APjAAAWX+VAJKJkp38eh1mjlj8eIUE6R9Imtf6tPjyDPO4xW7LewP/FR
        uQ9MrXrIv3w3DxZSkpWfYZrmwFRddJGJ9JJFhxs=
X-Google-Smtp-Source: APXvYqyVhftD2WIclxPvZsnWyhBMGDHnom2eoaNlMrpvpLwbi+6CcI1D8alw9eNbNQkIJzBwEUpPlP0DQz10bQn3s4k=
X-Received: by 2002:a1f:95d0:: with SMTP id x199mr341311vkd.83.1553502404558;
 Mon, 25 Mar 2019 01:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015359.7231-1-marek.vasut@gmail.com> <20190323015359.7231-4-marek.vasut@gmail.com>
In-Reply-To: <20190323015359.7231-4-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 09:26:32 +0100
Message-ID: <CAMuHMdUCWHR9zLz0Ru41860UhpUdjRvDBxDFoA5CdaAFrONJmQ@mail.gmail.com>
Subject: Re: [PATCH V3 4/6] PCI: rcar: Replace (8 * n) with (n << 3)
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

Hi Marek,

On Sat, Mar 23, 2019 at 2:54 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace (8 * n) with (n << 3) to make bit shift operations consistent.
> No functional change.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

Where is the inconsistency? The driver consistently uses
  1. multiplications for bit offset calculations,
  2. shifts for bit field extraction or insertion.

While technically equivalent, I think your change makes the code harder
to read: the values are multiplied by eight to convert from number of
bytes to number of bits, so IMHO "BITS_PER_BYTE * n" would be more
readable.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
