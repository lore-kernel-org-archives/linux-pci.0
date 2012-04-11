Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53167 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756084Ab2DKDhn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Apr 2012 23:37:43 -0400
Received: by lahj13 with SMTP id j13so374335lah.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 20:37:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F84A3EC.6030903@snewbury.org.uk>
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
 <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
 <4F8467AA.90305@snewbury.org.uk> <CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
 <4F848357.3060007@snewbury.org.uk> <CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
 <4F848E10.1090703@snewbury.org.uk> <CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
 <1334089568.4083.2.camel@Nokia-N900> <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
 <4F84A3EC.6030903@snewbury.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Apr 2012 21:37:21 -0600
Message-ID: <CAErSpo6GTarMUySce+n6x=TtqgfryzA5-88aKwL7L4snDp4MTA@mail.gmail.com>
Subject: Re: PCI resources above 4GB
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2012 at 3:19 PM, Steven Newbury <steve@snewbury.org.uk> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 10/04/12 21:45, Yinghai Lu wrote:
>> On Tue, Apr 10, 2012 at 1:26 PM, Steven Newbury
>> <steve@snewbury.org.uk> wrote:
>>>>
>>> So far I'm concluding the BIOS isn't sane.  Is it possible to
>>> define a custom memory map from the linux boot cmdline to set
>>> TOP_OF_LOW_MEM?
>>
>> The BIOS have MMIO and memory overlapping...
>>
>>>
> Another thought, normally the integrated graphics has an "AGP"
> aperture of 256M @0xe0000000, which is detected by agpgart-intel, this
> will need to be moved up above 4G to free up 0xe0000000 for the
> radeon, assuming the "agp_bridge" has a 64bit base register...  I
> noticed in my docked dmesg, "AGP aperture is 256M @ 0x20000000", but
> the PCI base: "120000000-12fffffff : 0000:00:02.0" so only 32bits have
> been set in agpgart-intel.  Explains why i915 wasn't initialised.
>
>>> Obviously, I'd prefer getting everything allocated into the
>>> address space available, and working, but if it comes down to it
>>> I'd accept a hack like the above if there's no other way.
>>
>> Could try to reduce carbus preallocated size.... boot with
>> pci=cbmemsize=16M
>>
>> Please apply attached patch in addtition to allocate_high_at_first
>>
> I'll try first thing tomorrow.  I'm away from the docking station now.

Why are we messing around with resources above 4G?  The host bridge
_CRS reports no apertures above 4G, and you can't just try random
things and hope they work.

If the host bridge has a _PRS with settings above 4G that we could
enable, that might be worthwhile.  I haven't seen _PRS on a host
bridge yet, and Linux would ignore it if it existed, but that would be
a plausible approach.  (Turn on CONFIG_PNP_DEBUG_MESSAGES and boot
with pnp.debug=1 to see if you have any _PRS.)

I think it would be helpful to break this down and look at one issue
at a time, e.g., by removing the dock/undock hotplug issues.

In https://bugzilla.kernel.org/show_bug.cgi?id=10461#c12, I think the
problem you're seeing is that when you boot while docked, the
integrated i915 works, but the radeon in the dock does not.  That
makes sense to me because they each want 256M of space, and according
to your _CRS info, there's only one possible location with that much
space (0xe0000000).  Do you happen to know what Windows does in that
situation?  Does the radeon work and the i915 not, or does it somehow
make both work?  Is there any way you could collect the device info
under Windows, using AIDA64 (http://www.aida64.com/) or similar?

Bjorn
