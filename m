Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=PF/i=ZZ=wunner.de=lukas@kernel.org>
Date: Sun, 12 Feb 2017 17:31:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 7/8] thunderbolt: Power down controller when idle
Message-ID: <20170212163130.GA2769@wunner.de>
References: <cover.1484486499.git.lukas@wunner.de>
 <153c459627143d2a071344567367032afa4eadef.1484486499.git.lukas@wunner.de>
 <20170128233237.GQ20550@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170128233237.GQ20550@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 28, 2017 at 05:32:37PM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> > A Thunderbolt controller appears to the OS as a set of virtual devices:
> > One upstream bridge, multiple downstream bridges and one NHI (Native
> > Host Interface).  The upstream and downstream bridges represent a PCIe
> > switch (see definition of a switch in the PCIe spec).  The NHI device is
> > used to manage the switch fabric.  Hotplugged devices appear behind the
> > downstream bridges:
> > 
> >   (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
> >                                      +-- Downstream Bridge 1 --
> >                                      +-- Downstream Bridge 2 --
> >                                      ...
> > 
> > Power is cut to the entire set of devices.  The Linux pm model is
> > hierarchical and assumes that a child cannot resume before its parent.
> > To conform to this model, power control must be governed by the
> > Thunderbolt controller's topmost device, which is the upstream bridge.
> > The NHI and downstream bridges go to D3hot independently and the
> > upstream bridge goes to D3cold once all its children have suspended.
> > This commit only adds runtime pm for the upstream bridge.  Runtime pm
> > for the NHI is added in a separate commit to signify its independence.
> > Runtime pm for the downstream bridges is handled by the pcieport driver.
> > 
> > Because Apple's ACPI methods are nonstandard, a struct dev_pm_domain is
> > used to override the PCI bus pm_ops.  The thunderbolt driver binds to
> 
> What are the default PCI bus pm_ops?  I looked briefly for it to see
> if there was some way to use hooks there instead of using
> dev_pm_domain_set() with its weird out-of-orderness.

The default PCI bus pm_ops are defined in drivers/pci/pci-driver.c as
struct dev_pm_ops pci_dev_pm_ops.

I did hook into those callbacks in an earlier version of this series
but it required more patches and more modifications to the PCI core
and PCIe port services driver to get Thunderbolt runpm to work:
https://www.spinics.net/lists/linux-pci/msg51158.html

Using dev_pm_domain_set() is the de facto standard to solve this,
vga_switcheroo does the same, that's why I settled on this approach.
(see drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_init_domain_pm_ops())


> I guess what you do in thunderbolt_power_init() is copy the upstream
> device's bus's ops, then override a few of them?  Seems like we then
> have the problem of keeping the Thunderbolt ones in sync with the
> generic ones, e.g., if something got added to the generic one,
> somebody should look at the Thunderbolt one to see if it's also need
> there?

Not a problem.  upstream_runtime_suspend() essentially does this:

	// call pci_dev_pm_ops ->runtime_suspend hook:
	ret = dev->bus->pm->runtime_suspend(dev);
	// power down:
	acpi_execute_simple_method(power->set, NULL, 0)
	// enable wake interrupt:
	acpi_enable_gpe(NULL, power->wake_gpe)

So any changes to the pci_dev_pm_ops are inherited.  Again,
vga_switcheroo does the same (see vga_switcheroo_runtime_suspend()).


> > +#define pr_fmt(fmt) KBUILD_MODNAME " %s: " fmt, dev_name(dev)
[...]
> > +	/* prevent interrupts during system sleep transition */
> > +	if (ACPI_FAILURE(acpi_disable_gpe(NULL, power->wake_gpe))) {
> > +		pr_err("cannot disable wake GPE, resuming\n");
> 
> Can you use dev_err() here and below?  This is related to a specific
> device, and it'd be nice to know which one.

See above, the device name is included in pr_fmt.  The reason to use
pr_err() instead of dev_err() is to get the error message prefixed
with "thunderbolt" instead of "pcieport".  Recall that this function
is executed in the context of the upstream bridge, whose driver name
is pcieport.  I would like to prevent people from grepping the portdrv
code for the error message.  You're the second person to raise this
question (Andy Shevchenko made the same comment on an earlier version
of this patch), so I've now added a comment to explain it.


> > +void thunderbolt_power_init(struct tb *tb)
> > +{
> > +	struct device *upstream_dev, *nhi_dev = &tb->nhi->pdev->dev;
> > +	struct tb_power *power = NULL;
> 
> Unnecessary initialization.

Good point.

Thanks,

Lukas
