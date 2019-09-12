Return-Path: <SRS0=JEK6=XH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7466FC49ED9
	for <linux-pci@archiver.kernel.org>; Thu, 12 Sep 2019 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACB920CC7
	for <linux-pci@archiver.kernel.org>; Thu, 12 Sep 2019 08:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfILIio (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:38:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42794 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIio (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 04:38:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id c10so25283937otd.9;
        Thu, 12 Sep 2019 01:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqmT1HvR4vLWNY+7igxafksaREtgXv4jug7zkytal8c=;
        b=NoPBKDuwX1z6ZR0qxn1tk1MTl0pgUw4I4HY3fozT92g7iB1f3/YoqrrfaINobd8zMl
         q5pZWiqbd4iBf+iaCNyh5r3iA6JUGGxgc6fJdZWAtN5r3erI3YerB2T/eqxqDoAN5MJl
         CDX6172gehtTD+pTUltm/h+GtgBpHhf6fkojB142JLLtr2VimNuZWqx7uVuQvizyrmj7
         DZiJ0qQ0EdMiuDXi3qnew9O5wSeusYEsLhm/9YtuEWtunW+kq/xxWeDU8XEWW7Jb1Y/j
         fNJROjTff9nK0OVpIc3F4JGxtCR0fppx5jMeE/bgyFMyo1XzdQhb/Y5vrIRoiMtyeaqP
         /YMg==
X-Gm-Message-State: APjAAAVwQp1EsIaAtBs8FexYEcVxk1OMKMs6Inq/PErkv98G8hYhtTZz
        740tENQoABUsfciS7TQfgVQERn/PuYGjD6XgKB8=
X-Google-Smtp-Source: APXvYqwmS/S8Pnl/jmGvW+6EP/j1YUSGZj/y2Dwhu2U29EPvQVhQDHGwxx1c1A+4Xwy3yWzEGu1X0jowl6fn/p52JIs=
X-Received: by 2002:a9d:12ca:: with SMTP id g68mr615887otg.145.1568277523827;
 Thu, 12 Sep 2019 01:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190905150528.20417-1-andrew.murray@arm.com>
In-Reply-To: <20190905150528.20417-1-andrew.murray@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Sep 2019 10:38:32 +0200
Message-ID: <CAMuHMdVHO3CHiNTheFvWKJ79p+3YYL6+i4nB9-nymBCorBYCUA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Remove unnecessary header include (../pci.h)
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 5, 2019 at 8:33 PM Andrew Murray <andrew.murray@arm.com> wrote:
> Remove unnecessary header include (../pci.h) since it doesn't
> provide any needed symbols.
>
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
