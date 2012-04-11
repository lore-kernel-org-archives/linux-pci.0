Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:57456 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619Ab2DKFbo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Apr 2012 01:31:44 -0400
From: Steven Newbury <steve@snewbury.org.uk>
Reply-To: Steven Newbury <steve@snewbury.org.uk>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity>
	 <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	 <4F84110E.3000400@snewbury.org.uk>
	 <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	 <4F8467AA.90305@snewbury.org.uk>
	 <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	 <4F848357.3060007@snewbury.org.uk>
	 <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
	 <4F848E10.1090703@snewbury.org.uk>
	 <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
	 <1334089568.4083.2.camel@Nokia-N900>
	 <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
	 <4F84A3EC.6030903@snewbury.org.uk>
	  <CAErSpo6GTarMUySce+n6x=TtqgfryzA5-88aKwL7L4snDp4MTA@mail.gmail.com>
In-Reply-To: <CAErSpo6GTarMUySce+n6x=TtqgfryzA5-88aKwL7L4snDp4MTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 Apr 2012 06:33:24 +0100
Message-Id: <1334122404.28676.2.camel@Nokia-N900>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 11 Apr 2012, 04:37:21 BST, Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Tue, Apr 10, 2012 at 3:19 PM, Steven Newbury <steve@snewbury.org.uk>
> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On 10/04/12 21:45, Yinghai Lu wrote:
> > > On Tue, Apr 10, 2012 at 1:26 PM, Steven Newbury
> > > <steve@snewbury.org.uk> wrote:
> > > > > 
> > > > So far I'm concluding the BIOS isn't sane.  Is it possible to
> > > > define a custom memory map from the linux boot cmdline to set
> > > > TOP_OF_LOW_MEM?
> > > 
> > > The BIOS have MMIO and memory overlapping...
> > > 
> > > > 
> > Another thought, normally the integrated graphics has an "AGP"
> > aperture of 256M @0xe0000000, which is detected by agpgart-intel, this
> > will need to be moved up above 4G to free up 0xe0000000 for the
> > radeon, assuming the "agp_bridge" has a 64bit base register...  I
> > noticed in my docked dmesg, "AGP aperture is 256M @ 0x20000000", but
> > the PCI base: "120000000-12fffffff : 0000:00:02.0" so only 32bits have
> > been set in agpgart-intel.  Explains why i915 wasn't initialised.
> > 
> > > > Obviously, I'd prefer getting everything allocated into the
> > > > address space available, and working, but if it comes down to it
> > > > I'd accept a hack like the above if there's no other way.
> > > 
> > > Could try to reduce carbus preallocated size.... boot with
> > > pci=cbmemsize=16M
> > > 
> > > Please apply attached patch in addtition to allocate_high_at_first
> > > 
> > I'll try first thing tomorrow.  I'm away from the docking station now.
> 
> Why are we messing around with resources above 4G?   The host bridge
> _CRS reports no apertures above 4G, and you can't just try random
> things and hope they work.
> 
The BIOS doesn't always know best, there's no reason to think Dell put any effort into 64bit OS support, the only supported OS options were WinXP (32bit), and (new at the time) Vista (32bit), as such they tried to minimize the PCI hole so most of the maximum supported 4GB is available, but severely limiting MMIO space for additional devices.  Reproducing what the BIOS should have done may be the only option.

> If the host bridge has a _PRS with settings above 4G that we could
> enable, that might be worthwhile.   I haven't seen _PRS on a host
> bridge yet, and Linux would ignore it if it existed, but that would be
> a plausible approach.   (Turn on CONFIG_PNP_DEBUG_MESSAGES and boot
> with pnp.debug=1 to see if you have any _PRS.)
> 
I will try this, but I'll be surprised if it has anything useful.

> I think it would be helpful to break this down and look at one issue
> at a time, e.g., by removing the dock/undock hotplug issues.

The hotplug detection of the card devices doesn't work on mainline, only the bridge device shows up, but it does work with Yinghai's for-pci-busn-alloc branch, but resource allocation does not.  No different to booting docked.
> 
> In https://bugzilla.kernel.org/show_bug.cgi?id=10461#c12, I think the
> problem you're seeing is that when you boot while docked, the
> integrated i915 works, but the radeon in the dock does not.   That
> makes sense to me because they each want 256M of space, and according
> to your _CRS info, there's only one possible location with that much
> space (0xe0000000).   Do you happen to know what Windows does in that

That's why I'm hoping to be able to reallocate the i915 aperture above 4GB, but this depends on what the chipset is capable of rather than what the BIOS exposes.

> situation?   Does the radeon work and the i915 not, or does it somehow
> make both work?   Is there any way you could collect the device info
> under Windows, using AIDA64 (http://www.aida64.com/) or similar?
> 
>From reading Microsoft documents, they always try putting PCI resources above 4GB on 64bit Windows since Vista, even using bounce buffers where necessary, and supported by the hardware, only falling back below 4GB when all else fails.  I only have the 32bit Windows Vista shipped with the laptop to test on, and in that case it just fails badly, BSOD if booting docked, or unable to allocate resources just like Linux on hotplug.

Despite this, the reason I bought this card is a positive report from a Windows user of success, most VGA cards don't work in the d/dock, and I was hoping to experiment with prime. :)
