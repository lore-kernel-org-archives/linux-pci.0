Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 Mar 2016 11:43:35 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vga_switcheroo: add power support for windows 10
 machines.
Message-ID: <20160314094335.GE1796@lahna.fi.intel.com>
References: <1457504045-12738-1-git-send-email-airlied@gmail.com>
 <2736217.utxPzJExd5@vostro.rjw.lan>
 <20160311105815.GS1796@lahna.fi.intel.com>
 <2759763.dR5D0KopkA@vostro.rjw.lan>
 <CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPM=9txo4aOOa-CS-mnyQe+vYDtAOCm1bzAgfMzwJJS8ZuYmwQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 14, 2016 at 12:19:14PM +1000, Dave Airlie wrote:
> On 11 March 2016 at 23:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, March 11, 2016 12:58:15 PM Mika Westerberg wrote:
> >> On Thu, Mar 10, 2016 at 09:57:09PM +0100, Rafael J. Wysocki wrote:
> >> > > It doesn't seem to do any runtime PM,
> >> > > I do wonder if pcieport should be doing it's own runtime PM handling,
> >> > > but that is a
> >> > > larger task than I'm thinking to tackle here.
> >> >
> >> > PCIe ports don't do PM - yet.  Mika has posted a series of patches to implement
> >> > that, however, that are waiting for comments now:
> >> >
> >> > https://patchwork.kernel.org/patch/8453311/
> >> > https://patchwork.kernel.org/patch/8453381/
> >> > https://patchwork.kernel.org/patch/8453391/
> >> > https://patchwork.kernel.org/patch/8453411/
> >> > https://patchwork.kernel.org/patch/8453371/
> >> > https://patchwork.kernel.org/patch/8453351/
> >> >
> >> > > Maybe I should be doing
> >> > >
> >> > > pci_set_power_state(pdev->bus->self, PCI_D3cold) ? I'm not really sure.
> >> >
> >> > Using pci_set_power_state() would be more appropriate IMO, but you can get
> >> > to the bridge via dev->parent too, can't you?
> >> >
> >> > In any case, it looks like you and Mika need to talk. :-)
> >>
> >> When the vga_switcheroo device gets runtime suspended (with the above
> >> runtime PM patchs for PCIe root ports) the root port should also be
> >> runtime suspended by the PM core.
> >
> > Right, after your patches have been applied, the additional handling
> > won't be needed.
> >
> > So Dave, maybe you can check if the Mika's patches help?
> 
> Hi Mika,
> 
> I tested your patches with a couple of changes on the Lenovo W541.

Thanks for testing.

> The attached patch contains the two things I needed to get the same
> functionality
> as my patches.
> 
> I'm really not in love with the per-chipset enablement for this,
> really any chipsets
> after a certain year should probably be better, as we'll constantly be
> adding PCI Ids
> for every chipset ever made, and I expect we'll forget some.

Bjorn also had the same comment. I think I'll change it to use cut-off
date instead of list of PCI IDs of nobody objects.

> Dave.

> From eea412076c9d24262ebd4811f766d5379b728045 Mon Sep 17 00:00:00 2001
> From: Dave Airlie <airlied@redhat.com>
> Date: Mon, 14 Mar 2016 23:37:43 +1000
> Subject: [PATCH] [RFC] PCI: enable runtime PM on pcieports to let secondary
>  GPUs powerdown.
> 
> With secondary GPUs in Windows 10 laptops we need to use runtime PM
> to power down the PCIe ports after the devices goes to D3Cold.
> 
> This patch adds the PCI ID for the Haswell 16x PCIE slot found
> in the W541 laptops. I should probably try and gather the PCI IDs,
> for broadwell/skylake variants as well if we can't find them.
> 
> This fixes a regression on W541 laptops on top of Mika's PCIE patches
> since we started advertising Windows 2013 ACPI.
> 
> [probably should be two patches - hence RFC]
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 43dd23e..1405de8 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -278,8 +278,10 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  
>  	pci_save_state(dev);
>  
> -	if (pcie_port_runtime_suspend_allowed(dev))
> +	if (pcie_port_runtime_suspend_allowed(dev)) {
> +		pm_runtime_allow(&dev->dev);

PCI drivers typically have left this decision up to the userspace. I'm
wondering whether it is good idea to deviate from that here? Of course
this allows immediate power savings but could potentially cause problems
as well.

I think we need to add corresponding call to pm_runtime_forbid() in
pcie_portdrv_remove().

>  		pm_runtime_put_noidle(&dev->dev);
> +	}
>  
>  	return 0;
>  }
> @@ -436,6 +438,8 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>   * LINUX Device Driver Model
>   */
>  static const struct pci_device_id port_pci_ids[] = {
> +	/* Intel Skylake PCIE graphics port */
> +	{ PCI_VDEVICE(INTEL, 0x0c01), .driver_data = PCIE_PORT_SPT },
>  	/* Intel Broxton */
>  	{ PCI_VDEVICE(INTEL, 0x1ad6), .driver_data = PCIE_PORT_SPT },
>  	{ PCI_VDEVICE(INTEL, 0x1ad7), .driver_data = PCIE_PORT_SPT },
> -- 
> 2.5.0
> 

