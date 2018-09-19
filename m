Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbeISWH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:07:28 -0400
Date: Wed, 19 Sep 2018 11:28:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 01/10] PCI/portdrv: Use subsys_init for service drivers
Message-ID: <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-2-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180918235702.26573-2-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 18, 2018 at 05:56:53PM -0600, Keith Busch wrote:
> The PCI port driver saves the PCI state after initializing all the
> service devices. This was, however, before the service drivers were even
> registered. The config space state that the service drivers were setting
> up were not being saved.
> 
> This patch fixes this by changing the service drivers use the
> subsys_init, which gets the service drivers registered after the pci bus
> system is initialized, but before the pci devices are probed. This gets
> the state saved as expected.

I agree this is a problem.  What are the user-visible symptoms of it?
Incorrect service behavior after a resume?  Nice debugging and fix!

I think the ordering here is pretty obscure.  We have a lot of
initcalls here and they all have to line up exactly right.  If I
understand correctly, the flow of the required pieces (after this
patch) is like this:

  pci_driver_init                             # postcore_initcall (2)
    bus_register(&pcie_port_bus_type)

  pcied_init (pciehp)                         # subsys_initcall (4)
    pcie_port_service_register(&hpdriver_portdrv)
      new->driver.bus = &pcie_port_bus_type   # depends on above
                                              # bus_register()
      driver_register(&new->driver)

  pcie_portdrv_init                           # device_initcall (6)
    pci_register_driver(&pcie_portdriver)

  pcie_portdrv_probe                          # pcie_portdriver.probe
    pcie_port_device_register
      pcie_device_init
        device_register
          device_add
            bus_probe_device
              ...
                pciehp_probe                  # <-- critical init
                                              # depends on above
                                              # service_register() and
                                              # eager probing
    pci_save_state                            # <-- critical save

The problem used to be that both pcied_init() (for pciehp) and
pcie_portdrv_init() were device initcalls and pcie_portdrv_init() was
called before pcied_init() because of link order, so the
pci_save_state() happened before the pciehp init.

Since none of the service drivers can be modules, I don't think it
buys us much to make their init functions initcalls.  Can we
explicitly call them from the pcie_portdrv_probe() path?

> Note, 70626d88385 ("PCI: pciehp: Make explicitly non-modular") already
> mentioned this exact change should be done, but declined to at the time
> until there was a real need for it.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_core.c | 2 +-
>  drivers/pci/pcie/aer.c            | 2 +-
>  drivers/pci/pcie/dpc.c            | 2 +-
>  drivers/pci/pcie/pme.c            | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ccaf01e6eced..334044814dbe 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -322,4 +322,4 @@ static int __init pcied_init(void)
>  
>  	return retval;
>  }
> -device_initcall(pcied_init);
> +subsys_initcall(pcied_init);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 83180edd6ed4..1d2159409b01 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1575,4 +1575,4 @@ static int __init aer_service_init(void)
>  		return -ENXIO;
>  	return pcie_port_service_register(&aerdriver);
>  }
> -device_initcall(aer_service_init);
> +subsys_initcall(aer_service_init);
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f03279fc87cd..aacfb50eccfc 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -286,4 +286,4 @@ static int __init dpc_service_init(void)
>  {
>  	return pcie_port_service_register(&dpcdriver);
>  }
> -device_initcall(dpc_service_init);
> +subsys_initcall(dpc_service_init);
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 3ed67676ea2a..cd8c1adb9b0a 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -450,4 +450,4 @@ static int __init pcie_pme_service_init(void)
>  {
>  	return pcie_port_service_register(&pcie_pme_driver);
>  }
> -device_initcall(pcie_pme_service_init);
> +subsys_initcall(pcie_pme_service_init);
> -- 
> 2.14.4
> 
