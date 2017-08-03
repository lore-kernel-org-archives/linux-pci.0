Return-Path: <SRS0=xvyd=7F=google.com=rajatja@kernel.org>
Return-Path: <SRS0=xvyd=7F=google.com=rajatja@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170803201034.GW20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
 <20170802173249.GB20308@bhelgaas-glaptop.roam.corp.google.com>
 <20170803035924.GB13257@localhost.localdomain> <20170803201034.GW20308@bhelgaas-glaptop.roam.corp.google.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 3 Aug 2017 16:00:18 -0700
Message-ID: <CACK8Z6FF_T7yc86_vc=carnp1N9XyNk_tYHrvaVGekTf8hf+jA@mail.gmail.com>
Subject: Re: [PATCH] pciehp: Enable hot plug capable detection
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thu, Aug 3, 2017 at 1:10 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Yinghai, Rajat]
>
> On Wed, Aug 02, 2017 at 11:59:24PM -0400, Keith Busch wrote:
>> On Wed, Aug 02, 2017 at 12:32:49PM -0500, Bjorn Helgaas wrote:
>> > Hi Keith,
>> >
>> > On Wed, Aug 02, 2017 at 01:15:07AM -0400, Keith Busch wrote:
>> > > The PCIe specification ties presence detect change enabling to the hot plug
>> > > capable bit in Slot Capabilities. This capability is not mutally exclusive
>> > > with attention buttons, so enabing detection should not be tied it.
>> >
>> > Can you clarify this a little?
>> >
>> >   - Please include the spec section you're referring to.
>> >
>> >   - I'm not sure what "This capability is not ..." refers to.  There
>> >     is not a "presence detect change enabling" capability.  I agree
>> >     that the "Hot-Plug Capable" bit is independent of the "Attention
>> >     Button Present" bit.
>> >
>> >   - Slot Control (PCIe r3.1, sec 7.8.10) says PDCE *is permitted* to
>> >     be read-only zero if PCI_EXP_SLTCAP_HPC is zero.  It doesn't say
>> >     PDCE is *required* to be read-only in that case.
>> >
>> > My initial reaction is that it probably makes sense per the spec to
>> > enable PDCE unconditionally, but I would want to do some archaeology
>> > to figure out why it wasn't that way from the beginning.

I think we should think about what events do we want to actually
*trigger* the hot-plug, and is presence detect one of them. In other
words, can we assume that the card is ready to be scanned as soon as
it is inserted, even on platforms that do advertise an attention
button? May be these are remote corner cases and don't make any sense
(have a very good imagination ;-):

* Could the device be powered externally, and the operator needs to
still turn it on after plugging it in?
* Could there be a need for the operator to wait on something after
plugging in, before it gives a go ahead to the host to start scanning?
(wait until device has loaded some firmware, some device LED blinked
or things like that).

AFAICT, the attention button was precisely meant for holding off host
scanning until the operator believes the device is ready for it.
Today, pciehp would wait for 5 seconds after attention button press
before actually starting hotplug, thus giving the operator a chance to
press the attention button again to cancel the operation:

        case BLINKINGOFF_STATE:
        case BLINKINGON_STATE:
                /*
                 * Cancel if we are still blinking; this means that we
                 * press the attention again before the 5 sec. limit
                 * expires to cancel hot-add or hot-remove
                 */

Now I don't recall where (I checked PCIe spec and PCI hotplug spec)
but I recall reading a documented sequence of steps for hotplug in
some sort of spec, which is what pciehp seemed to mimic. So I believe
if we enabled presence detect to start hotplug immediately
unconditionally, there might be dead code left. Also, I'm wondering
are we going to render the attention button useless for hotplug
addition scenario (this will change the behavior for platforms that
currently use attention button correctly)?

>> >  There's
>> > probably some reason for it being the way it is, so we have to take
>> > that into account.  Maybe it works around some flaky presence detect
>> > hardware or something.

YInghai seemed to have seen some:
https://patchwork.ozlabs.org/patch/170489/

>>
>> Thanks for the feedback. I can definitely make the commit message better
>> if that's the only concern.
>>
>> The part of the specification that suggests PDCE is tied to the hotplug
>> capable bit is the "Slot Control Register" section in 7.8.10 of PCIe
>> Base spec rev4. Specifically:
>>
>>   "If the Hot-Plug Capable bit in the Slot Capabilities register is 0b,
>>    this bit is permitted to be read-only with a value of 0b"
>>
>> So this control doesn't do anything if hotplug capable is not set.
>
> I thought that might be the part of the spec you were referring to,
> but that's not how I read it :)  I read sec 7.8.10 as saying:
>
>   - Presence Detect Changed Enable is a read/write bit,
>   - However, if Hot-Plug Capable (a HwInit/read-only bit) is 0,
>     PDCE may be a read-only 0 (OR it may be read/write)
>
> So I think it's slightly misleading to suggest that PDCE is "tied" to
> HPC.  I think the spec allows PDCE to be read/write and to have some
> effect, even if HPC is 0.
>
> I don't know what it would *mean* to have a slot that said "I don't
> support hot-plug operations, but my Presence Detect State might
> change".  We've seen some creative uses of pciehp, so I wouldn't be
> surprised if somebody dreamed up a way to use it.
>
>> The only reference I find on why the code is currently done this way is
>> from this thread:
>>
>>   https://marc.info/?l=linux-kernel&m=138688828930718&w=2
>>
>> It seems the current behavior was done this way as a hunch more than
>> anything emperical.

