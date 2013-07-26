Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:40099 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab3GZTsS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 15:48:18 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so217032obc.29
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2013 12:48:17 -0700 (PDT)
Date: Fri, 26 Jul 2013 13:48:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Don Dutile <ddutile@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, joro@8bytes.org,
	iommu@lists.linux-foundation.org, acooks@gmail.com,
	dwmw2@infradead.org
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
Message-ID: <20130726194813.GA20021@google.com>
References: <20130711204439.1701.90503.stgit@bling.home>
 <20130711210326.1701.56478.stgit@bling.home>
 <20130723223533.GB19765@google.com>
 <51F03C1B.2070002@redhat.com>
 <20130725171958.GB9272@google.com>
 <51F16D80.5040208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F16D80.5040208@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 25, 2013 at 02:25:04PM -0400, Don Dutile wrote:
> On 07/25/2013 01:19 PM, Bjorn Helgaas wrote:
> >On Wed, Jul 24, 2013 at 04:42:03PM -0400, Don Dutile wrote:
> >>On 07/23/2013 06:35 PM, Bjorn Helgaas wrote:
> >>>On Thu, Jul 11, 2013 at 03:03:27PM -0600, Alex Williamson wrote:
> >>>>+ * pcie_for_each_requester - Call callback @fn on each devices and DMA source
> >>>>+ *                           from @requestee to the PCIe requester ID visible
> >>>>+ *                           to @bridge.
> >>>
> >>>Transactions from a device may appear with one of several requester IDs,
> >>>but there's not necessarily an actual pci_dev for each ID, so I think the
> >>ditto above; have to have a pdev for each id....
> >
> >This *might* be true, but I don't think we should rely on it.  For
> >example:
> >
> >   00:1c.0 PCIe to PCI bridge to [bus 01]
> >   01:01.0 PCI endpoint
> >
> >The bridge will take ownership of DMA transactions from the 01:01.0
> >endpoint.  An IOMMU on bus 00 will see a bridge-assigned requester
> >ID of 01:00.0 (subordinate bus number, devfn zero), but there is no
> >01:00.0 device.
> >
> Clarification:
> I meant that each requester-id must have at least 1 PCI device associated
> with it.

I don't think that's true, as in the example above.  Requester ID
0x0100 has no pci_dev associated with it.  What am I missing?

Maybe you mean that requester ID 0x0100 is associated with pci_dev
01:01.0 in the sense that DMAs from 01:01.0 appear with that ID?
That's true, but I can't think of a reason why we would start with
ID 0x0100 and try to look up 01:01.0 from it.  And of course, if you
*did* try to look up the device, there could be several of them.

Bjorn
