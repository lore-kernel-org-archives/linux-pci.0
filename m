Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:54847 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIGK3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2018 06:29:16 -0400
Date: Fri, 7 Sep 2018 07:49:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Daniel Drake <drake@endlessm.com>
Cc: bhelgaas@google.com, mika.westerberg@linux.intel.com,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        rafael.j.wysocki@intel.com, nic_swsd@realtek.com,
        keith.busch@intel.com, netdev@vger.kernel.org,
        nouveau@lists.freedesktop.org, andriy.shevchenko@linux.intel.com,
        linux@endlessm.com, davem@davemloft.net,
        jonathan.derrick@intel.com, hkallweit1@gmail.com
Subject: Re: [Nouveau] [PATCH] PCI: Reprogram bridge prefetch registers on
 resume
Message-ID: <20180907054956.kuf4ttqoil5eiykl@wunner.de>
References: <20180907053614.6540-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907053614.6540-1-drake@endlessm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 01:36:14PM +0800, Daniel Drake wrote:
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -934,6 +934,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>  unsigned int pci_scan_child_bus(struct pci_bus *bus);
>  void pci_bus_add_device(struct pci_dev *dev);
> +void pci_setup_bridge_mmio_pref(struct pci_dev *bridge);
>  void pci_read_bridge_bases(struct pci_bus *child);
>  struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  					  struct resource *res);

Since this is only used internally in the PCI core, the declaration
can live in drivers/pci/pci.h.

Thanks,

Lukas
