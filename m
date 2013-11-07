Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63780 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690Ab3KGV7V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2013 16:59:21 -0500
Received: by mail-ie0-f178.google.com with SMTP id to1so138544ieb.9
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2013 13:59:21 -0800 (PST)
Date: Thu, 7 Nov 2013 14:59:18 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Nishank Trivedi <nistrive@cisco.com>
Subject: Re: [PATCH] PCI: Use pci_is_root_bus() to check for root bus
Message-ID: <20131107215918.GC2955@google.com>
References: <20131105232903.3790.8738.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQX74B32iD2LAaWxwOAH62YAFWkt2=hK9pVDCDUnfrEaNw@mail.gmail.com>
 <20131106181558.GA14444@google.com>
 <20131107030054.GA11245@weiyang.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20131107030054.GA11245@weiyang.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 07, 2013 at 11:00:54AM +0800, Wei Yang wrote:
> On Wed, Nov 06, 2013 at 11:15:58AM -0700, Bjorn Helgaas wrote:
> >[+cc Nishank]
> >
> >On Tue, Nov 05, 2013 at 07:39:10PM -0800, Yinghai Lu wrote:
> >> On Tue, Nov 5, 2013 at 3:29 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> > pci_enable_device_flags() and pci_enable_bridge() assume that
> >> > "bus->self == NULL" means that "bus" is a root bus.  That assumption is
> >> > false; see 2ba29e270e97 ("PCI: Use pci_is_root_bus() to check for root
> >> > bus") for details.
> >> >
> >> > This patch changes them to use pci_is_root_bus() instead.
> >> >
> >> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >> > ---
> >> >  drivers/pci/pci.c |    9 ++++-----
> >> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> > index ac40f90..de65bf7 100644
> >> > --- a/drivers/pci/pci.c
> >> > +++ b/drivers/pci/pci.c
> >> > @@ -1150,10 +1150,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
> >> >  {
> >> >         int retval;
> >> >
> >> > -       if (!dev)
> >> > -               return;
> >> > -
> >> 
> >> May need to keep this checking.
> >> 
> >> virtual bus (for sriov virtual function) could have bus->self == NULL.
> >
> >Ah, you're right, thanks!  When "dev" is a VF, "dev->bus->self" may be
> >NULL.  If we call pci_enable_device() on a VF, "dev->bus" is not a root
> >bus, so we'll call pci_enable_bridge(dev->bus->self) when
> >"dev->bus->self" is NULL, so we'll dereference a NULL pointer.
> >
> >But currently we just return when "dev == NULL", and I think that masks
> >a deeper problem: what if we enable IOV but never call
> >pci_enable_device(PF)?  In that case, the upstream bridge may not be
> >enabled, and when we call pci_enable_device(VF), we'll do nothing, so
> >the upstream bridge remains disabled.
> >
> >I didn't see anywhere the core requires the PF to be enabled before IOV
> >is enabled.  I checked all the current callers of pci_enable_sriov(),
> >and they all call pci_enable_device(PF) first.  But I don't think
> >anything *prevents* a driver from calling pci_enable_sriov(PF) without
> >doing pci_enable_device(PF).
> >
> >Or the PCI core could enable VFs even with no driver attached, e.g., if
> >we called pci_enable_sriov() from sriov_numvfs_store() (for the sysfs
> >"sriov_numvfs" file).  We talked about that a bit at the PCI miniconf in
> >New Orleans.  IIRC, there are some Cisco boxes where the firmware
> >enables IOV, so the VFs are enabled before Linux even sees the PF, and a
> >driver could bind to a VF and do pci_enable_device(VF) even if there's
> >no PF driver at all.  If that VF is on a virtual bus, we won't enable
> >the upstream bridge, and the VF may not work.
> >
> >What do you think of the patches below?
> >
> 
> Thanks Bjorn, this is really a potential problme. And your patches fix this
> problem.
> 
> While I did a small change on the seconde one like this. Hope you like it :-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bdd64b1..8d0ce48 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1153,7 +1153,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
>         if (!dev)
>                 return;
>  
> -       pci_enable_bridge(dev->bus->self);
> +       pci_enable_bridge(pci_upstream_bridge(dev));
>  
>         if (pci_is_enabled(dev)) {
>                 if (!dev->is_busmaster) {
> @@ -1190,7 +1190,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>         if (atomic_inc_return(&dev->enable_cnt) > 1)
>                 return 0;               /* already enabled */
>  
> -       pci_enable_bridge(dev->bus->self);
> +       pci_enable_bridge(pci_upstream_bridge(dev));
>  
>         /* only skip sriov related */
>         for (i = 0; i <= PCI_ROM_RESOURCE; i++)

Thanks for looking at these.  I think the latest version (the ones
acked by Yinghai) do basically what you're suggesting.

> BTW, pci_enable_bridge() is only called in pci_enable_device_flags(). After
> change in these two patches, we pass a 'upstream bridge' to
> pci_enable_bridge(). I am not sure whether this 'upstream bridge' could be a
> VF? I took a look at the SPEC again, but not find clear clause.
> 
> In case the 'upstream bridge' is always a PF, maybe we could simplize the
> logic in pci_enable_bridge(). While current logic is reasonable and clear.

I doubt it's possible for a VF to be a bridge, but I don't think
there's really any reason to build that assumption into the code
here.

Bjorn
