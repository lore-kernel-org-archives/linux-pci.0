Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Jun 2016 07:12:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: Add support for unbinding the generic PCI host
 controller
Message-ID: <20160624061238.GD29165@arm.com>
References: <57698276.6050606@siemens.com>
 <20160622060638.GY29165@arm.com>
 <576C1CF6.7020804@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <576C1CF6.7020804@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 23, 2016 at 07:31:34PM +0200, Jan Kiszka wrote:
> On 2016-06-22 08:06, Will Deacon wrote:
> > On Tue, Jun 21, 2016 at 08:07:50PM +0200, Jan Kiszka wrote:
> >> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> >> index 8cba7ab..c0ff4b1 100644
> >> --- a/drivers/pci/host/pci-host-common.c
> >> +++ b/drivers/pci/host/pci-host-common.c
> >> @@ -164,6 +164,19 @@ int pci_host_common_probe(struct platform_device *pdev,
> >>  	}
> >>  
> >>  	pci_bus_add_devices(bus);
> >> +	platform_set_drvdata(pdev, bus);
> >> +	return 0;
> >> +}
> >> +
> >> +int pci_host_common_remove(struct platform_device *pdev)
> >> +{
> >> +	struct pci_bus *bus = platform_get_drvdata(pdev);
> >> +
> >> +	pci_lock_rescan_remove();
> >> +	pci_stop_root_bus(bus);
> >> +	pci_remove_root_bus(bus);
> >> +	pci_unlock_rescan_remove();
> > 
> > A couple of comments/questions about this:
> > 
> >   - The probe path seems to have some stateful operations outside of PCI
> >     resources. For example, kzalloc'ing the bus_range resource in
> >     of_pci_get_host_bridge_resources. Do we need to clean these up
> >     explicitly?
> > 
> >   - Similarly, we don't seem to tear-down the config space mappings and
> >     data structures for that, so we leak VA space afaict.
> > 
> 
> Good points. But to my understanding, everything is released
> automatically on pci_remove_root_bus because all the resources are
> registered with the bus which takes care of them during destruction. And
> if I trace the release, I find this e.g.
> 
> ...
> devres_release_all() {
>   _raw_spin_lock_irqsave();
>   release_nodes() {
>     _raw_spin_unlock_irqrestore();
>     devm_action_release() {
>       gen_pci_unmap_cfg() {

Ah, thanks for investigating that -- I completely missed the explicit
devm_ callback. That resolves my concern about the config space mappings,
but I still don't understand what happens to the resources allocated
in of_pci_get_host_bridge_resources. It looks like they should actually
be freed within that function, since pci_add_resource{_offset} copy the
resources into their own resource_entries anyway.

Am I missing something?

Will
