Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Fri, 11 Nov 2016 07:44:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Check for PCIe capabilities change after
 resume
Message-ID: <20161111064417.GA8178@wunner.de>
References: <20161110185520.19461.9789.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161110231808.GA8155@wunner.de>
 <20161111002448.GC12055@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161111002448.GC12055@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2016 at 06:24:48PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 11, 2016 at 12:18:08AM +0100, Lukas Wunner wrote:
> > On Thu, Nov 10, 2016 at 12:55:20PM -0600, Bjorn Helgaas wrote:
> > > Len Brown reported that resume on a Dell XPS11 laptop takes longer than it
> > > should.  The delay is caused by pciehp scanning for a device below a Root
> > > Port that has nothing connected to it.
> > > 
> > > At boot-time, the 00:1c.0 Root Port's PCI Express Capabilities Register
> > > (PCIe spec r3.0, sec 7.8.2) advertises a slot (PCI_EXP_FLAGS_SLOT is set),
> > > so pciehp claims the port.
> > > 
> > > At resume-time, PCI_EXP_FLAGS_SLOT is clear, so the Root Port no longer
> > > advertises a slot.  But pciehp doesn't notice that change, and it reads
> > > Slot Status to see if anything changed.  Slot Status says a device is
> > > present (Ports not connected to slots are required to report "Card Present"
> > > per sec 7.8.11), so pciehp tries to bring up the link and scan for the
> > > device, which accounts for the delay.
> > > 
> > > Per sec 7.8.2, the PCIe Capabilities Register is all read-only, so I
> > > think the fact that it changes between boot- and resume-time is a
> > > firmware defect.
> > > 
> > > Work around this by re-reading the Capabilites at resume-time and updating
> > > the cached copy in pci_dev->pcie_flags_reg.  Then stop using pciehp on the
> > > port if it no longer advertises a slot.
> > > 
> > > Reported-and-tested-by: Len Brown <lenb@kernel.org>
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=99751
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
[snip]
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index 1ccce1c..fe8e964 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -505,7 +505,20 @@ static int pci_restore_standard_config(struct pci_dev *pci_dev)
> > >  
> > >  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
> > >  {
> > > +	u16 flags;
> > > +
> > >  	pci_power_up(pci_dev);
> > > +
> > > +	if (pci_dev->pcie_cap) {
> > > +		pci_read_config_word(pci_dev, pci_dev->pcie_cap + PCI_EXP_FLAGS,
> > > +				     &flags);
> > > +		if (pci_dev->pcie_flags_reg != flags) {
> > > +			dev_info(&pci_dev->dev, "PCIe Capabilities was %#06x, is %#06x after resume (possible firmware defect)\n",
> > > +				 pci_dev->pcie_flags_reg, flags);
> > > +			pci_dev->pcie_flags_reg = flags;
> > > +		}
> > > +	}
> > > +
> > 
> > Is there a reason that this must happen at ->resume_noirq time rather than
> > ->resume time?
> 
> PM is black magic to me.  I put it here because Rafael said
> pci_power_up() is called for every PCI device during resume.  Possibly
> another location would make more sense (please suggest one, if so).

I think Rajat Jain had the right idea to put this in a quirk.
A port losing the slot capability over system sleep seems like
a total anomaly and nothing that we should need to worry about
in regular PCI code.

By setting the is_hotplug_bridge to false, pciehp can be prevented
from binding to this port in the first place.

That quirk needs to be executed after is_hotplug_bridge is set
and before pciehp_resume() is called for the first time. This
simple one-liner might already be sufficient, there's already a
quirk_hotplug_bridge() function in quirks.c, this could go right
next to it:


/*
 * Intel Haswell-ULT root port 1 loses slot capability over system sleep,
 * causing pciehp to fail on resume.
 */
static void quirk_no_hotplug_bridge(struct pci_dev *dev)
{
	dev->is_hotplug_bridge = 0;
}
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9c10, quirk_no_hotplug_bridge);


> I'm a little gun-shy because as far as I can tell, this bit isn't
> supposed to change, and I don't know what *else* might change.  We'd
> be totally hosed if the Device/Port Type changed, so I guess we don't
> have to worry about that.  The Interrupt Message Number is nominally
> RO, but hardware is explicitly required to update it in some cases, so
> I could imagine it changing at resume, and I guess we should check how
> we use that.
> 
> But you're a PM expert so maybe you can answer this:
> PCI_EXP_FLAGS_SLOT is "HwInit" and per spec, can only be reset by a
> Fundamental Reset.  Does a suspend/resume involve a Fundamental Reset?

If the machine went into S3 then I'd say yes because power went away and
is reapplied.

However Linux also supports "suspend-to-idle", i.e. all devices are
put into D3 but the machine isn't suspended using the platform.
When resuming from suspend-to-idle, the devices just return to D0
and there's no reset.  The same ->suspend and ->resume hooks are
executed regardless if the machine is going to suspend-to-idle or
S3.

To me this looks like an erratum of this Haswell-ULT revision (the port
has revision e4) wherein the slot capability bit is set incorrectly
after platform suspend.  However to know for sure you'd have to ask an
Intel hardware engineer how the config space is populated when the
system is initially powered up versus resumes from S3.

Best regards,

Lukas
