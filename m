Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWhm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 18:37:42 -0400
Date: Tue, 4 Sep 2018 13:11:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@kernel.org>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: add support for Immediate Readiness
Message-ID: <20180904181126.GG107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
 <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org>
 <874lgcufsu.fsf@linux.intel.com>
 <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 03, 2018 at 01:25:58PM -0400, Sinan Kaya wrote:
> On 8/3/2018 2:26 AM, Felipe Balbi wrote:
> > Sinan Kaya <okaya@kernel.org> writes:
> > 
> > > On 8/2/2018 7:36 AM, Felipe Balbi wrote:
> > > > PCIe GEN4 defines a new bit on Status Register which tells us that, if
> > > > Set, a function is immediately ready after a Reset. This means that
> > > > all delays after a Conventional or Function Reset can be skipped.
> > > 
> > > Can you give a reference to the section of the specification? or
> > > a pointer to the ECN?
> > 
> > Section 7.5.1.1.4 of PCIe GEN4 spec. Table 7-4:
> > 
> > Immediate Readiness – This optional bit, when Set, indicates the
> > Function is guaranteed to be ready to successfully complete valid
> > configuration accesses at any time following any reset that the host is
> > capable of issuing Configuration Requests to this Function.
> > 
> > When this bit is Set, for accesses to this Function, software is exempt
> > from all requirements to delay configuration accesses following any type
> > of reset, including but not limited to the timing requirements defined
> > in Section 6.6.  How this guarantee is established is beyond the scope
> > of this document.
> > 
> > It is permitted that system software/firmware provide mechanisms that
> > supersede the indication provided by this bit, however such
> > software/firmware mechanisms are outside the scope of this
> > specification.
> > 
> 
> Thanks for the spec reference.

Yes.  Please include the reference in the changelog of v2.

> I think the patch is touching the wrong places. pci_dev_wait() is there
> to wait for CRS response to finish following reset.
> 
> Typical sequences are:
> 1. Do some kind of reset in another routine
> 2. Wait reset specific wait time (1sec for secondary bus reset as an
> example and 100ms for d3-d0 transition)
> 3. call pci_dev_wait() after reset to see if device can accept config
> transactions.
> 
> Since this applies to all resets, I think you also need to get rid of
> waits following different reset types in step #2 and return immediately.
> I suggest you review callers of pci_dev_wait() and tap in there.

I agree; I think we should be able to skip the delays in pcie_flr(),
pci_af_flr(), etc.

> Another thing is that this is a common functionality. Initializing
> the flag in pm_init() would not be the best place.

The immediate readiness thing is not directly related to PM, but
pci_pm_init() does deal with similar delays, and I don't have a better
suggestion off the top of my head.

Bjorn
