Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbcKISFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 13:05:47 -0500
MIME-Version: 1.0
In-Reply-To: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1478700308-25481-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 9 Nov 2016 12:05:23 -0600
Message-ID: <CAL_JsqL13-e5RGfafsLfP7EoJWTkAsuRG4mAF-t52GoDXeQS-Q@mail.gmail.com>
Subject: Re: [PATCH] of/irq: improve error message on irq discovery process failure
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 9, 2016 at 8:05 AM, Guilherme G. Piccoli
<gpiccoli@linux.vnet.ibm.com> wrote:
> On PowerPC machines some PCI slots might not have Level-triggered
> interrupts capability (also know as Level Signaled Interrupts - LSI),
> leading of_irq_parse_pci() to complain by presenting error messages
> on the kernel log - in this case, the properties "interrupt-map" and
> "interrupt-map-mask" are not present on the device's node on device
> tree.
>
> This patch introduces a different message for this specific case,
> and it also reduces the level of the message from error to warning.
> Before this patch, when an adapter was plugged in a slot without Level
> interrupts capabilities, we saw generic error messages like this:
>
>     [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-22
>
> Now, with this applied, we see the following specific message:
>
>     [19.947] pci 0014:60:00.0: of_irq_parse_pci() gave up. The slot of this
>     device has no Level-triggered Interrupts capability.
>
> No functional changes were introduced.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  drivers/of/irq.c        | 5 ++++-
>  drivers/of/of_pci_irq.c | 8 +++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 393fea8..1ad6882 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -275,7 +275,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>         of_node_put(ipar);
>         of_node_put(newpar);
>
> -       return -EINVAL;
> +       /* Positive non-zero return means no Level-triggered Interrupts
> +        * capability was found.
> +        */
> +       return ENOENT;

It's not really a normal pattern to return positive errno values. You
should return a negative value and check for that specific error value
or perhaps move the print statement into this function.

Rob
