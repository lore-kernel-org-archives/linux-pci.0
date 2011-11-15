Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:37010 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab1KOANB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2011 19:13:01 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <dwg@au1.ibm.com>;
	Tue, 15 Nov 2011 00:11:32 +1000
Date: Tue, 15 Nov 2011 11:05:05 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Christian Benvenuti (benve)" <benve@cisco.com>,
	chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de,
	"Aaron Fabbri (aafabbri)" <aafabbri@cisco.com>,
	B08248@freescale.com, B07421@freescale.com, avi@redhat.com,
	konrad.wilk@oracle.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Message-ID: <20111115000505.GA5035@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
 <184D23435BECB444AB6B9D4630C8EC8302D5FE38@XMB-RCD-303.cisco.com>
 <1321034647.2682.98.camel@bling.home>
 <184D23435BECB444AB6B9D4630C8EC8302D603A9@XMB-RCD-303.cisco.com>
 <1321311540.17169.122.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321311540.17169.122.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 14, 2011 at 03:59:00PM -0700, Alex Williamson wrote:
> On Fri, 2011-11-11 at 16:22 -0600, Christian Benvenuti (benve) wrote:
[snip]

> > - the user either unmaps one specific mapping or 'all of them'.
> >   The 'all of them' case would also take care of those cases where
> >   the user does _not_ keep track of mappings and simply uses
> >   the "unmap from 0 to ~0" each time.
> > 
> > Because of this you could still provide an exact map/unmap logic
> > and allow such "unmap from 0 to ~0" by making the latter a special
> > case.
> > However, if we want to allow any arbitrary/inexact unmap request, then OK.
> 
> I can't think of any good reasons we shouldn't be more strict.  I think
> it was primarily just convenient to hit all the corner cases since we
> merge all the requests together for tracking and need to be able to
> split them back apart.  It does feel a little awkward to have a 0/~0
> special case though, but I don't think it's worth adding another ioctl
> to handle it.

Being strict, or at least enforcing strictness, requires that the
infrastructure track all the maps, so that the unmaps can be
matching.  This is not a natural thing with the data structures you
want for all IOMMUs.  For example on POWER, the IOMMU (aka TCE table)
is a simple 1-level pagetable.  One pointer with a couple of
permission bits per IOMMU page.  Handling oddly overlapping operations
on that data structure is natural, enforcing strict matching of maps
and unmaps is not and would require extra information to be stored by
vfio.  On POWER, the IOMMU operations often *are* a hot path, so
manipulating those structures would have a real cost, too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

