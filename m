Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:45676 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbbCKMgH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2015 08:36:07 -0400
MIME-Version: 1.0
In-Reply-To: <1426001139-18419-1-git-send-email-m-karicheri2@ti.com>
References: <1426001139-18419-1-git-send-email-m-karicheri2@ti.com>
From: Rob Herring <robherring2@gmail.com>
Date: Wed, 11 Mar 2015 07:35:45 -0500
Message-ID: <CAL_JsqJPvW5q4XwwenFTHrDG4cU5uTd7n-vLKj0mdV9FbVC4Ag@mail.gmail.com>
Subject: Re: [PATCH] pci: of : fix BUG: unable to handle kernel
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Will Deacon <will.deacon@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 10, 2015 at 10:25 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On some platforms such as that based on x86, ia64 etc, root bus is
> created with parent node passed in as NULL to pci_create_root_bus().
> On these platforms, the patch series "PCI: get DMA configuration from
> parent device" when applied causes kernel crash. So add a check for this
> in of_pci_dma_configure()

Wouldn't these arches have OF disabled and call an empty function?
Regardless, we still need this.

> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

I'm assuming Bjorn will apply this.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  drivers/of/of_pci.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 86d3c38..a8e485c 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -129,6 +129,10 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
>         struct device *dev = &pci_dev->dev;
>         struct device *bridge = pci_get_host_bridge_device(pci_dev);
>
> +       /* Some platforms can have bridge->parent set to NULL */
> +       if (!bridge->parent)
> +               return;
> +
>         of_dma_configure(dev, bridge->parent->of_node);
>         pci_put_host_bridge_device(bridge);
>  }
> --
> 1.7.9.5
>
