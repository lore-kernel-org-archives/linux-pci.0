Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37794 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdGPVRT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2017 17:17:19 -0400
Received: by mail-it0-f47.google.com with SMTP id m84so44284492ita.0
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2017 14:17:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170715214406.657273405@cogentembedded.com>
References: <20170715214406.657273405@cogentembedded.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 16 Jul 2017 23:17:17 +0200
Message-ID: <CACRpkdbwMm_YwDG=e1Dyi1B7yp-++2u5frQiL_cbw_eRTiGiiQ@mail.gmail.com>
Subject: Re: [PATCH] pci: ftpci100: fix of_irq_get() error check
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 15, 2017 at 11:43 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

> of_irq_get() may return a negative error number as well as 0 on failure,
> while the driver only checks for 0, blithely continuing with the call to
> irq_set_chained_handler_and_data() -- that function expects *unsigned int*
> so should probably do nothing when a large IRQ number resulting from a
> conversion of a negative error number is passed to it. The driver then
> probes successfully while being only partly functional...
>
> Check for 'irq <= 0' instead and propagate the negative error number to
> the probe method --  that will allow the deferred probing as well...
>
> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Looks correct!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> -               return -EINVAL;
> +               return irq ?: -EINVAL;

I thought I knew C but I learn something new all the time.
I had no clue one can use the ternary operator like this.

Linus Walleij
