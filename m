Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934023AbaJ3Q60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 12:58:26 -0400
Message-ID: <1414688299.27420.292.camel@ul30vt.home>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Thu, 30 Oct 2014 10:58:19 -0600
In-Reply-To: <545268E8.3080107@maya.org>
References: <20140923210318.498dacbd@dualc.maya.org>
									 <543804BC.3080307@maya.org>
									 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
									 <20141011003219.560cca97@dualc.maya.org>
									 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>
									 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>
									 <1413925580.4202.189.camel@ul30vt.home>
								 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>
							 <1414010215.4202.275.camel@ul30vt.home> <54492606.5090308@maya.org>
						 <1414082022.27420.39.camel@ul30vt.home> <54493BFA.8010609@maya.org>
					 <1414093023.27420.40.camel@ul30vt.home> <544B3D14.70907@maya.org>
				 <1414533068.27420.226.camel@ul30vt.home> <54511A16.30602@maya.org>
			 <1414604677.27420.263.camel@ul30vt.home> <54512A91.2010606@maya.org>
		 <1414606581.27420.266.camel@ul30vt.home>
		 <20141029204344.61d5fc73@dualc.maya.org>
	 <1414615824.27420.281.camel@ul30vt.home> <545268E8.3080107@maya.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-10-30 at 17:35 +0100, Andreas Hartmann wrote:
> Alex Williamson wrote:
> > On Wed, 2014-10-29 at 20:43 +0100, Andreas Hartmann wrote:
> [...]
> >> Therefore, I never should need pci_save_vc_state and
> >> pci_restore_vc_state. Thus, it should be ok to add "return" at the
> >> beginning of each of these function, true? Then it should work.
> >>
> >> I tested it. It worked.
> >>
> >> But if I'm removing only one of these returns either in
> >> pci_save_vc_state or pci_restore_vc_state, the machine hangs again.
> >>
> >> Therefore, there must be something odd going on in the for loops. Isn't
> >> it possible to add some useful debug code to these loops to see what's
> >> really going on? But the output *must* go to the actual console,
> >> otherwise I can't see it!
> >>
> >>
> >> int pci_save_vc_state(struct pci_dev *dev)
> >> {
> >>         return 0; // must be set
> >>         int i;
> >>
> >>         for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
> 		   // continue; -> works
> >>                 int pos, ret;
> >>                 struct pci_cap_saved_state *save_state;
> 		   // continue does not work!
> 
> --> Most probably the
> 
>             struct pci_cap_saved_state *save_state;
> 
>     makes the system hang!

We've done nothing more than declare variables there, there's no actual
code.  What happens if you increase the delay after bus reset, edit
drivers/pci/pci.c, find the call to ssleep(1) and change the 1 to a 2,
doubling the delay after reset.  It seems like VC save/restore is just a
scapegoat for the platform already being broken by the bus reset.  Also,
if you have any other card to test in this slot, it would be useful
comparison data to know if we're dealing with an endpoint issue or a bus
issue.

>   ARRAY_SIZE(vc_caps) is 3 and the whole
>     function is called 3 times when starting the vm.

Sounds right.  The array is declared right above these functions and has
entries for VC, VC9, and MFVC types.  VFIO will try to reset the device
when it's initially opened and then QEMU does it twice (for some
reason), so that makes 3.  Thanks,

Alex

> >>
> >>                 pos = pci_find_ext_capability(dev, vc_caps[i].id);
> >>                 if (!pos || !pci_vc_needs_save(dev, vc_caps[i].id))
> >>                         continue;
> > 
> > Take the next logical step, comment out the if here and we'll statically
> > take the continue.  Does it still fail?  If so, move the continue above
> > the call to pci_find_ext_capability(), if not...
> > 
> >>
> >>                 save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > 
> > If not, add a continue; here.  Unless my pci_vc_needs_save() function is
> > broken, we shouldn't be getting here anyway.
> > 
> >>                 if (!save_state) {
> >>                         dev_err(&dev->dev, "%s buffer not found in %s\n",
> >>                                 vc_caps[i].name, __func__);
> >>                         return -ENOMEM;
> >>                 }
> >>
> >>                 printk("%s doing %s save on %s\n", __func__, vc_caps[i].name, pci_name(dev));
> >>                 ret = pci_vc_do_save_buffer(dev, pos, save_state, true);
> >>                 if (ret) {
> >>                         dev_err(&dev->dev, "%s save unsuccessful %s\n",
> >>                                 vc_caps[i].name, __func__);
> >>                         return ret;
> >>                 }
> >>         }
> >>
> >>         return 0;
> >> }
> >>
> >>
> >> void pci_restore_vc_state(struct pci_dev *dev)
> >> {
> >>         return; // must be set
> >>         int i;
> >>
> >>         for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
> >>                 int pos;
> >>                 struct pci_cap_saved_state *save_state;
> >>
> >>                 pos = pci_find_ext_capability(dev, vc_caps[i].id);
> >>                 save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> > 
> > This should never find a save_state with the pci_vc_needs_save() patch,
> > so we should always take the branch below.  Comment out the if (... and
> > leave the continue, does the behavior change?  If so, add a continue;
> > line above pci_find_saved_ext_cap(), does it work?  If not, add another
> > continue above pci_find_ext_capability().
> > 
> >>                 if (!save_state || !pos)
> >>                         continue;
> >>
> >>                 printk("%s doing %s restore on %s\n", __func__, vc_caps[i].name, pci_name(dev));
> >>                 pci_vc_do_save_buffer(dev, pos, save_state, false);
> >>         }
> >> }
> > 
> > In the "working" case with Bjorn's patch, are you actually trying to use
> > the device or just testing to see if the system survives reset?  You
> > might at least want to run lspci -xxxx on it after reset to make sure
> > it's really there.  Thanks,
> > 
> > Alex
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



