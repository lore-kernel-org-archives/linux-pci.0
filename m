Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50983 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab2HNFHA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 01:07:00 -0400
Received: by obbuo13 with SMTP id uo13so7977300obb.19
        for <linux-pci@vger.kernel.org>; Mon, 13 Aug 2012 22:06:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-2-git-send-email-thierry.reding@avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 13 Aug 2012 22:06:38 -0700
Message-ID: <CAErSpo5YDwstHv7B7LEbDQmnHnuVsMA2ibTFNLkiCKmkkeE4Zw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] PCI: Keep pci_fixup_irqs() around after init
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2012 at 12:55 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> When using deferred driver probing, PCI host controller drivers may
> actually require this function after the init stage.

Yes, this is a bug.  Actually, there's still another bug here: if we
hot-add a device, we won't do pdev_fixup_irq() for it.  But your
change is worthwhile even without fixing that other bug.

Normally I would include this in my PCI tree since it's under
drivers/pci.  That would make it easier for somebody to fix the
hotplug problem in this cycle.  Would having it in my PCI tree make
things harder for you?

> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Changes in v3:
> - none
>
> Changes in v2:
> - use __devinit annotations
>
>  drivers/pci/setup-irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> index eb219a1..f0bcd56 100644
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -18,7 +18,7 @@
>  #include <linux/cache.h>
>
>
> -static void __init
> +static void __devinit
>  pdev_fixup_irq(struct pci_dev *dev,
>                u8 (*swizzle)(struct pci_dev *, u8 *),
>                int (*map_irq)(const struct pci_dev *, u8, u8))
> @@ -54,7 +54,7 @@ pdev_fixup_irq(struct pci_dev *dev,
>         pcibios_update_irq(dev, irq);
>  }
>
> -void __init
> +void __devinit
>  pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
>                int (*map_irq)(const struct pci_dev *, u8, u8))
>  {
> --
> 1.7.11.2
>
