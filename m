Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from beta.dmz-ap.st.com ([138.198.100.35]:46597 "EHLO
	beta.dmz-ap.st.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3J2HjP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 03:39:15 -0400
Date: Tue, 29 Oct 2013 12:40:15 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Marek Vasut <marex@denx.de>,
	Tim Harvey <tharvey@gateworks.com>,
	'Arnd Bergmann' <arnd@arndb.de>
Subject: Re: [QUERY] Number of address translation regions in designware
Message-ID: <20131029071015.GB2297@pratyush-vbox>
References: <52652BF1.4040507@ti.com>
 <000001cecee5$cbeafa10$63c0ee30$%han@samsung.com>
 <52668991.1020208@ti.com>
 <20131023043610.GA5521@pratyush-vbox>
 <5267EF1E.1010101@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5267EF1E.1010101@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ Marek, Tim, arnd

Hi Kishon,

On Wed, Oct 23, 2013 at 11:45:34PM +0800, Kishon Vijay Abraham I wrote:
> Hi Pratyush,
> 
> On Wednesday 23 October 2013 10:06 AM, Pratyush Anand wrote:
> > Hi Kishon,
> > 
> > On Tue, Oct 22, 2013 at 10:20:01PM +0800, Kishon Vijay Abraham I wrote:
> >> Hi Pratyush, Jingoo,
> >>
> >> On Tuesday 22 October 2013 10:46 AM, Jingoo Han wrote:
> >>> On Monday, October 21, 2013 10:28 PM, Kishon Vijay Abraham I wrote:
> >>>>
> >>>> Currently I see in pcie-designware.c we use only 2 ATU regions. We re-use
> >>>> INDEX0 for mem outbound and cfg0, and INDEX1 for cfg1 and io. So I'd like to
> >>>> know if in your platform, do you have only 2 address translation regions? In
> >>>> DRA7xx we have 16 outbound regions and 4 inbound regions.
> >>>
> >>> In Exynos, there are only 2 inbound and 2 outbound viewpoints.
> >>>
> >>>> Also the same designware IP can be used as a EP also no? Shouldn't we move it
> >>>> out of drivers/pci/host and allow it to be configured as EP also?
> >>>
> >>> Currently, Exynos PCIe IP does not support EP mode.
> >>
> >> Thanks for the information. I think we can do some optimization w.r.t address
> >> translation regions. Will post a RFC soon.
> >>
> >> One more query.
> >> In dw_pcie_prog_viewport_cfg0/dw_pcie_prog_viewport_cfg1 functions, the *lower
> >> target* is programmed to busdev. Is it for any specific reason?
> >> I mean doing that will leave lot of holes in the PCIe address space.
> >> IIUC, if we don't set that to busdev, consecutive pcie address space will be
> >> used for each function no?
> > 
> > Yes, I think even if CX_ATU_MIN_REGION_SIZE is 64KB in any controller,
> > bus, dev and function number can be used to define target address.
> 
> I meant for function 0 the configuration space will be from (0x0 t0 0xfff -
> 4KB). If we use *busdev* for programming target, for function 1 the
> configuration space will start at 0x10000 PCIe address which will leave a small
> hole from (0x1000 to 0xffff). I'm not sure if it will have a big impact though.
> Also till we haven't exhausted the 64KB space (minimum), we wouldn't be needing
> to program a new viewport. That's good enough to accommodate 18 functions for
> the number of devices.

Yes, I agree with you that using *busdev* will create hole and we
should avoid it. More on this at the end.

> > 
> > So you are trying to allocate statically a separate viewport for each
> > function's cfg0 transfer (whereever sufficient number of viewport is
> > avilable)?
> 
> Actually in DRA7xx, we face a different problem in that, we can't program the
> translation region directly from the ranges. Because while programming the
> address translation window, the most significant 4 bits are not used.
> 
> For example if you see, the cpu address of memory window starts @ 0x20012000
> but while programming the address translation window we have to give 0x00012000.
> 
> My dt data looked like this.
> ranges = <0x00000800 0 0x20001000 0x20001000 0 0x00001000
> 	  0x81000000 0 0	  0x20002000 0 0x00010000
> 	  0x82000000 0 0x20012000 0x20012000 0 0xffee000>;
> 
> translation = <(OUTBOUND | INDEX0) CFG0 0x0 0x00001000 0x0000fff 0x0 0x00001000
> 	       (OUTBOUND | INDEX1) IO   0x0 0x00002000 0x000ffff 0x0 0x00002000
> 	       (OUTBOUND | INDEX2) MEM  0x0 0x00012000 0xffee000 0x0 0x20012000
> >;

I too have some doubt here..not very clear.. may be someone more
expert can correct (I keep arnd in cc).... How should be the
translation?
In my opinion, input address of translation should be in "bus address
domain"  ie address what PCIe sees and translated output for memory
transaction should be in "parent bus address domain" ie what CPUs
see. If my understanding is correct, then pcie designware driver needs
fixes at some places.

I am not much used to DT, but if I understood correctly, in your case
parent bus address and bus address are different.

pp->mem_base = bus address  = range.pci_addr = 0x0000000000012000
pp->config.mem_bus_addr = parent bus address = range.cpu_addr = 0x20012000

So, shouldn't your ranges look like this:

ranges = <0x00000800 0 0x00001000 0x20001000 0 0x00001000
 	  0x81000000 0 0	  0x20002000 0 0x00010000
 	  0x82000000 0 0x00012000 0x20012000 0 0xffee000>;

And then I think with the proper designware driver fixes you should be
able to work.

> (btw that translation is a wip I tried to get pcie working in dra7x).
> 
> Since I wanted to do the translation configuration from dt data, I was thinking
> whether it is necessary to program the viewport dynamically.
> 
> But now I think some sort of dynamic programming would be needed, considering
> the limitation on few SoCs.

Yes, some dynamic programming is needed and not sure how to manage in
case of only one outbound viewport. What about following idea:
1. We keep dynamic for cfg and static for others.
2. We use single viewport for cfg0 and cfg1 both. We do not use
separate cfg0/1 base rather use only cfg_base and cfg_size=64K (we
could have done with even 4K, but some controller might have min
viewport size as 64K). As per viewport CR programmed, translated
output will be cfg0 or cfg1.
3. Now if a controller has only one viewport, a warning message is
generated that IO transaction may not work correctly. (I think IO
will always need translation. Just for curiosity anyone knows a ARM
based system which uses PCIe IO transaction?).
4. If a controller has atleast 2 viewport, we program second viewport
statically for IO transaction.
5. If it has only two viewport, and cpu_addr != pci_addr, a warning
message is generated that MEM transaction may not work correctly.
6. Else, 3rd viewport is programmed for mem transaction.

Regards
Pratyush

> 
> Thanks
> Kishon
> 
> > 
> > If viewport is programmed dynamically at each cfg transfer, then
> > whether you use bus and dev only or function also, will it really make
> > any difference in saving of address space?
> > 
> > Regards
> > Pratyush
> > 
> >>
> >> Thanks
> >> Kishon
