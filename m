Return-Path: <SRS0=tr2T=KP=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=tr2T=KP=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 31 Jul 2018 11:03:42 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: pciehp: Deduplicate presence check on probe &
 resume
Message-ID: <20180731080342.GA2534@lahna.fi.intel.com>
References: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
 <f9c36223a126c86ecc7dc921f8f943d29926edc3.1532754355.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9c36223a126c86ecc7dc921f8f943d29926edc3.1532754355.git.lukas@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 28, 2018 at 07:22:00AM +0200, Lukas Wunner wrote:
> On driver probe and on resume from system sleep, pciehp checks the
> Presence Detect State bit in the Slot Status register to bring up an
> occupied slot or bring down an unoccupied slot.  Both code paths are
> identical, so deduplicate them per Mika's request.
> 
> On probe, an additional check is performed to disable power of an
> unoccupied slot.  This can e.g. happen if power was enabled by BIOS.
> It cannot happen once pciehp has taken control, hence is not necessary
> on resume:  The Slot Control register is set to the same value that it
> had on suspend by pci_restore_state(), so if the slot was occupied,
> power is enabled and if it wasn't, power is disabled.  Should occupancy
> have changed during the system sleep transition, power is adjusted by
> bringing up or down the slot per the paragraph above.
> 
> To allow for deduplication of the presence check, move the power check
> to pcie_init().  This seems safer anyway, because right now it is
> performed while interrupts are already enabled, and although I can't
> think of a scenario where pciehp_power_off_slot() and the IRQ thread
> collide, it does feel brittle.
> 
> However this means that pcie_init() may now write to the Slot Control
> register before the IRQ is requested.  If both the CCIE and HPIE bits
> happen to be set, pcie_wait_cmd() will wait for an interrupt (instead
> of polling the Command Completed bit) and eventually emit a timeout
> message.  Additionally, if a level-triggered INTx interrupt is used,
> the user may see a spurious interrupt splat.  Avoid by disabling
> interrupts before disabling power.  (Normally the HPIE and CCIE bits
> should be clear on probe, but conceivably they may already have been
> set e.g. by BIOS.)
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

One small nit, see below:

> ---
>  drivers/pci/hotplug/pciehp_core.c | 63 ++++++++++++++++---------------
>  drivers/pci/hotplug/pciehp_hpc.c  | 14 +++++++
>  2 files changed, 46 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 01fcf1fa0f66..ec48c9433ae5 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -200,12 +200,40 @@ static int reset_slot(struct hotplug_slot *hotplug_slot, int probe)
>  	return pciehp_reset_slot(slot, probe);
>  }
>  
> +/**
> + * pciehp_check_presence() - synthesize event if presence has changed

You should document the argument as well so that the tool that is used
to process these knows about it:

  @ctrl: ....

> + *
> + * On probe and resume, an explicit presence check is necessary to bring up an
> + * occupied slot or bring down an unoccupied slot.  This can't be triggered by
> + * events in the Slot Status register, they may be stale and are therefore
> + * cleared.  Secondly, sending an interrupt for "events that occur while
> + * interrupt generation is disabled [when] interrupt generation is subsequently
> + * enabled" is optional per PCIe r4.0, sec 6.7.3.4.
> + */
> +static void pciehp_check_presence(struct controller *ctrl)
