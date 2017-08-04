Return-Path: <SRS0=ea3o=7G=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=ea3o=7G=intel.com=keith.busch@kernel.org>
Date: Thu, 3 Aug 2017 21:58:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] pciehp: Enable hot plug capable detection
Message-ID: <20170804015844.GA478@localhost.localdomain>
References: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
 <20170802173249.GB20308@bhelgaas-glaptop.roam.corp.google.com>
 <20170803035924.GB13257@localhost.localdomain>
 <20170803201034.GW20308@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170803201034.GW20308@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 03:10:34PM -0500, Bjorn Helgaas wrote:
> [+cc Yinghai, Rajat]
> 
> On Wed, Aug 02, 2017 at 11:59:24PM -0400, Keith Busch wrote:
> > 
> > The part of the specification that suggests PDCE is tied to the hotplug
> > capable bit is the "Slot Control Register" section in 7.8.10 of PCIe
> > Base spec rev4. Specifically:
> > 
> >   "If the Hot-Plug Capable bit in the Slot Capabilities register is 0b,
> >    this bit is permitted to be read-only with a value of 0b"
> > 
> > So this control doesn't do anything if hotplug capable is not set.
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

Indeed, in my limited experience I also observe slightly different
behavior that could all be interpreted as spec compliant. Coding the
kernel for one unfortunately risks breaking another. :(

> > The only reference I find on why the code is currently done this way is
> > from this thread:
> > 
> >   https://marc.info/?l=linux-kernel&m=138688828930718&w=2
> > 
> > It seems the current behavior was done this way as a hunch more than
> > anything emperical.
> 
> Yeah, this is the sort of thing that niggles at me, but I don't know
> how to resolve it other than to just apply your patch and see if
> anything breaks.  There is this hint that presence detect flaps
> sometimes:
> 
>   http://www.spinics.net/lists/hotplug/msg05812.html
> 
> But there's nothing there we can really act on, unless Yinghai or
> Rajat can dredge up something more concrete.
> 
> > The problem I'm trying to solve, though, is with a real platform
> > that supports hot-add. The reason it is currently broken with Linux
> > is because this platform advertises "Attention Button Present" when
> > in fact no physical button exists on the platform. Since the kernel
> > doesn't enable presence detect change events when attention button
> > present is set, we don't get hot-add events. We've been working around
> > this by using pciehp_poll_mode=1, but we'd prefer to see this working
> > without kernel parameters.
> 
> I agree, using pciehp_poll_mode stinks, and I like your patch.
> 
> Can we mention the platform name here, just in case this oddity
> (advertising Attention Button without having a button) is of interest
> in the future?
> 
> I propose the following changelog (and I'll add the platform name if
> you can supply it):

This one I'm helping with is based on a COM Express Type 6. The
interesting part is probably the carrier board, which has a PEX8733
bridge. I think its safe to assume not all the available features are
being used, which should be fine, but is why advertised capabilities
are missing their human interfaces.

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

This sounds great to me. Let me consider Rajat's reply before pulling
the trigger on this one. I initially thought this patch was safe, but
I don't want to break anything.
