Return-Path: <SRS0=Ttdp=7F=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=Ttdp=7F=intel.com=keith.busch@kernel.org>
Date: Wed, 2 Aug 2017 23:59:24 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pciehp: Enable hot plug capable detection
Message-ID: <20170803035924.GB13257@localhost.localdomain>
References: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
 <20170802173249.GB20308@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802173249.GB20308@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 02, 2017 at 12:32:49PM -0500, Bjorn Helgaas wrote:
> Hi Keith,
> 
> On Wed, Aug 02, 2017 at 01:15:07AM -0400, Keith Busch wrote:
> > The PCIe specification ties presence detect change enabling to the hot plug
> > capable bit in Slot Capabilities. This capability is not mutally exclusive
> > with attention buttons, so enabing detection should not be tied it.
> 
> Can you clarify this a little?
> 
>   - Please include the spec section you're referring to.
> 
>   - I'm not sure what "This capability is not ..." refers to.  There
>     is not a "presence detect change enabling" capability.  I agree
>     that the "Hot-Plug Capable" bit is independent of the "Attention
>     Button Present" bit.
> 
>   - Slot Control (PCIe r3.1, sec 7.8.10) says PDCE *is permitted* to
>     be read-only zero if PCI_EXP_SLTCAP_HPC is zero.  It doesn't say
>     PDCE is *required* to be read-only in that case.
> 
> My initial reaction is that it probably makes sense per the spec to
> enable PDCE unconditionally, but I would want to do some archaeology
> to figure out why it wasn't that way from the beginning.  There's
> probably some reason for it being the way it is, so we have to take
> that into account.  Maybe it works around some flaky presence detect
> hardware or something.

Thanks for the feedback. I can definitely make the commit message better
if that's the only concern.

The part of the specification that suggests PDCE is tied to the hotplug
capable bit is the "Slot Control Register" section in 7.8.10 of PCIe
Base spec rev4. Specifically:

  "If the Hot-Plug Capable bit in the Slot Capabilities register is 0b,
   this bit is permitted to be read-only with a value of 0b"

So this control doesn't do anything if hotplug capable is not set.

The only reference I find on why the code is currently done this way is
from this thread:

  https://marc.info/?l=linux-kernel&m=138688828930718&w=2

It seems the current behavior was done this way as a hunch more than
anything emperical.

The problem I'm trying to solve, though, is with a real platform
that supports hot-add. The reason it is currently broken with Linux
is because this platform advertises "Attention Button Present" when
in fact no physical button exists on the platform. Since the kernel
doesn't enable presence detect change events when attention button
present is set, we don't get hot-add events. We've been working around
this by using pciehp_poll_mode=1, but we'd prefer to see this working
without kernel parameters.

> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/pci/hotplug/pciehp.h     | 1 +
> >  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> > index 06109d4..610e295 100644
> > --- a/drivers/pci/hotplug/pciehp.h
> > +++ b/drivers/pci/hotplug/pciehp.h
> > @@ -120,6 +120,7 @@ struct controller {
> >  #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
> >  #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
> >  #define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
> > +#define HP_CAP(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
> >  #define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
> >  #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
> >  #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index 026830a..43a86ed 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -691,7 +691,7 @@ void pcie_enable_notification(struct controller *ctrl)
> >  	cmd = PCI_EXP_SLTCTL_DLLSCE;
> >  	if (ATTN_BUTTN(ctrl))
> >  		cmd |= PCI_EXP_SLTCTL_ABPE;
> > -	else
> > +	if (HP_CAP(ctrl))
> >  		cmd |= PCI_EXP_SLTCTL_PDCE;
> >  	if (!pciehp_poll_mode)
> >  		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
> > -- 
> > 2.5.5
> > 
