Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=DZ5F=MB=intel.com=keith.busch@kernel.org>
Date: Wed, 19 Sep 2018 11:05:33 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sinan Kaya <okaya@kernel.org>, Thomas Tai <thomas.tai@oracle.com>,
	poza@codeaurora.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCHv3 01/10] PCI/portdrv: Use subsys_init for service drivers
Message-ID: <20180919170533.GA28310@localhost.localdomain>
References: <20180918235702.26573-1-keith.busch@intel.com>
 <20180918235702.26573-2-keith.busch@intel.com>
 <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180919162846.GB243610@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 11:28:46AM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 05:56:53PM -0600, Keith Busch wrote:
> > The PCI port driver saves the PCI state after initializing all the
> > service devices. This was, however, before the service drivers were even
> > registered. The config space state that the service drivers were setting
> > up were not being saved.
> > 
> > This patch fixes this by changing the service drivers use the
> > subsys_init, which gets the service drivers registered after the pci bus
> > system is initialized, but before the pci devices are probed. This gets
> > the state saved as expected.
> 
> I agree this is a problem.  What are the user-visible symptoms of it?
> Incorrect service behavior after a resume?  Nice debugging and fix!

I'll look at the suspend/resume case too, but I noticed the incorrect
behavior after a bus reset: future DPC or HPC events downstream a port
were lost after an AER recovery because the control registers were
never restored.

The very next patch is required too, since that's what actually restores
the registers to the saved state.

> I think the ordering here is pretty obscure.  We have a lot of
> initcalls here and they all have to line up exactly right.  If I
> understand correctly, the flow of the required pieces (after this
> patch) is like this:
> 
>   pci_driver_init                             # postcore_initcall (2)
>     bus_register(&pcie_port_bus_type)
> 
>   pcied_init (pciehp)                         # subsys_initcall (4)
>     pcie_port_service_register(&hpdriver_portdrv)
>       new->driver.bus = &pcie_port_bus_type   # depends on above
>                                               # bus_register()
>       driver_register(&new->driver)
> 
>   pcie_portdrv_init                           # device_initcall (6)
>     pci_register_driver(&pcie_portdriver)
> 
>   pcie_portdrv_probe                          # pcie_portdriver.probe
>     pcie_port_device_register
>       pcie_device_init
>         device_register
>           device_add
>             bus_probe_device
>               ...
>                 pciehp_probe                  # <-- critical init
>                                               # depends on above
>                                               # service_register() and
>                                               # eager probing
>     pci_save_state                            # <-- critical save
> 
> The problem used to be that both pcied_init() (for pciehp) and
> pcie_portdrv_init() were device initcalls and pcie_portdrv_init() was
> called before pcied_init() because of link order, so the
> pci_save_state() happened before the pciehp init.
> 
> Since none of the service drivers can be modules, I don't think it
> buys us much to make their init functions initcalls.  Can we
> explicitly call them from the pcie_portdrv_probe() path?

That sounds good to me. The portdrv isn't all that abstracted from the
child services anyway.
