Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41669 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab2GRE2m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Jul 2012 00:28:42 -0400
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Wed, 18 Jul 2012 00:28:41 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 775596E804F
	for <linux-pci@vger.kernel.org>; Wed, 18 Jul 2012 00:28:40 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6I4Se9m49479806
	for <linux-pci@vger.kernel.org>; Wed, 18 Jul 2012 00:28:40 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6I9xWFs007837
	for <linux-pci@vger.kernel.org>; Wed, 18 Jul 2012 05:59:33 -0400
Date: Wed, 18 Jul 2012 12:28:34 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
	bhelgaas@google.com, yinghai@kernel.org
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
Message-ID: <20120718042834.GB2375@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61>
 <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw>
 <20120717055715.GF2369@ram-ThinkPad-T61>
 <1342516619.3669.5.camel@pasglop>
 <20120717100314.GB25613@ram-ThinkPad-T61>
 <1342521498.3669.7.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342521498.3669.7.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 17, 2012 at 08:38:18PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2012-07-17 at 18:03 +0800, Ram Pai wrote:
> >         Lets say we passed that 'type' flag to size the minimum
> >         alignment constraints for that b_res.  And window_alignment(bus,
> >         type) of your platform  used that 'type' information to
> >         determine whether to use the alignment constraints of 32-bit
> >         window or 64-bit window.
> > 
> >         However, later when the b_res is actually allocated a resource,
> >         the pci_assign_resource() has no idea whether to allocate 32-bit
> >         window resource or 64-bit window resource, because the 'type'
> >         information is not captured anywhere in b_res.
> > 
> >         You would basically have a disconnect between what is sized and 
> >         what is allocated. Unless offcourse you pass that 'type' to
> >         the b_res->flags, which is currently not the case. 
> 
> Right, we ideally would need the core to query the alignment once per
> "apertures" it tries as a candidate to allocate a given resource... but
> that's for later.
> 
> For now we can probably live with giving out the max of the minimum
> alignment we support for M64 and our M32 segment size.

Its an approximation, which may not be terribly bad. But not comforting enough.

RP

