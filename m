Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0116.outbound.protection.outlook.com ([157.56.111.116]:55908
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752103AbbBJVwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 16:52:01 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Jake Oshins <jakeo@microsoft.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Stu Grossman <grossman@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: 64bit BARs: prefetchable only?
Date: Tue, 10 Feb 2015 21:51:57 +0000
Message-ID: <DM2PR05MB975B1F75453CE8874D3D9FDB4240@DM2PR05MB975.namprd05.prod.outlook.com>
References: <DM2PR05MB9756702E07AE2E167262448B4270@DM2PR05MB975.namprd05.prod.outlook.com>
 <DM2PR0301MB1232EA3736CC5ABCB800F51FAB270@DM2PR0301MB1232.namprd03.prod.outlook.com>
In-Reply-To: <DM2PR0301MB1232EA3736CC5ABCB800F51FAB270@DM2PR0301MB1232.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Jake,

Thanks for your response. 

> -----Original Message-----
> From: Jake Oshins [mailto:jakeo@microsoft.com]
> Sent: Monday, February 09, 2015 1:25 PM
> To: Rajat Jain; linux-pci@vger.kernel.org
> Cc: Stu Grossman; Guenter Roeck
> Subject: RE: 64bit BARs: prefetchable only?
> 
> > Hello,
> >
> > I'm working on a system that can potentially have a large amount of
> > PCI memory requirements (say 8GB or more) for the memory mapped PCI
> > device registers. Since these are registers, I want non-prefetchable
> > memory windows and not prefetchable ones.
> >
> > Now, I'm taking a look at the PCI-to-PCI bridge architecture
> > specifications, and I see that for bridges (downstream ports / root
> > oorts etc), while there are 64 bits available to specify the
> > Prefetchable memory base and limit, the (non-
> > prefetchable) memory base and limit register are only 32 bit. I looked
> > at various different specs related to PCI, but I could not find
> > anything that could help me understand how to program a bridge so that
> > it forwards a transaction to a 64bit BAR, using the Non-prefetchable
> windows.
> >
> > My questions:
> >
> > 1) Is there any way possible to have a non-prefetchable memory,
> > greater than 4GB, programmed on a PCI bridge?
> >
> 
> No, there isn't, but it probably doesn't matter in practice.  You're almost
> certainly dealing with PCI Express here

Yes, I am.

> , and the concept of prefetchable
> doesn't apply to Express.  Bridges aren't allowed to buffer reads with
> Express, and so nothing is actually prefetched.

Can you please point me to the section in the PCI Express spec that mandates this? The only reference I could find in the spec to this was in an "implementation note" below:

========================================================================
"Implementation Note: Additional Guidance on the Prefetchable Bit in Memory Space BARs"
=======================================================================
...
<snip>
...
On PCI Express systems that meet the criteria enumerated below, setting the Prefetchable bit in a
candidate BAR will still permit correct operation even if the BAR's range includes some locations
that have read side-effects or cannot tolerate write merging. This is primarily due to the fact that
PCI Express Memory Reads always contain an explicit length, and PCI Express Switches never
prefetch or do byte merging. Generally only 64-bit BARs are good candidates, since only Legacy
Endpoints are permitted to set the Prefetchable bit in 32-bit BARs, and most scalable platforms map
all 32-bit Memory BARs into non-prefetchable Memory Space regardless of the Prefetchable bit
value.
...
<snip>
...
========================================================================

I see that this has been mentioned matter-of-factly but I'm assuming that this should probably be spelled out more loudly somewhere else?

>  The prefetchable bit in the
> BAR is legacy from PCI, which did involve buffering in bridges.
> 
> 
> > 2) Is it possible to have to program a non-prefetchable window, may be
> > small size (say 1MB), but starts at a PCI address ABOVE 4GB?
> >
> 
> No, but see the answer above.
> 
> > 3) How do the 64 bit BARs behave. Does the PCI standard requires all
> > 64 bit BARs to be only mapped using prefetchable regions?
> >
> 
> No, it doesn't.


I did not get this. How does it work if I map a 64 bit BAR using non-prefetchable region, if there is no way for the bridges to forward the traffic to it (The memory base and limit registers are only 32 bit)?

Thanks,

Rajat

> 
> 
> Cheers,
> Jake Oshins

