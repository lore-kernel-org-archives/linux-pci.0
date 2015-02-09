Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bbn0101.outbound.protection.outlook.com ([157.56.111.101]:27782
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761232AbbBIVki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 16:40:38 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Stu Grossman <grossman@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: 64bit BARs: prefetchable only?
Date: Mon, 9 Feb 2015 21:24:47 +0000
Message-ID: <DM2PR0301MB1232EA3736CC5ABCB800F51FAB270@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <DM2PR05MB9756702E07AE2E167262448B4270@DM2PR05MB975.namprd05.prod.outlook.com>
In-Reply-To: <DM2PR05MB9756702E07AE2E167262448B4270@DM2PR05MB975.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Hello,
> 
> I'm working on a system that can potentially have a large amount of PCI
> memory requirements (say 8GB or more) for the memory mapped PCI device
> registers. Since these are registers, I want non-prefetchable memory windows
> and not prefetchable ones.
> 
> Now, I'm taking a look at the PCI-to-PCI bridge architecture specifications, and I
> see that for bridges (downstream ports / root oorts etc), while there are 64 bits
> available to specify the Prefetchable memory base and limit, the (non-
> prefetchable) memory base and limit register are only 32 bit. I looked at
> various different specs related to PCI, but I could not find anything that could
> help me understand how to program a bridge so that it forwards a transaction
> to a 64bit BAR, using the Non-prefetchable windows.
> 
> My questions:
> 
> 1) Is there any way possible to have a non-prefetchable memory, greater than
> 4GB, programmed on a PCI bridge?
> 

No, there isn't, but it probably doesn't matter in practice.  You're almost certainly dealing with PCI Express here, and the concept of prefetchable doesn't apply to Express.  Bridges aren't allowed to buffer reads with Express, and so nothing is actually prefetched.  The prefetchable bit in the BAR is legacy from PCI, which did involve buffering in bridges.


> 2) Is it possible to have to program a non-prefetchable window, may be small
> size (say 1MB), but starts at a PCI address ABOVE 4GB?
> 

No, but see the answer above.

> 3) How do the 64 bit BARs behave. Does the PCI standard requires all 64 bit
> BARs to be only mapped using prefetchable regions?
> 

No, it doesn't.


Cheers,
Jake Oshins

