Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35382 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdFZILM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2017 04:11:12 -0400
MIME-Version: 1.0
In-Reply-To: <99e5ddc3b23962b22740dc93113d178f6f98df2f.1498210098.git.arvind.yadav.cs@gmail.com>
References: <99e5ddc3b23962b22740dc93113d178f6f98df2f.1498210098.git.arvind.yadav.cs@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jun 2017 10:11:10 +0200
Message-ID: <CAMuHMdX2di4HBN0BzPQiaXJ6XVu8Poyxd3ULeKxfU3qbd_a92w@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen2: make of_device_ids const
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 23, 2017 at 11:29 AM, Arvind Yadav
<arvind.yadav.cs@gmail.com> wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
