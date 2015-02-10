Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0143.outbound.protection.outlook.com ([157.56.111.143]:50616
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753944AbbBJWuV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Feb 2015 17:50:21 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Stu Grossman <grossman@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: 64bit BARs: prefetchable only?
Date: Tue, 10 Feb 2015 22:34:34 +0000
Message-ID: <DM2PR0301MB1232770672AC080E235E1E23AB240@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <DM2PR05MB9756702E07AE2E167262448B4270@DM2PR05MB975.namprd05.prod.outlook.com>
 <DM2PR0301MB1232EA3736CC5ABCB800F51FAB270@DM2PR0301MB1232.namprd03.prod.outlook.com>
 <DM2PR05MB975B1F75453CE8874D3D9FDB4240@DM2PR05MB975.namprd05.prod.outlook.com>
In-Reply-To: <DM2PR05MB975B1F75453CE8874D3D9FDB4240@DM2PR05MB975.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Rajat Jain [mailto:rajatjain@juniper.net]
> Sent: Tuesday, February 10, 2015 1:52 PM
> To: Jake Oshins; linux-pci@vger.kernel.org
> Cc: Stu Grossman; Guenter Roeck
> Subject: RE: 64bit BARs: prefetchable only?
> 
> > , and the concept of prefetchable
> > doesn't apply to Express.  Bridges aren't allowed to buffer reads with
> > Express, and so nothing is actually prefetched.
> 
> Can you please point me to the section in the PCI Express spec that mandates
> this? The only reference I could find in the spec to this was in an
> "implementation note" below:
> 
> ================================================================
> ========
> "Implementation Note: Additional Guidance on the Prefetchable Bit in Memory
> Space BARs"
> ================================================================
> =======
> ...
> <snip>
> ...
> On PCI Express systems that meet the criteria enumerated below, setting the
> Prefetchable bit in a
> candidate BAR will still permit correct operation even if the BAR's range
> includes some locations
> that have read side-effects or cannot tolerate write merging. This is primarily
> due to the fact that
> PCI Express Memory Reads always contain an explicit length, and PCI Express
> Switches never
> prefetch or do byte merging. Generally only 64-bit BARs are good candidates,
> since only Legacy
> Endpoints are permitted to set the Prefetchable bit in 32-bit BARs, and most
> scalable platforms map
> all 32-bit Memory BARs into non-prefetchable Memory Space regardless of the
> Prefetchable bit
> value.
> ...
> <snip>
> ...
> ================================================================
> ========

This is exactly the section that I would have pointed you to.  PCI Express switches are called switches rather than bridges because they do no buffering.  When your endpoint has credits to put TLPs on the fabric, that means that those TLPs are going to pass all the way across the fabric.  Your endpoint will never have credits when this can't happen.  Thus there's no notion of prefetching.  If you want a more detailed discussion than the implementation note above, read the sections on how an endpoint is granted the right to send TLPs.

> I did not get this. How does it work if I map a 64 bit BAR using non-prefetchable
> region, if there is no way for the bridges to forward the traffic to it (The
> memory base and limit registers are only 32 bit)?
> 

If you map a 64-bit BAR into a non-prefetchable region, that will involve writing zeros to all the bits in the upper part of the 64-bit BAR, so that it falls within the bridge windows.  (This is strictly true only for endpoints which are not embedded in the root complex.  These can appear on the root bus, and thus they might have addresses above 4GB in their BARs.)

And yes, in my opinion, this makes the requirement that all BARs be 64-bit capable (on Express) a little silly.

-- Jake Oshins

