Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40787 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab2CHR13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 12:27:29 -0500
Received: by lbbgm6 with SMTP id gm6so124650lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 08 Mar 2012 09:27:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1331218291-16119-7-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-7-git-send-email-thierry.reding@avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 8 Mar 2012 10:27:07 -0700
Message-ID: <CAErSpo6hbWjteESST1+O2WzbtmZq6hC-pnUB4o3MAXWG-EgU+g@mail.gmail.com>
Subject: Re: [PATCH 06/11] PCI: Keep pci_fixup_irqs() around after init
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 8, 2012 at 7:51 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  drivers/pci/setup-irq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> index eb219a1..270ae7b 100644
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -18,7 +18,7 @@
>  #include <linux/cache.h>
>
>
> -static void __init
> +static void
>  pdev_fixup_irq(struct pci_dev *dev,
>               u8 (*swizzle)(struct pci_dev *, u8 *),
>               int (*map_irq)(const struct pci_dev *, u8, u8))
> @@ -54,7 +54,7 @@ pdev_fixup_irq(struct pci_dev *dev,
>        pcibios_update_irq(dev, irq);
>  }
>
> -void __init
> +void
>  pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
>               int (*map_irq)(const struct pci_dev *, u8, u8))
>  {


        struct pci_dev *dev = NULL;
        for_each_pci_dev(dev)
                pdev_fixup_irq(dev, swizzle, map_irq);
}

Hmm, your patch looks OK as far as it goes, but the implementation of
pci_fixup_irqs() as a call-once-at-boot-time thing with a loop through
all the PCI devices we've found so far looks completely broken with
regard to hotplug.

Who does the swizzle for devices hot-added after boot?

Bjorn
