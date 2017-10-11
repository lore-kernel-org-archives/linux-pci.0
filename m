Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751994AbdJKNHn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 09:07:43 -0400
MIME-Version: 1.0
In-Reply-To: <20171011080041.12918-1-kishon@ti.com>
References: <20171011080041.12918-1-kishon@ti.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 11 Oct 2017 08:07:21 -0500
Message-ID: <CAL_JsqLLgCt+wS5uFmLXB5Z-_vb-akme0hXjemtc_gzQwpwPYA@mail.gmail.com>
Subject: Re: [PATCH] of: Devices with pci_epf_bus_type require DMA configuration
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 3:00 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> pci-epc-core.c invokes of_dma_configure in order to configure
> the coherent_dma_mask/dma_mask of endpoint function device. This is
> required for dma_alloc_coherent to succeed in pci function driver
> (pci-epf-test.c). However after
> commit 723288836628bc1c08 ("of: restrict DMA configuration"),
> of_dma_configure doesn't configure the coherent_dma_mask/dma_mask
> of endpoint function device (since it doesn't have dma-ranges
> property), resulting in dma_alloc_coherent in pci endpoint function
> driver to to fail. Fix it by making sure of_dma_configure configures
> coherent_dma_mask/dma_mask irrespective of whether the node has
> dma-ranges property or not.
>
> Fixes: 723288836628bc1c08 ("of: restrict DMA configuration")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/of/device.c                 | 4 +++-
>  drivers/pci/endpoint/pci-epf-core.c | 3 +--
>  include/linux/pci-epf.h             | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 64b710265d39..881cf80a3d69 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -10,6 +10,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <linux/pci-epf.h>
>  #include <linux/platform_device.h>
>  #include <linux/amba/bus.h>
>
> @@ -105,7 +106,8 @@ int of_dma_configure(struct device *dev, struct device_node *np)
>  #ifdef CONFIG_ARM_AMBA
>                     dev->bus != &amba_bustype &&
>  #endif
> -                   dev->bus != &platform_bus_type)
> +                   dev->bus != &platform_bus_type &&
> +                   dev->bus != &pci_epf_bus_type)

This is going to fail when this PCI is disabled. There's some
restructuring of this code proposed that will help you that I copied
you on.

Rob
