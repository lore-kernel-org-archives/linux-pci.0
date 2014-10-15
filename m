Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbaJOIEh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Oct 2014 04:04:37 -0400
Message-ID: <1413360267.4202.70.camel@ul30vt.home>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Wed, 15 Oct 2014 02:04:27 -0600
In-Reply-To: <5438CC1E.3060407@maya.org>
References: <20140923210318.498dacbd@dualc.maya.org>
	 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>
	 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>
	 <5437F1F5.3010706@maya.org>
	 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>
	 <543804BC.3080307@maya.org>
	 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
	 <20141011003219.560cca97@dualc.maya.org>
	 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2014-10-11 at 08:20 +0200, Andreas Hartmann wrote:
> Bjorn Helgaas wrote:
> > On Sat, Oct 11, 2014 at 12:32:19AM +0200, Andreas Hartmann wrote:
> >> Bjorn Helgaas wrote:
> >>> On Fri, Oct 10, 2014 at 10:09 AM, Andreas Hartmann
> >>> <andihartmann@freenet.de> wrote:
> >>>> Bjorn Helgaas wrote:
> >>>>> On Fri, Oct 10, 2014 at 8:49 AM, Andreas Hartmann
> >>>>> <andihartmann@freenet.de> wrote:
> >>>>>> Bjorn Helgaas wrote:
> >>>>>>> On Fri, Oct 10, 2014 at 3:39 AM, Andreas Hartmann
> >>>>>>> <andihartmann@freenet.de> wrote:
> >>>>>>>> shortly: I retested w/ qemu 2.1.0 and Linux 3.17.0 - no change in behaviour.
> >>>>>>>>
> >>>>>>>> Alex Williamson wrote:
> >>>>>>>>> On Tue, 2014-09-23 at 21:03 +0200, Andreas Hartmann wrote:
> >>>>>>>>>> Hello!
> >>>>>>>>>>
> >>>>>>>>>> Since long time now, I'm using w/o any problem PCIe pass through with a
> >>>>>>>>>> Gigabyte GA-990XA-UD3/GA-990XA-UD3 mainboard (AMD 990X chipset) and
> >>>>>>>>>> enabled IOMMU with vfio-pci.
> >>>>>>>>>>
> >>>>>>>>>> The last kernel working w/o any problem is kernel 3.13.7 (I didn't use
> >>>>>>>>>> .8 and .9, but I do not think they would have been problematic).
> >>>>>>>>>>
> >>>>>>>>>> Since 3.14.19 (I didn't test any 3.14 kernel before) I'm encountering a
> >>>>>>>>>> hard and silent lock up of the complete machine when starting the VM
> >>>>>>>>>> with the PCIe card passed through.
> >>>>>>>
> >>>>>>> Since we're not really making any progress on this yet, would it be
> >>>>>>> possible to bisect it?  We already know that 3.13.7 works and 3.14.19
> >>>>>>> fails, and "git bisect start v3.14 v3.13" says it's about 13 steps.  I
> >>>>>>> know that's still quite a bit of work, but at least it sounds like the
> >>>>>>> problem is easy to reproduce.
> >>>>>>
> >>>>>> Which git repository should I use best?
> >>>>>
> >>>>> The linux-stable repository [1] contains both the v3.13.x and the
> >>>>> v3.14.x branches, but apparently you can't bisect directly between
> >>>>> v3.13.7 and v3.14.19:
> >>>>
> >>>> I know that the first version after 3.13.0 (patch-v3.13-next-20140121)
> >>>> is already broken. Therefore, it must be between 3.13.7 and
> >>>> patch-v3.13-next-20140121.
> >>
> >>
> >> Ok, this is the result of git bisect:
> >>
> >> 425c1b223dac456d00a61fd6b451b6d1cf00d065 is the first bad commit
> >> commit 425c1b223dac456d00a61fd6b451b6d1cf00d065
> >> Author: Alex Williamson <alex.williamson@redhat.com>
> >> Date:   Tue Dec 17 16:43:51 2013 -0700
> >>
> >>     PCI: Add Virtual Channel to save/restore support
> >>     
> >>     While we don't really have any infrastructure for making use of VC
> >>     support, the system BIOS can configure the topology to non-default
> >>     VC values prior to boot.  This may be due to silicon bugs, desire to
> >>     reserve traffic classes, or perhaps just BIOS bugs.  When we reset
> >>     devices, the VC configuration may return to default values, which can
> >>     be incompatible with devices upstream.  For instance, Nvidia GRID 
> >>     cards provide a PCIe switch and some number of GPUs, all supporting 
> >>     VC.  The power-on default for VC is to support TC0-7 across VC0,
> >>     however some platforms will only enable TC0/VC0 mapping across the 
> >>     topology.  When we do a secondary bus reset on the downstream switch 
> >>     port, the GPU is reset to a TC0-7/VC0 mapping while the opposite end 
> >>     of the link only enables TC0/VC0.  If the GPU attempts to use TC1-7, 
> >>     it fails. 
> >>
> >>     This patch attempts to provide complete support for VC save/restore, 
> >>     even beyond the minimally required use case above.  This includes 
> >>     save/restore and reload of the arbitration table, save/restore and 
> >>     reload of the port arbitration tables, and re-enabling of the 
> >>     channels for VC, VC9, and MFVC capabilities. 
> >>
> >>     Signed-off-by: Alex Williamson <alex.williamson@redhat.com> 
> >>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Wow, I'm amazed that you could get that done so fast... you must have spent
> > your whole day working on this!
> 
> If I would have been more familiar with the versioning of the kernels
> and if I would have a faster internet connection and if there wouldn't
> be another bug in systemd, which has bitten me on booting with broken fs
> (but I found a cool workaround now :-)), I would have been much faster:
> my 8 core machine and 8 GB of RAM, where I've been compiling the kernel
> in and my special kernel config (which Im using since 3.10) only
> containing my requests, with parts of the process automated makes it
> possible to have a turn around of ~ 7 minutes :-).
> I too had no problem with reproducibility, because the problem always
> comes up at the start of the vm after 1 or 2 secs.

