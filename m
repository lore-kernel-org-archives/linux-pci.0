Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63942 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321Ab3GZMni (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 08:43:38 -0400
MIME-Version: 1.0
In-Reply-To: <20130725175727.6006.98109.stgit@bhelgaas-glaptop>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
	<20130725175727.6006.98109.stgit@bhelgaas-glaptop>
Date: Fri, 26 Jul 2013 05:43:36 -0700
Message-ID: <CAE9FiQU9k6m-5bM5ZfFUZxW3H7_v4aOtaK66pa7iV0Zb-J86jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: pciehp: Convert pciehp to be builtin only, not modular
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	linux-sh@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 25, 2013 at 10:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Convert pciehp to be builtin only, with no module option.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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

Acked-by: Yinghai Lu <yinghai@kernel.org>
