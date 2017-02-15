Return-Path: <SRS0=X9Yn=Z4=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=X9Yn=Z4=h08.hostsharing.net=foo00@kernel.org>
Date: Wed, 15 Feb 2017 13:13:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v6 2/8] PCI: Allow runtime PM on Thunderbolt ports
Message-ID: <20170215121327.GA24838@h08.hostsharing.net>
References: <cover.1486913733.git.lukas@wunner.de>
 <656ca6114612a11469d4f124425437f7ac6803c6.1486913733.git.lukas@wunner.de>
 <20170214203827.GA19040@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170214203827.GA19040@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

[cc += Mika, Rafael]

On Tue, Feb 14, 2017 at 02:38:27PM -0600, Bjorn Helgaas wrote:
> On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
> > PCIe ports are only allowed to go to D3 if the BIOS is dated 2015+ to
> > avoid potential issues with old chipsets.  However for Thunderbolt we
> > know that even the oldest controller, Light Ridge (2010), is able to
> > suspend its ports to D3 just fine.
> > 
> > We're about to add runtime PM for Thunderbolt on the Mac.  Apple has
> > released multiple EFI updates since 2015 but not everyone has installed
> > them (https://support.apple.com/en-us/HT201222).  Those users should
> > still benefit from the achievable power saving.  Thus, special-case
> > Thunderbolt in pci_bridge_d3_possible().
> > 
> > This allows the Thunderbolt controller to power down but the root port
> > to which the Thunderbolt controller is attached remains in D0 unless
> > an EFI update is installed.  Users can pass pcie_port_pm=force on the
> > kernel command line if they cannot install an EFI update but still want
> > to benefit from the additional power saving of putting the root port
> > into D3.  In practice, root ports can be suspended to D3 without issues
> > at least on 2012 Ivy Bridge machines.
> > 
> > If the BIOS cut-off date is ever lowered to 2010 and runtime PM is
> > allowed on all native hotplug ports, the Thunderbolt special case can be
> > removed.
> > 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Andreas Noever <andreas.noever@gmail.com>
> > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > Cc: Amir Levy <amir.jer.levy@intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/pci.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7904d02ffdb9..441083a0d5b0 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2224,7 +2224,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
> >   * @bridge: Bridge to check
> >   *
> >   * This function checks if it is possible to move the bridge to D3.
> > - * Currently we only allow D3 for recent enough PCIe ports.
> > + * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
> >   */
> >  bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >  {
> > @@ -2253,6 +2253,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >  		if (pci_bridge_d3_force)
> >  			return true;
> >  
> > +		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> > +		if (bridge->is_thunderbolt)
> > +			return true;
> 
> Does this whole function connect with anything in a spec?  For
> example, I see how dev->pme_support, pci_pme_capable(), etc., relate
> to PCI_PM_PMC in the PM Capability (PCI PM r1.1, sec 3.2.3).  But I'm
> not a PM guy, so I'm kind of at a loss to see how
> pci_bridge_d3_possible() is related to that.

No, this function does not connect with anything in a spec but rather
encodes policy:

pci_bridge_d3_possible() determines whether runtime PM is allowed on a
PCIe port *at all*.  This is used to activate runtime PM on the port
(or not) in drivers/pci/pcie/portdrv_pci.c:pcie_portdrv_probe().
It is also used to initially set a pci_dev's ->bridge_d3 flag on probe
in drivers/pci/pci.c:pci_pm_init().  If this function returns false,
the port will never ever runtime suspend.  So right now "false" is the
default, and "true" is only returned if the BIOS is dated 2015+ or
pcie_port_pm=force is passed on the command line.  This patch allows
runtime PM on ports with is_thunderbolt set, i.e. on Thunderbolt
controllers and on PCIe switches on a Thunderbolt daisy chain.
(E.g. my external Thunderbolt chassis contains a PLX 8613 switch,
but I've verified that those ports runtime suspend and resume just fine.)

pci_dev_check_d3cold() determines whether a pci_dev blocks runtime PM
on its parent ports.  Unlike pci_bridge_d3_possible(), the return value
can change over time, e.g. because the user allowed or disallowed D3cold
via sysfs.  This function contains a mix of policy-driven conditions and
stuff mandated by the spec (e.g. the pci_dev is wakeup capable but not
from D3cold, so it has to block its parents from going to D3hot as it's
effectively in D3cold then).


> I guess I'm just unclear on the purpose of pci_bridge_d3_possible().
> The comment says "is it possible to move the bridge to D3".  I would
> have expected that to involve PCI_PM_PMC and other questions of what
> the hardware can do.  But I can't connect the dots.

That happens later when the port actually runtime suspends:

pci_pm_runtime_suspend
  pci_finish_runtime_suspend

This determines the appropriate power state, enables PME, etc.

Obviously if pci_bridge_d3_possible() returns false or one of the port's
children blocks runtime PM via pci_dev_check_d3cold(), the port will
never get this far.


> My larger question is about dev->is_thunderbolt.  After the previous
> patch, every device downstream of a Thunderbolt controller will be
> marked "is_thunderbolt".  If I understand correctly, a downstream
> device could be an arbitrary PCIe device totally unrelated to
> Thunderbolt except that some upstream bridge is a Thunderbolt device.

That is correct.  It allows quirks for devices which happen to be part
of a Thunderbolt daisy chain (e.g. not registering with vga_switcheroo
for Thunderbolt eGPUs) among other things (see the three use cases listed
in the changelog of patch [1/8]).

Thanks,

Lukas
