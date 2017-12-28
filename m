Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbdL1Wr2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Dec 2017 17:47:28 -0500
Date: Thu, 28 Dec 2017 16:47:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] PCI: Regroup all PCI related entries into
 drivers/pci/Makefile
Message-ID: <20171228224718.GA19819@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <49f5a733e05a46521340e913876332f3804e2042.1513620412.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49f5a733e05a46521340e913876332f3804e2042.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 18, 2017 at 07:16:01PM +0100, Cyrille Pitchen wrote:
> This patch cleans drivers/Makefile up by moving the pci/endpoint and
> pci/dwc entries from drivers/Makefile into drivers/pci/Makefile.

Thanks a lot for doing this!

s/This patch cleans/Clean up/

Speaking of cleanup, this Makefile has useless comments and blank
lines.  Maybe you could add a new patch to remove them and reorder it
into a sensible order, with the Intel MID special case at the end and
the host/dwc/cadence stuff together?

> Since we don't want to introduce any dependency between CONFIG_PCI and
> CONFIG_PCI_ENDPOINT, we now always execute drivers/pci/Makefile.
>
> Hence all Makefiles in drivers/pci/ were updated accordingly so no file is
> compiled when CONFIG_PCI is not defined.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  drivers/Makefile          |  5 +----
>  drivers/pci/Kconfig       |  1 +
>  drivers/pci/Makefile      | 11 ++++++++---
>  drivers/pci/host/Makefile |  2 ++
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 1d034b680431..9757199b9a65 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -16,10 +16,7 @@ obj-$(CONFIG_PINCTRL)		+= pinctrl/
>  obj-$(CONFIG_GPIOLIB)		+= gpio/
>  obj-y				+= pwm/
>  
> -obj-$(CONFIG_PCI)		+= pci/
> -obj-$(CONFIG_PCI_ENDPOINT)	+= pci/endpoint/
> -# PCI dwc controller drivers
> -obj-y				+= pci/dwc/
> +obj-y				+= pci/
>
>  obj-$(CONFIG_PARISC)		+= parisc/
>  obj-$(CONFIG_RAPIDIO)		+= rapidio/
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index bda151788f3f..7eeb969ab86a 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -125,6 +125,7 @@ config PCI_PASID
>  
>  config PCI_LABEL
>  	def_bool y if (DMI || ACPI)
> +	depends on PCI
>  	select NLS
>  
>  config PCI_HYPERV
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index c7819b973df7..7284a7f6ad1e 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -3,12 +3,15 @@
>  # Makefile for the PCI bus specific drivers.
>  #
>  
> -obj-y		+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
> +obj-$(CONFIG_PCI)	+= access.o bus.o probe.o host-bridge.o remove.o pci.o \
>  			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o \
>  			irq.o vpd.o setup-bus.o vc.o mmap.o setup-irq.o
>  
> +ifdef CONFIG_PCI
>  obj-$(CONFIG_PROC_FS) += proc.o
>  obj-$(CONFIG_SYSFS) += slot.o
> +obj-$(CONFIG_OF) += of.o
> +endif
>  
>  obj-$(CONFIG_PCI_QUIRKS) += quirks.o
>  
> @@ -44,10 +47,12 @@ obj-$(CONFIG_PCI_ECAM) += ecam.o
>  
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  
> -obj-$(CONFIG_OF) += of.o
> -
>  ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>  
>  # PCI host controller drivers
>  obj-y += host/
>  obj-y += switch/
> +
> +obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> +# PCI dwc controller drivers
> +obj-y				+= dwc/
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index 34ec1d88f961..3b1059190867 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -34,6 +34,8 @@ obj-$(CONFIG_VMD) += vmd.o
>  # ARM64 and use internal ifdefs to only build the pieces we need
>  # depending on whether ACPI, the DT driver, or both are enabled.
>  
> +ifdef CONFIG_PCI
>  obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>  obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>  obj-$(CONFIG_ARM64) += pci-xgene.o
> +endif
> -- 
> 2.11.0
> 