Hi Andreas,

Sorry for the breakage.  Is it possible to run lspci on the device in a
loop from the host and capture whether we're failing to restore some of
the VC bits to their previous state?  Does the problem also occur if you
unbind from host driver, echo 1 > reset in pci-sysfs, and re-bind to the
host?  I'll also try to reproduce on my 990fx system, but I won't be
able to do that until next week due to travel.  Thanks,

Alex

> > To double-check this, can you try applying the patch below?  It should be
> > enough to make things work if 425c1b223dac is really what's causing the
> > trouble.
> > 
> > This patch is based on v3.17, but 425c1b223dac appeared in v3.14, so you
> > should be able to apply it to v3.14 or any later kernel.
> > 
> > Bjorn
> > 
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 2c9ac70254e2..8ef8bc56a584 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1007,8 +1007,6 @@ int pci_save_state(struct pci_dev *dev)
> >  		return i;
> >  	if ((i = pci_save_pcix_state(dev)) != 0)
> >  		return i;
> > -	if ((i = pci_save_vc_state(dev)) != 0)
> > -		return i;
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(pci_save_state);
> > @@ -1072,7 +1070,6 @@ void pci_restore_state(struct pci_dev *dev)
> >  	/* PCI Express register must be restored first */
> >  	pci_restore_pcie_state(dev);
> >  	pci_restore_ats_state(dev);
> > -	pci_restore_vc_state(dev);
> >  
> >  	pci_restore_config_space(dev);
> >  
> > @@ -2170,8 +2167,6 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
> >  	if (error)
> >  		dev_err(&dev->dev,
> >  			"unable to preallocate PCI-X save buffer\n");
> > -
> > -	pci_allocate_vc_save_buffers(dev);
> >  }
> >  
> >  void pci_free_cap_save_buffers(struct pci_dev *dev)
> > 
> 
> This patch proofed the git bisect result. I applied it to
> patch-v3.13-next-20140122 and the machine worked pretty fine :-).
> 
> 
> Thanks,
> Regards,
> Andreas



