Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42652 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbaJ2Uug (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Oct 2014 16:50:36 -0400
Message-ID: <1414615824.27420.281.camel@ul30vt.home>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Wed, 29 Oct 2014 14:50:24 -0600
In-Reply-To: <20141029204344.61d5fc73@dualc.maya.org>
References: <20140923210318.498dacbd@dualc.maya.org>
								 <5437F1F5.3010706@maya.org>
								 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-29 at 20:43 +0100, Andreas Hartmann wrote:
> Alex Williamson wrote:
> > On Wed, 2014-10-29 at 18:57 +0100, Andreas Hartmann wrote:
> >> Alex Williamson wrote:
> >>> On Wed, 2014-10-29 at 17:47 +0100, Andreas Hartmann wrote:
> >>>> Alex Williamson wrote:
> >>>>> On Sat, 2014-10-25 at 08:03 +0200, Andreas Hartmann wrote:
> >>>>>>
> >>>>>> Out of interest:
> >>>>>> Bjorn's patch disables vc save/restore support - and the machine works
> >>>>>> fine again. Why is it needed at all if it seems to work perfectly w/o
> >>>>>> it? What's the additional benefit? Or in other words: What am I missing
> >>>>>> until today :-) ? What would be better? What could I do more?
> >>>>>
> >>>>>
> >>>>> You're right, in the configuration you have the endpoint device has a
> >>>>> Virtual Channel capability but the upstream root port does not.  The
> >>>>> spec is not at all clear about defining the endpoints for enabling
> >>>>> Virtual Channel in each type of configuration, but I think that if we
> >>>>> have an upstream port that does not support Virtual Channel, we can skip
> >>>>> the save/restore.  Please test the patch below.
> >>>>>
> >>>>> I'm also still completely confused about whether this is a VC
> >>>>> save/restore issue or a bus reset issue.  You originally bisected this
> >>>>> back to the VC save/restore patch, but you also found that a manual,
> >>>>> setpci-based bus reset triggered a system hang.
> >>>>
> >>>> With your additional patch posted here:
> >>>> http://article.gmane.org/gmane.linux.kernel.pci/36162
> >>>
> >>> Right, a reset via sysfs also triggered it with that patch, but the
> >>> reset via setpci is independent of any VC save/restore and still hung
> >>> your box.
> >>>
> >>>>
> >>>>>  I believe that
> >>>>> re-ordering the kernel reset mechanisms also triggered this.  Since
> >>>>> recent versions of QEMU are going to favor a bus reset over PM reset, I
> >>>>> don't have a lot of confidence that we're actually solving the problem
> >>>>> for you.  Please make sure to test with a recent QEMU to be sure we'll
> >>>>> do a bus reset.
> >>>>
> >>>> I'm running qemu 2.1.0 (newest is 2.1.2 - but this shouldn't be a
> >>>> problem) and tested w/ linux 3.17.
> >>>
> >>> Yep, just want to make sure it's QEMU new enough to do a bus reset and
> >>> kernel with matching support.
> >>>
> >>>>> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> >>>>> index 7e1304d..6d13d34 100644
> >>>>> --- a/drivers/pci/vc.c
> >>>>> +++ b/drivers/pci/vc.c
> >>>>> @@ -339,6 +339,25 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
> >>>>>  	return buf ? 0 : len;
> >>>>>  }
> >>>>>  
> >>>>> +/**
> >>>>> + * pci_vc_needs_save - Determine whether a VC capability needs to be saved
> >>>>> + * @dev: device
> >>>>> + * @id: VC capability ID (VC/VC9/MFVC)
> >>>>> + *
> >>>>> + * In configurations where we have a VC or MFVC capability, but the upstream
> >>>>> + * device does not, we assume that VC save (and therefore restore) is not
> >>>>> + * necessary.  The intention is to only do VC save/restore in configuration
> >>>>> + * where it's necessary and hopefully avoid reset issues.
> >>>>> + */
> >>>>> +static bool pci_vc_needs_save(struct pci_dev *dev, u16 id)
> >>>>> +{
> >>>>> +	if (id == PCI_EXT_CAP_ID_VC9 || pci_is_root_bus(dev->bus) ||
> >>>>> +	    pci_find_ext_capability(dev->bus->self, PCI_EXT_CAP_ID_VC))
> >>>>> +		return true;
> >>>>> +
> >>>>> +	return false;
> >>>>> +}
> >>>>> +
> >>>>>  static struct {
> >>>>>  	u16 id;
> >>>>>  	const char *name;
> >>>>> @@ -362,7 +381,7 @@ int pci_save_vc_state(struct pci_dev *dev)
> >>>>>  		struct pci_cap_saved_state *save_state;
> >>>>>  
> >>>>>  		pos = pci_find_ext_capability(dev, vc_caps[i].id);
> >>>>> -		if (!pos)
> >>>>> +		if (!posi || !pci_vc_needs_save(dev, vc_caps[i].id))
> >>>>                         ^
> >>>> This should be most probably !pos (and not !posi - because !posi does
> >>>> through a compile error).
> >>>
> >>> Oops, sorry.
> >>>
> >>>>>  			continue;
> >>>>>  
> >>>>>  		save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);
> >>>>> @@ -422,7 +441,7 @@ void pci_allocate_vc_save_buffers(struct pci_dev *dev)
> >>>>>  	for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
> >>>>>  		int len, pos = pci_find_ext_capability(dev, vc_caps[i].id);
> >>>>>  
> >>>>> -		if (!pos)
> >>>>> +		if (!pos || !pci_vc_needs_save(dev, vc_caps[i].id))
> >>>>>  			continue;
> >>>>>  
> >>>>>  		len = pci_vc_do_save_buffer(dev, pos, NULL, false);
> >>>>
> >>>> W/ the above patch, the machine hangs again (w/ qemu and setpci), but w/
> >>>> Bjorn's patch (and nothing more applied) which disables vc save/restore,
> >>>> the machine just works fine ... . I especially retested this case to be
> >>>> really sure. I'm so sorry. But that's how it behaves here :-(
> >>>
> >>> Hmm, the intention was that this should effectively do the same thing as
> >>> Bjorn's patch.  The Atheros device (03:00.0) reports a VC capability but
> >>> the root port above it (00:05.0) does not.
> >>
> >> Are you sure, that this patch really works (-> here!) as expected? Would
> >> it be possible to add some debug output printing to the actual console
> >> (not to log file) to be sure it really works as expected? Maybe some
> >> more output to get an idea what's actually going on? Or is it just a
> >> timing issue?
> > 
> > Sure, here's some added printks (and fixed posi).  You should be able to
> > run 'dmesg | grep pci_vc_needs_save' after boot and see device
> > 0000:03:00.0.  Hopefully you won't see the pci_save_vc_state() printk as
> > you assign the device.
> 
> [...]
> 
> I'm getting the expected output:
> 
> [    1.156857] pci_vc_needs_save(0000:03:00.0, 2) returning false
> [    1.158866] pci_vc_needs_save(0000:04:00.0, 2) returning false
> 
> This is most probably triggered by pci_allocate_vc_save_buffers, true?

Yes, it will be done at device discovery.

> Therefore, I never should need pci_save_vc_state and
> pci_restore_vc_state. Thus, it should be ok to add "return" at the
> beginning of each of these function, true? Then it should work.
> 
> I tested it. It worked.
> 
> But if I'm removing only one of these returns either in
> pci_save_vc_state or pci_restore_vc_state, the machine hangs again.
> 
> Therefore, there must be something odd going on in the for loops. Isn't
> it possible to add some useful debug code to these loops to see what's
> really going on? But the output *must* go to the actual console,
> otherwise I can't see it!
> 
> 
> int pci_save_vc_state(struct pci_dev *dev)
> {
>         return 0; // must be set
>         int i;
> 
>         for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
>                 int pos, ret;
>                 struct pci_cap_saved_state *save_state;
> 
>                 pos = pci_find_ext_capability(dev, vc_caps[i].id);
>                 if (!pos || !pci_vc_needs_save(dev, vc_caps[i].id))
>                         continue;

Take the next logical step, comment out the if here and we'll statically
take the continue.  Does it still fail?  If so, move the continue above
the call to pci_find_ext_capability(), if not...

> 
>                 save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);

If not, add a continue; here.  Unless my pci_vc_needs_save() function is
broken, we shouldn't be getting here anyway.

>                 if (!save_state) {
>                         dev_err(&dev->dev, "%s buffer not found in %s\n",
>                                 vc_caps[i].name, __func__);
>                         return -ENOMEM;
>                 }
> 
>                 printk("%s doing %s save on %s\n", __func__, vc_caps[i].name, pci_name(dev));
>                 ret = pci_vc_do_save_buffer(dev, pos, save_state, true);
>                 if (ret) {
>                         dev_err(&dev->dev, "%s save unsuccessful %s\n",
>                                 vc_caps[i].name, __func__);
>                         return ret;
>                 }
>         }
> 
>         return 0;
> }
> 
> 
> void pci_restore_vc_state(struct pci_dev *dev)
> {
>         return; // must be set
>         int i;
> 
>         for (i = 0; i < ARRAY_SIZE(vc_caps); i++) {
>                 int pos;
>                 struct pci_cap_saved_state *save_state;
> 
>                 pos = pci_find_ext_capability(dev, vc_caps[i].id);
>                 save_state = pci_find_saved_ext_cap(dev, vc_caps[i].id);

This should never find a save_state with the pci_vc_needs_save() patch,
so we should always take the branch below.  Comment out the if (... and
leave the continue, does the behavior change?  If so, add a continue;
line above pci_find_saved_ext_cap(), does it work?  If not, add another
continue above pci_find_ext_capability().

>                 if (!save_state || !pos)
>                         continue;
> 
>                 printk("%s doing %s restore on %s\n", __func__, vc_caps[i].name, pci_name(dev));
>                 pci_vc_do_save_buffer(dev, pos, save_state, false);
>         }
> }

In the "working" case with Bjorn's patch, are you actually trying to use
the device or just testing to see if the system survives reset?  You
might at least want to run lspci -xxxx on it after reset to make sure
it's really there.  Thanks,

Alex

