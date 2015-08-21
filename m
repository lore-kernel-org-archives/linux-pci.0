Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36004 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbbHUT63 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2015 15:58:29 -0400
Received: by wicja10 with SMTP id ja10so23883066wic.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2015 12:58:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150821150800.7525.14750.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150821150557.7525.58923.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150821150800.7525.14750.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 21 Aug 2015 12:58:08 -0700
Message-ID: <CAErSpo7wEpPSy9BSt6t5UYXSqbXRf_Wu-1kzDCzmowO60UqKTQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: Change MPS default to "match upstream bridge"
To: Keith Busch <keith.busch@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Austin Bolen <Austin_Bolen@dell.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Myron Stowe <mstowe@redhat.com>, Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 21, 2015 at 8:08 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Change the default MPS tuning policy to "default," which means we set every
> device's MPS to match its upstream bridge.  Typically this means we'll
> preserve the fabric configuration done by firmware, even for hot-added
> devices.
>
> N.B. This effectively re-enables quirk_intel_mc_errata(), which turns off
> read completion coalescing on Intel 5000 and 5100 memory controllers.

I think this patch might be the wrong thing for quirk_intel_mc_errata().

Currently, the default is PCIE_BUS_TUNE_OFF.  In that case, the quirk
does nothing, Linux doesn't touch MPS at all, and the BIOS is
responsible for avoiding the erratum, either by disabling read
coalescing or by avoiding MPS=256.

This patch (as-is) means that even if the BIOS set MPS=128, we would
disable read coalescing here, which is unnecessary.  The new
PCIE_BUS_DEFAULT basically means Linux will set MPS for hot-added
devices the same way as for devices present at boot.  That means we
should be able to rely on the BIOS workaround and shouldn't have to
disable read coalescing.

So I think maybe we should bail out of quirk_intel_mc_errata() for
both TUNE_OFF and DEFAULT, e.g.,

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2862,7 +2862,8 @@ static void quirk_intel_mc_errata(struct pci_dev *dev)
        int err;
        u16 rcc;

-       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
+       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
+           pcie_bus_config == PCIE_BUS_DEFAULT)
                return;


> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c   |    2 +-
>  drivers/pci/probe.c |    3 ++-
>  include/linux/pci.h |    9 +++++----
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0008c95..b96b4cc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -81,7 +81,7 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
>  unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
>
> -enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
>
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f73dd7a..9da27af 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1831,7 +1831,8 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
>         if (!pci_is_pcie(dev))
>                 return 0;
>
> -       if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> +       if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
> +           pcie_bus_config == PCIE_BUS_DEFAULT)
>                 return 0;
>
>         mps = 128 << *(u8 *)data;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4d4f9d2..faf06a1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -738,10 +738,11 @@ struct pci_driver {
>  void pcie_bus_configure_settings(struct pci_bus *bus);
>
>  enum pcie_bus_config_types {
> -       PCIE_BUS_TUNE_OFF,
> -       PCIE_BUS_SAFE,
> -       PCIE_BUS_PERFORMANCE,
> -       PCIE_BUS_PEER2PEER,
> +       PCIE_BUS_TUNE_OFF,      /* don't touch MPS at all */
> +       PCIE_BUS_DEFAULT,       /* MPS matches upstream bridge */
> +       PCIE_BUS_SAFE,          /* largest MPS supported by boot-time devices */
> +       PCIE_BUS_PERFORMANCE,   /* use MPS and MRRS for best performance */
> +       PCIE_BUS_PEER2PEER,     /* MPS = 128 for all devices */
>  };
>
>  extern enum pcie_bus_config_types pcie_bus_config;
>
