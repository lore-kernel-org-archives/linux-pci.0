Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:33875 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386Ab3GWXKb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 19:10:31 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so12907123oag.9
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 16:10:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130723180821.19616.52936.stgit@bhelgaas-glaptop>
References: <20130723180001.19616.72450.stgit@bhelgaas-glaptop>
	<20130723180821.19616.52936.stgit@bhelgaas-glaptop>
Date: Tue, 23 Jul 2013 16:10:30 -0700
Message-ID: <CAE9FiQU5-rjWir=NvwEs0vEMmSL9qps6NAa2QFO7yNrLzrx26A@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Convert pciehp to be builtin only, not modular
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 23, 2013 at 11:08 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Convert pciehp to be builtin only, with no module option.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/Kconfig |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 569f82f..3b94cfc 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>  # Include service Kconfig here
>  #
>  config HOTPLUG_PCI_PCIE
> -       tristate "PCI Express Hotplug driver"
> +       bool "PCI Express Hotplug driver"
>         depends on HOTPLUG_PCI && PCIEPORTBUS

HOTPLUG_PCI is still tristate,

 menuconfig HOTPLUG_PCI
        tristate "Support for PCI Hotplug"


Can you make HOTPLUG_PCI to be built-in ?

or to be more aggressive, just kill HOTPLUG_PCI as with HOTPLUG.

Thanks

Yinghai

>         help
>           Say Y here if you have a motherboard that supports PCI Express Native
>           Hotplug
>
> -         To compile this driver as a module, choose M here: the
> -         module will be called pciehp.
> -
>           When in doubt, say N.
>
>  source "drivers/pci/pcie/aer/Kconfig"
>
