Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37636 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab2GQKEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Jul 2012 06:04:24 -0400
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Tue, 17 Jul 2012 06:04:23 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 18D2138C805F
	for <linux-pci@vger.kernel.org>; Tue, 17 Jul 2012 06:03:20 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6HA3JTZ363500
	for <linux-pci@vger.kernel.org>; Tue, 17 Jul 2012 06:03:19 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6HA3IFK027477
	for <linux-pci@vger.kernel.org>; Tue, 17 Jul 2012 06:03:19 -0400
Date: Tue, 17 Jul 2012 18:03:14 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
	bhelgaas@google.com, yinghai@kernel.org
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120717100314.GB25613@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw>
 <20120717055715.GF2369@ram-ThinkPad-T61>
 <1342516619.3669.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342516619.3669.5.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 17, 2012 at 07:16:59PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2012-07-17 at 13:57 +0800, Ram Pai wrote:
> > Hmm.. this code is not about determining what kind of segment the
> > platform is returning. This code is about using the right alignment
> > constraints for the type of segment from which resource will be
> > allocated. right?
> > 
> > b_res is the resource that is being sized. b_res already knows
> > what kind of resource it is, i.e IORESOURCE_MEM or
> > IORESOURCE_PREFETCH.
> > Hence we should be exactly using the same alignment constraints as
> > that dictated by the type of b_res. no? 
> 
> This is unclear.... ideally we want to know which of the host bridge
> "apertures" is about to be used...
> 
> IE. A prefetchable resource can very well be allocated to a
> non-prefetchable window, though the other way isn't supposed to happen.
> 
> Additionally, our PHB doesn't actually differenciate prefetchable and
> non-prefetchable windows (whether you can prefetch or not is an
> attribute of the CPU mapping, but basically non-cachable mappings are
> never prefetchable for us).
> 
> So we can be lax in how we assign things between our single 32-bit
> window divided in 128 segments and our 16x64-bit windows divided in 8
> segments (and future HW will do thins differently even).
> 
> For example we would like in some cases to use M64's (64-bit windows) to
> map SR-IOV BARs regardless of the "prefetchability" though that can only
> work if we are not behind a PCIe switch, as those are technically
> allowed to prefetch :-)
> 
> Worst is that the alignment constraint is based on the segment size, and
> while we more/less fix the size of the 32-bit window, we plan to
> dynamically allocate/resize the 64-bit ones which will mean variable
> segment sizes as well.
> 
> So the more information you can get at that point, the better. The type
> is useful because it allows us to know if you are trying to put a
> prefetchable memory BAR inside a non-prefetchable region, in which case
> we know it has to be in M32.


Ben,
	Lets say we passed that 'type' flag to size the minimum
	alignment constraints for that b_res.  And window_alignment(bus,
	type) of your platform  used that 'type' information to
	determine whether to use the alignment constraints of 32-bit
	window or 64-bit window.

	However, later when the b_res is actually allocated a resource,
	the pci_assign_resource() has no idea whether to allocate 32-bit
	window resource or 64-bit window resource, because the 'type'
	information is not captured anywhere in b_res.

	You would basically have a disconnect between what is sized and 
	what is allocated. Unless offcourse you pass that 'type' to
	the b_res->flags, which is currently not the case.

RP

