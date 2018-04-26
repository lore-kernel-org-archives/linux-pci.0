Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:40593 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbeDZIHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 04:07:30 -0400
MIME-Version: 1.0
In-Reply-To: <1524669685-8265-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1524669685-8265-1-git-send-email-vladimir_zapolskiy@mentor.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Apr 2018 10:07:29 +0200
Message-ID: <CAMuHMdWzq-iMtXfSBwCDcnuBomjHutjzm5YAFXCOXL2aV9RVEg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Reuse generic pci_parse_request_of_pci_ranges()
 function
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2018 at 5:21 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> The non-functional change removes a custom function to parse and
> allocate PCI resources in favour of pci_parse_request_of_pci_ranges().
>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
