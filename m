Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38002 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbcDLFhD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 01:37:03 -0400
Date: Tue, 12 Apr 2016 00:37:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: 'Casey Leedom' <leedom@chelsio.com>, linux-pci@vger.kernel.org,
	hariprasad@chelsio.com, hare@suse.com, bhelgaas@google.com
Subject: Re: 4.6-rc2 regression with commit 104daa71b396: check VPD access
 offset against length
Message-ID: <20160412053700.GF11361@localhost>
References: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
 <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
 <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 11, 2016 at 01:16:17PM -0500, Steve Wise wrote:
> > kernel.org commit 104daa71b396 added a check to make sure that efforts to
> > read/write the VPD wouldn't extend past the computed length of the VPD.
> > Later, kernel.org commit 408641e93aa5 folded the pci_vpd_pci22 into
> > struct pci_vpd so things moved around a bit after that and an error return
> > got changed into a silent failure instead of -EINVAL.
> > 
> >   The problem is that the previous pci_vpd_pci22_read() didn't check for a
> read with
> > a VPD Offset > VPD Length and the new pci_vpd_read() is checking that.  Worse
> > yet, when a VPD Offset is greater than the recorded VPD Length, it simply
> > returns 0 rather than -EINVAL.
> > 
> >   The problem is stemming from the fact that the Chelsio adapters actually
> have
> > two VPD structures stored in the VPD.  An abbreviated on at Offset 0x0 and the
> > complete VPD at Offset 0x400.  The abbreviated one only contains the PN, SN
> and
> > EC Keywords, while the complete VPD contains those plus various adapter
> > constants contained in V0, V1, etc.  And it also contains the Base Ethernet
> MAC
> > Address in the "NA" Keyword which the cxgb4 driver needs when it can't contact
> > the adapter firmware.  (We don't have the "NA" Keywork in the VPD Structure at
> > Offset 0x0 because that's not an allowed VPD Keyword in the PCI-E 3.0
> > specification.)
> > 
> >   With the new code, the computed size of the VPD is 0x200 and so our efforts
> > to read the VPD at Offset 0x400 silently fails.  We check the result of the
> > read looking for a signature 0x82 byte but we're checking against random stack
> > garbage.
> > 
> >   The end result is that the cxgb4 driver now fails the PCI-E Probe.
> > 
> 
> Silently failing is wrong, in my opinion.  And I even question truncating which
> is also done in pci_vpd_read().  To the PCI maintainers:  Should the length
> checks just be removed?    If not, what is the correct solution?  Adding a
> different "expert" API that ignores the length checks, or somehow allowing the
> device driver to set the actual VPD size? 

I think everybody would prefer if it the kernel could just read
whatever VPD region the user requested, without parsing the data or
checking for length (as long as we're within the 32K space allowed by
the spec).

The problem is that some cards crash if you read too much:

  commit 104daa71b396
  Author: Hannes Reinecke <hare@suse.de>
  Date:   Mon Feb 15 09:42:01 2016 +0100

    PCI: Determine actual VPD size on first access
    
    PCI-2.2 VPD entries have a maximum size of 32k, but might actually be
    smaller than that.  To figure out the actual size one has to read the VPD
    area until the 'end marker' is reached.
    
    Per spec, reading outside of the VPD space is "not allowed."  In practice,
    it may cause simple read errors or even crash the card.  To make matters
    worse not every PCI card implements this properly, leaving us with no 'end'
    marker or even completely invalid data.
    
    Try to determine the size of the VPD data when it's first accessed.  If no
    valid data can be read an I/O error will be returned when reading or
    writing the sysfs attribute.

So if you want to get rid of the length checks, you have to propose
some other mechanism to avoid these issues.

The only ideas I have are to (1) parse the data as we do in
104daa71b396, (2) add quirks to prevent VPD access (as in
7c20078a8197 ("PCI: Prevent VPD access for buggy devices"), and/or (3)
add quirks to allow access to more VPD than parsing says we can
access.  These aren't mutually exclusive -- we already have (1) and
(2), and I think we could easily add (3) into the mix.

(3) seems like a possible solution for Chelsio.  In that case, it's
the driver that needs the data, so the driver could maintain a quirk.

Bjorn
