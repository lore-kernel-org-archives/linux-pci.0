Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbdGPS4b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Jul 2017 14:56:31 -0400
Date: Sun, 16 Jul 2017 12:56:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: ryzen X370: iommu - unusable huge groups
Message-ID: <20170716125630.7cfcec1c@w520.home>
In-Reply-To: <ecdf6b75-4966-fa3a-00de-99b1c9fe6caa@01019freenet.de>
References: <95b7f350-76f7-daff-be4a-f3fc70589ba9@01019freenet.de>
        <20170716085334.7ae210d2@w520.home>
        <ecdf6b75-4966-fa3a-00de-99b1c9fe6caa@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 16 Jul 2017 18:53:11 +0200
Andreas Hartmann <andihartmann@01019freenet.de> wrote:

> Hello Alex!
> 
> Nice to hear you again :-)
> 
> 
> 
> On 07/16/2017 at 04:53 PM Alex Williamson wrote:
> > On Sun, 16 Jul 2017 07:44:01 +0200
> > Andreas Hartmann <andihartmann@01019freenet.de> wrote:
> >   
> >> Hello!
> >>
> >> I've got a Asus X370-Pro motherboard with enabled iommu. Unfortunately,
> >> the group 0 is mostly all of the system :-).
> >>
> >> [    2.602426] iommu: Adding device 0000:00:01.0 to group 0
> >> [    2.602440] iommu: Adding device 0000:00:01.3 to group 0
> >> [    2.603368] iommu: Adding device 0000:03:00.0 to group 0
> >> [    2.603377] iommu: Adding device 0000:03:00.1 to group 0
> >> [    2.603385] iommu: Adding device 0000:03:00.2 to group 0
> >> [    2.603396] iommu: Adding device 0000:1d:00.0 to group 0
> >> [    2.603406] iommu: Adding device 0000:1d:02.0 to group 0
> >> [    2.603417] iommu: Adding device 0000:1d:03.0 to group 0
> >> [    2.603428] iommu: Adding device 0000:1d:04.0 to group 0
> >> [    2.603439] iommu: Adding device 0000:1d:06.0 to group 0
> >> [    2.603450] iommu: Adding device 0000:1d:07.0 to group 0
> >> [    2.603466] iommu: Adding device 0000:24:00.0 to group 0
> >> [    2.603481] iommu: Adding device 0000:25:00.0 to group 0
> >> [    2.603498] iommu: Adding device 0000:26:00.0 to group 0
> >> [    2.603513] iommu: Adding device 0000:27:00.0 to group 0  
> > 
> > 
> > Update your motherboard BIOS, AMD AGESA 1.0.0.6 is supposed to
> > enable ACS in the PCIe root ports.  Thanks,  
> 
> Group 0 is now group 10 - that's mostly all :-( - no significant change.
> (Version 805 which should contain AGESA 1.0.0.6).
> 
> 
> [    2.600097] iommu: Adding device 0000:03:00.0 to group 10
> [    2.600117] iommu: Adding device 0000:03:00.1 to group 10
> [    2.600136] iommu: Adding device 0000:03:00.2 to group 10
> [    2.600148] iommu: Adding device 0000:1d:00.0 to group 10
> [    2.600158] iommu: Adding device 0000:1d:02.0 to group 10
> [    2.600169] iommu: Adding device 0000:1d:03.0 to group 10
> [    2.600180] iommu: Adding device 0000:1d:04.0 to group 10
> [    2.600190] iommu: Adding device 0000:1d:06.0 to group 10
> [    2.600201] iommu: Adding device 0000:1d:07.0 to group 10
> [    2.600216] iommu: Adding device 0000:24:00.0 to group 10
> [    2.600233] iommu: Adding device 0000:25:00.0 to group 10
> [    2.600249] iommu: Adding device 0000:26:00.0 to group 10
> [    2.600266] iommu: Adding device 0000:27:00.0 to group 10
> 
> 
> All devices that are used are in the same group again.
> 
> Isn't it possible to allow them to put to VM anyway if there is no peer
> to peer communication - same as it was possible with the previous
> chipset (990xa)?

Ah, I see you have a PCIe switch with downstream ports 1d.*.0 where
the downstream switch ports don't support ACS (not surprising for
something reporting ASMedia as a subsystem capability).  So ACS was
broken at multiple levels and now that it's exposed at the root port
it's still broken by the non-ACS switch.  The endpoints downstream of
the switch are not sufficiently isolated to separate between VMs,
sorry, the hardware isn't up to the task at hand.  Thanks,

Alex
