Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37252 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBWMfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Feb 2018 07:35:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180223122949.24291-1-colin.king@canonical.com>
References: <20180223122949.24291-1-colin.king@canonical.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2018 13:35:31 +0100
Message-ID: <CAMuHMdWqe4BV+O5TebVHPkCY+zH+WS7tC8COsSmzRJr_7qzsew@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen2: remove duplicated bit-wise or of RCAR_PCI_INT_SIGRETABORT
To: Colin King <colin.king@canonical.com>
Cc: Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 23, 2018 at 1:29 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Bit pattern RCAR_PCI_INT_SIGRETABORT is being bit-wise or'd twice;
> remove the redundant 2nd RCAR_PCI_INT_SIGRETABORT.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