Essentially the reason it was done is the assumption that if attention
button is present, then it is left on the operator to let us know when
to initiate the hot plug.

One question, does your platform advertise surprise removal
capability? If so, then I think a better way to enable PDCE is if
surprise removal is supported, this was also suggested by Yinghai one
time:

From: https://lkml.org/lkml/2013/12/13/433:
> > I suggest that link event handling will be enabled automatically when
> > attention button is not there and surprise removal is supported.

May be we can do something like:

if (suprise_removal_supported || !attention_button_present)
     enable PDCE

>
> Yeah, this is the sort of thing that niggles at me, but I don't know
> how to resolve it other than to just apply your patch and see if
> anything breaks.  There is this hint that presence detect flaps
> sometimes:
>
>   http://www.spinics.net/lists/hotplug/msg05812.html

I had mostly seen link state flapping because of shaky hands when
hotpluggin, but I'd imagine that the presence detect can flap too for
the same reasons.

>
> But there's nothing there we can really act on, unless Yinghai or
> Rajat can dredge up something more concrete.
>
>> The problem I'm trying to solve, though, is with a real platform
>> that supports hot-add. The reason it is currently broken with Linux
>> is because this platform advertises "Attention Button Present" when
>> in fact no physical button exists on the platform. Since the kernel
>> doesn't enable presence detect change events when attention button
>> present is set, we don't get hot-add events. We've been working around
>> this by using pciehp_poll_mode=1, but we'd prefer to see this working
>> without kernel parameters.
>
> I agree, using pciehp_poll_mode stinks, and I like your patch.
>
> Can we mention the platform name here, just in case this oddity
> (advertising Attention Button without having a button) is of interest
> in the future?
>
> I propose the following changelog (and I'll add the platform name if
> you can supply it):
>
>   PCI: pciehp: Always enable Presence Detect notifications for hotplug slots
>
>   Previously we only enabled notification of Presence Detect change events if
>   the slot did not advertise an Attention Button.
>
>   But there are platforms that support hotplug and advertise "Attention
>   Button Present" when in fact there is no physical button.  On these
>   platforms, we enabled Attention Button notifications, but never got any.
>   Presence Detect events occurred, but we left Presence Detect notification
>   disabled, so we never noticed them.
>
>   Always enable Presence Detect notifications for hotplug slots, even if they
>   advertise "Attention Button Present", so we can detect hotplug events.
>
>   Signed-off-by: Keith Busch <keith.busch@intel.com>
>   [bhelgaas: changelog]
>   Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
>> > > Signed-off-by: Keith Busch <keith.busch@intel.com>
>> > > ---
>> > >  drivers/pci/hotplug/pciehp.h     | 1 +
>> > >  drivers/pci/hotplug/pciehp_hpc.c | 2 +-
>> > >  2 files changed, 2 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
>> > > index 06109d4..610e295 100644
>> > > --- a/drivers/pci/hotplug/pciehp.h
>> > > +++ b/drivers/pci/hotplug/pciehp.h
>> > > @@ -120,6 +120,7 @@ struct controller {
>> > >  #define ATTN_LED(ctrl)           ((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
>> > >  #define PWR_LED(ctrl)            ((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
>> > >  #define HP_SUPR_RM(ctrl) ((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
>> > > +#define HP_CAP(ctrl)             ((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPC)
>> > >  #define EMI(ctrl)                ((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
>> > >  #define NO_CMD_CMPL(ctrl)        ((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
>> > >  #define PSN(ctrl)                (((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
>> > > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> > > index 026830a..43a86ed 100644
>> > > --- a/drivers/pci/hotplug/pciehp_hpc.c
>> > > +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> > > @@ -691,7 +691,7 @@ void pcie_enable_notification(struct controller *ctrl)
>> > >   cmd = PCI_EXP_SLTCTL_DLLSCE;
>> > >   if (ATTN_BUTTN(ctrl))
>> > >           cmd |= PCI_EXP_SLTCTL_ABPE;
>> > > - else
>> > > + if (HP_CAP(ctrl))

I may be wrong, but I believe that unless PCI_EXP_SLTCAP_HPC is set,
the pciehp will never get control of the hotplug port i.e. pcieport
will not send it to pciehp? So we do not need HP_CAP.

>> > >           cmd |= PCI_EXP_SLTCTL_PDCE;
>> > >   if (!pciehp_poll_mode)
>> > >           cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
>> > > --
>> > > 2.5.5
>> > >
