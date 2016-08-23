Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160822192728.5055.58901.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160822192728.5055.58901.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Aug 2016 08:49:21 +0200
Message-ID: <CAMuHMdXxynFuw6UQTpGsyy7RHVuo+xZL_eYvsLdxh2My9dmejQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Consolidate register space lookup and ioremap
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 22, 2016 at 9:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Move the devm_ioremap_resource() of R-Car register space next to the
> of_address_to_resource() that extracts the resource.  No functional change
> intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
