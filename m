Return-Path: <SRS0=ea3o=7G=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=ea3o=7G=intel.com=keith.busch@kernel.org>
Date: Thu, 3 Aug 2017 23:46:31 -0400
From: Keith Busch <keith.busch@intel.com>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] pciehp: Enable hot plug capable detection
Message-ID: <20170804034631.GB478@localhost.localdomain>
References: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
 <20170802173249.GB20308@bhelgaas-glaptop.roam.corp.google.com>
 <20170803035924.GB13257@localhost.localdomain>
 <20170803201034.GW20308@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6FF_T7yc86_vc=carnp1N9XyNk_tYHrvaVGekTf8hf+jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACK8Z6FF_T7yc86_vc=carnp1N9XyNk_tYHrvaVGekTf8hf+jA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 04:00:18PM -0700, Rajat Jain wrote:
> 
> I think we should think about what events do we want to actually
> *trigger* the hot-plug, and is presence detect one of them. In other
> words, can we assume that the card is ready to be scanned as soon as
> it is inserted, even on platforms that do advertise an attention
> button? May be these are remote corner cases and don't make any sense
> (have a very good imagination ;-):
> 
> * Could the device be powered externally, and the operator needs to
> still turn it on after plugging it in?
> * Could there be a need for the operator to wait on something after
> plugging in, before it gives a go ahead to the host to start scanning?
> (wait until device has loaded some firmware, some device LED blinked
> or things like that).
> 
> AFAICT, the attention button was precisely meant for holding off host
> scanning until the operator believes the device is ready for it.
> Today, pciehp would wait for 5 seconds after attention button press
> before actually starting hotplug, thus giving the operator a chance to
> press the attention button again to cancel the operation:
> 
>         case BLINKINGOFF_STATE:
>         case BLINKINGON_STATE:
>                 /*
>                  * Cancel if we are still blinking; this means that we
>                  * press the attention again before the 5 sec. limit
>                  * expires to cancel hot-add or hot-remove
>                  */
> 
> Now I don't recall where (I checked PCIe spec and PCI hotplug spec)
> but I recall reading a documented sequence of steps for hotplug in
> some sort of spec, which is what pciehp seemed to mimic. So I believe
> if we enabled presence detect to start hotplug immediately
> unconditionally, there might be dead code left. Also, I'm wondering
> are we going to render the attention button useless for hotplug
> addition scenario (this will change the behavior for platforms that
> currently use attention button correctly)?

I was thinking a real attention button would suppress presence detect,
but I'm sure now that's not always the case. I'm starting to think
the user's process for this particular platform may need to be altered
(details below).

> >  There's
> >> > probably some reason for it being the way it is, so we have to take
> >> > that into account.  Maybe it works around some flaky presence detect
> >> > hardware or something.
> 
> YInghai seemed to have seen some:
> https://patchwork.ozlabs.org/patch/170489/
> 
> >>
> >> Thanks for the feedback. I can definitely make the commit message better
> >> if that's the only concern.
> >>
> >> The part of the specification that suggests PDCE is tied to the hotplug
> >> capable bit is the "Slot Control Register" section in 7.8.10 of PCIe
> >> Base spec rev4. Specifically:
> >>
> >>   "If the Hot-Plug Capable bit in the Slot Capabilities register is 0b,
> >>    this bit is permitted to be read-only with a value of 0b"
> >>
> >> So this control doesn't do anything if hotplug capable is not set.
> >
> > I thought that might be the part of the spec you were referring to,
> > but that's not how I read it :)  I read sec 7.8.10 as saying:
> >
> >   - Presence Detect Changed Enable is a read/write bit,
> >   - However, if Hot-Plug Capable (a HwInit/read-only bit) is 0,
> >     PDCE may be a read-only 0 (OR it may be read/write)
> >
> > So I think it's slightly misleading to suggest that PDCE is "tied" to
> > HPC.  I think the spec allows PDCE to be read/write and to have some
> > effect, even if HPC is 0.
> >
> > I don't know what it would *mean* to have a slot that said "I don't
> > support hot-plug operations, but my Presence Detect State might
> > change".  We've seen some creative uses of pciehp, so I wouldn't be
> > surprised if somebody dreamed up a way to use it.
> >
> >> The only reference I find on why the code is currently done this way is
> >> from this thread:
> >>
> >>   https://marc.info/?l=linux-kernel&m=138688828930718&w=2
> >>
> >> It seems the current behavior was done this way as a hunch more than
> >> anything emperical.
> 
> Essentially the reason it was done is the assumption that if attention
> button is present, then it is left on the operator to let us know when
> to initiate the hot plug.
> 
> One question, does your platform advertise surprise removal
> capability? If so, then I think a better way to enable PDCE is if
> surprise removal is supported, this was also suggested by Yinghai one
> time:
>
> From: https://lkml.org/lkml/2013/12/13/433:
> > > I suggest that link event handling will be enabled automatically when
> > > attention button is not there and surprise removal is supported.
> 
> May be we can do something like:
> 
> if (suprise_removal_supported || !attention_button_present)
>      enable PDCE

Surprise removal is not supported. These do have Power Controller Control,
though, and the user is supposed to power off the slot first like this:

  echo 0 > /sys/bus/pci/slot/<slot>/power

Then they can manually remove the device safely. They don't always do
that, though, and it seems surprise yanks happen to work, but I doubt
that's 100% safe.

Their expectation for hot add was that the kernel would handle it without
the manual power control, and maybe that's not a valid expectation with
this hardware even though it appears to work with my patch.

After reading all this, I'm starting to reconsider my patch, as well as
the users' current processes. Maybe they should be using sysfs in lieu
of physical attention buttons. To make that work, I will request they
disable pciehp polling and require the user initiate the hot add with
the slot's sysf. I will check if this is acceptable and have them run
tests to confirm if that works.

> >> > >   cmd = PCI_EXP_SLTCTL_DLLSCE;
> >> > >   if (ATTN_BUTTN(ctrl))
> >> > >           cmd |= PCI_EXP_SLTCTL_ABPE;
> >> > > - else
> >> > > + if (HP_CAP(ctrl))
> 
> I may be wrong, but I believe that unless PCI_EXP_SLTCAP_HPC is set,
> the pciehp will never get control of the hotplug port i.e. pcieport
> will not send it to pciehp? So we do not need HP_CAP.

Thanks for pointing that out. FWIW, you are correct; the check is
not needed.
