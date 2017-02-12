Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Date: Sun, 12 Feb 2017 20:05:02 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Christoph Hellwig <hch@lst.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170212190502.GA2937@wunner.de>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
 <20170209201154.GA22458@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQUpzE-5XKS8hKy3e25CyhknDjwXkNk=ADxi-r_euJTd5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUpzE-5XKS8hKy3e25CyhknDjwXkNk=ADxi-r_euJTd5A@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 06:39:16PM -0800, Yinghai Lu wrote:
> On Thu, Feb 9, 2017 at 12:11 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Feb 09, 2017 at 09:09:50AM -0600, Bjorn Helgaas wrote:
> > > On Thu, Feb 09, 2017 at 05:06:48AM +0100, Lukas Wunner wrote:
> > > > https://patchwork.kernel.org/patch/9557113/
> > > > https://patchwork.kernel.org/patch/9562007/
> >
> > I apologize: I had quirks on the brain, but neither of the patches
> > above is device-specific.  So neither is claiming broken hardware.
> >
> > However, 9557113 claims we get unwanted PME interrupts if the slot is
> > occupied when we suspend to D3hot.  This is what I want to explore
> > further, because that hardware behavior doesn't really make sense to
> > me.
> >
> > 9562007 apparently fixes something, but at this point it's a debugging
> > patch (no changelog or signed-off-by) so not a candidate for tossing
> > into v4.10 at this late date.
> 
> Agreed. It should need more test coverage.  Found more problems.
> 
> Actually we don't need 9557113 as even with that, we still saw link up
> when power off slots with some cards.
> 
> please check updated version of 9562007, that fix power on/off link up
> problem.

Thank you for debugging this further.  The patch I've submitted today
reinstates runtime PM for hotplug ports but constrains it to those on
a Thunderbolt daisy chain.  The patch allows enabling the feature on
other hardware by booting with pcie_port_pm=force.

A few things to keep in mind:

* On Thunderbolt hotplug ports, interrupts are sent even if the port
  is in D3hot, which as Bjorn has pointed out contradicts the PCI PM
  spec r1.2, table 5-4.  This may be caused by liberal interpretation
  of the spec by Intel when designing the Thunderbolt controllers,
  or perhaps Thunderbolt controllers simply do not possess a "real",
  fully-fledged PCIe switch.  I let the hotplug ports go to D3hot,
  expecting them to continue delivering interrupts but YMMV.

* You've reported that the hotplug port must be in D0 to enable and
  disable power on the slot.  I think this is not required by the spec.
  Thunderbolt hotplug ports do not support power control.  My suspicion
  is that the ports on your machine must remain in D0 as long as the
  slot is occupied, i.e. they must not runtime suspend to D3hot.  Can
  this happen?  Yes.  I release the runtime PM ref once a slot has been
  enabled or disabled.  The device remains runtime active as long as it
  has active children.  If all children runtime suspend, the port will
  go to D3hot, which might cause trouble if this implies that slot power
  is turned off.  To test this you need a card whose Linux driver supports
  runtime PM (e.g. Nvidia GPU, boot with nouveau.runpm=1).

* If the hotplug slot has runtime suspended to D3hot and there are ports
  above it that also runtime suspend to D3hot, its config space is no
  longer accessible and in-band interrupts won't come through.  A side-band
  signaling method such as PME WAKE# is required to deliver interrupts from
  this state.  Also, the hotplug_slot_ops defined for pciehp will have to
  be augmented with calls to pm_runtime_get_sync() and pm_runtime_put()
  to wake the parent of the hotplug port so that config space is accessible
  when interacting with the slot via sysfs.

* If pciehp_poll_mode is used, it may be necessary to call
  pm_runtime_forbid(). (Or alternatively runtime resume it whenever config
  space is polled, but that seems silly.)


> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_ctrl.c
> +++ linux-2.6/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -89,17 +89,17 @@ static int board_added(struct slot *p_sl
>  	struct controller *ctrl = p_slot->ctrl;
>  	struct pci_bus *parent = ctrl->pcie->port->subordinate;
>  
> +	pm_runtime_get_sync(&ctrl->pcie->port->dev);
>  	if (POWER_CTRL(ctrl)) {
>  		/* Power on slot */
>  		retval = pciehp_power_on_slot(p_slot);
>  		if (retval)
> -			return retval;
> +			goto err_exit;
>  	}
>  
>  	pciehp_green_led_blink(p_slot);
>  
>  	/* Check link training status */
> -	pm_runtime_get_sync(&ctrl->pcie->port->dev);
>  	retval = pciehp_check_link_status(ctrl);
>  	if (retval) {
>  		ctrl_err(ctrl, "Failed to check link status\n");

Well, it may be simpler to just move the pm_runtime_get_sync() / _put()
to the caller of board_added() and remove_board().  That way it's not
necessary to insert a pm_runtime_put() into every error path.  The
patch I've submitted today does exactly that.

In fact, v2 of my Thunderbolt runtime PM series, posted in May 2016,
already did that:
http://www.spinics.net/lists/linux-pci/msg51153.html

But for v3 I decided to move the pm_runtime_get_sync() / _put() down
the call stack into board_added() and remove_board() to make more
precise exactly which operations require the hotplug port to be in D0.
Guess that wasn't a good idea. :-(

Thanks,

Lukas
