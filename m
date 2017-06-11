Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] MIPS: PCI: Remove unused busn_offset
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
References: <20170519195559.25338.30891.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170519195606.25338.73798.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <1b895897-8ea6-0ee4-42db-8ec085f9e273@gentoo.org>
Date: Sat, 10 Jun 2017 21:14:09 -0400
MIME-Version: 1.0
In-Reply-To: <20170519195606.25338.73798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/19/2017 15:56, Bjorn Helgaas wrote:
> pci_add_resource_offset() is for host bridge windows where the bridge
> translates CPU addresses to PCI bus addresses by adding an offset.  To my
> knowledge, no host bridge translates bus numbers, so this is only useful
> for MEM and IO windows.  In any event, host->busn_offset is never set to
> anything other than zero, so pci_add_resource() is sufficient.
> 
> a2e50f53d535 ("MIPS: PCI: Add a hook for IORESOURCE_BUS in
> pci_controller/bridge_controller") also added busn_resource itself.  This
> is currently unused but may be used by future SGI IP27 fixes, so I left it
> there.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/include/asm/pci.h |    1 -
>  arch/mips/pci/pci-legacy.c  |    3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 1000c1b4c875..52f551ee492d 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -39,7 +39,6 @@ struct pci_controller {
>  	unsigned long io_offset;
>  	unsigned long io_map_base;
>  	struct resource *busn_resource;
> -	unsigned long busn_offset;
>  
>  #ifndef CONFIG_PCI_DOMAINS_GENERIC
>  	unsigned int index;
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index 3a84f6c0c840..174575a9a112 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -86,8 +86,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>  				hose->mem_resource, hose->mem_offset);
>  	pci_add_resource_offset(&resources,
>  				hose->io_resource, hose->io_offset);
> -	pci_add_resource_offset(&resources,
> -				hose->busn_resource, hose->busn_offset);
> +	pci_add_resource(&resources, hose->busn_resource);
>  	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
>  				&resources);
>  	hose->bus = bus;
> 
> 

I tested this change out on my Octane (SGI-IP30) and Origin 200 (SGI-IP27), and
it appears to work fine on both systems (for now).

The Octane has two PCI host bridges in it right now (BaseIO & PCI Card cage),
while the Origin 200 only has one.  Haven't tested it on my bigger Onyx2 w/
multiple host bridges, but that machine has other problems, so I am ignoring it
for now.

I wasn't aware that pci_add_resource existed back when I wrote the patch.  The
symptom that was addressed was some conditional in the PCI core -- I forget
where -- wasn't enumerating multiple PCI busses without having an
IORESOURCE_BUS struct passed to it.  I think it found the first bus and then
moved on to other subsystems, which usually led to a non-booting machine.

Acked-by: Joshua Kinard <kumba@gentoo.org>
