Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:10706 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762353Ab2DMB4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Apr 2012 21:56:12 -0400
From: "Hao, Xudong" <xudong.hao@intel.com>
To: Don Dutile <ddutile@redhat.com>, Matthew Wilcox <matthew@wil.cx>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V4] Quirk for IVB graphics FLR errata
Date: Fri, 13 Apr 2012 01:56:10 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FD0FBAE@SHSMSX102.ccr.corp.intel.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD0DA33@SHSMSX102.ccr.corp.intel.com>
 <4F8594FD.8020109@redhat.com> <20120412040630.GC6557@parisc-linux.org>
 <4F86F28E.8020807@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Hao, Xudong
> Sent: Friday, April 13, 2012 9:41 AM
> To: 'Don Dutile'; Matthew Wilcox
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org
> Subject: RE: [PATCH V4] Quirk for IVB graphics FLR errata
> 
> > -----Original Message-----
> > From: Don Dutile [mailto:ddutile@redhat.com]
> > Sent: Thursday, April 12, 2012 11:20 PM
> > To: Matthew Wilcox
> > Cc: Hao, Xudong; Bjorn Helgaas; linux-pci@vger.kernel.org
> > Subject: Re: [PATCH V4] Quirk for IVB graphics FLR errata
> >
> > On 04/12/2012 12:06 AM, Matthew Wilcox wrote:
> > > On Wed, Apr 11, 2012 at 10:28:13AM -0400, Don Dutile wrote:
> > >>> +	cycles_t cyc_op_timeout = tsc_khz*op_timeout*1000;
> > >> Don't we know how to do a 10sec timeout w/o tying it to tsc_khz?
> > >
> > > Right, this code should of course be using jiffies and msleep.
> > >
> > >> -->  other arch compile problem source???
> > >
> > > Well, this device is part of the x86 CPU.  It's never going to be
> > > found as part of any other architecture.  Why force other
> > > architectures to carry this quirk around?
> > >
> > >
> >
> > Well, the trend to include more IO into chipsets tied to an arch will
> > probably increase over time, so such conditional quirks will increase as well.
> > Sounds like the quirk tables need an arch-hook (linked list) to check &
> traverse.
> > Then such code can go into arch/<arch>/pci/quirks.c .
> >
> 
> If using jiffies instead of tsc, the ifdef <x86> can be removed here, we already
> have device ID to limit the quirk workaround.
> So I do want to change this patch file directory, I will change tsc to jiffies.

A mistake here, I means I do NOT want to change the patch directory, according to device ID, other arch/device will not execute this quirk.

> 
> > I was under the impression Linux prefers not to have ifdef <arch> in
> > common code modules, and to split it out under arch/<> .
> >
> 
> Agreed and learned.
