Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbdK3XFR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Nov 2017 18:05:17 -0500
Date: Thu, 30 Nov 2017 17:05:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] PCI: Add support to the Cadence PCIe controller
Message-ID: <20171130230514.GC19640@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171128155039.GA17154@red-moon>
 <8c6c50fc-47a9-7b93-d826-1dba9c4d09c2@ti.com>
 <20171130181819.GD12096@red-moon>
 <a02af401-2eb8-dc34-6f3c-092f04ec2636@free-electrons.com>
 <058b2025-f55d-9210-a979-d00972259987@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <058b2025-f55d-9210-a979-d00972259987@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 30, 2017 at 09:05:12PM +0100, Cyrille Pitchen wrote:
> Le 30/11/2017 à 19:45, Cyrille Pitchen a écrit :
> > Le 30/11/2017 à 19:18, Lorenzo Pieralisi a écrit :
> >> On Thu, Nov 30, 2017 at 12:43:20PM +0530, Kishon Vijay Abraham I wrote:

> >>> The reason to patch drivers/Makefile should be because
> >>> pcie-cadence-ep has to be compiled even when CONFIG_PCI is not
> >>> enabled. CONFIG_PCI enables host specific features and ENDPOINT
> >>> shouldn't depend on CONFIG_PCI.

> I know it's far from perfect but what do you think or something like that:
> 
> ---8<---------------------------------------------------------------------------
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 27bdd98784d9..9757199b9a65 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -16,11 +16,7 @@ obj-$(CONFIG_PINCTRL)		+= pinctrl/
>  obj-$(CONFIG_GPIOLIB)		+= gpio/
>  obj-y				+= pwm/
>  
> -obj-$(CONFIG_PCI)		+= pci/
> -obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
> -obj-$(CONFIG_PCI_CADENCE)	+= pci/cadence/
> -# PCI dwc controller drivers
> -obj-y				+= pci/dwc/
> +obj-y				+= pci/
>  
>  obj-$(CONFIG_PARISC)		+= parisc/
>  obj-$(CONFIG_RAPIDIO)		+= rapidio/
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 3d5e047f0a32..4e57fe4499ce 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the PCI bus specific drivers.
>  #
>  
> +ifdef CONFIG_PCI
>  obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
>  			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
>  			irq.o vpd.o setup-bus.o vc.o mmap.o setup-irq.o
> @@ -54,3 +55,9 @@ ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>  # PCI host controller drivers
>  obj-y += host/
>  obj-y += switch/
> +endif
> +
> +obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> +obj-$(CONFIG_PCI_CADENCE)	+= cadence/
> +# PCI dwc controller drivers
> +obj-y				+= dwc/
> ---8<---------------------------------------------------------------------------
> 
> I admit it doesn't solve the ordering issue but at least it cleans some mess
> in drivers/Makefile. 

I like this a lot.  I think the only things that would actually
require the ifdef are the generic symbol things (CONFIG_PROC_FS,
CONFIG_SYSFS, CONFIG_OF), so we could do this for most of it:

  obj-$(CONFIG_PCI)		+= access.o bus.o probe.o ...
  ...
  obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
  obj-$(CONFIG_PCIEPORTBUS)	+= pcie/
  obj-$(CONFIG_PCI)		+= host/
  obj-$(CONFIG_PCI)		+= switch/

With possibly a few Kconfig dependency tweaks.
